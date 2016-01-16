package org.jclarion.clarion.compile.grammar;

import java.util.Stack;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.Lexer;

public class WarningCollator 
{
	private static ThreadLocal<WarningCollator> instance=new ThreadLocal<WarningCollator>() {
		@Override
		protected WarningCollator initialValue() {
			return new WarningCollator();
		}
	};
	private ClarionCompiler compiler;
	private Lexer lexer;
	private Stack<Lexer> lexerStack=new Stack<Lexer>();
	
	public static WarningCollator get()
	{
		return instance.get();
	}
	
	
	private WarningCollator()
	{
	}

	public void set(ClarionCompiler compiler,Lexer l)
	{
		setCompiler(compiler);
		setLexer(l);
	}
	
	public void setCompiler(ClarionCompiler compiler)
	{
		this.compiler=compiler;
	}
	
	public boolean isRecycled()
	{
		if (compiler==null) return false;
		return compiler.isRecycled();
	}
	
	public ClarionCompiler getCompiler()
	{
		return getCompiler();
	}
	
	public void setLexer(Lexer l)
	{
		if (l==null) throw new IllegalStateException("Lexer is null");
		this.lexer=l;		
		lexerStack.clear();
	}
	
	public Lexer getLexer()
	{
		return lexer;
	}
	
	public void pushLexer(Lexer next)
	{
		lexerStack.push(lexer);
		lexer=next;
	}
	
	public void popLexer()
	{
		lexer=lexerStack.pop();
	}
	
	public void warning(String message)
	{
		if (compiler==null) return;
		Lex last = lexer.lookahead();
		compiler.error().warning(lexer,last.lineNumber,last.charStart,last.charEnd,message);
	}
}

