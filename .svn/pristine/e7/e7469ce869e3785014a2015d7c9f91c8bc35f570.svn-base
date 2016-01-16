package org.jclarion.clarion.ide.editor;

import java.util.IdentityHashMap;
import java.util.Iterator;
import java.util.Map;

import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.embed.Advise;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.embed.SimpleEmbedStore;
import org.jclarion.clarion.ide.model.app.AbstractListenerContainer;

public class EmbedHelper implements EmbedChangeListener
{
	
	protected Map<Embed,Embed> 					alteredEmbeds=new IdentityHashMap<Embed,Embed>();	// old, new
	protected Map<Embed,Embed> 					newEmbeds=new IdentityHashMap<Embed,Embed>();		// new, old
	protected SimpleEmbedStore<Embed> 			newEmbedStore=new SimpleEmbedStore<Embed>();
	private AbstractListenerContainer<EmbedChangeListener> container=new AbstractListenerContainer<EmbedChangeListener>();
	
	private EmbedHelper parent;
	private Procedure   procedure;
	
	public EmbedHelper(Procedure procedure)
	{
		this.procedure=procedure;
	}
	
	public EmbedHelper(EmbedHelper parent)
	{
		this.parent=parent;
		parent.addChangeListener(this);
	}
	
	public void dispose()
	{
		if (parent!=null) {
			parent.removeChangeListener(this);
		}
	}
	
	public Procedure getProcedure()
	{
		if (procedure!=null) return procedure;
		return parent.getProcedure();
	}
	
	public EmbedHelper getParent()
	{
		return parent;
	}	
	
	public void addChangeListener(EmbedChangeListener r)
	{
		container.add(r);
	}
	
	public void removeChangeListener(EmbedChangeListener r)
	{
		container.remove(r);
	}
	
	public boolean isDirty()
	{
		return !alteredEmbeds.isEmpty() || !newEmbeds.isEmpty();
	}
	
	public void save()
	{
		if (procedure!=null) {
			for (Embed e : alteredEmbeds.keySet()) {
				procedure.getEmbeds().delete(e);
			}		
			for (Embed e : newEmbedStore) {
				procedure.getEmbeds().add(e);
			}	
			alteredEmbeds.clear();
			newEmbedStore= new SimpleEmbedStore<Embed>();
			newEmbeds.clear();
			fireChange();
		} else {
			for (Map.Entry<Embed,Embed> scan : alteredEmbeds.entrySet()) {				
				Embed oldEmbed = scan.getKey();
				Embed newEmbed = scan.getValue();
				
				// if the old embed happens to represent a new embed from point of view of the parent then replace the new embed on the parent with a new-new embed
				if (parent.newEmbeds.containsKey(oldEmbed)) {
					parent.newEmbedStore.delete(oldEmbed);
					oldEmbed = parent.newEmbeds.remove(oldEmbed);					
				}
				
				parent.alteredEmbeds.put(oldEmbed, newEmbed);
				if (newEmbed!=null) {
					parent.newEmbeds.put(newEmbed, oldEmbed);
					parent.newEmbedStore.add(newEmbed);
				}
			}
			for (Map.Entry<Embed,Embed> scan : newEmbeds.entrySet()) {
				if (scan.getValue()!=null) continue;
				parent.newEmbeds.put(scan.getKey(),null);
				parent.newEmbedStore.add(scan.getKey());				
			}
			
			alteredEmbeds.clear();
			newEmbedStore= new SimpleEmbedStore<Embed>();
			newEmbeds.clear();
			parent.fireChange();
		}
		
	}


	public void add(Embed embed) {
		newEmbeds.put(embed,null);
		newEmbedStore.add(embed);
	}
	
	public Embed modify(Embed embed) 
	{		
		if (newEmbeds.containsKey(embed)) return embed;		
		Embed e = alteredEmbeds.get(embed);
		if (e==null) {
			e = new Embed(embed.getPriority(),embed.getKey(),embed.getInstanceID());				
			e.setIndent(embed.isIndent());
			e.setValue(embed.getValue());
			alteredEmbeds.put(embed,e);
			newEmbeds.put(e,embed);
			newEmbedStore.add(e);
		}
		return e;
	}

	private SimpleEmbedStore<Embed>		getRetainedEmbeds()
	{
		SimpleEmbedStore<Embed>	 retainedEmbeds=new SimpleEmbedStore<Embed>();
			if (procedure!=null) {				
				for (Embed e : procedure.getEmbeds()) {
					retainedEmbeds.add(e);
				}
			} else {
				for (Embed e : parent.getRetainedEmbeds()) {
					retainedEmbeds.add(e);
				}
				for (Embed e : parent.newEmbeds.keySet()) {
					retainedEmbeds.add(e);
				}
			}
					
			for (Embed e : alteredEmbeds.keySet()) {
				retainedEmbeds.delete(e);
			}
		return retainedEmbeds;
	}
	
	public Iterator<? extends Advise> getUnmodifiedEmbeds(EmbedKey key)
	{
		return getRetainedEmbeds().get(key,1,10000);
	}

	public Iterator<? extends Advise> getNewEmbeds(EmbedKey key)
	{
		return newEmbedStore.get(key, 1, 10000);
	}
	
	public void delete(Embed embed) 
	{
		if (newEmbeds.containsKey(embed)) {
			Embed originalEmbed = newEmbeds.get(embed);
			if (originalEmbed!=null) {
				alteredEmbeds.put(originalEmbed, null);
			}
			newEmbeds.remove(embed);
			newEmbedStore.delete(embed);
			fireChange();			
			return;
		}
		
		alteredEmbeds.put(embed, null);
		fireChange();			
	}

	
	public void fireChange()
	{
		for (EmbedChangeListener r : container) {
			r.embedsChanged();
		}
	}
	
	@Override
	public void embedsChanged() {
		fireChange();
	}
}
