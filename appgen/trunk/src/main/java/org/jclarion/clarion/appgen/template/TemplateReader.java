package org.jclarion.clarion.appgen.template;



import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Stack;

import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

/**
 * Read lines off a template file doing some initial parsing.
 * 
 * @author barney
 *
 */
public class TemplateReader 
{
	/*
	public static final Set<String> WINSTRUCTURE=new HashSet<String>(); 
	static {
		WINSTRUCTURE.add("ORDINAL");
		WINSTRUCTURE.add("ORIG");
		WINSTRUCTURE.add("SEQ");
		WINSTRUCTURE.add("FIELDS");
		WINSTRUCTURE.add("LINK");
		WINSTRUCTURE.add("#ORDINAL");
		WINSTRUCTURE.add("#ORIG");
		WINSTRUCTURE.add("#SEQ");
		WINSTRUCTURE.add("#FIELDS");
		WINSTRUCTURE.add("#LINK");
	}
	*/

	private static class Source
	{
		private BufferedReader reader;
		private String name;
		private int linecount;
		private String lastLine;
	}
		
	private Stack<Source> stack=new Stack<Source>();  	
	private AbstractLine last=null;
	
	TemplateLoaderSource path;
	//private Map<String,File> files=new HashMap<String,File>();
	
	public TemplateReader(TemplateLoaderSource path)
	{
		this.path=path;
	}

	public void addSource(String name) throws IOException
	{
		addSource(new BufferedReader(new InputStreamReader(path.get(name))),name);
	}
	
	public void addSource(BufferedReader reader,String name)
	{
		Source s = new Source();
		s.reader=reader;
		s.name=name;
		stack.add(s);
	}
	
	public String readRaw() throws IOException
	{
		if (stack.isEmpty()) return null;
		Source s = stack.peek();
		String line= s.reader.readLine();
		s.linecount++;
		s.lastLine=line;
		return line;
	}
	
	public AbstractLine read() throws IOException
	{
		if (last!=null && !last.isConsumed()) return last;
		last=_read();
		return last;
	}
	
	private String _nextline;
	
	private AbstractLine _read() throws IOException
	{
		
		while ( true ) {
			String line=null;
			if (_nextline!=null) {
				line=_nextline;
				_nextline=null;
			} else {
				if (stack.isEmpty()) return null;
				Source s = stack.peek();
				line = s.reader.readLine();
				s.linecount++;
				s.lastLine=line;
			}
			if (line==null) {
				stack.pop();
				continue;
			}
			
			char first=' ';
			int scan=0;
			while (scan<line.length()) {
				first = line.charAt(scan++);
				if (first=='\t') {
					first=' ';
					continue;
				}
				if (first==' ') continue;
				break;
			}

			if (first=='#') {
				if (scan==line.length()) error("Blank Line");
				char second = line.charAt(scan);
				
				/**
				 * options:
				 *   #! = comment
				 *   #$ = comment
				 *   #? = conditional source code
				 *   #< = spaced comment
				 *   #A-Z = command label
				 */
				
				if (second=='!' || second=='$') {
					continue; 
				}
				
				if (second=='?') {
					line=line.substring(0,scan-1)+line.substring(scan+1);
					return parseSourceLine(line,true);
				}
				
				if (second=='<') {
					return parseSourceLine(line.substring(scan+1),false);
				}

				MarkedStringReader msr = new MarkedStringReader(line,scan);
				Lexer l = new Lexer(msr);
				l.setIgnoreWhitespace(true);
				l.setJavaMode(false);
				l.setTemplateLexer(true);
				Lex cmd = l.next();
				/*
				if (WINSTRUCTURE.contains(cmd.value)) {
					return parseSourceLine(line,false,false);
				}
				*/
				
				int to = line.indexOf('#',scan);
				if (to>-1) {
					// string may be multiline.  These don't happen often
					l.begin();
					while ( true ) {
						while (true) {
							char ch=l.getStream().peek(0);
							if (ch==' ' || ch=='\t') {
								l.getStream().skip(1);
							} else {
								break;
							}
						}
						if (l.getStream().peek(0)=='#') {
							l.getStream().skip(1);
							int pos = msr.getPos();
							msr.setLength(pos);
							_nextline=line.substring(pos-1);
							if (_nextline.startsWith("#!")) {
								_nextline=null;
							}
							break;
						}
						Lex t = l.next();
						if (t.type==LexType.eof) break;
					}
					l.rollback();
				}
				
				return new CommandLine(scan-1,cmd.value,l);
			}
			return parseSourceLine(line,false);
		}
	}
	
	private AbstractLine parseSourceLine(String line, boolean conditional) throws IOException 
	{
		return new SourceLine(line,conditional);
	}

	public void error(String msg) throws IOException
	{
		if (stack.isEmpty()) {
			throw new IOException(msg);
		}
		Source s = stack.peek();
		throw new IOException(msg+" at "+s.name+" #"+s.linecount+" ("+s.lastLine+")");
	}

	public int getLine() {
		if (stack.isEmpty()) return 0;
		return stack.peek().linecount;
	}

	public String getFile() {
		if (stack.isEmpty()) return "?";
		return stack.peek().name;
	}
}
