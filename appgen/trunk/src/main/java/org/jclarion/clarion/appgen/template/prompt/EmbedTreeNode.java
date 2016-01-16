package org.jclarion.clarion.appgen.template.prompt;

import java.util.HashMap;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;

import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.template.cmd.EmbedPoint;

public class EmbedTreeNode implements Comparable<EmbedTreeNode>
{
	private String  					name;
	private int 						priority;
	private int							color;
	private int 						minPriority=10000;
	private int 						maxPriority=1;		
	private Map<Integer,TreeNodeEntry> 	nodes=new TreeMap<Integer,TreeNodeEntry>();
	private EmbedTreeNode 				parent;
	private TreeSet<EmbedTreeNode> 		children=new TreeSet<EmbedTreeNode>();
	private Map<String,EmbedTreeNode>	namedChildren=new HashMap<String,EmbedTreeNode>();
	private EmbedKey key;
	
	public EmbedTreeNode()
	{
	}
	
	public EmbedTreeNode(String name,int priority,int color)
	{
		this.name=name;
		this.priority=priority;
		this.color=color;
	}
	
	public void setEmbedPoint(EmbedPoint point,EmbedKey key)
	{
		if (key==null) {
			minPriority=point.getMinPriority();
			maxPriority=point.getMaxPriority();
		} else {
			if (point.getMinPriority()<minPriority) minPriority=point.getMinPriority();
			if (point.getMaxPriority()>maxPriority) maxPriority=point.getMaxPriority();
		}
		this.key=key;
	}
	
	public int getMinPriority()
	{
		return minPriority;
	}
	
	public int getMaxPriority() {
		return maxPriority;
	}
	
	public EmbedKey getKey()
	{
		return key;
	}
	
	public int getColor()
	{
		return color;
	}
	
	public boolean addEntry (TreeNodeEntry entry)
	{
		if (nodes.containsKey(entry.getPriority())) {
			return false;
		} else {
			nodes.put(entry.getPriority(),entry);
			return true;
		}
	}
	
	public String getName()
	{
		return name;
	}

	@Override
	public int compareTo(EmbedTreeNode o) 
	{
		int diff = priority-o.priority;
		if (diff!=0) return diff;
		
		return name.compareTo(o.name);
		//return instance-o.instance;
	}
	
	public void addChild(EmbedTreeNode child)
	{
		child.parent=this;
		children.add(child);
		namedChildren.put(child.getName(),child);
	}
	
	public EmbedTreeNode getChild(String name)
	{
		return namedChildren.get(name);
	}
	
	public SortedSet<EmbedTreeNode> getChildren()
	{
		return children;
	}
	
	public EmbedTreeNode getParent()
	{
		return parent;
	}
	
	public Iterable<TreeNodeEntry> getNodes()
	{
		return nodes.values();
	}

	public EmbedTreeNode addChild(String name,int priority) 
	{
		EmbedTreeNode node = getChild(name);
		if (node==null) {
			node = new EmbedTreeNode(name,priority,0);
			addChild(node);
		}
		return node;
	}
}