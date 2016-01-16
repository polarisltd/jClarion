package org.jclarion.clarion;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.jface.text.Document;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentExtension3;
import org.eclipse.jface.text.IDocumentPartitioner;
import org.eclipse.jface.text.ITypedRegion;

import org.jclarion.clarion.ide.editor.ClarionIncDocumentSetupParticipant;
import org.jclarion.clarion.ide.editor.ClarionIncPartitionScanner;
import org.jclarion.clarion.ide.editor.ClarionIncSourceViewerConfiguration;
import org.jclarion.clarion.ide.model.ClarionIncContent;

public class TestUtils {

	public static IDocument createDocument(String fileName) throws IOException {
		return new Document(readFile(fileName));
	}

	/**
	 * Partitions the document and returns all the {@link ITypedRegion}
	 * {@link ClarionIncPartitionScanner#CLARION_INC_COMMENT_CONTENT_TYPE}s
	 */
	public static ITypedRegion[] getWindowContentTypes(IDocument document) throws IOException {
		new ClarionIncDocumentSetupParticipant().setup(document);

		IDocumentPartitioner partitioner = ((IDocumentExtension3) document).getDocumentPartitioner(
				new ClarionIncSourceViewerConfiguration().getConfiguredDocumentPartitioning(null));

		List<ITypedRegion> windows = new ArrayList<ITypedRegion>();
		for (ITypedRegion region : partitioner.computePartitioning(0, document.getLength())) {
			if (region.getType().equals(ClarionIncPartitionScanner.CLARION_INC_WINDOW_CONTENT_TYPE)) {
				windows.add(region);
			}
		}

		return (ITypedRegion[]) windows.toArray(new ITypedRegion[windows.size()]);
	}

	/**
	 * Partitions the document and returns the first window content type wrapped
	 * in a {@link ClarionIncContent} model
	 */
	public static ClarionIncContent getFirstClarionIncContent(IDocument document) throws Exception {
		ITypedRegion region = TestUtils.getWindowContentTypes(document)[0];
		return new ClarionIncContent(null,null,document, region, null);
	}

	public static String readFile(String fileName) throws IOException {
		BufferedReader reader = new BufferedReader(new FileReader(fileName));
		StringBuilder builder = new StringBuilder();
		for (String line = reader.readLine(); line != null; line = reader.readLine()) {
			builder.append(line).append("\n");
		}
		reader.close();
		return builder.toString();
	}

}
