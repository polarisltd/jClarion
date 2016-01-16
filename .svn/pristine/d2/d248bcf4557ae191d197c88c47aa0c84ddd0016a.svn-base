package org.jclarion.clarion.appgen.template.at;

import java.util.Collection;

import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.app.Meta;
import org.jclarion.clarion.appgen.app.PrimaryFile;
import org.jclarion.clarion.appgen.embed.SimpleEmbedStore;
import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;

/**
 * This object models a source of At blocks. and represents the scope of At blocks
 * 
 * Different scopes, in depth are
 *   PROGRAM -> MODULE -> PROCEDURE -> CONTROL*
 * 
 * Controls can be further nested as deeply as they need
 * 
 * This object links to the loaded Application model only and is not used to manage state of actual template run
 * 
 * @author barney
 *
 */
public interface AtSource 
{
	public abstract TemplateID						getBase();
	public abstract String							getTemplateType();
	public abstract Collection<? extends AtSource> 	getChildren();
	public abstract UserSymbolScope 				getPrompts();
	public abstract SymbolScope 					getSystemScope(ExecutionEnvironment environment);
	public abstract AtSource						getParent();
	public abstract SimpleEmbedStore<Embed> 		getEmbeds();
	public abstract void							prepareToExecute(AdditionExecutionState state);
	public abstract String 							getName();
	public abstract int								getAtSourceOrder();
	public abstract void 							setPrompts(UserSymbolScope scope);
	public abstract PrimaryFile						getPrimaryFile();
	public abstract Meta							meta();
}
