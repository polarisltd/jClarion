package org.jclarion.clarion.ide.view;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Frame;
import java.awt.LayoutManager;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.io.IOException;
import java.util.List;

import javax.swing.SwingUtilities;

import jclarion.Activator;

import org.eclipse.core.commands.operations.UndoContext;
import org.eclipse.core.runtime.Assert;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.SelectionChangedEvent;
import org.eclipse.jface.viewers.Viewer;
import org.eclipse.swt.SWT;
import org.eclipse.swt.awt.SWT_AWT;
import org.eclipse.swt.custom.ScrolledComposite;
import org.eclipse.swt.dnd.DND;
import org.eclipse.swt.dnd.DragSource;
import org.eclipse.swt.dnd.DragSourceEvent;
import org.eclipse.swt.dnd.DragSourceListener;
import org.eclipse.swt.dnd.TextTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.events.TraverseEvent;
import org.eclipse.swt.events.TraverseListener;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.ide.Compiler;
import org.jclarion.clarion.ide.Serializer;
import org.jclarion.clarion.ide.model.ClarionToJavaInput;
import org.jclarion.clarion.ide.model.ClarionToJavaListener;
import org.jclarion.clarion.ide.model.JavaSwingContributor;
import org.jclarion.clarion.ide.model.JavaSwingProvider;
import org.jclarion.clarion.ide.model.WindowDefinitionProvider;


public class ClarionToJavaViewer extends Viewer {

	private final ScrolledComposite scrolledContainer;
	private final Composite container;
	private final JavaSwingProvider javaSwingProvider;
	private final WindowDefinitionProvider windowDefinitionProvider;

	private Object 						  		input;
	private ISelection 					  		selection;
	private AbstractTarget 						awt;

	public ClarionToJavaViewer(Composite parent, WindowDefinitionProvider provider,UndoContext context,JavaSwingContributor contributer) {
		super();
		this.javaSwingProvider = new JavaSwingProvider(context,contributer);
		this.windowDefinitionProvider = provider;

		Compiler compiler = new Compiler();
		this.awt = compiler.compile(provider.getWindow());

		Canvas frame = new Canvas(parent,SWT.NONE);
		frame.setLayout(new GridLayout(1,true));

		Canvas buttons =new Canvas(frame,SWT.BORDER);
		buttons.setLayout(new RowLayout());
		buttons.setLayoutData(new GridData(SWT.FILL,SWT.TOP,true,false));
		buttons.setBackground(parent.getBackground());

		if (awt instanceof AbstractWindowTarget) {
			addButton(buttons,"Str:"," STRING('String'),AT(,,30,10)");
			addButton(buttons,"Pro:"," Prompt('Prompt'),AT(,,30,10)");
			addButton(buttons,"Btn"," BUTTON('Button'),AT(,,50,20)");
			addButton(buttons,"Entry"," Entry(@s20),AT(,,30,15)");
			addButton(buttons,"Text"," TEXT,AT(,,30,15)");
			addButton(buttons,"Check"," CHECK('Check'),AT(,,30,15)");
			addButton(buttons,"List"," LIST,AT(,,30,30)");
			addButton(buttons,"Image"," IMAGE('resource://resources/images/clarion/hand.png'),AT(,,30,30)");
			addButton(buttons,"Combo"," COMBO,AT(,,30,30)");
			addButton(buttons,"Grp"," GROUP('Group'),AT(,,30,30),BOXED\n.");
			addButton(buttons,"Box"," BOX,AT(,,30,30)");
			addButton(buttons,"Line"," LINE,AT(,,30,0)");
			addButton(buttons,"Panel"," PANEL,AT(,,30,0)");
			addButton(buttons,"Sheet"," SHEET,AT(,,30,30)\n.");
			addButton(buttons,"Tab"," TAB('New Tab')\n.");
			addButton(buttons,"OPTION"," OPTION('Options'),AT(,,30,30),BOXED\n.");
			addButton(buttons,"RADIO"," RADIO('Radio'),AT(,,30,),BOXED");
			addButton(buttons,"PROGRESS"," PROGRESS,AT(,,30,)");
			addButton(buttons,"SPIN"," SPIN(@n5),AT(,,30,)");
		} else {
			addButton(buttons,"Str:","* STRING('String'),AT(,,30,10)");			
			addButton(buttons,"Text","* TEXT,AT(,,30,15)");
			addButton(buttons,"Image","* IMAGE('resource://resources/images/clarion/hand.png'),AT(,,30,30)");
			addButton(buttons,"Box","* BOX,AT(,,30,30)");
			addButton(buttons,"Line","* LINE,AT(,,30,0)");
			addButton(buttons,"Grp","* GROUP('Group'),AT(,,30,30),BOXED\n.");
			addButton(buttons,"Detail","*  DETAIL,AT(,,,100)");
			addButton(buttons,"Header","*  HEADER,AT(,,,100)");
			addButton(buttons,"Footer","*  FOOTER,AT(,,,100)");
			addButton(buttons,"Form","*  FORM,AT(,,,100)");
			addButton(buttons,"Break","  BREAK");
		}

		this.scrolledContainer = new ScrolledComposite(frame, SWT.H_SCROLL | SWT.V_SCROLL);
		this.scrolledContainer.setBackground(parent.getBackground());
		this.scrolledContainer.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,true));

		Composite container = new Composite(this.scrolledContainer, SWT.NONE);
		container.setBackground(this.scrolledContainer.getBackground());
		container.setLayout(new GridLayout());

		this.scrolledContainer.setContent(container);
		this.container = container;
	}

	
	public PropertyObject getSelectedControl()
	{
		return javaSwingProvider.getFirstSelection();
	}

	public List<PropertyObject> getSelectedControls()
	{
		return javaSwingProvider.getSelections();
	}
	
	private void addButton(Canvas buttons, String msg,final String button)
	{
		Label b = new Label(buttons,SWT.BORDER);
		b.setText(msg);
		DragSource src = new DragSource(b,DND.DROP_MOVE | DND.DROP_COPY | DND.DROP_LINK);
		src.setTransfer(new Transfer[] {TextTransfer.getInstance()});
		src.addDragListener(new DragSourceListener() {
			@Override
			public void dragStart(DragSourceEvent event) {
				event.doit=true;
			}

			@Override
			public void dragSetData(DragSourceEvent event) {
				event.data=button;
			}

			@Override
			public void dragFinished(DragSourceEvent event) {
			}

		});
	}

	public AbstractTarget getTarget() {
		return javaSwingProvider.getAbstractWindowTarget();
	}

	public JavaSwingProvider getProvider() {
		return javaSwingProvider;
	}

	@Override
	public Control getControl() {
		return scrolledContainer;
	}

	/**
	 * Returns the {@link ClarionToJavaInput} that is the input of this view, or
	 * null if not currently displaying anything
	 */
	@Override
	public Object getInput() {
		return input;
	}

	@Override
	public void setInput(Object input) {
		Assert.isTrue(input instanceof ClarionToJavaInput);
		this.input = (ClarionToJavaInput) input;
		if (this.input != null) {
			refresh();
		} else {
			clear();
		}
	}

	private Frame frame;
	private Composite wrap;

	@Override
	public void refresh() {
		clear();

		if (awt == null) {
			return;
		}

		if (frame==null) {
			wrap = new Composite(container, SWT.EMBEDDED+SWT.BORDER);
			wrap.setBackground(container.getBackground());
			
			wrap.addTraverseListener(new TraverseListener() {
				@Override
				public void keyTraversed(TraverseEvent e) {
					e.doit=false;
				}
			});
			frame = SWT_AWT.new_Frame(wrap);
			/**
			 * Add a fake layout manager on the frame so that changes to frame size do not
			 * propagate down to the container.  So container is sets size of SWT but not the
			 * other way round.
			 */
			frame.setLayout(new LayoutManager() {
				@Override
				public void addLayoutComponent(String name, Component comp) {
				}

				@Override
				public void removeLayoutComponent(Component comp) {
				}

				@Override
				public Dimension preferredLayoutSize(Container parent) {
					if (parent.getComponentCount()==0) {
						return new Dimension(0,0);
					}
					return parent.getComponent(0).getSize();
				}

				@Override
				public Dimension minimumLayoutSize(Container parent) {
					return preferredLayoutSize(parent);
				}

				@Override
				public void layoutContainer(Container parent) {
				}

			});

			SwingUtilities.invokeLater(new Runnable() {
				@Override
				public void run() {
					if (javaSwingProvider.getAbstractWindowTarget() == null) {
						Container c=javaSwingProvider.setAbstractWindowTarget(awt);
						frame.add(c);
						c.addComponentListener(new ComponentAdapter() {
							@Override
							public void componentResized(ComponentEvent e) {
								resizeItem(e.getComponent().getPreferredSize());
							}

						});
						final Dimension size = c.getSize();
						SwingUtilities.invokeLater(new Runnable() {
							@Override
							public void run() {
								try {
									Thread.sleep(100);
								} catch (InterruptedException ex) {
								}
								Activator.getDefault().runOnUiThread(new Runnable() {
									@Override
									public void run() {
										resizeItem(size);
									}
								});
							}
						});
					}
				}});
		}
	}

	private void resizeItem(final Dimension d)
	{
		if (Display.getDefault().getThread()!=Thread.currentThread()) {
			Activator.getDefault().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					resizeItem(d);
				}
			});
			return;
		}
		wrap.setLayoutData(new GridData(d.width,d.height));
		adjustSize();
	}

	@Override
	public ISelection getSelection() {
		return selection;
	}

	@Override
	public void setSelection(ISelection selection, boolean reveal) {
		this.selection = selection;
		fireSelectionChanged(new SelectionChangedEvent(this, selection));
	}

	public String getName() {
		return windowDefinitionProvider.getName();
	}

	public void addListener(ClarionToJavaListener listener) {
		javaSwingProvider.addListener(listener);
	}

	public void resetHighlight() {
		javaSwingProvider.resetHighlight();
	}

	public void highlight(List<PropertyObject> controls) {
		javaSwingProvider.highlight(controls);
	}

	public void dispose() {
		javaSwingProvider.reset();
		scrolledContainer.dispose();
	}

	public void save() {
		if (javaSwingProvider.getAbstractWindowTarget() == null) {
			Activator.getDefault().logWarning("No abstract window target to update exists. Has this been compiled?");
			return;
		}

		try {
			StringBuffer buffer = new StringBuffer();
			new Serializer().serialize(javaSwingProvider.getAbstractWindowTarget(), buffer);
			windowDefinitionProvider.setWindow(buffer.toString());
		} catch (IOException e) {
			Activator.getDefault().logError("Failed to serialise: " + this, e);
		}
		
		windowDefinitionProvider.restoreFocus();
	}
	
	public String serialize()
	{
		StringBuffer buffer = new StringBuffer();
		try {
			new Serializer().serialize(javaSwingProvider.getAbstractWindowTarget(), buffer);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return buffer.toString();
	}

	private void clear() {
		for (Control child : container.getChildren()) {
			child.dispose();
		}
		adjustSize();
	}

	/**
	 * Sets the computed size to show/hide scroll bars as required
	 */
	private void adjustSize() {
		container.setSize(container.computeSize(SWT.DEFAULT, SWT.DEFAULT));
		container.layout(true, true);
	}
}
