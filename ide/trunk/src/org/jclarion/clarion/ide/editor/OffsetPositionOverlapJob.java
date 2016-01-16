package org.jclarion.clarion.ide.editor;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.core.runtime.jobs.Job;
import org.eclipse.jface.text.BadPositionCategoryException;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.Position;

/**
 * A job that notifies listeners when the offset, e.g. caret or change event,
 * overlaps with any of a document's positions
 */
public class OffsetPositionOverlapJob extends Job {

	private final IDocument document;
	private final String positionCategory;
	private final List<Listener> listeners;

	private int offset;

	public OffsetPositionOverlapJob(IDocument document, String positionCategory) {
		super("Offset position overlap job");
		this.document = document;
		this.positionCategory = positionCategory;
		this.listeners = new ArrayList<OffsetPositionOverlapJob.Listener>(1);
		setPriority(Job.DECORATE); // Lowest priority job
	}

	public int getOffset() {
		return offset;
	}

	public void setOffsetAndSchedule(int offset) {
		this.offset = offset;
		schedule();
	}

	public void addListener(Listener listener) {
		if (!listeners.contains(listener)) {
			listeners.add(listener);
		}
	}

	@Override
	protected final synchronized IStatus run(IProgressMonitor monitor) {
		// Copy the value as it may change during execution
		int offsetCopy = getOffset();
		Position overlappingPosition = null;
		try {
			for (Position position : document.getPositions(positionCategory)) {
				if (position.overlapsWith(offsetCopy, 1)) {
					overlappingPosition = position;
					break;
				}
			}
		} catch (BadPositionCategoryException e) {
			//Activator.getDefault().logError("Cannot determine partition at offset " + offsetCopy, e);
			return Status.OK_STATUS;
		}
		for (Listener listener : listeners) {
			listener.overlappingPositionFound(overlappingPosition);
		}
		return Status.OK_STATUS;
	}

	public interface Listener {

		/**
		 * The position the {@link OffsetPositionOverlapJob} detected the offset
		 * overlapped with, or <code>null</code> if no overlapping positions
		 * found
		 */
		public void overlappingPositionFound(Position position);

	}

}
