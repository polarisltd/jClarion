/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.lang;

import java.io.CharArrayReader;
import java.io.Reader;
import java.io.StringReader;

import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

import junit.framework.TestCase;

public class LexerTest extends TestCase {

	public void testWhiteSpacedOps()
	{
		assertSingle("<>",LexType.comparator,"<>");
		assertSingle("< >",LexType.comparator,"<>");
		assertSingle("~=",LexType.comparator,"~=");
		assertSingle("~ =",LexType.comparator,"~=");
		assertSingle("<=",LexType.comparator,"<=");
		assertSingle("< =",LexType.comparator,"<=");
		assertSingle(">=",LexType.comparator,">=");
		assertSingle("> =",LexType.comparator,">=");
		assertSingle("=>",LexType.comparator,"=>");
		assertSingle("= >",LexType.comparator,"=>");
		assertSingle("=<",LexType.comparator,"=<");
		assertSingle("= <",LexType.comparator,"=<");
		assertSingle("~>",LexType.comparator,"~>");
		assertSingle("~ >",LexType.comparator,"~>");
		assertSingle("~<",LexType.comparator,"~<");
		assertSingle("~ <",LexType.comparator,"~<");
	}
	
	public void testWhitespacedOps2()
	{
    	Lexer l = new Lexer(new StringReader("> = apple"));
    	Lex le = l.next();
    	assertSame(LexType.comparator,le.type);
    	assertEquals(">=",le.value);
    	le = l.next();
    	assertSame(LexType.ws,le.type);
    	assertEquals(" ",le.value);
    	le = l.next();
    	assertSame(LexType.label,le.type);
    	assertEquals("apple",le.value);
	}
	
    private void assertSingle(String string, LexType operator, String string2) {
    	Lexer l = new Lexer(new StringReader(string));
    	Lex le = l.next();
    	assertSame(operator,le.type);
    	assertEquals(string2,le.value);
	}

	public void testMultiCharString()
    {
        String test = "'ひらがな, 平仮名'";
        Lexer lr = new Lexer(new StringReader(test));
        lr.setJavaMode(false);
        Lex l = lr.next();
        assertEquals(LexType.string,l.type);
        assertEquals("ひらがな, 平仮名",l.value);
    }

    public void testMultiCharStringToJava()
    {
        String test = "'ひらがな, 平仮名'";
        Lexer lr = new Lexer(new StringReader(test));
        Lex l = lr.next();
        assertEquals(LexType.string,l.type);
        assertEquals("\"ひらがな, 平仮名\"",l.value);
    }
    
    public void testBug2988797()
    {
        String num[] = new String[] { "@N4_","@N4_.2","@N4..2","@N4-.2","@N4.B" ,"@N4_v2b"};
        
        for (String test : num) {
            assertLex(test,
                    new Lex(LexType.picture,test),
                    new Lex(LexType.eof,"")
            );
            
        }
    }
    
    public void testLexerLabel()
    {
        assertLex("andrew",
                new Lex(LexType.label,"andrew"),
                new Lex(LexType.eof,"")
        );

        assertLex("_andrew",
                new Lex(LexType.label,"_andrew"),
                new Lex(LexType.eof,"")
        );

        assertLex("andrew123",
                new Lex(LexType.label,"andrew123"),
                new Lex(LexType.eof,"")
        );

        assertLex("Andrew_12:3",
                new Lex(LexType.label,"Andrew_12:3"),
                new Lex(LexType.eof,"")
        );

        assertLex("andrew123:",
                new Lex(LexType.label,"andrew123:"),
                new Lex(LexType.eof,"")
        );

        assertLex("12ndrew123:",
                new Lex(LexType.integer,"12"),
                new Lex(LexType.label,"ndrew123:"),
                new Lex(LexType.eof,"")
        );
    }

    public void testLexerWhitespace()
    {
        assertLex("andrew barnham",
                new Lex(LexType.label,"andrew"),
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"barnham"),
                new Lex(LexType.eof,"")
        );

        assertLex("andrew \t barnham",
                new Lex(LexType.label,"andrew"),
                new Lex(LexType.ws," \t "),
                new Lex(LexType.label,"barnham"),
                new Lex(LexType.eof,"")
        );

        assertLex("andrew| ! Comment\nbarnham",
                new Lex(LexType.label,"andrew"),
                new Lex(LexType.ws,"| ! Comment\n"),
                new Lex(LexType.label,"barnham"),
                new Lex(LexType.eof,"")
        );

        assertLex("andrew| ! Comment\n | another comment\nbarnham",
                new Lex(LexType.label,"andrew"),
                new Lex(LexType.ws,"| ! Comment\n | another comment\n"),
                new Lex(LexType.label,"barnham"),
                new Lex(LexType.eof,"")
        );
        
    }

    public void testNewLine()
    {
        assertLex(" program\n",
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"program"),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.eof,"")
        );
        assertLex(" program\r\n",
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"program"),
                new Lex(LexType.nl,"\r\n"),
                new Lex(LexType.eof,"")
        );
        assertLex(" program\r\nFile\n",
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"program"),
                new Lex(LexType.nl,"\r\n"),
                new Lex(LexType.label,"File"),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.eof,"")
        );
    }
    
    public void testString()
    {
        assertLex("'hello'\n",
                new Lex(LexType.string,"\"hello\""),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.eof,"")
        );

        assertLex("'hello\n",
                new Lex(LexType.string,"\"hello\""),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.eof,"")
        );

        assertLex("'hel''lo'\n",
                new Lex(LexType.string,"\"hel'lo\""),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.eof,"")
        );
    }

    public void testComment()
    {
        assertLex(" filename ! this is the file name\n",
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"filename"),
                new Lex(LexType.ws," "),
                new Lex(LexType.comment,"! this is the file name"),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.eof,"")
        );
    }    

    public void testDecimal()
    {
        assertLex(".123",
                new Lex(LexType.decimal,"0.123"),
                new Lex(LexType.eof,"")
        );

        assertLex("16.123",
                new Lex(LexType.decimal,"16.123"),
                new Lex(LexType.eof,"")
        );
    }    

    public void testInteger()
    {
        assertLex("123",
                new Lex(LexType.integer,"123"),
                new Lex(LexType.eof,"")
        );

        assertLex("123fh",
                new Lex(LexType.integer,"0x123f"),
                new Lex(LexType.eof,"")
        );

        assertLex("123o",
                new Lex(LexType.integer,"0x53"),
                new Lex(LexType.eof,"")
        );

        assertLex("101B",
                new Lex(LexType.integer,"0x5"),
                new Lex(LexType.eof,"")
        );
    }    
    
    public void testSimpleMisc()
    {
        assertLex("(",
                new Lex(LexType.lparam,"("),
                new Lex(LexType.eof,"")
        );

        assertLex(")",
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("[",
                new Lex(LexType.lbrack,"["),
                new Lex(LexType.eof,"")
        );

        assertLex("]",
                new Lex(LexType.rbrack,"]"),
                new Lex(LexType.eof,"")
        );

        assertLex("{",
                new Lex(LexType.lcurl,"{"),
                new Lex(LexType.eof,"")
        );

        assertLex("}",
                new Lex(LexType.rcurl,"}"),
                new Lex(LexType.eof,"")
        );

        assertLex(".",
                new Lex(LexType.dot,"."),
                new Lex(LexType.eof,"")
        );

        assertLex(",",
                new Lex(LexType.param,","),
                new Lex(LexType.eof,"")
        );

        assertLex("\"#$",
                new Lex(LexType.implicit,"\""),
                new Lex(LexType.implicit,"#"),
                new Lex(LexType.implicit,"$"),
                new Lex(LexType.eof,"")
        );

        assertLex("+-*/%^",
                new Lex(LexType.operator,"+"),
                new Lex(LexType.operator,"-"),
                new Lex(LexType.operator,"*"),
                new Lex(LexType.operator,"/"),
                new Lex(LexType.operator,"%"),
                new Lex(LexType.operator,"^"),
                new Lex(LexType.eof,"")
        );
        
        assertLex("&",
                new Lex(LexType.reference,"&"),
                new Lex(LexType.eof,"")
        );

        assertLex(":",
                new Lex(LexType.colon,":"),
                new Lex(LexType.eof,"")
        );
        
        assertLex(";",
                new Lex(LexType.semicolon,";"),
                new Lex(LexType.eof,"")
        );

        assertLex("?",
                new Lex(LexType.use,"?"),
                new Lex(LexType.eof,"")
        );
    }

    public void testAssign()
    {
        assertLex("+=-=*=/=%=^=:=:",
                new Lex(LexType.assign,"+="),
                new Lex(LexType.assign,"-="),
                new Lex(LexType.assign,"*="),
                new Lex(LexType.assign,"/="),
                new Lex(LexType.assign,"%="),
                new Lex(LexType.assign,"^="),
                new Lex(LexType.assign,":=:"),
                new Lex(LexType.eof,"")
        );
    }    

    public void testComparator()
    {
        assertLex("<>,~=,=>,>=,~<,=<,<=,~>,>,<,=,&=,~,",
                new Lex(LexType.comparator,"<>"),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"~="),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"=>"),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,">="),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"~<"),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"=<"),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"<="),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"~>"),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,">"),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"<"),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"="),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"&="),
                new Lex(LexType.param,","),
                new Lex(LexType.comparator,"~"),
                new Lex(LexType.param,","),
                new Lex(LexType.eof,"")
        );
    }    
    
    public void testPicture()
    {
        assertLex("@s20)",
                new Lex(LexType.picture,"@s20"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@S20)",
                new Lex(LexType.picture,"@S20"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@n20)",
                new Lex(LexType.picture,"@n20"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@N$10.3b)",
                new Lex(LexType.picture,"@N$10.3b"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@t6.)",
                new Lex(LexType.picture,"@t6."),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@d6.)",
                new Lex(LexType.picture,"@d6."),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@kKK3424aqsdk)",
                new Lex(LexType.picture,"@kKK3424aqsdk"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@K234234kK)",
                new Lex(LexType.picture,"@K234234kK"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@p###p)",
                new Lex(LexType.picture,"@p###p"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );

        assertLex("@p#######pB)",
                new Lex(LexType.picture,"@p#######pB"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );
        
        assertLex("@P###P)",
                new Lex(LexType.picture,"@P###P"),
                new Lex(LexType.rparam,")"),
                new Lex(LexType.eof,"")
        );
    }
    
    public void testSkip()
    {
        Lexer l = createLexer("  program\n  omit('skip')   junk junk junk skip\n  t=1");
        assertLex(l,
                new Lex(LexType.ws,"  "),
                new Lex(LexType.label,"program"),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.ws,"  "),
                new Lex(LexType.label,"omit"),
                new Lex(LexType.lparam,"("),
                new Lex(LexType.string,"\"skip\""),
                new Lex(LexType.rparam,")")
                );
        
        l.skipUntilMarker("skip");
        
        assertLex(l,
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.ws,"  "),
                new Lex(LexType.label,"t"),
                new Lex(LexType.comparator,"="),
                new Lex(LexType.integer,"1"),
                new Lex(LexType.eof,"")
                );
    }
    
    public void testNextSkip()
    {
        Lexer l = createLexer("  program\n  t=1");
        
        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
        assertLex(new Lex(LexType.label,"program"),l._next(false,1));
        assertLex(new Lex(LexType.nl,"\n"),l._next(false,2));
        assertLex(new Lex(LexType.ws,"  "),l._next(false,3));
        assertLex(new Lex(LexType.label,"t"),l._next(false,4));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,5));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,6));
        assertLex(new Lex(LexType.eof,""),l._next(false,7));

        assertLex(new Lex(LexType.ws,"  "),l._next(true,3));
        assertLex(new Lex(LexType.label,"t"),l._next(false,0));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,1));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,2));
        assertLex(new Lex(LexType.eof,""),l._next(false,3));
    }        

    public void testNextIgnoreWS()
    {
        Lexer l = createLexer("  program\n  t=1");

        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
        assertLex(new Lex(LexType.label,"program"),l._next(false,1));
        assertLex(new Lex(LexType.nl,"\n"),l._next(false,2));
        assertLex(new Lex(LexType.ws,"  "),l._next(false,3));
        assertLex(new Lex(LexType.label,"t"),l._next(false,4));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,5));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,6));
        assertLex(new Lex(LexType.eof,""),l._next(false,7));
        
        l.setIgnoreWhitespace(true);
        
        assertLex(new Lex(LexType.label,"program"),l._next(false,0));
        assertLex(new Lex(LexType.nl,"\n"),l._next(false,1));
        assertLex(new Lex(LexType.label,"t"),l._next(false,2));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,3));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,4));
        assertLex(new Lex(LexType.eof,""),l._next(false,5));
        
        l.setIgnoreWhitespace(false);
        
        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
        assertLex(new Lex(LexType.label,"program"),l._next(false,1));
        assertLex(new Lex(LexType.nl,"\n"),l._next(false,2));
        assertLex(new Lex(LexType.ws,"  "),l._next(false,3));
        assertLex(new Lex(LexType.label,"t"),l._next(false,4));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,5));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,6));
        assertLex(new Lex(LexType.eof,""),l._next(false,7));

        l.setIgnoreWhitespace(true);
        
        assertLex(new Lex(LexType.label,"program"),l._next(true,0));
        assertLex(new Lex(LexType.nl,"\n"),l._next(true,0));

        assertLex(new Lex(LexType.label,"t"),l._next(false,0));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,1));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,2));
        assertLex(new Lex(LexType.eof,""),l._next(false,3));
        
        l.setIgnoreWhitespace(false);
        
        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
        assertLex(new Lex(LexType.label,"t"),l._next(false,1));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,2));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,3));
        assertLex(new Lex(LexType.eof,""),l._next(false,4));
    }        

    public void testConsumePastEOFConsumes()
    {
        Lexer l = createLexer("  program\n  t=1");
        assertLex(new Lex(LexType.eof,""),l._next(true,20));
        assertLex(new Lex(LexType.eof,""),l._next(true,0));
    }

    public void testNoConsumePastEOFDoesNotConsume()
    {
        Lexer l = createLexer("  program\n  t=1");
        assertLex(new Lex(LexType.eof,""),l._next(false,20));
        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
    }
    
    public void testNextConsume()
    {
        Lexer l = createLexer("  program\n  t=1");
        
        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
        assertLex(new Lex(LexType.ws,"  "),l._next(true,0));
        assertLex(new Lex(LexType.label,"program"),l._next(false,0));
        assertLex(new Lex(LexType.label,"program"),l._next(false,0));
        assertLex(new Lex(LexType.label,"program"),l._next(true,0));
        assertLex(new Lex(LexType.nl,"\n"),l._next(false,0));
        assertLex(new Lex(LexType.nl,"\n"),l._next(false,0));
        assertLex(new Lex(LexType.nl,"\n"),l._next(true,0));
        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
        assertLex(new Lex(LexType.ws,"  "),l._next(false,0));
        assertLex(new Lex(LexType.ws,"  "),l._next(true,0));
        assertLex(new Lex(LexType.label,"t"),l._next(false,0));
        assertLex(new Lex(LexType.label,"t"),l._next(false,0));
        assertLex(new Lex(LexType.label,"t"),l._next(true,0));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,0));
        assertLex(new Lex(LexType.comparator,"="),l._next(false,0));
        assertLex(new Lex(LexType.comparator,"="),l._next(true,0));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,0));
        assertLex(new Lex(LexType.integer,"1"),l._next(false,0));
        assertLex(new Lex(LexType.integer,"1"),l._next(true,0));
        assertLex(new Lex(LexType.eof,""),l._next(false,0));
        assertLex(new Lex(LexType.eof,""),l._next(true,0));
    }        

    
    public void testNext()
    {
        Lexer l = createLexer("  program\n");

        assertLex(ws("  "),l.next());
        assertLex(label("program"),l.next());
        assertLex(nl("\n"),l.next());
        assertLex(eof(),l.next());
    }

    public void testLookahead()
    {
        Lexer l = createLexer("  program\n");

        assertLex(ws("  "),l.lookahead());
        assertLex(ws("  "),l.lookahead(0));
        assertLex(label("program"),l.lookahead(1));
        assertLex(nl("\n"),l.lookahead(2));
        assertLex(eof(),l.lookahead(3));

        assertLex(ws("  "),l.next());
        assertLex(label("program"),l.lookahead());
        assertLex(nl("\n"),l.lookahead(1));
        assertLex(eof(),l.lookahead(2));
    }

    public void testSavepointsRollback()
    {
        Lexer l = createLexer("  program\n  compile('skip')   junk junk junk skip\n  t=1 skip");

        assertLex(ws("  "),l.next());
        assertLex(label("program"),l.next());
        assertLex(nl("\n"),l.next());
        
        int p1 = l.begin();
        assertLex(ws("  "),l.next());
        assertLex(label("compile"),l.next());
        assertLex(lparam(),l.next());
        assertLex(string("\"skip\""),l.next());
        assertLex(rparam(),l.next());
        
        int p2 = l.begin();
        
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        
        l.rollback(p2);
        
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        
        l.rollback(p1);
        
        assertLex(ws("  "),l.next());
        assertLex(label("compile"),l.next());
        assertLex(lparam(),l.next());
        assertLex(string("\"skip\""),l.next());
        assertLex(rparam(),l.next());
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        assertLex(ws(" "),l.next());
        assertLex(label("junk"),l.next());
        
    }

    public void testSavepointsCommitRollback()
    {
        Lexer l = createLexer("  program\n  compile('skip')   junk junk junk skip\n  t=1 skip");

        assertLex(ws("  "),l.next());
        assertLex(label("program"),l.next());
        assertLex(nl("\n"),l.next());
        
        int p1 = l.begin();
        assertLex(ws("  "),l.next());
        assertLex(label("compile"),l.next());
        assertLex(lparam(),l.next());
        assertLex(string("\"skip\""),l.next());
        assertLex(rparam(),l.next());
        
        int p2 = l.begin();
        
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        
        l.commit(p2);
        
        assertLex(ws(" "),l.next());
        assertLex(label("junk"),l.next());
        
        l.rollback(p1);
        
        assertLex(ws("  "),l.next());
        assertLex(label("compile"),l.next());
        assertLex(lparam(),l.next());
        assertLex(string("\"skip\""),l.next());
        assertLex(rparam(),l.next());
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        assertLex(ws(" "),l.next());
        assertLex(label("junk"),l.next());
        
    }

    public void testSavepointsCommitRollback2()
    {
        Lexer l = createLexer("  program\n  compile('skip')   junk junk junk skip\n  t=1 skip");

        assertLex(ws("  "),l.next());
        assertLex(label("program"),l.next());
        assertLex(nl("\n"),l.next());
        
        l.begin();
        assertLex(ws("  "),l.next());
        assertLex(label("compile"),l.next());
        assertLex(lparam(),l.next());
        assertLex(string("\"skip\""),l.next());
        assertLex(rparam(),l.next());
        
        l.begin();
        
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        
        l.commit();
        
        assertLex(ws(" "),l.next());
        assertLex(label("junk"),l.next());
        
        l.rollback();
        
        assertLex(ws("  "),l.next());
        assertLex(label("compile"),l.next());
        assertLex(lparam(),l.next());
        assertLex(string("\"skip\""),l.next());
        assertLex(rparam(),l.next());
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        assertLex(ws(" "),l.next());
        assertLex(label("junk"),l.next());
    }

    
    

    public void testSavepointsIncorrectRollback()
    {
        Lexer l = createLexer("  program\n  compile('skip')   junk junk junk skip\n  t=1 skip");

        assertLex(ws("  "),l.next());
        assertLex(label("program"),l.next());
        assertLex(nl("\n"),l.next());
        
        int p1 = l.begin();
        try {
            l.rollback(p1+1);
            fail();
        } catch (RuntimeException ex) { }
    }

    public void testSavepointsIncorrectCommit()
    {
        Lexer l = createLexer("  program\n  compile('skip')   junk junk junk skip\n  t=1 skip");

        assertLex(ws("  "),l.next());
        assertLex(label("program"),l.next());
        assertLex(nl("\n"),l.next());
        
        int p1 = l.begin();
        try {
            l.commit(p1+1);
            fail();
        } catch (RuntimeException ex) { }
    }
    
    
    public void testSavepointsRollbackCommit()
    {
        Lexer l = createLexer("  program\n  compile('skip')   junk junk junk skip\n  t=1 skip");

        assertLex(ws("  "),l.next());
        assertLex(label("program"),l.next());
        assertLex(nl("\n"),l.next());
        
        int p1 = l.begin();
        assertLex(ws("  "),l.next());
        assertLex(label("compile"),l.next());
        assertLex(lparam(),l.next());
        assertLex(string("\"skip\""),l.next());
        assertLex(rparam(),l.next());
        
        int p2 = l.begin();
        
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        
        l.rollback(p2);
        l.commit(p1);
        
        assertLex(ws("   "),l.next());
        assertLex(label("junk"),l.next());
        assertLex(ws(" "),l.next());
        assertLex(label("junk"),l.next());
        
    }
    
    
    public void testInclude()
    {
        Lexer l = createLexer("  program\n  compile('skip')   junk junk junk skip\n  t=1 skip");
        assertLex(l,
                new Lex(LexType.ws,"  "),
                new Lex(LexType.label,"program"),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.ws,"  "),
                new Lex(LexType.label,"compile"),
                new Lex(LexType.lparam,"("),
                new Lex(LexType.string,"\"skip\""),
                new Lex(LexType.rparam,")")
                );
        
        l.addIncludeMarker("skip");
        
        assertLex(l,
                new Lex(LexType.ws,"   "),
                new Lex(LexType.label,"junk"),
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"junk"),
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"junk"),
                new Lex(LexType.ws," "),
                new Lex(LexType.nl,"\n"),
                new Lex(LexType.ws,"  "),
                new Lex(LexType.label,"t"),
                new Lex(LexType.comparator,"="),
                new Lex(LexType.integer,"1"),
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"skip"),
                new Lex(LexType.eof,"")
                );
    }

    public void testNestedInclude()
    {
        Lexer l = createLexer("i1 junk i2 junk2 i2 junk3 i1 i2 i1");

        assertLex(l,
                new Lex(LexType.label,"i1"));
        l.addIncludeMarker("i1");
        
        assertLex(l,
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"junk"),
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"i2")
        );
        l.addIncludeMarker("i2");
        
        assertLex(l,
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"junk2"),
                new Lex(LexType.ws," "),
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"junk3"),
                new Lex(LexType.ws," "),
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"i2"),
                new Lex(LexType.ws," "),
                new Lex(LexType.label,"i1"),
                new Lex(LexType.eof,"")
        );
        
    }
    
    public Lexer createLexer(String token)
    {
        Reader r = new CharArrayReader(token.toCharArray());
        Lexer l = new Lexer(r);
        return l;
    }
    
    public void assertLex(String token,Lex... lex) {
        Lexer l =  createLexer(token);
        assertLex(l,lex);
        assertTrue(l.eof());
    }
        
    public void assertLex(Lexer l,Lex... lex) {
        for ( Lex tlex : lex ) {
            Lex next = l._next();
            assertNotNull(tlex.toString(),next);
            assertSame(tlex.toString(),tlex.type,next.type);
            assertEquals(tlex.toString(),tlex.value,next.value);
        }
    }

    public void assertLex(Lex alex[],Lex... lex) {
        int scan=0;
        for ( Lex tlex : lex ) {
            Lex next = alex[scan++];
            assertNotNull(tlex.toString(),next);
            assertSame(tlex.toString(),tlex.type,next.type);
            assertEquals(tlex.toString(),tlex.value,next.value);
        }
    }
    
    public void assertLex(Lex left,Lex right) {
        assertNotNull(left.toString(),right);
        assertSame(left.toString(),left.type,right.type);
        assertEquals(left.toString(),left.value,right.value);
    }

    public static Lex ws(String value)
    {
        return new Lex(LexType.ws,value);
    }
    
    public static Lex nl(String value)
    {
        return new Lex(LexType.nl,value);
    }

    public static Lex label(String value)
    {
        return new Lex(LexType.label,value);
    }

    public static Lex comparator(String value)
    {
        return new Lex(LexType.comparator,value);
    }

    public static Lex integer(String value)
    {
        return new Lex(LexType.integer,value);
    }

    public static Lex decimal(String value)
    {
        return new Lex(LexType.decimal,value);
    }

    public static Lex string(String value)
    {
        return new Lex(LexType.string,value);
    }

    public static Lex eof()
    {
        return new Lex(LexType.eof,"");
    }

    public static Lex lparam()
    {
        return new Lex(LexType.lparam,"(");
    }

    public static Lex rparam()
    {
        return new Lex(LexType.rparam,")");
    }

    
}
