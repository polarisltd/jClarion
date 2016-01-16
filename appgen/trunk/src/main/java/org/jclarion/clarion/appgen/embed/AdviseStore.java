package org.jclarion.clarion.appgen.embed;

import java.util.Iterator;

/**
 * Get advises that match a given embed key. (i.e. a pointcut)
 * 
 * The advise objects returned are guaranteed to be in order of priority
 * 
 * @author barney
 */
public interface AdviseStore {
	public abstract Iterator<? extends Advise> get(EmbedKey key,int minPriority,int maxPriority);
	public abstract void debug(EmbedKey key);	
}
