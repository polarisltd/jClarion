package org.jclarion.clarion.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.gui.CommandList;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.NetworkError;
import org.jclarion.clarion.swing.gui.RemoteSemaphore;
import org.jclarion.clarion.swing.gui.RemoteWidget;
import org.jclarion.clarion.swing.gui.ResponseRunnable;

public class Playback extends GUIModel
{
	private Map<String,RemoteWidget> widgets=new HashMap<String,RemoteWidget>();
	
	private LinkedList<Command> commands=new LinkedList<Command>();
	
	private boolean shutdown;
    private TestProfile					profile;
	
	
	public Playback()
	{
		profile=new TestProfile("gui");
	}
	
	public void shutdown()
	{
		List<Command> shutdownList = new ArrayList<Command>();
		synchronized(commands) {
			shutdownList.addAll(commands);
			shutdown=true;
		}
		for (Command c : shutdownList ) {
			try {
				c.shutdown();
			} catch (NetworkError ne) { }
		}
		for (RemoteWidget w : widgets.values()) {
			if (w instanceof AbstractWindowTarget) {
				((AbstractWindowTarget)w).post(Event.CLOSEDOWN);
			}			
		}
	}
	
	@Override
	public void send(RemoteWidget w, int command, Object... params) 
	{
		Command c = new Command(w,null,command,params);
		noteRequest(c);
	}

	@Override
	public void send(RemoteWidget w, ResponseRunnable nextTask, int command,Object... params) 
	{
		Command c = new Command(w,nextTask,command,params);
		noteRequest(c);
	}

	@Override
	public void send(RemoteSemaphore rs, Object result) 
	{
		throw new IllegalStateException("Not allowed");
	}

	@Override
	public Object sendRecv(RemoteWidget w, int command, Object... params) 
	{
		Command c = new Command(w,null,command,params);
		noteRequest(c);
		Object o = c.getResponse();
		return o;
	}
	
	private Map<Class<? extends RemoteWidget>,CommandList> commandList=new HashMap<Class<? extends RemoteWidget>,CommandList>();
	
	public CommandList getCommandList(RemoteWidget w)
	{
		CommandList cl;
		synchronized(commandList) {
			cl = commandList.get(w.getClass());
			if (cl!=null) return cl;
		}
		cl=w.getCommandList();
		synchronized(commandList) {
			commandList.put(w.getClass(),cl);
		}
		return cl;
	}
	
	public Command get(String widget,String command,int wait,boolean remove)
	{
		long until = System.currentTimeMillis()+wait;
		synchronized(commands) {
			while ( true ) {
				if (!commands.isEmpty()) {
					RemoteWidget match  = get(widget);
					if (match!=null) {
						int cmd = getCommandList(match).getID(command);						
						Iterator<Command> i = commands.iterator();
						while (i.hasNext()) {
							Command test = i.next();
							if (test.w==match && test.command==cmd) {
								if (remove) i.remove();
								return test;
							}
						}
					}
				}
				long waitNow = until-System.currentTimeMillis();
				if (waitNow<=0) return null;
				try {
					commands.wait(waitNow);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void noteRequest(Command c) {
		
		if (!(c.w instanceof PropertyObject)) {
			registerSingleton(c.w);			
		}
		
		if (c.w instanceof AbstractControl) {
			AbstractControl po = (AbstractControl)c.w;
			if (po.getId()==null) {
				po.setId(".auto_"+po.getUseID());
				register(po);
			}
		}
		

		if (!profile.isLogWorthy(c.w,c.command,c.params)) {
			c.setResult(null);
			return;
		}
		
		if (c.w instanceof AbstractControl && c.command==AbstractControl.GET_AWT_PROPERTY) {
			int prop = (Integer)c.params[0];
			switch(prop) {
				case Prop.WIDTH:
				case Prop.HEIGHT:
					c.setResult(new ClarionNumber(10));
					return;
			}
		}
		
		if (c.w instanceof CWinImpl && c.command == CWinImpl.OPEN) {
			register((AbstractWindowTarget)c.params[0]);
		}
		synchronized(commands) {
			if (shutdown) {
				c.shutdown();
				System.err.println("Thread:"+Thread.currentThread());
				throw new NetworkError();
			}
			commands.add(c);
			commands.notifyAll();
		}
	}

	private void register(AbstractWindowTarget win) 
	{
		synchronized(widgets) {
			widgets.put(win.getId(),win);
		}
		for (AbstractControl ac : win.getControls() ) {
			register(ac);
		}
	}

	private void registerSingleton(RemoteWidget win) 
	{
		String name = win.getClass().getName();
		synchronized(widgets) {
			widgets.put(name.substring(name.lastIndexOf('.')+1),win);
		}
	}
	
	private void register(AbstractControl win) 
	{
		synchronized(widgets) {
			widgets.put(win.getId(),win);
		}
		for (AbstractControl ac : win.getChildren() ) {
			register(ac);
		}
	}

	public RemoteWidget get(String widget)
	{
		synchronized(widgets) {
			return widgets.get(widget);
		}
	}

	public String logCommand(Command c)
	{
		StringBuilder sb = new StringBuilder();
		sb.append(c.w);
		sb.append(" ");
		sb.append(getCommandList(c.w).getName(c.command));
		sb.append(" ");
		for (Object o : c.params ) {
			sb.append(",");
			if (o instanceof Integer) {
				int i = (Integer)o;
				String n = Prop.getPropStringOrNull(i);
				if (n==null) n=String.valueOf(i);
				sb.append(n);
			} else {
				sb.append(o);
			}
		}
		return sb.toString();
	}
	
	public void logCommands() 
	{
		for (Command c : commands ) {
			System.out.println(logCommand(c));
		}
	}

	@Override
	public boolean isLocal() {
		return true;
	}
}
