package org.jclarion.clarion.ide.lang;

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
			encodeString(source,sb);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	public static void encodeString(CharSequence source,Appendable target) throws IOException
	{
		target.append('\'');
		if (source.length()==0) {
			target.append('\'');
			return;
		}
		
		int scan=0;
		char c=source.charAt(0);
		while (true) {
			if (c=='\'' || c=='<' || c=='{') {
				target.append(c);
				target.append(c);
			} else if (c>=32 && c<=126) {
				target.append(c);
			} else {
				target.append('<');
				target.append(Integer.toString((int)c));
				target.append('>');
			}
			
			// look ahead as long as it is the same character
			int count=0;
			char la=0;
			scan++;
			while (scan+count<source.length()) {
				la=source.charAt(scan+count);
				count++;
				if (la!=c) {
					break;
				}
			}
			if (count==1) {
				// next character not the same.  Most common occurrance
				c=la;
			} else if (count==0) {
				// end of string
				break;
			} else if (count>=4) {
				// character repeated at least 5 times
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
		target.append('\'');
	}
}
