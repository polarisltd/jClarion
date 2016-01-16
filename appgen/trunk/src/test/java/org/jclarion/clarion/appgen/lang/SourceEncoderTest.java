package org.jclarion.clarion.appgen.lang;

import java.io.StringReader;

import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

import junit.framework.TestCase;

public class SourceEncoderTest extends TestCase {

	
	public void testVariousEncodings()
	{
		assertEncoding("Hello World","'Hello World'");
		assertEncoding("Hello  World","'Hello  World'");
		assertEncoding("Hello  World ","'Hello  World '");
		assertEncoding("Hello  World  ","'Hello  World  '");
		assertEncoding("Hello  World   ","'Hello  World   '");
		assertEncoding("Hello  World    ","'Hello  World    '");
		assertEncoding("Hello  World      ","'Hello  World {6}'");
		assertEncoding("Hello World          ","'Hello World {10}'");
		assertEncoding("Hello           World","'Hello {11}World'");
		assertEncoding("Hello World'<20>{10}\r\n","'Hello World''<<20>{{10}<0DH,0AH>'");
		assertEncoding("\"The Laser\"","'\"The Laser\"'");
	}

	private void assertEncoding(String in,String enc) 
	{
		String result = SourceEncoder.encodeString(in);
		assertEquals(enc,result);
		
		Lexer l = new Lexer(new StringReader(result));
		l.setJavaMode(false);
		Lex test = l.next();
		assertEquals(LexType.string,test.type);
		assertEquals(in,test.value);
	}
	
}