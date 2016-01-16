package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;

public class CaseCmd extends ConditionalCmd
{
	private static class TestBlock extends TemplateItem implements StatementBlock
	{
		private List<CExpr> 	test=new ArrayList<CExpr>();
		private List<Statement> code=new ArrayList<Statement>();
		
		public TestBlock(CExpr test)
		{
			this.test.add(test);
		}
		
		@Override
		public void addStatement(Statement stmt) {
			code.add(stmt);
		}

		public void addTest(CExpr test) {
			this.test.add(test);
		}
		
		@Override
		public String getItemType() {
			return "IfBlock";
		}

		@Override
		public CodeResult run(ExecutionEnvironment scope) {
			return scope.runBlock(code);
		}
	}

	private List<TestBlock> testBlocks = new ArrayList<TestBlock>();
	private List<Statement> elseBlock = null;
	
	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException {
		
		TestBlock current=null;
		
		//TestBlock current = new TestBlock(getTest());
		//testBlocks.add(current);
		
		while ( true ) {
			TemplateItem ti = parser.read();
			
			if (ti instanceof ConditionalCmd) {
				ConditionalCmd cc = (ConditionalCmd)ti;
				if (cc.getItemType().equals("#OF")) {
					cc.consume(parser, null);
					current = new TestBlock(cc.getTest());
					testBlocks.add(current);
					continue;
				}
				
				if (cc.getItemType().equals("#OROF")) {
					cc.consume(parser, null);
					if (!current.code.isEmpty()) {
						parser.getReader().error("Cannot handle statements between OF and OROF");
					}
					current.addTest(cc.getTest());
					testBlocks.add(current);
					continue;
				}				
			}
			
			if (ti instanceof ElseCmd) {
				current=new TestBlock(null);
				elseBlock=current.code;
				ti.consume(parser,null);
				continue;
			}
				
			if (ti instanceof EndCmd && ((EndCmd)ti).isEnd("#ENDCASE")) {
				ti.consume(parser, this);
				break;
			}
			
			ti.consume(parser, current);
		}
		
		((StatementBlock)parent).addStatement(this);
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		ClarionObject r = scope.eval(getTest());
		for (TestBlock tb : testBlocks) {
			for (CExpr test : tb.test) {
				if (scope.eval(test).equals(r)) {
					return scope.runBlock(tb.code);
				}
			}
		}
		if (elseBlock!=null) {
			return scope.runBlock(elseBlock);
		}
		return CodeResult.OK;
	}
}
