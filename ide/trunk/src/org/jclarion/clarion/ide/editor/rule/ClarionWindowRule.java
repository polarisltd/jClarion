package org.jclarion.clarion.ide.editor.rule;


import java.io.StringReader;
import java.util.HashSet;
import java.util.Set;

import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.rules.IPartitionTokenScanner;
import org.eclipse.jface.text.rules.IToken;
import org.eclipse.jface.text.rules.Token;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class ClarionWindowRule implements IPartitionTokenScanner
{
	// items in a window that can be nested
	private static Set<String> nestableTypes=construct("SHEET","TAB","GROUP","OPTION","DETAIL","HEADER","FOOTER","BREAK");
	
	// window is damaged when these are encountered
	private static Set<String> damagedTypes=construct("CODE","PROCEDURE","DATA","FUNCTION","ROUTINE","WINDOW","REPORT","MAP");
	
	private static Set<String> construct(String ...items) {
		HashSet<String> r = new HashSet<String>();
		for (String i : items ) {
			r.add(i);
		}
		return r;
	}	
	
	private boolean				newline;
	private DocumentLexStream 	stream;
	private Lexer 				lexer;
	private int					tokenStart;
	private int					tokenEnd;

	private IToken success;
	
	public ClarionWindowRule(IToken success)
	{
		this.success=success;
	}

	@Override
	public void setPartialRange(IDocument document, int offset, int length,String contentType, int partitionOffset) 
	{
		if (partitionOffset==-1) partitionOffset=0;
		setRange(document,partitionOffset,length+offset-partitionOffset);
	}

	@Override
	public void setRange(IDocument document, int offset, int length) 
	{
		lexer = new Lexer(new StringReader(""));
		lexer.setJavaMode(false);
		lexer.setIgnoreWhitespace(false);
		stream=new DocumentLexStream(document, offset, length);
		lexer.setStream(stream);
		newline=true;
		
		try {
			if (offset>0) {
				int line =document.getLineOfOffset(offset);
				int startOfLine = document.getLineOffset(line);
				if (startOfLine!=offset) {
					newline=false;
				}
			}
		} catch (BadLocationException ex) {
			ex.printStackTrace();
		}
		
		
		
	}
	
	
	@Override
	public IToken nextToken() {
		tokenStart=stream.getDocumentOffset();
		
		while ( true ) {
			while (!newline) {
				Lex next = lexer.next();
				if (next.type==LexType.eof) return finish(Token.EOF);
				if (next.type==LexType.nl) newline=true;
			}
			
			tokenStart=stream.getDocumentOffset();

			Lex next = lexer.next();
			if (next.type==LexType.eof) return finish(Token.EOF);
			if (next.type==LexType.nl) continue;
			newline=false;
			
			if (next.type!=LexType.label) continue;
			
			if (lexer.next().type!=LexType.ws) continue;
			
			next = lexer.next();
			if (next.type!=LexType.label) continue;
			if (!next.value.equalsIgnoreCase("window") && !next.value.equalsIgnoreCase("report")) continue;

			int mode=2;	//		0 = start new line.  1 = label/ws read.  2 = guts of the control	
			int depth=1;
			while(depth>0) {				
				// read until depth is back to zero
				
				Lex scan = lexer.next();
				if (scan.type==LexType.eof) {
					return finish(Token.EOF);				
				}
				if (scan.type==LexType.nl) {
					newline=true;
					mode=0;
					continue;
				}
				newline=false;
					
				if (mode<2 && (scan.type==LexType.dot || (scan.type==LexType.label && scan.value.equalsIgnoreCase("end")))) {
					depth--;
					mode=1;
					continue;
				}
					
				if (mode==0 && (scan.type==LexType.label || scan.type==LexType.ws)) {
					mode=1;
					continue;
				}
					
				if (mode==1) {
					if (scan.type==LexType.label) {
						String t=  scan.value.toUpperCase();
						if (damagedTypes.contains(t)) {
							return finish(Token.UNDEFINED);		
						}
						if (nestableTypes.contains(t)) {
							depth++;
						}
						mode=2;
					}
				}
			}
			return finish(success);
		}
	}
	
	private IToken finish(IToken result) {
		tokenEnd=stream.getDocumentOffset();
		if (result.isEOF() && tokenEnd!=tokenStart) result=Token.UNDEFINED;
		return result;
	}

	@Override
	public int getTokenOffset() {
		return tokenStart;
	}

	@Override
	public int getTokenLength() {
		return tokenEnd-tokenStart;
	}
}