package org.jclarion.clarion.ide.dialog.prompt;


import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.SortedSet;
import java.util.Stack;
import java.util.TreeSet;

import org.jclarion.clarion.ide.model.manager.ColorHelper;
import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CCombo;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.KeyListener;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.layout.RowData;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Group;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Spinner;
import org.eclipse.swt.widgets.TabFolder;
import org.eclipse.swt.widgets.TabItem;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.dict.File;
import org.jclarion.clarion.appgen.dict.Key;
import org.jclarion.clarion.appgen.dict.TextDictLoad;
import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.MultiSymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.at.AtSourceSession;
import org.jclarion.clarion.appgen.template.cmd.AtParam;
import org.jclarion.clarion.appgen.template.cmd.BoxedCmd;
import org.jclarion.clarion.appgen.template.cmd.ButtonCmd;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.DisplayCmd;
import org.jclarion.clarion.appgen.template.cmd.EnableCmd;
import org.jclarion.clarion.appgen.template.cmd.FieldCmd;
import org.jclarion.clarion.appgen.template.cmd.InsertWidget;
import org.jclarion.clarion.appgen.template.cmd.PromptCmd;
import org.jclarion.clarion.appgen.template.cmd.SheetCmd;
import org.jclarion.clarion.appgen.template.cmd.TabCmd;
import org.jclarion.clarion.appgen.template.cmd.Widget;
import org.jclarion.clarion.appgen.template.cmd.WidgetContainer;
import org.jclarion.clarion.appgen.template.cmd.WithCmd;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.runtime.expr.LabelExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.format.Formatter;

import java.io.IOException;
import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.TextAppLoad;
import org.jclarion.clarion.appgen.app.TextAppStore;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.TemplateLoader;



public class PromptDialog extends Dialog 
{
	
	public static void main(String args[]) throws IOException {
		TemplateChain chain = new TemplateChain();
		TemplateLoader loader = new TemplateLoader(chain);		
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","abchain.tpl");
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","LOCUSABC.tpl");
		chain.finalise();
		
		Dict d = (new TextDictLoad()).load("/home/barney/personal/c8/java/sourceforge/clarion2java/appgen/trunk/target/app/c8odbc.dict");		
		
		
		App a = (new TextAppLoad(chain)).load("/home/barney/personal/c8/java/sourceforge/clarion2java/appgen/trunk/target/app/");
		ExecutionEnvironment g = new ExecutionEnvironment(chain,a,d);
		g.setLibSrc("/home/barney/personal/c8/java/clarion/c9/src/main/clarion/libsrc");
		g.setGenerationEnabled(false);
		g.init();
		g.generate(a,true);
		g.recycle();
		
		Procedure src = a.getProcedure("accUpdate");
		
		Procedure p = new Procedure(src);
		g.setAlternative(src, p);
		System.out.println(p.getWindow());
		
		PromptDialog pe = new PromptDialog(null);
		
		pe.setInfo(g, p.getAddition(2),null);
		pe.open();
		TextAppStore tas = new TextAppStore(chain);
		tas.setTarget("/dev/stdout");
		tas.serializePrompts(src.getPrompts(),false);
	}
	
	
	private WidgetContainer container;
	private ExecutionEnvironment generator;
	private AtSource source;
	private String name;
	private AtSourceSession session;
	private boolean primary;
	private String field;

	public PromptDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public PromptDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(ExecutionEnvironment generator,AtSource source,String field)
	{
		setInfo(null,generator,source,field);
	}
	
	public void setInfo(WidgetContainer cont,ExecutionEnvironment generator,AtSource source,String field)
	{
		this.primary=(cont==null);
		this.container=cont;
		this.generator=generator;
		this.source=source;
		this.field=field;
		session = generator.getSession(source);		
		CodeSection cs = session.getCodeSection();		
		session.prepare();

		if (this.container==null) {
			this.container = cs;
			if (cs.getWidgets().size()==1 && cs.getWidgets().get(0) instanceof WidgetContainer) {
				this.container=(WidgetContainer)cs.getWidgets().get(0);
			}
		}
		
		name = container.getLabel(generator);
	}
	
	public String getName()
	{
		return name;
	}

	private Control 		lastControl;
	private List<Runnable> 	listenerHarvest;
	
	private static class WithEntry
	{
		public SymbolEntry 	se;
		public SymbolValue  value;
		public WithEntry 	prior;
		public void prepare() {
			se.list().values().fix(value);			
		}
	}
	private WithEntry 		withStack;
	private boolean startup=true;
	

	
	public void addListener(Runnable l) 
	{
		listenerHarvest.add(l);
	}
	
	public void runListeners()
	{
		for (Runnable r : listenerHarvest) {
			r.run();
		}
	}
	
	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText(name);
		Composite container = (Composite) super.createDialogArea(parent);		
		container.setLayout(null);
		listenerHarvest=new ArrayList<Runnable>();
		
		constructControls(this.container,container,false,field);
		
		runListeners();		
		startup=false;
		return container;
	}

	private boolean open(WidgetContainer container)
	{
		PromptDialog dialog = new PromptDialog(getShell());
		dialog.setInfo(container,this.generator,this.source,null);
		return dialog.open()==Dialog.OK;
	}
	
	

	@Override
	public int open() {
		AdditionExecutionState state = session. prepareToExecute();
		UserSymbolScope save = session.getScope().save();
		int result = super.open();
		if (result!=OK) {
			session.getScope().restore(save);
		} else {
			if (primary) {
				UserSymbolScope ns=new UserSymbolScope(session.getScope(),new AppLoaderScope(),false);
				ns.constrainFields(session.getCodeSection().getDeclaredPrompts());
				source.setPrompts(ns);
			}					
		}
		state.finish();
		return result;
	}

	private void constructControls(WidgetContainer container,Composite parent,boolean clearLast,String field)
	{
	
		if (container instanceof MultiWidgetContainer) {
			MultiWidgetContainer mwc = (MultiWidgetContainer)container; 
			constructMultiButton( mwc.getButton() ,parent,mwc.multi);
			return;
		}
		
		if (clearLast) {
			lastControl=null;
		}
		for (Widget scan : container.getWidgets()) {
			if (field==null) {
				constructControl(scan,parent);
			} else {
				constructFieldControl(scan,parent,field);
			}
		}
		if (clearLast) {
			lastControl=parent;
		}
	}
	
	private static class MultiWidgetContainer implements WidgetContainer
	{
		private ButtonCmd button;
		private List<ButtonCmd> buttons;
		private boolean multi;
		
		public MultiWidgetContainer(ButtonCmd button,boolean multi)
		{
			this.button=button;
			buttons=new LinkedList<ButtonCmd>();
			this.multi=multi;
			buttons.add(button);
		}
		
		@Override
		public void addWidget(Widget w) 
		{
			throw new IllegalStateException("Do not call");
		}

		@Override
		public List<? extends Widget> getWidgets() 
		{
			return buttons;
		}
		
		public ButtonCmd getButton()
		{
			return button;
		}

		@Override
		public String getLabel(ExecutionEnvironment environment) {
			return button.getLabel(environment);
		}
		
	}
	
	private void constructFieldControl(Widget scan,Composite parent,String field)
	{
		if (scan.getPrepare()!=null) {
			scan.getPrepare().run(generator);
		}
		if (scan instanceof InsertWidget) {
			constructControls((InsertWidget)scan,parent,false,field);
			return;
		}
		if (scan instanceof FieldCmd) {
			getEnvironment().getScope().get("%control").list().values().fix(SymbolValue.construct(field));
			FieldCmd fc = (FieldCmd)scan;
			if (fc.getWhere()==null || getEnvironment().eval(fc.getWhere()).boolValue()) {
				constructControls(fc,parent,false,null);
			}
			return;
		}
	}
	
	private void constructControl(Widget scan,Composite parent)
	{
			if (scan.getPrepare()!=null) {
				scan.getPrepare().run(generator);
			}
			if (scan instanceof SheetCmd) {
				constructSheet((SheetCmd)scan,parent);
				return;
			}
			if (scan instanceof TabCmd) {
				constructTab((TabCmd)scan,parent);
				return;
			}
			if (scan instanceof ButtonCmd) {
				constructButton((ButtonCmd)scan,parent);
				return;
			}
			if (scan instanceof PromptCmd) {
				constructPrompt((PromptCmd)scan,parent);
				return;
			}
			if (scan instanceof DisplayCmd) {
				constructDisplay((DisplayCmd)scan,parent);
				return;
			}
			if (scan instanceof EnableCmd) {
				constructEnable((EnableCmd)scan,parent);
				return;
			}
			if (scan instanceof WithCmd) {
				constructWith((WithCmd)scan,parent);
				return;
			}
			if (scan instanceof BoxedCmd) {
				constructBoxed((BoxedCmd)scan,parent);
				return;
			}
			if (scan instanceof InsertWidget) {
				constructControls((InsertWidget)scan,parent,false,null);
				return;
			}
			if (scan instanceof FieldCmd) {				
				return;
			}
			throw new IllegalStateException("Do not know how to construct:"+scan);
	}
	

	private ExecutionEnvironment getEnvironment()
	{
		return generator;
	}
	
	private int MARGIN=5;
	private int MAXWIDTH=400;
	private int MAXHEIGHT=500;
	private int PARTWIDTH=190;
	private int PARTSHIFT=0;
	private int globalOffsetY=0;
	
	private Stack<int[]> spaceStack=new Stack<int[]>();
	
	public void pushClientArea(Composite comp)
	{
		spaceStack.add(new int[] { MARGIN, MAXWIDTH,MAXHEIGHT,PARTWIDTH });
		
		Rectangle r = comp.getClientArea();
		Point size = comp.getSize();
		
		int diff = size.x-r.width;
		if (diff>0) {			
			MAXWIDTH-=diff;
			PARTWIDTH-=diff/2;
		}
		
	}
	
	public void popClientArea()
	{
		int[] bits = spaceStack.pop();
		MARGIN=bits[0];
		MAXWIDTH=bits[1];
		MAXHEIGHT=bits[2];
		PARTWIDTH=bits[3];
	}
	
	
	private static int convX(int x)
	{
		if (x==-1) return 0;
		return x*2;
	}
	
	private static int convY(int x)
	{
		if (x==-1) return 0;
		return x*20/7;
	}
	
	private void repack(Control c)
	{
		Point size = c.getSize();
		c.pack();
		Point packSize = c.getSize();
		c.setSize(
				Math.max(size.x, packSize.x),
				Math.max(size.y, packSize.y));
		
		
		//System.out.println("repack:"+c+" "+size+" "+packSize+" "+c.getSize());
		
		lastControl=c;
		
		
	}

	private void position(Control c,AtParam loc,int minWidth,int minHeight)
	{
		position(c,loc,minWidth,minHeight,MAXWIDTH-5,false);
	}
	
	private void position(Control c,AtParam loc,int minWidth,int minHeight,boolean newline)
	{
		position(c,loc,minWidth,minHeight,MAXWIDTH-5,newline);
	}
	
	
	private void position(Control c,AtParam loc,int minWidth,int minHeight,int maxWidth,boolean newline)
	{
		int width=convX(loc!=null ? loc.getWidth() : 0 );
		int height=convY(loc!=null ? loc.getHeight() : 0 );
		if (!(c instanceof Canvas)) {
			c.pack();
			if (width<c.getSize().x) {
				width=c.getSize().x;
			}
			if (height<c.getSize().y) {
				height=c.getSize().y;
			}			
		}
		if (width<minWidth) width=minWidth;
		if (height<minHeight) height=minHeight;
		if (width>maxWidth) width=maxWidth;
		
		c.setSize(width, height);

		
		int x=0;
		int y=0;
		boolean xdef=false,ydef=false;
		
		if (loc!=null) {
			if (loc.getX()>-1) {
				xdef=true;
				x=convX(loc.getX());
			}
			if (loc.getY()>-1) {
				ydef=true;
				y=convY(loc.getY());
			}
			if (xdef || ydef) {
				Point offset = new Point(0,0);
				Control scan = c.getParent();
				while (scan!=null && !(scan instanceof Shell)) {
					Point add = scan.getLocation();
					offset.x+=add.x;
					offset.y+=add.y;
					scan=scan.getParent();
				}
				
				if (xdef) {
					x=x-offset.x;
					if (x<0) x=0;
				}
				if (ydef) {
					y=y-offset.y+globalOffsetY;					
					if (y<0) y=0;
				}
			}
		}
		
		if (!xdef) {
			if (lastControl==null) {
				x=0;
			} else {
				if (newline || lastControl.getLocation().x+lastControl.getSize().x+MARGIN+width>MAXWIDTH) {
					x=0;
					if (!ydef) {
						y=lastControl.getLocation().y+lastControl.getSize().y+MARGIN;
						ydef=true;
					}
				} else {
					x=lastControl.getLocation().x+lastControl.getSize().x+MARGIN;
					if (!ydef) {
						ydef=true;
						y=lastControl.getLocation().y;
					}
				}
			}
		}
		
		if (!ydef) {
			if (lastControl==null) {
				y=0;
			} else {
				y=lastControl.getLocation().y+lastControl.getSize().y+MARGIN;
			}
		}
		
		Rectangle clientArea=c.getParent().getClientArea();
		if (c.getParent() instanceof Group) {
			Group g=  (Group)c.getParent();
			if (g.getText()!=null) {
				clientArea.y=25;
			}
		}
		if (x<clientArea.x) x=clientArea.x;
		if (y<clientArea.y) y=clientArea.y;
		c.setLocation(x, y);

		/*
		System.out.print(c+" ");
		int depth=0;
		Control scan = c;
		while (scan!=null) {
			scan=scan.getParent();
			depth++;
		}
		System.out.print(depth+" ");
		
		if (lastControl==null) {
			System.out.print("Last:"+null);
		} else {
			System.out.print("Last:"+lastControl.getBounds());
		}
		System.out.println("this:"+c.getBounds()+" "+loc);
		*/
		
		lastControl=c;
		return;
	}
	
	private int getYOffset(Control c)
	{
		int offset=0;
		Control scan = c.getParent();
		while (scan!=null) {
			Point add = scan.getLocation();
			offset+=add.y;
			scan=scan.getParent();
		}
		Rectangle clientArea=c.getParent().getClientArea();
		offset+=clientArea.y;
		return offset;
	}
	
	private void constructBoxed(final BoxedCmd box,Composite parent) 
	{
		String text = box.getLabel(generator); 
		boolean where=false;
		if (box.getWhere()!=null) {
			where=true;
			if (box.getWhere() instanceof LabelExpr) {
				if ( ((LabelExpr)box.getWhere()).getName().equalsIgnoreCase("%false")) {
					where=false;
				}
			}
		}
		
		if (text!=null && text.trim().length()==0) text=null;
		if (text==null && !where && box.isHide()) return;
		
		
		if (text!=null) {
			final Group g = new Group(parent,SWT.BORDER);
			g.setText(text.trim());
			position(g,box.getAt(),MAXWIDTH,0);
			pushClientArea(g);
			int lasty=globalOffsetY;
			if (box.isSection()) {
				globalOffsetY=getYOffset(g)+10;
			}
			constructControls(box, g, true,null);
			popClientArea();
			globalOffsetY=lasty;
			repack(g);
			if (where) {
				addListener(new Runnable() {
					@Override
					public void run() {
						setVisible(g,getEnvironment().eval(box.getWhere()).boolValue());
					}
				});				
			}
			if (box.isHide()) {
				setVisible(g,false);
			}
			return;
		}
		
		final Canvas g = new Canvas(parent,SWT.NONE);
		position(g,box.getAt(),MAXWIDTH,0);
		int lasty=globalOffsetY;
		if (box.isSection()) {
			globalOffsetY=getYOffset(g)+10;
		}
		constructControls(box, g, true,null);
		globalOffsetY=lasty;
		repack(g);
		if (where) {
			addListener(new Runnable() {
				@Override
				public void run() {
					setVisible(g,getEnvironment().eval(box.getWhere()).boolValue());
				}
			});				
		}
		if (box.isHide()) {
			setVisible(g,false);
		}
	}
	
	private void setEnabled(Control c,boolean visible)
	{
		if (!(c.isEnabled() ^ visible) && !startup) return;
		c.setEnabled(visible);
		if (c instanceof Composite) {
			for (Control kid : ((Composite)c).getChildren()) {
				setEnabled(kid,visible);
			}
		}
	}	
	
	private void setVisible(Control c,boolean visible)
	{
		if ( !(c.isVisible() ^ visible) && !startup) return;
		c.setVisible(visible);
		if (c instanceof Composite) {
			for (Control kid : ((Composite)c).getChildren()) {
				setVisible(kid,visible);
			}
		}
	}

	private void constructWith(WithCmd scan,Composite parent) 
	{		
		WithEntry we = new WithEntry();
		we.se=getEnvironment().getScope().get(scan.getSymbol());
		we.value=SymbolValue.construct(getEnvironment().eval(scan.getValue()));
		we.prior=withStack;
		withStack=we;
		we.prepare();
		
		constructControls(scan, parent,false,null);
		
		withStack=withStack.prior;
	}

	private void constructDisplay(DisplayCmd scan,Composite parent) 
	{
		String text = scan.getLabel(getEnvironment());
		
		boolean multi = text.length()>40;
		
		Label l=new Label(parent,multi ? SWT.WRAP : SWT.NONE);
		l.setText(text);
		position(l, scan.getAt(), multi ? MAXWIDTH : 0 ,0);
		if (multi) {
			l.setSize(MAXWIDTH-l.getLocation().x,l.getSize().y);
		}
	}
	
	private class MultiWidgets
	{
		public Table 			table;
		public ButtonCmd 		button;
		public Button 			insert;
		public Button 			prop;
		public Button 			delete;
		public Button 			up;
		public Button 			down;
		public MultiSymbolEntry entry;
		public ListSymbolValue 	src;
		
		
		public void loadQueue() {	
			int pos = table.getSelectionIndex();
			table.removeAll();
			ListSymbolValue src = getEnvironment().getScope().get(button.getSymbol()).list().values();			
			ListScanner scan = src.loop(false);
			while (scan.next()) {
				TableItem tc = new TableItem(table,SWT.NONE);
				/*
				if (button.isMulti()) {
					tc.setText(src.value().getString()+" : "+getEnvironment().eval(button.getExpression()).toString());
				}*/
				tc.setText(getEnvironment().eval(button.getExpression()).toString());
			}
			
			if (pos>=table.getItems().length) {
				pos--;
			}
			if (pos>-1) {
				table.select(pos);
			}
		}


		public Button createButton(String string,int len,Composite parent) {
			Button b = new Button(parent,SWT.PUSH);
			b.setText(string);
			return b;
		}

		public Button createButton(int type,int len,Composite parent) {
			Button b = new Button(parent,type);
			return b;
		}

		public void prime()
		{
			entry = getEnvironment().getScope().get(button.getSymbol()).list();
			src = entry.list().values();			
		}
		
		public boolean select() 
		{
			prime();
			int pos = table.getSelectionIndex()+1;
			if (pos==0) return false;
			return src.select(pos);
		}
	
		public void swap(int i) {
			
			if (!select()) return;			
			SymbolValue val = src.value();
			SymbolValue swap = SymbolValue.construct(val.getInt()+i);
			if (!src.fix(swap)) return;
			entry.alertListenersOfValueChange(swap.getString(),"_TMP");
			entry.alertListenersOfValueChange(val.getString(),swap.getString());
			entry.alertListenersOfValueChange("_TMP",val.getString());
			int pos = table.getSelectionIndex();
			loadQueue();
			table.select(pos+i);
		}
	}

	private void constructMultiButton(final ButtonCmd btn,Composite parent,boolean multi) 
	{
		final MultiWidgets w = new MultiWidgets();
		
		Canvas structure = new Canvas(parent,SWT.NONE);		
		structure.setLayout(new RowLayout(SWT.VERTICAL));
		w.table=new Table(structure,SWT.BORDER);
		w.table.setSize(MAXWIDTH-10,250);
		w.table.setLayoutData(new RowData(MAXWIDTH-10, 250));
		
		Canvas buttonPanel = new Canvas(structure,SWT.NONE);
		buttonPanel.setLayout(new RowLayout(SWT.HORIZONTAL));
		w.button=btn;			
		if (multi) w.insert=w.createButton("&Insert",35,buttonPanel);
		w.prop=w.createButton("&Properties",50,buttonPanel);
		if (multi) {
			w.delete=w.createButton("&Delete",35,buttonPanel);
			w.up=w.createButton(SWT.ARROW+SWT.UP,15,buttonPanel);
			w.down=w.createButton(SWT.ARROW+SWT.DOWN,15,buttonPanel);
		}
		
		w.loadQueue();
		
		w.prop.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				if (!w.select()) return;
				open(btn);
				w.loadQueue();
			}			
		});

		if (w.insert!=null) 
		w.insert.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				w.prime();
				int biggest = 0;
				ListScanner scan = w.src.loop(false);
				while (scan.next()) {
					int thisValue = w.src.value().getInt();
					if (thisValue>biggest) {
						biggest=thisValue;
					}
				}
				
				SymbolValue ne = SymbolValue.construct(biggest+1);
				
				w.src.add(ne);
				w.src.fix(ne);
				
				for (Widget w : btn.getWidgets()) {
					w.prime(getEnvironment());
				}
				
				if (!open(btn)) {
					w.prime();
					w.src.fix(ne);
					w.src.delete();
					w.entry.alertListenersOfValueChange(ne.getString(), null);
				}
				w.loadQueue();
				w.table.select(w.table.getChildren().length-1); 
			}			
		});
		
		if (w.delete!=null) 
		w.delete.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				if (!w.select()) return;				
				int value = w.src.value().getInt();
				w.entry.alertListenersOfValueChange(w.entry.getFix(),null);				
				int biggest = -1;
				
				ListScanner scan = w.src.loop(false);
				while (scan.next()) {
					int thisValue = w.src.value().getInt();
					if (thisValue>value) {
						w.entry.alertListenersOfValueChange(String.valueOf(thisValue),String.valueOf(thisValue-1));
					}
					if (thisValue>biggest) {
						biggest=thisValue;
					}
				}
				
				if (w.src.fix(SymbolValue.construct(biggest))) {
					w.src.delete();
				}
				
				w.loadQueue();
			}			
		});		

		
		if (w.down!=null)
		w.down.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				w.swap(1);
			}			
		});		
		
		
		if (w.up!=null)
		w.up.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				w.swap(-1);
			}			
		});		
		
		position(structure, btn.getAt(), MAXWIDTH,500);
	}


	
	private void constructButton(final ButtonCmd scan,Composite parent) 
	{
		if (scan.isInline()) {
			constructMultiButton(scan, parent,scan.isMulti());
		} else {
			Button result = new Button(parent,SWT.PUSH);
			result.setText(scan.getLabel(getEnvironment()));
			position(result, scan.getAt(), PARTWIDTH,0);

			result.addSelectionListener(new SelectionAdapter() {
				@Override
				public void widgetSelected(SelectionEvent e) {
					if (scan.isMulti() || scan.isFrom()) {
						if (open(new MultiWidgetContainer(scan,scan.isMulti()))) {
							if (scan.getWhenAccepted()!=null) {
								getEnvironment().eval(scan.getWhenAccepted());
							}							
						}
					} else {
						open(scan);
					}
				}			
			});				
		}
	}

	private void constructEnable(final EnableCmd enable,Composite parent) {
		int from = parent.getChildren().length;		
		constructControls(enable, parent,false,null);
		int to = parent.getChildren().length;
		
		
		Control ctl[] = parent.getChildren();
		
		final Control[] enabledControls = new Control[to-from];
		System.arraycopy(ctl, from, enabledControls, 0, to-from);
		
		if (enable.getExpr()!=null) {
			addListener(new Runnable() { 
				@Override
				public void run() {
					boolean result = getEnvironment().eval(enable.getExpr()).boolValue();
					for (Control s : enabledControls) {
						setEnabled(s,result);
					}
				}
			});
		}		
	}

	private void constructPrompt(final PromptCmd scan,Composite parent) 
	{		
		String type = scan.getType();
		
		if (type.equals("SPIN")) {
			addPrompt(scan,parent);
			final Spinner s = new Spinner(parent,SWT.BORDER);
			
			List<Parameter> p = scan.getTypeParams();
			int val=0;
			SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).getValue();
			if (sv!=null) {
				val=sv.getInt();
			}			
			try {
				s.setValues(val,p.get(1).getInt(),p.get(2).getInt(),0,1,10);
			} catch (ParseException e1) {
				e1.printStackTrace();
				s.setSelection(val);
			}
			position(s,scan.getAt(),PARTWIDTH,0);
			s.addModifyListener(new ModifyListener() {
				@Override
				public void modifyText(ModifyEvent e) {
					getEnvironment().getScope().get(scan.getSymbol()).scalar().setValue(
							SymbolValue.construct(s.getSelection()));
					if (scan.getWhenAccepted()!=null) {
						getEnvironment().eval(scan.getWhenAccepted());
					}					
				}
				
			});
			return;
		}
		
		if (type.equals("CHECK")) {
			final Button result = new Button(parent,SWT.CHECK);			
			result.setText(scan.getLabel(getEnvironment()));
			SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).getValue();
			if (sv!=null) {
				result.setSelection(sv.getInt()>0);
			}			
			position(result,scan.getAt(),0,0);
			result.addSelectionListener(new SelectionAdapter() {
				@Override
				public void widgetSelected(SelectionEvent e) {
					getEnvironment().getScope().get(scan.getSymbol()).scalar().setValue(
							SymbolValue.construct(result.getSelection()));
					if (scan.getWhenAccepted()!=null) {
						getEnvironment().eval(scan.getWhenAccepted());
					}
					runListeners();

				}			
			});				
			return;
		}

		if (scan.isMulti()) {
			// TODO!
			return;
		}
		
		if (type.startsWith("@")) {
			final Formatter f = Formatter.construct(type);
			addPrompt(scan,parent);
			final Text t = new Text(parent,SWT.BORDER);
			SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).scalar().getValue();
			if (sv!=null) {
				t.setText(f.format(sv.getString()).trim());
			}
			position(t,null,PARTWIDTH,0);
			
			t.addModifyListener(new ModifyListener() {
				@Override
				public void modifyText(ModifyEvent e) {
					getEnvironment().getScope().get(scan.getSymbol()).scalar().setValue(
							SymbolValue.construct(f.deformat(t.getText()).trim()));
					if (scan.getWhenAccepted()!=null) {
						getEnvironment().eval(scan.getWhenAccepted());
					}
				}
			});
			return;
		}
		
		if (type.equals("EXPR") || type.equals("FIELD")  || type.equals("FILE") || type.equals("KEYCODE")) {
			addPrompt(scan,parent);
			final Text t = new Text(parent,SWT.BORDER);
			SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).scalar().getValue();
			if (sv!=null) {
				t.setText(sv.getString().trim());
			}
			position(t,null,PARTWIDTH,0);
			
			t.addModifyListener(new ModifyListener() {
				@Override
				public void modifyText(ModifyEvent e) {
					runListeners();
					getEnvironment().getScope().get(scan.getSymbol()).scalar().setValue(
							SymbolValue.construct(t.getText()));
					if (scan.getWhenAccepted()!=null) {
						getEnvironment().eval(scan.getWhenAccepted());
					}
				}
			});
			return;			
		}
		
		if (type.equals("COLOR")) {
			List<String> queue = new ArrayList<String>();
			for (String col : ColorHelper.getInstance().getNames()) {
				queue.add(col);
			}
			PARTSHIFT=-50;
			constructDropPrompt(scan,parent,queue,new DropAssistant() {
				@Override
				public String getDialogResult() {
					return null;
				}
				
				@Override
				public String convertToSymbol(String in) {
					return in;
				}
				
				private static final String ZEROS="000000";
				
				@Override
				public String convertFromSymbol(String in) {
					try {
						int value = Integer.parseInt(in);
						in = ColorHelper.getInstance().getName(value);
						if (in==null) {
							in=Integer.toString(value, 16);
							in=ZEROS.substring(0,6-in.length())+in;
						}
						return in;
					} catch (NumberFormatException ex) {
						return in;
					}
				}
			});
			PARTSHIFT=0;
			return;
			
		}

		if (type.equals("FROM")) {
			List<String> queue = new ArrayList<String>();
			ListSymbolValue list = getEnvironment().getScope().get(scan.getTypeString(0)).list().values();
			for (SymbolValue s : list) {
				queue.add(s.getString());
			}
			constructDropPrompt(scan,parent,queue);
			return;
		}
		
		if (type.equals("KEY")) {
			List<String> queue = new ArrayList<String>();
			if (source.getPrimaryFile()!=null) {
				File f= generator.getDict().getFile(source.getPrimaryFile().getName());
				if (f!=null) {
					for (Key k : f.getKeys()) {
						queue.add(f.getFile().getValue("PRE")+":"+k.getKey().getName());
					}
				}
			}
			constructDropPrompt(scan,parent,queue);
			return;			
		}
		
		if (type.equals("COMPONENT")) {
			List<String> queue = new ArrayList<String>();
			if (source.getPrimaryFile()!=null && source.getPrimaryFile().getKey()!=null && source.getPrimaryFile().getKey().length()>0) {
				File f= generator.getDict().getFile(source.getPrimaryFile().getName());
				if (f!=null) {
					Key k = f.getKey(source.getPrimaryFile().getKey());
					for (Lex  l : k.getKey().getTypeProperty().getParams()) {
						queue.add(l.value);
					}
				}
			}
			constructDropPrompt(scan,parent,queue);
			return;			
		}		

		if (type.equals("PROCEDURE")) {
			TreeSet<String> queue = new TreeSet<String>();
			for (Procedure p : generator.getApp().getProcedures()) {
				queue.add(p.getName());
			}
			constructDropPrompt(scan,parent,queue,null);
			return;			
		}		
		
		if (type.equals("DROP")) {
			List<String> queue = new ArrayList<String>();
			for (String s : scan.getTypeString(0).split("\\|")) {
				queue.add(s);
			}
			constructDropPrompt(scan,parent,queue);
			return;
		}

		if (type.equals("CONTROL")) {
			List<String> queue = new ArrayList<String>();
			ListSymbolValue list = getEnvironment().getScope().get("%control").list().values();
			for (SymbolValue s : list) {
				queue.add(s.getString());
			}
			constructDropPrompt(scan,parent,queue);
			return;
		}
		
		if (type.equals("EMBEDBUTTON")) {
			return;
		}
		
		throw new IllegalStateException("Do not know how to construct:"+scan);
	}

	private void constructDropPrompt(final PromptCmd scan, Composite parent,List<String> queue) {
		constructDropPrompt(scan,parent,new TreeSet<String>(queue),null);		
	}

	private void constructDropPrompt(final PromptCmd scan, Composite parent,List<String> queue,DropAssistant da) {
		constructDropPrompt(scan,parent,new TreeSet<String>(queue),da);
	}
	
	private static abstract class DropAssistant
	{
		public abstract String convertFromSymbol(String in);
		public abstract String convertToSymbol(String in);
		public abstract String getDialogResult();
	}
	
	private class DropHelper implements ModifyListener,KeyListener
	{
		private SortedSet<String> queue;
		private String 		filter="";
		private CCombo 		combo;
		private PromptCmd 	cmd;
		private String 		lastFilter=null;
		private boolean		changed;
		private DropAssistant assistant;
		
		public DropHelper(Composite parent,SortedSet<String> queue,PromptCmd cmd,DropAssistant assistant)
		{
			combo = new CCombo(parent,SWT.BORDER);
			this.assistant=assistant;
			this.queue=queue;
			this.cmd=cmd;
			combo.addModifyListener(this);
			combo.addKeyListener(this);
		}
		
		public boolean loadQueue()
		{
			if (filter.equals(lastFilter)) return false;
			lastFilter=filter;
			
			String value =combo.getText();
			int sel=-1;
			int scan=0;
			combo.removeAll();
			while ( true ) {
				scan=0;
				sel=-1;
				for (String item : queue) {
					if (item.equalsIgnoreCase(value)) {
						combo.add(item);
						sel=scan++;
						continue;
					}
					if (filter.length()==0 || item.toLowerCase().contains(filter)) {
						combo.add(item);					
						scan++;
						continue;
					}
				}
				if (sel>-1 && scan==1 && filter.length()>0) {
					combo.removeAll();
					filter=filter.substring(0,filter.length()-1);
					continue;
				}
				if (scan==0 && filter.length()>0) {
					filter=filter.substring(0,filter.length()-1);
					continue;
				}
				break;
			}
			if (sel>-1) {
				combo.select(sel);
			}
			return true;
		}

		@Override
		public void modifyText(ModifyEvent e) {
			String value = combo.getText();
			if (assistant!=null) {
				value = assistant.convertToSymbol(value);
			}
			getEnvironment().getScope().get(cmd.getSymbol()).scalar().setValue(SymbolValue.construct(value));
			if (cmd.getWhenAccepted()!=null) {
				getEnvironment().eval(cmd.getWhenAccepted());
			}
			runListeners();
		}

		@Override
		public void keyPressed(KeyEvent e) {	
			if (!combo.getListVisible() && (e.keyCode==SWT.ARROW_DOWN || e.keyCode==SWT.ARROW_UP)) {
				if (changed) {
					changed=false;
					filter=combo.getText();
					loadQueue();
				}
				combo.setListVisible(true);
			}
			
			if (e.character>=32 && e.character<=126) {			
				if (!combo.getListVisible()) {
					changed=true;
				} else {
					filter=filter+e.character;
					loadQueue();
				}
				return;
			}
			
			if (e.keyCode==SWT.BS && filter.length()>0 && combo.getListVisible()) {
				filter=filter.substring(0,filter.length()-1);
				loadQueue();
				return;
			}
		}
		
		@Override
		public void keyReleased(KeyEvent e) {
			if (e.keyCode==SWT.ESC && filter.length()>0) {
				filter="";
				loadQueue();
				return;
			}					
		}
		

	
	}
		
	private void constructDropPrompt(PromptCmd scan, Composite parent,SortedSet<String> queue,DropAssistant da) {
		addPrompt(scan,parent);
		
		final DropHelper helper = new DropHelper(parent,queue,scan,da);
		SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).getValue();
		if (sv!=null) {
			String value = getEnvironment().getScope().get(scan.getSymbol()).getValue().getString();
			if (da!=null) {
				value=da.convertFromSymbol(value);
			}
			helper.combo.setText(value);
		}
		helper.loadQueue();
		position(helper.combo,null,PARTWIDTH,0);	
		return;			
	}

	private void addPrompt(PromptCmd scan, Composite parent) 
	{
		Label l = new Label(parent,SWT.NONE);
		l.setText(scan.getLabel(getEnvironment()));
		position(l,scan.getAt(),PARTWIDTH+PARTSHIFT,0,true);
	}

	private void constructTab(TabCmd tab,Composite top) {
		if (tab.getWhere()!=null && !getEnvironment().eval(tab.getWhere()).boolValue()) {
			return;
		}
		
		TabItem item = new TabItem((TabFolder)top,SWT.NONE);
		item.setText(tab.getLabel(getEnvironment()));
		Canvas content = new Canvas(top,SWT.NONE);
		item.setControl(content);		
		constructControls(tab,content,true,null);
	}

	private void constructSheet(SheetCmd sheet,Composite parent) 
	{
		TabFolder control = new TabFolder(parent,SWT.TOP+SWT.BORDER);
		position(control,null,MAXWIDTH,MAXHEIGHT);
		pushClientArea(control);		
		constructControls(sheet,control,true,null);
		popClientArea();
		repack(control);
		control.setSize(400,500);
	}


	/**
	 * Create contents of the button bar.
	 * @param parent
	 */
	@Override
	protected void createButtonsForButtonBar(Composite parent) {
		createButton(parent, IDialogConstants.OK_ID, IDialogConstants.OK_LABEL,true);
		createButton(parent, IDialogConstants.CANCEL_ID,IDialogConstants.CANCEL_LABEL, false);
	}

	/**
	 * Return the initial size of the dialog.
	 */
	@Override
	protected Point getInitialSize() {
		return new Point(MAXWIDTH+20, 600);
	}

}
