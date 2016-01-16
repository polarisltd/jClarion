package org.jclarion.clarion.appgen.template;

import java.io.IOException;

import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;

import junit.framework.TestCase;

public class SourceLineTest extends TestCase {

	public void testSimpleEncode() throws IOException
	{
		
		ExecutionEnvironment ee = new ExecutionEnvironment();
		UserSymbolScope scope = new UserSymbolScope("test");
		
		
		
		ee.pushBaseScope(scope);
		scope.declare("%procedure",false).scalar().setValue(SymbolValue.construct("SomeFunction"));
		scope.declare("%parameters",false).scalar().setValue(SymbolValue.construct("()"));
		
		BufferedWriteTarget t=new BufferedWriteTarget();
		
		SourceLine sl;
		
		t.reset();
		sl = new SourceLine("%[20]Procedure PROCEDURE  %Parameters         #<! Declare Procedure",false);
		sl.render(ee,t);
		
		assertEquals("SomeFunction         PROCEDURE  ()               ! Declare Procedure",t.getBuffer());

		t.reset();
		sl = new SourceLine("%[20]Procedure PROCEDURE                      #<! Declare Procedure",false);
		sl.render(ee,t);
		
		assertEquals("SomeFunction         PROCEDURE                   ! Declare Procedure",t.getBuffer());
	}
}
