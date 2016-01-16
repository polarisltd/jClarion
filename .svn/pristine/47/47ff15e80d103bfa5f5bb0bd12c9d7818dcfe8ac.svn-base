package org.jclarion.clarion.ide.model;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.NavigableMap;
import java.util.TreeMap;

import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.ILineTracker;
import org.eclipse.jface.text.IRegion;
import org.eclipse.jface.text.ITextStore;
import org.eclipse.jface.text.Region;
import org.jclarion.clarion.appgen.app.Component;
import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.prompt.EmbeditorBlock;

public class EmbeditorTextStore implements ITextStore
{
	private static class Block implements EmbedCode
	{
		private Block 			next;	
		private EmbedKey 		key;
		private Embed    		embed;
		private boolean			dirty;
		private StringBuilder	content;
		private int 			priority;
		private String			indent;
		private int 			documentOffset;
		private int				lineOffset;
		private int[]			lines;
		private Component		store;
		
		
		private boolean forceNewline()
		{
			if (content.length()==0 || content.charAt(content.length()-1)!='\n') {
				content.append('\n');
				genLines();
				return true;
			}
			genLines();
			return false;
		}
		
		private void genLines()
		{
			// firstly collate number of lines
			int lc=0;
			for (int scan=0;scan<content.length();scan++) {
				if (content.charAt(scan)=='\n') {
					lc++;
				}
			}
			lines=new int[lc];
			lc=1;
			for (int scan=0;scan<content.length();scan++) {
				if (content.charAt(scan)=='\n') {
					if (lc<lines.length) {
						lines[lc]=scan+1;
					}
					lc++;
				}
			}
		}

		@Override
		public String getContent() {
			return content.toString();
		}

		@Override
		public Embed getExistingEmbed() {
			return embed;
		}

		@Override
		public EmbedKey getEmbedKey() {
			return key;
		}

		@Override
		public String getIndent() {
			return indent;
		}

		@Override
		public int getPriority() {
			return priority;
		}

		@Override
		public void setEmbed(Embed e) {
			this.embed=e;
			this.dirty=false;
		}
		
		public Component getEmbedStore()
		{
			return store;
		}
	}
	
	private TreeMap<Integer,Block> positions;
	private TreeMap<Integer,Block> lines;
	private Block first=null;
	private Block lastGood=null;
	private int   length=0;
	private int   lineLength=0;
	private boolean	dirty;
	
	public void replace(EmbeditorTextStore newStore) {
		
		Map<EmbedPriorityKey,Block> dirtyChangesSoFar = new HashMap<EmbedPriorityKey,Block>();
		Block scan=first;
		while (scan!=null) {
			if (scan.key!=null && scan.dirty) {
				dirtyChangesSoFar.put(new EmbedPriorityKey(scan.key,scan.priority),scan);
			}
			scan=scan.next;
		}
		
		this.positions=newStore.positions;
		this.lines=newStore.lines;
		this.first=newStore.first;
		this.lastGood=newStore.lastGood;
		this.length=newStore.length;
		this.lineLength=newStore.lineLength;
		this.dirty=false;
		
		
		if (!dirtyChangesSoFar.isEmpty()) {
			int ofsAdjust=0;
			int lineAdjust=0;
			scan=first;
			while(scan!=null) {
				scan.documentOffset+=ofsAdjust;
				scan.lineOffset+=lineAdjust;
				if (scan.key!=null) {
					Block ob = dirtyChangesSoFar.remove(new EmbedPriorityKey(scan.key,scan.priority));
					if (ob!=null) {
						if (!dirty) {
							lastGood=scan;
							positions=new TreeMap<Integer,Block>(positions.headMap(lastGood.documentOffset,true));
							lines=new TreeMap<Integer,Block>(lines.headMap(lastGood.lineOffset,true));
						}
						
						ofsAdjust+=ob.content.length()-scan.content.length();
						lineAdjust=ob.lines.length-scan.lines.length;
						scan.content=ob.content;
						scan.lines=ob.lines;
						scan.dirty=true;
						dirty=true;
					}
				}
				scan=scan.next;
			}
			lineLength+=lineAdjust;
			length+=ofsAdjust;			
		}
	}
	
	
	public EmbeditorTextStore(EmbeditorBlock block)
	{
		positions=new TreeMap<Integer,Block>();
		lines=new TreeMap<Integer,Block>();
		
		Block last=null;
		int offsetSoFar=0;
		int linesSoFar=0;
		
		while (block!=null) {
			Block b=  new Block();
			if (last==null) {
				first=b;
			} else {
				last.next=b;
			}
			last=b;

			
			b.key=block.getKey();
			if (b.key!=null) {
				AtSource origin = block.getOrigin();
				while (!(origin instanceof Component)) {
					origin=origin.getParent();
				}
				b.store=(Component)origin;
			}
			b.embed=block.getEmbed();
			b.content=new StringBuilder(block.getWriter().toString());
			b.priority=block.getPriority();
			b.indent=block.getIndent();
			b.documentOffset=offsetSoFar;
			b.forceNewline();
			b.lineOffset=linesSoFar;
			offsetSoFar+=b.content.length();
			linesSoFar+=b.lines.length;
			positions.put(b.documentOffset, b);
			lines.put(b.lineOffset,b);
			
			
			block=block.getNext();			
		}
		
		length=offsetSoFar;
		lineLength=linesSoFar;
	}

	private void rebuildTree(int endPos,int endLine)
	{
		if (lastGood==null) return;		
		while (lastGood!=null) {
			if (endPos>-1 && lastGood.documentOffset+lastGood.content.length()>endPos) break;
			if (endLine>-1 && lastGood.lineOffset+lastGood.lines.length>endLine) break;
			
			int offset =  lastGood.documentOffset+lastGood.content.length();
			int lineOffset = lastGood.lineOffset + lastGood.lines.length;
			lastGood=lastGood.next;
			if (lastGood==null) break;
			positions.put(offset,lastGood);
			lines.put(lineOffset,lastGood);
			lastGood.documentOffset=offset;
			lastGood.lineOffset=lineOffset;
		}
	}

	@Override
	public char get(int offset) {
		rebuildTree(offset,-1);		
		NavigableMap<Integer,Block> head = positions.headMap(offset,true);
		if (head.isEmpty()) throw new IllegalStateException("Out of range");
		Block next = head.lastEntry().getValue();
		
		offset=offset-next.documentOffset;
		
		if (offset<0 || offset>=next.content.length()) throw new IllegalStateException("Out of range");
		return next.content.charAt(offset);
	}

	@Override
	public String get(int offset, int length) {
		rebuildTree(offset,-1);
		NavigableMap<Integer,Block> head = positions.headMap(offset,true);
		if (head.isEmpty()) throw new IllegalStateException("Out of range");
		Block next = head.lastEntry().getValue();

		StringBuilder out = new StringBuilder();
		offset=offset-next.documentOffset;
		if (offset<0 ) throw new IllegalStateException("Out of range");
		
		while (length>0) {
			int read = next.content.length()-offset;
			if (read>length) {
				read=length;
			}			
			out.append(next.content,offset,offset+read);
			next=next.next;
			offset=0;
			length=length-read;
		}
		
		return out.toString();
	}

	@Override
	public int getLength() {
		return length;
	}
	
	public static class DirtyIterator implements Iterator<EmbedCode> 
	{
		private Block next;

		public DirtyIterator(Block block)
		{
			this.next=block;
		}

		@Override
		public boolean hasNext() {
			while (next!=null && !next.dirty) {
				next=next.next;
			}
			return next!=null;
		}

		@Override
		public EmbedCode next() {
			hasNext();
			EmbedCode result = next;
			next=next.next;
			return result;
		}

		@Override
		public void remove() {
		}
	}
	
	
	public Iterable<EmbedCode> getDirtyEmbeds()
	{
		return new Iterable<EmbedCode>() {
			@Override
			public Iterator<EmbedCode> iterator() {
				return new DirtyIterator(first);
			}
		};
	}
	
	public void flagAsNotDirty() {
		Block scan=first;
		while (scan!=null) {
			scan.dirty=false;
			scan=scan.next;
		}
		dirty=false;
	}


	@Override
	public void replace(int offset, int length, String text) 
	{
		rebuildTree(offset,-1);
		NavigableMap<Integer,Block> head = positions.headMap(offset,true);
		if (head.isEmpty()) throw new IllegalStateException("Out of range");
		Block next = head.lastEntry().getValue();
		offset=offset-next.documentOffset;
		if (offset<0 ) throw new IllegalStateException("Out of range");

		if (offset+length>next.content.length()) {
			throw new IllegalStateException("Replace crosses multiple partitions");
		}
		
		if (next.key==null) {
			throw new IllegalStateException("Cannot replace autogenerated source code");
		}
		
		int oldLineCount=next.lines.length;
		
		next.dirty=true;
		next.content.replace(offset, offset+length, text);
		this.length=this.length-length+text.length();
		if (next.forceNewline()) {
			this.length++;
		}
		
		int newLineCount=next.lines.length;
		dirty=true;
		
		
		
		positions=new TreeMap<Integer,Block>(head);
		lastGood=positions.lastEntry().getValue();		
		
		lineLength=lineLength-oldLineCount+newLineCount;
		lines=new TreeMap<Integer,Block>(lines.headMap(lastGood.lineOffset,true));
	}
	
	
	
	public Object getComponent(int lineOffset) {
		rebuildTree(lineOffset, -1);
		NavigableMap<Integer, Block> head = positions.headMap(lineOffset,
				true);
		if (head.isEmpty())
			throw new IllegalStateException("Out of range");
		Block next = head.lastEntry().getValue();
		return next;		
	}
	
	public boolean isReadOnly(int lineOffset) {
		rebuildTree(lineOffset, -1);
		NavigableMap<Integer, Block> head = positions.headMap(lineOffset,
				true);
		if (head.isEmpty())
			throw new IllegalStateException("Out of range");
		Block next = head.lastEntry().getValue();
		return next.key == null;
	}

	@Override
	public void set(String text) {
		throw new IllegalStateException(
				"Disallowed! Only Replace is supported");
	}

	private final static String[] delimiters = new String[] { "\n", "\r\n" };

	public ILineTracker getLineTracker()
	{
		return new LineTracker();
	}
	
	private class LineTracker implements ILineTracker { 

		@Override
		public void set(String text) {
			throw new IllegalStateException(
					"Disallowed! Only Replace is supported");
		}

		@Override
		public String[] getLegalLineDelimiters() {
			return delimiters;
		}

		@Override
		public String getLineDelimiter(int line) throws BadLocationException {
			rebuildTree(-1, line);
			NavigableMap<Integer, Block> head = lines.headMap(line, true);
			if (head.isEmpty())
				throw new BadLocationException("Out of range");
			Block next = head.lastEntry().getValue();

			line = line - next.lineOffset + 1;
			int end = line >= next.lines.length ? next.content.length()
					: next.lines[line];

			if (end == 1)
				return delimiters[0];
			if (next.content.charAt(end - 2) == '\r')
				return delimiters[1];
			return delimiters[0];
		}

		@Override
		public int computeNumberOfLines(String text) {
			int count=0;
			for (int scan=0;scan<text.length();scan++) {
				if (text.charAt(scan)=='\n') {
					count++;
				}
			}
			return count;
		}

		@Override
		public int getNumberOfLines() {
			return lineLength;
		}

		@Override
		public int getNumberOfLines(int offset, int length)
				throws BadLocationException {
			return getLineNumberOfOffset(offset + length)
					- getLineNumberOfOffset(offset) + 1;
		}

		@Override
		public int getLineOffset(int line) throws BadLocationException {
			rebuildTree(-1, line);
			NavigableMap<Integer, Block> head = lines.headMap(line, true);
			if (head.isEmpty())
				throw new BadLocationException("Out of range");
			Block next = head.lastEntry().getValue();
			line = line - next.lineOffset;
			return next.lines[line] + next.documentOffset;
		}

		@Override
		public int getLineLength(int line) throws BadLocationException {
			rebuildTree(-1, line);
			NavigableMap<Integer, Block> head = lines.headMap(line, true);
			if (head.isEmpty())
				throw new BadLocationException("Out of range");
			Block next = head.lastEntry().getValue();
			line = line - next.lineOffset;

			if (line + 1 == next.lines.length) {
				return next.content.length() - next.lines[line];
			} else {
				return next.lines[line + 1] - next.lines[line];
			}
		}

		@Override
		public int getLineNumberOfOffset(int offset)
				throws BadLocationException {
			rebuildTree(offset, -1);
			NavigableMap<Integer, Block> head = positions.headMap(offset, true);
			if (head.isEmpty())
				throw new BadLocationException("Out of range");
			Block next = head.lastEntry().getValue();

			offset = offset - next.documentOffset;

			for (int scan = 0; scan < next.lines.length; scan++) {
				if (next.lines[scan] > offset) {
					return next.lineOffset + scan - 1;
				}
			}
			return next.lineOffset + next.lines.length - 1;
		}

		@Override
		public IRegion getLineInformationOfOffset(int offset)
				throws BadLocationException {
			rebuildTree(offset, -1);
			NavigableMap<Integer, Block> head = positions.headMap(offset, true);
			if (head.isEmpty())
				throw new BadLocationException("Out of range");
			Block next = head.lastEntry().getValue();

			offset = offset - next.documentOffset;

			int line = next.lines.length - 1;

			for (int scan = 0; scan < next.lines.length; scan++) {
				if (next.lines[scan] > offset) {
					line = scan - 1;
					break;
				}
			}

			int end = line + 1 < next.lines.length ? next.lines[line + 1]
					: next.content.length();
			end--;
			if (end > 0 && next.content.charAt(end) == '\r')
				end--;
			return new Region(next.lines[line] + next.documentOffset, end
					- next.lines[line]);
		}

		@Override
		public IRegion getLineInformation(int line) throws BadLocationException {
			rebuildTree(-1, line);
			NavigableMap<Integer, Block> head = lines.headMap(line, true);
			if (head.isEmpty())
				throw new BadLocationException("Out of range");
			Block next = head.lastEntry().getValue();
			line = line - next.lineOffset;

			int end = line + 1 < next.lines.length ? next.lines[line + 1]
					: next.content.length();
			end--;
			if (end > 0 && next.content.charAt(end) == '\r')
				end--;
			return new Region(next.lines[line] + next.documentOffset, end
					- next.lines[line]);
		}

		@Override
		public void replace(int offset, int length, String text) throws BadLocationException {
		}
	}


	public boolean isDirty() {
		return dirty;
	}


}
