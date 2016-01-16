package org.jclarion.clarion.appgen.template;

import java.io.IOException;
import java.util.ArrayList;

import org.jclarion.clarion.appgen.lang.SourceEncoder;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.LabelExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;


public class SourceLine extends AbstractLine
{
	
	private static class Word
	{

		public void render(ExecutionEnvironment scope, WriteTarget out, int startPosition) throws IOException 
		{
			throw new IllegalStateException("Not implemented:"+this.getClass());
		}

		public void trim() {
			throw new IllegalStateException("Not implemented:"+this.getClass());
		}
	}
	
	private static class ConstantWord extends Word
	{
		private CharSequence constant;

		public ConstantWord(String constant)
		{
			this.constant=constant;
		}
		
		public String toString()
		{
			return "C:"+constant;
		}

		@Override
		public void render(ExecutionEnvironment scope, WriteTarget out, int startPosition) throws IOException 
		{
			out.append(constant);
		}
		
		public void trim()
		{
			int len =constant.length();
			while (len>0 && constant.charAt(len-1)==' ') {
				len--;
			}
			constant=constant.subSequence(0, len);
		}
	}

	private static class SpacedComment extends Word
	{
		private String constant;

		public SpacedComment(String constant)
		{
			this.constant=constant;
		}
		
		public String toString()
		{
			return "S:"+constant;
		}
		
		@Override
		public void render(ExecutionEnvironment scope, WriteTarget out, int startPosition) throws IOException 
		{
			out.append(' ');
			int len = scope.getComment();
			while (out.getCharsWritten()-startPosition+1<len) {
				out.append(' ');
			}
			out.append(constant);
		}
	}

	private static class Field extends Word
	{
		private String field;
		private SymbolScope lastScope=null;
		private SymbolEntry lastEntry=null;

		public Field(String field)
		{
			this.field=field;
		}
		
		public String toString()
		{
			return "F:"+field;
		}

		@Override
		public void render(ExecutionEnvironment scope, WriteTarget out, int startPosition) throws IOException 
		{
			if (scope.getScope()!=lastScope || lastEntry==null) {
				lastEntry = scope.getScope().get(field);
				lastScope=scope.getScope();
			}
			if (lastEntry==null) {
				//throw new IllegalStateException("Cannot resolve:"+field);
				return;
			}
			SymbolValue sv = lastEntry.getValue();
			if (sv!=null) { 
				out.append(sv.getString());
			}
		}
	}

	private static class FormatField extends Word
	{
		private CExpr field;
		private String format;

		public FormatField(CExpr field,String format)
		{
			this.field=field;
			this.format=format;
		}
		
		public String toString()
		{
			return "FF:"+field+"("+format+")";
		}
	}

	private static class StringField extends Word
	{
		private String field;
		private SymbolScope lastScope=null;
		private SymbolEntry lastEntry=null;		

		public StringField(String field)
		{
			this.field=field;
		}
		
		public String toString()
		{
			return "SF:"+field;
		}
		
		@Override
		public void render(ExecutionEnvironment scope, WriteTarget out, int startPosition) throws IOException 
		{
			if (scope.getScope()!=lastScope || lastEntry==null) {
				lastEntry = scope.getScope().get(field);
				lastScope=scope.getScope();
			}
			if (lastEntry==null) {
				throw new IllegalStateException("Cannot resolve:"+field);
			}
			SymbolValue sv = lastEntry.getValue();
			if (sv!=null) { 
				SourceEncoder.encodeString(sv.getString(),out,false);
			}
		}		
	}

	private static class PadField extends Word
	{
		private CExpr field;
		private CExpr pad;
		

		public PadField(CExpr field,CExpr pad)
		{
			this.field=field;
			this.pad=pad;
		}
		
		public String toString()
		{
			return "PF:"+field+"("+pad+")";
		}
		
		@Override
		public void render(ExecutionEnvironment scope, WriteTarget out, int startPosition) throws IOException 
		{
			String value = scope.eval(field).toString();
			int len = scope.eval(pad).intValue();
			
			out.append(value);
			for (int scan=value.length();scan<len;scan++) {
				out.append(' ');
			}
		}		
	}

	private static class Expr extends Word
	{
		private CExpr expr;

		public Expr(CExpr expr)
		{
			this.expr=expr;
		}
		
		public String toString()
		{
			return "E:"+expr;
		}
		
		@Override
		public void render(ExecutionEnvironment scope, WriteTarget out, int startPosition) throws IOException 
		{
			out.append(scope.eval(expr).toString());
		}		
	}
	
	
	private ArrayList<Word> words;
	private boolean conditional;

	
	public SourceLine(String line, boolean conditional) throws IOException
	{
		
		// %% = %
		// %# = #
		// %@pic@symbol : format symbol as picture
		// %[expr]symbol : pad result of symbol to length expr
		// %| : merge onto next line.  i.e. no newline
		// %'symbol:  string escape symbol
		// %(expression): evaluate expression
		// #
		
		Lexer l = new Lexer(new MarkedStringReader(line,0));
		l.setTemplateLexer(true);
		l.setIgnoreWhitespace(true);
		l.setJavaMode(false);
		
		words= new ArrayList<Word>();
		
		while ( true ) {

			char last=0;
			while (true) {
				if (l.getStream().eof()) {
					last=0;
					break;
				}
				last = l.getStream().peek(0);
				
				if (last=='#') {
					break;
				}
				
				if (last=='%') {
					break;
				}
				l.getStream().read();
			}
			
			String s = l.getStream().getToken();
			if (s.length()>0) {
				words.add(new ConstantWord(s));
			}
			
			if (last==0) break;
			
			char next = l.getStream().peek(1);
			
			if (last=='#') {
				if (next=='<') {
					l.getStream().read();
					l.getStream().read();
					l.getStream().getToken();
					if (!words.isEmpty()) {
						words.get(words.size()-1).trim();
					}
					words.add(new SpacedComment(""));
					continue;
				} else {
					l.getStream().read();
					l.getStream().read();
					words.add(new ConstantWord(l.getStream().getToken()));
					continue;					
				}
			}
			
			if (next=='%') {
				l.getStream().read();
				l.getStream().read();
				l.getStream().getToken();
				words.add(new ConstantWord("%"));
				continue;
			}
			
			if (next=='#') {
				l.getStream().read();
				l.getStream().read();
				l.getStream().getToken();
				words.add(new ConstantWord("#"));
				continue;
			}
			
			if (next=='@') {
				l.getStream().read();
				l.getStream().getToken();
				Lex pattern = l.next();
				if (pattern.type!=LexType.picture) throw new IOException("Expected picture in "+line);
				if (l.getStream().read()!='@') throw new IOException("Expected @ in "+line);
				l.getStream().getToken();
				Lex field = l.next();
				if (l.lookahead().type==LexType.label) {
					words.add(new FormatField(new LabelExpr("%"+field.value),pattern.value));
				} else if (l.lookahead().type==LexType.lparam) {
					l.next();
					Parser p = new Parser(l);
					try {
						words.add(new FormatField(p.expr(LexType.rparam),pattern.value));
					} catch (ParseException e) {
						throw new IOException(e.getMessage()+" in "+line);
					}
				} else {
					throw new IOException("Expected label or expression in "+line);
				}
				continue;
			}
			
			if (next=='\'') {
				l.getStream().read();
				l.getStream().read();
				l.getStream().getToken();
				Lex field = l.next();
				if (field.type!=LexType.label) throw new IOException("Expected label in "+line);
				words.add(new StringField("%"+field.value));
				continue;
			}
			
			if (next=='[') {
				l.getStream().read();
				l.getStream().read();
				l.getStream().getToken();
				Parser p = new Parser(l);
				try {
					CExpr e = p.expr(LexType.rbrack);
					if (l.lookahead().type==LexType.label) {
						words.add(new PadField(new LabelExpr("%"+l.next().value),e));
					} else if (l.lookahead().type==LexType.lparam) {
						l.next();
						words.add(new PadField(p.expr(LexType.rparam),e));
 					} else {
 						throw new IOException("Expected label or expression in "+line);
 					}
					
					continue;
				} catch (ParseException e) {
					throw new IOException(e.getMessage()+" in "+line);
				}
			}
			
			if (next=='(') {
				l.getStream().read();
				l.getStream().read();
				l.getStream().getToken();
				Parser p = new Parser(l);
				try {
					CExpr e = p.expr(LexType.rparam);
					words.add(new Expr(e));
					continue;
				} catch (ParseException e) {
					throw new IOException(e.getMessage()+" in "+line);
				}
			}
			
			if ( (next>='A' && next<='Z') || (next>='a' && next<='z') ) {
				Lex field = l.next();
				if (field.type!=LexType.label) throw new IOException("Expected label in "+line+" got: "+field);
				words.add(new Field(field.value));	
				continue;
			}
			
			l.getStream().read();
			l.getStream().read();
			words.add(new ConstantWord(l.getStream().getToken()));
			
			//throw new IOException("Unexpected "+next+" in "+line);
		}
		this.conditional=conditional;
	}
	
	public void render(ExecutionEnvironment scope,WriteTarget out) throws IOException
	{
		int start=out.getCharsWritten();
		out.append(scope.getIndentSeq());
		for (Word w : words) {
			w.render(scope,out, start);
		}		
	}
	
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		sb.append("Source[");
		for (Word w : words) {
			sb.append(' ').append(w);
		}
		sb.append("Source]");
		return sb.toString();
	}

	public boolean isConditional() {
		return conditional;
	}

}
