package org.jclarion.clarion.appgen.app;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;

public class App extends Component 
{
	private String 			procedure;
	private String 			dictionary;
	private int 			version;
	private String 			todoType;
	private String 			todoValue;
	private Program  		program;
	private Map<String,Module> 		modules=new LinkedHashMap<String,Module>();
	private List<Module> 			modulelist=new ArrayList<Module>();
	private Map<String,Procedure> 	procedures=new LinkedHashMap<String,Procedure>();
	private UserSymbolScope persist;
	private String fileName; 
	
	public void addModule(Module loadModule) {
		modulelist.add(loadModule);
		modules.put(loadModule.getName().toLowerCase(),loadModule);
		loadModule.setApp(this);
		for (Procedure p : loadModule.getProcedures()) {
			addProcedure(p);
		}
	}
	
	
	public void deleteProcedure(Procedure p)
	{
		procedures.remove(p.getName().toLowerCase());
	}
	public void deleteModule(Module m)
	{
		modules.remove(m.getName().toLowerCase());
		modulelist.remove(m);
	}
	
	
	public void alertProcedureNameChange(String oldName, String newName) {
		procedures.put(newName.toLowerCase(),procedures.remove(oldName.toLowerCase()));
	}	

	public String getProcedure() {
		return procedure;
	}

	public void setProcedure(String procedure) {
		this.procedure = procedure;
	}

	public String getDictionary() {
		return dictionary;
	}

	public void setDictionary(String dictionary) {
		this.dictionary = dictionary;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getTodoType() {
		return todoType;
	}

	public void setTodoType(String todoType) {
		this.todoType = todoType;
	}

	public String getTodoValue() {
		return todoValue;
	}

	public void setTodoValue(String todoValue) {
		this.todoValue = todoValue;
	}

	public Program getProgram() {
		return program;
	}

	public void setProgram(Program program) {
		this.program = program;
		program.setParent(this);
	}

	public UserSymbolScope getPersist() {
		return persist;
	}

	public void setPersist(UserSymbolScope persist) {
		this.persist = persist;
	}

	public void debug() 
	{
		Map<String,Procedure> map = new LinkedHashMap<String,Procedure>();
		Set<String> loaded=new HashSet<String>();
		for (Module m : modules.values()) {
			for (Procedure p : m.getProcedures()) {
				map.put(p.getName(),p);
			}
		}
		
		try {
			System.setOut(new java.io.PrintStream("out.txt"));
		} catch (java.io.FileNotFoundException e) {
			e.printStackTrace();
		}
		
		for (Procedure p : map.values()) {
			if (p.isGlobal()) {
				debug(map,loaded,p.getName(),0,new HashSet<String>());
			}
		}
		
		debug(map,loaded,getProcedure(),0,new HashSet<String>());

		for (Procedure p : map.values()) {
			if (!loaded.contains(p.getName())) {
				debug(map,loaded,p.getName(),0,new HashSet<String>());
			}
		}
	}

	private void debug(Map<String, Procedure> map, Set<String> loaded,String name, int depth,HashSet<String> stack) 
	{
		Procedure p = map.get(name);
		if (depth>0 && p.isGlobal()) return;
		
		for (int scan=0;scan<depth;scan++) {
			System.out.print("  ");
		}
		if (stack.contains(name)) {
			System.out.println(p.getName()+" : "+p.getBase().getType()+" (Recursive)");
			return;
		} else {
			System.out.println(p.getName()+" : "+p.getBase().getType()+" - "+p.getDescription());
		}
		stack.add(name);
		loaded.add(name);
		for (String s : p.getAllCalls()) {
			debug(map,loaded,s,depth+1,stack);
		}
		stack.remove(name);
	}

	public String getName() {
		if (fileName==null) return "?";
		int end = fileName.lastIndexOf('.');
		if (end==-1) end = fileName.length();
		int start= fileName.lastIndexOf(java.io.File.separatorChar)+1;		
		return fileName.substring(start,end);
	}

	
	
	public Iterable<Module> getModules() 
	{
		Module x =getModule(getProgram().getName());
		if (x==null) {
			x = new Module();
			x.setApp(this);
			x.setName(getProgram().getName());
			addModule(x);
		}
		
		return modulelist;
	}
	
	public Module getModule(String name) 
	{
		return modules.get(name.toLowerCase());
	}

	public Module getModule(int ofs) 
	{
		return modulelist.get(ofs);
	}
	
	public void sortModules()
	{
		Set<Module> set = new TreeSet<Module>(new Comparator<Module>() {

			@Override
			public int compare(Module o1, Module o2) {
				int diff = o1.getOrder()-o2.getOrder();
				if (diff!=0) return diff;
				if (o1.getFileName()!=null && o1.getFileName()!=null) {
					diff = o1.getFileName().compareTo(o2.getFileName());
					if (diff!=0) return diff;
				}
				if (o1.getFileName()==null) return -1;
				if (o2.getFileName()==null) return 1;
				
				throw new IllegalStateException("WTF?");
			}} );
		
		set.addAll(modulelist);
		
		modulelist.clear();
		modulelist.addAll(set);
	}

	public void addProcedure(Procedure proc) {
		procedures.put(proc.getName().toLowerCase(), proc);
	}
	
	public Procedure getProcedure(String value) {
		return procedures.get(value.toLowerCase());
	}

	public Iterable<Procedure> getProcedures() 
	{
		return procedures.values();
	}

	public void setFile(String fileName) 
	{
		this.fileName=fileName;
	}

	@Override
	public String getType() {
		return "App";
	}

	@Override
	public String getTemplateType() {
		return "#APPLICATION";
	}

	@Override
	public Collection<? extends AtSource> getChildren() 
	{
		List<AtSource> result =new ArrayList<AtSource>(modules.size()+1);
		for (Module m : getModules()) {
			if (m.getBase()==null) continue;
			result.add(m);
		}
		result.add(program);
		return result;
	}

	@Override
	public void prepareToExecute(AdditionExecutionState state) 
	{
	}

	@Override
	public AtSource getParent() {
		return null;
	}

	@Override
	public SymbolScope getSystemScope(ExecutionEnvironment environment) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PrimaryFile getPrimaryFile() {
		// TODO Auto-generated method stub
		return null;
	}
}
