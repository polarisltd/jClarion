package org.jclarion.clarion.appgen.template.at;

import java.util.ArrayList;
import java.util.Collection;
import java.util.IdentityHashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.embed.Advise;
import org.jclarion.clarion.appgen.embed.AdviseStore;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.embed.MultiAdviseIterator;
import org.jclarion.clarion.appgen.embed.SimpleEmbedStore;
import org.jclarion.clarion.appgen.embed.WildcardEmbedStore;
import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.cmd.AtBlock;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;

/**
 * This object is an analogue of AtSource and represents an actual running scope for purposes of an template execution run 
 * 
 * @author barney
 */
public class AtSourceSession implements AdviseStore
{	
	// identify Execution Environment 
	private ExecutionEnvironment env;
	
	// identify the source this session represents. Will refer to a program/module etc
	private AtSource source;
	
	// the executing scope used to represent the source.
	private UserSymbolScope scope;
	private SymbolScope 	baseScope;

	// the code section
	private CodeSection     code;
	
	// the children
	private List<AtSourceSession> 			children;
	private Map<AtSource,AtSourceSession> 	childrenMap;

	private WildcardEmbedStore<AtAspect> embeds;

	private AtSourceSession parent;
	
	private boolean generated=false;
	
	public AtSourceSession(AtSource source,ExecutionEnvironment env,AtSourceSession parent)
	{
		this.source=env.getAlternative(source);
		this.env=env;
		this.parent=parent;
		constructScope();
	}

	public AtSourceSession(AtSource source,ExecutionEnvironment env,SymbolScope scope)
	{
		this.source=env.getAlternative(source);
		this.env=env;
		this.baseScope=scope;
		constructScope();
	}
	
	private void constructScope()
	{
		SymbolScope pScope = prepBaseScope(source,baseScope!=null ? baseScope : parent.getScope());		
		if (source.getPrompts()!=null) {
			this.scope=new UserSymbolScope(source.getPrompts(),pScope);
		} else {
			this.scope=new UserSymbolScope(source.getName());
		}
		this.scope.setParent(pScope);
	}
	

	private SymbolScope prepBaseScope(AtSource source,SymbolScope pScope)
	{
		SymbolScope append = source.getSystemScope(env);
		if (append!=null) {
			append.setParentScope(pScope);
			pScope=append;
		}		
		return pScope;
	}
	
	
	public boolean isGenerated() {	
		return generated;
	}

	public void setGenerated(boolean generated) {
		this.generated = generated;
	}



	public UserSymbolScope getScope()
	{
		return scope;
	}

	/*public UserSymbolScope getBaseScope()
	{
		return baseScope;
	}*/
	
	public void deleteChildren()
	{
		allKidsLoaded=false;
		children=null;
		childrenMap=null;
		code=null;
		embeds=null;
	}
	
	public void dispose()
	{
		if (scope!=null) {
			scope.dispose();
		}
		if (children!=null) {
			for (AtSourceSession session : children ) {
				session.dispose();
			}
		}
	}
	
	public CodeSection getCodeSection()
	{
		if (code==null) {
			if (source.getBase().getType()==null) {
				Collection<CodeSection> sect = env.getTemplateChain().getTemplate(source.getBase().getChain()).getSection(source.getTemplateType());
				if (sect.size()!=1) {
					throw new IllegalStateException("Could not determine unnamed section for "+source);
				}
				code=sect.iterator().next();
			} else {
				code=env.getTemplateChain().getSection(source.getTemplateType(),source.getBase());
				if (code==null && source.getTemplateType().equals("#CONTROL")) {
					code=env.getTemplateChain().getSection("#EXTENSION",source.getBase());
				}
			}
		}
		return code;
	}
	
	public boolean isChildrenLoaded()
	{
		return children!=null;
	}
	
	public AtSourceSession getChild(AtSource src)
	{
		loadChildren();
		return childrenMap.get(src);
	}
	
	private void loadChildren()
	{		
		if (children!=null) {
			return;
		}
	
		Collection<? extends AtSource> kids = source.getChildren();
		children=new ArrayList<AtSourceSession>(kids.size());
		childrenMap=new IdentityHashMap<AtSource,AtSourceSession>(kids.size());
		/*if (getScope()!=getBaseScope()) {
			throw new IllegalStateException("Auto scope is obscuring scope on child construct");
		}*/			
		for (AtSource kid : kids ) {
			kid=env.getAlternative(kid);
			AtSourceSession sess = new AtSourceSession(kid,env,this);
			children.add(sess);
			childrenMap.put(kid,sess);
		}
	}
	
	public void prepare()
	{
		loadEmbeds(true);
	}
	
	private void loadEmbeds(boolean prepareParents)
	{
		if (embeds!=null) return;
		if (parent!=null && prepareParents) {
			parent.loadEmbeds(true);
		}
		
		embeds=new WildcardEmbedStore<AtAspect>();		
		AdditionExecutionState state = prepareToExecute();
		
		// run prepare code before harvesting at blocks.  Prepare code may declare variables at blocks depend on 
		if (getCodeSection().getAtStart()!=null) {
			getCodeSection().getAtStart().run(env);
		}

		for (AtBlock ab : getCodeSection().getAtBlocks()) {
			AtAspect aa = new AtAspect(scope,ab,this,ab.getCmd().constructEmbedKey());
			embeds.add(aa);
		}

		state.finish();
	}

	private boolean allKidsLoaded=false;
	
	/*
	private boolean isChildOf(String name)
	{
		if (name.equalsIgnoreCase(getSource().getName())) {
			return true;
		}
		if (parent==null) return false;
		return parent.isChildOf(name);
	}
	*/
	
	/*
	private void childEmbedDebug(EmbedKey search)
	{
		System.err.println("Embeds for "+getSource());
		if (embeds!=null) {
			embeds.debug(search);
			if (children!=null) {
				for (AtSourceSession kid : children) {
					kid.childEmbedDebug(search);
				}
			}
		} else {
			System.err.println("   *** not yet loaded");
		}
	}
	*/
	
	
	private void loadEmbeds(EmbedKey search)			
	{

		if (embeds!=null && allKidsLoaded) return;
		
		if (getCodeSection().containsAt(search.getName())) {
			loadEmbeds(true);			
		}
		
		if (!allKidsLoaded) {
			loadChildren();
			allKidsLoaded=true;
			for (AtSourceSession kids : children) {			
				kids.loadEmbeds(search);
				if (kids.embeds!=null) {
					if (!kids.allKidsLoaded) {
						allKidsLoaded=false;
					}
					embeds.addAll(kids.embeds);
					if (kids.allKidsLoaded) {
						kids.embeds.finishTrackingUsed();
					}
				} else {
					allKidsLoaded=false;
				}
			}
		}

	}
	
	@Override
	public Iterator<Advise> get(EmbedKey key, int minPriority,int maxPriority) 
	{
		loadEmbeds(key);		
		
		MultiAdviseIterator<Advise> scan = new MultiAdviseIterator<Advise>();
		
		SimpleEmbedStore<Embed> r = getSource().getEmbeds();
		if (r!=null) {
			scan.add(r.get(key, minPriority, maxPriority));
		}
		
		if (embeds!=null) {
			scan.add(embeds.get(key, minPriority, maxPriority));
		}
		
		scan.completeAdd();
		
		return scan;
	}

	@Override
	public void debug(EmbedKey key) {
		embeds.debug(key);
	}

	public AdditionExecutionState prepareToExecute() 
	{
		return new AdditionExecutionState(this);
	}

	public ExecutionEnvironment getEnvironment() 
	{
		return env;
	}
	
	public AtSource getSource()
	{
		return source;
	}

	public AtSourceSession getParent() 
	{
		return this.parent;
	}

	public void debug() {
		embeds.debug();
	}
	
	public String toString()
	{
		return getSource().getName()+":"+getSource().getTemplateType();
	}
	
	
	public void pushAutoScope(UserSymbolScope scope)
	{
		scope.setParentScope(this.scope);
		this.scope=scope;
	}
	
	public void setScope(UserSymbolScope save) {
		this.scope=save;
	}
	
	
	public void popAutoScope()
	{
		scope=(UserSymbolScope)scope.getParentScope();
	}

	
}
