package org.jclarion.clarion.swing.gui;

import java.awt.Color;
import java.awt.Font;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.swing.OpenMonitor;
import org.jclarion.clarion.util.SharedOutputStream;

import junit.framework.TestCase;

public class RemoteNetworkTest extends TestCase {

	RemoteNetwork send=new RemoteNetwork();
	RemoteNetwork recv=new RemoteNetwork();
	GUIModel model=new LocalClient();
	
	public void setUp()
	{
		send=new RemoteNetwork();
		recv=new RemoteNetwork();
	}
	
	public void testNull()
	{
		assertNull(sendRecv(null));
	}

	public void testBoolean()
	{
		assertTrue((Boolean)sendRecv(true));
		assertFalse((Boolean)sendRecv(false));
	}
	
	public void testDouble()
	{
		double d = 4.325;
		assertEquals(d,(Double)sendRecv(d));
	}

	public void testFloat()
	{
		assertEquals(4.3245f,(Float)sendRecv(4.3245f));
	}
	
	public void testInputStream() throws IOException
	{
		for (int repeat=0;repeat<20;repeat++) {
			Random r = new Random();
			byte[] b = new byte[r.nextInt(100000)];
			r.nextBytes(b);
			InputStream is = (InputStream)sendRecv(new ByteArrayInputStream(b));
			for (byte t : b ) {
				int i = t&0xff;
				assertEquals(i,is.read());
			}
			assertEquals(-1,is.read());
		}
	}

	public void testByteArray()
	{
		for (int repeat=0;repeat<20;repeat++) {
			Random r = new Random();
			byte[] b = new byte[r.nextInt(100000)];
			r.nextBytes(b);
			byte[] is = (byte[])sendRecv(b);
			assertEquals(is.length,b.length);
			for ( int scan=0;scan<is.length;scan++) {
				assertEquals(b[scan],is[scan]);
			}
		}
	}
	
	public void testFont()
	{
		Font f = new Font("Serif",Font.BOLD,18);
		Font r = (Font)sendRecv(f);
		assertNotSame(f,r);
		assertEquals(f,r);
		assertSame(r,sendRecv(f));
		assertSame(r,sendRecv(new Font("Serif",Font.BOLD,18)));

		Font f2 = new Font("Mono",0,6);
		Font r2 = (Font)sendRecv(f2);
		assertNotSame(f2,r2);
		assertEquals(f2,r2);

		assertSame(r,sendRecv(f));
		assertSame(r,sendRecv(new Font("Serif",Font.BOLD,18)));
		assertSame(r2,sendRecv(f2));
		assertSame(r2,sendRecv(new Font("Mono",0,6)));
	
	}
	
	public void testColor()
	{
		Random r = new Random();
		for (int loop=0;loop<1000000;loop++) {
			Color c = new Color(r.nextInt(),true);
			Color s = (Color)sendRecv(c);
			assertEquals(s,c);
			assertEquals(s.getAlpha(),c.getAlpha());
			assertEquals(s.getRed(),c.getRed());
			assertEquals(s.getBlue(),c.getBlue());
			assertEquals(s.getGreen(),c.getGreen());
		}
		
	}
	
	public void testInts()
	{
		int test[]=new int[] { 0,1,2,3,-5,126,127,128,255,256,65534,65535,65536,65537,1000000,1000000000,2000000000, Integer.MAX_VALUE, Integer.MIN_VALUE,Integer.MAX_VALUE-1,Integer.MIN_VALUE+1 };
		for (int i : test) {
			assertEquals(i,sendRecv(i));
		}
	}

	public void testPackedInts() throws IOException
	{
		int test[]=new int[] { 0,1,2,3,-5,126,127,128,255,256,65534,65535,65536,65537,1000000,1000000000,2000000000, Integer.MAX_VALUE, Integer.MIN_VALUE,Integer.MAX_VALUE-1,Integer.MIN_VALUE+1 };
		for (int i : test) {
			SharedOutputStream sos = new SharedOutputStream();
			RemoteNetwork rn = new RemoteNetwork();
			rn.writeNumber(sos,i);
			InputStream is = sos.getInputStream();
			assertEquals(i,rn.readNumber(is));
			assertEquals(-1,is.read());
		}
	}
	
	public void testRandomPackedInts() throws IOException
	{
		Random r = new Random();
		for (int loop=0;loop<1000000;loop++) {
			int i = r.nextInt();
			SharedOutputStream sos = new SharedOutputStream();
			RemoteNetwork rn = new RemoteNetwork();
			rn.writeNumber(sos,i);
			InputStream is = sos.getInputStream();
			assertEquals(i,rn.readNumber(is));
			assertEquals(-1,is.read());
		}
		
	}

	public void testLong() throws IOException
	{
		Random r = new Random();
		for (int loop=0;loop<10000;loop++) {
			long l = r.nextLong();
			long re = (Long)sendRecv(l);
			assertEquals(re,l);
		}
		
	}
	
	public void testArray()
	{
		Object array[] = new Object[] { 1, 5, "hello" , "world" };
		Object result[] = (Object[])sendRecv(array);
		assertEquals(result.length,array.length);
		for (int scan=0;scan<result.length;scan++) {
			assertEquals(array[scan],result[scan]);
		}
	}
	
	@SuppressWarnings("unchecked")
	public void testMap()
	{
		Map<Object,Object> m = new HashMap<Object,Object>();
		m.put(1,"One");
		m.put(2,"Two");
		m.put("Three",3);
		m.put("Four",4);
		Map<Object,Object> r = (Map<Object,Object>)sendRecv(m);
		assertEquals(4,r.size());
		assertEquals(4,m.size());
		assertEquals(m,r);
		r.put(5,5);
		assertFalse(m.equals(r));
	}

	public void testPrimativeArray()
	{
		int array[] = new int[] { 4,5,6,7};
		Object result[] = (Object[])sendRecv(array);
		assertEquals(result.length,array.length);
		for (int scan=0;scan<result.length;scan++) {
			assertEquals(array[scan],result[scan]);
		}
	}

	public void testCollection()
	{
		List<Object> l = new ArrayList<Object>();
		l.add(1);
		l.add(5);
		l.add("Hello");
		l.add("World");
		Object result[] = (Object[])sendRecv(l);
		assertEquals(result.length,l.size());
		for (int scan=0;scan<result.length;scan++) {
			assertEquals(l.get(scan),result[scan]);
		}
	}
	
	public void testDecimal()
	{
		ClarionDecimal cd=new ClarionDecimal(10,2);
		ClarionDecimal r;
		
		cd.setValue("-5");
		r=(ClarionDecimal)sendRecv(cd);
		assertEquals("-5.00",r.toString());

		cd.setValue("45731.6");
		r=(ClarionDecimal)sendRecv(cd);
		assertEquals("45731.60",r.toString());
	}
	
	public void testSimpleACWidget()
	{
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));
		
		StringControl w = (StringControl)sendRecv(sc);
		StringControl ow = w;
		assertNotNull(w);
		assertNotSame(sc,w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		w = (StringControl)sendRecv(sc);
		assertSame(w,ow);
		assertNotNull(w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		sc.setProperty(Prop.XPOS,15);

		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		w = (StringControl)sendRecv(sc);
		assertSame(w,ow);
		assertNotNull(w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(15,w.getProperty(Prop.XPOS).intValue());
	}

	public void testSimpleWindowWidget()
	{
		ClarionWindow cw = new ClarionWindow();
		cw.setText("Hello World");
		cw.setAt(10,20,30,40);
		
		ClarionWindow w = (ClarionWindow)sendRecv(cw);
		ClarionWindow ow = w;
		assertNotNull(w);
		assertNotSame(cw,w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		w = (ClarionWindow)sendRecv(cw);
		assertSame(w,ow);
		assertNotNull(w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		cw.setProperty(Prop.XPOS,15);

		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		w = (ClarionWindow)sendRecv(cw);
		assertSame(w,ow);
		assertNotNull(w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(15,w.getProperty(Prop.XPOS).intValue());
	}
	
	public void testSimpleCommand() throws IOException
	{
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		SharedOutputStream sos = new SharedOutputStream();
		send.writeCommand(sos,5,false,null,sc,11,13,17,19);

		InputStream is = sos.getInputStream();
		RemoteCommand rc = recv.readCommand(is,null);
		
		assertNotNull(rc);
		assertEquals(5,rc.command);
		assertEquals(0,rc.response);
		assertEquals("Hello World",((StringControl)rc.source).getProperty(Prop.TEXT).toString());
		assertEquals(4,rc.params.length);
		assertEquals(11,rc.params[0]);
		assertEquals(13,rc.params[1]);
		assertEquals(17,rc.params[2]);
		assertEquals(19,rc.params[3]);
		
		assertNull(recv.readCommand(is,null));
	}

	public void testSimpleTwoWayCommand() throws IOException
	{
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		SharedOutputStream sos = new SharedOutputStream();
		send.writeCommand(sos,5,false,null,sc,11,13,17,19);

		InputStream is = sos.getInputStream();
		RemoteCommand rc = recv.readCommand(is,null);
		
		assertNotNull(rc);
		assertEquals(5,rc.command);
		assertEquals(0,rc.response);
		assertEquals("Hello World",((StringControl)rc.source).getProperty(Prop.TEXT).toString());
		assertEquals(4,rc.params.length);
		assertEquals(11,rc.params[0]);
		assertEquals(13,rc.params[1]);
		assertEquals(17,rc.params[2]);
		assertEquals(19,rc.params[3]);
		
		assertNull(recv.readCommand(is,null));

		sos.reset();
		recv.writeCommand(sos,10,false,null,rc.source,"Some Crap");
		is = sos.getInputStream();
		RemoteCommand rc2 = send.readCommand(is,null);
		
		assertNotNull(rc2);
		assertEquals(0,rc2.response);
		assertSame(sc,rc2.source);
		assertEquals(10,rc2.command);
		assertEquals(1,rc2.params.length);
		assertEquals("Some Crap",rc2.params[0]);

		((StringControl)rc.source).setProperty(Prop.XPOS,20);
		assertEquals(10,sc.getProperty(Prop.XPOS).intValue());
		
		sos.reset();
		recv.writeCommand(sos,10,false,null,rc.source,"Some Crap");
		is = sos.getInputStream();
		rc2 = send.readCommand(is,null);
		assertEquals(0,rc2.response);
		assertSame(sc,rc2.source);
		assertEquals(10,rc2.command);
		assertEquals(1,rc2.params.length);
		assertEquals("Some Crap",rc2.params[0]);

		assertEquals(20,sc.getProperty(Prop.XPOS).intValue());
		
		// now - test unnecessary propagation by exercising a known race.
		//   remote changes it's value
		//   sc retransmits
		
		((StringControl)rc.source).setProperty(Prop.XPOS,30);
		sc.setProperty(Prop.YPOS,31);
		
		sos.reset();
		send.writeCommand(sos,5,false,null,sc,11,13,17,19);
		is = sos.getInputStream();
		recv.readCommand(is,null);
		
		
		assertEquals(30,((StringControl)rc.source).getProperty(Prop.XPOS).intValue());
		assertEquals(31,((StringControl)rc.source).getProperty(Prop.YPOS).intValue());
		assertEquals(20,sc.getProperty(Prop.XPOS).intValue());
		assertEquals(31,sc.getProperty(Prop.YPOS).intValue());
	}

	public void testOpenMonitorSemaphore() throws IOException, InterruptedException
	{
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		final OpenMonitor om = new OpenMonitor();
		
		SharedOutputStream sos = new SharedOutputStream();
		send.writeCommand(sos,5,false,null,sc,om);
		
		Thread wait = new Thread() {
			public void run() {
				om.waitForOpen();
			}
		};
		wait.start();
		
		NetworkModel model = new NetworkModel(recv,sos);
		
		InputStream is = sos.getInputStream();
		RemoteCommand rc = recv.readCommand(is,model);
		assertNotNull(rc);
		assertEquals(1,rc.params.length);
		assertNotNull(rc.params[0]);
		assertNotSame(om,rc.params[0]);
		
		wait.join(500);
		assertTrue(wait.isAlive());
		
		sos.reset();
		((OpenMonitor)rc.params[0]).setOpened();
		
		wait.join(500);
		assertTrue(wait.isAlive());

		is = sos.getInputStream();
		assertNull(send.readCommand(is,null));

		wait.join(500);
		assertFalse(wait.isAlive());		
	}

	public void testClarionEventSemaphore() throws IOException, InterruptedException
	{
		ClarionWindow cw = new ClarionWindow();
		
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		cw.add(sc);

		final ClarionEvent ce = new ClarionEvent(6,sc,true);
		ce.setNetworkSemaphore(true);
		final Boolean result[]=new Boolean[1];
		
		SharedOutputStream sos = new SharedOutputStream();
		send.writeCommand(sos,5,false,null,cw,ce);
		
		Thread wait = new Thread() {
			public void run() {
				result[0]=ce.getConsumeResult();
			}
		};
		wait.start();
		
		NetworkModel model = new NetworkModel(recv,sos);
		
		InputStream is = sos.getInputStream();
		RemoteCommand rc = recv.readCommand(is,model);
		assertNotNull(rc);
		assertEquals(1,rc.params.length);
		assertNotNull(rc.params[0]);
		assertNotSame(ce,rc.params[0]);
		
		wait.join(500);
		assertTrue(wait.isAlive());
		
		sos.reset();
		ClarionEvent rem = ((ClarionEvent)rc.params[0]);
		rem.consume(true);
		
		wait.join(500);
		assertTrue(wait.isAlive());

		is = sos.getInputStream();
		assertNull(send.readCommand(is,null));

		wait.join(500);
		assertFalse(wait.isAlive());
		
		assertTrue(result[0]);
	}

	public void testClarionEventSemaphore2() throws IOException, InterruptedException
	{
		ClarionWindow cw = new ClarionWindow();
		
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		cw.add(sc);

		final ClarionEvent ce = new ClarionEvent(6,sc,true);
		ce.setNetworkSemaphore(true);
		final Boolean result[]=new Boolean[1];
		
		SharedOutputStream sos = new SharedOutputStream();
		send.writeCommand(sos,5,false,null,cw,ce);
		
		Thread wait = new Thread() {
			public void run() {
				result[0]=ce.getConsumeResult();
			}
		};
		wait.start();
		
		NetworkModel model = new NetworkModel(recv,sos);
		
		InputStream is = sos.getInputStream();
		RemoteCommand rc = recv.readCommand(is,model);
		assertNotNull(rc);
		assertEquals(1,rc.params.length);
		assertNotNull(rc.params[0]);
		assertNotSame(ce,rc.params[0]);
		
		wait.join(500);
		assertTrue(wait.isAlive());
		
		sos.reset();
		ClarionEvent rem = ((ClarionEvent)rc.params[0]);
		rem.consume(false);
		
		wait.join(500);
		assertTrue(wait.isAlive());

		is = sos.getInputStream();
		assertNull(send.readCommand(is,null));

		wait.join(500);
		assertFalse(wait.isAlive());
		
		assertFalse(result[0]);
	}
	

	public void testClarionEventSemaphoreNoNetwork() throws IOException, InterruptedException
	{
		ClarionWindow cw = new ClarionWindow();
		
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		cw.add(sc);

		final ClarionEvent ce = new ClarionEvent(6,sc,true);
		final Boolean result[]=new Boolean[1];
		
		SharedOutputStream sos = new SharedOutputStream();
		send.writeCommand(sos,5,false,null,cw,ce);
		
		Thread wait = new Thread() {
			public void run() {
				result[0]=ce.getConsumeResult();
			}
		};
		wait.start();
		
		NetworkModel model = new NetworkModel(recv,sos);
		
		InputStream is = sos.getInputStream();
		RemoteCommand rc = recv.readCommand(is,model);
		assertNotNull(rc);
		assertEquals(1,rc.params.length);
		assertNotNull(rc.params[0]);
		assertNotSame(ce,rc.params[0]);
		
		wait.join(500);
		assertTrue(wait.isAlive());
		
		sos.reset();
		ClarionEvent rem = ((ClarionEvent)rc.params[0]);
		rem.consume(false);
		
		wait.join(500);
		assertTrue(wait.isAlive());

		is = sos.getInputStream();
		assertNull(send.readCommand(is,null));

		wait.join(500);
		assertTrue(wait.isAlive());
		
		ce.consume(true);
		
		wait.join(500);
		assertFalse(wait.isAlive());
	}
	
	public void testResponseCommand() throws IOException
	{
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		SharedOutputStream sos = new SharedOutputStream();
		RemoteResponse rr = send.writeCommand(sos,5,true,null,sc,11,13,17,19);

		InputStream is = sos.getInputStream();
		RemoteCommand rc = recv.readCommand(is,null);
		
		
		assertFalse(rr.isResponseReady(0));
		
		
		sos.reset();
		recv.writeResponse(sos,rc,"Here is your response");
		is = sos.getInputStream();
		assertNull(send.readCommand(is,null));
		
		assertTrue(rr.isResponseReady(0));
		assertEquals("Here is your response",rr.waitForResponse());
	}

	public void testResponseCommandWithRunnable() throws IOException
	{
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		final int[] o=new int[] { 5 };
		
		SharedOutputStream sos = new SharedOutputStream();
		RemoteResponse rr = send.writeCommand(sos,5,true,new ResponseRunnable() {
			@Override
			public void run(Object result) {
				o[0]=o[0]+(Integer)result;
			}
			
		},sc,11,13,17,19);

		InputStream is = sos.getInputStream();
		RemoteCommand rc = recv.readCommand(is,null);
		
		assertEquals(5,o[0]);
		assertFalse(rr.isResponseReady(0));
		
		sos.reset();
		recv.writeResponse(sos,rc,15);
		is = sos.getInputStream();
		assertNull(send.readCommand(is,null));
		
		assertTrue(rr.isResponseReady(0));
		assertEquals(15,rr.waitForResponse());
		assertEquals(20,o[0]);
	}
	
	
	public void testNestedACWidget()
	{
		
		StringControl sc =new StringControl();
		sc.setText("Hello World");
		sc.setAt(10,20,30,40);
		sc.use(new ClarionNumber(5));

		GroupControl gc = new GroupControl();
		gc.setAt(5,5,100,50);
		gc.add(sc);

		GroupControl gw = (GroupControl)sendRecv(gc);
		assertNotSame(gw,gc);
		
		StringControl w = (StringControl)gw.getChild(0);
		StringControl ow = w;
		assertNotNull(w);
		assertNotSame(sc,w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		w = (StringControl)sendRecv(sc);
		assertSame(w,ow);
		assertNotNull(w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		sc.setProperty(Prop.XPOS,15);

		assertEquals(10,w.getProperty(Prop.XPOS).intValue());
		
		w = (StringControl)sendRecv(sc);
		assertSame(w,ow);
		assertNotNull(w);
		assertEquals("Hello World",w.getProperty(Prop.TEXT).toString());
		assertEquals(15,w.getProperty(Prop.XPOS).intValue());
		
	}
	
	
	public void testClarionNumber()
	{
		int test[]=new int[] { 0,1,2,3,-5,126,127,128,255,256,65534,65535,65536,65537,1000000,1000000000,2000000000 };
		for (int i : test) {
			ClarionNumber cn = new ClarionNumber(i);
			ClarionNumber v = (ClarionNumber)sendRecv(cn);
			assertEquals(cn,v);
			assertEquals(cn.intValue(),v.intValue());
		}
	}
	
	public void testStrings()
	{
		String test[]=new String[] {
				"",
				"hello",
				"hello there world ",
				"Gentlemen, you are welcome to Elsinore. Your hands,\ncome then: the appurtenance of welcome is fashion\nand ceremony: let me comply with you in this garb,\nlest my extent to the players, which, I tell you,\nmust show fairly outward, should more appear like\nentertainment than yours. You are welcome: but my\nuncle-father and aunt-mother are deceived.",
				"\u2120\u2122\u2123Gentlemen, you are welcome to Elsinore. Your hands,\ncome then: the appurtenance of welcome is fashion\nand ceremony: let me comply with you in this garb,\nlest my extent to the players, which, I tell you,\nmust show fairly outward, should more appear like\nentertainment than yours. You are welcome: but my\nuncle-father and aunt-mother are deceived.\u2120\u2122\u2123",
				"\r\t\n\u0000",
				"\u2120\u2122\u2123",
				"last" };
		for (String i : test) {
			Object result = sendRecv(i); 
			assertEquals(i,result);
			assertNotSame(i,result);
		}		
	}

	public void testClarionStrings()
	{
		String test[]=new String[] {
				"",
				"hello",
				"hello there world ",
				"Gentlemen, you are welcome to Elsinore. Your hands,\ncome then: the appurtenance of welcome is fashion\nand ceremony: let me comply with you in this garb,\nlest my extent to the players, which, I tell you,\nmust show fairly outward, should more appear like\nentertainment than yours. You are welcome: but my\nuncle-father and aunt-mother are deceived.",
				"\u2120\u2122\u2123Gentlemen, you are welcome to Elsinore. Your hands,\ncome then: the appurtenance of welcome is fashion\nand ceremony: let me comply with you in this garb,\nlest my extent to the players, which, I tell you,\nmust show fairly outward, should more appear like\nentertainment than yours. You are welcome: but my\nuncle-father and aunt-mother are deceived.\u2120\u2122\u2123",
				"\r\t\n\u0000",
				"\u2120\u2122\u2123",
				"last" };
		for (String i : test) {
			ClarionString cs = new ClarionString(i);
			ClarionString result = (ClarionString)sendRecv(cs); 
			assertEquals(cs,result);
			assertNotSame(cs,result);
			assertEquals(cs.toString(),result.toString());
		}		
	}

	public void testClarionPaddedStrings()
	{
		String test[]=new String[] {
				"",
				"hello",
				"hello there world ",
				"Gentlemen, you are welcome to Elsinore. Your hands,\ncome then: the appurtenance of welcome is fashion\nand ceremony: let me comply with you in this garb,\nlest my extent to the players, which, I tell you,\nmust show fairly outward, should more appear like\nentertainment than yours. You are welcome: but my\nuncle-father and aunt-mother are deceived.",
				"\u2120\u2122\u2123Gentlemen, you are welcome to Elsinore. Your hands,\ncome then: the appurtenance of welcome is fashion\nand ceremony: let me comply with you in this garb,\nlest my extent to the players, which, I tell you,\nmust show fairly outward, should more appear like\nentertainment than yours. You are welcome: but my\nuncle-father and aunt-mother are deceived.\u2120\u2122\u2123",
				"\r\t\n\u0000",
				"\u2120\u2122\u2123",
				"last" };
		for (String i : test) {
			ClarionString cs = new ClarionString(800);
			cs.setValue(i);
			ClarionString result = (ClarionString)sendRecv(cs); 
			assertEquals(cs,result);
			assertNotSame(cs,result);
			assertEquals(cs.toString(),result.toString());
		}		
	}
	
	public Object sendRecv(Object o)
	{
		try {
			SharedOutputStream sos = new SharedOutputStream();
			send.writeParameter(sos,o);
			InputStream is = sos.getInputStream();
			Object r= recv.readParameter(is,model);
			assertEquals(-1,is.read());
			return r;
		} catch (IOException ex) {
			ex.printStackTrace();
			fail();
		}
		return null;
	}
	
}
