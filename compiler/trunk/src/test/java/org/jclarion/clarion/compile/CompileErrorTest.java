package org.jclarion.clarion.compile;

import java.io.CharArrayReader;

import org.jclarion.clarion.compile.grammar.AccumulatingClarionCompileError;
import org.jclarion.clarion.compile.grammar.AccumulatingErrorCollator;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.lang.Lexer;

/**
 * Test behaviour when compiler encounters a syntax error. Eventually we want to implement the compiler so it does not fail fast instead it reaps as many errors as
 * it can.
 * 
 * @author barney
 */
public class CompileErrorTest extends CompileTestHelper
{
	private AccumulatingErrorCollator errors;



	public void setUp()
	{
		super.setUp();
		errors=new AccumulatingErrorCollator();
		compiler.setErrorCollator(errors);
	}
	
	public void testSingleError()
	{		
		doCompile(
				" program\n",
				"tid long\n",
				"  code\n",
				"  tid=tid+x\n",
				"");
		
		assertEquals(1,errors.getErrors().size());
		AccumulatingErrorCollator.Entry entry = errors.getErrors().iterator().next();
		assertEquals(4,entry.getLineNumber());
		assertEquals("Expected expression",entry.getMessage());
		
	}

	public void testManyErrors()
	{		
		doCompile(
				" program\n",
				"tid long\n",
				"  code\n",
				"  if tid=0\n",
				"     tid=x\n",
				"  .\n",
				"  x=1\n",
				"");
		
		assertEquals(2,errors.getErrors().size());
		AccumulatingErrorCollator.Entry entry;
		
		entry = errors.getErrors().get(0);
		assertEquals(5,entry.getLineNumber());
		assertEquals("Undefined Naked Expression",entry.getMessage());
		
		entry = errors.getErrors().get(1);
		assertEquals(7,entry.getLineNumber());
		assertEquals("Expected eof",entry.getMessage());
	}
	
	public void testManyErrorsOnComplexStructure()
	{		
		doCompile(
				" program\n",
				"tid long\n",
				"  code\n",
				"  loop\n",
				"     if field()=1 then message('yes!').\n",
				"     if tid=tidx then break.\n",
				"  .\n",
				"  tid=2\n",
				"  tid=tid+noSuchProcedure\n",
				"");
		
		assertEquals(2,errors.getErrors().size());
		AccumulatingErrorCollator.Entry entry;
		
		entry = errors.getErrors().get(0);
		assertEquals(6,entry.getLineNumber());
		assertEquals("Expect '.' or 'end'",entry.getMessage());
		
		entry = errors.getErrors().get(1);
		assertEquals(9,entry.getLineNumber());
		assertEquals("Expected expression",entry.getMessage());
	}
		
	
	private void doCompile(String ...source)
	{
        System.setProperty("clarion.compile.forceHardAssert","1");
        Lexer l  = new Lexer(new CharArrayReader(get(source).toCharArray()));
        try {
            Parser p = new Parser(compiler,l);
            p.compileProgram(true);
        } catch (AccumulatingClarionCompileError ex) { 
        	ex.printStackTrace();
        } finally {
            System.clearProperty("clarion.compile.forceHardAssert");
        } 		
	}

}
