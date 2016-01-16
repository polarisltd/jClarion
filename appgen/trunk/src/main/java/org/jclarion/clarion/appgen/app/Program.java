package org.jclarion.clarion.appgen.app;

import java.util.ArrayList;
import java.util.Collection;

import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;

public class Program extends Component 
{
	private App  app;
	private String name;

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name=name;
	}

	@Override
	public String getType() {
		return "Prog";
	}

	@Override
	public String getTemplateType() {
		return "#PROGRAM";
	}

	@Override
	public Collection<? extends AtSource> getChildren() 
	{
		return new ArrayList<AtSource>();
	}

	@Override
	public void prepareToExecute(AdditionExecutionState state) 
	{
	}

	@Override
	public AtSource getParent() {
		return app;
	}

	public void setParent(App app2) {
		app=app2;
	}

	@Override
	public SymbolScope getSystemScope(ExecutionEnvironment environment) {
		return null;
	}

	@Override
	public PrimaryFile getPrimaryFile() {
		// TODO Auto-generated method stub
		return null;
	}


}
