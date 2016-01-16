package org.jclarion.clarion.appgen.app;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;
import org.jclarion.clarion.lang.Lex;

/**
 * Construct a list of flattened fields
 * 
 * @author barney
 */
public class FlatFields 
{
	public static List<Field> flatten(Iterable<Field> source)
	{
		ArrayList<Field> target=new ArrayList<Field>();
		
		flatten(target,source,0);
		
		return target;
	}

	private static void flatten(ArrayList<Field> target, Iterable<Field> source,int depth) 
	{
		for (Field x : source) {
			target.add(x);
			x.getDefinition().setIndent(depth);
			flatten(target,x.getFields(),depth+1);
			
			String type=x.getDefinition().getTypeName();
			type=type.toUpperCase();
			if (type.equals("QUEUE") || type.equals("CLASS") || type.equals("GROUP")) {
				Field end = new Field();
				Definition d = new Definition("","                    ");
				d.add(new DefinitionProperty("END",new ArrayList<Lex>()));
				end.setDefinition(d);
				d.setIndent(depth);
				target.add(end);
			}
		}
	}
}
