package org.jclarion.clarion.appgen.app;

import java.io.IOException;

import org.jclarion.clarion.appgen.embed.AbstractAdvise;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;

public class Embed extends AbstractAdvise
{
	private EmbedKey key;
	private String  value;
	private boolean indent=true;
	
	
	public Embed(int priority,EmbedKey key,int instance)
	{
		super(priority,0,instance);
		this.key=key;	
	}
	
	public EmbedKey getKey()
	{
		return key;
	}
	
	public String getValue()
	{
		return value;
	}
	
	public void setValue(String value)
	{
		this.value=value;
	}
	
	public void setIndent(boolean b) 
	{
		this.indent=b;
	}
	
	public boolean isIndent()
	{
		return indent;
	}
	

	@Override
	public void run(ExecutionEnvironment env,EmbedKey source) 
	{
		try {
			if (!indent) {
				env.getWriteTarget().append(value);
			} else {
				Appendable target =env.getWriteTarget();
				CharSequence cs = env.getIndentSeq();
				boolean indent=true;
				for (int scan=0;scan<value.length();scan++) {
					if (indent) {
						target.append(cs);
						indent=false;
					}
					char c = value.charAt(scan);
					target.append(c);
					if (c=='\n') {
						indent=true;
					}
				}
			}
		} catch (IOException ex) { 
			ex.printStackTrace();
		}
		env.release();
		
	}

	@Override
	public String toString() {
		return "Embed [key=" + key + ", indent=" + indent + ", getPriority()="
				+ getPriority() + ", getInstanceID()=" + getInstanceID() + "]";
	}

	
	

}
