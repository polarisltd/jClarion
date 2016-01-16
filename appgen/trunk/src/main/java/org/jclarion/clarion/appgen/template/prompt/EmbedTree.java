package org.jclarion.clarion.appgen.template.prompt;

import java.util.IdentityHashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;

import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.embed.Advise;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.template.BufferedSegment;
import org.jclarion.clarion.appgen.template.BufferedWriteTarget;
import org.jclarion.clarion.appgen.template.at.AtAspect;
import org.jclarion.clarion.appgen.template.cmd.EmbedPoint;

public class EmbedTree {
	
	private EmbedTreeNode root=new EmbedTreeNode("Root",5000,0);
	private IdentityHashMap<Embed,Embed>    referencedEmbeds=new IdentityHashMap<Embed,Embed>();
	
	public EmbedTreeNode getNode(String name)
	{
		EmbedTreeNode base=null;		
		int index = name.lastIndexOf('|');
		if (index>0) {
			base=getNode(name.substring(0,index));
		} else {
			base=root;
		}
		
		name = name.substring(index+1);
		int priority=4999;
		int color=0;
		
		while (true) {
			int start=name.indexOf('{');
			if (start==-1) break;
			int end = name.indexOf('}');
			
			String item = name.substring(start+1,end);
			name=name.substring(0,start)+name.substring(end+1);
			
			while ( item.length()>0 ) {				
				end=item.indexOf(',');
				String thisitem="";				
				if (end==-1) {
					thisitem=item;
					item="";
				} else {
					thisitem=item.substring(0,end);
					item=item.substring(end+1);
				}
				if (thisitem.startsWith("PRIORITY(")) {
					priority=Integer.parseInt(thisitem.substring(9,thisitem.length()-1));
					continue;
				}
				if (thisitem.startsWith("COLOR(")) {
					color=Integer.parseInt(thisitem.substring(6,thisitem.length()-1));
					continue;
				}
				throw new IllegalStateException(thisitem);
			}
		}
		
		EmbedTreeNode child = base.getChild(name);
		if (child==null) {
			child=new EmbedTreeNode(name,priority,color);
			base.addChild(child);
		}
		return child;
	}
	
	public void load(BufferedWriteTarget buffer) 
	{
		LinkedList<EmbedTreeNode> stack = new LinkedList<EmbedTreeNode>();
		EmbedTreeNode currentEntry=null;
		
		for (BufferedSegment segment : buffer.getSegments()) {
			Map<String,Object> current = segment.getMetaData();
			
			if (!current.isEmpty()) {
				String type = segment.getMetaData().get("Type").toString();
				
				
				if (type.equals("StartEmbed")) {
					stack.add(currentEntry);
					String tree =  (String)segment.getMetaData("Tree");
					if (tree==null) {
						currentEntry=null;
					} else {
						currentEntry = getNode(tree);
						EmbedPoint e = (EmbedPoint)segment.getMetaData("Embed");
						currentEntry.setEmbedPoint(e,(EmbedKey)segment.getMetaData("Key"));
					}					
				}

				if (type.equals("EndEmbed")) 
				{
					currentEntry=stack.removeLast();
				}

				if (type.equals("StartAdvise")) 
				{
					if (currentEntry!=null) {
						
						Advise advise = (Advise)segment.getMetaData("Advise");
						if (advise instanceof Embed) {
							if (currentEntry.addEntry(new EmbedTreeNodeEntry((Embed)advise))) {
								referencedEmbeds.put((Embed)advise,(Embed)advise);
							}
						}
						
						if (advise instanceof AtAspect) {
							ClarionString description = (ClarionString)segment.getMetaData().get("Description");
							currentEntry.addEntry(new AtTreeNodeEntry(description== null  ? null : description.toString(), advise.getPriority()));
						}
					}
				}
				
				if (type.equals("EndAdvise")) 
				{					
				}
			}
		}
	}
	
	public EmbedTreeNode getRoot()
	{
		return root;
	}
	
	public void log()
	{
		log(root,"");
	}
	
	public void collateOrphanedEmbeds(Procedure procedure)
	{
		Iterator<Embed> scan = procedure.getEmbeds().iterator();
		while (scan.hasNext()) {
			Embed e = scan.next();
			if (referencedEmbeds.containsKey(e)) continue;
			
			EmbedKey key = e.getKey();
			EmbedTreeNode orphaned = root.addChild("Orphaned Embeds",9000).addChild(key.getName(),4999);
			for (int icount=0;icount<key.getInstanceCount();icount++) {
				orphaned=orphaned.addChild(key.getInstance(icount),4999);
			}
			orphaned.addEntry(new EmbedTreeNodeEntry(e));
			referencedEmbeds.put(e,e);
		}		
	}
	
	public void log(EmbedTreeNode base,String depth)
	{
		System.out.println(depth+base.getName());
		depth=depth+"  ";
		for (EmbedTreeNode kid : base.getChildren()) {
			log(kid,depth);
		}
		for (TreeNodeEntry kid : base.getNodes()) {
			System.out.println(depth+(kid instanceof EmbedTreeNodeEntry ? "*" : "" )+kid.getDescription());
		}
	}
}
