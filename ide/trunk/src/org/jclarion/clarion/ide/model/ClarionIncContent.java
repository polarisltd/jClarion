package org.jclarion.clarion.ide.model;

import java.io.StringReader;

import jclarion.Activator;

import org.eclipse.core.resources.IProject;
import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.DocumentEvent;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentListener;
import org.eclipse.jface.text.IRegion;
import org.eclipse.jface.text.Position;

import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.editor.EditorClosedListener;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.jclarion.clarion.lang.LexStream;
import org.jclarion.clarion.lang.Lexer;

/**
 * Clarion *.inc editor's Content Outline model
 */
public class ClarionIncContent extends GenericTreeNode {

	private final IDocument document;
	public final Position position;
	public final String sourceCode;
	//public final WindowDefinitionProvider windowDefinitionProvider;
	private AbstractClarionEditor closeTracker;

	private final Listener listener;

	private String name;
	private IProject project;

	
	
	public ClarionIncContent(AbstractClarionEditor tracker,IProject project,IDocument document, IRegion region, Listener listener) throws BadLocationException {
		super();
		this.project=project;
		this.closeTracker=tracker;
		this.document = document;
		this.position = getPositionIncludingName(document, region);
		this.name = getName(document, region.getOffset(),region.getLength());
		this.sourceCode = document.get(position.offset, position.length);
		//this.windowDefinitionProvider = new C2JWindowDefinitionProvider();
		this.listener = listener;
	}

	
	
	public String getName() {
		return name;
	}

	public synchronized void setName(String name) {
		String oldName = this.name;
		this.name = name;
		if (listener != null) {
			listener.contentChanged();
		}
		doSetName(this.name, oldName);
	}

	/**
	 * Returns <code>true</code> if the offset falls within this model's name
	 */
	public boolean overlapsName(int offset) throws BadLocationException {
		return (offset >= position.offset) && (offset <= (position.offset + getName().length()));
	}

	@Override
	public String toString() {
		return getName();
	}
	
	@Override
	public boolean equals(Object o) {
		if (!(o instanceof ClarionIncContent)) {
			return false;
		}
		ClarionIncContent that = (ClarionIncContent) o;
		return this.sourceCode.equals(that.sourceCode) && this.position.equals(that.position);
	}

	/**
	 * Returns a {@link Position} that includes the name. The window content
	 * type returned by the partitioner starts at <code>WINDOW</code>, so the
	 * position needs to be calculated manually
	 */
	private static Position getPositionIncludingName(IDocument document, IRegion region) throws BadLocationException {
		int nameStartOffset = getNameOffset(document, region.getOffset());
		int lengthDiff = region.getOffset() - nameStartOffset;
		return new Position(nameStartOffset, region.getLength() + lengthDiff);
	}

	/**
	 * Returns the name of the WINDOW, for the WINDOW positioned at
	 * <code>windowOffset</code> within <code>document</code>
	 */
	private static String getName(IDocument document, int windowOffset,int windowLen) throws BadLocationException {
		
		Lexer l = new Lexer(new LexStream(new StringReader(document.get(windowOffset,windowLen)))); 
		l.setIgnoreWhitespace(true);
		
		String name = l.next().value;
		String type = l.next().value;
		
		return type.toUpperCase()+" : "+name;
	}

	/**
	 * Returns the offset of the <code>WINDOW</code>'s name, i.e. the first
	 * character of the line
	 */
	private static int getNameOffset(IDocument document, int offset) throws BadLocationException {
		// Get the line the WINDOW block starts on
		int line = document.getLineOfOffset(offset);

		// Get the offset of the first char on that line, i.e. the start of the
		// WINDOW name
		return document.getLineOffset(line);
	}

	/**
	 * Updates the document with the new name
	 */
	private void doSetName(String name, String oldName) {
		try {
			int diff = oldName.length() - name.length();
			if (diff > 0) {
				// The new name is shorter than the old name, so preserve the
				// WINDOW's position by padding out the new name with whitespace
				String padded = name + getWhitepacePadding(diff);
				document.replace(position.offset, padded.length(), padded);
			} else {
				// The new name is longer than the old name, so insert the new
				// name at the start of the line with the whitespace that
				// already existed separating the new name and WINDOW
				clearAndInsertInDocument(position.offset, oldName.length(), name);
			}
		} catch (BadLocationException e) {
			Activator.getDefault().logError("Failed to update window name name", e);
		}
	}

	private String getWhitepacePadding(int whitespaceBetweenLength) {
		String padding = "";
		for (int i = 0; i < whitespaceBetweenLength; i++) {
			padding += " ";
		}
		return padding;
	}

	public interface Listener {

		public void contentChanged();

	}

	/**
	 * Clears all the text starting at <code>offset</code> and inserts
	 * <code>text</code>
	 */
	private void clearAndInsertInDocument(int offset, int length, String text) throws BadLocationException {
		document.replace(offset, length, text);
		//document.replace(offset, 0, text);
	}
	
	public WindowDefinitionProvider getWindowDefinitionProvider()
	{
		return new C2JWindowDefinitionProvider();
	}

	private class C2JWindowDefinitionProvider implements WindowDefinitionProvider {

		private IDocumentListener listener;
		private int offset;
		private int length;
		
		public C2JWindowDefinitionProvider()
		{
			offset=position.offset;
		}
		
		@Override
		public void startEditSession() {
			
			offset=position.offset;
			length=position.length;
			
			listener=new IDocumentListener() {
				@Override
				public void documentAboutToBeChanged(DocumentEvent event) {
					// TODO Auto-generated method stub
				}

				@Override
				public void documentChanged(DocumentEvent event) {
					if (event.fText==null) return;
					
					int delta = event.fText.length()-event.fLength;
					
					if (event.fOffset<offset) {
						offset+=delta;
						return;
					}
				}
			};
			document.addDocumentListener(listener);
		}

		@Override
		public void finishEditSession() {
			document.removeDocumentListener(listener);
		}		
		
		public String getName() {
			return ClarionIncContent.this.getName();
		}

		@Override
		public String getWindow() {
			return sourceCode;
		}

		@Override
		public void setWindow(String window) {
			try {
				clearAndInsertInDocument(offset, length, window);
				length=window.length();
			} catch (BadLocationException e) {
				Activator.getDefault().logError("Failed to set window: " + window, e);
			}
		}
		
		public int hashCode()
		{
			return offset;
		}

		@Override
		public boolean equals(Object o) {
			if (o == null) {
				return false;
			}
			if (!(o instanceof C2JWindowDefinitionProvider)) {
				return false;
			}
			C2JWindowDefinitionProvider other = (C2JWindowDefinitionProvider) o;
			if (other.document() != document()) {
				return false;
			}
			return other.offset == offset;
		}

		public IDocument document() {
			return ClarionIncContent.this.document;
		}

		@Override
		public IProject getProject() {
			return project;
		}

		@Override
		public ProcedureModel getModel() {
			return null;
		}

		@Override
		public Procedure getDirtyProcedure() {
			return null;
		}

		@Override
		public void addEditorCloseListener(EditorClosedListener listener) {
			if (closeTracker!=null) 
			closeTracker.addEditorCloseListener(listener);
			
		}

		@Override
		public void removeEditorCloseListener(EditorClosedListener listener) {
			if (closeTracker!=null) 
			closeTracker.removeEditorCloseListener(listener);
		}

		@Override
		public void restoreFocus() {
			if (closeTracker!=null) {
				closeTracker.restoreFocus();
			}
		}

		@Override
		public AbstractClarionEditor getParentEditor() {
			return closeTracker;
		}

	}

}
