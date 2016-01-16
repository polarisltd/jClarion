package org.jclarion.clarion.test;

import java.io.CharArrayWriter;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class TeeStream
{
	private Writer base;
	private List<CharArrayWriter> methods=new ArrayList<CharArrayWriter>();
	private LinkedList<CharArrayWriter> stack = new LinkedList<CharArrayWriter>();
	private Set<String> methodNames=new HashSet<String>();
	private Map<String,String[]> fields = new LinkedHashMap<String,String[]>();
	private CharArrayWriter current;
	private String primaryMethod=null;
	
	public TeeStream(Writer base) throws FileNotFoundException 
	{
		this.base=base;
	}

	public void close() throws IOException {
		base.close();
	}

	public void flush() throws IOException {
		base.flush();
	}

	public void println() 
	{
		current.append('\n');
		try {
			base.write('\n');
		} catch (IOException ex) { }
	}

	public void print(CharSequence s) 
	{
		current.append(s);
		try {
			base.append(s);
		} catch (IOException ex) { }
	}
	
	public void println(CharSequence s) {
		print(s);
		println();
	}
	
	public String setField(String name,String type,String assignment)
	{
		for (Map.Entry<String,String[]> e : fields.entrySet() ) {
			if (e.getValue()[0].equals(type) && e.getValue()[1].equals(assignment)) {
				return e.getKey();
			}
		}
		name="_"+primaryMethod+"_"+name.replace('.','_').replaceAll("[^a-zA-Z0-9_]","");
		if (fields.containsKey(name)) {
			int scan=1;
			while ( true ) {
				String test = name+"_"+scan;
				if (fields.containsKey(test)) {
					scan++;
					continue;
				}
				name=test;
				break;
			}
		}
		
		fields.put(name,new String[] {type,assignment});
		return name;
	}

	public String pushMethod(String name)
	{
		name=name.replace('.','_').replaceAll("[^a-zA-Z0-9_]","");

		boolean append=false;
		if (primaryMethod==null) {
			primaryMethod=name;
		} else {
			name="_"+primaryMethod+"_"+name;
			append=true;
		}
		
		if (methodNames.contains(name)) {
			int scan=1;
			while (methodNames.contains(name+"_"+scan)) {
				scan++;
			}
			name=name+"_"+scan;
		}
		
		if (append) {
			current.append("        ").append(name).append("();\n");			
		}
		
		methodNames.add(name);
		current=new CharArrayWriter();
		methods.add(current);
		stack.add(current);
		current.append("    public void ").append(name).append("()\n");
		current.append("    {\n");
		return name;
	}
	
	public void popMethod()
	{
		current.append("    }\n");
		stack.removeLast();
		if (stack.isEmpty()) {
			current=null;
		} else {
			current=stack.getLast();
		}
	}
	
	public void rewrite(Appendable out) throws IOException
	{
		for (Map.Entry<String,String[]> e : fields.entrySet() ) {
			out.append("    private ").append(e.getValue()[0]).append(' ').append(e.getKey());
			out.append(" = _gen").append(e.getKey()).append("();\n");
			out.append("    private static ").append(e.getValue()[0]);
			out.append(" _gen").append(e.getKey()).append("() {\n");
			out.append("        return ").append(e.getValue()[1]).append(";\n");
			out.append("    }\n");
		}
		for ( CharArrayWriter caw : methods ) {
			out.append(caw.toString());
		}
	}
}
