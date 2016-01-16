package org.jclarion.clarion.ide.model.window;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.ide.Compiler;
import org.jclarion.clarion.ide.Serializer;
import org.jclarion.clarion.ide.UseVarHelper;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;

/**
 * Static helper functions to implement common window editing functions
 * 
 * @author barney
 */

public class WindowEditorHelper 
{
	public static String mergeInTemplateControls(String window,String templateControls,int id)
	{
		if (window==null) return null;
		if (templateControls==null) return window;

		Compiler c = new Compiler();
		AbstractTarget target = c.compile(window);
		
		List<PropertyObject> items = c.popControls(templateControls);
		
		UseVarHelper var = new UseVarHelper();
		var.use(target,true);
		var.collateUniqueProperty(target,Prop.FROM);
		
		for (PropertyObject scan : items ) {
			AbstractControl ac = (AbstractControl) scan;			
			var.setUniqueUse(ac,true);
			var.ensureUniqueProperty(ac,Prop.FROM,true);
			ExtendProperties.get(ac).addPragma("SEQ", new String[] { String.valueOf(id) });
			target.add(ac);
		}
		
		Serializer serializer = new Serializer();
		StringBuilder sb = new StringBuilder();
		try {
			serializer.serialize(target,sb);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
}
