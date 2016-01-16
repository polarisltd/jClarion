package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.MultiSymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ForCmd extends Statement implements StatementBlock
{

	private String symbol;
	private CExpr where;
	private boolean reverse;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("REVERSE")) {
			reverse=true;
			return;
		}
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#FOR") && params.size()==1) {
			this.symbol=params.get(0).getString();
			return;
		}
		if (name.equals("WHERE") && params.size()==1) {
			this.where=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}

	public String getSymbol() {
		return symbol;
	}

	public CExpr getWhere() {
		return where;
	}

	public boolean isReverse() {
		return reverse;
	}

	@Override
	public String toString() {
		return "ForCmd [symbol=" + symbol + ", where=" + where + ", reverse="
				+ reverse + "]";
	}

	private List<Statement> code=new ArrayList<Statement>();

	@Override
	public void addStatement(Statement stmt) {
		code.add(stmt);
	}

	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException 
	{
		while ( true ) {
			TemplateItem ti = parser.read();
			ti.consume(parser, this);
			
			if (ti instanceof EndCmd && ((EndCmd)ti).isEnd("#ENDFOR")) {
				break;
			}
		}
		((StatementBlock)parent).addStatement(this);
	}
	
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		SymbolEntry se = scope.getScope().get(symbol);
		if (se==null) scope.error("Could not find symbol:"+symbol);
		MultiSymbolEntry list = se.list();
		if (list==null) scope.error("Symbol is not a list:"+symbol+" "+se.getClass());
		ListSymbolValue val = list.values();
		if (val==null) scope.error("Symbol list not defined:"+symbol);
		ListScanner ls = val.loop(reverse);
		while (ls.next()) {
			if (where!=null && !scope.eval(where).boolValue()) continue;
			CodeResult cr = scope.runBlock(code);
			if (cr==CodeResult.BREAK) return CodeResult.OK;
			if (cr.getCode()==CodeResult.CODE_RETURN) return cr;			
			
			
			if (val!=list.list().values()) {
				throw new IllegalStateException("Dependent multi was yanked from underneath us. Waaahhh! "+symbol);
			}
		}
		return CodeResult.OK;
	}			
	

	
}
