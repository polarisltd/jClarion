package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ProcedureCmd extends CodeSection
{

	private String name;
	private String description;
	private String target;
	private boolean report;
	private boolean window;
	private boolean def;
	private String primaryMessage;
	private String primaryFlag;
	private TemplateID wizard;
	private TemplateID parent;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("REPORT")) {
			this.report=true;
			return;
		}
		if (flag.equals("WINDOW")) {
			this.window=true;
			return;
		}
		if (flag.equals("DEFAULT")) {
			this.def=true;
			return;
		}
		throw new ParseException("Unknown "+flag);
	}

	
	
	@Override
	protected void initSetting(TemplateParser parser, String value, Lexer l) throws ParseException 
	{
		if (value.equals("QUICK")) {
			wizard=getTemplateID(l);
			return;
		}
		if (value.equals("PARENT")) {
			parent=getTemplateID(l);
			return;
		}
		super.initSetting(parser, value, l);
	}



	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("PRIMARY") && params.size()>=1 && params.size()<=2) {
			primaryMessage=params.get(0).getString();
			if (params.size()==2) {
				primaryFlag=params.get(1).getString();
			}
			return;
		}
		if (name.equals("#PROCEDURE") && params.size()>=2 && params.size()<=3) {
			this.name=params.get(0).getString();
			this.description=params.get(1).getString();
			if (params.size()==3) {
				this.target=params.get(2).getString();
			}
			return;
		}
		throw new ParseException("Unknown");
	}



	public String getName() {
		return name;
	}



	public String getDescription() {
		return description;
	}



	public String getTarget() {
		return target;
	}



	public boolean isReport() {
		return report;
	}

	public boolean isDefault() {
		return def;
	}


	public boolean isWindow() {
		return window;
	}



	public String getPrimaryMessage() {
		return primaryMessage;
	}



	public String getPrimaryFlag() {
		return primaryFlag;
	}



	public TemplateID getWizard() {
		return wizard;
	}



	public TemplateID getParent() {
		return parent;
	}



	@Override
	public String toString() {
		return "ProcedureCmd [name=" + name + ", description=" + description
				+ ", target=" + target + ", report=" + report + ", window="
				+ window + ", primaryMessage=" + primaryMessage
				+ ", primaryFlag=" + primaryFlag + ", wizard=" + wizard
				+ ", parent=" + parent + "]";
	}

	
	public String getCodeID()
	{
		return name;
	}

	private String defProc;


	public void setDefault(String def) {
		if (this.defProc!=null) {
			System.err.println("Default overwritten");
		}
		this.defProc=def;
	}
	
	public String getDefault()
	{
		return defProc;
	}

	
	private boolean parentAdded=false;
	
	public void addParent(TemplateChain chain)
	{
		if (parentAdded) return;
		parentAdded=true;
		if (parent==null) return;		
		ProcedureCmd p = (ProcedureCmd)chain.getSection("#PROCEDURE", parent);
		p.addParent(chain);
		
		addParent(p);
	}
	
}
