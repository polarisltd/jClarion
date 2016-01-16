package org.jclarion.clarion.compile.java;

import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.MainScope;

public class MainJavaClass extends ScopedJavaClass 
{
	public MainJavaClass(MainScope c, String pkg) {
		super(c, pkg);
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
