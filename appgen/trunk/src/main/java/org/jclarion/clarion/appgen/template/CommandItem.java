package org.jclarion.clarion.appgen.template;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.appgen.template.cmd.CallParam;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ConstExpr;
import org.jclarion.clarion.runtime.expr.LabelExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;


public abstract class CommandItem extends TemplateItem
{
	private static class StringParameter extends Parameter
	{
		private String source;

		public StringParameter(String source)
		{
			this.source=source;
		}

		@Override
		public int getInt() {
			if (source.length()==0) return 0;
			return Integer.parseInt(source);
		}

		@Override
		public String getString() {
			return source;
		}

		@Override
		public CExpr getExpression() {
			return new ConstExpr(new ClarionString(source));
		}
		
		public String toString() {
			return "Str:"+source;
		}

	}

	private static class LabelParameter extends Parameter
	{
		private String source;

		public LabelParameter(String source)
		{
			this.source=source;
		}

		@Override
		public int getInt() {
			if (source.length()==0) return 0;
			return Integer.parseInt(source);
		}

		@Override
		public String getString() {
			return source;
		}

		@Override
		public CExpr getExpression() {
			return new LabelExpr(source);
		}
		
		public String toString() {
			return "Lab:"+source;
		}

		@Override
		public boolean isLabel() {
			return true;
		}
	}
	
	private static class EmptyParameter extends Parameter
	{
		public EmptyParameter()
		{
		}

		@Override
		public int getInt() {
			return 0;
		}

		@Override
		public String getString() {
			return "";
		}

		@Override
		public CExpr getExpression() {
			return new ConstExpr(new ClarionString(""));
		}
		
		public String toString() {
			return "Empty";
		}

		@Override
		public boolean isEmpty() {
			return true;
		}
	}
	
	private static class IntParameter extends Parameter
	{
		private int source;

		public IntParameter(int source)
		{
			this.source=source;
		}

		@Override
		public int getInt() {
			return source;
		}

		@Override
		public String getString() {
			return String.valueOf(source);
		}

		@Override
		public CExpr getExpression() {
			return new ConstExpr(new ClarionNumber(source));
		}
		
		public String toString() {
			return "Int:"+source;
		}

		@Override
		public boolean isEmpty() {
			return false;
		}
		
	}

	private static class ExprParameter extends Parameter
	{
		private CExpr source;

		public ExprParameter(CExpr source)
		{
			this.source=source;
		}

		@Override
		public int getInt()  throws ParseException
		{
			throw new ParseException("parse int from expr");
		}

		@Override
		public String getString() throws ParseException 
		{
			throw new ParseException("parse string from expr");
		}

		@Override
		public CExpr getExpression() {
			return source;
		}
		
		public String toString() {
			return "Expr:"+source;
		}
	}
	
	public CommandItem()
	{		
	}
	
	private String itemType;
	
	@Override
	public String getItemType() {
		return "#"+itemType;
	}

	
	
	public void init(TemplateParser parser, CommandLine line) throws ParseException
	{
		Lexer l = line.getParams();
		
		initCommand(parser,line, l);		
		initSetting(parser,line, l);
		
		itemType=line.getCommand();
		
		if (l.lookahead().type!=LexType.eof) {
			throw new ParseException("Expected EOL");
		}
	}
	
	protected boolean caseSensitiveSettings()
	{
		return false;
	}
	
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
			if (label.type!=LexType.label) {
				throw new ParseException("Expected label. Got:"+label);
			}
			initSetting(parser,caseSensitiveSettings() ?  label.value : label.value.toUpperCase(), l);
		}
	}
	
	protected CallParam getCallParam(Lexer l) throws ParseException
	{
		if (l.next().type!=LexType.lparam) throw new ParseException("Expected (");
		Lex n = l.next();
		if (n.type!=LexType.label) {
			throw new ParseException("Expected label");			
		}
		CallParam cp = new CallParam(n.value,popParams(l));
		if (l.next().type!=LexType.rparam) throw new ParseException("Expected )");
		return cp;
	}

	protected TemplateID getTemplateID(String val)
	{
		val=val.trim();
		int sep = val.indexOf('(');
		int endsep = val.indexOf(')');
		if (sep>0 && endsep==val.length()-1) {
			return new TemplateID(val.substring(sep+1,endsep),val.substring(0,sep));
		} else {
			return new TemplateID(null,val);
		}
	}
	
	protected TemplateID getTemplateID(Lexer l) throws ParseException
	{
		return getTemplateID(l,true,true);
	}

	protected TemplateID getTemplateID(Lexer l,boolean first,boolean last) throws ParseException
	{
		if (first) {
			if (l.next().type!=LexType.lparam) throw new ParseException("Expected (");
		}
		Lex n = l.next();
		if (n.type!=LexType.label) throw new ParseException("Expected label");
		String cl=null;
		if (l.lookahead().type==LexType.lparam && l.lookahead(1).type==LexType.label && l.lookahead(2).type==LexType.rparam) {
			l.next();
			cl=l.next().value;
			l.next();
		} else {
			//cl=tp.getTemplate().getName();
		}
		
		TemplateID cp = new TemplateID(cl,n.value);
		if (last) {
			if (l.next().type!=LexType.rparam) throw new ParseException("Expected )");
		}
		return cp;
	}
	
	protected void initSetting(TemplateParser parser, String value, Lexer l)  throws ParseException
	{
		List<Parameter> p=popParams(l);
		if (p==null) {
			initFlag(value);
		} else {
			initSetting(value,p);
		}
	}

	protected void initCommand(TemplateParser parser, CommandLine line, Lexer l) throws ParseException 
	{
		List<Parameter> p = popParams(l);
		if (p!=null) {
			initSetting("#"+line.getCommand(),p);			
		}
	}
	
	protected List<Parameter> popParams(Lexer l) throws ParseException
	{
		if (l.lookahead().type!=LexType.lparam) return null;
		List<Parameter> result = new ArrayList<Parameter>();
		l.next();
		if (l.lookahead().type==LexType.rparam) {
			l.next();
			return result;
		}
		
		while ( true ) {
			Lex f1=l.lookahead(0);
			
			if (f1.type==LexType.param) {
				l.next();
				result.add(new EmptyParameter());
				continue;
			}
			
			Lex f2=l.lookahead(1);
			if (f1.type==LexType.eof || f2.type==LexType.eof) throw new ParseException("Unexpected EOF");
			
			Parameter p = null;
			if (f2.type==LexType.param || f2.type==LexType.rparam) {
				if (f1.type==LexType.string || f1.type==LexType.picture) {
					p=new StringParameter(f1.value);
				} else if (f1.type==LexType.label) {
					p=new LabelParameter(f1.value);
				} else if (f1.type==LexType.integer) {
					try {
						p=new IntParameter(Integer.parseInt(f1.value));
					} catch (NumberFormatException ex) {
						throw new ParseException(ex.getMessage());
					}
				}
			}
			
			if (p!=null) {
				l.next();
			} else {
				Parser parser = new Parser(l);
				CExpr ce = parser.expr(null);
				if (ce==null) {
					throw new ParseException("No expression");
				}
				p=new ExprParameter(ce);
			}
			result.add(p);
			
			if (l.lookahead(0).type==LexType.rparam) {
				l.next();
				break;
			}
			if (l.lookahead(0).type!=LexType.param) {
				throw new ParseException("Expected , or )");
			}
			l.next();
		}
		return result;
	}
	
	public abstract void initFlag(String flag) throws ParseException;
	public abstract void initSetting(String name,List<Parameter> params) throws ParseException;



	public void noteIndent(int indent) 
	{
	}
}
