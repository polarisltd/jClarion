package org.jclarion.clarion.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.swing.SwingUtilities;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.KeyedClarionEvent;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.AbstractListControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.print.Page;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.gui.CommandList;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.RemoteSemaphore;
import org.jclarion.clarion.swing.gui.RemoteWidget;
import org.jclarion.clarion.swing.gui.ResponseRunnable;


public class Record extends GUIModel 
{
	private static Map<Thread,String>		networkSide=new HashMap<Thread,String>();
	
	private static Set<String> newImports=new HashSet<String>();

	private static String getSide()
	{
		String side = networkSide.get(Thread.currentThread());
		if (side!=null) return side;
		return SwingUtilities.isEventDispatchThread() ? "gui" : "svr";		
	}
	
	private GUIModel 				base;
	private String 					name;
	private TeeStream 				log;
	private SimpleExecutor			remoteReader;
	private SimpleExecutor			localReader;
	private TestProfile				profile;
	
	public static void main(String args[])
	{
		String className="clarion.AutoTest";
		String testName="testDefault";
		String mainClass="clarion.Main";
		
		List<String> n_args=new ArrayList<String>();
		
		
		int scan=0;
		while (scan<args.length) {
			if (args[scan].equals("--name")) {
				scan++;
				testName=args[scan];
				scan++;
				continue;
			}
			if (args[scan].equals("--class")) {
				scan++;
				className=args[scan];
				scan++;
				continue;
			}
			if (args[scan].equals("--main")) {
				scan++;
				mainClass=args[scan];
				scan++;
				continue;
			}
			
			n_args.add(args[scan]);
			scan++;
		}
		
		SimpleExecutor guiReader = new SimpleExecutor("gui");
		SimpleExecutor svrReader = new SimpleExecutor("svr");
		networkSide.put(guiReader,"gui");
		networkSide.put(svrReader,"svr");
		guiReader.start();
		svrReader.start();

		try {
			File temp=new File(".Test.java.tmp");
			TeeStream ps = new TeeStream(new FileWriter(temp));
			ps.pushMethod(testName);
			GUIModel.setClient(new Record(GUIModel.getClient(),"gui",ps,svrReader,guiReader));
			GUIModel.setServer(new Record(GUIModel.getServer(),"svr",ps,guiReader,svrReader));
		
			CRun.setTestMode(true);
			
			Class<?> c = Class.forName(mainClass);
			Method m = c.getMethod("main",new Class[] { String[].class });
			String n_args_a[]=new String[n_args.size()];
			n_args.toArray(n_args_a);
			m.invoke(null,new Object[] { n_args_a });

			ps.close();
			
			String fname= "src/test/java/"+(className.replace('.','/'))+".java";
			if ((new File("../src")).exists()) {
				fname = "../"+fname;
			}
			fname=fname.replace('/',File.separatorChar);
			
			File target = new File(fname);
			File src = null;
			BufferedReader r = null;
			if (target.exists()) {
				src = new File(fname+".tmp");
				src.delete();
				target.renameTo(src);
				r= new BufferedReader(new FileReader(src));
			}
			FileOutputStream fos = new FileOutputStream(target);
			PrintStream p = new PrintStream(fos);
			
			Set<String> imports=new HashSet<String>();
			
			if (r!=null) {
				while ( true ) {
					String s = r.readLine();
					if (s.startsWith("public ")) {
						break;
					}
					imports.add(s);
					p.println(s);
				}
			} else {
				p.print("package ");
				p.print(className.subSequence(0,className.lastIndexOf('.')));
				p.println(";");								
			}
			
			newImports.add("import org.jclarion.clarion.constants.*;");			
			newImports.add("import org.jclarion.clarion.test.*;");
			
			for (String s : newImports ) {
				if (imports.contains(s)) continue;
				p.println(s);
			}
			
			p.print("public class ");
			p.print(className.subSequence(className.lastIndexOf('.')+1,className.length()));
			p.println(" extends ClarionTestCase");
			p.println("{");
			
			if (r!=null) {
				
				Pattern pattern = Pattern.compile(
						"(^    public void (_)?"+testName+")"+
						"|(^    private(.*)_"+testName+")"); 
				
				while(true) {
					String s = r.readLine();
					if (s==null) break;
					if (s.startsWith("{")) continue;
					if (s.startsWith("}")) break;
					
					Matcher match = pattern.matcher(s);
					if (match.find()) {
						while (true ) {
							s = r.readLine();
							if (s==null) break;
							if (s.equals("    }")) break;
						}
					} else {
						p.println(s);
					}
				}
			}
			p.flush();
			ps.popMethod();
			ps.rewrite(p);
			p.println("}");
			p.close();
			temp.delete();
			if (src!=null) src.delete();
		} catch (IOException ex) { 
			ex.printStackTrace();			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} finally {
			CRun.setTestMode(false);			
		}
	}

	public Record(GUIModel base,String name,TeeStream log,SimpleExecutor remote,SimpleExecutor local)
	{
		this.remoteReader=remote;
		this.localReader=local;
		this.base=base;
		this.name=name;
		this.log=log;
		this.profile=new TestProfile(name);
	}

	private Map<Class<?>,String> className=new HashMap<Class<?>,String>();

	private void stampObject(StringBuilder entry,Object o)
	{
		if (o==null) {
			entry.append("null");
			return;
		}
		if (o instanceof RemoteWidget) {
			stampClass(entry,o);
			if (o instanceof PropertyObject) {
				entry.append('[');
				entry.append(((PropertyObject)o).getId());
				entry.append(']');
			}
			return;
		}
		if (o instanceof Integer) {
			int i = (Integer)o;
			String s = Prop.getPropStringOrNull(i);
			if (s!=null) {
				entry.append(s);
				return;
			}
		}
		if (o.getClass().isArray()) {
			entry.append('[');
			for (int scan=0;scan<Array.getLength(o);scan++) {
				if (scan>0) entry.append(',');
				stampObject(entry,Array.get(o,scan));
			}
			entry.append(']');
			return;
		}
		entry.append(o);
	}
	
	private void stampClass(StringBuilder entry,Object o)
	{
		if (o==null) {
			entry.append('?');
		}
		Class<?> c = o.getClass();
		String name=null;
		synchronized(className) {
			name=className.get(c);
		}
		if (name!=null) {
			entry.append(name);
			return;
		}

		String cname = c.getName();
		int lpos = cname.lastIndexOf('.');
		name = cname.substring(lpos+1);
		synchronized(className) {
			className.put(c,name);
		}
		entry.append(name);
	}
	
	private Map<Class<? extends RemoteWidget>,CommandList> commands=new HashMap<Class<? extends RemoteWidget>,CommandList>();

	private CommandList getCommandList(RemoteWidget w)
	{
		CommandList cl;
		synchronized(commands) {
			cl=commands.get(w.getClass());
		}
		if (cl==null && w!=null) {
			cl=w.getCommandList();
			synchronized(commands) {
				commands.put(w.getClass(),cl);
			}
		}
		return cl;
	}

	private String getSpecializedCommand(RemoteWidget w,int command)
	{
		if (w instanceof CWinImpl) {
			if (command==CWinImpl.OPEN) return "assertOpen(%1,%2);"; 
			if (command==CWinImpl.LAZY_OPEN) return "assertLazyOpen(%1);"; 
			if (command==CWinImpl.CLOSE) return "assertClose(%1,%2);"; 
		}
		if (w instanceof AbstractControl) {
			if (command==AbstractControl.NOTIFY_AWT_CHANGE) return "assertChange(%w,%1,%2);"; 			
			if (command==AbstractControl.SELECT) return "assertSelect(%w%@);"; 			
		}
		return null;
	}
	
	private static LinkedList<Map<Integer,Boolean>> guiRespond=new LinkedList<Map<Integer,Boolean>>();
	static {
		guiRespond.add(new HashMap<Integer,Boolean>());
	};
	
	private void rewrite(String pattern,StringBuilder sb,RemoteWidget w,int command,Object... params)
	{
		int scan=0;
		while (scan<pattern.length()) {
			char c = pattern.charAt(scan++);
			if (c=='%') {
				c = pattern.charAt(scan++);
				if (c>='1' && c<='9') {
					logJavaObject(sb,params[c-'1']);
					continue;
				}
				if (c=='@') {
					for (Object o : params ) {
						sb.append(",");
						logJavaObject(sb,o);
					}
					continue;
				}
				if (c=='w') {
					logJavaObject(sb,w);
					continue;
				}
				if (c=='c') {
					sb.append('"');
					sb.append(getCommandList(w).getName(command));
					sb.append('"');
					continue;
				}
			}
			sb.append(c);
		}
	}

	private int getRespondID()
	{
		int count=0;
		int depth=guiRespond.size();
		Map<Integer,Boolean> r = guiRespond.getLast(); 
		while (true) {
			count++;
			Boolean b = r.get(count);
			if (b==null) {
				log.println("        ServerResponse s"+depth+"_"+count+";");
				b=false;
				r.put(count,b);
			}
			if (!b) {
				r.put(count,true);
				break;
			}
		}
		return count;
	}
	
	private int guiLog(RemoteWidget w,boolean willRespond,int command,Object... params)
	{
		int count=0;
		if (willRespond) {
			count=getRespondID();
		}
		
		StringBuilder sb = new StringBuilder();
		String special=getSpecializedCommand(w,command);
		if (count>0) {
			sb.append("        s").append(guiRespond.size()).append('_').append(count).append("=");
		} else {
			sb.append("        ");
		}
		int eat=-1;
		if (special!=null) {
			rewrite(special,sb,w,command,params);
		} else {
			sb.append("assertCommand(");
			logJavaObject(sb,w);
			sb.append(",\"");
			CommandList cl = getCommandList(w);
			sb.append(cl.getName(command));
			sb.append("\"");
			for (Object o : params ) {
				sb.append(",");
				logJavaObject(sb,o);
			}
			sb.append(");");
		}
		if (w instanceof AbstractControl && command==AbstractControl.NOTIFY_AWT_CHANGE) {
			eat=(Integer)params[0];
		}
		doLog(sb);
		if (assertMetaData(w,eat)) {
			log.println();
		}
		for (Object o : params ) {
			if (o!=null && o instanceof RemoteWidget) {
				assertMetaData((RemoteWidget)o);
			}
		}
		return count;
	}

	private boolean assertMetaData(RemoteWidget w)
	{
		return assertMetaData(w,-1);
	}
	
	private boolean assertMetaData(RemoteWidget w,int eat)
	{
		Map<Integer,Object> data = w.getChangedMetaData();
		StringBuilder sb = new StringBuilder();
		boolean any=false;
		if (data!=null && eat>0) data.remove(eat);
		if (data != null && !data.isEmpty() && isMetaDataInteresting(w)) {
			for (Map.Entry<Integer, Object> item : data.entrySet()) {
				if (!isMetaDataInteresting(w,item.getKey(),item.getValue())) continue;
				any=true;
				
				sb.setLength(0);

				if (w instanceof AbstractListControl && item.getKey()==AbstractListControl.MD_QUEUE) {
					Object o[] = (Object[])item.getValue();
					int colSize=(Integer)o[0];
					int rowCount = (o.length-1-colSize)/colSize;

					sb.append("        assertQueue(");
					logJavaObject(sb,w);
					
					StringBuilder value = new StringBuilder();
					value.append("new Object[] {");
					if (rowCount==0) {
						value.append("}");
					}
					for (int scan=1;scan<=rowCount;scan++) {
						value.append("\n        ");
						for (int col=1;col<=colSize;col++) {
							logJavaObject(value,o[scan*colSize+col]);
							if (col<colSize || scan<rowCount) {
								value.append(",");
							} else {
								value.append("}");
							}
						}
					}
					sb.append(",");
					sb.append(log.setField( ((PropertyObject)w).getId(),"Object[]",value.toString()));
					sb.append(");");
					
					doLog(sb);					
					
					continue;
				}
				
				String name = Prop.getPropStringOrNull(item.getKey());
				if (name!=null) {
					
					if (name.equals("TEXT")) {
						sb.append("        assertText(");						
						logJavaObject(sb,w);
					} else if (name.equals("USE")) { 
						sb.append("        assertUse(");						
						logJavaObject(sb,w);
					} else {
						sb.append("        assertProperty(");
						logJavaObject(sb,w);
						sb.append(",Prop.");
						sb.append(name);
					}
				} else {
					sb.append("        assertMetaData(");
					logJavaObject(sb,w);
					name = getCommandList(w).getName(item.getKey());
					if (name!=null) {
						sb.append(",\"");
						sb.append(name);
						sb.append('"');
					} else {
						sb.append(',');
						sb.append(item.getKey());
					}
				}
				sb.append(',');
				String alt=null;
				if (w instanceof AbstractControl) {
					if (item.getKey()==Prop.USE) {
						String text=((AbstractControl)w).getProperty(Prop.TEXT).toString();
						if (text.toLowerCase().startsWith("@d")) {
							int time =0;
							Object o = item.getValue();
							if (o instanceof ClarionObject) {
								time=((ClarionObject)o).intValue();
							}
							if (o instanceof Integer) {
								time=(Integer)o;
							}
							if (time>0) {
								newImports.add("import org.jclarion.clarion.runtime.CDate;");
								if (time==CDate.today()) {
									alt="CDate.today()";
								} else {
									alt="CDate.date("+CDate.month(time)+","+CDate.day(time)+","+CDate.year(time)+")";
								}
							}
						}
					}
				}
				if (alt!=null) {
					sb.append(alt);
				} else {
					logJavaObject(sb,item.getValue());
				}
				sb.append(");");
				doLog(sb);
			}
		}
		Iterable<? extends RemoteWidget> kids = w.getChildWidgets();
		if (kids != null) {
			for (RemoteWidget k : kids) {
				if (assertMetaData(k)) any=true;
			}
		}
		return any;
	}
	
	private static char hexit[] = "0123456789abcdef".toCharArray();
	
	private void logJavaObject(StringBuilder sb,Object o)
	{
		logJavaObject(sb,o,false);
	}
	
	private void logJavaObject(StringBuilder sb,Object o,boolean strict)
	{
		if (o==null) {
			sb.append("null");
			return;
		}
		if (o instanceof Long) {
			sb.append(o);
			sb.append("l");
			return;
		}
		if (o instanceof Integer) {
			int i = (Integer)o;
			String name = Prop.getPropStringOrNull(i);
			if (name!=null) {
				sb.append("Prop.").append(name);
			} else {
				sb.append(o);
			}
			return;
		}
		
		if (o instanceof ClarionEvent) {
			ClarionEvent ce = (ClarionEvent)o;
			sb.append("Event.");
			sb.append(CWin.eventString(ce.getEvent()).toUpperCase());
			if (ce.creatingField()!=null) {
				sb.append(",");
				logJavaObject(sb,ce.creatingField());
			} else {
				if (ce.getField()!=0) {
					sb.append(",").append(ce.getField());
				}
			}
			if (ce.getAdditionalData()!=null) {
				sb.append(",");
				logJavaObject(sb,ce.getAdditionalData());
			}

			if (o instanceof KeyedClarionEvent) {
				KeyedClarionEvent kce = (KeyedClarionEvent)o;
				sb.append(',').append(kce.getKeyChar());
				sb.append(',').append(kce.getKeyCode());
				sb.append(',').append(kce.getKeyState());
			}
			return;
		}
		
		if ((o instanceof ClarionNumber)) {
			if (strict) {
				newImports.add("import org.jclarion.clarion.Clarion;");
				sb.append("Clarion.newNumber(").append(o).append(")");
			} else {
				sb.append(o);
			}
			return;
		}
		

		if ((o instanceof ClarionString)  && strict) {
			sb.append("Clarion.newString(");
			logJavaObject(sb,o,false);
			sb.append(")");
			return;
		}
		
		if (o instanceof PropertyObject) {
			PropertyObject po  =(PropertyObject)o;
			sb.append('"');
			if (po.getId()==null) {
				po.setId(".auto_"+ ((AbstractControl)o).getUseID() );
			}
			sb.append(po.getId());
			sb.append('"');
			return;
		} 
		
		if (o instanceof RemoteWidget) {
			String name = o.getClass().getName();
			int pos = name.lastIndexOf('.');
			sb.append('"');
			sb.append(name.subSequence(pos+1,name.length()));
			sb.append('"');
			return;
		}

		if (o.getClass().isArray()) {
			sb.append("new Object[] {");
			for (int scan=0;scan<Array.getLength(o);scan++) {
				if (scan>0) sb.append(',');
				logJavaObject(sb,Array.get(o,scan));
			}
			sb.append('}');
			return;
		}
		if (o instanceof Boolean) {
			sb.append(o);
			return;
		}

		if (o instanceof Page) {
			Page p = (Page)o;
			PageToText ptt = new PageToText();
			ptt.extract(p);
			sb.append("new Object[] {");
			boolean first=true;
			for (String[] s : ptt.getLines()) {
				if (first) {
					sb.append("\n         new String[] {");
					first=false;
				} else {
					sb.append("\n        ,new String[] {");
				}
				boolean fs=true;
				for (String x : s ) {
					if (!fs) {
						sb.append(",");
					} else {
						fs=false;						
					}
					logJavaObject(sb,x);
				}
				sb.append("}");	
			}
			sb.append("}");	
			return;
		}
		
		sb.append('"');
		String s = o.toString();
		int len = s.length();
		while (len>0 && s.charAt(len-1)==' ') { len=len-1; }
		for (int scan=0;scan<len;scan++) {
			char c= s.charAt(scan);
			if (c=='"' || c=='\\') {
				sb.append('\\');
			}
			if (c>=32 && c<=126) {
				sb.append(c);
				continue;
			}
			if (c=='\r') {
				sb.append("\\r");
				continue;
			}
			if (c=='\n') {
				sb.append("\\n");
				continue;
			}
			if (c=='\t') {
				sb.append("\\t");
				continue;
			}
			sb.append("\\u");
			sb.append(hexit[(c>>12)&0x0f]);
			sb.append(hexit[(c>>8)&0x0f]);
			sb.append(hexit[(c>>4)&0x0f]);
			sb.append(hexit[(c)&0x0f]);
		}
		sb.append('"');
	}
	
	
	
	private static String lastLog="gui";
	
	private int log(RemoteWidget w,boolean willRespond,int command,Object... params)
	{
		if (name.equals("gui")) {
			if (w instanceof CWinImpl) {
				if (command==CWinImpl.OPEN) {
					guiRespond.add(new HashMap<Integer,Boolean>());
					log.pushMethod(((AbstractWindowTarget)params[0]).getId());
				} 
				if (command==CWinImpl.DISPOSE) {
					guiRespond.removeLast();
					log.popMethod();
				}
			}
		}
		
		if (!isLogWorthy(w,command,params) && !willRespond) return 0;
	
		if (!lastLog.equals(name)) {
			lastLog=name;
			log.println();
		}
		
		if (name.equals("gui")) {
			return guiLog(w,willRespond,command,params);
		}
		
		// log server
		if (w instanceof AbstractWindowTarget) {
			if (command==AbstractWindowTarget.POST) {
				StringBuilder sb = new StringBuilder();
				sb.append("        post(");
				ClarionEvent ce = (ClarionEvent)params[0];
				if (ce.creatingField()==null) {
					logJavaObject(sb,w);
					sb.append(",");
				}
				logJavaObject(sb,params[0]);
				sb.append(");");
				doLog(sb);
				return 0;
			}
		}
		
		StringBuilder sb = new StringBuilder();
		int count=0;
		if (willRespond) {
			count=getRespondID();
			sb.append("        s").append(count).append("=sendRecv(");
		} else {
			sb.append("        send(");
		}
		logJavaObject(sb,w);
		sb.append(",\"");
		CommandList cl = getCommandList(w);
		sb.append(cl.getName(command));
		sb.append("\"");
		for (Object o : params ) {
			sb.append(",");
			logJavaObject(sb,o);
		}
		sb.append(");");
		doLog(sb);
		return count;
	}
	
	protected boolean isLogWorthy(RemoteWidget w,int command,Object... params)
	{
		return profile.isLogWorthy(w,command,params);
	}
	
	@SuppressWarnings("unused")
	private void logMetaData(RemoteWidget w) 
	{
		logMetaData(w,true);
	}
	
	private boolean isMetaDataInteresting(RemoteWidget w)
	{
		if (w instanceof GroupControl) {
			return false;
		}
		if (w instanceof PanelControl) {
			return false;
		}
		if (w instanceof StringControl) {
			return ((StringControl)w).getUseObject()!=null;
		}
		return true;
	}
	
	private boolean isMetaDataInteresting(RemoteWidget w,int key,Object value)
	{
		if (w instanceof EntryControl) {
			if (key==Prop.TEXT) return false; 
		}

		if (w instanceof StringControl) {
			if (key==Prop.TEXT && ((StringControl)w).getUseObject()!=null) return false; 
		}
		
		switch (key) {
			case Prop.FONTCHARSET:
			case Prop.FONT:
			case Prop.FONTCOLOR:
			case Prop.FONTSIZE:
			case Prop.FONTSTYLE:
			case Prop.XPOS:
			case Prop.YPOS:
			case Prop.WIDTH:
			case Prop.HEIGHT:
			case Prop.GRAY:
			case Prop.CLIENTWIDTH:
			case Prop.CLIENTHEIGHT:
			case Prop.MAXIMIZE:
			case Prop.IMM:
			case Prop.SYSTEM:
			case Prop.ICON:
			case Prop.TIMER:
			case Prop.MODAL:
			case Prop.MDI:
			case Prop.DOUBLE:
			case Prop.DEFAULT:
			case Prop.VSCROLL:
			case Prop.HSCROLL:
			case Prop.SELSTART:
			case Prop.SELEND:
			case Prop.COLUMN:
			case Prop.BOXED:
			case Prop.BEVELINNER:
			case Prop.BEVELOUTER:
			case Prop.BEVELSTYLE:
			case Prop.VSCROLLPOS:
			case Prop.CENTEROFFSET:
			case Prop.CENTER:
			case Prop.LEFT:
			case Prop.LEFTOFFSET:
			case Prop.RIGHT:
			case Prop.RIGHTOFFSET:
			case Prop.DECIMAL:
			case Prop.DECIMALOFFSET:
			case Prop.MSG:
			case Prop.SKIP:
			case Prop.ALRT:
			case Prop.FORMAT:
			case Prop.TRUEVALUE:
			case Prop.FALSEVALUE:
			case Prop.MINWIDTH:
			case Prop.HLP:
			case Prop.MINHEIGHT:
			case Prop.RESIZE:
			case Prop.MAX:
			case Prop.KEY:
			case Prop.STD:
			case Prop.LINEWIDTH:
			case Prop.PASSWORD:
			case Prop.SELECTEDCOLOR:
			case Prop.FILLCOLOR:
			case Prop.SELECTEDFILLCOLOR:
				return false;
				
		}

		String name = getCommandList(w).getName(key);
		if (name==null) return true;
		if (name.equals("MD_USEID")) return false;
		if (name.equals("MD_ALERTS")) return false;
		if (name.equals("MD_STATUS")) return false;
		if (name.equals("MD_PROPSTYLE")) return false;
		return true;
	}
	
	private void logMetaData(RemoteWidget w,boolean root) 
	{
		Map<Integer,Object> data = w.getChangedMetaData();
		StringBuilder sb = new StringBuilder();
		if (data != null && !data.isEmpty() && isMetaDataInteresting(w)) {
			boolean anyLog=root;
			for (Map.Entry<Integer, Object> item : data.entrySet()) {
				if (!isMetaDataInteresting(w,item.getKey(),item.getValue())) continue;

				sb.setLength(0);
				sb.append("  ");
				String name = Prop.getPropStringOrNull(item.getKey());
				if (name==null) {
					name = getCommandList(w).getName(item.getKey());					
				}
				if (name==null) {
					name = item.getKey().toString()+"?";
				}
				if (!anyLog) {
					sb.setLength(0);
					sb.append("  ");
					stampObject(sb,w);
					doLog(sb);
					anyLog=true;
					sb.setLength(0);
				}
				
				sb.setLength(0);
				sb.append("  ");
				sb.append(name);
				sb.append(" : ");
				stampObject(sb, item.getValue());
				doLog(sb);
			}
		}
		Iterable<? extends RemoteWidget> kids = w.getChildWidgets();
		if (kids != null) {
			for (RemoteWidget k : kids) {
				logMetaData(k,false);
			}
		}
	}

	private void logResult(RemoteWidget w,int count,Object result, int command,Object... params)
	{		
		StringBuilder entry = new StringBuilder();
		if (getSide().equals("gui")) {
			entry.append("        s").append(guiRespond.size()).append('_').append(count).append(".setResult(");
			logJavaObject(entry,result,true);
			entry.append(");");
		} else {
			entry.append("        assertResult(");
			logJavaObject(entry,result);
			entry.append(",s").append(guiRespond.size()).append('_').append(count).append(");");
		}
		guiRespond.getLast().put(count,false);
		doLog(entry);
		log.println();
	}

	private boolean isLocal()
	{
		return getSide().equals(name);
	}
	
	private void doLog(StringBuilder entry)
	{		
		log.println(entry);
	}
	
	@Override
	public void send(final RemoteWidget w,final int command,final Object... params) 
	{
		if (isLocal()) {
			base.send(w,command,params);
			return;
		}

		synchronized(log) {
			log(w,false,command,params);
		}
		localReader.deploy(new Runnable() {
			public void run() {
				base.send(w,command,params);
			}
		});
	}

	@Override
	public void send(final RemoteWidget w, final ResponseRunnable nextTask, final int command,final Object... params) {
		if (isLocal()) {
			base.send(w,nextTask,command,params);
			return;
		}

		final int count;
		synchronized(log) {
			count=log(w,true,command,params);
		}
		localReader.deploy(new Runnable() {
			public void run() {
				base.send(w,new ResponseRunnable() {
					@Override
					public void run(final Object result) {
						synchronized(log) {
							logResult(w,count,result,command,params);
						}
						if (nextTask!=null) {
							remoteReader.deploy(new Runnable() {
								public void run() {
									nextTask.run(result);
								};
							});
						}
					}
				},command,params);
			}
		});
	}

	@Override
	public Object sendRecv(final RemoteWidget w,final int command,final Object... params) {
		if (isLocal()) {
			return base.sendRecv(w,command,params);
		}
		WaitRunnable wr = new WaitRunnable() {
			@Override
			public Object doRun() {
				int count;
				synchronized(log) {
					count=log(w,true,command,params);
				}
				Object o = base.sendRecv(w,command,params);
				synchronized(log) {
					logResult(w,count,o,command,params);
				}
				return o;
			}
			
		};
		localReader.deploy(wr);
		return wr.getResult();
		
	}

	@Override
	public void send(RemoteSemaphore rs, Object result) {
		// TODO Auto-generated method stub
		
	}

	
	
}
