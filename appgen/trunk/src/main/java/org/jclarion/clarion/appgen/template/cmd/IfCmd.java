package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;

public class IfCmd extends ConditionalCmd
{
	private static class TestBlock extends TemplateItem implements StatementBlock
	{
		private CExpr test;
		private List<Statement> code=new ArrayList<Statement>();
		
		public TestBlock(CExpr test)
		{
			this.test=test;
		}
		
		@Override
		public void addStatement(Statement stmt) {
			code.add(stmt);
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
		
		
		TestBlock current = new TestBlock(getTest());
		testBlocks.add(current);
		
		while ( true ) {
			TemplateItem ti = parser.read();
			
			if (ti instanceof ConditionalCmd) {
				ConditionalCmd cc = (ConditionalCmd)ti;
				if (cc.getItemType().equals("#ELSIF")) {
					cc.consume(parser, null);
					current = new TestBlock(cc.getTest());
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
				
			if (ti instanceof EndCmd && ((EndCmd)ti).isEnd("#ENDIF")) {
				ti.consume(parser, this);
				break;
			}
			
			ti.consume(parser, current);
		}
		
		((StatementBlock)parent).addStatement(this);
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		for (TestBlock tb : testBlocks) {
			if (scope.eval(tb.test).boolValue()) {
				return scope.runBlock(tb.code);
			}
		}
		if (elseBlock!=null) {
			return scope.runBlock(elseBlock);
		}
		return CodeResult.OK;
	}
	
	public CodeResult debug(ExecutionEnvironment scope) 
	{
		for (TestBlock tb : testBlocks) {
			ClarionObject ev = scope.eval(tb.test);
			debug(" EVAL "+ev);
			if (ev.boolValue()) {
				return scope.runBlock(tb.code);
			}
		}
		if (elseBlock!=null) {
			debug(" ELSE ");
			return scope.runBlock(elseBlock);
		}
		return CodeResult.OK;
	}
	
}
