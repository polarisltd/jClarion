package org.jclarion.clarion.appgen.template.cmd;

import org.jclarion.clarion.runtime.expr.CExpr;

public abstract class AdditionCodeSection extends CodeSection
{
	public abstract boolean isWindow();
	public abstract boolean isReport();
	public abstract TemplateID getRequired();
	public abstract boolean isProcedure();
	public abstract boolean isApplication();
	public abstract boolean isMulti();
	public abstract String  getName();
	public abstract CExpr getDisplayDescription();
	public abstract boolean isPrimary();
	public abstract String getPrimaryMessage();
	public abstract String getPrimaryFlag();
	
}
