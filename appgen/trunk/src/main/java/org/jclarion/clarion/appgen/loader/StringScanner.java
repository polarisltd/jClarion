package org.jclarion.clarion.appgen.loader;

import java.io.IOException;

import org.jclarion.clarion.lang.Constant;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class StringScanner
{
	private String source;
	int pos=0;
	private int lineCount;
	
	StringScanner(String source,int lineCount)
	{
		this.source=source;
		this.lineCount=lineCount;
	}
	
	private Lex la=null;
	private Lex last=null;
	
	public Lex la() throws IOException
	{
		if (la!=null) return la;
		la=pop();
		return la;
	}

	public Lex next() throws IOException
	{
		if (la!=null) {
			Lex r = la;
			la=null;
			return r;
		}
		return pop();
	}

	public Lex pop() throws IOException
	{
		last=_pop();
		return last;
	}
	
	private Lex _pop() throws IOException
	{
		// pop whitespace
		while (pos<source.length()) {
			char c = source.charAt(pos);
			if (c==' ' || c=='\t') {
				pos++;
				continue;
			} else {
				break;
			}
		}
		
		if (pos==source.length()) return null;
		
		char c = source.charAt(pos);
		
		if ((c>='a' && c<='z') || (c>='A' && c<='Z') || (c=='%') || (c=='@')) {
			int start=pos;
			pos++;
			while (pos<source.length()) {
				c = source.charAt(pos);
				if ((c>='a' && c<='z') || (c>='A' && c<='Z') || (c=='%') || (c=='_') || (c=='@') || (c>='0' && c<='9') || c==':') {
					pos++;
				} else {
					break;
				}
			}
			return new Lex(LexType.label,source.substring(start,pos));
		}
		
		if (c=='(') {
			pos++;
			return new Lex(LexType.lparam,"(");
		}

		if (c==')') {
			pos++;
			return new Lex(LexType.rparam,")");
		}

		if (c==',') {
			pos++;
			return new Lex(LexType.param,",");
		}
		
		if (c=='\'') {
			pos++;
			int start=pos;
			
			while (true) {
				if (pos>=source.length()) {
					lexError("Unterminated String");
				}
				c = source.charAt(pos);
				pos++;
				if (c=='\'') {
					if (pos<source.length() && source.charAt(pos)=='\'') {
						pos++;
					} else {
						break;
					}
				}
			}
			return new Lex(LexType.string,Constant.string(source.substring(start,pos-1),false));				
		}
		
		if ((c>='0' && c<='9') || c=='-') {
			int start=pos;
			pos++;
			while (pos<source.length()) {
				c=source.charAt(pos);
				if ((c>='0' && c<='9') || c=='-' || (c>='a' && c<='f') || (c>='A' && c<='F') || c=='b' || c=='B' || c=='h' || c=='H') {
					pos++;
				} else {
					break;
				}
			}
			return new Lex(LexType.integer,Constant.number(source.substring(start,pos)));
		}
		
		lexError("Unknown char : "+c);
		return null;
	}
	
	public void lexError(String error) throws IOException
	{
		throw new IOException(error+" at line "+lineCount+" ("+source+") "+last);
	}
}