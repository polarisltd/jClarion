/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.control;

import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.util.logging.Logger;

import javax.swing.ImageIcon;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JScrollPane;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.WaitingImageObserver;


public class ImageControl extends AbstractControl {

    private static Logger log = Logger.getLogger(ImageControl.class.toString());
    
    public ImageControl setText(ClarionString text)
    {
        setProperty(Prop.TEXT,text);
        return this;
    }
    
    public ImageControl setHVScroll()
    {
        setProperty(Prop.HSCROLL,true);
        setProperty(Prop.VSCROLL,true);
        return this;
    }
    
    public ImageControl setCentered()
    {
        setProperty(Prop.CENTERED,true);
        return this;
    }
    @Override
    public boolean isAcceptAllControl() {
        return false;
    }

    @Override
    public boolean validateInput() {
        return true;
    }

    @Override
    public int getCreateType() {
        return Create.IMAGE;
    }

    private JComponent  base;
    private JLabel      label;
    
    @Override
    public void clearMetaData() 
    {
        base=null;
        label=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"label",label);
        debugMetaData(sb,"base",base);
    }
    
    private boolean clip;
    private int c_x1,c_x2,c_y1,c_y2,cox,coy;
    private int dragCorner=0;		// bit 0 x. bit 1 y
	private int imagex;
	private int imagey;
    
    private void normalizeClip()
    {
    	if (c_x1>c_x2) {
    		int tmp = c_x1;
    		c_x1=c_x2;
    		c_x2=tmp;
    		if (dragCorner<4) {
    			dragCorner=dragCorner ^ 1;
    		}
    	}
    	if (c_y1>c_y2) {
    		int tmp = c_y1;
    		c_y1=c_y2;
    		c_y2=tmp;
    		if (dragCorner<4) {
    			dragCorner=dragCorner ^ 2;
    		}
    	}
    }
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
        label = new JLabel() {

        	/**
			 * 
			 */
			private static final long serialVersionUID = 944719832245757670L;
			private Color st = new Color(64,64,64,192);
        	
			@Override
			protected void paintComponent(Graphics g) {
				super.paintComponent(g);
				if (clip) {
					g.setColor(st);
					g.fillRect(0,0,getWidth(),c_y1);
					g.fillRect(0,c_y2,getWidth(),getHeight()-c_y2);
					g.fillRect(0,c_y1,c_x1-1,c_y2-c_y1);
					g.fillRect(c_x2+1,c_y1,getWidth()-c_x2-1,c_y2-c_y1);
					
					g.setColor(Color.BLACK);
					g.drawRect(c_x1-1,c_y1-1,c_x2-c_x1+1,c_y2-c_y1+1);
					drawBox(g,c_x1,c_y1);
					drawBox(g,c_x1,c_y2);
					drawBox(g,c_x2,c_y1);
					drawBox(g,c_x2,c_y2);
				}
			}

			private void drawBox(Graphics g, int t_x2, int t_y2) {
				g.drawRect(t_x2-4,t_y2-4,7,7);
			}
        	
        };
        
        if (isProperty(Prop.HSCROLL) || isProperty(Prop.VSCROLL)) {
            JScrollPane jsp = new JScrollPane(label);
            base = jsp;
            if (isProperty(Prop.HSCROLL)) {
                jsp.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
            }
            if (isProperty(Prop.VSCROLL)) {
                jsp.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
            }
        } else {
            base=label;
        }
        
        setIcon();
        label.setOpaque(false);
        parent.add(base);
        configureFont(label);
        setPositionAndState();
        setIcon();

        label.addMouseListener(new MouseListener() {
			@Override
			public void mouseClicked(MouseEvent e) {
				// TODO Auto-generated method stub
			}

			@Override
			public void mousePressed(MouseEvent e) {
				if (e.getButton()!=1) return;
				if (clip) {
					int bestFit=100;
					int bestMatch=-1;
					for (int scan=0;scan<4;scan++) {
						int x=0;
						int y=0;
						switch(scan) {
							case 0:
								x=c_x1;
								y=c_y1;
								break;
							case 1:
								x=c_x2;
								y=c_y1;
								break;
							case 3:
								x=c_x2;
								y=c_y2;
								break;
							case 2:
								x=c_x1;
								y=c_y2;
								break;
						}
						if (Math.abs(e.getX()-x)<5 && Math.abs(e.getY()-y)<5) {
							int fit = Math.abs(e.getX()-x)+Math.abs(e.getY()-y);
							if (fit<bestFit) {
								bestFit=fit;
								bestMatch=scan;
							}
						}
						if (bestMatch>-1) {
							dragCorner=bestMatch;
							cox=e.getX()-x;
							coy=e.getY()-y;
							return;
						}
					}
				}
				
				if (clip && e.getX()>c_x1 && e.getX()<c_x2 && e.getY()>c_y1 && e.getY()<c_y2) {
					cox=e.getX()-c_x1;
					coy=e.getY()-c_y1;
					dragCorner=4;
				} else {
					c_x1=e.getX();
					c_y1=e.getY();
					clip=false;
					e.getComponent().repaint();
				}	
			}

			@Override
			public void mouseReleased(MouseEvent e) {
				if (e.getButton()!=1) return;
				if (c_x1==0 && c_y1==0 && c_x2==e.getComponent().getWidth() && c_y2==e.getComponent().getHeight()) {
					clip=false;
					e.getComponent().repaint();
				}
				if (clip) {
					float convX=imagex*1.0f/e.getComponent().getWidth();
					float convY=imagey*1.0f/e.getComponent().getHeight();
					
					int x = (int)Math.floor(convX*c_x1);
					int y = (int)Math.floor(convY*c_y1);
					int w = (int)Math.ceil(convX*c_x2)-x;
					int h = (int)Math.ceil(convY*c_y2)-y;
					
					//System.out.println(convX+" "+convY+" "+c_x1+","+c_y1+","+c_x2+","+c_y2+" : "+x+","+y+","+w+","+h);
					
					setProperty(Prop.CLIENTX,x);
					setProperty(Prop.CLIENTY,y);
					setProperty(Prop.CLIENTWIDTH,w);
					setProperty(Prop.CLIENTHEIGHT,h);
					setProperty(Prop.CLIP,1);
				} else {
					setProperty(Prop.CLIP,0);					
				}
				post(Event.SIZED);
			}

			@Override
			public void mouseEntered(MouseEvent e) {
				// TODO Auto-generated method stub
			}

			@Override
			public void mouseExited(MouseEvent e) {
				// TODO Auto-generated method stub
			}
        });
        
        
        label.addMouseMotionListener(new MouseMotionListener() {

			@Override
			public void mouseDragged(MouseEvent e) {
				if ((e.getModifiersEx()&MouseEvent.BUTTON1_DOWN_MASK)==0) return;
				//if (e.getButton()!=1) return;
				
				if (!clip) {
					cox=0;
					coy=0;
					clip=true;
					dragCorner=3;
				}

				if (dragCorner==4) {
					int cx = e.getX()-cox;
					int cy = e.getY()-coy;
					
					int w = c_x2-c_x1;
					int h = c_y2-c_y1;
					
					if (cx<0) cx=0;
					if (cy<0) cy=0;
					if (cx+w>e.getComponent().getWidth()) cx=e.getComponent().getWidth()-w; 
					if (cy+h>e.getComponent().getHeight()) cy=e.getComponent().getHeight()-h;
					
					c_x1=cx;
					c_y1=cy;
					c_x2=cx+w;
					c_y2=cy+h;
				} else {
					int x = e.getX()-cox;
					int y = e.getY()-coy;
					if (x<0) x=0;
					if (x>e.getComponent().getWidth()) x=e.getComponent().getWidth();
					if (y<0) y=0;
					if (y>e.getComponent().getHeight()) y=e.getComponent().getHeight();
					switch(dragCorner) {
						case 0:	
							c_x1=x;
							c_y1=y;
							break;
						case 1:	
							c_x2=x;
							c_y1=y;
							break;
						case 3:	
							c_x2=x;
							c_y2=y;
							break;
						case 2:	
							c_x1=x;
							c_y2=y;
							break;
					}
				}
				normalizeClip();
				e.getComponent().repaint();
			}

			@Override
			public void mouseMoved(MouseEvent e) {
			} 
        	
        });
    }
    
    private Image lastImage=null;

    private void setIcon() {
        JLabel lab=label;
        if (lab!=null) {
            
            Image i=null;
            String text = getProperty(Prop.TEXT).toString();
            if (text.length()>0) {
                i  = CWin.getInstance().getImage(text,0,0);
            } else {
                ClarionObject payload = getRawProperty(Prop.IMAGEBITS);
                if (payload!=null) {
                    i = CWin.getInstance().getImageFromBinaryData(payload);
                }
            }

            if (i!=null) {
                WaitingImageObserver wio=new WaitingImageObserver();            	
            	imagex = i.getWidth(wio);
            	if (imagex==-1) {
            		wio.waitTillDone();
                	imagex = i.getWidth(wio);
            	}
        		imagey = i.getHeight(wio);
            	if (imagey==-1) {
            		wio.waitTillDone();
            		imagey = i.getHeight(wio);
            	}
            }
        	
            if (i!=null) {
                if (isProperty(Prop.CENTERED)) {
                    // as is 
                } else {
                    Dimension d = lab.getSize();
                    if (d.width>0 && d.height>0) {
                        i =CWin.getInstance().scale(i,d.width,d.height);
                    }
                }
                lastImage=i;
                lab.setIcon(new ImageIcon(i));
            } else {
            	lastImage=null;
                lab.setIcon(null);
            }
        }
    }
    
    

    @Override
	protected void handleAWTChange(int indx, ClarionObject value) {
    	if (indx==Prop.TEXT) {
    		if (clip) {
    			clip=false;
    			setProperty(Prop.CLIP,0);
    			post(Event.SIZED);
    		}
            log.fine("New image:["+value.toString()+"]");
            setIcon();    		
    	}
		super.handleAWTChange(indx, value);
	}

	@Override
	protected boolean isAWTChange(int indx) {
    	if (indx==Prop.TEXT) return true;
		return super.isAWTChange(indx);
	}

    @Override
    public Component getComponent() {
        return base;
    }

	@Override
	protected boolean isCopy() {
		return true;
	}


	public static class ImageSelection implements Transferable {
	    private Image image;
	   
	    public static void copyImageToClipboard(Image image) {
	        ImageSelection imageSelection = new ImageSelection(image);
	        Toolkit toolkit = Toolkit.getDefaultToolkit();
	        toolkit.getSystemClipboard().setContents(imageSelection, null);
	    }
	   
	    public ImageSelection(Image image) {
	        this.image = image;
	    }
	   
	    public Object getTransferData(DataFlavor flavor) throws UnsupportedFlavorException {
	        if (flavor.equals(DataFlavor.imageFlavor) == false) {
	            throw new UnsupportedFlavorException(flavor);
	        }
	        return image;
	    }
	   
	    public boolean isDataFlavorSupported(DataFlavor flavor) {
	        return flavor.equals(DataFlavor.imageFlavor);
	    }
	   
	    public DataFlavor[] getTransferDataFlavors() {
	        return new DataFlavor[] {
	            DataFlavor.imageFlavor
	        };
	    }
	}
	
	@Override
	protected void copy() {
		if (lastImage==null) return;
        ImageSelection is = new ImageSelection(lastImage);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(is,null);
	}
    

    
    
}
