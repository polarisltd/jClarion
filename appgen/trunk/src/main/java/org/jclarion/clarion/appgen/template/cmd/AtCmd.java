package org.jclarion.clarion.appgen.template.cmd;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateExecutionError;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class AtCmd extends CommandItem implements StatementBlock
{
	private String location;
	private List<Parameter> instances;
	private CExpr where;
	private boolean auto;
	private boolean preserve;
	private CExpr description;
	private int priority=-1;
	private int position=1;
	private EmbedKey key;
	
	public boolean matchEmbedKey(ExecutionEnvironment env,EmbedKey compare) {
		try {
			for (int scan=0;scan<instances.size();scan++) {
				Parameter p =instances.get(scan);
				if (p.isEmpty() || !p.isLabel()) continue;
				String item =p.getString();
				SymbolEntry se = env.getScope().get(item);
				if (se==null) {
					throw new IllegalStateException("AT block no good. missing symbol:"+item+" "+getSrcRef());
				}
				String str_val="";
				SymbolValue val = se.getValue();
				if (val!=null) str_val=val.getString(); 
				if (!str_val.equalsIgnoreCase(compare.getInstance(scan))) {
					return false;
				}
			}
			return true;
		} catch (ParseException ex) {
			ex.printStackTrace();
			throw new TemplateExecutionError(ex.getMessage(),ex);
		}		
	}
	
	public EmbedKey constructEmbedKey() {
		if (key==null) {
			String result[] = new String[instances.size()];
			for (int scan=0;scan<result.length;scan++) {
				Parameter p =instances.get(scan);
				if (p.isEmpty() || p.isLabel()) continue;
				
				try {
					String item =result[scan]=p.getString();
					result[scan]=item;
				} catch (ParseException e) {
					throw new TemplateExecutionError("At block problem",e);
				}
				
 			}
			key = new EmbedKey(location,result);;
		}
		return key;
	}
	
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("AUTO")) {
			this.auto=true;
			return;
		}
		if (flag.equals("FIRST")) {
			this.position=0;
			return;
		}
		if (flag.equals("LAST")) {
			this.position=2;			
			return;
		}
		if (flag.equals("PRESERVE")) {
			this.preserve=true;
			return;
		}
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#AT") && params.size()>=1) {
			this.location=params.get(0).getString();
			this.instances=new ArrayList<Parameter>(params.subList(1, params.size()));
			return;
		}
		if (name.equals("WHERE") && params.size()==1) {
			this.where=params.get(0).getExpression();
			return;
		}
		if (name.equals("DESCRIPTION") && params.size()==1) {
			this.description=params.get(0).getExpression();
			return;
		}
		if (name.equals("PRIORITY") && params.size()==1) {
			this.priority=params.get(0).getInt();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getLocation() {
		return location;
	}

	public CExpr getWhere() {
		return where;
	}

	public boolean isAuto() {
		return auto;
	}

	public boolean isPreserve() {
		return preserve;
	}

	public CExpr getDescription() {
		return description;
	}

	public int getPriority() {
		return priority;
	}


	
	@Override
	public String toString() {
		return "AtCmd [location=" + location + ", instances=" + instances
				+ ", getSrcRef()=" + getSrcRef() + "]";
	}



	private List<Statement> statements;
	
	@Override
	public void addStatement(Statement stmt) {
		statements.add(stmt);
	}
		
	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException {
		
		CodeSection section = (CodeSection)parent;
		
		int priority=this.priority;
		if (priority==-1) {
			//section.getLastAtBlock(this.location);
			priority=7000;
		}
				
		
		AtBlock block = new AtBlock(this,priority,position,this.description,getSrcRef());
		statements=block.getStatements();
		section.addAtBlock(block);
		
		while ( true ) {
			TemplateItem ti = parser.read();
			if (ti instanceof PriorityCmd) {
				PriorityCmd pi = (PriorityCmd)ti;
				block = new AtBlock(this,pi.getPriority(),position,pi.getDescription(),ti.getSrcRef());
				statements=block.getStatements();
				section.addAtBlock(block);
			}
			ti.consume(parser, this);			
			if (ti instanceof EndCmd && ((EndCmd)ti).isEnd("#ENDAT")) {
				break;
			}
		}
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) 
	{
		throw new IllegalStateException("Not runnable");
		//return scope.runBlock(statements);
	}

}
