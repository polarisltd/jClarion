package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;

public class CallParam {
	private String name;
	private List<Parameter> params;
	
	public CallParam(String name,List<Parameter> params) {
		this.name=name;
		this.params=params;
	}

	public String getName() {
		return name;
	}

	public List<Parameter> getParams() {
		return params;
	}
	
	
}
