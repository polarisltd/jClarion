package org.jclarion.clarion.appgen.dict;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;

public class Identity {

	private Map<String, DefinitionProperty> parameters=new LinkedHashMap<String,DefinitionProperty>();
	private String description;
	private List<Definition> screenControls;
	private List<Definition> reportControls;
	private List<Definition> quickCode;

	public void addParams(Definition cd) 
	{
		if (cd==null) return;
		addParam(cd.getTypeName(),cd.getTypeProperty());
		for (DefinitionProperty prop : cd.getProperties()) {
			addParam(prop.getName(),prop);
		}
	}

	
	public void init(String nextDescription,List<Definition> nextScreenControls,List<Definition> nextReportControls,List<Definition> nextQuickCode) 
	{
		this.description=nextDescription;
		this.screenControls=nextScreenControls;
		this.quickCode=nextQuickCode;
		this.reportControls=nextReportControls;
	}
	
	public int getIdent() {
		DefinitionProperty av = parameters.get("IDENT");
		if (av==null) {
			return 0;
		}
		return av.get(0).getInt();
	}

	public Map<String, DefinitionProperty> getParameters() {
		return parameters;
	}

	public DefinitionProperty getParameter(String key)
	{
		return parameters.get(key.toUpperCase());
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String desc)
	{
		this.description=desc;
	}

	public List<Definition> getScreenControls() {
		return screenControls;
	}

	public void addScreenControl(Definition d) {
		if (screenControls==null) {
			screenControls=new ArrayList<Definition>();
		}
		screenControls.add(d);
	}
	
	public List<Definition> getReportControls() {
		return reportControls;
	}

	public void addReportControl(Definition d) {
		if (reportControls==null) {
			reportControls=new ArrayList<Definition>();
		}
		reportControls.add(d);
	}
	
	
	public void addQuickCode(Definition d) {
		if (quickCode==null) {
			quickCode=new ArrayList<Definition>();
		}
		quickCode.add(d);
	}
	
	public List<Definition> getQuickCode() {
		return quickCode;
	}

	public void addParam(String type, DefinitionProperty typeParameter) 
	{
		parameters.put(type.toUpperCase(),typeParameter);
	}
	
	
}
