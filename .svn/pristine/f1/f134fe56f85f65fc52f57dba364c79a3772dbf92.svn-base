package org.jclarion.clarion.ide;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.ide.windowdesigner.ControlType;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;

public class UseVarHelper {
	private Set<String> usedVars=new HashSet<String>();
	
	
	public void setUniqueUse(AbstractControl target,boolean deep)
	{
		ExtendProperties prop = ExtendProperties.get(target);
		String use = prop.getUsevar();		
		String newUse = getUniqueUse(target,use);
		if (use==null || !use.equals(newUse)) {
			
			String bits[] = prop.getUsevars();
			if (bits==null) {
				prop.decodeUseVar(newUse);
			} else if (bits[0].startsWith("?")) {
					prop.decodeUseVar(newUse);
			} else {
				prop.setUsevar(new String[] { bits[0] } );
				if (!prop.getUsevar().equals(newUse)) {
					prop.setUsevar(new String[] { bits[0],"",newUse } );					
				}
			}
		}
		
		if (deep) {
			usedVars.add(newUse.toLowerCase());
			for (AbstractControl kid : target.getChildren()) {
				setUniqueUse(kid,true);
			}
		}
	}
	
	public String getUniqueUse(AbstractTarget source,AbstractControl target,String requestedUse)
	{
		use(source,target,true);
		return getUniqueUse(target,requestedUse);
	}
	
	public String getUniqueUse(AbstractControl target,String requestedUse)
	{
		if (requestedUse==null || requestedUse.trim().length()==0) {		
			String name = ControlType.get(target.getClass()).getName();
			name=(name.substring(0,1).toUpperCase())+(name.substring(1).toLowerCase());			
			int scan=1;
			while ( true ) {
				requestedUse="?"+name+scan;
				if (!usedVars.contains(requestedUse.toLowerCase())) return requestedUse;
				scan++;
			}
		}
		requestedUse=requestedUse.replace(" ","");
				
		String bits[] = requestedUse.split(",");
		ExtendProperties ep = new ExtendProperties(target);
		ep.setUsevar(bits);
		
		
		String base = ep.getUsevar();

		if (!usedVars.contains(base.toLowerCase())) return requestedUse;
		
		String test = getUniqueName(base,usedVars);
		
		
		if (bits.length==1) {
			if (bits[0].startsWith("?")) {
				return test;
			}
			return bits[0]+",,"+test;
		}
		
		return bits[0]+","+bits[1]+","+test;
	}

	private String getUniqueName(String base, Set<String> used) {
		int end = base.lastIndexOf(':');
		if (end>-1) {
			end++;
			while (end!=-1 && end<base.length()) {
				char test = base.charAt(end);
				if (test<'0' || test>'9') {
					end=-1;
				} else {
					end++;
				}
			}
			if (end>-1) {
				base=base.substring(0,base.lastIndexOf(':'));
			}
		}
		String test = base;
		int scan=0;
		while ( true ) {
			if (used.contains(test.toLowerCase())) {
				scan++;
				test=base+":"+scan;
			} else {
				break;
			}
		}
		return test;
	}

	public void use(PropertyObject source,boolean deep) 
	{
		use(source,null,deep);
	}
	
	public void use(PropertyObject source,PropertyObject filter,boolean deep) 
	{
		if (source!=filter) {
			ExtendProperties ep = ExtendProperties.get(source);
			if (ep!=null) {
				String uv = ep.getUsevar();
				if (uv!=null) {
					usedVars.add(uv.toLowerCase());
				}
			}
		}
		if (deep) {
			for (PropertyObject scan : source.getChildren()) {
				use(scan,filter,true);
			}
		}
	}

	private Map<Integer,Set<String>> uniqueProperties=new HashMap<Integer,Set<String>>();
	
	public void collateUniqueProperty(PropertyObject target, int prop) 
	{
		ClarionObject co  =target.getRawProperty(prop);
		if (co!=null) {
			Set<String> items = uniqueProperties.get(prop);
			if (items==null) {
				items=new HashSet<String>();
				uniqueProperties.put(prop,items);
			}
			items.add(co.toString().toLowerCase().trim());
		}
		
		for (PropertyObject kid : target.getChildren()) {
			collateUniqueProperty(kid, prop);
		}
	}

	public void ensureUniqueProperty(PropertyObject ac, int prop,boolean deep) 
	{
		ClarionObject co  =ac.getRawProperty(prop);
		if (co!=null) {
			Set<String> items = uniqueProperties.get(prop);
			if (items==null) return;
			if (items.contains(co.toString().toLowerCase().trim())) {
				ac.setProperty(prop,getUniqueName(co.toString(),items));
			}
		}
		if (deep) {
			for (PropertyObject scan : ac.getChildren()) {
				ensureUniqueProperty(scan, prop, true);
			}
		}
	}
	
}
