package org.jclarion.clarion.test;

import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.KeyedClarionEvent;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.AbstractListControl;
import org.jclarion.clarion.print.Page;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.swing.OpenMonitor;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.LocalClient;
import org.jclarion.clarion.swing.gui.RemoteWidget;

import junit.framework.TestCase;

public class ClarionTestCase extends TestCase
{
	public Playback model;
	public Thread app;

	public void setUp(final String mainClass)
	{
		setUp(mainClass,new String[0]);
	}
	
	public void setUp(final String mainClass,final String params[])
	{
		CFile.clearPath();
		model=new Playback();
		GUIModel.setClient(model);
	
		app=new Thread("Test App") {
			public void run()
			{
				try {
					CRun.setTestMode(true);
					Class<?> c = Class.forName(mainClass);
					Method m = c.getMethod("main",new Class[] { String[].class });
					m.invoke(null,new Object[] { params });
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				} catch (SecurityException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} finally {
					CRun.setTestMode(false);					
				}
			}
		};
		app.start();
	}
	
	public void setUp()
	{
		setUp("clarion.Main");
	}
	
	@SuppressWarnings("deprecation")
	public void tearDown()
	{
		model.shutdown();
		try {
			app.join(5000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		if (app.isAlive()) {			
			app.stop();
		}
		GUIModel.setClient(new LocalClient());
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	public ClarionTestCase()
	{
	}
	
	public Command assertCommand(String widget,String command,Object... params)
	{
		Command c = model.get(widget,command,5000,true);
		if (c==null) {
			System.out.println("==========\n");
			System.out.println(widget);
			System.out.println(command);
			model.logCommands();
			fail("Could not find command");
		}
		assertMetaData(params,c.params);
		return c;
	}

	public Command assertOpen(String target,String parent)
	{
		Command c=assertCommand("CWinImpl","OPEN",target,parent,"");
		return c;
	}

	public Command assertClose(String target,String parent)
	{
		Command c=assertCommand("CWinImpl","CLOSE",target,parent);
		return c;
	}

	public Command assertLazyOpen(String tgt)
	{
		Command c=assertCommand("CWinImpl","LAZY_OPEN",tgt);
		AbstractWindowTarget target = (AbstractWindowTarget)c.params[0];
		target.getOpenMonitor().setOpened();
		return c;
	}
	
	public Command assertSelect(String widget,Object... bits)
	{
		return assertCommand(widget,"SELECT",bits);
	}

	public Command assertChange(String widget,int key,Object value)
	{
		return assertCommand(widget,"NOTIFY_AWT_CHANGE",key,value);
	}

	public void assertText(String widget,Object o)
	{
		assertProperty(widget,Prop.TEXT,o);
	}

	public void assertUse(String widget,Object o)
	{
		assertProperty(widget,Prop.USE,o);
	}
	
	public void assertProperty(String widget,int key,Object o)
	{
		PropertyObject po = (PropertyObject)get(widget);
		if (o==null) { 
			assertFalse(po.isProperty(key));
		} else {
			ClarionObject x = po.getProperty(key);
			assertTrue(x+" = "+o,x.equals(o));
		}
	}
	
	private Map<String,Map<Integer,Object>> metaData=new HashMap<String,Map<Integer,Object>>();
	
	private Map<Integer,Object> getMetaData(String widget)
	{
		Map<Integer,Object> m = metaData.get(widget);
		if (m==null) {
			m=new HashMap<Integer,Object>();
			metaData.put(widget,m);
		}

		RemoteWidget w = get(widget);
		Map<Integer,Object> nm = w.getChangedMetaData();
		if (nm!=null) {
			m.putAll(nm);
		}
		return m;
	}
	
	public void assertQueue(String widget,Object[] data)
	{
		Map<Integer,Object> m = getMetaData(widget);
		Object[] queue = (Object[])m.get(AbstractListControl.MD_QUEUE);
		assertTrue(queue.length>0);
		int ofs = 1+((Integer)queue[0]);
		assertEquals(queue.length-ofs,data.length);
		for (int scan=0;scan<data.length;scan++) {
			assertMetaData(data[scan],queue[scan+ofs]);
		}
	}
	
	public void assertMetaData(String widget,String key,Object o)
	{
		Map<Integer,Object> m = getMetaData(widget);
		assertMetaData(o,m.get(model.getCommandList(get(widget)).getID(key)));
	}
	
	public void assertResult(Object test,ServerResponse s)
	{
		assertMetaData(test,s.getResult());
	}

	public static class RegExMatch
	{
		private String pattern;
		private String value;
		
		public RegExMatch(String pattern)
		{
			this.pattern=pattern;
		}
		
		public boolean matches(String value)
		{
			this.value=value;
			return value.matches(pattern);
		}
		
		public String getValue()
		{
			return value;
		}
	}
	
	public void assertMetaData(Object test,Object value)
	{
		if (test==null || value==null) {
			assertNull(test);
			assertNull(value);
			return;
		}

		if (test instanceof RegExMatch) {
			RegExMatch rem = (RegExMatch)test;
			assertTrue(value.toString(),rem.matches(value.toString()));
			return;
		}
		
		
		if (value instanceof OpenMonitor) return;
		
		if (value instanceof RemoteWidget && test instanceof String) {
			assertSame(get(test.toString()),value);
			return;
		}
		
		if (value instanceof Page) {
			PageToText ptt = new PageToText();
			ptt.extract((Page)value);
			Object[] t = (Object[])test;
			
			List<String[]> lines = ptt.getLines();
			assertEquals(t.length,lines.size());
			
			for (int scan=0;scan<lines.size();scan++) {
				assertMetaData(t[scan],lines.get(scan));
			}			
			return;
		}
		
		if (test.getClass().isArray()) {
			assertEquals(Array.getLength(test),Array.getLength(value));
			for (int scan=0;scan<Array.getLength(test);scan++) {
				assertMetaData(Array.get(test,scan),Array.get(value,scan));
			}
			return;
		}
		
		if (test instanceof ClarionObject) {
			assertTrue(test+"="+value,test.equals(value));
			return;
		}
		
		if (value instanceof ClarionObject) {
			assertTrue(value+"="+test,value.equals(test));
			return;			
		}
		
		assertEquals(test,value);
	}
	public void post(String window,int event)
	{
		AbstractWindowTarget awt = (AbstractWindowTarget)model.get(window);
		if (awt==null) fail("Window not found");
		GUIModel.getServer().send(awt,AbstractWindowTarget.POST,new ClarionEvent(event,null,event!=Event.CLOSEWINDOW));
	}

	public void post(String window,int event,Object additional[])
	{
		AbstractWindowTarget awt = (AbstractWindowTarget)model.get(window);
		if (awt==null) fail("Window not found");
		ClarionEvent ce = new ClarionEvent(event,null,event!=Event.CLOSEWINDOW);
		ce.setAdditionalData(additional);
		GUIModel.getServer().send(awt,AbstractWindowTarget.POST,ce);
	}
	
	public void setProperty(String control,int key,Object value)
	{
		PropertyObject o = (PropertyObject)model.get(control);
		if (o==null) fail("not found");
		o.setProperty(key,value);		
	}

	public void post(int event,String widget)
	{
		AbstractControl ac = (AbstractControl)model.get(widget);
		if (ac==null) fail("Widget not found");
		AbstractWindowTarget awt = ac.getWindowOwner();
		if (event==Event.SELECTED) {
			awt.setCurrentFocus(ac);
		}
		GUIModel.getServer().send(awt,AbstractWindowTarget.POST,new ClarionEvent(event,ac,true));
	}

	public void post(String window,int event,int chr,int code,int modifier)
	{
		AbstractWindowTarget awt = (AbstractWindowTarget)model.get(window);
		if (awt==null) fail("Window not found");
		GUIModel.getServer().send(awt,AbstractWindowTarget.POST,new KeyedClarionEvent(event,null,true,code,code,modifier));
	}

	public void post(String window,int event,String widget,int chr,int code,int modifier)
	{
		AbstractWindowTarget awt = (AbstractWindowTarget)model.get(window);
		if (awt==null) fail("Window not found");
		AbstractControl ac = (AbstractControl)model.get(widget);
		if (ac==null) fail("Widget not found");
		GUIModel.getServer().send(awt,AbstractWindowTarget.POST,new KeyedClarionEvent(event,ac,true,code,chr,modifier));
	}
	
	public void send(String widget,String command,Object... params)
	{
		RemoteWidget w = get(widget);
		if (w==null) fail("Widget not found");
		int cmd = model.getCommandList(w).getID(command);
		GUIModel.getServer().send(w,cmd,params);
	}

	public ServerResponse sendRecv(String widget,String command,Object... params)
	{
		RemoteWidget w = get(widget);
		if (w==null) fail("Widget not found");
		int cmd = model.getCommandList(w).getID(command);
		SimpleServerResponse sr = new SimpleServerResponse();
		GUIModel.getServer().send(w,sr,cmd,params);
		return sr;
	}
	
	public RemoteWidget get(String widget)
	{
		return model.get(widget);
	}
	
}
