package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ExtensionCmd extends AdditionCodeSection
{
	private String name;
	private String description;
	private String target;
	private boolean multi;
	private CExpr displayDescription;
	private boolean show;
	private String primaryMessage;
	private String primaryFlag;
	private int priority=5000;
	private boolean window=false;
	private TemplateID required;
	private String order;
	private boolean procedure;
	private boolean application;
	private TemplateID child;
	private boolean report;
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
		if (flag.equals("APPLICATION")) {
			application=true;
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
		if (flag.equals("SHOW")) {
			multi=true;
			return;
		}
		
		throw new ParseException("Unknown:"+flag);
	}

	
	
	public boolean isWindow() {
		return window;
	}

	public boolean isReport() {
		return report;
	}


	@Override
	protected void initSetting(TemplateParser parser, String value, Lexer l) throws ParseException {
		if (value.equals("APPLICATION")) {
			application=true;
			if (l.lookahead().type==LexType.lparam){
				child=getTemplateID(l);
			}
			return;
		}
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
		if (name.equals("#EXTENSION") && params.size()>=2 && params.size()<=3) {
			this.name=params.get(0).getString();
			this.description=params.get(1).getString();
			if (params.size()==3) {
				this.target=params.get(2).getString();
			}
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



	public String getTarget() {
		return target;
	}



	public boolean isMulti() {
		return multi;
	}

	public boolean isPrimary() {
		return primary;
	}


	public CExpr getDisplayDescription() {
		return displayDescription;
	}



	public boolean isShow() {
		return show;
	}



	public String getPrimaryMessage() {
		return primaryMessage;
	}



	public String getPrimaryFlag() {
		return primaryFlag;
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



	public boolean isProcedure() {
		return procedure;
	}



	public boolean isApplication() {
		return application;
	}



	public TemplateID getChild() {
		return child;
	}



	@Override
	public String toString() {
		return "ExtensionCmd [name=" + name + ", description=" + description
				+ ", target=" + target + ", multi=" + multi
				+ ", displayDescription=" + displayDescription + ", show="
				+ show + ", primaryMessage=" + primaryMessage
				+ ", primaryFlag=" + primaryFlag + ", priority=" + priority
				+ ", required=" + required + ", order=" + order
				+ ", procedure=" + procedure + ", application=" + application
				+ ", child=" + child + "]";
	}



	@Override
	public String getCodeID() {
		return name;
	}

	
}
