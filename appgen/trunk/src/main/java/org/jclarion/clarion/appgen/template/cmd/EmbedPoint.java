package org.jclarion.clarion.appgen.template.cmd;

import java.io.StringReader;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.appgen.embed.Advise;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.appgen.template.at.AtAspect;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;

/**
 * Define an embed point.
 * 
 * @author barney
 *
 */
public class EmbedPoint extends Statement
{
	private Map<String,EmbedSymbol> symbols=new LinkedHashMap<String,EmbedSymbol>();
	private String identifier;
	private String description;
	private boolean data;
	private boolean hide;
	private boolean label;
	private boolean noindent;
	private boolean noOrder;
	private CExpr where;
	private boolean legacy;
	private int maxPriority=10000;
	private int minPriority=1;
	private CExpr tree;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("DATA")) {
			this.data=true;
			return;
		}
		if (flag.equals("HIDE")) {
			this.hide=true;
			return;
		}
		if (flag.equals("LABEL")) {
			this.label=true;
			return;
		}
		if (flag.equals("NOINDENT")) {
			this.noindent=true;
			return;
		}
		if (flag.equals("NOORDER")) {
			this.noOrder=true;
			return;
		}
		if (flag.equals("LEGACY")) {
			this.legacy=true;
			return;
		}
		throw new ParseException("Unknown "+flag);
	}

	public boolean isNoOrder() {
		return noOrder;
	}

	public int getMaxPriority() {
		return maxPriority;
	}

	public int getMinPriority() {
		return minPriority;
	}

	public CExpr getTree() {
		return tree;
	}

	@Override
	protected void initSetting(TemplateParser parser, CommandLine line, Lexer l) throws ParseException
	{
		while ( true) {		
			if (l.lookahead().type==LexType.eof) break;
			if (l.lookahead().type==LexType.param) {
				l.next();
			} else {
				// be a bit loose. Could be space instead of param
			}
			Lex label = l.next();
			if (label.type!=LexType.label && label.type!=LexType.string) {
				throw new ParseException("Expected label. Got:"+label);
			}
			
			if (label.type==LexType.string) {
				decodeSymbol(label.value,l,true);
			} else {			
				initSetting(null,label.value, l);
			}
		}
	}	
	
	
	@Override
	protected void initSetting(TemplateParser parser, String value, Lexer l) throws ParseException {
		if (value.startsWith("%")) {
			decodeSymbol(value,l,false);
			return;
		}
		super.initSetting(parser, value, l);
	}

	private void decodeSymbol(String value, Lexer l,boolean literal) throws ParseException
	{
		EmbedSymbol s = new EmbedSymbol(value,literal);
		symbols.put(value,s);
		if (l.lookahead().type==LexType.lbrack) {
			l.next();
			Parser p = new Parser(l);
			s.setDescription(p.expr(LexType.rbrack));
		}
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException 
	{
		if (name.equals("HLP")) return; 
		if (name.equals("WHERE") && params.size()==1) {
			where=params.get(0).getExpression();
			return;
		}
		if (name.equals("#EMBED") && params.size()>=1 && params.size()<=2) {
			this.identifier=params.get(0).getString();
			if (params.size()==2) {
				this.description=params.get(1).getString();
			}
			return;
		}
		if (name.equals("PRIORITY") && params.size()==2) {
			this.minPriority=params.get(0).getInt();
			this.maxPriority=params.get(1).getInt();
			return;
		}
		if (name.equals("MAP") && params.size()==2) {
			String key=params.get(0).getString();
			CExpr val=params.get(1).getExpression();
			if (symbols.get(key)!=null) {
				symbols.get(key).setDescription(val);
			}
			
			return;
		}
		
		if (name.equals("PREPARE") && params.size()<=symbols.size()) {
			Iterator<Parameter> s1 = params.iterator();
			Iterator<EmbedSymbol> s2 = symbols.values().iterator();
			while (s1.hasNext() && s2.hasNext()) {
				s2.next().setPrepare(s1.next().getExpression());
			}
			return;
		}
		
		if (name.equals("TREE") && params.size()==1) {
			tree=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown: "+name);
	}


	public void evaluateTree(String tree) throws ParseException
	{
		Iterator<EmbedSymbol> es = symbols.values().iterator();
		for (String item : tree.split("\\|")) {
			EmbedSymbol e = es.next();
			
			int indx = item.indexOf('{');
			int end = item.lastIndexOf('}');
			if (indx>-1 && end==item.length()-1) {
				e.setDescription(item.substring(0,indx));
				
				String paramPart = item.substring(indx+1,end);
				Lexer l = new Lexer(new StringReader(paramPart));
				l.setIgnoreWhitespace(true);
				while (true) {
					Lex label = l.next();
					if (label.type!=LexType.label) throw new ParseException("Tree content bad:"+paramPart);
					if (l.next().type!=LexType.lparam) throw new ParseException("Tree content bad:"+paramPart);
					e.setParam(label.value, l.next().value);
					if (l.next().type!=LexType.rparam) throw new ParseException("Tree content bad:"+paramPart);
					if (l.lookahead().type==LexType.eof) break; 
					if (l.next().type!=LexType.param) throw new ParseException("Tree content bad:"+paramPart);
				}					
			} else {
				e.setDescription(item);
			}
		}
	}

	public Iterable<EmbedSymbol> getSymbols() {
		return symbols.values();
	}

	public Iterable<String> getSymbolNames() {
		return symbols.keySet();
	}

	public EmbedSymbol getSymbol(String name) {
		return symbols.get(name);
	}

	public String getIdentifier() {
		return identifier;
	}



	public String getDescription() {
		return description;
	}



	public boolean isData() {
		return data;
	}



	public boolean isHide() {
		return hide;
	}



	public boolean isLabel() {
		return label;
	}



	public boolean isNoindent() {
		return noindent;
	}



	public CExpr getWhere() {
		return where;
	}



	public boolean isLegacy() {
		return legacy;
	}

	private int indent;
	@Override
	public void noteIndent(int indent)
	{
		this.indent=indent;
	}
	
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		
		if (where!=null) {
			if (!scope.eval(where).boolValue()) {
				return CodeResult.OK;
			}
		}
		
		String[] instances =new String[symbols.size()];
	
		int ofs=0;
		for (EmbedSymbol es : symbols.values()) {
			if (es.isLiteral()) {
				instances[ofs++]=es.getName();
			} else {
				String name = es.getName();		
				SymbolEntry se =  scope.getScope().get(name);
				if (se==null) {
					scope.error("Unable to find symbol:"+name);
					return CodeResult.OK;
				}
				SymbolValue val = se.getValue();
				if (val==null) {
					scope.error("Unable to find symbol value:"+name);
					if (se.list()!=null) {
						scope.error("Unable to find symbol value list:"+se.list().values().toString());
					}
					return CodeResult.OK;					
				}
				instances[ofs++]=val.getString();
				
			}
		}

		EmbedKey ek = new EmbedKey(this.identifier, instances);
		
		int oldIndent=scope.getIndent();
		
		
		scope.setIndent(noindent ? oldIndent : oldIndent+indent);
		
		boolean logEmbeds = !this.hide && !this.legacy && scope.isEditProcedure();
		
		if (logEmbeds) {
			String tree=null;
			if (this.tree!=null) {
				tree=scope.eval(this.tree).toString();
			}	
			if (tree==null) {
				tree=getDescription();
				for (EmbedSymbol symbol : symbols.values()) {
					String val;
					if (symbol.getDescription()!=null) {
						val=scope.eval(symbol.getDescription()).toString();
					} else {
						val=symbol.getName();
					}
					tree=tree+"|"+val;
				}
			}
			markup(scope,"StartEmbed","Key",ek,"Description",description,"Tree",tree,"Source",scope.getCurrentSource().getSource());
		}
		
		Iterator<? extends Advise> scan = scope.getCurrentSource().get(ek,minPriority,maxPriority);
		
		while (scan.hasNext()) {			
			Advise advise = scan.next();
			
			if (logEmbeds) {
				
				if (advise instanceof AtAspect) {
					if (!((AtAspect)advise).test(scope,ek)) {
						continue;
					}
				}
				
				initMarkup(scope,"StartAdvise");
				addMarkup(scope,"Advise",advise);
				if (advise instanceof AtAspect) {
					AtAspect aa = (AtAspect)advise;
					CExpr desc = aa.getDescription();
					if (desc!=null) {
						addMarkup(scope,"Description",scope.eval(desc));
					}
				} else {				
					finishMarkup(scope);
				}
			}
			
			advise.run(scope,ek);
			
			if (logEmbeds) {
				markup(scope,"EndAdvise");
			}
		}
		
		scope.setIndent(oldIndent);

		if (logEmbeds) {
			markup(scope,"EndEmbed");
		}
		
		return CodeResult.OK;
	}

	
	private void editRelease(ExecutionEnvironment scope) {
		if (scope.isIncludeEmptyEmbeds()) {
			scope.release();
			scope.getWriteTarget().setCharsWritten(0);
		}
	}

	private void markup(ExecutionEnvironment scope,String type, Object ...bits) {
		initMarkup(scope,type);
		for (int scan=0;scan<bits.length;scan+=2) {
			if (bits[scan+1]==null) continue;
			addMarkup(scope,bits[scan].toString(),bits[scan+1]);
		}
		finishMarkup(scope);
	}

	private void finishMarkup(ExecutionEnvironment scope) 
	{
		scope.getWriteTarget().clearMarkup();
		editRelease(scope);
	}

	private void addMarkup(ExecutionEnvironment scope, String string,Object object) {
		scope.getWriteTarget().markup(string, object);
	}

	private void initMarkup(ExecutionEnvironment scope,String type) {
		scope.getWriteTarget().clearMarkup();
		scope.getWriteTarget().markup("Type",type);
		scope.getWriteTarget().markup("Embed",this);
		scope.getWriteTarget().markup("Indent",scope.getIndentSeq());
	}

	@Override
	public String toString() {
		return "EmbedPoint [identifier=" + identifier + ", description="
				+ description + ", maxPriority=" + maxPriority
				+ ", minPriority=" + minPriority + "]";
	}

	
	
	
	
}

