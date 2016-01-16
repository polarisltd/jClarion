package org.jclarion.clarion.appgen.template.cmd;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.runtime.expr.CExpr;

public class AtBlock {
	private int 			priority;
	private int 			position;
	private CExpr 			description;
	private List<Statement> statements;
	private AtCmd cmd;
	private String srcref;
	
	public AtBlock(AtCmd cmd,int priority,int position,CExpr description,String srcref)
	{
		this.srcref=srcref;
		this.cmd=cmd;
		this.priority=priority;
		this.description=description;		
		this.statements=new ArrayList<Statement>();
	}
	
	public String getSrcRef()
	{
		return srcref;
	}

	public int getPriority() {
		return priority;
	}

	public int getPosition() {
		return position;
	}

	public CExpr getDescription() {
		return description;
	}

	public List<Statement> getStatements() {
		return statements;
	}
	
	public AtCmd getCmd()
	{
		return cmd;
	}

	@Override
	public String toString() {
		return "AtBlock [priority=" + priority + ", description=" + description+ ", cmd=" + cmd + "]";
	}
	
	

}
