package org.jclarion.clarion.compile.java;

import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.MainScope;
import org.jclarion.clarion.compile.var.Variable;


public class MainJavaClass extends ScopedJavaClass 
{
	public MainJavaClass(MainScope c, String pkg) {
		super(c, pkg);
	}

	@Override
    protected boolean isStatic(Variable v)
    {
    	return true;
    }
	
	@Override
    protected void buildStatic(StringBuilder main,JavaDependencyCollector collector,boolean anyDestruct) {
    	main.append("\n\tprivate static java.util.List<Runnable> __static_init_list = new java.util.ArrayList<Runnable>();\n");
    	main.append("\tpublic static void __register_init(Runnable r) {\n");
    	main.append("\t\t__static_init_list.add(r);\n");
    	main.append("\t}\n\n");
    	main.append("\tprivate static java.util.List<Runnable> __static_destruct_list = new java.util.ArrayList<Runnable>();\n");
    	main.append("\tpublic static void __register_destruct(Runnable r) {\n");
    	main.append("\t\t__static_destruct_list.add(r);\n");
    	main.append("\t}\n\n");
    	main.append("\tprivate static boolean __is_init=false;\n");
        main.append("\tstatic {\n");
        main.append("\t\t__static_init();\n");    	
    	main.append("\t}\n\n");
    }	
	
	@Override
	protected boolean generateBlankStatics()
	{
		return true;
	}
	
	@Override
	protected void buildPreStaticInit(StringBuilder main,JavaDependencyCollector collector) 
	{
		main.append("\t\t__is_init=true;\n");
		main.append("\t\tjava.util.List<Runnable> __init_list = new java.util.ArrayList<Runnable>(__static_init_list);\n");
	}

	@Override
	protected void buildPostStaticInit(StringBuilder main,JavaDependencyCollector collector) 
    {
		main.append("\t\tfor (Runnable __scan : __init_list) { __scan.run(); };\n");
	}
	
	protected void buildPreStaticDestruct(StringBuilder main,JavaDependencyCollector collector) {
		main.append("\t\t__is_init=false;\n");
		main.append("\t\tjava.util.List<Runnable> __destruct_list = new java.util.ArrayList<Runnable>(__static_destruct_list);\n");
	}

	protected void buildPostStaticDestruct(StringBuilder main,JavaDependencyCollector collector) {
		main.append("\t\tfor (Runnable __scan : __destruct_list) { __scan.run(); };\n");
	}
	
	
	@Override
	protected void buildPostFields(StringBuilder main,JavaDependencyCollector collector) {
		super.buildPostFields(main, collector);
		Map<String,Procedure> m = ((MainScope)getScope()).getPrototypes();
		if (m==null) return;
		
		collector.add(ClarionCompiler.CLARION+".ClarionQueue");
		collector.add(ClarionCompiler.CLARION+".ClarionGroup");
		
		for ( Map.Entry<String,Procedure> p : m.entrySet() ) {
			
			String name = p.getKey();
			Procedure proc = p.getValue();
			
			main.append("\t\tpublic static ClarionQueue.Order __");
			main.append(name);
			main.append("=new ClarionQueue.FunctionOrder() {\n");
			main.append("\t\t\t@Override\n");
			main.append("\t\t\tpublic int compare(ClarionGroup g1,ClarionGroup g2)\n");
			main.append("\t\t\t{\n");
			main.append("\t\t\t\treturn (new ");
			main.append(proc.getScope().getJavaClass().getName());
			main.append("()).");
            main.append(Labeller.get(proc.getName(),false));
			main.append("(g1,g2).intValue();\n");
			main.append("\t\t\t}\n");
			main.append("\t\t};\n");
		}
	}
	
	
}
