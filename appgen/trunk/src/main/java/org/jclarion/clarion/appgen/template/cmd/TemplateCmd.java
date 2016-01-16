package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

public class TemplateCmd extends CommandItem
{

	private String name;
	private String description;
	private String family;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#TEMPLATE") && params.size()==2) {
			this.name=params.get(0).getString();
			this.description=params.get(1).getString();
			return;
		}
		if (name.equals("FAMILY") && params.size()==1) {
			this.family=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown "+name);
	}

	public String getName() {
		return name;
	}

	public String getDescription() {
		return description;
	}

	public String getFamily() {
		return family;
	}
	
	@Override
	public String toString() {
		return "TemplateCmd [name=" + name + ", description=" + description
				+ "]";
	}

	protected void execute(TemplateParser parser,TemplateItem parent) throws IOException
	{
		parser.setTemplate(this);
		while (true ) {
			TemplateItem child = parser.read();
			if (child==null) return;
			if (child instanceof TemplateCmd) return; // multiple template sets
			child.consume(parser, this);
		}
	}
	
	private Map<String,Map<String,CodeSection>> sections=new HashMap<String,Map<String,CodeSection>>();

	public void register(CodeSection codeSection) 
	{
		Map<String,CodeSection> cs = getSectionMap(codeSection.getItemType());
		String key = codeSection.getCodeID().toUpperCase();
		if (cs.containsKey(key)) {
			throw new IllegalStateException("Duplicated entry "+codeSection);
		}
		cs.put(key,codeSection);
	}
	
	public AppCmd getApplication()
	{
		Map<String,CodeSection> cs = getSectionMap("#APPLICATION");
		if (cs.isEmpty()) return null;
		return (AppCmd)cs.values().iterator().next();
	}

	public SystemCmd getSystem()
	{
		Map<String,CodeSection> cs = getSectionMap("#SYSTEM");
		if (cs.isEmpty()) return null;
		return (SystemCmd)cs.values().iterator().next();
	}
	
	public ProgramCmd getProgram()
	{
		Map<String,CodeSection> cs = getSectionMap("#PROGRAM");
		if (cs.isEmpty()) return null;
		return (ProgramCmd)cs.values().iterator().next();
	}
	
	private Map<String, CodeSection> getSectionMap(String itemType) 
	{
		Map<String,CodeSection> c = sections.get(itemType);
		if (c==null) {
			c=new LinkedHashMap<String,CodeSection>();
			sections.put(itemType, c);
		}
		return c;
	}

	public void debug() {
		System.out.println("Template:"+name);
		for (Map.Entry<String,Map<String,CodeSection>> bits : sections.entrySet()) {
			System.out.println(bits.getKey());
			for (CodeSection cs : bits.getValue().values()) {
				System.out.println("   "+cs.getCodeID()+" "+cs.getDescription());
			}
		}
	}
	
	public Collection<CodeSection> getSection(String type) {
		return getSectionMap(type).values();
	}

	public CodeSection getSection(String type, String id) 
	{
		Map<String, CodeSection> sect= getSectionMap(type);
		if (sect==null) {
			throw new IllegalStateException("Section "+type+" not found");
		}
		if (id==null) {
			id=type;
		}
		return sect.get(id.toUpperCase());
	}
	

}
