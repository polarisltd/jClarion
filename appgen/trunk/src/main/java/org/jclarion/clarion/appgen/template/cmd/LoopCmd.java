package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class LoopCmd extends Statement implements StatementBlock
{

	public static enum Type {
		WHILE, UNTIL, FOR, TIMES, INFINITE;
	}
	
	private Type type=Type.INFINITE;
	private CExpr expression;
	
	private String counter;
	private CExpr start;
	private CExpr end;
	private CExpr step;
	
	private CExpr times;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}
	

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#LOOP") && params.size()==0) {
			return;
		}

		if (name.equals("UNTIL") && params.size() == 1) {
			type = Type.UNTIL;
			expression = params.get(0).getExpression();
			return;
		}
		if (name.equals("WHILE") && params.size() == 1) {
			type = Type.WHILE;
			expression = params.get(0).getExpression();
			return;
		}
		if (name.equals("FOR") && params.size() == 3) {
			type = Type.FOR;
			counter = params.get(0).getString();
			start = params.get(1).getExpression();
			end = params.get(2).getExpression();
			return;
		}
		if (name.equals("TIMES") && params.size() == 1) {
			type = Type.TIMES;
			times = params.get(0).getExpression();
			return;
		}
		
		if (type==Type.FOR && name.equals("BY") && params.size()==1) {
			step=params.get(0).getExpression();
			return;
		}
		
		throw new ParseException("Unknown "+name+" "+type);
	}

	public Type getType() {
		return type;
	}

	public CExpr getExpression() {
		return expression;
	}

	public String getCounter() {
		return counter;
	}

	public CExpr getStart() {
		return start;
	}

	public CExpr getEnd() {
		return end;
	}

	public CExpr getStep() {
		return step;
	}

	public CExpr getTimes() {
		return times;
	}

	@Override
	public String toString() {
		return "LoopCmd [type=" + type + ", expression=" + expression
				+ ", counter=" + counter + ", start=" + start + ", end=" + end
				+ ", step=" + step + ", times=" + times + "]";
	}

	private List<Statement> statements=new ArrayList<Statement>();

	@Override
	public void addStatement(Statement stmt) {
		statements.add(stmt);
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		if (type==Type.INFINITE) {
			while ( true ) {
				CodeResult cr = scope.runBlock(statements);
				if (cr==CodeResult.BREAK) return CodeResult.OK;
				if (cr.getCode()==CodeResult.CODE_RETURN) return cr;
			}			
		}
		
		if (type==Type.TIMES) {
			int times = scope.eval(this.times).intValue();
			for (int scan=0;scan<times;scan++) {
				CodeResult cr = scope.runBlock(statements);
				if (cr==CodeResult.BREAK) return CodeResult.OK;
				if (cr.getCode()==CodeResult.CODE_RETURN) return cr;				
			}
			return CodeResult.OK;
		}
		
		if (type==Type.FOR) {
			SymbolEntry se = scope.getScope().get(counter);
			boolean created=false;
			try {
				if (se == null) {
					created = true;
					se = scope.getScope().declare(counter, "LONG",ValueType.scalar);
				}
				int start = scope.eval(this.start).intValue();
				int end = scope.eval(this.end).intValue();
				int step = 1;
				if (this.step != null) {
					step = scope.eval(this.step).intValue();
				}

				while (true) {
					if (step > 0 && start > end) break;
					if (step < 0 && start < end) break;
					se.scalar().setValue(SymbolValue.construct(start));

					CodeResult cr = scope.runBlock(statements);
					if (cr == CodeResult.BREAK) return CodeResult.OK;
					if (cr.getCode() == CodeResult.CODE_RETURN) return cr;

					start = start + step;
				}
				return CodeResult.OK;
			} finally {
				if (created) {
					scope.getScope().remove(counter);
				}
			}
		}
		
		if (type==Type.WHILE || type==Type.UNTIL) {
			while (true) {
				if (type==Type.WHILE && !scope.eval(expression).boolValue()) return CodeResult.OK;
				if (type==Type.UNTIL && scope.eval(expression).boolValue()) return CodeResult.OK;
				CodeResult cr = scope.runBlock(statements);
				if (cr==CodeResult.BREAK) return CodeResult.OK;
				if (cr.getCode()==CodeResult.CODE_RETURN) return cr;				
			}
		}

		throw new IllegalStateException("Unknown");
	}			
	

	
	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException 
	{
		while ( true ) {
			TemplateItem ti = parser.read();
			ti.consume(parser, this);
			
			if (ti instanceof EndCmd && ((EndCmd)ti).isEnd("#ENDLOOP")) {
				break;
			}
		}
		((StatementBlock)parent).addStatement(this);
	}
	
}
