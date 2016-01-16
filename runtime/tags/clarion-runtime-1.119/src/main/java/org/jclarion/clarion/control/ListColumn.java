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

import java.util.ArrayList;

import org.jclarion.clarion.runtime.SimpleStringDecoder;
import org.jclarion.clarion.runtime.format.Formatter;

public class ListColumn 
{
    private static void popListColumn(ListColumn n,SimpleStringDecoder d)
    {
        Integer w = d.popNumeric();
        if (w==null) d.error("Invalid format string");
        n.width=w;
        n.justification=popJustify(d);
        if (d.pop('(')) {
            n.indent=d.popNumeric();
            if (!d.pop(')')) d.error("Invalid format string");
        }
        
    }

	private boolean fieldNumberSet;
	private boolean treeOptions;
	private boolean treeRootOffsetSet;
    
    private static void popListColumnModifiers(ListColumn n,SimpleStringDecoder d)
    {
        while ( true ) {
            if (d.end()) break;

            if (d.pop('*')) {
                n.color=true;
                continue;
            }

            if (d.pop('Y')) {
                n.style=true;
                continue;
            }

            if (d.pop('Z')) {
                if (!d.pop('(')) d.error("Invalid format");
                Integer i =d.popNumeric();
                if (i==null) d.error("Invalid format");
                n.defaultStyle=i;
                if (!d.pop(')')) d.error("Invalid format");
                continue;
            }

            if (d.pop('I')) {
                n.icon=true;
                continue;
            }

            if (d.pop('J')) {
                n.transparantIcon=true;
                continue;
            }

            if (d.pop('T')) {
                n.tree=true;
                n.treeRootLines=true;
                n.treeLines=true;
                n.treeBoxes=true;
                n.treeIndent=true;

                if (d.pop('(')) {
                	n.treeOptions=true;
                    while ( !d.pop(')') ) {
                        if (d.end()) d.error("Invalid format");
                        Integer tro = d.popNumeric();
                        if (tro!=null) {
                        	n.treeRootOffsetSet=true;
                            n.treeRootOffset=tro;
                            continue;
                        }
                        if (d.pop('R')) {
                            n.treeRootLines=false;
                            continue;
                        }
                        if (d.pop('L')) {
                            n.treeLines=false;
                            continue;
                        }
                        if (d.pop('B')) {
                            n.treeBoxes=false;
                            continue;
                        }
                        if (d.pop('I')) {
                            n.treeIndent=false;
                            continue;
                        }
                        d.error("Invalid format");
                    }
                }
                continue;
            }
            
            if (d.pop('~')) {
                n.header=d.popString('~');
                if (!d.pop('~')) d.error("Invalid format string");
                n.headerJustification=popJustify(d);
                if (d.pop('(')) {
                    n.headerIndent=d.popNumeric();
                    if (!d.pop(')')) d.error("Invalid format string");
                }
                continue;
            }

            if (d.pop('@')) {
                
                char c = d.peekChar(0);
                switch(c) {
                    case 's': 
                    case 'S': 
                    case 'd': 
                    case 'D': 
                    case 'n': 
                    case 'N': 
                    case 't': 
                    case 'T': 
                    case 'p': 
                    case 'P': 
                    case 'k': 
                    case 'K': 
                        n.picture=Formatter.construct('@'+d.popString('@'));
                        if (!d.pop('@')) d.error("Invalid format string");
                }
                continue;
            }
            
            if (d.pop('?')) {
                n.locator=true;
                continue;
            }
            
            if (d.pop('#')) {
                n.fieldNumber=d.popNumeric();
                n.fieldNumberSet=true;
                if (!d.pop('#')) d.error("Invalid format string");
                continue;
            }

            if (d.pop('_')) {
                n.underline=true;
                continue;
            }

            if (d.pop('/')) {
                n.lastOnLine=true;
                continue;
            }

            if (d.pop('|')) {
                n.verticalLine=true;
                continue;
            }

            if (d.pop('M')) {
                n.resizable=true;
                continue;
            }

            if (d.pop('F')) {
                n.columnFixed=true;
                continue;
            }

            if (d.pop('S')) {
                if (d.pop('(')) {
                    n.columnScroll=d.popNumeric();
                    if (!d.pop(')')) d.error("Invalid format string");
                }
                continue;
            }

            if (d.pop('P')) {
                // Unsupported data tooltip property
                continue;
            }

            if (d.pop('E')) {
                // Unsupported style colour property E(int,int,int,int)
                if (d.pop('(')) {
                    // Pop up to and including the enclosing )
                    char c;
                    do {
                        c = d.popAny();
                    } while (c != ')');
                }
                continue;
            }

            return;
        }
    }
    
    public static ListColumn[] constructDefault()
    {
        ListColumn lc[]=new ListColumn[1];
        lc[0]=new ListColumn();
        lc[0].fieldNumber=1;
        return lc;
    }
    
    public static ListColumn[] construct(String format)
    {
        SimpleStringDecoder d = new SimpleStringDecoder(format.trim());
        try {
            return construct(d,true,new int[] { 0 } );
        } catch (RuntimeException ex) {
            throw(new RuntimeException(format,ex));
        }
    }
    
    public static String deconstruct(ListColumn col[]) {
    	StringBuilder sb = new StringBuilder();
    	for (ListColumn lc : col ) {
    		sb.append(lc.getWidth());
    		sb.append(getJustify(lc.justification));
    		if (lc.getIndent()>0) {
    			sb.append('(');
    			sb.append(lc.getIndent());
    			sb.append(')');
    		}
    		
    		if (lc.isTransparantIcon()) sb.append('J');
    		if (lc.isIcon()) sb.append('I');
    		if (lc.isVerticalLine()) sb.append('|');
    		if (lc.isStyle()) sb.append('Y');
    		if (lc.isResizable()) sb.append('M');
    		if (lc.isColumnFixed()) sb.append('F');
    		if (lc.isColor()) sb.append('*');
    		if (lc.isLocator()) sb.append('?');
    		if (lc.isLastOnLine()) sb.append('/');

    		if (lc.columnScroll>0) {
    			sb.append('S');
    			sb.append(lc.columnScroll);
    		}
    		
    		if (lc.fieldNumberSet) {
    			sb.append("#").append(lc.fieldNumber);
    		}
    		
    		if (lc.isTree()) {
    			sb.append("T");
    			if (lc.treeOptions) {
    				sb.append("(");
    				if (lc.treeRootOffsetSet) {
    					sb.append(lc.treeRootOffset);
    				}
    				if (!lc.treeRootLines) {
    					sb.append("R");
    				}
    				if (!lc.treeLines) {
    					sb.append("L");
    				}
    				if (!lc.treeBoxes) {
    					sb.append("B");
    				}
    				if (!lc.treeIndent) {
    					sb.append("I");
    				}
    				sb.append(")");
    			}
    		}
    		
    		if (lc.header!=null) {
    			sb.append('~');
    			sb.append(lc.header);
    			sb.append('~');
				sb.append(getJustify(lc.getHeaderJustification()));
    			if (lc.getHeaderIndent()>0) {
    				sb.append('(');
    				sb.append(lc.getHeaderIndent());
    				sb.append(')');
    			}
    		}
    		
    		if (lc.getPicture()!=null) {
    			sb.append(lc.getPicture().picture);
    			sb.append('@');
    		}
    		
    		if (lc.defaultStyle>0) {
    			sb.append('Z');
    			sb.append('(');
    			sb.append(lc.defaultStyle);
    			sb.append(')');
    		}
    	}
    	//BARNEY
    	
    	return sb.toString();
    }

    public static ListColumn[] construct(SimpleStringDecoder d,boolean main,int lastposition[])
    {
        ArrayList<ListColumn> results=new ArrayList<ListColumn>();
        
        while (true ) {
            if (main) {
                if (d.end()) break;
            } else {
                if (d.pop(']')) break;
                if (d.end()) d.error("Invalid Format");
            }
            
            ListColumn n = new ListColumn();
            
            if (d.pop('[')) {
                n.children=construct(d,false,lastposition);
                if (d.pop('(')) {
                    n.width=d.popNumeric();
                    if (!d.pop(')')) d.error("Invalid format string");
                }
            } else {
                popListColumn(n,d);
                if (n.fieldNumber==0) {
                    n.fieldNumber=lastposition[0]+1;
                }
                lastposition[0]=n.fieldNumber;
            }
            
            
            popListColumnModifiers(n,d);

            // list below is in required order
            if (n.style) lastposition[0]++;
            if (n.tree) lastposition[0]++;
            if (n.icon || n.transparantIcon) lastposition[0]++;
            if (n.color) lastposition[0]+=4; // fore, back, sel+for, sel+back
            
            results.add(n);
        }

        return (ListColumn[])results.toArray(new ListColumn[results.size()]);
    }
    
    private static Justify popJustify(SimpleStringDecoder d) {
        
        if (d.pop('L')) return Justify.LEFT;
        if (d.pop('R')) return Justify.RIGHT;
        if (d.pop('C')) return Justify.CENTER;
        if (d.pop('D')) return Justify.DECIMAL;
        return Justify.LEFT;
    }
    
    private static char getJustify(Justify j)
    {
    	if (j==Justify.LEFT) return 'L'; 
    	if (j==Justify.RIGHT) return 'R'; 
    	if (j==Justify.CENTER) return 'C'; 
    	if (j==Justify.DECIMAL) return 'D';
    	return '?';
    }
    
    
    public enum Justify { LEFT, RIGHT, CENTER, DECIMAL };
    
    private int     width;  // numeric
    private Justify justification; // L, R, C, D
    private int     indent;  // '(' number ')'
    private boolean color; // '*'
    private boolean style; // 'Y'
    private boolean icon; // 'I'
    private boolean transparantIcon; // 'J'
    private int     defaultStyle=0; // 'Z'

    private boolean tree; // 'T'
    
    // following settings are in '(' after 'T'
    private int     treeRootOffset; // '1'
    private boolean treeRootLines; // 'R'
    private boolean treeLines; // 'L'
    private boolean treeBoxes; // 'R'
    private boolean treeIndent; // 'I'
    // ')'
    
    private String  header; // ~header~
    private Justify headerJustification; //  L, R, C, D
    private int     headerIndent; // '(' number ')'
    
    private Formatter   picture;  // '@' picture '@'
 
    private boolean     locator; // '?'
    private int         fieldNumber; // '#' number '#'
    private boolean     underline; // '_'
    private boolean     lastOnLine; // '/'
    private boolean     verticalLine; // '|'
    private boolean     resizable; // 'M'
    private boolean     columnFixed; // 'F'
    private int         columnScroll; // 'S' number

    private ListColumn  children[];

    public int getWidth() {
        return width;
    }
    
    public ListColumn clone()
    {
    	ListColumn c = new ListColumn();
    	c.color=color;
    	c.columnFixed=columnFixed;
    	c.columnScroll=columnScroll;
    	c.defaultStyle=defaultStyle;
    	c.width=width;
    	c.header=header;
    	c.icon=icon;
    	c.headerIndent=headerIndent;
    	c.headerJustification=headerJustification;
    	c.indent=indent;
    	c.justification=justification;
    	c.picture=picture;
    	c.resizable=resizable;
    	c.style=style;
    	c.transparantIcon=transparantIcon;
    	c.tree=tree;
    	c.treeBoxes=treeBoxes;
    	c.treeLines=treeLines;
    	c.treeOptions=treeOptions;
    	c.treeRootOffset=treeRootOffset;
    	c.treeRootOffsetSet=treeRootOffsetSet;
    	c.underline=true;
    	c.verticalLine=verticalLine;
    	c.width=width;
    	
    	return c;
    }
    
    public void setWidth(int width) {
    	this.width=width;
    }

    public Justify getJustification() {
        return justification;
    }

    public void setJustification(Justify justification) {
    	this.justification = justification;
    }

    public boolean isLeft()
    {
        return getJustification()==Justify.LEFT;
    }

    public boolean isRight()
    {
        return getJustification()==Justify.RIGHT;
    }

    public boolean isCenter()
    {
        return getJustification()==Justify.CENTER;
    }

    public boolean isDecimal()
    {
        return getJustification()==Justify.DECIMAL;
    }
    
    public int getIndent() {
        return indent;
    }

    public void setIndent(int indent) {
    	this.indent = indent;
    }

    public boolean isColor() {
        return color;
    }

    public void setColor(boolean color) {
    	this.color = color;
    }

    public boolean isStyle() {
        return style;
    }

    public void setStyle(boolean style) {
    	this.style = style;
    }

    public int getDefaultStyle() {
        return defaultStyle;
    }

    public void setDefaultStyle(int defaultStyle) {
    	this.defaultStyle = defaultStyle;
    }

    public boolean isIcon() {
        return icon;
    }

    public void setIcon(boolean icon) {
    	this.icon = icon;
    }

    public boolean isTransparantIcon() {
        return transparantIcon;
    }

    public void setTransparantIcon(boolean transparantIcon) {
    	this.transparantIcon = transparantIcon;
    }

    public boolean isTree() {
        return tree;
    }

    public void setTree(boolean tree) {
    	this.tree = tree;
    }

    public int getTreeRootOffset() {
        return treeRootOffset;
    }

    public boolean isTreeRootLines() {
        return treeRootLines;
    }

    public void setTreeRootLines(boolean treeRootLines) {
    	this.treeRootLines = treeRootLines;
    }

    public boolean isTreeLines() {
        return treeLines;
    }

    public void setTreeLines(boolean treeLines) {
    	this.treeLines = treeLines;
    }

    public boolean isTreeBoxes() {
        return treeBoxes;
    }

    public void setTreeBoxes(boolean treeBoxes) {
    	this.treeBoxes = treeBoxes;
    }

    public boolean isTreeIndent() {
        return treeIndent;
    }

    public void setTreeIndent(boolean treeIndent) {
    	this.treeIndent = treeIndent;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
    	this.header = header;
    }

    public Justify getHeaderJustification() {
        return headerJustification;
    }

    public void setHeaderJustification(Justify headerJustification) {
    	this.headerJustification = headerJustification;
    }

    public boolean isHeaderLeft()
    {
        return getHeaderJustification()==Justify.LEFT;
    }

    public boolean isHeaderRight()
    {
        return getHeaderJustification()==Justify.RIGHT;
    }

    public boolean isHeaderCenter()
    {
        return getHeaderJustification()==Justify.CENTER;
    }

    public boolean isHeaderDecimal()
    {
        return getHeaderJustification()==Justify.DECIMAL;
    }

    public int getHeaderIndent() {
        return headerIndent;
    }

    public void setHeaderIndent(int headerIndent) {
    	this.headerIndent = headerIndent;
    }

    public Formatter getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
    	this.picture = Formatter.construct(picture);
    }

    public boolean isLocator() {
        return locator;
    }

    public void setLocator(boolean locator) {
    	this.locator = locator;
    }

    public int getFieldNumber() {
        return fieldNumber;
    }

    public boolean isUnderline() {
        return underline;
    }

    public void setUnderline(boolean underline) {
    	this.underline = underline;
    }

    public boolean isLastOnLine() {
        return lastOnLine;
    }

    public void setLastOnLine(boolean lastOnLine) {
    	this.lastOnLine = lastOnLine;
    }

    public boolean isVerticalLine() {
        return verticalLine;
    }

    public void setVerticalLine(boolean verticalLine) {
        this.verticalLine=verticalLine;
    }

    public boolean isResizable() {
        return resizable;
    }

    public void setResizable(boolean resizable) {
    	this.resizable = resizable;
    }

    public boolean isColumnFixed() {
        return columnFixed;
    }

    public void setColumnFixed(boolean columnFixed) {
    	this.columnFixed = columnFixed;
    }

    public int getColumnScroll() {
        return columnScroll;
    }

    public void setColumnScroll(int columnScroll) {
    	this.columnScroll = columnScroll;
    }

    public ListColumn[] getChildren() {
        return children;
    }

    public void setChildren(ListColumn[] children) {
    	this.children = children;
    }
    
    private int swingWidth;

    public int getSwingWidth() {
        return swingWidth;
    }
    
    private boolean established;
    private int     establishedWidth;
    private int		baseWidth;
    
    public void establish(int width)
    {
    	if (established) return;
    	establishedWidth=width;
    	established=true;
    }
    
    public boolean changeWidth(int newWidth)
    {
    	if (!established) return false;
    	if (establishedWidth==newWidth) return false;
    	establishedWidth=newWidth;
    	return true;
    }

    public void syncSetSwingWidth(int swingWidth) {
        synchronized(this) {
            if (this.swingWidth==0) {
                this.swingWidth = swingWidth;
            }
        }
    }

    public void setSwingWidth(int swingWidth) {
        this.swingWidth = swingWidth;
    }

	public void initBaseWidth() {
		this.baseWidth=getSwingWidth();
	}
	
	public int getBaseWidth()
	{
		return baseWidth;
	}
}
