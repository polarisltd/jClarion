package org.jclarion.clarion.appgen.template;


import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class CommandLine extends AbstractLine
{
	private String command;
	private Lexer args;
	private int argStart;
	private int indent;
	
	
	public CommandLine(int indent,String command,Lexer args)
	{
		this.command=command.toUpperCase();
		this.indent=indent;
		this.args=args;
		argStart=args.begin();
	}
	
	public String getCommand()
	{
		return command;
	}
	
	public Lexer getParams()
	{
		args.rollback(argStart);
		argStart=args.begin();
		return args;
	}
	
	public int getIndent()
	{
		return indent;
	}
	
	public String toString()
	{
		StringBuilder sb=new StringBuilder();
		sb.append("Command[name:").append(command).append(" args:");
		getParams();
		int scan=0;
		while (true ) {
			Lex l = args.lookahead(scan++);
			if (l.type==LexType.eof) break;
			if (scan>1) sb.append(" ");
			sb.append(l);
		}
		sb.append("]");
		return sb.toString();
	}
	
}
