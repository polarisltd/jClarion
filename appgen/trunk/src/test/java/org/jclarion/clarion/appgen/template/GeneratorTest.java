package org.jclarion.clarion.appgen.template;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;

import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.AppLoader;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.DictLoader;

import junit.framework.TestCase;

public class GeneratorTest extends TestCase 
{
	public void testCaseOne() throws IOException
	{
		App a = (new AppLoader()).loadApplication("src/test/resources/generator/sampleapp.txa");
		TemplateChain tc = new TemplateChain();
		(new TemplateLoader(tc)).load("src/test/resources/generator/","test_1.tpl");
		Dict d = (new DictLoader()).loadDictionary("src/test/resources/generator/sampleapp.txd");
		ExecutionEnvironment gt = new ExecutionEnvironment(tc,a,d);
		gt.generate();
	}

	public void testABCGenService() throws IOException
	{
		App a = (new AppLoader()).loadApplication("src/test/resources/generator/sampleapp.txa");
		TemplateChain tc = new TemplateChain();
		(new TemplateLoader(tc)).load("src/test/resources/generator/","abcgen.tpl");
		Dict d = (new DictLoader()).loadDictionary("src/test/resources/generator/sampleapp.txd");
		ExecutionEnvironment gt = new ExecutionEnvironment(tc,a,d);
		gt.setLibSrc("src/test/resources/libsrc/");
		gt.setTarget("target/");
		//long start=System.currentTimeMillis();
		gt.generate();
		//long end=System.currentTimeMillis();
		//System.out.println(end-start);
		
		BufferedReader base = new BufferedReader(new FileReader("src/test/resources/generator/abcgen.txt"));
		BufferedReader test = new BufferedReader(new FileReader("target/test.txt"));
		int line=0;
		
		while ( true ) {
			line++;
			String t1 = base.readLine();
			String t2 = test.readLine();
			assertFalse("Line "+line,t1==null ^ t2==null);
			if (t1==null) break;
			if (t1.contains("IncFile")) {
				t1=t1.toLowerCase();
				t2=t2.toLowerCase();
			}
			assertEquals("Line #"+line,t1,t2);
		}
		base.close();
		test.close();
		File f=  new File("test.txt");
		f.delete();
	}
	
	public void testCaseTwo() throws IOException
	{
		App a = (new AppLoader()).loadApplication("src/test/resources/generator/sampleapp.txa");
		TemplateChain tc = new TemplateChain();
		(new TemplateLoader(tc)).load("src/test/resources/generator/","test_2.tpl");
		Dict d = (new DictLoader()).loadDictionary("src/test/resources/generator/sampleapp.txd");
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		PrintStream old=System.out;
		System.setOut(new PrintStream(baos));
		try {
			ExecutionEnvironment gt = new ExecutionEnvironment(tc,a,d);
			gt.generate();
		} finally {
			System.setOut(old);			
		}
		String result = new String(baos.toByteArray());
		assertEquals(" Here is some test code\n"+
				"      Parent: Apple Child: Sweet Grandchild: Some Value:0\n"+
				"      Parent: Apple Child: Red Grandchild: Some Value:1\n"+
				"      Parent: Apple Child: Fruit Grandchild: Some Value:2\n"+
				"      Parent: Pear Child: Hard Grandchild: Some Value:12\n"+
				"      Parent: Pear Child: Orange Grandchild: Some Value:13\n"+
				"      Parent: Pear Child: Fruit Grandchild: Some Value:14\n"+
				"      Parent: Pear Child: Hard Grandchild: Some Value:12\n"+
				"      Parent: Pear Child: Orange Grandchild: Some Value:13\n"+
				"      Parent: Pear Child: Fruit Grandchild: Some Value:14\n"+
				"      Parent: Banana Child: Radioactive Grandchild: Some Value:6\n"+
				"      Parent: Banana Child: Yellow Grandchild: Some Value:7\n"+
				"      Parent: Banana Child: Fruit Grandchild: Some Value:8\n"+
				"      Parent: Pear Child: Hard Grandchild: Some Value:12\n"+
				"      Parent: Pear Child: Orange Grandchild: Some Value:13\n"+
				"      Parent: Pear Child: Fruit Grandchild: Some Value:14\n"+
				"      Parent: Pear Child: Hard Grandchild: Some Value:12\n"+
				"      Parent: Pear Child: Orange Grandchild: Some Value:13\n"+
				"      Parent: Pear Child: Fruit Grandchild: Some Value:14\n",result);
	}

	public void testAssert() throws IOException
	{
		try {
			assertTemplate("assert.tpl");
			fail("Did not fail");
		} catch (TemplateExecutionError tee) {
			assertEquals("This test should fail @3@assert.tpl",tee.getMessage());
		}
	}
	
	public void testDeclare() throws IOException
	{
		assertTemplate("declare.tpl");
	}
	public void testCache() throws IOException
	{
		assertTemplate("cache.tpl");
	}

	public void testCache2() throws IOException
	{
		assertTemplate("cache2.tpl");
	}

	public void testCache3() throws IOException
	{
		assertTemplate("cache3.tpl");
	}
	
	public void testAdd() throws IOException
	{
		assertTemplate("add.tpl");
	}

	public void testAddFix() throws IOException
	{
		assertTemplate(
				"  1 some child\n"+
				"  2 \n"+
				"  3 some other child\n"+
				"  4 \n"
				,"addfix.tpl");
	}

	public void testCall() throws IOException
	{
		assertTemplate("call.tpl");
	}

	public void testCase() throws IOException
	{
		assertTemplate("case.tpl");
	}

	public void testPreserve() throws IOException
	{
		assertTemplate(""+
				"Franch PSI:email Franch PSI:email PSI:email\n"+
				"Franch PSI:email invitem  PSI:email\n"+
				"invitem  invitem  \n"+
				"","preserve.tpl");
	}

	public void testClear() throws IOException
	{
		assertTemplate("clear.tpl");
	}

	public void testIO() throws IOException
	{
		assertTemplate("io.tpl");
	}

	public void testLoop() throws IOException
	{
		assertTemplate("loop.tpl");
	}

	public void testFind() throws IOException
	{
		assertTemplate("find_nest.tpl");
	}

	public void testFindSystem() throws IOException
	{
		assertTemplate("find_system.tpl");
	}

	public void testFindMultiDimensionsal() throws IOException
	{
		assertTemplate("find_multi.tpl");
	}
	
	public void testFor() throws IOException
	{
		assertTemplate("for.tpl");
	}

	public void testForFix() throws IOException
	{
		assertTemplate("forfix.tpl");
	}

	public void testFree() throws IOException
	{
		assertTemplate("free.tpl");
	}

	public void testIf() throws IOException
	{
		assertTemplate("if.tpl");
	}

	public void testInsert() throws IOException
	{
		assertTemplate("insert.tpl");
	}

	public void testInvoke() throws IOException
	{
		assertTemplate("invoke.tpl");
	}
	
	public void testRelateSymbols() throws IOException
	{
		 String result = "Accnt[AC:PrimaryKey] <=> invhead[ivh:CLIENT_KEY] 1:MANY\n"+
			"AC:ID : ivh:CLIENT\n"+
			" : ivh:INVOICE\n"+
			"ivh:CLIENT : AC:ID\n"+
			"invitem[ivl:INV_KEY] <=> invhead[ivh:INV_KEY] MANY:1\n"+
			"ivl:INVOICE : ivh:INVOICE\n"+
			"ivh:INVOICE : ivl:INVOICE\n"+
			" : ivl:clid\n"+
			"invhead[ivh:CLIENT_KEY] <=> Accnt[AC:PrimaryKey] MANY:1\n"+
			"ivh:CLIENT : AC:ID\n"+
			"AC:ID : ivh:CLIENT\n"+
			" : ivh:INVOICE\n"+
			"invhead[ivh:INV_KEY] <=> invitem[ivl:INV_KEY] 1:MANY\n"+
			"ivh:INVOICE : ivl:INVOICE\n"+
			" : ivl:clid\n"+
			"ivl:INVOICE : ivh:INVOICE\n"+
			"";
		
		 assertTemplate(result,"relation.tpl");
	}

	public void testQuery() throws IOException
	{
		assertTemplate(
				"Test 1\n"+
				"1\n"+
				"3\n"+
				"5\n"+
				"Test 2\n"+
				"Test 3\n"+
				"1\n"+
				"2\n"+
				"3\n"+
				"4\n"+
				"5\n"
			,"query.tpl");
	}

	public void testSuspend() throws IOException
	{
		assertTemplate(
				"Test 1\n"+
				"1\n"+
				"3\n"+
				"5\n"+
				"Test 2\n"+
				"1\n"+
				"2\n"+
				"3\n"+
				"4\n"+
				"Test 3\n"+
				"1\n"+
				"3\n"+
				"5\n"+
				"Test 4\n"+
			"","suspend.tpl");
	}

	public void testReplace() throws IOException
	{
		assertTemplate("replace.tpl");
	}

	public void testSection() throws IOException
	{
		assertTemplate("baz\nfoo bar\n","section.tpl");
	}

	public void testDictSymbols() throws IOException
	{
		assertTemplate("dict_symbols.tpl");
	}

	public void testAppSymbols() throws IOException
	{
		assertTemplate("app_symbols.tpl");
	}

	public void testLocalData() throws IOException
	{
		assertTemplate(""+				
				"CurrentTab           STRING(80)\n"+
				"ActionMessage        CSTRING(40)\n"+
				"tCurrent             DECIMAL(8,2)\n"+
				"MyAccount            CLASS(C8:Accounts)\n"+
				"                     END\n"+
				"ccDetails            BYTE\n"+
				"CreditCard           STRING(20)\n"+
				"","localdata.tpl");
	}

	public void testCallInsertDiffs() throws IOException
	{
		assertTemplate("callscope.tpl");
	}

	public void testIndent() throws IOException
	{
		assertTemplate(""+
				"output flat 0\n"+
				"nested output flat 0\n"+
				"  nested output indented again 2\n"+
				"nested output with noindent 0\n"+
				"nested output flat 0\n"+
				"  output indented 2\n"+
				"  nested output flat 2\n"+
				"    nested output indented again 4\n"+
				"  nested output with noindent 2\n"+
				"  nested output flat 2\n"+				
				"","indent.tpl");
	}
	
	public void testBuiltins() throws IOException
	{
		assertTemplate("builtins.tpl");
	}
	
	public void assertTemplate(String file) throws IOException
	{
		assertTemplate("",file);
	}

	public void assertTemplate(String output,String file) throws IOException
	{
		App a = (new AppLoader()).loadApplication("src/test/resources/generator/sampleapp.txa");
		Dict d = (new DictLoader()).loadDictionary("src/test/resources/generator/sampleapp.txd");
		TemplateChain tc = new TemplateChain();
		(new TemplateLoader(tc)).load("src/test/resources/generator/testcase/",file);
		
		StringBuilder sb = new StringBuilder();
		
		ExecutionEnvironment gt = new ExecutionEnvironment(tc,a,d);
		gt.setStopOnError(true);
		gt.setTarget("target/");
		gt.setDefaultStream(sb);
		gt.generate();
		assertEquals(output,sb.toString());
	}

	
}
