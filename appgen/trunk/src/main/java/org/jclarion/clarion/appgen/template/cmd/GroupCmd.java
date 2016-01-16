package org.jclarion.clarion.appgen.template.cmd;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.PreserveBarrier;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.LabelExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;

public class GroupCmd extends CodeSection
{
	private static class Param
	{
		private String type;
		private String name;
		private CExpr def;
		@Override
		public String toString() {
			return "Param [type=" + type + ", name=" + name + ", def=" + def
					+ "]";
		}
	}

	private String 	symbol;
	private boolean preserve;
	private boolean auto;
	private String 	description;
	private int 	priority;
	private List<Param> params=new ArrayList<Param>();

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("AUTO")) {
			this.auto=true;
			return;
		}
		if (flag.equals("FIRST")) {
			this.priority=1;
			return;
		}
		if (flag.equals("LAST")) {
			this.priority=10000;
			return;
		}
		if (flag.equals("PRESERVE")) {
			this.preserve=true;
			return;
		}
		throw new ParseException("Unknown:"+flag);
	}

	
	
	@Override
	protected void initCommand(TemplateParser parser, CommandLine line, Lexer l) throws ParseException 
	{
		if (l.next().type!=LexType.lparam) throw new ParseException("Expected ("); 
		if (l.lookahead().type!=LexType.label) throw new ParseException("Expected label");
		symbol=l.next().value;
		
		
		while (l.lookahead().type==LexType.param) {
			l.next();
			Param p =new Param();
			p.type="STRING";
			if (l.lookahead(1).type==LexType.label) {
				if (l.lookahead(0).type==LexType.label) {
					p.type=l.next().value;
				} else if (l.lookahead(1).type==LexType.label && l.lookahead(0).type==LexType.operator && l.lookahead(0).value.equals("*")) {
					p.type="*";
					l.next();
				}
			}
			
			if (l.lookahead().type!=LexType.label) throw new ParseException("Expected label. Got:"+l.lookahead()+" "+l.lookahead(1));
			p.name=l.next().value;

			if (l.lookahead().type==LexType.comparator && l.lookahead().value.equals("=")) {
				l.next();
				Parser defp =new Parser(l);
				p.def=defp.expr(null);
			}
			params.add(p);
		}
		Lex rp = l.next();
		if (rp.type!=LexType.rparam) throw new ParseException("Expected ). Got:"+rp); 
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#HLP")) return;
		throw new ParseException("Unknown:"+name);
	}



	public String getSymbol() {
		return symbol;
	}


	public String getDescription() {
		return description;
	}


	public int getPriority() {
		return priority;
	}


	@Override
	public String toString() {
		return "GroupCmd [symbol=" + symbol + ", preserve=" + preserve
				+ ", auto=" + auto + ", description=" + description
				+ ", priority=" + priority + ", params=" + params + "]";
	}



	@Override
	public String getCodeID() {
		return symbol;
	}
	
	
	private String autoName;
	
	public CodeResult call(ExecutionEnvironment env,List<CExpr> params)
	{		
		PreserveBarrier pb=null;
		if (preserve) {
			pb=new PreserveBarrier();
			env.pushMonitor(pb);
		}
		
		UserSymbolScope autoScope=null;
		if (!this.params.isEmpty() || auto ) {
			if (autoName==null) {
				autoName="GROUP AUTO "+getSrcRef();
			}			
			autoScope = new UserSymbolScope(autoName);
			Iterator<CExpr> e = params.iterator(); 
			for (Param p : this.params) {
				
				CExpr next = e.hasNext() ? e.next() : null;
				
				if (p.type.equals("*")) {
					autoScope.declareAsReference(p.name,env.getScope().get( ((LabelExpr)next).getName() ));
					continue;
				}
				
				autoScope.declare(p.name,p.type,ValueType.scalar).scalar().setValue(next!=null ? 
						SymbolValue.construct(env.eval(next)) : 
						SymbolValue.construct(env.eval(p.def))
						);
			}			

			env.pushAutoScope(autoScope);			
		}

		
		
		CodeResult cr = this.run(env);
		
		if (autoScope!=null) {
			env.popAutoScope();
		}
		
		if (pb!=null) {
			pb.restoreFixChanges();
			env.popMonitor();
		}
		
		return cr;
	}

}
