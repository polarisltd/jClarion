package org.jclarion.clarion.appgen.template.prompt;


import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.TextAppLoad;
import org.jclarion.clarion.appgen.app.TextAppStore;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.DictLoader;
import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.MultiSymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.TemplateLoader;
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
import org.jclarion.clarion.appgen.template.cmd.PromptCmd;
import org.jclarion.clarion.appgen.template.cmd.SheetCmd;
import org.jclarion.clarion.appgen.template.cmd.TabCmd;
import org.jclarion.clarion.appgen.template.cmd.Widget;
import org.jclarion.clarion.appgen.template.cmd.WidgetContainer;
import org.jclarion.clarion.appgen.template.cmd.WithCmd;
import org.jclarion.clarion.appgen.template.cmd.InsertWidget;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Std;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.CheckControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.SimpleComboQueue;


public class PromptEditor 
{
	public static void main(String args[]) throws IOException {
		TemplateChain chain = new TemplateChain();
		TemplateLoader loader = new TemplateLoader(chain);		
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","abchain.tpl");
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","LOCUSABC.tpl");
		chain.finalise();
		
		Dict d = (new DictLoader()).loadDictionary(("resources/src/main/clarion/common/c8odbc.txd"));		
		
		
		App a = (new TextAppLoad(chain)).load("target/app");
		ExecutionEnvironment g = new ExecutionEnvironment(chain,a,d);
		g.setLibSrc("resources/src/main/clarion/libsrc");
		g.setGenerationEnabled(false);
		g.init();
		g.generate(a,true);
		
		PromptEditor pe = new PromptEditor(g);
		//while ( true ) {
			AtSource src = a.getProcedure("GlobalViewAccount").getAddition(1);
			pe.edit(src);
			TextAppStore tas = new TextAppStore(chain);
			tas.setTarget("/dev/stdout");
			tas.serializePrompts(src.getPrompts(),false);
		//}
		
	}
	
	private ExecutionEnvironment generator;
	

	public PromptEditor(ExecutionEnvironment g)
	{
		generator=g;
	}

	public ExecutionEnvironment getEnvironment()
	{
		return generator;
	}
	
	private static final int WINWIDTH=200;
	private static final int WINHEIGHT=250;
	
	
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
	
	private int cursorX,cursorY,cursorNewLine,offsetX,offsetY;
	private Set<EventListener<? extends Widget>> listenerHarvest;
	
	private static int lastID=0;
	
	private abstract class EventListener<X extends Widget> implements Comparable<EventListener<X>>
	{
		
		private int 			id;
		private int 			priority;
		private X 				item;
		private AbstractControl control;
		private int 			event;
		private WithEntry		withStack;

		@Override
		public int compareTo(EventListener<X> o) 
		{
			if (priority<o.priority) return -1;
			if (priority>o.priority) return 1;
			return id-o.id;
		}
		
		public EventListener(int priority,X item)
		{
			this(priority,item,null,0);
		}
		
		public EventListener(int priority,X item,AbstractControl control,int event)
		{
			this.priority=priority;
			this.item=item;
			this.control=control;
			this.event=event;
			this.id=++lastID;
			this.withStack=PromptEditor.this.withStack;
		}

		public X getWidget()
		{
			return item;
		}
		
		public AbstractControl getControl()
		{
			return control;
		}
		
		public boolean canProcess()
		{
			if (control!=null && control.getUseID()!=CWin.field()) return false;
			if (event>0 && event!=CWin.event()) return false;
			return true;
		}
		
		public void prepare()
		{
			prepare(withStack);
		}

		private void prepare(WithEntry entry)
		{
			if (entry==null) return;
			prepare(entry.prior);
			entry.prepare();
		}
		
		public abstract void process();
	}
	
	public void addListener(EventListener<? extends Widget> l) 
	{
		listenerHarvest.add(l);
	}
	
	private AtSourceSession session;
	
	public boolean edit(AtSource src)
	{
		session = generator.getSession(src);		
		CodeSection cs = session.getCodeSection();		
		AdditionExecutionState state = session. prepareToExecute();
		session.prepare();
		state.finish();	

		boolean result=false;
		
		WidgetContainer target = cs;
		
		if (cs.getWidgets().size()==1 && cs.getWidgets().get(0) instanceof WidgetContainer) {
			target=(WidgetContainer)cs.getWidgets().get(0);
		}
		
		result=open(target);
		if (result) {
			UserSymbolScope ns=new UserSymbolScope(session.getScope(),new AppLoaderScope(),false);
			ns.constrainFields(cs.getDeclaredPrompts());
			src.setPrompts(ns);
		}
		
		
		TextAppStore tas = new TextAppStore(generator.getTemplateChain());
		tas.setTarget("out.txt");
		tas.serializePrompts(src.getPrompts(),false);
		
		return result;
	}

	private boolean open(WidgetContainer widgetContainer) {
		
		UserSymbolScope save = session.getScope().save();
		save = new UserSymbolScope(save,save.getParentScope());
		
		AdditionExecutionState state = session. prepareToExecute();
		
		ClarionWindow cw = new ClarionWindow();		
		cw.setFont("MS Sans Serif", 10,null,null,null).setText(widgetContainer.getLabel(generator));
		
		AbstractWindowTarget current = CWin.getInstance().getTarget();
		if (current!=null) {
			cw.setAt(current.getProperty(Prop.XPOS).intValue()+10,current.getProperty(Prop.YPOS).intValue()+10,WINWIDTH+60,WINHEIGHT);
		} else {
			cw.setAt(null,null,WINWIDTH+60,WINHEIGHT);
		}
		
		GroupControl cg = new GroupControl();
		cw.add(cg);
		
		ButtonControl ok = new ButtonControl();
		ok.setText("OK").setAt(WINWIDTH+5,5,50,15);
		ButtonControl cancel = new ButtonControl();
		cancel.setText("Cancel").setAt(WINWIDTH+5,22,50,15);
		cancel.setStandard(Std.CLOSE);
		cw.add(ok);
		cw.add(cancel);
		
		cursorX=0;
		cursorY=0;
		cursorNewLine=0;
		offsetX=0;
		offsetY=0;
		
		Set<EventListener<? extends Widget>> listeners=new TreeSet<EventListener<? extends Widget>>();
		listenerHarvest=listeners;
		constructControls(widgetContainer,cg);
		listenerHarvest=null;
		
		state.finish();	
		
		cw.open();
		
		
		boolean result=false;
		
		while (cw.accept()) {
			state = session. prepareToExecute();
			
			if (CWin.accepted()==ok.getUseID()) {
				result=true;
				cw.post(Event.CLOSEWINDOW);
			}
			for (EventListener<? extends Widget> scan : listeners) {
				if (!scan.canProcess()) continue;
				scan.prepare();
				scan.process();
			}
			cw.consumeAccept();
			
			
			state.finish();
		}
		
		cw.close();
		
		if (!result) {
			session.getScope().restore(save);
		}
		
		return result;
	}

	/*
	private void debugWindow(AbstractControl cg, int i) {
		for (int scan=0;scan<i;scan++) {
			System.out.print("  ");
		}
		System.out.println(cg);
		for (AbstractControl kid : cg.getChildren()) {
			debugWindow(kid,i+1);
		}
	}
	*/

	private void constructControls(WidgetContainer container,AbstractControl parent)
	{
		if (container instanceof MultiWidgetContainer) {
			constructMultiButton( ((MultiWidgetContainer)container).getButton() ,parent);
			return;
		}
		
		for (Widget scan : container.getWidgets()) {
			constructControl(scan,parent);
		}
	}
	
	private static class MultiWidgetContainer implements WidgetContainer
	{
		private ButtonCmd button;
		private List<ButtonCmd> buttons;
		
		public MultiWidgetContainer(ButtonCmd button)
		{
			this.button=button;
			buttons=new LinkedList<ButtonCmd>();
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
	
	private void constructControl(Widget scan,AbstractControl parent)
	{
			if (scan.getPrepare()!=null) {
				scan.getPrepare().run(getEnvironment());
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
				constructControls((InsertWidget)scan,parent);
				return;
			}
			if (scan instanceof FieldCmd) {
				return;
			}
			throw new IllegalStateException("Do not know how to construct:"+scan);
	}
	
	private void newline()
	{
		cursorX=0;
		cursorY=cursorNewLine;
	}
	
	private void constructBoxed(BoxedCmd box,AbstractControl parent) 
	{
		newline();

		int oldOffsetX=offsetX;
		int oldOffsetY=offsetY;
		
		if (box.getAt()!=null && box.getAt().getY()>=0) {
			cursorNewLine=box.getAt().getY();
			cursorY=cursorNewLine;
		}
		
		int startPos=cursorNewLine+offsetY;
		int endPos=cursorNewLine+offsetY;
		
		
				
		final GroupControl gc = new GroupControl();
		parent.addChild(gc);
		
		String text = box.getLabel(getEnvironment());
		if (text!=null) {
			gc.setText(text);
			gc.setBoxed();
			cursorNewLine+=10;
			cursorY+=10;
		}
		
		if (box.isSection()) {
			offsetX+=cursorX;
			offsetY+=cursorY;
			cursorX=0;
			cursorY=0;
			cursorNewLine=0;
		}
		
		for (Widget scan : box.getWidgets()) {
			constructControl(scan,gc);
			if (cursorNewLine+offsetY>endPos) {
				endPos=cursorNewLine+offsetY;
			}
		}
		
		offsetX=oldOffsetX;
		offsetY=oldOffsetY;
		
		if (text!=null) {
			gc.setAt(5,startPos,190,endPos-startPos+3);	
			endPos+=5;
			newline();
		}
		cursorNewLine=endPos-offsetY;
		cursorX=0;
		cursorY=cursorNewLine;
		
		
		if (box.isHide()) {
			gc.setHidden();
		}
		
		if (box.getWhere()!=null) {
			addListener(new EventListener<BoxedCmd>(1,box) {
				@Override
				public void process() {
					gc.setProperty(Prop.HIDE,!getEnvironment().eval(getWidget().getWhere()).boolValue());
				}
			});
		}
	}

	private void constructWith(WithCmd scan,AbstractControl parent) 
	{		
		WithEntry we = new WithEntry();
		we.se=getEnvironment().getScope().get(scan.getSymbol());
		we.value=SymbolValue.construct(getEnvironment().eval(scan.getValue()));
		we.prior=withStack;
		withStack=we;
		we.prepare();
		
		constructControls(scan, parent);
		
		withStack=withStack.prior;
	}

	private void constructDisplay(DisplayCmd scan,AbstractControl parent) 
	{
		String text = scan.getLabel(getEnvironment());
		
		if (text.length()<=50) {
			StringControl result = new StringControl();
			parent.addChild(result);
			result.setText(text);
			setAt(result,scan.getAt(),180,8);
			return;
		}
		
		while ( text.length()>0) {
			int pos = text.length();
			if (pos>50) pos=50;
			while (pos<text.length()) {
				if (text.charAt(pos)==' ') {
					pos++;
					break;
				} else {
					pos++;
				}
			}			
			StringControl sc = new StringControl();
			parent.addChild(sc);
			sc.setText(text.substring(0,pos).trim());
			setAt(sc,null,180,8);
			text=text.substring(pos);
		}
	}
	
	private class MultiWidgets
	{
		public ListControl list;
		public ButtonCmd button;
		public SimpleComboQueue queue;
		public ButtonControl insert;
		public ButtonControl prop;
		public ButtonControl delete;
		public ButtonControl up;
		public ButtonControl down;
		public MultiSymbolEntry entry;
		public ListSymbolValue src;
		
		
		public void loadQueue() {		
			queue.free();
			ListSymbolValue src = getEnvironment().getScope().get(button.getSymbol()).list().values();			
			ListScanner scan = src.loop(false);
			while (scan.next()) {
				queue.item.setValue(src.value().getString()+" : "+getEnvironment().eval(button.getExpression()).toString());
				queue.add();
			}
		}


		public ButtonControl createButton(String string,int len,AbstractControl parent) {
			ButtonControl bc = new ButtonControl();
			bc.setFont(null, 8, null, null, null);
			bc.setText(string);
			parent.addChild(bc);
			setAt(bc,null,len,12,1);
			return bc;
		}


		public void prime()
		{
			entry = getEnvironment().getScope().get(button.getSymbol()).list();
			src = entry.list().values();			
		}
		
		public boolean select() 
		{
			prime();
			int pos = list.getProperty(Prop.SELSTART).intValue();
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
			loadQueue();
			list.setProperty(Prop.SELSTART,list.getProperty(Prop.SELSTART).intValue()+i);
		}
	}

	private void constructMultiButton(ButtonCmd scan,AbstractControl parent) 
	{
		final MultiWidgets w = new MultiWidgets();
		
		w.list=new ListControl();
		w.queue=new SimpleComboQueue();
		w.list.setFrom(w.queue);
		w.button=scan;			
		parent.addChild(w.list);
		setAt(w.list,scan.getAt(),180,100);
		
		w.insert=w.createButton("&Insert",35,parent);
		w.prop=w.createButton("&Properties",50,parent);
		w.delete=w.createButton("&Delete",35,parent);
		w.up=w.createButton("",15,parent);
		w.up.setIcon("up.png");
		w.down=w.createButton("",15,parent);
		w.down.setIcon("down.png");
		
		addListener(new EventListener<ButtonCmd>(0,scan,w.prop,Event.ACCEPTED) {
			@Override
			public void process() {
				if (!w.select()) return;
				open(getWidget());
				w.loadQueue();
			}
		});

		addListener(new EventListener<ButtonCmd>(0,scan,w.insert,Event.ACCEPTED) {
			@Override
			public void process() {
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
				
				for (Widget w : getWidget().getWidgets()) {
					w.prime(getEnvironment());
				}
				
				if (!open(getWidget())) {
					w.prime();
					w.src.fix(ne);
					w.src.delete();
					w.entry.alertListenersOfValueChange(ne.getString(), null);
				}
				w.loadQueue();
				CWin.display();
				w.list.setProperty(Prop.SELSTART,w.queue.records()); 
			}
		});
		
		
		addListener(new EventListener<ButtonCmd>(0,scan,w.delete,Event.ACCEPTED) {
			@Override
			public void process() {
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

		addListener(new EventListener<ButtonCmd>(0,scan,w.down,Event.ACCEPTED) {
			@Override
			public void process() {
				w.swap(1);
			}
		});
		
		addListener(new EventListener<ButtonCmd>(0,scan,w.up,Event.ACCEPTED) {
			@Override
			public void process() {
				w.swap(-1);
			}
		});
		
		w.loadQueue();		
	}
	
	private void constructButton(ButtonCmd scan,AbstractControl parent) 
	{
		if (scan.isMulti() && scan.isInline()) { 
			 constructMultiButton(scan, parent);
		} else {
			ButtonControl result = new ButtonControl();
			parent.addChild(result);
			result.setText(scan.getLabel(getEnvironment()));
			setAt(result,scan.getAt(),80,12);
		
			addListener(new EventListener<ButtonCmd>(0,scan,result,Event.ACCEPTED) {
				@Override
				public void process() {
					if (getWidget().isMulti()) {
						if (open(new MultiWidgetContainer(getWidget()))) {
							if (getWidget().getWhenAccepted()!=null) {
								getEnvironment().eval(getWidget().getWhenAccepted());
							}							
						}
					} else {
						open(getWidget());
					}
				}
			});
		}
	}

	private void constructEnable(EnableCmd enable,AbstractControl parent) {
		final GroupControl gc = new GroupControl();
		parent.addChild(gc);
		constructControls(enable, gc);
		if (enable.getExpr()!=null) {
			addListener(new EventListener<EnableCmd>(1,enable) {
				@Override
				public void process() {
					boolean result = getEnvironment().eval(getWidget().getExpr()).boolValue();
					gc.setProperty(Prop.DISABLE,!result);
				}
			});
		}		
	}

	private void constructPrompt(PromptCmd scan,AbstractControl parent) 
	{		
		String type = scan.getType();
		if (type.equals("CHECK")) {
			CheckControl result = new CheckControl();
			parent.addChild(result);
			result.setText(scan.getLabel(getEnvironment()));
			result.setValue("1", "0");
			SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).getValue();
			if (sv!=null) {
				result.use(new ClarionNumber(sv.getInt()));
			}
			setAt(result,scan.getAt(),170,8);
			addListener(new EventListener<PromptCmd>(0,scan,result,Event.ACCEPTED) {
				@Override
				public void process() {
					getEnvironment().getScope().get(getWidget().getSymbol()).scalar().setValue(
							SymbolValue.construct(getControl().getUseObject()));
					if (getWidget().getWhenAccepted()!=null) {
						getEnvironment().eval(getWidget().getWhenAccepted());
					}
				}
			});			
			return;
		}

		if (scan.isMulti()) {
			// TODO!
			return;
		}
		
		if (type.startsWith("@")) {
			addPrompt(scan,parent);
			EntryControl result = new EntryControl();
			result.use(new ClarionString());
			SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).scalar().getValue();
			if (sv!=null) {
				result.getUseObject().setValue(sv.getString());
			}
			parent.addChild(result);
			result.setPicture(type);
			setAt(result,null,80,10);
			
			addListener(new EventListener<PromptCmd>(0,scan,result,Event.ACCEPTED) {
				@Override
				public void process() {
					getEnvironment().getScope().get(getWidget().getSymbol()).scalar().setValue(
							SymbolValue.construct(getControl().getUseObject()));
					if (getWidget().getWhenAccepted()!=null) {
						getEnvironment().eval(getWidget().getWhenAccepted());
					}
					
				}
			});
			
			return;
		}
		
		if (type.equals("EXPR") || type.equals("FIELD")  || type.equals("COMPONENT") || type.equals("FILE") || type.equals("KEY") || type.equals("PROCEDURE")) {
			addPrompt(scan,parent);
			EntryControl result = new EntryControl();
			result.use(new ClarionString());
			SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).scalar().getValue();
			if (sv!=null) {
				result.getUseObject().setValue(sv.getString());
			}
			parent.addChild(result);
			result.setPicture("@s255");
			setAt(result,null,80,10);
			
			addListener(new EventListener<PromptCmd>(0,scan,result,Event.ACCEPTED) {
				@Override
				public void process() {
					getEnvironment().getScope().get(getWidget().getSymbol()).scalar().setValue(
							SymbolValue.construct(getControl().getUseObject()));
					if (getWidget().getWhenAccepted()!=null) {
						getEnvironment().eval(getWidget().getWhenAccepted());
					}					
				}
			});
			
			return;
		}

		if (type.equals("FROM")) {
			SimpleComboQueue queue = new SimpleComboQueue();
			ListSymbolValue list = getEnvironment().getScope().get(scan.getTypeString(0)).list().values();
			for (SymbolValue s : list) {
				queue.item.setValue(s.getString());
				queue.add();
			}
			constructDropPrompt(scan,parent,queue);
			return;
		}
			
		if (type.equals("DROP")) {
			SimpleComboQueue queue = new SimpleComboQueue();
			for (String s : scan.getTypeString(0).split("\\|")) {
				queue.item.setValue(s);
				queue.add();
			}
			constructDropPrompt(scan,parent,queue);
			return;
		}

		if (type.equals("CONTROL")) {
			SimpleComboQueue queue = new SimpleComboQueue();
			ListSymbolValue list = getEnvironment().getScope().get("%control").list().values();
			for (SymbolValue s : list) {
				queue.item.setValue(s.getString());
				queue.add();
			}
			constructDropPrompt(scan,parent,queue);
			return;
		}
		
		
		throw new IllegalStateException("Do not know how to construct:"+scan);
	}

	private void constructDropPrompt(PromptCmd scan, AbstractControl parent,SimpleComboQueue queue) {
		addPrompt(scan,parent);
		
		final ListControl result = new ListControl();
		parent.addChild(result);
		result.setDrop(5);
		result.setFrom(queue);
		setAt(result,null,80,13);
		
		SymbolValue sv = getEnvironment().getScope().get(scan.getSymbol()).getValue();
		if (sv!=null) {
			String value = getEnvironment().getScope().get(scan.getSymbol()).getValue().getString();			
			ClarionObject field = result.getFrom().what(1); 
			field.setValue(value);
			result.getFrom().get(result.getFrom().ORDER().ascend(field));
			result.setProperty(Prop.SELSTART,result.getFrom().getPosition());
		}
		
		addListener(new EventListener<PromptCmd>(0,scan,result,Event.ACCEPTED) {
			@Override
			public void process() {
				ListControl lc = (ListControl)getControl();
				int pos = lc.getProperty(Prop.SELSTART).intValue();
				lc.getFrom().get(pos);
				getEnvironment().getScope().get(getWidget().getSymbol()).scalar().setValue(
						SymbolValue.construct(lc.getFrom().what(1)));
				if (getWidget().getWhenAccepted()!=null) {
					getEnvironment().eval(getWidget().getWhenAccepted());
				}
			}
		});
		
		return;			
	}

	private void addPrompt(PromptCmd scan, AbstractControl parent) 
	{
		PromptControl sc = new PromptControl();
		parent.addChild(sc);
		sc.setText(scan.getLabel(getEnvironment()));
		newline();
		setAt(sc,scan.getAt(),80,15);
	}

	/*
	private void debugSetAt(AbstractControl result, AtParam at,int preferredWidth,int preferredHeight) 
	{
		System.out.println("CURRENT:"+cursorX+" "+cursorY+" "+cursorNewLine);
		System.out.println(result);
		System.out.println(at);
		System.out.println(preferredWidth+" "+preferredHeight);
		setAt(result,at,preferredWidth,preferredHeight);
		System.out.println("NOW:"+cursorX+" "+cursorY+" "+cursorNewLine);
		System.out.println(result);
	}
	*/

	private void setAt(AbstractControl result, AtParam at,int preferredWidth,int preferredHeight)
	{
		setAt(result,at,preferredWidth,preferredHeight,5);
	}
	
	private void setAt(AbstractControl result, AtParam at,int preferredWidth,int preferredHeight,int gap) 
	{
		int x=cursorX==0 ? 10 : cursorX+gap;
		int y=cursorY;
		int width=preferredWidth;
		int height=preferredHeight;
		
		boolean xFixed=false,yFixed=false;
		
		if (at!=null) {
			if (at.getX()>=0) {
				xFixed=true;
				x=at.getX();
			}
			if (at.getY()>=0) {
				y=at.getY();
				yFixed=true;
			}
			
			if (at.getWidth()>=0) {
				width=at.getWidth();
			}
			if (at.getHeight()>=0) {
				height=at.getHeight();
			}
		}

		if (!xFixed && !yFixed && x+width>180) {
			y=cursorNewLine;
			x=10;
		}
		if (xFixed && !yFixed) {
			y=cursorNewLine;
		}
		
		result.setAt(x+offsetX,y+offsetY,width,height);
		
		cursorX=x+width;
		cursorY=y;
		cursorNewLine=y+height+2;
		
	}

	private void constructTab(TabCmd tab,AbstractControl top) {
		if (tab.getWhere()!=null && !getEnvironment().eval(tab.getWhere()).boolValue()) {
			return;
		}
		TabControl result = new TabControl();
		result.setAt(0, 0, 200,200);
		result.setText(tab.getLabel(getEnvironment()));
		top.addChild(result);
		
		cursorX=0;
		cursorY=0;
		cursorNewLine=0;
		offsetX=0;
		offsetY=25;
		
		constructControls(tab,result);
	}

	private void constructSheet(SheetCmd sheet,AbstractControl parent) 
	{
		SheetControl control = new SheetControl();
		control.setAt(0, 0, WINWIDTH,WINHEIGHT);
		parent.addChild(control);
		constructControls(sheet,control);
	}

	/*
	private void log(List<? extends Widget> widgets, int i) {
		for (Widget w : widgets) {
			for (int scan=0;scan<i;scan++) {
				System.out.print("  ");
			}
			System.out.println(w);
			if (w instanceof WidgetContainer) {
				log( ((WidgetContainer)w).getWidgets(),i+1);
			}
		}	
	}
	*/
}
