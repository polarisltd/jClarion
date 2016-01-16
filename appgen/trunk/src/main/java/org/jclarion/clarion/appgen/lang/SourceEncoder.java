package org.jclarion.clarion.appgen.lang;

import java.io.IOException;

/**
 * Encode various things into correct clarion source encoding
 * 
 * @author barney
 */
public class SourceEncoder {
	public static String encodeString(CharSequence source)
	{
		StringBuilder sb  =new StringBuilder();
		try {
			encodeString(source,sb,true);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	private static final char[] hexits="0123456789ABCDEF".toCharArray();
	
	public static void encodeString(CharSequence source,Appendable target,boolean includeQuotes) throws IOException
	{
		if (includeQuotes) {
			target.append('\'');
			if (source.length()==0) {
				target.append('\'');
				return;
			}
		} else {
			if (source.length()==0) {
				return;
			}
		}
		
		int scan=0;
		char c=source.charAt(0);
		
		boolean closeExpand=false;
		
		while (true) {
			if (c=='\'' || c=='<' || c=='{') {
				if (closeExpand) {
					target.append('>');
					closeExpand=false;
				}
				target.append(c);
				target.append(c);
			} else if (c>=32 && c<=126) {
				if (closeExpand) {
					target.append('>');
					closeExpand=false;
				}
				target.append(c);
			} else {
				if (closeExpand) {
					target.append(',');
				} else {
					target.append('<');
					closeExpand=true;
				}
				target.append(hexits[(c>>4)&15]);
				target.append(hexits[(c)&15]);
				target.append('H');
			}
			
			// look ahead as long as it is the same character
			int count=0;
			char la=0;
			scan++;
			while (scan+count<source.length()) {
				la=source.charAt(scan+count);
				count++;
				if (la!=c || closeExpand) {
					break;
				}
			}
			if (count==1) {
				// next character not the same.  Most common occurrance
				c=la;
			} else if (count==0) {
				// end of string
				break;
			} else if (count>=5) {
				// character repeated at least 6 times
				if (c==la) {
					// count counts to the end
					target.append("{");
					target.append(Integer.toString(count+1));
					target.append("}");
					break;
				} else {
					// count also counts the next lookahead character
					target.append("{");
					target.append(Integer.toString(count));
					target.append("}");
					scan+=count-1;
					c=la;					
				}
			} else {
				// do nothing. Repeated charater but not repeated enough to escape with {}
			}
		}
		if (closeExpand) {
			target.append('>');
			closeExpand=false;
		}		
		if (includeQuotes) {
			target.append('\'');
		}
	}
}
