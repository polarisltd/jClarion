package org.jclarion.clarion.appgen.loader;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.lang.Lex;

/**
 * Loads a TXA application file and represents it as a set of beans stemming from App object
 * 
 * @author barney
 */
public class GenericLoader {
	private BufferedReader reader;
	private String last=null;
	private String la=null;
	private int lineCount=0;

	public GenericLoader(BufferedReader reader)
	{
		this.reader=reader;
	}
	

	public void lineError(String error) throws IOException
	{
		throw new IOException(error+" at line "+lineCount+" ("+last+")");
	}
	
	public List<Lex> decode() throws IOException
	{
		String next = next();
		if (next==null) return null;
		return decode(next);
	}
	
	public Definition getDefintion() throws IOException
	{
		String next = next();
		if (next==null) return null;
		return DefinitionLoader.loadItem(next);
	}

	public Definition getDefintion(String next) throws IOException
	{
		return DefinitionLoader.loadItem(next);
	}
	
	public List<Lex> decode(String next) throws IOException
	{	
		List<Lex> result = new ArrayList<Lex>();		
		StringScanner ss = new StringScanner(next,lineCount);		
		while (true ) {
			Lex l = ss.pop();
			if (l==null) return result;
			result.add(l);
		}
	}

	
	public String next() throws IOException
	{
		if (la==null) {
			la();
		}
		if (la!=null) {
			last=la;
			la=null;
			return last;
		}
		return la;
	}

	public String la() throws IOException
	{
		return la(true);
	}
	
	public String la(boolean mergelines) throws IOException
	{
		 if (la!=null) return la;
		 while (true ) {
			 String n=reader.readLine();
			 if (n==null) break;
			 lineCount++;
			 
			 boolean join=false;
			 if (mergelines && n.length()>0 && n.charAt(n.length()-1)=='|') {
				 join=true;
				 n=n.substring(0,n.length()-1);
			 }
			 if (la==null) {
				 la=n;
			 } else {
				 la=la+n;
			 }
			 if (!join) break;
		 }
		 last=la;
		 return la;
	}

	public StringScanner scanner() throws IOException
	{
		return scanner(next());
	}

	public StringScanner scanner(String src) {
		return new StringScanner(src,lineCount);
	}
}
