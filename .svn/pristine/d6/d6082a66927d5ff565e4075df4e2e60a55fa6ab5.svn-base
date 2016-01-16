package org.jclarion.clarion.ide.windowdesigner;

import java.awt.Container;
import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.PropertyObjectListener;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.ide.model.manager.PropertyManager;

public class ExtendProperties implements PropertyObjectListener
{
	private String 		label;
	private String[] 	usevar;
	private Map<String, String[]> pragma = new LinkedHashMap<String, String[]>();
	public PropertyManager manager;
	public boolean negWidth;
	public boolean negHeight;
	public String  controlLex;
	public String  endLex;
	private String pre;
	public Container container;
	public PropertyObjectListener resizeMonitor;
	public boolean isExpanded=true;
	private PropertyObject control;
	
	public static ExtendProperties get(PropertyObject po)
	{
		return (ExtendProperties)po.getExtend();
	}
	
	public ExtendProperties(PropertyObject control)
	{
		this.control=control;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
		control.setClonedProperty(-1, null);
	}

	public String getUsevar() {
		if (usevar==null || usevar.length==0) return null;
		String result = usevar[usevar.length-1];
		if (result.startsWith("?")) return result;
		return "?"+result.replace("[","_").replace("]","");
	}
	
	public void decodeUseVar(String usevar)
	{
		setUsevar(usevar.replace(" ","").split(","));
	}

	public void setUsevar(String ...usevar) {
		this.usevar=usevar;
		control.setClonedProperty(-1, null);
	}
	
	public void addPragma(String prop, String... array) {
		if (array==null) {
			pragma.remove(prop);
		} else {
			pragma.put(prop, array);
		}
		control.setClonedProperty(-1, null);
	}

	public Map<String, String[]> getPragma() {
		return pragma;
	}
	
	public String[] getPragma(String param)
	{
		return pragma.get(param.toUpperCase());
	}

	public String[] getUsevars() {
		return usevar;
	}

	public String getFullUseVar() {
		if (usevar==null) return "";
		StringBuilder sb=  new StringBuilder();
		for (String bits : usevar) {
			if (sb.length()>0) {
				sb.append(',');
			}
			sb.append(bits.trim());
		}
		return sb.toString();
	}

	@Override
	public void propertyChanged(PropertyObject owner, int property,ClarionObject value) {
		if (property==Prop.SELSTART) return;
		if (property==Prop.USE) return;
		this.controlLex=null;
		this.endLex=null;
		owner.removeListener(this);
	}

	@Override
	public Object getProperty(PropertyObject owner, int property) {
		return null;
	}

	public void setPre(String string) {
		this.pre=string;
		control.setClonedProperty(-1, null);
	}
	
	public String getPre()
	{
		return pre;
	}
}
