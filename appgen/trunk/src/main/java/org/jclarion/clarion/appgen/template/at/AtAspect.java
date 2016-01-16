package org.jclarion.clarion.appgen.template.at;


import org.jclarion.clarion.appgen.embed.AbstractAdvise;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.symbol.PreserveBarrier;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.BufferedWriteTarget;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateExecutionError;
import org.jclarion.clarion.appgen.template.cmd.AtBlock;
import org.jclarion.clarion.runtime.expr.CExpr;

public class AtAspect extends AbstractAdvise
{
	private static int lastInstance=0;
	
	private EmbedKey			key;
	private AtSourceSession		state;
	private AtBlock 			at;
	
	public AtAspect(UserSymbolScope scope,AtBlock at,AtSourceSession state,EmbedKey key) {
		super(at.getPriority(),state.getSource().getAtSourceOrder(),++lastInstance);
		this.key=key;
		this.at=at;
		this.state=state;
	}
	
	private String autoName;
	
	public AtSourceSession getSession()
	{
		return state;
	}
	
	public AtBlock getBlock()
	{
		return at;
	}
	
	public String getSrcRef()
	{
		return at.getSrcRef();
	}

	public boolean test(ExecutionEnvironment env,EmbedKey source) 
	{
		return doRun(env,source,true,false,false);
	}
	
	@Override
	public void run(ExecutionEnvironment env,EmbedKey source) 
	{
		doRun(env,source,true,true,true);
	}
	
	private boolean doRun(ExecutionEnvironment env,EmbedKey source,boolean matchTest,boolean embedTest,boolean run)
	{
		AdditionExecutionState runState = state!=null ? state.prepareToExecute() : null;
		
		if (at.getCmd().isAuto()) {
			if (autoName==null) {
				autoName="AT AUTO("+at.getCmd().getSrcRef()+")";
			}
			env.pushAutoScope(autoName);
		}
			
		PreserveBarrier barrier=null;
		if (at.getCmd().isPreserve()) {
			barrier=new PreserveBarrier();
			env.getScope().pushMonitor(barrier);
		}

		boolean result=true;
		
		try {
			if (matchTest && !at.getCmd().matchEmbedKey(env,source)) {
				result=false;
			}

			if (result && embedTest && at.getCmd().getWhere()!=null && !env.eval(at.getCmd().getWhere()).boolValue()) {
				result=false;
			}
			
			if (run && env.isEditProcedure()) {
				if (((BufferedWriteTarget)env.getWriteTarget()).hasMetaData()) {
					env.getWriteTarget().markup("Filtered",!result);
					env.getWriteTarget().clearMarkup();
				}
			}
			
			if (result && run) {
				env.runBlock(at.getStatements());
			}
		
		} catch (TemplateExecutionError ex) {
			ex.append(",@"+at.getCmd().getSrcRef());
			throw(ex);
		} catch (RuntimeException ex) {
			throw new TemplateExecutionError(ex.getMessage()+" @"+at.getCmd().getSrcRef(),ex);
		}

		if (barrier!=null) {
			barrier.restoreFixChanges();
		}
		
		if (at.getCmd().isAuto()) {
			env.popAutoScope();
		}
		
		if (runState!=null) runState.finish();
		
		return result;
	}
	
	public String toString()
	{
		return at.getCmd().getSrcRef()+" "+state.getSource().getTemplateType()+" "+state.getSource().getName();
	}

	@Override
	public EmbedKey getKey() {
		return key;
	}

	public CExpr getDescription() {
		return at.getDescription();
	}
}
