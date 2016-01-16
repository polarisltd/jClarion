package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ControlCmd extends AdditionCodeSection
{
	private String name;
	private String description;
	private boolean multi;
	private boolean show;
	private boolean window;
	private boolean report;
	private String wrap;
	private String primaryMessage;
	private String primaryFlag;
	private CExpr displayDescription;
	private int priority=5000;
	private TemplateID required;
	private String order;
	private boolean procedure;
	private boolean primary;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("FIRST")) {
			priority=1;
			return;
		}
		if (flag.equals("LAST")) {
			priority=10000;
			return;
		}
		if (flag.equals("MULTI")) {
			multi=true;
			return;
		}
		if (flag.equals("SINGLE")) {
			multi=false;
			return;
		}
		if (flag.equals("PROCEDURE")) {
			procedure=true;
			return;
		}
		if (flag.equals("SHOW")) {
			multi=true;
			return;
		}
		if (flag.equals("WINDOW")) {
			window=true;
			return;
		}
		if (flag.equals("REPORT")) {
			report=true;
			return;
		}
		
		throw new ParseException("Unknown:"+flag);
	}

	
	
	@Override
	protected void initSetting(TemplateParser parser, String value, Lexer l) throws ParseException {
		if (value.equals("REQ")) {
			required=getTemplateID(l,true,false);
			if (l.lookahead().type==LexType.param) {
				l.next();
				if (l.lookahead().type!=LexType.label) throw new ParseException("Expected label");
				this.order=l.next().value;
			}
			if (l.next().type!=LexType.rparam) throw new ParseException("Expected )");
			return;
		}
		super.initSetting(parser, value, l);
	}



	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("#CONTROL") && params.size()==2) {
			this.name=params.get(0).getString();
			this.description=params.get(1).getString();
			return;
		}

		if (name.equals("PRIMARY") && params.size()>=1 && params.size()<=2) {
			this.primary=true;
			this.primaryMessage=params.get(0).getString();
			if (params.size()==2) {
				this.primaryFlag=params.get(1).getString();
			}
			return;
		}
		
		if (name.equals("DESCRIPTION") && params.size()==1) {
			this.displayDescription=params.get(0).getExpression();
			return;
		}

		if (name.equals("WRAP") && params.size()==1) {
			this.wrap=params.get(0).getString();
			return;
		}
		
		if (name.equals("PRIORITY") && params.size()==1) {
			this.priority=params.get(0).getInt();
			return;
		}

		
		throw new ParseException("Unknown:"+name);
	}

	public String getName() {
		return name;
	}

	public String getDescription() {
		return description;
	}

	public boolean isMulti() {
		return multi;
	}

	public boolean isProcedure() {
		return procedure;
	}
	
	public boolean isPrimary()
	{
		return primary;
	}
	
	public boolean isShow() {
		return show;
	}

	public boolean isWindow() {
		return window;
	}

	public boolean isReport() {
		return report;
	}

	public String getWrap() {
		return wrap;
	}

	public String getPrimaryMessage() {
		return primaryMessage;
	}

	public String getPrimaryFlag() {
		return primaryFlag;
	}

	public CExpr getDisplayDescription() {
		return displayDescription;
	}

	public int getPriority() {
		return priority;
	}

	public TemplateID getRequired() {
		return required;
	}

	public String getOrder() {
		return order;
	}

	@Override
	public String toString() {
		return "ControlCmd [name=" + name + ", description=" + description
				+ ", multi=" + multi + ", show=" + show + ", window=" + window
				+ ", report=" + report + ", wrap=" + wrap + ", primaryMessage="
				+ primaryMessage + ", primaryFlag=" + primaryFlag
				+ ", displayDescription=" + displayDescription + ", priority="
				+ priority + ", required=" + required + ", order=" + order
				+ "]";
	}



	@Override
	public String getCodeID() {
		return name;
	}


	@Override
	public boolean isApplication() {
		return false;
	}

}
