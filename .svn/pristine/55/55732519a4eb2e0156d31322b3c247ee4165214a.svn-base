package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ButtonCmd extends AbstractWidgetContainer
{

	private AtParam at;
	private CExpr text;
	private boolean required;
	private boolean inline;
	private boolean sort;
	private CExpr whenAcceptedExpr;
	private CExpr where;
	private boolean isFrom;
	private CExpr expression;
	private String symbol;
	private boolean isMulti;
	private String icon;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("REQ")) {
			required=true;
			return;
		}
		if (flag.equals("INLINE")) {
			inline=true;
			return;
		}
		if (flag.equals("SORT")) {
			sort=true;
			return;
		}
		throw new ParseException("Unknown");
	}
	
	

	@Override
	protected void initSetting(TemplateParser parser, String value, Lexer l) throws ParseException {
		/*if (value.equals("WHENACCEPTED")) {
			whenAccepted=getCallParam(l);
			return;
		}*/
		super.initSetting(parser, value, l);
	}



	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("AT")) {
			at=new AtParam(params);
			return;
		}
		if (name.equals("HLP")) return;
		if (name.equals("#BUTTON") && params.size()>=1 && params.size()<=2) {
			text=params.get(0).getExpression();
			if (params.size()==2) {
				icon = params.get(1).getString();
			}
			return;
		}
		if (name.equals("FROM") && params.size()==2) {
			isFrom=true;
			symbol = params.get(0).getString();
			expression=params.get(0).getExpression();
			return;
		}
		if (name.equals("MULTI") && params.size()==2) {
			isMulti=true;
			symbol = params.get(0).getString();
			expression=params.get(1).getExpression();
			return;
		}
		if (name.equals("WHERE") && params.size()==1) {
			where=params.get(0).getExpression();
			return;
		}
		if (name.equals("WHENACCEPTED") && params.size()==1) {
			whenAcceptedExpr=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown "+name);
	}



	public AtParam getAt() {
		return at;
	}



	public CExpr getText() {
		return text;
	}

	public String getIcon() {
		return icon;
	}


	public boolean isRequired() {
		return required;
	}



	public boolean isInline() {
		return inline;
	}



	public boolean isSort() {
		return sort;
	}



	public CExpr getWhenAccepted() {
		return whenAcceptedExpr;
	}



	public CExpr getWhere() {
		return where;
	}



	public boolean isFrom() {
		return isFrom;
	}



	public CExpr getExpression() {
		return expression;
	}



	public String getSymbol() {
		return symbol;
	}



	public boolean isMulti() {
		return isMulti;
	}



	@Override
	public String toString() {
		return "ButtonCmd [at=" + at + ", text=" + text + ", required="
				+ required + ", inline=" + inline + ", sort=" + sort
				+ ", whenAccepted=" + whenAcceptedExpr + ", where=" + where
				+ ", isFrom=" + isFrom + ", expression=" + expression
				+ ", symbol=" + symbol + ", isMulti=" + isMulti + "]";
	}



	@Override
	protected String endType() {
		return "#ENDBUTTON";
	}



	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return environment.eval(text).toString();
	}
	
	public void prime(ExecutionEnvironment scope)
	{
		if (isMulti()) return;
		super.prime(scope);
	}	
	
	@Override
	public void declare(UserSymbolScope scope,SymbolList dependents)
	{
		if ((isMulti() || isFrom()) && symbol!=null) {
			if (scope.get(symbol)==null) {
				String type="DEFAULT";
				if (isMulti()) {
					type="LONG";
				}
				ValueType vt = ValueType.multi;
				if (isSort()) {
					vt = ValueType.unique;
				}
				
				scope.declare(symbol,type,vt,dependents.asArray()).setWidget(this);
			}
		
			dependents.add(scope.get(symbol));
		}
		
		super.declare(scope, dependents);
		
		if ((isMulti() || isFrom()) && symbol!=null) {
			dependents.remove();
		}
	}	
	
}

