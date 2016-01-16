package org.jclarion.clarion.appgen.template.prompt;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;

import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.embed.Advise;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.template.BufferedSegment;
import org.jclarion.clarion.appgen.template.BufferedWriteTarget;
import org.jclarion.clarion.appgen.template.at.AtAspect;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.cmd.EmbedPoint;
import org.jclarion.clarion.util.SharedWriter;

public class EmbedEditor {

	private static class EmbedStack
	{
		private EmbedPoint			embed;
		private EmbedKey			key;
		private int 				lastPriority;
		private boolean				lastAspectHadContent;
		private Map<String,Object>	data;
		private AspectStack			parent;		
		private boolean				empty=true;
		public AtSource origin;
	}
	
	private static class AspectStack
	{
		private Embed				embed;
		private EmbedStack			parent;
	}
	
	private AspectStack aspect=new AspectStack();	
	private EmbedStack embed=new EmbedStack();
	
	private EmbeditorBlock first;
	private EmbeditorBlock last;
	
	
	public static class BufferedReader implements Iterator<BufferedSegment>
	{
		private Iterator<BufferedSegment> segment;
		private LinkedList<BufferedSegment> readahead=new LinkedList<BufferedSegment>();
		
		public BufferedReader(Iterator<BufferedSegment> segment)
		{
			this.segment=segment;
		}
		
		
		@Override
		public boolean hasNext()
		{
			if (!readahead.isEmpty()) return true;
			return segment.hasNext();
		}
		
		@Override
		public BufferedSegment next()
		{
			if (!readahead.isEmpty()) return readahead.removeFirst();
			return segment.next();
		}


		@Override
		public void remove() {
		}
		
		private class ReadAheadIterator implements Iterator<BufferedSegment>
		{
			private Iterator<BufferedSegment> priorBuffer;
			
			public ReadAheadIterator()
			{
				if (!readahead.isEmpty()) {
					priorBuffer=readahead.iterator();
				}
			}

			@Override
			public boolean hasNext() {
				if (priorBuffer!=null) {
					if (priorBuffer.hasNext()) return true;
					priorBuffer=null;
				}
				return segment.hasNext();
			}

			@Override
			public BufferedSegment next() {
				if (priorBuffer!=null) {
					if (priorBuffer.hasNext()) return priorBuffer.next();
					priorBuffer=null;
				}
				BufferedSegment bs = segment.next();
				readahead.addLast(bs);
				return bs;
			}

			@Override
			public void remove() {
			}
			
		}
		
		public Iterator<BufferedSegment> readahead()
		{
			return new ReadAheadIterator();
		}
	}
	
	private boolean detailed;
	
	public EmbedEditor()
	{
		detailed=true;
	}
	
	public EmbedEditor(boolean detailed)
	{
		this.detailed=detailed;
	}
	
	private SharedWriter getReadOnlyBlock()
	{
		if (last.getKey()==null) return last.getWriter();
		EmbeditorBlock n = new EmbeditorBlock();
		last=last.add(n);
		return last.getWriter();
	}
	
	private void print(CharSequence output)
	{
		try {
			getReadOnlyBlock().append(output);
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	
	public EmbeditorBlock load(BufferedWriteTarget buffer) 
	{
		first=new EmbeditorBlock();
		last=first;
		
		aspect=new AspectStack();	
		embed=new EmbedStack();
		aspect.parent=embed;
		
		String depth="";
		
		BufferedReader reader = new BufferedReader(buffer.getSegments().iterator());
		
		while (reader.hasNext()) {
			BufferedSegment segment = reader.next();
			Map<String,Object> current = segment.getMetaData();
			
			if (!current.isEmpty()) {
				String type = segment.getMetaData().get("Type").toString();
				
				
				if (type.equals("StartEmbed")) {				
					embed = new EmbedStack();
					embed.parent=aspect;
					embed.data=current;		
					embed.lastPriority=1;
					embed.embed=(EmbedPoint)current.get("Embed");
					embed.key=(EmbedKey)current.get("Key");
					embed.origin=(AtSource)current.get("Source");
					embed.lastAspectHadContent=true;
					if (embed.embed.getMinPriority()<=1) {
						if (detailed) {
							print(embed.data.get("Indent")+"! Start of \""+embed.data.get("Description")+"\"\n");
						}
					} else {
						embed.lastAspectHadContent=false;
					}
				}

				if (type.equals("EndEmbed")) {
					if (embed.empty) {
						embed.lastAspectHadContent=true;
					}
					insertEmbed(embed.embed.getMaxPriority(),embed.data.get("Indent").toString());
					if ((embed.embed.getMaxPriority()==10000)) {
						if (detailed) {
							print(embed.data.get("Indent")+"! End of \""+embed.data.get("Description")+"\"\n");
						}
					}
					aspect=embed.parent;
					embed=aspect.parent;
				}

				if (type.equals("StartAdvise")) 
				{
					this.aspect=new AspectStack();
					this.aspect.parent=embed;
					
					
					Advise advise = (Advise)segment.getMetaData("Advise");
					if (advise instanceof Embed) {
						this.aspect.embed=(Embed)advise;
						if (detailed) {
							print(current.get("Indent")+"! [Priority "+advise.getPriority()+"]\n");
						}
						embed.lastAspectHadContent=false;
						embed.empty=false;
						
						EmbeditorBlock block = new EmbeditorBlock(embed.origin,aspect.embed,current.get("Indent").toString());
						last=last.add(block);						
					}
					if (advise instanceof AtAspect) {
						insertEmbed(advise.getPriority(),current.get("Indent").toString());
						
						boolean filter = (Boolean)current.get("Filtered");
						Object o=current.get("Description");
						String newDescription = o==null || filter ? null : o.toString();

						if (newDescription!=null) {
							embed.lastAspectHadContent=true;
							if (detailed) {
								print(current.get("Indent")+"! "+newDescription+"\n");
							}
						}
					}
				}
				
				if (type.equals("EndAdvise")) {					
					if (aspect.embed!=null) {
						embed.lastAspectHadContent=false;
					}
					aspect=null;
				}

				if (type.startsWith("End")) {
					depth=depth.substring(0,depth.length()-4);
				}
					
				
				if (type.startsWith("Start")) {
					depth=depth+"    ";
				}
			} else {
				if (segment.getWriter().getSize()>0) {
					if (aspect==null || aspect.embed==null) {
						print(segment.getWriter());
					} else {
						try {
							last.getWriter().append(segment.getWriter());
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					embed.lastAspectHadContent=true;
				}
			}
		}
		
		print("\n");
		
		return first;
	}

	private void insertEmbed(int priority,String indent) 
	{
		if (!embed.lastAspectHadContent) {
			embed.lastPriority=priority;
			return;
		}
		embed.empty=false;
		embed.lastAspectHadContent=false;		
		if (priority==embed.lastPriority) return;
		
		int thisPriority =calcPriority(embed.lastPriority,priority);

		if (detailed) {
			print(indent+"! [Priority "+thisPriority+"]\n");		
			EmbeditorBlock block = new EmbeditorBlock(embed.origin,embed.key,thisPriority,indent);
			last=last.add(block);
		}
		
		embed.lastPriority=priority;
	}
	
	private int diff(int p1,int p2) {
		return p2>p1 ? p2-p1 : p1-p2;
	}

	private int calcPriority(int p1,int p2) {
		int diff=0;
		
		int space = diff(p1,p2);
		
		if (space<=20) {
			diff=(p1+p2+1)/2;
		} else if (space<=200) {
			diff=((p1+p2)/2+9)/10*10;
		} else {
			diff=((p1+p2)/2+50)/100*100;
		}
		return diff;
	}

}
