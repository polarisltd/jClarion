package org.jclarion.clarion.control;

import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.Shape;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;
import javax.swing.JSeparator;
import javax.swing.Timer;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.DefaultHighlighter;
import javax.swing.text.Document;
import javax.swing.text.JTextComponent;
import javax.swing.text.LayeredHighlighter;
import javax.swing.text.Position;
import javax.swing.text.StyledDocument;
import javax.swing.text.View;
import javax.swing.text.Highlighter.Highlight;

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.file.ClarionFileFactory;
import org.jclarion.clarion.file.InputStreamWrapper;

import com.swabunga.spell.engine.SpellDictionaryHashMap;
import com.swabunga.spell.engine.Word;
import com.swabunga.spell.event.SpellCheckEvent;
import com.swabunga.spell.event.SpellCheckListener;
import com.swabunga.spell.event.StringWordTokenizer;

public class SpellChecker 
{
	private static SpellChecker sInstance=new SpellChecker();
	
	public static SpellChecker getInstance()
	{
		return sInstance;		
	}

	public static class MyDocumentListener implements DocumentListener, ActionListener
	{
		private Timer timer;
		private JTextComponent component;
		
		public MyDocumentListener(JTextComponent c)
		{
			this.component=c;
		}
		
		private void reset()
		{
			if (timer!=null) {
				timer.stop();
			}
			timer=new Timer(1000,this);
			timer.setRepeats(false);
			timer.start();
		}
		
		@Override
		public void changedUpdate(DocumentEvent e) {
			reset();
		}

		@Override
		public void insertUpdate(DocumentEvent e) {
			reset();
		}

		@Override
		public void removeUpdate(DocumentEvent e) {
			reset();
		}

		@Override
		public void actionPerformed(ActionEvent e) {
			getInstance().spellCheck(component);
		}		
	}
	
	
	public LayeredHighlighter.LayerPainter underline = new LayeredHighlighter.LayerPainter() { 
		java.awt.Color color = java.awt.Color.RED; 
		public void paint(Graphics g, int offs0, int offs1, Shape bounds,
				JTextComponent c) {
			// Do nothing: this method will never be called
		}

		
    public Shape paintLayer(Graphics g, int offs0, int offs1, Shape bounds,
        JTextComponent c, View view) {
      g.setColor(color == null ? c.getSelectionColor() : color);

      Rectangle alloc = null;
      if (offs0 == view.getStartOffset() && offs1 == view.getEndOffset()) {
        if (bounds instanceof Rectangle) {
          alloc = (Rectangle) bounds;
        } else {
          alloc = bounds.getBounds();
        }
      } else {
        try {
          Shape shape = view.modelToView(offs0,
              Position.Bias.Forward, offs1,
              Position.Bias.Backward, bounds);
          alloc = (shape instanceof Rectangle) ? (Rectangle) shape
              : shape.getBounds();
        } catch (BadLocationException e) {
          return null;
        }
      }

      FontMetrics fm = c.getFontMetrics(c.getFont());
      int baseline = alloc.y + alloc.height - fm.getDescent() + 1;
     
      /*
      int ofs[]=new int[] { 0,1,2,1 };
      int inc[]=new int[] { 3,1,3,1 };
      
      int scan=0;
      int mode=0;
      while (scan<alloc.width) {
    	  int from=scan;
    	  scan+=inc[mode];
    	  if (scan>=alloc.width) { scan=alloc.width; }

    	  int height=ofs[mode];
    	  g.drawLine(alloc.x+from, baseline+height, alloc.x + scan, baseline+height);
    	  mode=mode+1;
    	  if (mode==ofs.length) mode=0;
      }
      */
      
      g.drawLine(alloc.x, baseline + 1, alloc.x + alloc.width,baseline + 1);
      g.drawLine(alloc.x, baseline, alloc.x + alloc.width,baseline);

      return alloc;
    }
  };		

  
	private SpellDictionaryHashMap dictionary;
	private boolean base=false;
	
	public SpellChecker()
	{
		try {
			dictionary =new SpellDictionaryHashMap() {
				@Override
				protected void putWordUnique(String arg0) 
				{
					super.putWord(arg0);
				}
			};
		} catch (IOException e) {
			e.printStackTrace();
		}	
		if (load("resource:/resources/dict/english.txt")) {
			base=true;
		} else {
			if (load("english.txt")) base=true;
		}
		load(new File("custom.dict"));
	}

	public void spellCheck(final JTextComponent jta)
	{
        final DefaultHighlighter dh = (DefaultHighlighter)jta.getHighlighter();
        dh.removeAllHighlights();
        com.swabunga.spell.event.SpellChecker sc = new com.swabunga.spell.event.SpellChecker(dictionary);
        sc.addSpellCheckListener(new SpellCheckListener() {
			@Override
			public void spellingError(SpellCheckEvent arg0) 
			{
				int pos = arg0.getWordContextPosition();
		        try {
					dh.addHighlight(pos,pos+arg0.getInvalidWord().length(),underline);
				} catch (BadLocationException e1) {
					e1.printStackTrace();
				}
			}
		});
        try {
			sc.checkSpelling(new StringWordTokenizer(jta.getText(0,jta.getDocument().getLength())));
		} catch (BadLocationException e) {
			e.printStackTrace();
		}

	}
	
	public void init(final JTextComponent jta,final TextControl control) 
	{
		if (!base) return;
        DefaultHighlighter dh = new DefaultHighlighter();
        jta.setHighlighter(dh);
        spellCheck(jta);
        
        jta.getDocument().addDocumentListener(new MyDocumentListener(jta));
        
        if (control.isProperty(Prop.READONLY)) return;
        	
		jta.addMouseListener(
				new MouseListener() {
					@SuppressWarnings("unchecked")
					@Override
					public void mouseClicked(MouseEvent e) {
						if (e.getButton()==3) {
							int pos=jta.viewToModel(e.getPoint());
							for (Highlight h : jta.getHighlighter().getHighlights()) {
								final int from = h.getStartOffset();
								final int to = h.getEndOffset();
								if (from<=pos && to>=pos) {
									try {
										final String word= jta.getText(h.getStartOffset(),h.getEndOffset()-h.getStartOffset());
								        com.swabunga.spell.event.SpellChecker sc = new com.swabunga.spell.event.SpellChecker(dictionary);
								        List<Word> l = sc.getSuggestions(word,140);
								        JPopupMenu jpm = new JPopupMenu();
								        for (final Word s : l ) {
								        	JMenuItem jmi=new JMenuItem(s.getWord());
								        	jpm.add(jmi);
								        	final int f_pos=pos;
								        	jmi.addActionListener(new ActionListener(){
												@Override
												public void actionPerformed(ActionEvent e) 
												{
													try {
														AttributeSet a = null;
														Document d = jta.getDocument();
														if (d instanceof StyledDocument) {
															a=((StyledDocument)d).getCharacterElement(f_pos).getAttributes();
														}
														jta.getDocument().insertString(to,s.getWord(),a);
														jta.getDocument().remove(from,to-from);
													} catch (BadLocationException e1) {
														e1.printStackTrace();
													}
													spellCheck(jta);
												}  });
								        }
								        jpm.add(new JSeparator());
								        
								        JMenuItem add = new JMenuItem("Add :"+word);
								        add.addActionListener(new ActionListener(){
											@Override
											public void actionPerformed(
													ActionEvent e) {
												dictionary.addWord(word);
												try {
													FileWriter fw = new FileWriter("custom.dict",true);
													fw.write(word);
													fw.write(System.getProperty("line.separator"));
													fw.close();
													spellCheck(jta);
												} catch (IOException ex) { }												
											} } );

								        JMenuItem ignore = new JMenuItem("Ignore :"+word);
								        ignore.addActionListener(new ActionListener(){
											@Override
											public void actionPerformed(
													ActionEvent e) {
												dictionary.addWord(word);
												spellCheck(jta);
											} } );
								        
								        jpm.add(add);
								        jpm.add(ignore);
								        
								        if (control!=null) {
								        	if (control.getAccept()!=null) {
										        control.getAccept().accept(false);								        		
								        	}
								        }
								        spellCheck(jta);
								        
								        jpm.show(e.getComponent(),e.getX(), e.getY());
								        e.consume();
								        return;
								        
									} catch (BadLocationException e1) {
										e1.printStackTrace();
									}
								}
							}
						}
					}

					@Override
					public void mouseEntered(MouseEvent e) {
					}

					@Override
					public void mouseExited(MouseEvent e) {
					}

					@Override
					public void mousePressed(MouseEvent e) {
					}

					@Override
					public void mouseReleased(MouseEvent e) {
					} } 
		);
	}

	public boolean load(String file) 
	{
		try {
			ClarionRandomAccessFile  craf = ClarionFileFactory.getInstance().getRandomAccessFile(file);
			dictionary.addDictionary(new InputStreamReader(new InputStreamWrapper(craf)));
			return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}

	public void load(File f) 
	{
		try {
			dictionary.addDictionary(new FileReader(f));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
