package org.jclarion.clarion.appgen.embed;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;

/**
 * Define a segment of code that can insert into #EMBED points. Concrete implementation  is either embed in an app file or an #AT statement
 * 
 * @author barney
 */
public interface Advise extends Comparable<Advise>
{	
	public abstract int getPriority();
	public abstract void run(ExecutionEnvironment env,EmbedKey source);
}
