package org.jclarion.clarion.ide.model;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Insets;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.dnd.DnDConstants;
import java.awt.dnd.DropTarget;
import java.awt.dnd.DropTargetDragEvent;
import java.awt.dnd.DropTargetDropEvent;
import java.awt.dnd.DropTargetEvent;
import java.awt.dnd.DropTargetListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.geom.RoundRectangle2D;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JToggleButton;
import javax.swing.SwingConstants;
import javax.swing.SwingUtilities;
import javax.swing.border.MatteBorder;

import jclarion.Activator;

import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.commands.operations.AbstractOperation;
import org.eclipse.core.commands.operations.IUndoContext;
import org.eclipse.core.commands.operations.IUndoableOperation;
import org.eclipse.core.commands.operations.OperationHistoryFactory;
import org.eclipse.core.commands.operations.UndoContext;
import org.eclipse.core.runtime.Assert;
import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.PropertyObjectListener;
import org.jclarion.clarion.appgen.app.Addition;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionLoader;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.at.AtSourceSession;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.ControlCmd;
import org.jclarion.clarion.appgen.template.cmd.ExtensionCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateCmd;
import org.jclarion.clarion.appgen.template.cmd.Widget;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ControlIterator;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.PropertyChange;
import org.jclarion.clarion.control.RadioControl;
import org.jclarion.clarion.control.ReportBreak;
import org.jclarion.clarion.control.ReportComponent;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.ide.Compiler;
import org.jclarion.clarion.ide.Serializer;
import org.jclarion.clarion.ide.UseVarHelper;
import org.jclarion.clarion.ide.editor.ControlTemplateDataFlavor;
import org.jclarion.clarion.ide.editor.DefinitionDataFlavor;
import org.jclarion.clarion.ide.model.report.ReportEditorLayout;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.ClarionContentPane;
import org.jclarion.clarion.swing.ClarionLayoutManager;
import org.jclarion.clarion.util.SharedWriter;


/**
 * Creates, configures and provides all the Java Swing components required to
 * render and edit the the output of {@link Compiler}
 */
public class JavaSwingProvider {
	
	private static final Color P_HIGHLIGHT_BORDER_COLOR = new Color(0, 160, 0, 64);
	private static final Color P_HIGHLIGHT_FILL_COLOR   = new Color(0, 160, 0, 32);
	private static final Color P_HIGHLIGHT_EDGE_COLOR   = new Color(0, 160, 0, 192);
	
	private static final Color HIGHLIGHT_BORDER_COLOR = new Color(0, 40, 160, 64);
	private static final Color HIGHLIGHT_FILL_COLOR   = new Color(0, 40, 160, 32);
	private static final Color HIGHLIGHT_EDGE_COLOR   = new Color(0, 40, 160, 192);
	
	private static final Color DRAG_FILL_COLOR   = new Color(160, 160, 0, 32);
	private static final Color DRAG_EDGE_COLOR   = new Color(160, 160, 0, 64);
	private static final Color BANNER = new Color(32,32,255);
	private static final Color BANNER_FONT_COLOR = new Color(220,220,96);
	private static final java.awt.Font  BANNER_FONT = new java.awt.Font(java.awt.Font.SANS_SERIF,java.awt.Font.BOLD,14);

	/** The panel the compiler output is added to */
	private JPanel container;

	/** The panel used to capture mouse editing events */
	private MaskPanel mask;

	private PropertyObject 			   lastSelection;
	private final List<PropertyObject> _selections;
	private final List<PropertyObject> dragSelections;
	private final List<ClarionToJavaListener> listeners;
	private Point dragStart;
	private Point dragEnd;
	private Point lastDelta;
	private int[] dragFunction;
	private boolean controlsOpened;

	private static Map<Integer,int[]> dragFunctions=new HashMap<Integer,int[]>();
	private static int[] defaultDragFunction = new int [] { 1,1,0,0 };

	static {
		dragFunctions.put(Cursor.N_RESIZE_CURSOR,new int[] { 0,1,0,-1 });
		dragFunctions.put(Cursor.S_RESIZE_CURSOR,new int[] { 0,0,0,1 });
		dragFunctions.put(Cursor.W_RESIZE_CURSOR,new int[] { 1,0,-1,0 });
		dragFunctions.put(Cursor.E_RESIZE_CURSOR,new int[] { 0,0,1,0 });

		dragFunctions.put(Cursor.NW_RESIZE_CURSOR,new int[] { 1,1,-1,-1 });
		dragFunctions.put(Cursor.NE_RESIZE_CURSOR,new int[] { 0,1,1,-1 });
		dragFunctions.put(Cursor.SW_RESIZE_CURSOR,new int[] { 1,0,-1,1 });
		dragFunctions.put(Cursor.SE_RESIZE_CURSOR,new int[] { 0,0,1,1 });
	}

	private AbstractTarget awt;
	private UndoContext undoContext;
	private JavaSwingContributor contributer;

	public static Rectangle getAltBounds(JavaSwingProvider provider, PropertyObject po) {
		if (po instanceof TabControl) {
			TabControl tc = (TabControl)po;
			if (tc.getComponent()!=null) {
				Component c = tc.getComponent();
				if (!c.isVisible()) return null;
				Rectangle r=c.getBounds();
				c=c.getParent();
				while (c!=null && c!=provider.container) {
					Point p = c.getLocation();
					r.x+=p.x;
					r.y+=p.y;
					c=c.getParent();
				}
				return r;
			}
		}
		return null;
	}
	
	public PropertyObject getPropertyAt(int x,int y)
	{
		ControlIterator ci = new ControlIterator(awt);
		ci.setScanDisabled(true);
		ci.setScanHidden(true);
		PropertyObject match = null;
		while (ci.hasNext()) {
			AbstractControl test = ci.next();
			if (invisibleTab(test)) {
				continue;
			}
			Rectangle r = getPropertyBounds(test);
			if (r!=null && r.contains(x,y)) {
				match = test;
			}
		}
		return match;
	}

	public static Rectangle getPropertyBounds(JavaSwingProvider provider, PropertyObject po) {
		if (po instanceof SheetControl || po instanceof TabControl) {
			SheetControl sheet=null;
			if (po instanceof TabControl) {
				sheet=(SheetControl)po.getParentPropertyObject();
			} else {
				sheet=(SheetControl)po;
			}

			int x = sheet.getProperty(Prop.XPOS).intValue();
			int y = sheet.getProperty(Prop.YPOS).intValue();
			int w = sheet.getProperty(Prop.WIDTH).intValue();
			int h = sheet.getProperty(Prop.HEIGHT).intValue();

			Rectangle r = new Rectangle(
					provider.awt.widthDialogToPixels(x),
					provider.awt.heightDialogToPixels(y),
					provider.awt.widthDialogToPixels(w),
					provider.awt.heightDialogToPixels(h));

			if (sheet!=po) {
				int maxdepth=0;
				for (TabControl tc : sheet.getTabs()) {
					if (tc.getButton()==null) continue;
					Rectangle bb = tc.getButton().getBounds();
					if (bb.y+bb.height>maxdepth) {
						maxdepth=bb.y+bb.height;
					}
				}
				r.y+=maxdepth;
				r.height-=maxdepth;
			}

			return r;
		}

		ExtendProperties ep = ExtendProperties.get(po);
		if (ep.container!=null && ep.container.isVisible()) return ep.container.getBounds();

		if (po instanceof AbstractControl) {
			Component c = ((AbstractControl)po).getComponent();
			if (c!=null) {
				if (!c.isVisible()) return null;
				Rectangle r=c.getBounds();
				c=c.getParent();
				while (c!=null) {
					if (!c.isVisible()) return null;
					 if ((c instanceof JComponent) && ((JComponent)c).getClientProperty("EditorZone")!=null) {
						 Point x = c.getLocation();
						 r.x+=x.x;
						 r.y+=x.y;
					 }
					 c=c.getParent();
				}
				return r;
			}
		}

		if (po instanceof ClarionReport) return provider.container.getBounds();

		if (po instanceof AbstractTarget) {
			int w = po.getProperty(Prop.WIDTH).intValue();
			int h = po.getProperty(Prop.HEIGHT).intValue();
			return new Rectangle(0,0,
					provider.awt.widthDialogToPixels(w),
					provider.awt.heightDialogToPixels(h));
		}
		return null;
	}

	public JavaSwingProvider(UndoContext context,JavaSwingContributor contributer) {
		this.undoContext=context;
		this.contributer=contributer;
		this._selections = Collections.synchronizedList(new ArrayList<PropertyObject>(1));
		this.dragSelections = new ArrayList<PropertyObject>(5);
		this.listeners = new ArrayList<ClarionToJavaListener>(1);
	}

	/**
	 * Returns the first selected {@link AbstractControl}
	 */
	public PropertyObject getFirstSelection() {
		if (lastSelection!=null) return lastSelection;
		if (_selections.isEmpty()) {
			return null;
		}
		return _selections.get(0);
	}
	
	public List<PropertyObject> getSelections() {
		return _selections;
	}

	/**
	 * Returns the compiled {@link AbstractWindowTarget}, or <code>null</code>
	 * if {@link #compile(Lexer)} has not yet been invoked
	 */
	public AbstractTarget getAbstractWindowTarget() {
		return awt;
	}

	public void addListener(ClarionToJavaListener listener) {
		if (!listeners.contains(listener)) {
			listeners.add(listener);
		}
	}

	private PropertyObject lastMouseHighlight;

	public void tabNext()
	{
		PropertyObject po = getFirstSelection();
		if (po==null) {
			highlight(awt);
			fireMouseSelectionChanged();
			return;
		}		
		
		// has kids
		List<? extends PropertyObject> kids = po.getChildren();
		if (!kids.isEmpty()) {
			highlight(kids.get(0));
			fireMouseSelectionChanged();
			return;
		}
		
		while ( true ) {
			PropertyObject parent = po.getParentPropertyObject();
			if (parent==null) {
				highlight(awt);
				fireMouseSelectionChanged();
				return;
			}
			
			int pos = parent.getChildIndex(po)+1;
			kids = parent.getChildren();
			if (pos<kids.size()) {
				highlight(kids.get(pos));
				fireMouseSelectionChanged();
				return;
			}
			
			po=parent;
		}
	}
	
	public void tabPrevious()
	{
		PropertyObject po = getFirstSelection();
		if (po==null) {
			highlight(getLast(awt));
			fireMouseSelectionChanged();
			return;			
		}
		PropertyObject parent = po.getParentPropertyObject();
		if (parent==null) {
			highlight(getLast(awt));
			fireMouseSelectionChanged();
			return;
		}
		List<? extends PropertyObject> kids = parent.getChildren();			
		int pos = parent.getChildIndex(po);
			
		if (pos==0) {
			highlight(parent);
			fireMouseSelectionChanged();
			return;
		}
			
		po = kids.get(pos-1);
		highlight(getLast(po));
		fireMouseSelectionChanged();
		return;
	}	

	private PropertyObject getLast(PropertyObject po) {
		while ( true ) {
			List<? extends PropertyObject> kids = po.getChildren();
			if (kids.isEmpty()) break;
			po=kids.get(kids.size()-1);
		}
		return po;
	}

	public void highlight(PropertyObject po) {
		ArrayList<PropertyObject> al = new ArrayList<PropertyObject>();
		al.add(po);
		highlight(al);
		
	}

	public void highlight(List<PropertyObject> controls) {
		highlight(controls,null);
	}
	
	public void highlight(List<PropertyObject> controls,PropertyObject newLastSelection) {

		if (newLastSelection!=null) {
			lastSelection=newLastSelection;
		}
		if (_selections.equals(controls)) return;
		
		LinkedHashSet<PropertyObject> s_controls =new LinkedHashSet<PropertyObject>(controls);
		LinkedHashSet<PropertyObject> s_selections =new LinkedHashSet<PropertyObject>(_selections);
		
		if (s_controls.equals(s_selections)) return;
		
		if (newLastSelection==null) {
			// figure out last Selection
			s_controls.removeAll(_selections);
			if (s_controls.isEmpty()) {
				if (controls.isEmpty()) {
					lastSelection=null;
				} else {
					lastSelection=controls.get(controls.size()-1);
				}
			} else {
				for (PropertyObject remain : s_controls) {
					lastSelection=remain;
				}
			}
		}
		
		lastMouseHighlight=null;
		_selections.clear();
		_selections.addAll(controls);

		boolean change=false;
		
		for (PropertyObject ctl : controls) {
			if (!(ctl instanceof AbstractControl)) continue;
			AbstractControl control = (AbstractControl)ctl;
			while (control!=null) {
				AbstractControl parent = control.getParent();
				if (parent==null) break;
				if (parent instanceof SheetControl) {
					SheetControl sc = (SheetControl)parent;
					int val = sc.getUseObject().intValue();
					int newval=sc.getChildIndex(control) + 1;
					if (val!=newval) {
						sc.getUseObject().setValue(sc.getChildIndex(control) + 1);
						change=true;
					}
				}
				control=parent;
			}
		}
		if (change) {
			container.requestFocusInWindow();
		}
		mask.repaint();
	}

	public void reset() {
		listeners.clear();
		resetHighlight();
	}

	public void resetHighlight() {
		_selections.clear();
		lastSelection=null;
		if (mask!=null) {
			mask.repaint();
		}
	}

	
	/**
	 * Updates the UI components provided by this provider with the supplied
	 * compiler output. This <strong>must</strong> be invoked on Swing's Event
	 * Dispatch Thread. Failure to do so has been observed to result in
	 * {@link #container} being blank/empty.
	 */
	public Container setAbstractWindowTarget(final AbstractTarget awt) {
		assertIsEventDispatchThread();
		controlsOpened = false;
		this.awt = awt;
		if (container==null) {
			
			if (awt instanceof ClarionReport) {
				ReportEditorLayout layout = new ReportEditorLayout((ClarionReport)awt);
				if (awt.isProperty(Prop.THOUS)) {
					awt.setFontHeight(layout.getDPI(),1000);
					awt.setFontWidth(layout.getDPI(),1000);
				} else {
					awt.setFontHeight(layout.getDPI(),1);
					awt.setFontWidth(layout.getDPI(),1);
				}				
				this.container = new JPanel();
				this.container.setLayout(layout);
				CWin.getInstance().configureFont(container, awt);
			} else {
				this.container = new ClarionContentPane();
				this.container.setLayout(new ClarionLayoutManager());
				CWin.getInstance().configureFont(container, awt);
				CWin.getInstance().setFontDimensions(awt, container, container.getFont());
			}
			
			this.container.setFocusable(true);
			this.container.setFocusTraversalKeysEnabled(false);
			this.container.addKeyListener(new MaskKeyListener());
		}

		container.removeAll();
		this.mask = new MaskPanel();
		
		
		new DropTarget(mask,new DropTargetListener() {

			@Override
			public void dragEnter(DropTargetDragEvent dtde) {
			}

			@Override
			public void dragOver(DropTargetDragEvent dtde) {
			}

			@Override
			public void dropActionChanged(DropTargetDragEvent dtde) {
			}

			@Override
			public void dragExit(DropTargetEvent dte) {
			}

			@Override
			public void drop(DropTargetDropEvent dtde) {
				
				if (dtde.getTransferable().isDataFlavorSupported(DefinitionDataFlavor.DEFINITION)) {
					try {
						dtde.acceptDrop(DnDConstants.ACTION_COPY_OR_MOVE);						
						String s = getDrop(dtde,DefinitionDataFlavor.DEFINITION);
						if (s!=null) {
							dropDefinition(dtde.getLocation(),s);
						}
					} catch (UnsupportedFlavorException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					return;
				}
				if (dtde.getTransferable().isDataFlavorSupported(ControlTemplateDataFlavor.TEMPLATE)) {
					try {
						dtde.acceptDrop(DnDConstants.ACTION_COPY_OR_MOVE);						
						String s = getDrop(dtde,ControlTemplateDataFlavor.TEMPLATE);
						if (s!=null) {
							dropTemplate(dtde.getLocation(),s);
						}
					} catch (UnsupportedFlavorException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					return;
				}
				
				DataFlavor df = DataFlavor.selectBestTextFlavor(dtde.getCurrentDataFlavors());
				if (df==null) return;				
				Object val;
				try {
					dtde.acceptDrop(DnDConstants.ACTION_COPY_OR_MOVE);
					val = dtde.getTransferable().getTransferData(df);
					if (val==null) return;
					dropControl(dtde.getLocation(),val.toString());
				} catch (UnsupportedFlavorException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			private String getDrop(DropTargetDropEvent dtde,DataFlavor definition) throws IOException, UnsupportedFlavorException
			{
				
				Object val = dtde.getTransferable().getTransferData(definition);
				if (val==null) return null;
				if (val instanceof InputStream) {
					Reader r = new InputStreamReader((InputStream)val);
					SharedWriter sw = new SharedWriter();
					char buff[] = new char[512];
					while (true) {
						int len = r.read(buff);
						if (len<=0) break;
						sw.write(buff, 0, len);
					}
					sw.close();
					return sw.toString();
				}
				return null;
			}

		});

		

		awt.opened();
		for (AbstractControl ac : awt.getControls()) {
			openControl(ac);
		}


		Rectangle r = getPropertyBounds(awt);
		if (r!=null) {
			Dimension d = new Dimension(r.width,r.height);
			container.setSize(d);
			container.setPreferredSize(d);
			this.mask.setSize(this.container.getSize());
		}

		container.add(mask);
		if (container instanceof ClarionContentPane) {
			((ClarionContentPane)container).setOffset(1); // never insert infront of mask
		}

		container.addComponentListener(new ComponentListener() {

			@Override
			public void componentResized(ComponentEvent e) {
				mask.setSize(container.getSize());
				container.setPreferredSize(container.getSize());				
			}

			@Override
			public void componentMoved(ComponentEvent e) {
			}

			@Override
			public void componentShown(ComponentEvent e) {
			}

			@Override
			public void componentHidden(ComponentEvent e) {
			}

		});

		if (container instanceof ClarionContentPane) {
		awt.addListener(new PropertyObjectListener() {
			@Override
			public void propertyChanged(PropertyObject owner, int property,ClarionObject value) {
				if (property==Prop.WIDTH || property==Prop.HEIGHT) {
					SwingUtilities.invokeLater(new Runnable() {
						@Override
						public void run() {
							Rectangle r = getPropertyBounds(awt);
							Dimension d = new Dimension(r.width,r.height);
							container.setPreferredSize(d);
							container.setSize(d);

						}
					});
				}
			}

			@Override
			public Object getProperty(PropertyObject owner, int property) {
				return null;
			}

		});
		}

		constructSwingComponent(awt);
		
		controlsOpened = true;

		return container;
	}
	
	private void constructSwingComponent(PropertyObject po)
	{
		if (!(po instanceof AbstractControl)) {
			for (PropertyObject kid : po.getChildren()) {
				constructSwingComponent(kid);
			}		
			if (po==awt) {
				container.invalidate();
				container.doLayout();
				container.validate();
				container.repaint();				
			}
			return;
		}
		final AbstractControl ac = (AbstractControl)po;
		
		Container container=getContainer(ac);
		
		if (ac instanceof ReportComponent) {
			
			JPanel block  =new JPanel();
			block.setLayout(new BorderLayout());
			
			JLabel label = new JLabel();			
			String text = ac.getClass().getName();
			text=text.substring(text.lastIndexOf('.')+1);
			final ExtendProperties ep = ExtendProperties.get(ac);
			if (ep!=null && ep.getLabel()!=null) {
				text=text+" "+ep.getLabel();
			}			
			label.setText(text);
			label.setFont(BANNER_FONT);
			label.setForeground(BANNER_FONT_COLOR);
			label.setBackground(BANNER);
			label.setOpaque(true);
			label.setHorizontalAlignment(SwingConstants.CENTER);
			label.setBorder(new MatteBorder(new Insets(1,1,1,1),Color.BLACK));
			
			block.putClientProperty("Clarion",ac);
			block.putClientProperty("Header", true);
			
			block.add(label,BorderLayout.CENTER);
			
			
			this.container.add(block);
			
			if (!(ac instanceof ReportBreak)) {
				final ClarionContentPane pane = new ClarionContentPane();
				pane.setVisible(ep.isExpanded);
				final JToggleButton expand = new JToggleButton(ep.isExpanded ? "+" : "-");
				expand.setSelected(ep.isExpanded);
				expand.putClientProperty("AboveMask",true);
				block.add(expand,BorderLayout.WEST);
				
				expand.addActionListener(new ActionListener() {
					@Override
					public void actionPerformed(ActionEvent e) {
						ep.isExpanded=expand.isSelected();
						pane.setVisible(expand.isSelected());
						expand.setText(expand.isSelected() ? "+" : "-");
						JavaSwingProvider.this.container.invalidate();
						JavaSwingProvider.this.container.doLayout();
						JavaSwingProvider.this.container.validate();
						JavaSwingProvider.this.container.repaint();						
					}
				});
				
				
				ep.container=pane;
				pane.setBackground(Color.WHITE);
				pane.setLayout(new ClarionLayoutManager());
				pane.putClientProperty("Clarion",ac);
				pane.putClientProperty("EditorZone",true);
				this.container.add(pane);			
			
				// monitor control for size changes
				if (ep.resizeMonitor!=null) {
					ac.removeListener(ep.resizeMonitor);
				}
				ep.resizeMonitor = new PropertyObjectListener() {
					@Override
					public void propertyChanged(PropertyObject owner, int property,
						ClarionObject value) {
						switch(property) {
							case Prop.XPOS:
							case Prop.YPOS:
							case Prop.WIDTH:
							case Prop.HEIGHT:
								JavaSwingProvider.this.container.invalidate();
								JavaSwingProvider.this.container.doLayout();
								JavaSwingProvider.this.container.validate();
								JavaSwingProvider.this.container.repaint();
						}
					}
					@Override
					public Object getProperty(PropertyObject owner, int property) {
						if (property==Prop.WIDTH) {
							if (owner.getRawProperty(Prop.WIDTH,false)!=null) return null;
							return awt.widthPixelsToDialog(ep.container.getWidth(),true);
						}
						if (property==Prop.HEIGHT) {
							if (owner.getRawProperty(Prop.HEIGHT,false)!=null) return null;
							return awt.heightPixelsToDialog(ep.container.getHeight(),true);
						}
						return null;
					} 
				};
				ac.addListener(ep.resizeMonitor);
			}
			
			for (AbstractControl kid : ac.getChildren()) {
				constructSwingComponent(kid);
			}
		} else {
			ac.constructSwingComponent(container);
		}
	}

	private Container getContainer(PropertyObject ac) {
		while (ac!=null) {
			if (ac==awt) return container;
			ExtendProperties ep = ExtendProperties.get(ac);
			if (ep.container!=null) return ep.container;
			ac=ac.getParentPropertyObject();
		}
		return container;
	}

	
	public void resizeControl(AbstractControl ac)
	{
		ClarionObject size;
		
		size = ac.getRawProperty(Prop.WIDTH,false);
		if (size!=null) {
			ac.setProperty(Prop.WIDTH,awt.widthPixelsToDialog(size.intValue(),true));
		}

		size = ac.getRawProperty(Prop.HEIGHT,false);
		if (size!=null) {
			ac.setProperty(Prop.HEIGHT,awt.heightPixelsToDialog(size.intValue(),true));
		}
		
		for (AbstractControl kid : ac.getChildren()) {
			resizeControl(kid);
		}
	}

	public AbstractControl decorateControl(AbstractControl child,String parent,boolean resize)
	{
		Compiler c = new Compiler();
		AbstractControl po = (AbstractControl)c.popControl(parent);
		if (resize) {
			resizeControl(po);
		}
		String use = Compiler.getUniqueUse(awt, po, null);
		ExtendProperties.get(po).decodeUseVar(use);
		po.addChild(child);
		return po;
	}
	
	public void dropTemplate(Point location,String definition)
	{
		Map<String,String> params = new HashMap<String,String>();
		for (String items : definition.split(";")) {
			int eq = items.indexOf('=');
			if (eq==-1) continue;
			params.put(items.substring(0,eq),items.substring(eq+1));
		}
		
		Procedure p = contributer.getDirtyProcedure();
		AppProject project = contributer.getModel().getApp().getAppProject();

		
		//Template=ABC;Type=#CONTROL;Name=BrowseUpdateButtons;Parent=5
		
		
		TemplateCmd template = project.getChain().getTemplate(params.get("Template"));
		CodeSection code = template.getSection(params.get("Type"),params.get("Name"));
		
		AtSource parent = p;
		if (params.get("Parent")!=null) {
			parent = p.getAddition(Integer.parseInt(params.get("Parent")));
		}
				
		Addition a = new Addition();
		a.setBase(template.getFamily(),code.getCodeID());
			
		a.setInstanceID(p.getMaxInstanceID()+1);
		a.setOrderID(a.getInstanceID());
			
		if (parent instanceof Addition) {
			((Addition)parent).addChild(a);
		}
		p.addAddition(a);			
			
		a.setPrompts(code.getDeclaredPrompts());

		ExecutionEnvironment generator = project.getEnvironment(true);		
		generator.setAlternative(contributer.getModel().getProcedure(),p);

		AtSourceSession session = generator.getSession(a);		
		session.getCodeSection();		
		AdditionExecutionState state = session. prepareToExecute();			
		for (Widget w : code.getWidgets()) {
			w.prime(generator);
		}
			
		// prepare called mainly to make sure construction is good
		session.prepare();
			
		generator.open("control.$$$",ExecutionEnvironment.CREATE);
		code.run(generator);
		String content = generator.getBuffer("control.$$$").getBuffer();
			
		// after priming has been completed : copy back newly primed result
		UserSymbolScope ns=new UserSymbolScope(session.getScope(),new AppLoaderScope(),false);
		ns.constrainFields(code.getDeclaredPrompts());
		a.setPrompts(ns);
			
		state.finish();
			
			
		Compiler c = new Compiler();
		List<PropertyObject> base = c.popControls(content);
		int xofs=0,yofs=0;
		
		UseVarHelper var = new UseVarHelper();
		var.collateUniqueProperty(awt,Prop.FROM);
		
		for (PropertyObject scan : base ) {
			
			var.ensureUniqueProperty(scan,Prop.FROM,true);
			
			int x = scan.getProperty(Prop.XPOS).intValue();
			int y = scan.getProperty(Prop.YPOS).intValue();
			
			if (xofs!=0) {
				scan.setProperty(Prop.XPOS,x+xofs);
			}
			if (yofs!=0) {
				scan.setProperty(Prop.YPOS,y+yofs);
			}
			
			xofs+=x;
			yofs+=y;
			
			ExtendProperties ep = ExtendProperties.get(scan);
			ep.addPragma("SEQ", new String[] { String.valueOf(a.getInstanceID()) });
			if (ep.getUsevars()!=null) {
				ep.addPragma("ORIG",ep.getUsevar());
			}
		}
		dropControl(location,null,base,false);
		project.recycleEnvironment(generator);

		dropTemplateSWTBits(project,a,p,code);
		
		
		// todo : open file. open prompt. fire dirty listener 
		//Procedure proc = getDirtyProcedure();
		//proc.setWindow(WindowEditorHelper.mergeInTemplateControls(proc.getWindow(),content,a.getInstanceID()));
		
	}
	
	private void dropTemplateSWTBits(final AppProject project,final Addition a,final Procedure p,final CodeSection code) 
	{
		Activator.getDefault().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				if (code instanceof ControlCmd) {
					if (((ControlCmd)code).isPrimary()) {
						project.fileDialog(a);
					}
				}
				if (code instanceof ExtensionCmd) {
					if (((ExtensionCmd)code).isPrimary()) {
						project.fileDialog(a);
					}
				}
				ExecutionEnvironment generator = project.getEnvironment(true);		
				generator.setAlternative(contributer.getModel().getProcedure(),p);
				project.prompt(generator,a);
				project.recycleEnvironment(generator);
				DirtyProcedureMonitor.fire(p);
			}
		});
	}
	
	public static String getDefinitionPattern(Definition d)
	{
		String type = d.getTypeName().toLowerCase();
		String picture=null;
		
		if (type.endsWith("string") && d.getTypeProperty().getPropCount()>0) {
			picture="@s"+d.getTypeProperty().getProp(0).value;
		}
		
		if (type.endsWith("decimal") && d.getTypeProperty().getPropCount()>1) {
			
			int size = d.getTypeProperty().get(0).getInt();
			int dp = d.getTypeProperty().get(0).getInt();
			
			int inc = size-dp;
			int adj=0;
			while (inc>3) {
				inc-=3;
				adj++;
			}				
			size=size+1+adj;				
			picture="@n"+size+"."+dp;
		}
		
		if (type.equals("date")) {
			picture="@d6";
		}
		if (type.equals("time")) {
			picture="@t1";
		}
		
		if (type.equals("long") || type.equals("short") || type.equals("ushort") || type.equals("ulong") || type.equals("byte")) {
			picture="@n7";
		}
		
		return picture;
	}

	public void dropDefinition(Point location,String definition)
	{
		JPopupMenu jpm = new JPopupMenu();
		
		Definition d = DefinitionLoader.loadItem(definition);
		
		String name = d.getName();
		String picture=getDefinitionPattern(d);
		
		if (awt instanceof ClarionReport) {
			addDefinitionOption(jpm,location,"String"," STRING("+picture+"),USE("+name+")");
		} else {
			
			if (picture!=null && name!=null) {
				addDefinitionOption(jpm,location,"String"," STRING("+picture+"),USE("+name+")");
				addDefinitionOption(jpm,location,"Entry"," ENTRY("+picture+"),USE("+name+")");
			}
			
			if (name!=null) {
				addDefinitionOption(jpm,location,"Prompt"," PROMPT('"+name+":'),USE(?"+name+":prompt)");
			}
		}
		
		if (jpm.getComponentCount()==0) return;
		
		if (jpm.getComponentCount()==1) {
			String def = (String)((JComponent)jpm.getComponent(0)).getClientProperty("Clarion.Definition");
			if (def!=null) {
				dropControl(location,def);
			}
			return;
		}
		
		jpm.show(mask,(int)location.getX(),(int)location.getY());
	}

	private void addDefinitionOption(JPopupMenu jpm, final Point location,String name,final String def) 
	{
		JMenuItem item = new JMenuItem(name);
		item.putClientProperty("Clarion.Definition",def);
		jpm.add(item);
		item.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				dropControl(location,def);
			}
		});
	}


	public void dropControl(Point location,String item)
	{
		dropControl(location,null,item);
	}

	public void dropControl(PropertyObject parent,String item)
	{
		dropControl(null,parent,item);
	}
	
	private Point getPosition(PropertyObject po)
	{
		if (po==null) return null;
		if (po instanceof TabControl) return null;
		Point p = new Point(
				po.getProperty(Prop.XPOS).intValue(),
				po.getProperty(Prop.YPOS).intValue()
				);
		return p;
	}
	
	public void dropControl(Point location,PropertyObject parent,String item)
	{
		boolean resize=false;
		if (item.startsWith("*")) {
			resize=true;
			item=item.substring(1);
		}
		
		Compiler c = new Compiler();
		List<PropertyObject> base = c.popControls(item);	
		dropControl(location,parent,base,resize);
	}
	
	public void dropControl(Point location,PropertyObject parent,List<PropertyObject> base,boolean resize)
	{
		if (base==null || base.isEmpty()) return;
		UseVarHelper helper = new UseVarHelper();
		helper.use(awt, true);		
		Point minPosition=null;
		for (PropertyObject ppo : base) {
			
			if (ppo instanceof AbstractControl) {
				if (resize) {
					resizeControl((AbstractControl)ppo);
				}				
				Point position = getPosition(ppo);
				if (position==null) continue;
				if (minPosition==null) {
					minPosition=position;
				} else {
					minPosition.x=Math.min(minPosition.x,position.x);
					minPosition.y=Math.min(minPosition.y,position.y);
				}
			}
		}
		if (minPosition==null) {
			minPosition=new Point(0,0);
		} else {
			minPosition.x=-minPosition.x;
			minPosition.y=-minPosition.y;
		}
		
		beginStructuralChange("Drag and Drop",false);
		for (PropertyObject ppo : base) {
			if (!(ppo instanceof AbstractControl)) continue;
			AbstractControl po = (AbstractControl)ppo; 
		
			AbstractControl match = null;

			while ( true ) {
				
				if (location!=null) {
					// locate a home for the control
					ControlIterator ci = new ControlIterator(awt);
					ci.setScanDisabled(true);
					ci.setScanHidden(true);
					match=null;
					while (ci.hasNext()) {
						AbstractControl test = ci.next();
						if (invisibleTab(test)) continue;
						Rectangle r = getPropertyBounds(test);
						if (r!=null && r.contains(location)) {
							if (Compiler.isValidParent(po,test)) {
								match=test;
							}
						}
					}
				} 
				if (parent!=null) {
					PropertyObject scan=parent;
					while ( scan!=null ) {
						if (Compiler.isValidParent(po,scan)) {
							break;
						}
						scan=scan.getParentPropertyObject();
					}
					if (scan instanceof AbstractControl) {
						match= (AbstractControl)scan;
					}					
				}
				
				if (match==null) {
					if ( po instanceof RadioControl) {
						adjust(po,15,15);
						po=decorateControl(po," OPTION('Options'),BOXED,AT(,,30,30)\n.",resize);
						continue;
					}
					if ( po instanceof TabControl) {
						po=decorateControl(po," SHEET,AT(,,30)",resize);
						continue;
					}
				}
				break;
			}
			
			PropertyObject targetParent=match;
			if (targetParent==null) {
				targetParent=awt;
				if (!Compiler.isValidParent(po, targetParent)) continue;
			}
			
			helper.setUniqueUse(po, true);

			Point adjust=null;
			if (location!=null) {
				adjust=new Point(location.x,location.y);
				
				Container container = getContainer(targetParent);
				if (container!=null && (container instanceof JComponent) && ((JComponent)container).getClientProperty("EditorZone")!=null) {
					Point loc = container.getLocation();
					adjust.x-=loc.x;
					adjust.y-=loc.y;
				}
				
				adjust.x=awt.widthPixelsToDialog(adjust.x);
				adjust.y=awt.heightPixelsToDialog(adjust.y);
				
			} else {
				if ( match instanceof TabControl) {
					adjust=getPosition(match.getParentPropertyObject());
				} else {
					
					if (parent!=null && parent!=match) {
						Rectangle r = getBox(parent);
						adjust=new Point(r.x,r.y+r.height+5);
					} else {
						adjust=getPosition(match);
					}
				}
			}
			
			if (adjust!=null && !(po instanceof ReportComponent)) {
				if (minPosition!=null) {
					adjust.x+=minPosition.x;
					adjust.y+=minPosition.y;
				}
				adjust(po,adjust.x,adjust.y);				
			}
			
			
			if (location!=null) {
				addStructuralChange(new StructuralChangeItem(po,targetParent,getIdealIndexForChild(targetParent,po)));
			} else {
				addStructuralChange(new StructuralChangeItem(po,targetParent));
			}
		}
		commitStructuralChange();		
	}
	
	private Rectangle getBox(PropertyObject o)
	{
		int x = o.getProperty(Prop.XPOS).intValue();
		int y = o.getProperty(Prop.YPOS).intValue();
		int w = o.getProperty(Prop.WIDTH).intValue();
		int h = o.getProperty(Prop.HEIGHT).intValue();
		
		if (w<0) {
			x=x+w;
			w=-w;
		}
		if (h<0) {
			y=y+h;
			h=-h;
		}
		
		return new Rectangle(x,y,w,h);
	}
	
	public int getIdealIndexForChild(PropertyObject parent,PropertyObject child)
	{
		if (child instanceof TabControl) return parent.getChildren().size();
		
		Rectangle child_pos = getBox(child);
		
		PropertyObject best_fit=null;
		int best_distance=0;
		Rectangle best_pos=null;
		int best_index=0;
		int best_intercept_area=0;
		
		int child_index=-1;
		
		for (PropertyObject scan : parent.getChildren()) {
			child_index++;
			Rectangle pos = getBox(scan);
			
			int distance=0;
			int intercept_area=0;
			if (pos.intersects(child_pos)) {
				if (pos.contains(child_pos)) continue; 	
				Rectangle intercept = pos.intersection(child_pos);
				intercept_area = intercept.width*intercept.height;
			} else {
				distance = Integer.MAX_VALUE;
				distance = best(pos,child_pos,distance);
				distance = best(child_pos,pos,distance);
				
			}
			if (best_fit!=null) {
				if (intercept_area<best_intercept_area) continue;
				if (distance>best_distance) continue;
			}
			best_fit=scan;
			best_distance=distance;
			best_intercept_area=intercept_area;
			best_pos=pos;
			best_index=child_index;
		}
		
		if (best_fit==null) return 0;
		
		int dx=child_pos.x+child_pos.width/2-best_pos.x-best_pos.width/2;
		int dy=child_pos.y+child_pos.height/2-best_pos.y-best_pos.height/2;
		
		int mx_num=1;
		int mx_denom=1;
		
		
		if (best_pos.width!=0 && best_pos.height!=0) {
			mx_num = best_pos.height;
			mx_denom = best_pos.width;
		}
		
		
		if (-dy<=dx*mx_num/mx_denom) best_index++; 
		return best_index;
	}

	private static class Rct
	{
		private int x1,y1,x2,y2;
		
		public Rct(Rectangle r) {
			x1=r.x;
			y1=r.y;
			x2=r.x+r.width;
			y2=r.y+r.height;
		}
	}
	
	private int best(Rectangle _a, Rectangle _b, int distance) 
	{
		Rct a = new Rct(_a);
		Rct b = new Rct(_b);
		
		if (b.x1>=a.x2 && b.y1<=a.y2 && b.y2>=a.y1) {
			distance=best(b.x1-a.x2,distance);
		}
		if (b.y1>=a.y2 && b.x1<=a.x2 && b.x2>=a.x1) {
			distance=best(b.y1-a.y2,distance);
		}
		distance=best(a.x2,a.y1,b.x1,b.y2,distance);
		distance=best(a.x2,a.y2,b.x1,b.y1,distance);
		return distance;
	}

	private int best(int x1, int y1, int x2, int y2, int distance) {
		int dx = (x1-x2);
		int dy= (y1-y2);
		return best((int)Math.sqrt(dx*dx+dy*dy),distance);
	}

	private int best(int i, int distance) {
		return i<distance ? i : distance;
	}

	private void swing(Runnable r)
	{
		if (SwingUtilities.isEventDispatchThread()) {
			r.run();
		} else {
			SwingUtilities.invokeLater(r);
		}
	}

	public void notifyControlChanged(PropertyObject po, int property) {
		assertIsEventDispatchThread();
		container.repaint();
		mask.repaint();
		fireControlChanged(po, property, po.getRawProperty(property));
	}

	private void assertIsEventDispatchThread() {
		Assert.isTrue(SwingUtilities.isEventDispatchThread());
	}

	private void adjust(AbstractControl po, int xofs, int yofs)
	{
		if (!(po instanceof TabControl)) {
			po.setProperty(Prop.XPOS, po.getProperty(Prop.XPOS).intValue()+xofs);
			po.setProperty(Prop.YPOS, po.getProperty(Prop.YPOS).intValue()+yofs);			
		}
		for (AbstractControl ac : po.getChildren()) {
			adjust(ac,xofs,yofs);
		}
	}

	/**
	 * Removes the control from the model and view and notifies listeners
	 */
	public void delete(final AbstractControl control) {
		addStructuralChange(new StructuralChangeItem(control));
	}

	public void move(PropertyObject match,int matchOffset,AbstractControl child) {

		addStructuralChange(new StructuralChangeItem(child,match,matchOffset));
	}

	/**
	 * Returns <code>true</code> when a target exists and it and its controls
	 * have been opened
	 */
	public boolean isTargetInitialised() {
		return (awt != null) && awt.isOpened() && controlsOpened;
	}

	public void fireMouseSelectionChanged() {
		for (ClarionToJavaListener listener : listeners) {
			listener.mouseSelectionChanged(_selections);
		}
	}

	private void fireMouseDragged(int sx,int sy,int x, int y, int deltaX, int deltaY, int deltaWidth, int deltaHeight, boolean rehome, List<PropertyChange> otherChanges) {
		for (ClarionToJavaListener listener : listeners) {
			listener.mouseDragged(_selections, sx,sy,x, y, deltaX, deltaY, deltaWidth, deltaHeight, rehome,otherChanges);
		}
	}

	public void fireStructureChanged(PropertyObject control) {
		for (ClarionToJavaListener listener : listeners) {
			listener.structureChanged(control);
		}
	}

	private void fireControlChanged(PropertyObject control, int property, Object value) {
		for (ClarionToJavaListener listener : listeners) {
			listener.controlChanged(control, property, value);
		}
	}

	private void openControl(AbstractControl control) {
		control.opened();
		for (AbstractControl child : control.getChildren()) {
			openControl(child);
		}
	}



	public boolean invisibleTab(PropertyObject po)
	{
		if (!(po instanceof TabControl)) return false;
		PropertyObject sheet = po.getParentPropertyObject();
		ClarionObject tests = sheet.getRawProperty(Prop.SELSTART);
		if (tests==null) return true;
        int choice=tests.intValue();
        if (choice<=0) return true;
        return ((AbstractControl)sheet).getChild(choice-1)!=po;
	}
	
	private Rectangle getAltBounds(PropertyObject po)
	{
		if (po instanceof TabControl) {
			TabControl tc = (TabControl)po;
			if (tc.getComponent()!=null) {
				Component c = tc.getComponent();
				if (!c.isVisible()) return null;
				Rectangle r=c.getBounds();
				c=c.getParent();
				while (c!=null && c!=container) {
					Point p = c.getLocation();
					r.x+=p.x;
					r.y+=p.y;
					c=c.getParent();
				}
				return r;
			}
		}
		return null;
	}
	
	public Rectangle getPropertyBounds(PropertyObject po)
	{
		if (po instanceof SheetControl || po instanceof TabControl) {
			
			SheetControl sheet=null;
			if (po instanceof TabControl) {
				sheet=(SheetControl)po.getParentPropertyObject();
			} else {
				sheet=(SheetControl)po;
			}
			
			int x = sheet.getProperty(Prop.XPOS).intValue();
			int y = sheet.getProperty(Prop.YPOS).intValue();
			int w = sheet.getProperty(Prop.WIDTH).intValue();
			int h = sheet.getProperty(Prop.HEIGHT).intValue();

			Rectangle r = new Rectangle(awt.widthDialogToPixels(x),awt.heightDialogToPixels(y),
					awt.widthDialogToPixels(w),
					awt.heightDialogToPixels(h));
			
			
			if (sheet!=po) {
				int maxdepth=0;
				for (TabControl tc : sheet.getTabs()) {
					if (tc.getButton()==null) continue;
					Rectangle bb = tc.getButton().getBounds();
					if (bb.y+bb.height>maxdepth) {
						maxdepth=bb.y+bb.height;
					}
				}
				r.y+=maxdepth;
				r.height-=maxdepth;
			}
			
			return r;
		}
		
		ExtendProperties ep = ExtendProperties.get(po);
		if (ep.container!=null && ep.container.isVisible()) return ep.container.getBounds();

		if (po instanceof AbstractControl) {
			Component c = ((AbstractControl)po).getComponent();
			if (c!=null) {
				if (!c.isVisible()) return null;
				Rectangle r=c.getBounds();
				c=c.getParent();
				while (c!=null) {
					if (!c.isVisible()) return null;
					 if ((c instanceof JComponent) && ((JComponent)c).getClientProperty("EditorZone")!=null) {
						 Point x = c.getLocation();
						 r.x+=x.x;
						 r.y+=x.y;
					 }
					 c=c.getParent();
				}
				return r;
			}
		}
		
		if (po instanceof ClarionReport) return container.getBounds();
		
		if (po instanceof AbstractTarget) {
			int w = po.getProperty(Prop.WIDTH).intValue();
			int h = po.getProperty(Prop.HEIGHT).intValue();
			return new Rectangle(0,0,
					awt.widthDialogToPixels(w),
					awt.heightDialogToPixels(h));
		}
		return null;
	}

	private class MaskPanel extends JPanel {

		private static final long serialVersionUID = 1L;

		private MaskPanel() {
			setOpaque(false);
			addMouseMotionListener(new MaskMouseMotionListener());
			addMouseListener(new MaskMouseListener());
		}

		@Override
		public void paint(Graphics g) {
			Graphics2D g2d = (Graphics2D) g;
			g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

			Rectangle drag=null;
			if (dragEnd!=null) {
				drag = new Rectangle();
				drag.x=dragStart.x;
				drag.y=dragStart.y;
				drag.width=dragEnd.x-dragStart.x;
				drag.height=dragEnd.y-dragStart.y;
				if (drag.width<0) {
					drag.x=drag.x+drag.width;
					drag.width=-drag.width;
				}
				if (drag.height<0) {
					drag.y=drag.y+drag.height;
					drag.height=-drag.height;
				}

				dragSelections.clear();
				for (AbstractControl scan  : awt.getControls()) {
					checkControl(scan,drag);
				}
				for (PropertyObject control : dragSelections) {
					renderControl(g2d,control,false);
				}
			} else {
				dragSelections.clear();
			}

			synchronized (_selections) {
				for (Iterator<PropertyObject> iter = _selections.iterator(); iter.hasNext(); ) {
					PropertyObject goal = iter.next();
					renderControl(g2d, goal,goal==lastSelection);
				}
			}

			if (drag!=null) {
				g2d.setColor(DRAG_FILL_COLOR);
				g2d.fillRect(drag.x,drag.y,drag.width,drag.height);
				g2d.setColor(DRAG_EDGE_COLOR);
				g2d.drawRect(drag.x,drag.y,drag.width,drag.height);
			}
		}

		private void renderControl(Graphics2D g2d, PropertyObject control,boolean primary) {
			Rectangle rect = getPropertyBounds(control);
			if (rect==null) return;
			int x = rect.x;
			int y = rect.y;
			int width = rect.width;
			int height = rect.height;
			g2d.setColor(primary ? P_HIGHLIGHT_FILL_COLOR :HIGHLIGHT_FILL_COLOR);
			g2d.fillRoundRect(x, y, width, height, 4, 4);
			g2d.setColor(primary ? P_HIGHLIGHT_BORDER_COLOR : HIGHLIGHT_BORDER_COLOR);
			g2d.drawRoundRect(x, y, width, height, 4, 4);
			g2d.setColor(primary ? P_HIGHLIGHT_EDGE_COLOR : HIGHLIGHT_EDGE_COLOR);
			Shape previous = g2d.getClip();
			g2d.setClip(new RoundRectangle2D.Float(x, y, width, height, 4, 4));
			drawBox(g2d,x,y);
			drawBox(g2d,(x+x+width-5)/2,y);
			drawBox(g2d,x+width-5,y);

			drawBox(g2d,x,y+height-5);
			drawBox(g2d,x+width-5,y+height-5);
			drawBox(g2d,(x+x+width-5)/2,y+height-5);

			drawBox(g2d,x,(y+y+height-5)/2);
			drawBox(g2d,x+width-5,(y+y+height-5)/2);

			g2d.setClip(previous);
		}

		private void checkControl(AbstractControl scan,Rectangle drag) {
			if (!scan.isProperty(Prop.VISIBLE)) return;
			Rectangle r = getPropertyBounds(scan);
			if (r!=null && drag.contains(r)) {
				dragSelections.add(scan);
				return;
			}
			for (AbstractControl kid : scan.getChildren()) {
				checkControl(kid,drag);
			}
		}

		private void drawBox(Graphics2D g2d, int x, int y)
		{
			g2d.fillRect(x,y,5,5);
		}

	}

	private int getCursor(int x, int y) {

		int value = Cursor.DEFAULT_CURSOR;
		int lastbuffer=5;

		synchronized (_selections) {
			for (Iterator<PropertyObject> iter = _selections.iterator(); iter.hasNext(); ) {
				PropertyObject control = iter.next();
				Rectangle pos = getPropertyBounds(control);
				if (pos==null) continue;

				int buffer=0;

				if (x<pos.x) buffer=calcBuffer(x,pos.x,buffer);
				if (x>pos.x+pos.width) buffer=calcBuffer(x,pos.x+pos.width,buffer);
				if (y<pos.y) buffer=calcBuffer(y,pos.y,buffer);
				if (y>pos.y+pos.height) buffer=calcBuffer(y,pos.y+pos.height,buffer);

				if (buffer>=lastbuffer) continue;

				pos.x-=buffer;
				pos.y-=buffer;
				pos.width+=buffer*2;
				pos.height+=buffer*2;
				lastbuffer=buffer;

				boolean left = margin(x,pos.x,pos.width);
				boolean top = margin(y,pos.y,pos.width);
				boolean right = margin(x,pos.x+pos.width,pos.height);
				boolean bottom = margin(y,pos.y+pos.height,pos.height);

				value = Cursor.MOVE_CURSOR;

				if (left && !top && !right && !bottom) value=Cursor.W_RESIZE_CURSOR;
				if (!left && top && !right && !bottom) value=Cursor.N_RESIZE_CURSOR;
				if (!left && !top && right && !bottom) value=Cursor.E_RESIZE_CURSOR;
				if (!left && !top && !right && bottom) value=Cursor.S_RESIZE_CURSOR;

				if (left && top && !right && !bottom) value=Cursor.NW_RESIZE_CURSOR;
				if (!left && top && right && !bottom) value=Cursor.NE_RESIZE_CURSOR;
				if (left && !top && !right && bottom) value=Cursor.SW_RESIZE_CURSOR;
				if (!left && !top && right && bottom) value=Cursor.SE_RESIZE_CURSOR;
			}

		}

		return value;
	}

	private int calcBuffer(int x,int x2,int buffer)
	{
		int diff = Math.abs(x-x2);
		if (diff>buffer) return diff;
		return buffer;
	}

	private boolean margin(int x, int x2,int size) {

		size=size/3;
		if (size>8) size=8;
		if (size<2) size=2;

		return Math.abs(x-x2)<size;
	}
	
	private static class StructuralChangeItem 
	{
		private AbstractControl item;
		private PropertyObject 	oldParent;
		private int				oldIndex;	
		private PropertyObject 	newParent;
		private int 			newIndex;
		
		public StructuralChangeItem()
		{
		}
		
		public StructuralChangeItem(AbstractControl item)
		{
			this.item=item;
			oldParent=this.item.getParentPropertyObject();
			if (oldParent!=null) {
				oldIndex=oldParent.getChildIndex(item);
			}
		}

		
		public StructuralChangeItem(AbstractControl item,PropertyObject newParent)
		{
			this(item);
			this.newParent=newParent;
			this.newIndex=this.newParent.getChildren().size();
		}

		public StructuralChangeItem(AbstractControl item,PropertyObject newParent,int newIndex)
		{
			this(item);
			this.newParent=newParent;
			this.newIndex=newIndex;
		}	
		
		public StructuralChangeItem undo()
		{
			StructuralChangeItem i = new StructuralChangeItem();
			i.item=item;
			i.oldParent=newParent;
			i.oldIndex=newIndex;
			i.newParent=oldParent;
			i.newIndex=oldIndex;
			return i;
		}
		
		public String toString()
		{
			return obj(item)+" "+path(oldParent,oldIndex)+" => "+path(newParent,newIndex);
		}
		
		private String obj(PropertyObject item)
		{
			String type = item.getClass().getName();
			type=type.substring(type.lastIndexOf('.')+1);
			ExtendProperties ep = ExtendProperties.get(item);
			String val = null;
			if (ep!=null) {
				val =ep.getUsevar();
				if (val==null) {
					val=ep.getLabel();
				}
			}
			if (val==null) return type;
			return type+"("+val+")";
		}
		
		private String path(PropertyObject item,int index)
		{
			if (item==null) return "";
			return obj(item)+"#"+index;
		}
	}
	
	public StructuralChange beginStructuralChange(String name,boolean repaint)
	{
		StructuralChange change = new StructuralChange(name,repaint);
		try {
			OperationHistoryFactory.getOperationHistory().execute(change, null, null);
		} catch (ExecutionException e) {
			e.printStackTrace();
		}	
		return change;
	}

	public void commitStructuralChange()
	{
		IUndoableOperation op = OperationHistoryFactory.getOperationHistory().getUndoOperation(undoContext);
		if (op!=null && (op instanceof StructuralChange)) {
			StructuralChange sc = (StructuralChange)op;
			if (sc.items.isEmpty()) {
				 OperationHistoryFactory.getOperationHistory().replaceOperation(op,new IUndoableOperation[0]);
			} else {
				((StructuralChange)op).close();
			}
		}		
	}

	public void addStructuralChange(StructuralChangeItem item)
	{
		IUndoableOperation op = OperationHistoryFactory.getOperationHistory().getUndoOperation(undoContext);
		StructuralChange change=null;
		if (op!=null && (op instanceof StructuralChange)) {
			change = (StructuralChange)op;
			if (change.closed) change=null;
		}
		boolean autoCommit=false;
		if (change==null) {
			autoCommit=true;
			change=beginStructuralChange("Structural Change",false);
		}
		change.add(item);
		change.apply(item);
		if (autoCommit) {
			change.close();
		}
	}
	
	private class StructuralChange extends AbstractOperation
	{
		private LinkedList<StructuralChangeItem> items=new LinkedList<StructuralChangeItem>();
		private boolean closed;
		private boolean repaint;
		private Set<PropertyObject> changes=new HashSet<PropertyObject>();
		private Set<PropertyObject> selections=new LinkedHashSet<PropertyObject>();
		private boolean forceRepaint;
		
		public StructuralChange(String label,boolean repaint) {
			super(label);
			addContext(undoContext);
			this.repaint=repaint;
		}
		
		public void add(StructuralChangeItem item)
		{
			if (item.oldParent==item.newParent && item.oldIndex<item.newIndex) {
				item.newIndex--;
			}			
			items.add(item);
		}
		
		public void close()
		{
			if (closed) return;
			closed=true;
			repaint();
		}
		
		public void complete()
		{
			for (PropertyObject po : changes ) {
				fireStructureChanged(po);
			}
			highlight(new ArrayList<PropertyObject>(selections));
			fireMouseSelectionChanged();
			changes.clear();
			selections.clear();
		}
		
		public void reverseSelections()
		{
			LinkedList<PropertyObject> ll = new LinkedList<PropertyObject>(selections);
			selections.clear();
			Iterator<PropertyObject> po = ll.descendingIterator();
			while (po.hasNext()) {
				selections.add(po.next());
			}
		}

		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			if (!items.isEmpty()) {
				for (StructuralChangeItem scan : items) {
					apply(scan);
				}
				repaint();				
			}
			return Status.OK_STATUS;
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return execute(monitor,info);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			if (!items.isEmpty()) {
				Iterator<StructuralChangeItem> reverse = items.descendingIterator();
				while (reverse.hasNext()) {
					apply(reverse.next().undo());
				}
				repaint();
				reverseSelections();
			}
			return Status.OK_STATUS;
		}
		
		private void repaint()
		{
			if (!repaint && !forceRepaint) {
				complete();
				return;
			}
			forceRepaint=false;
			refresh();
			complete();
		}
		
		private void apply(final StructuralChangeItem scan) {
			
			if (scan.item instanceof ReportComponent) {
				forceRepaint=true;
			}
			
			if (scan.oldParent!=null) {
				
				changes.add(scan.oldParent);
				
				//scan.item.remove();
				if (scan.oldParent instanceof AbstractControl) {
					((AbstractControl)scan.oldParent).removeChild(scan.item);
				} 
				awt.remove(scan.item);

				if (!repaint) swing(new Runnable() {
					public void run() {
						doRemoveSwing(scan.item);
					}
				});				
			}
			
			if (scan.newParent!=null) {
				
				changes.add(scan.newParent);
				selections.add(scan.item);
				
				if (scan.newParent instanceof AbstractTarget) {
					((AbstractTarget)scan.newParent).add(scan.item,scan.newIndex);
					scan.item.setParent(null);
				} else {
					((AbstractControl)scan.newParent).addChild(scan.item, scan.newIndex);
					scan.item.setParent(((AbstractControl)scan.newParent));
				}
				openControl(scan.item);
				if (!repaint) swing(new Runnable() {
					public void run() {
						doAddSwing(scan.item,true);
					}
				});				
			}
		}
	}
	
	private void doRemoveSwing(AbstractControl control) {
		Component c = control.getComponent();
		if (c!=null) {
			Container parent = c.getParent();
			parent.remove(control.getComponent());
		}
		control.disposeSwingComponent();
		
		for (AbstractControl ac :control.getChildren()) {
			doRemoveSwing(ac);
		}
	}
	
	private void doAddSwing(AbstractControl control,boolean repaint) {
		constructSwingComponent(control);
		AbstractControl po = control;
		while (po!=null) {
			if (po.getComponent()!=null) {
				po.getComponent().invalidate();
				po.getComponent().doLayout();
				po.getComponent().repaint();
			}
			if (repaint) {
				po=po.getParent();
			} else {
				break;
			}
		}
	}
	
	
	private class KeyboardMove extends AbstractOperation
	{
		private List<PropertyObject> items;
		private int xpos=0;
		private int ypos=0;
		private long lastMove;
		
		public KeyboardMove(IUndoContext undoContext,List<PropertyObject> items) {
			super("Keyboard Move");
			addContext(undoContext);
			this.items=new ArrayList<PropertyObject>(items);
			lastMove=System.currentTimeMillis();
		}
		
		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException 
		{
			apply(items,1);
			return Status.OK_STATUS;
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return execute(monitor,info);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			apply(items,-1);
			return Status.OK_STATUS;
		}

		private void apply(List<PropertyObject> items2, int i) {
			apply(items2,xpos*i,ypos*i);
		}
		
		private void apply(List<? extends PropertyObject> items2, int xDiff,int yDiff) {		
			for (PropertyObject scan : items2) {
				inc(scan,Prop.XPOS,xDiff);
				inc(scan,Prop.YPOS,yDiff);
				if (Compiler.dragKids(scan)) {
					apply(scan.getChildren(),xDiff,yDiff);
				}
			}
			
		}

		private void inc(PropertyObject scan, int prop, int diff) 
		{
			if (diff==0) return;
			int nv = scan.getProperty(prop).intValue()+diff;
			scan.setProperty(prop,nv);
			fireControlChanged(scan, prop, nv);
		}	
	}
	
	private void move(int prop,int diff)
	{
		List<PropertyObject> items = getRootSelections(null);
		
		IUndoableOperation op = OperationHistoryFactory.getOperationHistory().getUndoOperation(undoContext);
		KeyboardMove move = null;
		if (op!=null && (op instanceof KeyboardMove)) {
			move = (KeyboardMove)op;			
			if (!move.items.equals(items) || move.lastMove+1500<System.currentTimeMillis()) {
				move=null;
			} else {
				move.lastMove=System.currentTimeMillis();
			}
		}
		if (move==null) {
			move=new KeyboardMove(undoContext,items);
			OperationHistoryFactory.getOperationHistory().add(move);
		}
		
		if (prop==Prop.XPOS) {
			
			int ratio = awt.widthPixelsToDialog(1);
			if (ratio>0) diff=diff*ratio;
			
			move.xpos+=diff;
			move.apply(items,diff,0);
		}
		
		if (prop==Prop.YPOS) {
			int ratio = awt.heightPixelsToDialog(1);
			if (ratio>0) diff=diff*ratio;			
			
			move.ypos+=diff;
			move.apply(items,0,diff);
		}
		
		container.repaint();
	}
	
	private class MaskKeyListener implements KeyListener {
		@Override
		public void keyTyped(KeyEvent e) {
			if (e.getKeyChar()=='\t') {
				if ((e.getModifiers() & KeyEvent.CTRL_MASK)>0) {
					tabPrevious();
				} else {
					tabNext();
				}
			}
		}

		@Override
		public void keyPressed(KeyEvent e) {
			switch(e.getKeyCode()) {
				case KeyEvent.VK_UP:
					move(Prop.YPOS,-1);
					break;
				case KeyEvent.VK_DOWN:
					move(Prop.YPOS,1);
					break;
				case KeyEvent.VK_LEFT:
					move(Prop.XPOS,-1);
					break;
				case KeyEvent.VK_RIGHT:
					move(Prop.XPOS,1);
					break;
			}
		}

		@Override
		public void keyReleased(KeyEvent e) {
		}
		
	}

	private class MaskMouseMotionListener implements MouseMotionListener {

		@Override
		public void mouseMoved(MouseEvent e) {
			int cursor = getCursor(e.getX(),e.getY());
			mask.setCursor(Cursor.getPredefinedCursor(cursor));
			e.consume();
		}


		@Override
		public void mouseDragged(MouseEvent e) {
			if (dragFunction!=null && dragStart!=null) {
				Point move = new Point(e.getPoint());
				move.x=move.x-dragStart.x;
				move.y=move.y-dragStart.y;

				move.x=awt.widthPixelsToDialog(move.x);
				move.y=awt.heightPixelsToDialog(move.y);


				Point delta = new Point(move);
				delta.x=delta.x-lastDelta.x;
				delta.y=delta.y-lastDelta.y;

				lastDelta=move;

				int deltaX = delta.x*dragFunction[0];
				int deltaY = delta.y*dragFunction[1];
				int deltaWidth = delta.x*dragFunction[2];
				int deltaHeight = delta.y*dragFunction[3];

				Set<PropertyObject> movedItems=new HashSet<PropertyObject>();

				boolean moved=false;
				synchronized (_selections) {
					for (Iterator<PropertyObject> iter = _selections.iterator(); iter.hasNext(); ) {
						if (move(iter.next(), deltaX, deltaY,deltaWidth,deltaHeight,movedItems)) {
							moved=true;
						}
					}
				}
				if (moved) {
					
					if (_selections.size()==1 && _selections.get(0) instanceof AbstractWindowTarget) {
						((AbstractWindowTarget)awt).handleResize(container.getSize());
					}
					container.repaint();
				}
			}

			if (dragStart!=null && dragFunction==null) {
				dragEnd=e.getPoint();
				mask.repaint();
			}

			e.consume();
		}

		private boolean move(PropertyObject drag, int deltaX, int deltaY, int deltaWidth,int deltaHeight,Set<PropertyObject> movedItems) {
			if (movedItems.contains(drag)) {
				return false;
			}
			movedItems.add(drag);
			boolean move=false;
			if (!(drag instanceof TabControl)) {
				ExtendProperties ep = ((ExtendProperties) drag.getExtend());
				int _deltaX = deltaX;
				int _deltaY = deltaY;
				int _deltaWidth = deltaWidth;
				int _deltaHeight= deltaHeight;

				if (ep.negWidth) {
					_deltaX=deltaX+deltaWidth;
					_deltaWidth=-deltaWidth;
				}
				if (ep.negHeight) {
					_deltaY=deltaY+deltaHeight;
					_deltaHeight=-deltaHeight;
				}

				move=adjust(drag,Prop.XPOS,_deltaX,move);
				move=adjust(drag,Prop.YPOS,_deltaY,move);
				move=adjust(drag,Prop.WIDTH,_deltaWidth,move);
				move=adjust(drag,Prop.HEIGHT,_deltaHeight,move);
			}
			
			if (!Compiler.dragKids(drag)) return move; 

			Iterable<? extends PropertyObject> scanner=null;
			if (drag instanceof AbstractControl) {
				scanner = ((AbstractControl)drag).getChildren();
			}
			if (drag instanceof AbstractWindowTarget) {
				scanner = ((AbstractWindowTarget)drag).getControls();
			}

			if (scanner==null) return move;
			for (PropertyObject kid : scanner) {
				if (move(kid, deltaX, deltaY,0,0,movedItems)) {
					move=true;
				}
			}

			return move;
		}


		private boolean adjust(PropertyObject drag, int prop, int delta,boolean move) {
			if (delta==0) return move;
			int value = drag.getProperty(prop).intValue() + delta;
			drag.setProperty(prop, value);
			fireControlChanged(drag, prop, value);
			return true;
		}
	}

	private Component find(Component source,int x,int y)
	{
		if (source==mask) return null;
		if (source instanceof ClarionContentPane) return null;
		if (!source.isVisible()) return null;
		if (!source.contains(x,y)) return null;	
		if (!(source instanceof Container)) return null;
		
		for (Component scan  : ((Container)source).getComponents()) {
			Point offset =scan.getLocation();
			Component result = find(scan,x-offset.x,y-offset.y);
			if (result!=null) return result;
		}
		
		return source;
	}
	
	private void popMenu(MouseEvent me)
	{
		JPopupMenu jpm = new JPopupMenu();
		JMenu alignment = new JMenu("Alignment");
		if (lastSelection==null || _selections.size()<2) {
			alignment.setEnabled(false);
		}
		jpm.add(alignment);
		alignment.add("Horizontal").setEnabled(false);
		alignment.addSeparator();
		addAlignment(alignment,"Left",0,null);
		addAlignment(alignment,"Right",2,null);
		addAlignment(alignment,"Center",1,null);
		alignment.add("Vertical").setEnabled(false);
		alignment.addSeparator();
		addAlignment(alignment,"Top",null,0);
		addAlignment(alignment,"Bottom",null,2);
		addAlignment(alignment,"Center",null,1);
		
		
		JMenu size = new JMenu("Size");
		if (lastSelection==null || _selections.size()<2) {
			size.setEnabled(false);
		}
		jpm.add(size);
		addSize(size,"Same Width",true,false);
		addSize(size,"Same Height",false,true);
		addSize(size,"Same Size",true,true);

		
		JMenu spread = new JMenu("Spread");
		if (_selections.size()<3) {
			spread.setEnabled(false);
		}
		jpm.add(spread);
		addSpread(spread,"Spread Vertically (to fit)",true,false);
		addSpread(spread,"Spread Vertically (same spread)",true,true);
		addSpread(spread,"Spread Horizontally (to fit)",false,false);
		addSpread(spread,"Spread Horizontally (same spread)",false,true);
		
		JMenu ratio = new JMenu("Resizing");
		jpm.add(ratio);
		addRatio(ratio,"Fixed");
		addRatio(ratio,"Right");
		addRatio(ratio,"Bottom");
		addRatio(ratio,"Bottom Right");
		addRatio(ratio,"Spread");
		addRatio(ratio,"Scale");
		
		jpm.addSeparator();
		
		if (contributer!=null) {
			contributer.contributePopup(jpm);
		}
		
		jpm.show(mask,me.getX(),me.getY());
		
	}
	
	private void addRatio(JMenu ratio, final String describe) {
		JMenuItem item = new JMenuItem(describe);
		ratio.add(item);
		item.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				try {
					OperationHistoryFactory.getOperationHistory().execute(new RatioOperation(describe),null,null);
				} catch (ExecutionException e1) {
					e1.printStackTrace();
				}
			}
		});
	}

	private void addSpread(JMenu alignment, final String describe,final boolean vert,final boolean round) 
	{
		JMenuItem item = new JMenuItem(describe);
		alignment.add(item);
		item.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				spread(describe,vert,round);
			}
		});
		
	}
	
	private void spread(String describe, boolean vert,boolean round)
	{
		if (lastSelection!=null && _selections.size()>1) {
			try {
				OperationHistoryFactory.getOperationHistory().execute(new SpreadOperation(describe,vert,round),null,null);
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
		}
	}
	
	private class SpreadOperation extends AbstractOperation
	{
		public Map<PropertyObject,Point> 		selections;
		private PropertyObject primary;


		private Rectangle getBounds(PropertyObject po)
		{
			Rectangle r = new Rectangle(
					po.getProperty(Prop.XPOS).intValue(),
					po.getProperty(Prop.YPOS).intValue(),
					po.getProperty(Prop.WIDTH).intValue(),
					po.getProperty(Prop.HEIGHT).intValue()
					);
			if (r.width<0) {
				r.x+=r.width;
				r.width=-r.width;
			}
			if (r.height<0) {
				r.y+=r.height;
				r.height=-r.height;
			}
			return r;
		}		
		
		public SpreadOperation(String label,boolean vertical,boolean round) {
			super(label);
			selections=new LinkedHashMap<PropertyObject, Point>();

			int from=0;			// location of top control
			int to=0;			// location of bottom control.  from -> to defines the dimension of the selected controls
			int cover=0;		// some of widths of the controls
			int count=0;		// number of controls
			
			Map<Integer,PropertyObject> order = new TreeMap<Integer,PropertyObject>();
			
			for (PropertyObject scan : getRootSelections(null)) {
				Rectangle ctl = getBounds(scan);
				
				int pos=vertical ? ctl.y : ctl.x;
				int length=vertical ? ctl.height : ctl.width;
				
				if (count==0) {
					from = pos;
					to=pos+length;
				} else {
					if (pos<from) from=pos;
					if (pos+length>to) to=pos+length;
				}
				
				count++;
				cover+=length;
				order.put((pos<<16)+count,scan);
			}
			if (count<2) return;
			
			int boundary = to-from;   			// distance from top control to bottom control
			int gap    = boundary-cover;		// amount of space we have to adjust for purposes of spreading.  Could be negative for overlapping controls
			
			int num   =  gap;
			int denom =  count-1;
			
			if (round) {
				num = num/denom;
				denom=1;
			}
			
			Iterator<PropertyObject> iter = order.values().iterator();

			int cursor=from;
			
			// numerator to use for purpose of calculating spread. We cannot use num/denom every time as this will introduce cumulative rounding error
			// runningNum at the end of a calculation is primed with the rounding error so rounding errors cumulate and will trigger some gaps to be 
			// bigger than others once rounding error is big enough
			int runningNum=0;	 
						
			while (iter.hasNext()) {
				PropertyObject scan = iter.next();
				Rectangle ctl = getBounds(scan);				
				int pos=vertical ? ctl.y : ctl.x;
				int length=vertical ? ctl.height : ctl.width;				
				int newpos=cursor;
				selections.put(scan,new Point(!vertical ? newpos-pos : 0 , vertical ? newpos-pos : 0 ));
				
				runningNum+=num;
				int inc=runningNum/denom;				
				cursor+=length+inc;				
				runningNum-=inc*denom;
			}
			addContext(undoContext);
		}
		
	
		
		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException 
		{
			apply(1);
			return Status.OK_STATUS;
		}
		
		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			apply(1);
			return Status.OK_STATUS;
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			apply(-1);
			highlight(new ArrayList<PropertyObject>(selections.keySet()),primary);
			return Status.OK_STATUS;
		}		

		
		private void apply(int multiplier)
		{
			for (Map.Entry<PropertyObject,Point>   scan : selections.entrySet()) {
				apply(scan.getKey(),scan.getValue().x*multiplier,scan.getValue().y*multiplier);
			}
		}

		private void apply(PropertyObject key, int xDiff, int yDiff) 
		{
			if (xDiff==0 && yDiff==0) return;
			if (!(key instanceof TabControl)) {
				if (xDiff!=0) adjust(key,Prop.XPOS,xDiff);
				if (yDiff!=0) adjust(key,Prop.YPOS,yDiff);
			}
			
			if (!Compiler.dragKids(key)) return;
			for (PropertyObject kid : key.getChildren()) {
				apply(kid,xDiff,yDiff);
			}
		}

		private void adjust(PropertyObject key, int prop, int diff) {
			ClarionObject co = key.getRawProperty(prop,false);
			key.setProperty(prop,co==null ? diff : diff+co.intValue());
		}
	}
	
		
	
	private void addSize(JMenu alignment, final String describe,final boolean horiz,final boolean vert) 
	{
		JMenuItem item = new JMenuItem(describe);
		alignment.add(item);
		item.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				size(describe,horiz,vert);
			}
		});
		
	}
	
	private void size(String describe, boolean horiz,boolean vert)
	{
		if (lastSelection!=null && _selections.size()>1) {
			try {
				OperationHistoryFactory.getOperationHistory().execute(new SizeOperation(describe,horiz,vert),null,null);
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
		}
	}

	private class RatioOperation extends AbstractOperation
	{
		public 	Map<PropertyObject,ClarionObject> 		selections;
		public String ratio;


		public RatioOperation(String label) {
			super("Ratio :"+label);
			ratio=label.toLowerCase();
			addContext(undoContext);
			selections=new HashMap<PropertyObject,ClarionObject>();
			for (PropertyObject po : _selections) {
				selections.put(po,po.getRawProperty(Prop.RATIO,false));
			}
		}
		


		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException 
		{
			for (PropertyObject po : selections.keySet()) {
				ClarionObject co = po.getParentPropertyObject().getInheritedProperty(Prop.RATIO);
				if (co!=null) {
					if (co.toString().equals(ratio)) {
						po.setClonedProperty(Prop.RATIO, null);
						continue;
					}
				}po.setClonedProperty(Prop.RATIO, ratio);
			}
			return Status.OK_STATUS;
		}
		
		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return redo(monitor,info);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			for (Map.Entry<PropertyObject,ClarionObject> scan : selections.entrySet()) {
				scan.getKey().setClonedProperty(Prop.RATIO, scan.getValue());
			}
			return Status.OK_STATUS;
		}		

	}
	
	private class SizeOperation extends AbstractOperation
	{
		public 	Map<PropertyObject,Integer[]> 		selections;
		private PropertyObject primary;
		private Integer newWidth;
		private Integer newHeight;


		public SizeOperation(String label,boolean horiz,boolean vert) {
			super(label);

			
			if (horiz) {
				newWidth=lastSelection.getProperty(Prop.WIDTH).intValue();
			}
			if (vert) {
				newHeight=lastSelection.getProperty(Prop.HEIGHT).intValue();
			}
			
			selections=new LinkedHashMap<PropertyObject,Integer[]>();
			primary=lastSelection;
			
			for (PropertyObject scan : _selections) {
				if (scan instanceof TabControl) continue;
				
				Integer bits[] = new Integer[] {
						getit(scan,Prop.WIDTH),
						getit(scan,Prop.HEIGHT)
				};
				selections.put(scan, bits);
			}		
			
			addContext(undoContext);
		}
		


		private Integer getit(PropertyObject scan, int prop) {
			ClarionObject co = scan.getRawProperty(prop,false);
			return co==null ? null : co.intValue();
		}



		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException 
		{
			for (PropertyObject po : selections.keySet()) {
				if (newWidth!=null) {
					po.setProperty(Prop.WIDTH,newWidth);
				} 
				if (newHeight!=null) {
					po.setProperty(Prop.HEIGHT,newHeight);
				} 
			}
			return Status.OK_STATUS;
		}
		
		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return redo(monitor,info);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			for (Map.Entry<PropertyObject,Integer[]> scan : selections.entrySet()) {
				if (newWidth!=null) {
					scan.getKey().setClonedProperty(Prop.WIDTH, scan.getValue()[0]);
				}
				if (newHeight!=null) {
					scan.getKey().setClonedProperty(Prop.HEIGHT, scan.getValue()[1]);
				}
			}
			highlight(new ArrayList<PropertyObject>(selections.keySet()),primary);
			return Status.OK_STATUS;
		}		

	}
	
	
	
	private void addAlignment(JMenu alignment, final String describe,final Integer horiz,final Integer vert) 
	{
		JMenuItem item = new JMenuItem(describe);
		alignment.add(item);
		item.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				align(describe,horiz,vert);
			}
		});
		
	}
	
	private void align(String describe, Integer horiz,Integer vert)
	{
		if (lastSelection!=null && _selections.size()>1) {
			try {
				OperationHistoryFactory.getOperationHistory().execute(new AlignmentOperation(describe,horiz,vert),null,null);
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	private class AlignmentOperation extends AbstractOperation
	{
		public Map<PropertyObject,Point> 		selections;
		private PropertyObject primary;


		private Rectangle getBounds(PropertyObject po)
		{
			Rectangle r = new Rectangle(
					po.getProperty(Prop.XPOS).intValue(),
					po.getProperty(Prop.YPOS).intValue(),
					po.getProperty(Prop.WIDTH).intValue(),
					po.getProperty(Prop.HEIGHT).intValue()
					);
			if (r.width<0) {
				r.x+=r.width;
				r.width=-r.width;
			}
			if (r.height<0) {
				r.y+=r.height;
				r.height=-r.height;
			}
			return r;
		}		
		
		public AlignmentOperation(String label,Integer horiz,Integer vert) {
			super(label);

			
			Rectangle p = getBounds(lastSelection);
			selections=new LinkedHashMap<PropertyObject,Point>();
			primary=lastSelection;
			
			for (PropertyObject scan : getRootSelections(null)) {
				Rectangle ctl = getBounds(scan);
				
				int diffX=0;
				int diffY=0;
				
				if (horiz!=null) {
					diffX=p.x+(p.width-ctl.width)*horiz/2-ctl.x;
				}
				if (vert!=null) {
					diffY=p.y+(p.height-ctl.height)*vert/2-ctl.y;
				}				
				selections.put(scan,new Point(diffX,diffY));
			}		
			
			addContext(undoContext);
		}
		


		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException 
		{
			apply(1);
			return Status.OK_STATUS;
		}
		
		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			apply(1);
			return Status.OK_STATUS;
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			apply(-1);
			highlight(new ArrayList<PropertyObject>(selections.keySet()),primary);
			return Status.OK_STATUS;
		}		

		
		private void apply(int multiplier)
		{
			for (Map.Entry<PropertyObject,Point>   scan : selections.entrySet()) {
				apply(scan.getKey(),scan.getValue().x*multiplier,scan.getValue().y*multiplier);
			}
		}

		private void apply(PropertyObject key, int xDiff, int yDiff) 
		{
			if (xDiff==0 && yDiff==0) return;
			if (!(key instanceof TabControl)) {
				if (xDiff!=0) adjust(key,Prop.XPOS,xDiff);
				if (yDiff!=0) adjust(key,Prop.YPOS,yDiff);
			}
			
			if (!Compiler.dragKids(key)) return;
			for (PropertyObject kid : key.getChildren()) {
				apply(kid,xDiff,yDiff);
			}
		}

		private void adjust(PropertyObject key, int prop, int diff) {
			ClarionObject co = key.getRawProperty(prop,false);
			key.setProperty(prop,co==null ? diff : diff+co.intValue());
		}
	}

	private void recalcLastSelection()
	{
		if (_selections.isEmpty()) {
			lastSelection=null;
		} else {
			lastSelection=_selections.get(_selections.size()-1);
		}		
	}
	
	private void handleMouseSelection(PropertyObject control, boolean multiSelect,PropertyObject deselectedControl) {
		if (control != null) {
			if (multiSelect) {
				if (_selections.contains(control)) {
					_selections.remove(control);
					recalcLastSelection();
				} else {
					if (deselectedControl!=null) {
						_selections.remove(deselectedControl);
					}
					_selections.add(control);
					lastSelection=control;
				}
			} else {
				// Single selection
				_selections.clear();
				_selections.add(control);
				lastSelection=control;
			}

			if (control instanceof TabControl) {
				TabControl tab  = (TabControl)control;
				SheetControl sheet = (SheetControl)tab.getParent();
				sheet.getUseObject().setValue(sheet.getChildIndex(tab) + 1);
			}
		} else {
			if (!multiSelect) {
				// Clicked outside of any controls so clear the selection
				_selections.clear();
				lastSelection=null;
			} else {
				if (deselectedControl!=null) {
					_selections.remove(deselectedControl);					
				}
				if (lastSelection==deselectedControl) {
					recalcLastSelection();
				}
			}
		}
	}
	
	private static final int MIN_PRIORITY=1;
	private static final int MAX_PRIORITY=3;
	private static Map<Class<? extends PropertyObject>,Integer> priority;
	static {
		priority=new HashMap<Class<? extends PropertyObject>,Integer>();
		priority.put(PanelControl.class,2);
		priority.put(GroupControl.class,2);
		priority.put(TabControl.class,3);
		priority.put(SheetControl.class,2);
		priority.put(SheetControl.class,2);
	};
	
	
	private class MaskMouseListener implements MouseListener {


		public boolean resendEvent(MouseEvent e) {
			Component locate = find(container,e.getX(),e.getY());
			if ((locate instanceof JComponent) && ((JComponent)locate).getClientProperty("AboveMask")!=null) {
					
					
				Component scan=locate;
				int x=e.getX();;
				int y=e.getY();
				while (scan!=container) {
					Point p = scan.getLocation();
					x=x-p.x;
					y=y-p.y;
					scan=scan.getParent();
				}
				
				locate.dispatchEvent(new MouseEvent(locate, e.getID(),e.getWhen(),e.getModifiers(),
						x,y,e.getXOnScreen(),e.getYOnScreen(),e.getClickCount(),false,e.getButton()));
				return true;
			}
			return false;
		}
		
		
		private int calcPriority(PropertyObject po)
		{
			Integer result = priority.get(po.getClass());
			if (result!=null) return result;
			return 1;
		}

		@Override
		public void mouseClicked(MouseEvent e) {
			if (resendEvent(e)) return;
			
			if (e.getButton()==MouseEvent.BUTTON3) {
				popMenu(e);
			}
			
			if (e.getButton()!=1) return;
			
			if (lastMouseHighlight!=null) {
				Rectangle r = getPropertyBounds(lastMouseHighlight);
				if (r!=null && !r.contains(e.getPoint())) {
					lastMouseHighlight=null;
				}
			}
			
			if (e.getModifiersEx() == InputEvent.CTRL_DOWN_MASK) {
				for (PropertyObject po : _selections) {
					if (po==lastSelection) continue;
					Rectangle r = getPropertyBounds(po);
					if (r!=null && r.contains(e.getPoint())) {
						lastSelection=po;
						mask.repaint();
						lastMouseHighlight=null;
						e.consume();
						return;
					}
				}
			}
					
			boolean abortedAtOldSelection=false;
			ControlIterator ci = new ControlIterator(awt);
			ci.setScanDisabled(true);
			ci.setScanHidden(true);
			PropertyObject match = null;
			boolean matchIsAlt=false;
			PropertyObject oldSelection = lastMouseHighlight;
			boolean foundSomething=false;
			
			int matchPriority=MAX_PRIORITY;
			int minPriority=MIN_PRIORITY;
			if (lastMouseHighlight!=null) {
				minPriority=calcPriority(lastMouseHighlight);
			}
			
			PropertyObject nearMatch = null;
			boolean nearMatchIsAlt=false;
			
			while (ci.hasNext()) {
				AbstractControl test = ci.next();
				Rectangle r=null;
				boolean alt=false;
				if (invisibleTab(test)) {
					r=getAltBounds(test);
					alt=true;
				} else {
					r = getPropertyBounds(test);
				}
				if (r!=null && r.contains(e.getPoint())) {
					foundSomething=true;
					int p = calcPriority(test);
					if (alt) p=1;
					if (test == oldSelection) {
						
						abortedAtOldSelection=true;

						if (match==null) {
							minPriority=p+1;
							match=nearMatch;
							matchIsAlt=nearMatchIsAlt;
						} else {
							break;
						}
					}
					
					
					if (p>=minPriority) {
						nearMatchIsAlt=alt;
						nearMatch = test;
						if (p<=matchPriority) {
							matchIsAlt=alt;
							match = test;
							matchPriority=p;
						}
					}
				}
			}
			if (match==null && !foundSomething) {
				if (oldSelection!=awt) {
					match=awt;
				} else {
					match=null;
				}
			}			
			
			if (matchIsAlt) {
				if (match instanceof TabControl) {
					TabControl tab  = (TabControl)match;
					SheetControl sheet = (SheetControl)tab.getParent();
					sheet.getUseObject().setValue(sheet.getChildIndex(tab) + 1);
					resetHighlight();
				}								
			} else {
				handleMouseSelection(match, e.getModifiersEx() == InputEvent.CTRL_DOWN_MASK,abortedAtOldSelection ? lastMouseHighlight : null);
				lastMouseHighlight=match;
			}
			fireMouseSelectionChanged();
			mask.repaint();
			e.consume();
		}

		@Override
		public void mousePressed(MouseEvent e) {
			if (resendEvent(e)) return;
			if (e.getButton()!=1) return;
			
			int cursor=getCursor(e.getX(),e.getY());
			dragStart=e.getPoint();
			lastDelta=new Point();
			dragFunction=dragFunctions.get(cursor);
			mask.setCursor(Cursor.getPredefinedCursor(cursor));
			if (dragFunction==null) dragFunction=defaultDragFunction;
			if (cursor==Cursor.DEFAULT_CURSOR) {
				dragFunction=null;
			}

			if (dragFunction!=null) {
				for (PropertyObject po : _selections) {
					ExtendProperties ep = (ExtendProperties)po.getExtend();
					ep.negWidth = isNeg(po,Prop.WIDTH);
					ep.negHeight = isNeg(po,Prop.HEIGHT);
				}
			}
			
			if (_selections.size()==1 && _selections.get(0) instanceof AbstractWindowTarget) {
				AbstractWindowTarget target = (AbstractWindowTarget)awt;
				CWin.getInstance().setDefaultRatios(target);
				target.handleOpen(container.getSize());
			}
			

			e.consume();
		}

		private boolean isNeg(PropertyObject po, int width) 
		{
			ClarionObject co = po.getRawProperty(width,false);
			return co!=null && co.intValue()<0;
		}

		@Override
		public void mouseReleased(MouseEvent e) {
			if (resendEvent(e)) return;
			if (e.getButton()!=1) return;
			
			int cursor=getCursor(e.getX(),e.getY());
			mask.setCursor(Cursor.getPredefinedCursor(cursor));

			if (dragEnd!=null) {
				if (e.getModifiersEx() != InputEvent.CTRL_DOWN_MASK) {
					_selections.clear();
					
				}
				_selections.addAll(dragSelections);
				if (_selections.isEmpty()) {
					lastSelection=null;
				} else {
					lastSelection=_selections.get(_selections.size()-1);
				}
				fireMouseSelectionChanged();
				mask.repaint();
			}

			if ((dragFunction != null) && dragStart!=null && !e.getPoint().equals(dragStart)) {
				int deltaX = awt.widthPixelsToDialog(e.getX() - dragStart.x);
				int deltaY = awt.heightPixelsToDialog(e.getY() - dragStart.y);
				
				List<PropertyChange> otherChanges=null;
				
				if (_selections.size()==1 && _selections.get(0) instanceof AbstractWindowTarget) {
					AbstractWindowTarget target = (AbstractWindowTarget)awt;
					otherChanges=target.collateResizeChanges();
					target.clearResizeMetaData();					
				}
				
				fireMouseDragged(
						dragStart.x,
						dragStart.y,
						e.getX(),
						e.getY(),
						deltaX * dragFunction[0],
						deltaY * dragFunction[1],
						deltaX * dragFunction[2],
						deltaY * dragFunction[3],
						(e.getModifiersEx() != InputEvent.CTRL_DOWN_MASK),otherChanges);
			}

			dragStart=null;
			dragEnd=null;
			e.consume();
		}

		@Override
		public void mouseEntered(MouseEvent e) {
			e.consume();
		}

		@Override
		public void mouseExited(MouseEvent e) {
			if (dragStart==null) {
				mask.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
			}
			e.consume();
		}
	}


	public void refresh()
	{
		swing(new Runnable() {
			public void run() {
				_refresh();
			}
		});
	}

	private void _refresh()
	{
		container.removeAll();
		if (container instanceof ClarionContentPane) {
			((ClarionContentPane)container).setOffset(0);
		}
		container.add(mask);
		if (container instanceof ClarionContentPane) {
			((ClarionContentPane)container).setOffset(1);
		}
		
		for (AbstractControl ac : awt.getChildren()) {
			_removeSwingComponent(ac);
		}

		constructSwingComponent(awt);
		container.invalidate();
		container.doLayout();
		container.validate();
	}

	private void _removeSwingComponent(AbstractControl ac) {
		ac.disposeSwingComponent();
		for (AbstractControl child : ac.getChildren()) {
			_removeSwingComponent(child);
		}
	}

	public boolean isDescendant(PropertyObject child,PropertyObject parent)
	{
		while (child!=null) {
			if (child==parent) return true;
			child=child.getParentPropertyObject();
		}
		return false;
	}

	public List<PropertyObject> getRootSelections(PropertyObject excludeAncestorsOfThis)
	{
		List<PropertyObject> objects = new LinkedList<PropertyObject>();
		
		for (PropertyObject po : _selections) {
		
			if (excludeAncestorsOfThis!=null && isDescendant(excludeAncestorsOfThis,po)) {
				continue;
			}
			
			Iterator<PropertyObject> oscan = objects.iterator();
			while (oscan.hasNext()) {
				PropertyObject exist = oscan.next();
				if (isDescendant(po,exist)) {
					po=null;
					break;
				}
				if (isDescendant(exist,po)) {
					oscan.remove();
				}
			}
			if (po==null) continue;
			objects.add(po);
		}
		return objects;
	}
	
	public String getTextSelection()
	{		
		Serializer str = new Serializer();
		StringBuilder sb = new StringBuilder();
		for (PropertyObject po : getRootSelections(null)) {
			try {
				str.serialize(po, sb);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}	
		return sb.toString();
	}

}
