package org.jclarion.clarion.ide.editor;


import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.TextAttribute;
import org.eclipse.jface.text.rules.IToken;
import org.eclipse.jface.text.rules.ITokenScanner;
import org.eclipse.jface.text.rules.Token;
import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.widgets.Display;
import org.jclarion.clarion.ide.editor.rule.DocumentLexStream;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class ClarionColorCoder implements ITokenScanner
{
	private static void construct(IToken token,Map<String,IToken> r,String ...items) {
		for (String i : items ) {
			r.put(i,token);
		}
	}	
	
	
	private static Map<LexType,IToken> attributes;
	private static Map<String,IToken>  labels;
	private static Token label;
	private static Token stdprop;
	private static Token def;
	private static Token command;
	private static Token use;
	
	private boolean				newline;
	private DocumentLexStream 	stream;
	private Lexer 				lexer;
	private int					tokenStart;
	private int					tokenEnd;
	private static HashSet<String> stdprefix;

	public ClarionColorCoder()
	{
		if (attributes==null) {
			synchronized(ClarionColorCoder.class) {
				if (attributes==null) {
					attributes=new HashMap<LexType,IToken>();
					attributes.put(LexType.ws, Token.WHITESPACE);
					attributes.put(LexType.eof, Token.EOF);
					Display d = Display.getDefault();
					label=new Token(new TextAttribute(new Color(d,255,60,60),null,SWT.BOLD));
					
					def=new Token(new TextAttribute(new Color(d,0,0,0)));
					use=new Token(new TextAttribute(new Color(d,60,60,60),null,SWT.ITALIC));
					attributes.put(LexType.integer,new Token(new TextAttribute(new Color(d,255,0,255))));
					attributes.put(LexType.decimal,new Token(new TextAttribute(new Color(d,255,0,255))));
					attributes.put(LexType.string,new Token(new TextAttribute(new Color(d,128,128,128))));
					attributes.put(LexType.comment,new Token(new TextAttribute(new Color(d,0,128,0))));
					attributes.put(LexType.operator,new Token(new TextAttribute(new Color(d,192,0,0))));
					attributes.put(LexType.reference,new Token(new TextAttribute(new Color(d,192,0,0))));
					attributes.put(LexType.comparator,new Token(new TextAttribute(new Color(d,192,0,0))));
					attributes.put(LexType.ws,new Token(new TextAttribute(new Color(d,0,128,0))));
					attributes.put(LexType.picture,new Token(new TextAttribute(new Color(d,160,80,0))));
					attributes.put(LexType.implicit,new Token(new TextAttribute(new Color(d,200,80,200),null,SWT.BOLD)));
					
					attributes.put(LexType.dot,def	);
					attributes.put(LexType.other,new Token(new TextAttribute(new Color(d,0,0,0),new Color(d,255,0,0),0)));		
					
					stdprop=new Token(new TextAttribute(new Color(d,40,128,40),null,SWT.BOLD));
					stdprefix=new HashSet<String>();
					stdprefix.add("std");
					stdprefix.add("prop");
					stdprefix.add("event");
					stdprefix.add("color");
					stdprefix.add("font");
					stdprefix.add("icon");
					stdprefix.add("button");
					stdprefix.add("propprint");
					
					labels=new HashMap<String,IToken>();
					
					// keywords
					construct(new Token(new TextAttribute(new Color(d,0,0,128),null,SWT.BOLD)),labels,
							"accept","case","code","data","cycle","else","end","if","of","to",
							"procedure","routine","return","self","then","parent","orof","elsif","loop","while","break","do","execute","exit","times","step","begin");	
					
					// commands
					command=new Token(new TextAttribute(new Color(d,0,0,128)));
					construct(command,labels,
							"alert","bind","unbind","pushbind","popbind","get","set","delete","add","put","sort","nosheet","nobar","wizard",
							"at","font","color","boxed","bevel","center","left","right","mdi","std","use","hide","disable","fill",
							"dim","pre","accepted","field","focus","event","keycode","window","report");

					//types
					construct(new Token(new TextAttribute(new Color(d,160,30,160))),labels,
							"panel","string","sheet","tab","box","option","radio","long","string",
							"short","ulong","ushort","cstring","pstring","decimal","button","check","list","entry","text","combo","group","line","prompt",
							"queue","class");

					//pragma
					construct(new Token(new TextAttribute(new Color(d,0,128,128),null,SWT.BOLD)),labels,
							"null","include","omit","compile","equate");
					
				}
			}
		}		
	}

	@Override
	public void setRange(IDocument document, int offset, int length) 
	{
		stream=new DocumentLexStream(document, offset, length);
		lexer = new Lexer(stream);
		lexer.setJavaMode(false);
		lexer.setIgnoreWhitespace(false);
		lexer.setDecodeInteger(true);
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
		Lex l = lexer.next();		// todo handle OMIT blocks
		
		IToken result = attributes.get(l.type);
		if (result==null) {
			if (l.type==LexType.label) {
				
				if (l.value.equalsIgnoreCase("omit")) {
					stream.mark();
					lexer.setIgnoreWhitespace(true);
					while ( true ) {
						if (lexer.next().type!=LexType.lparam) break;
						stream.mark();
						Lex marker = lexer.next();
						if (marker.type!=LexType.string) break;
						stream.mark();
						if (lexer.next().type!=LexType.rparam) break;
						stream.unmark();
						result=attributes.get(LexType.comment);
						
						while(!stream.eof()) {
							if (stream.readString(marker.value)) break;
							stream.read();
						}
						break;
					}
					lexer.setIgnoreWhitespace(false);
					stream.rewind();
				}
				
				if (newline && result==null) {
					stream.mark();
					
					while (lexer.lookahead(0).type==LexType.dot && lexer.lookahead(1).type==LexType.label) {
						lexer.next();
						lexer.next();
					}

					boolean match=false;
					if (lexer.next().type==LexType.ws && lexer.next().type==LexType.label){
						match=true;
					}
					stream.rewind();
					
					if (match) {
						stream.mark();
						while (lexer.next().type==LexType.dot && lexer.next().type==LexType.label) {
							stream.mark();
						}
						stream.rewind();
						result=label;
					}
				}
				
				if (result==null) {
					result=labels.get(l.value.toLowerCase());
					if (result==null) {
						stream.mark();
						lexer.setIgnoreWhitespace(true);
						if (lexer.next().type==LexType.lparam) {
							result=command;
						}
						stream.rewind();
						lexer.setIgnoreWhitespace(false);
					}
				}
				
				if (result==null) {
					String v = l.value.toLowerCase();
					int e = v.indexOf(':');
					if (e>0) {
						v=v.substring(0,e);
						if (stdprefix.contains(v)) {
							result=stdprop;
						}
					}
				}
			}
			
			if (l.type==LexType.use) {
				result=use;
				stream.mark();
				if (lexer.next().type==LexType.label) {
					stream.unmark();
				} else {
					stream.rewind();
				}
			}
		}
		if (result==null) result=def;

		tokenEnd=stream.getDocumentOffset();		
		newline=l.type==LexType.nl;
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


