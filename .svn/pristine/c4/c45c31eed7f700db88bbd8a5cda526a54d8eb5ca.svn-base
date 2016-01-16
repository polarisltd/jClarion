package org.jclarion.clarion.appgen.app;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;

public class Module extends Component
{
	private String name;
	private Map<String,Procedure> procedures=new LinkedHashMap<String,Procedure>();
	private String include;
	private boolean populate=true;
	private App app;
	private String filename;
	private int order;
	private Object source;
	
	public void addProcedure(Procedure loadProcedure)	
	{
		procedures.put(loadProcedure.getName().toLowerCase(),loadProcedure);
		if (app!=null) {
			app.addProcedure(loadProcedure);
		}
		loadProcedure.setParent(this);
	}

	public void deleteProcedure(Procedure p)
	{
		procedures.remove(p.getName().toLowerCase());
	}
	
	public void alertProcedureNameChange(String oldName, String newName) {
		procedures.put(newName.toLowerCase(),procedures.remove(oldName.toLowerCase()));
	}
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInclude() {
		return include;
	}

	public void setInclude(String include) {
		this.include = include;
	}

	public boolean isPopulate() {
		return populate;
	}

	public void setPopulate(boolean populate) {
		this.populate = populate;
	}
	
	public Iterable<Procedure> getProcedures()
	{
		return procedures.values();
	}

	public void setApp(App app) {
		this.app=app;
	}

	@Override
	public String getType() {
		return "Module";
	}

	@Override
	public String getTemplateType() 
	{
		return "#MODULE";
	}

	@Override
	public Collection<? extends AtSource> getChildren() 
	{
		return procedures.values();
	}

	@Override
	public void prepareToExecute(AdditionExecutionState state) 
	{
		state.set("%module",getName(),false);
	}

	@Override
	public App getParent() {
		return app;
	}

	public Procedure getProcedure(String value) {
		return procedures.get(value.toLowerCase());
	}

	@Override
	public SymbolScope getSystemScope(ExecutionEnvironment environment) {
		// TODO Auto-generated method stub
		return null;
	}

	public String getFileName() {
		return filename;
	}
	
	public void setFilename(String filename) {
		this.filename=filename;
	}
	
	public Object getSource()
	{
		return source;
	}
	
	public void setSource(Object source)
	{
		this.source=source;
	}

	public void setOrder(int order) {
		this.order=order;
	}
	
	public int getOrder() {
		return order;
	}

	@Override
	public PrimaryFile getPrimaryFile() {
		// TODO Auto-generated method stub
		return null;
	}

	
}
