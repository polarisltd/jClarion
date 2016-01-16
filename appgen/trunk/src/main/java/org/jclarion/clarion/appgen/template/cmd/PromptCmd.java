package org.jclarion.clarion.appgen.template.cmd;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;

/**
 * Represent a #PROMPT template control.
 * 
 * 
 * @author barney
 * 
 */
public class PromptCmd extends Widget
{
	private CExpr text;
	private String type;
	private List<Parameter> typeParams;
	private boolean required;
	private boolean multi;
	private boolean unique;
	private boolean inline;
	private boolean choice;
	private boolean hscroll;
	private Parameter def;
	private String icon;
	private AtParam at;
	private AtParam promptat;
	private String multiDescription;
	private String value;
	private String symbol;
	private CExpr whenAccepted;

	
	protected boolean caseSensitiveSettings()
	{
		return true;
	}
	
	@Override
	protected void initCommand(TemplateParser parser, CommandLine line, Lexer l) throws ParseException {
		if (l.next().type!=LexType.lparam) throw new ParseException("Expected (");
		Parser p = new Parser(l);
		text=p.expr(null);
		if (l.lookahead().type==LexType.param){
			l.next();
			type=l.next().value;
			typeParams=popParams(l);
		}
		if (l.next().type!=LexType.rparam) throw new ParseException("Expected )");
	}

	@Override
	public void initFlag(String iflag) throws ParseException {
		
		String flag=iflag.toUpperCase();
		
		if (flag.equalsIgnoreCase("REQ")) {
			required=true;
			return;
		}
		if (flag.equalsIgnoreCase("MULTI")) {
			multi=true;
			return;
		}
		if (flag.equalsIgnoreCase("UNIQUE")) {
			unique=true;
			return;
		}
		if (flag.equalsIgnoreCase("INLINE")) {
			inline=true;
			return;
		}
		if (flag.equalsIgnoreCase("HSCROLL")) {
			hscroll=true;
			return;
		}
		if (flag.equalsIgnoreCase("CHOICE")) {
			choice=true;
			return;
		}
		
		if (flag.startsWith("%")) {
			symbol=iflag;
			return;
		}
		
		throw new ParseException("Unknown flag:"+flag);
	}

	public boolean isHscroll() {
		return hscroll;
	}

	@Override
	public void initSetting(String iname, List<Parameter> params) throws ParseException {
		
		String name=iname.toUpperCase();
		
		if (name.equals("DEFAULT") && params.size()==1) {
			def=params.get(0);
			return;
		}

		if (name.equals("ICON") && params.size()==1) {
			icon=params.get(0).getString();
			return;
		}

		if (name.equals("AT")) {
			at=new AtParam(params);
			return;
		}

		if (name.equals("PROMPTAT")) {
			promptat=new AtParam(params);
			return;
		}

		if (name.equals("WHENACCEPTED")) {
			whenAccepted=params.get(0).getExpression();
			return;
		}

		if (name.equals("MULTI") && params.size()==1) {
			multi=true;
			multiDescription=params.get(0).getString();
			return;
		}
		
		if (name.equals("VALUE") && params.size()==1) {
			value=params.get(0).getString();
			return;
		}
		
		if (name.equals("VALUE") && params.size()==1) {
			value=params.get(0).getString();
			return;
		}

		if (name.equals("SELECTION") && params.size()==1) {
			value=params.get(0).getString();
			return;
		}
		
		throw new ParseException("Unknown setting:"+name);
	}

	public CExpr getText() {
		return text;
	}

	public String getType() {
		return type;
	}

	public List<Parameter> getTypeParams() {
		return typeParams;
	}
	
	public String getTypeString(int ofs) {
		try {
			return typeParams.get(0).getString();
		} catch (ParseException e) {
			e.printStackTrace();
			throw new IllegalStateException(e);
		}
	}

	public boolean isRequired() {
		return required;
	}

	public boolean isMulti() {
		return multi;
	}

	public boolean isUnique() {
		return unique;
	}

	public boolean isInline() {
		return inline;
	}

	public boolean isChoice() {
		return choice;
	}

	public Parameter getDef() {
		return def;
	}

	public CExpr getWhenAccepted() {
		return whenAccepted;
	}

	public String getIcon() {
		return icon;
	}

	public AtParam getAt() {
		return at;
	}

	public AtParam getPromptat() {
		return promptat;
	}

	public String getMultiDescription() {
		return multiDescription;
	}

	public String getValue() {
		return value;
	}

	public String getSymbol() {
		return symbol;
	}

	@Override
	public String toString() {
		return "PromptCmd [text=" + text + ", type=" + type + ", typeParams="
				+ typeParams + ", required=" + required + ", multi=" + multi
				+ ", unique=" + unique + ", inline=" + inline + ", choice="
				+ choice + ", def=" + def + ", icon=" + icon + ", at=" + at
				+ ", promptat=" + promptat + ", multiDescription="
				+ multiDescription + ", value=" + value + ", symbol=" + symbol
				+ "]";
	}
	
	
	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return environment.eval(text).toString();
	}
	
	public void prime(ExecutionEnvironment scope)
	{
		if (def!=null) {
			ClarionObject value;
			try {
				value = scope.eval(def.getExpression());
				SymbolEntry se = scope.getScope().get(symbol);
				if (se==null) {
					System.out.println("Could not prime missing symbol:"+symbol);
					return;
				}
				if (se.scalar()!=null) {
					se.scalar().setValue(SymbolValue.construct(value));
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}
	
	private static Map<String,String> typeMap;
	static {
		typeMap=new HashMap<String,String>();
		typeMap.put("DROP","DEFAULT");
		typeMap.put("SPIN","DEFAULT");
		typeMap.put("EXPR","DEFAULT");		
		typeMap.put("FROM","DEFAULT");		
		typeMap.put("CONTROL","DEFAULT");		
		typeMap.put("CHECK","LONG");
		typeMap.put("OPTION","DEFAULT");
		typeMap.put("SAVEDIALOG","DEFAULT");
		typeMap.put("OPENDIALOG","DEFAULT");
		typeMap.put("COLOR","LONG");
	}
	
	@Override
	public void declare(UserSymbolScope scope,SymbolList dependents)
	{
		
		if (symbol==null) return;
		if (scope.get(symbol)!=null) return;
		String type="DEFAULT";
		if (getType()!=null) {
			type=getType().toUpperCase();
		}
		if (type.startsWith("@N")) {
			type="LONG";
		} else
		if (type.startsWith("@S")) {
			type="DEFAULT";
		} else {
			String test = typeMap.get(type);
			if (test!=null) {
				type=test;
			}
		}
		
		ValueType vt = ValueType.scalar;
		if (isUnique()) {
			vt = ValueType.unique;
		} else if (isMulti()) {
			vt = ValueType.multi;
		}
		scope.declare(symbol,type,vt,dependents.asArray()).setWidget(this);
	}	
}
