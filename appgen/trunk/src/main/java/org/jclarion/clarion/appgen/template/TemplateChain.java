package org.jclarion.clarion.appgen.template;

import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.ProcedureCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;

public class TemplateChain extends TemplateItem
{
	@Override
	public String getItemType() {
		return "TemplateChain";
	}
	
	private Map<String,TemplateCmd> sets = new LinkedHashMap<String,TemplateCmd>();

	public void register(TemplateCmd templateCmd) 
	{		
		sets.put(templateCmd.getName().toUpperCase(),templateCmd);
	}
	
	public TemplateCmd getTemplate(String type)
	{
		return sets.get(type.toUpperCase());
	}

	public CodeSection getSection(String type,TemplateID id)
	{
		return getSection(type,id,true);
	}
	
	public Iterable<TemplateCmd> getTemplates()
	{
		return sets.values();
	}
	
	public CodeSection getSection(String type,TemplateID id,boolean strict)
	{
		if (id.getChain()==null) {
			throw new IllegalStateException("Type is null");
		}
		TemplateCmd cmd = sets.get(id.getChain().toUpperCase());
		if (cmd==null) {
			System.out.println(sets.keySet()+" "+id);
			return null;
		}
		CodeSection cs = cmd.getSection(type,id.getType());
		
		if (cs==null && !strict && type.equals("#CONTROL")) {
			cs = cmd.getSection("#EXTENSION",id.getType());
		}
		return cs;
	}
	
	public void debug() 
	{
		for (TemplateCmd set : sets.values() ) {
			set.debug();
		}
	}
	
	public void finalise()
	{
		for (TemplateCmd set : this.sets.values()) {
			for (CodeSection proc : set.getSection("#PROCEDURE")) {
				ProcedureCmd p = (ProcedureCmd)proc;
				p.addParent(this);
			}
		}
	}
	
}
