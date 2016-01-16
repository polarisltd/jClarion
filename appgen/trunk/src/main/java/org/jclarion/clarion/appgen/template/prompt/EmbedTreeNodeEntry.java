package org.jclarion.clarion.appgen.template.prompt;

import org.jclarion.clarion.appgen.app.Embed;



public class EmbedTreeNodeEntry extends TreeNodeEntry
{
	private Embed embed;
	
	
	public EmbedTreeNodeEntry(Embed embed) 
	{
		this.embed=embed;
	}

	public void setEmbed(Embed e) {
		embed=e;
	}
	
	public String getDescription() {
		String value = embed.getValue();
		int cr = value.indexOf('\r');
		int lf = value.indexOf('\n');
		if (cr==-1) cr= value.length();
		if (lf==-1) lf = value.length();
		return value.substring(0,cr<lf ? cr : lf).trim();
	}


	public int getPriority() {
		return embed.getPriority();
	}
	
	public Embed getEmbed()
	{
		return embed;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;
		EmbedTreeNodeEntry other = (EmbedTreeNodeEntry) obj;
		return other.embed==embed;
	}
}