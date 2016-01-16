package org.jclarion.clarion.ide.model.manager;

import java.awt.Font;
import java.awt.Point;
import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.swing.JComponent;
import javax.swing.SwingUtilities;

import jclarion.Activator;

import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.commands.operations.AbstractOperation;
import org.eclipse.core.commands.operations.IOperationHistory;
import org.eclipse.core.commands.operations.IOperationHistoryListener;
import org.eclipse.core.commands.operations.OperationHistoryEvent;
import org.eclipse.core.commands.operations.OperationHistoryFactory;
import org.eclipse.core.commands.operations.UndoContext;
import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.FontData;
import org.eclipse.swt.graphics.RGB;

import org.jclarion.clarion.ide.Compiler;
import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.AbstractReportControl;
import org.jclarion.clarion.control.ControlIterator;
import org.jclarion.clarion.control.PropertyChange;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.ide.model.JavaSwingProvider;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;


/**
 * Provides convenience getters and setters for managing {@link PropertyObject}
 * properties
 */
public class PropertyManager implements IOperationHistoryListener {

	private final PropertyObject po;
	private final JavaSwingProvider provider;
	private final UndoContext undoContext;

	/**
	 * Returns the supported values for {@link #setOrientation(String)}
	 */
	public static Collection<String> getOrientationNames() {
		return OrientationPropIdHelper.getInstance().getNames();
	}

	public static Collection<String> getUnitsNames() {
		return UnitsPropIdHelper.getInstance().getNames();
	}
	
	public static String getOrientationLeft() {
		return OrientationPropIdHelper.LEFT;
	}

	public static String getOrientationRight() {
		return OrientationPropIdHelper.RIGHT;
	}

	public static String getOrientationCenter() {
		return OrientationPropIdHelper.CENTER;
	}

	public static String getOrientationDecimal() {
		return OrientationPropIdHelper.DECIMAL;
	}

	/**
	 * Returns the supported values color value names
	 */
	public static Collection<String> getColorNames() {
		return ColorHelper.getInstance().getNames();
	}

	/**
	 * Returns the supported values for {@link #setStdName(String)}
	 */
	public static Collection<String> getStdNames() {
		return StdHelper.getInstance().getNames();
	}

	/**
	 * Returns the supported values for {@link #setKeyName(String)}
	 */
	public static Collection<String> getKeyNames() {
		return KeyHelper.getInstance().getNames();
	}

	public static void addMouseDraggedUndoHistory(List<PropertyManager> managers,
			int sx,int sy,
			int x, int y,
			int deltaX, int deltaY,
			int deltaWidth, int deltaHeight,
			boolean rehome,List<PropertyChange> otherChanges) {
		MouseDragOperation operation = new MouseDragOperation(
				managers, sx,sy,x, y, deltaX, deltaY, deltaWidth, deltaHeight, rehome,otherChanges);
		try {
			getOperationHistory().execute(operation,null,null);
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
	}

	public PropertyManager(PropertyObject po, JavaSwingProvider provider, UndoContext undoContext) {
		this.po = po;
		this.provider = provider;
		this.undoContext = undoContext;
		getOperationHistory().addOperationHistoryListener(this);
	}

	/**
	 * Notifies the {@link JavaSwingProvider} of undo and redo operations
	 */
	@Override
	public void historyNotification(OperationHistoryEvent event) {
		if ((event.getEventType() == OperationHistoryEvent.DONE) 
				|| (event.getEventType() == OperationHistoryEvent.UNDONE) 
				|| (event.getEventType() == OperationHistoryEvent.REDONE)) 
		{
			if (event.getOperation() instanceof PropertyObjectOperation) {
				final PropertyObjectOperation operation = (PropertyObjectOperation) event.getOperation();
				SwingUtilities.invokeLater(new Runnable() {
					@Override
					public void run() {
						for (PropertyObjectChange po : operation.getObjects()) {
							provider.notifyControlChanged(po.getObject(),po.getProperty());
						}
					}

				});
			} else {
				SwingUtilities.invokeLater(new Runnable() {
					@Override
					public void run() {
						provider.notifyControlChanged(po,0);
					}
				});
			}
		}
	}

	/**
	 * Returns one of the supported values in {@link #getOrientationNames()} if
	 * set, or <code>null</code>
	 */
	public String getOrientation() {
		for (String orientation : OrientationPropIdHelper.getInstance().getNames()) {
			Integer propId = OrientationPropIdHelper.getInstance().getValue(orientation);
			if (po.isProperty(propId)) {
				return orientation;
			}
		}
		return null;
	}

	public String getUnits() {
		for (String orientation : UnitsPropIdHelper.getInstance().getNames()) {
			Integer propId = UnitsPropIdHelper.getInstance().getValue(orientation);
			if (po.isProperty(propId)) {
				return orientation;
			}
		}
		return null;
	}
	
	/**
	 * Sets the orientation if <code>value</code> is one of
	 * {@link #getOrientationNames()}. Also, resets the offset values for all
	 * the offsets not associated with the new orientation value
	 */
	public void setOrientation(String value,String oldValue) {
		ManagerHelper h = OrientationPropIdHelper.getInstance();
		ManagerHelper oh = OrientationOffsetPropIdHelper.getInstance();
		
		GroupOperation go = new GroupOperation();
		
		Integer p =h.getValue(oldValue);
		if (p!=null) {
			addUndoableSetOperation(go,p,true,null);
			p=oh.getValue(oldValue);
			if (p!=null) {
				addUndoableSetOperation(go,p,po.getRawProperty(p),null);
			}			
		}
		p =h.getValue(value);
		if (p!=null) { 
			addUndoableSetOperation(go, p,null,true);
		}
		
		execute(go);
	}

	public void setUnits(String value,String oldValue) {
		ManagerHelper h = UnitsPropIdHelper.getInstance();
		
		GroupOperation go = new GroupOperation();
		
		Integer p =h.getValue(oldValue);
		if (p!=null) {
			addUndoableSetOperation(go,p,true,null);
		}
		p =h.getValue(value);
		if (p!=null) { 
			addUndoableSetOperation(go, p,null,true);
		}
		
		execute(go);
	}
	
	/**
	 * Gets the offset for the current value of {@link #getOrientation()},
	 * unless <code>null</code>
	 */
	public Integer getOrientationOffset() {
		String orientation = getOrientation();		
		Integer propId = OrientationOffsetPropIdHelper.getInstance().getValue(orientation);
		if (propId==null) return null;
		return getInteger(propId);
	}

	/**
	 * Sets the offset for the current value of {@link #getOrientation()},
	 * unless <code>null</code>
	 */
	public void setOrientationOffset(Integer oldValue,Integer value) {
		String orientation = getOrientation();	
		Integer propId = OrientationOffsetPropIdHelper.getInstance().getValue(orientation);
		if (propId==null) return;
		executeUndoableSetOperation(propId,oldValue,value);
	}

	/**
	 * Returns {@link Prop#FONTNAME}, {@link Prop#FONTSIZE} and
	 * {@link Prop#FONTSTYLE} as SWT {@link FontData} if all properties are
	 * non-null. Missing properties are inherited.
	 */
	public FontData getFont() {
		String name = getString(Prop.FONTNAME);
		Integer size = getInteger(Prop.FONTSIZE);
		Integer style = getInteger(Prop.FONTSTYLE);

		if ((name == null) && (size == null) && (style == null)) {
			return null;
		}
		return getInheritedFont();
	}

	public FontData getInheritedFont() {
		
		ClarionObject name=po.getInheritedProperty(Prop.FONTNAME);
		ClarionObject size=po.getInheritedProperty(Prop.FONTSIZE);
		ClarionObject style=po.getInheritedProperty(Prop.FONTSTYLE);
		
		return new FontData(
			name==null ? "Microsoft Sans Serif" : name.toString(),
			size==null ? 8 : size.intValue(),
			convertFontStyleClarionToSwt(style==null ? Font.PLAIN : style.intValue()));
	}

	
	public Integer getInheritedFontColor() {
		ClarionObject co = po.getInheritedProperty(Prop.FONTCOLOR);
		return co==null ? null : co.intValue();
	}

	/**
	 * Set the font name, size and style only if they differ from the inherited
	 * font settings
	 */
	public void setFont(FontData value,FontData old) {
		
		Object[] bits = decodeFont(value);
		Object[] oldBits = decodeFont(old);
		
		GroupOperation go = new GroupOperation();		
		addUndoableSetOperation(go,Prop.FONTNAME,oldBits[0], bits[0]);
		addUndoableSetOperation(go,Prop.FONTSIZE,oldBits[1], bits[1]);
		
		addUndoableSetOperation(go,Prop.FONTSTYLE,(Integer)oldBits[2],(Integer)bits[2]);
		execute(go);
	}

	private Object[] decodeFont(FontData value)
	{
		String name = null;
		Integer size = null;
		Integer style = null;
		FontData inheritedFont = getInheritedFont();
		if (value != null) {
			// Only set the name if it differs from the inherited font
			if (!value.getName().equals(inheritedFont.getName())) {
				name = value.getName();
			}

			// Only set the size if it differs from the inherited font
			if (value.getHeight() != inheritedFont.getHeight()) {
				size = value.getHeight();
			}

			// Only set the style if it differs from the inherited font
			if (value.getStyle() != inheritedFont.getStyle()) {
				style = convertFontStyleSwtToClarion(value.getStyle());
			}
		}
		
		return new Object[] { name,size,style };
		
	}

	public Integer nullConvertFontStyleSwtToClarion(Integer swtStyle) {
		if (swtStyle==null) return null;
		return convertFontStyleSwtToClarion(swtStyle);
	}


	public int convertFontStyleSwtToClarion(int swtStyle) {
	    return convert(swtStyle,
	    		new int[] { SWT.BOLD,   org.jclarion.clarion.constants.Font.BOLD },
	            new int[] { SWT.ITALIC, org.jclarion.clarion.constants.Font.ITALIC });
	}

	public int convertFontStyleClarionToSwt(int clarionStyle) {
	    return convert(clarionStyle,
	    		new int[] { org.jclarion.clarion.constants.Font.BOLD, SWT.BOLD },
	            new int[] { org.jclarion.clarion.constants.Font.ITALIC, SWT.ITALIC });
	}

	public int convertRgbToInteger(RGB rgb) {
		int value = rgb.blue;
		value = (value << 8) + rgb.green;
		value = (value << 8) + rgb.red;
		return value;
	}

	public String convertIntegerToColorHex(int value) {
		String hex = "#" + Integer.toHexString(value);
		while (hex.length() < 7) {
			hex += "0";
		}
		return hex.toUpperCase();
	}

	
	/**
	 * Returns {@link Prop#STD} as one of the supported values in
	 * {@link #getStdNames()} if set, or <code>null</code>
	 */
	public String getStdName() {
		return StdHelper.getInstance().getName(getInteger(Prop.STD));
	}
	
	
	public void setStdName(String name)
	{
		setProp(Prop.STD,getInteger(Prop.STD),StdHelper.getInstance().getValue(name));
	}

	public boolean isDirty() {
		return getOperationHistory().getUndoOperation(undoContext)!=null;
	}

	private static IOperationHistory getOperationHistory() {
		return OperationHistoryFactory.getOperationHistory();
	}

	public boolean getBoolean(int propId) {
		ClarionObject co = po.getRawProperty(propId, false);
		if (co == null) {
			return false;
		}
		return co.boolValue();
	}

	public Integer getInteger(int propId) {
		ClarionObject co = po.getRawProperty(propId, false);
		if (co == null) {
			return null;
		}
		return co.intValue();
	}

	public String getString(int propId) {
		ClarionObject co = po.getRawProperty(propId, false);
		if (co == null) {
			return null;
		}
		return co.toString();
	}

	/**
	 * Returns the value for the supplied property as an {@link RGB} if it does
	 * not correspond to one of the predefined color values, in which case
	 * <code>null</code> is returned
	 */
	public RGB getValueAsRGBIfNotColorName(int propId) {
		Integer color = getInteger(propId);
		if (color == null) {
			return null;
		}
		// Don't return an RGB if it's a predefined colour
		if (ColorHelper.getInstance().getValues().contains(color)) {
			return null;
		}
		return toRGB(color);
	}

	public void setValueAsRGB(int propId, Object oldValue,RGB value) {
		executeUndoableSetOperation(propId, oldValue,convertRgbToInteger(value));
	}

	public String getValueAsColorName(int propId) {
		return ColorHelper.getInstance().getName(getInteger(propId));
	}

	public void setValueAsColorName(int propId, Object oldValue,String value) {
		executeUndoableSetOperation(propId, oldValue,ColorHelper.getInstance().getValue(value));
	}

	private RGB toRGB(Integer color) {
		int red = (color ) & 0xFF;
		int green = (color >> 8) & 0xFF;
		int blue = (color>>16) & 0xFF;
		return new RGB(red, green, blue);
	}

	private int convert(int value, int[]... srcDsts) {
		
		
		
		int converted = 0;
		for (int[] srcDst : srcDsts) {
			int src = srcDst[0];
			int dst = srcDst[1];
			if ((value & src) == src) {
				converted |= dst;
			}
		}
		
		return converted;
	}

	public void setProp(int propId,Object oldValue,Object value)
	{
		executeUndoableSetOperation(propId,oldValue,value);
	}
	
	public String getUse()
	{
		return ExtendProperties.get(po).getFullUseVar();
		
	}

	public String getLabel()
	{
		return ExtendProperties.get(po).getLabel();
		
	}

	public String getPre()
	{
		return ExtendProperties.get(po).getPre();
		
	}
	
	public void setUse(String useVar)
	{
		useVar=Compiler.getUniqueUse(((AbstractControl)po).getOwner(),(AbstractControl)po,useVar);		
		try {
			getOperationHistory().execute(new SetUseVarOperation(useVar), null, null);
		} catch (ExecutionException e) {
			Activator.getDefault().logError("Failed to set property on " + po, e);
		}		
	}

	public void setLabel(String label)
	{
		try {
			getOperationHistory().execute(new SetLabelOperation(label), null, null);
		} catch (ExecutionException e) {
			Activator.getDefault().logError("Failed to set property on " + po, e);
		}		
	}

	public void setPre(String label)
	{
		try {
			getOperationHistory().execute(new SetPreOperation(label), null, null);
		} catch (ExecutionException e) {
			Activator.getDefault().logError("Failed to set property on " + po, e);
		}		
	}
	
	private void executeUndoableSetOperation(int propId,Object oldValue, Object value) {
		if (oldValue==null && value==null) return;
		if (oldValue!=null && value!=null) {
			if (Clarion.getClarionObject(oldValue).equals(Clarion.getClarionObject(value))) return;
		}

		try {
			getOperationHistory().execute(new SetPropertyOperation(propId, oldValue,value), null, null);
		} catch (ExecutionException e) {
			Activator.getDefault().logError("Failed to set property on " + po, e);
		}
	}

	private void addUndoableSetOperation(GroupOperation g,int propId,Object oldValue, Object value) {
		
		if (oldValue==null && value==null) return;
		if (oldValue!=null && value!=null) {
			if (Clarion.getClarionObject(oldValue).equals(Clarion.getClarionObject(value))) return;
		}
		
		g.add(new SetPropertyOperation(propId, oldValue,value));
	}
	
	private void execute(GroupOperation op) {
		if (op.operations.isEmpty()) return;
		try {
			getOperationHistory().execute(op, null, null);
		} catch (ExecutionException e) {
			Activator.getDefault().logError("Failed to set property on " + po, e);
		}
	}
	
	private static class PropertyObjectChange
	{
		private PropertyObject object;
		private int property;
		
		public PropertyObjectChange(PropertyObject po,int property)
		{
			this.object=po;
			this.property=property;
		}
		
		public PropertyObject getObject()
		{
			return object;
		}
		
		public int getProperty()
		{
			return property;
		}
	}
	
	private interface PropertyObjectOperation {
		Iterable<PropertyObjectChange> getObjects();
	}
	
	private class GroupOperation extends AbstractOperation implements PropertyObjectOperation,Iterable<PropertyObjectChange> {
		
		public GroupOperation() {
			super("Set Many Properties");
			addContext(undoContext);
		}

		private List<AbstractOperation> operations=  new ArrayList<AbstractOperation>();
		
		public void add(AbstractOperation operation)
		{
			operations.add(operation);
		}
		

		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			IStatus result=Status.OK_STATUS;
			for (AbstractOperation op : operations) {
				result=op.execute(monitor, info);
			}
			return result;
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			IStatus result=Status.OK_STATUS;
			for (AbstractOperation op : operations) {
				result=op.redo(monitor, info);
			}
			return result;
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			IStatus result=Status.OK_STATUS;
			for (AbstractOperation op : operations) {
				result=op.undo(monitor, info);
			}
			return result;
		}


		@Override
		public Iterable<PropertyObjectChange> getObjects() {
			return this;
		}


		@Override
		public Iterator<PropertyObjectChange> iterator() {
			return new Iterator<PropertyObjectChange>() {
				
				private Iterator<AbstractOperation> scan = operations.iterator();
				private Iterator<PropertyObjectChange> scan2;
				
				@Override
				public boolean hasNext() {
					if (scan2==null || !scan2.hasNext()) {
						if (!scan.hasNext()) return false;
						AbstractOperation test = scan.next();
						if (test instanceof PropertyObjectOperation) {
							scan2=((PropertyObjectOperation)test).getObjects().iterator();
						}
					}
					return true;
				}

				@Override
				public PropertyObjectChange next() {
					hasNext();
					return scan2.next();
				}

				@Override
				public void remove() {
				}
				
			};
		}
		
	}

	private class SetUseVarOperation extends AbstractOperation
	{
		private String[] oldVar;
		private String useVar;
		private boolean flip;

		public SetUseVarOperation(String useVar) 
		{
			super("Use Var");
			this.useVar=useVar;
			this.oldVar=ExtendProperties.get(po).getUsevars();
			
			boolean wasVar = oldVar.length>0 && !oldVar[0].startsWith("?");
			boolean isVar = useVar.length()>0 && !useVar.startsWith("?");
			
			flip = wasVar ^ isVar;
			
			
			addContext(undoContext);
		}

		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			ExtendProperties.get(po).decodeUseVar(useVar);
			handleFlip();
			return Status.OK_STATUS;
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return execute(monitor, info);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info)throws ExecutionException {
			ExtendProperties.get(po).setUsevar(oldVar);
			handleFlip();
			return Status.OK_STATUS;
		}

		private void handleFlip() {
			if (!flip) return;
			if (ExtendProperties.get(po).getFullUseVar().startsWith("?")) {
				((AbstractControl)po).use(null);
			} else {
				((AbstractControl)po).use(new ClarionString());
			}
			po.setClonedProperty(Prop.TEXT, po.getProperty(Prop.TEXT));
		}
		
	}

	private class SetLabelOperation extends AbstractOperation
	{
		private String oldLabel;
		private String label;

		public SetLabelOperation(String label) 
		{
			super("Label");
			this.label=label;
			this.oldLabel=ExtendProperties.get(po).getLabel();
			addContext(undoContext);
		}

		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			ExtendProperties.get(po).setLabel(label);
			return Status.OK_STATUS;
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return execute(monitor, info);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info)throws ExecutionException {
			ExtendProperties.get(po).setLabel(oldLabel);
			return Status.OK_STATUS;
		}
		
	}
	
	private class SetPreOperation extends AbstractOperation
	{
		private String oldPrefix;
		private String prefix;

		public SetPreOperation(String label) 
		{
			super("Prefix");
			this.prefix=label;
			this.oldPrefix=ExtendProperties.get(po).getPre();
			addContext(undoContext);
		}

		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			ExtendProperties.get(po).setPre(prefix);
			return Status.OK_STATUS;
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return execute(monitor, info);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info)throws ExecutionException {
			ExtendProperties.get(po).setPre(oldPrefix);
			return Status.OK_STATUS;
		}
		
	}	
	
	private class SetPropertyOperation extends AbstractOperation implements PropertyObjectOperation,Iterable<PropertyObjectChange> {

		private final int propId;
		private  Object newValue;
		private  ClarionObject oldValue;

		SetPropertyOperation(
				int propId,
				Object oldValue,
				Object newValue) {
			super("Set property");
			this.propId = propId;
			this.newValue = newValue;
			this.oldValue = Clarion.getClarionObject(oldValue);
			if (this.oldValue!=null) {
				this.oldValue=this.oldValue.genericLike();
			}
			addContext(undoContext);
		}

		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			po.setClonedProperty(propId, newValue);
			return Status.OK_STATUS;
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return execute(monitor, info);
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			po.setClonedProperty(propId, oldValue);
			return Status.OK_STATUS;
		}

		@Override
		public Iterable<PropertyObjectChange> getObjects() {
			return this;
		}

		@Override
		public Iterator<PropertyObjectChange> iterator() {
			return new Iterator<PropertyObjectChange>() {

				private boolean any=true;
				
				@Override
				public boolean hasNext() {
					return any;
				}

				@Override
				public PropertyObjectChange next() {
					any=false;
					return new PropertyObjectChange(po,propId);
				}

				@Override
				public void remove() {
				}
				
			};
		}


	}
	
	private static class MouseDragOperation extends AbstractOperation implements PropertyObjectOperation,Iterable<PropertyObjectChange> {

		private static class ControlInfo
		{
			private PropertyManager manager;
			private PropertyObject  oldParent;
			private int				oldParentOfs;
			private PropertyObject	newParent;
			private int				dx,dy;
			public ControlInfo(PropertyManager scan) {
				this.manager=scan;
			}
		}
		
		private final LinkedList<ControlInfo> managers;
		private final int deltaX;
		private final int deltaY;
		private final int deltaWidth;
		private final int deltaHeight;
		private final boolean rehome;
		private boolean refreshRequired;
		private List<PropertyChange> otherChanges;

		MouseDragOperation(
				List<PropertyManager> managers,
				int sx,int sy,int x, int y,
				int deltaX, int deltaY,
				int deltaWidth, int deltaHeight,
				boolean rehome,List<PropertyChange> otherChanges) {

			super("Mouse dragged");
			this.managers = new LinkedList<ControlInfo>();
			Set<PropertyObject> disregard=new HashSet<PropertyObject>();
			for (PropertyManager scan : managers ) {
				this.managers.add(new ControlInfo(scan));
				disregard.add(scan.po);
			}
			this.deltaX = deltaX;
			this.deltaY = deltaY;
			this.deltaWidth = deltaWidth;
			this.deltaHeight = deltaHeight;
			this.otherChanges=otherChanges;
			this.rehome = rehome && (deltaX!=0 || deltaY!=0);
			JavaSwingProvider provider=null;
			Set<PropertyObject> adjusted = new HashSet<PropertyObject>();
			for (ControlInfo scan : this.managers) {
				PropertyManager manager = scan.manager;
				addContext(manager.undoContext);
				if (this.rehome) {
					PropertyObject oldParent = manager.po.getParentPropertyObject();
					
					PropertyObject priorIdealParent = findParentAt(sx, sy, manager.po, manager.provider,disregard,false);
					PropertyObject newIdealParent = findParentAt(x, y, manager.po, manager.provider,disregard,false);

					if (priorIdealParent==newIdealParent) continue;

					PropertyObject newParent = findParentAt(x, y, manager.po, manager.provider,disregard,true);
					
					if (newParent!=null) {
						
						int dx=0;
						int dy=0;
						
						Point from = getEditorZone(oldParent);
						Point to = getEditorZone(newParent);
						dx=-(to.x-from.x);
						dy=-(to.y-from.y);
						if (dx!=0 || dy!=0) {
							AbstractTarget t = manager.provider.getAbstractWindowTarget();
							dx=t.widthPixelsToDialog(dx);
							dy=t.heightPixelsToDialog(dy);
							scan.dx=dx;
							scan.dy=dy;
						}
						
						scan.newParent=newParent;
						scan.oldParent=oldParent;
						scan.oldParentOfs=oldParent.getChildIndex(manager.po);
						if (dx!=0 || dy!=0) {
							adjust(manager.po,1,dx,dy,0,adjusted);
						}
						rehome(manager,scan.oldParent,scan.newParent,-1);
						provider=manager.provider;
					}
				}
			}
			
			applyOtherChanges(false);
			
			if (provider!=null) {
				provider.fireMouseSelectionChanged();
				if (refreshRequired) {
					provider.refresh();
					refreshRequired=false;
				}				
			}			
		}
		
		

		private Point getEditorZone(PropertyObject scan) {
			while (scan!=null) {
				ExtendProperties ep = ExtendProperties.get(scan);
				if (ep.container!=null) {
					if ((ep.container instanceof JComponent) && ((JComponent)ep.container).getClientProperty("EditorZone")!=null) {
						return ep.container.getLocation();
					}
				}
				scan=scan.getParentPropertyObject();
			}
			return new Point();
		}

		@Override
		public IStatus execute(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			return Status.OK_STATUS;
		}

		@Override
		public IStatus redo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			adjust(false);
			return Status.OK_STATUS;
		}

		@Override
		public IStatus undo(IProgressMonitor monitor, IAdaptable info) throws ExecutionException {
			adjust(true);
			return Status.OK_STATUS;
		}
		
		private void applyOtherChanges(boolean undo) {
			if (otherChanges==null) return;
			for (PropertyChange pc : otherChanges) {
				pc.getSource().setProperty(pc.getProperty(),undo ? pc.getOldValue() : pc.getNewValue());
			}
		}

		private void adjust(boolean undo) {
			int direction = undo ? -1 : 1;
			Set<PropertyObject> adjusted = new HashSet<PropertyObject>();

			Iterator<ControlInfo> iter= undo ? managers.descendingIterator() : managers.iterator();
			JavaSwingProvider provider=null;
			while (iter.hasNext()) {
				ControlInfo scan =iter.next();
				PropertyManager manager = scan.manager;
				adjust(manager.po, direction,scan.dx+deltaX,scan.dy+deltaY, direction, adjusted);

				if (rehome && scan.oldParent!=null) {
					if (undo) {
						rehome(manager,scan.newParent,scan.oldParent,scan.oldParentOfs);
					} else {
						rehome(manager,scan.oldParent,scan.newParent,-1);
					}
					provider=manager.provider;
				}
			}
			applyOtherChanges(undo);
			if (provider!=null) {
				provider.fireMouseSelectionChanged();
				if (refreshRequired) {
					provider.refresh();
					refreshRequired=false;
				}
			}
		}

		private void adjust(PropertyObject po, int xyDir,int dx,int dy,int sizeDir,Set<PropertyObject> adjusted) {
			if (adjusted.contains(po)) return;
			adjusted.add(po);
			if (!(po instanceof TabControl)) { 
				if (deltaX!=0) po.setProperty(Prop.XPOS, po.getProperty(Prop.XPOS).intValue() + ((dx)* xyDir));
				if (deltaY!=0) po.setProperty(Prop.YPOS, po.getProperty(Prop.YPOS).intValue() + ((dy) * xyDir));
				if (deltaWidth!=0 && sizeDir!=0) po.setProperty(Prop.WIDTH, po.getProperty(Prop.WIDTH).intValue() + (deltaWidth * sizeDir));
				if (deltaHeight!=0 && sizeDir!=0) po.setProperty(Prop.HEIGHT, po.getProperty(Prop.HEIGHT).intValue() + (deltaHeight * sizeDir));
			}
			if (!Compiler.dragKids(po)) return;
			for (PropertyObject kid : po.getChildren()) {
				adjust(kid,xyDir,dx,dy,0,adjusted);
			}
		}

		@Override
		public Iterable<PropertyObjectChange> getObjects() {
			return this;
		}

		private static final int[] PROPS = new int[] { Prop.XPOS, Prop.YPOS, Prop.WIDTH, Prop.HEIGHT };
		
		@Override
		public Iterator<PropertyObjectChange> iterator() {
			return new Iterator<PropertyManager.PropertyObjectChange>() {

				private Iterator<ControlInfo> scan = managers.iterator();
				private PropertyObject po;
				private int pofs;
				
				@Override
				public boolean hasNext() {
					if (po==null) 
						if (scan.hasNext()) {
							po=scan.next().manager.po;
							pofs=0;
						} else {
							return false;
					}
					return true;
				}

				@Override
				public PropertyObjectChange next() {
					hasNext();
					PropertyObjectChange result =  new PropertyObjectChange(po,PROPS[pofs++]);
					if (pofs==PROPS.length) {
						po=null;						
					}
					return result;
				}

				@Override
				public void remove() {
				}
			};
		}

		private void rehome(PropertyManager manager, PropertyObject from, PropertyObject to, int toOfs) {
			if (!(manager.po instanceof AbstractControl)) return;
			if (from==null || to==null) return;
			AbstractControl control = (AbstractControl) manager.po;
			setParent(control,from,to,manager.provider,toOfs);
		}

		/**
		 * Returns the first valid parent found for the control specified, or
		 * <code>null</code> if the Window is the parent
		 */
		private PropertyObject findParentAt(int x, int y, PropertyObject po, JavaSwingProvider provider,Set<PropertyObject> disregard,boolean strict) 
		{
			ControlIterator ci = new ControlIterator(provider.getAbstractWindowTarget());
			ci.setScanDisabled(true);
			ci.setScanHidden(true);
			PropertyObject match = null;
			while (ci.hasNext()) {
				AbstractControl test = ci.next();
				if (provider.invisibleTab(test)) {
					continue;
				}
				if (disregard.contains(test)) continue;
				if (!Compiler.isValidParent(po, test)) continue;
				Rectangle r = provider.getPropertyBounds(test);
				if (r!=null && r.contains(x,y)) {					
					match = test;
				}
			}
			if (match==null) match = provider.getAbstractWindowTarget();
			if (!strict) return match;
			
			PropertyObject scan=match;
			while (scan!=null) {
				if (scan==po) {
					return null;
				}
				scan=scan.getParentPropertyObject();
			}
			if (po.getParentPropertyObject()==match) {
				return null;
			}
			return match;
		}

		private void setParent(AbstractControl child, PropertyObject oldParent, PropertyObject newParent, JavaSwingProvider provider,int ofs) {
			if (oldParent instanceof AbstractTarget) {
				((AbstractTarget) oldParent).remove(child);
			} else if (oldParent instanceof AbstractControl) {
				((AbstractControl) oldParent).removeChild(child);
			}

			if (ofs<0) {
				ofs=provider.getIdealIndexForChild(newParent, child);				
			}
			
			if (newParent instanceof AbstractTarget) {
				if (ofs<0) {
					((AbstractTarget) newParent).add(child);
				} else {
					((AbstractTarget) newParent).add(child,ofs);
				}
				child.setParent(null);
			} else if (newParent instanceof AbstractControl) {
				if (ofs<0) {
					((AbstractControl) newParent).addChild(child);
				} else {
					((AbstractControl) newParent).addChild(child,ofs);
				}
				child.setParent((AbstractControl) newParent);
			}

			provider.fireStructureChanged(oldParent);
			provider.fireStructureChanged(newParent);
			if (newParent instanceof AbstractReportControl || oldParent instanceof AbstractReportControl) {
				refreshRequired=true;
			}
		}

	}

	public JavaSwingProvider getProvider() {
		return provider;
	}
	
	public int getInt(int prop) {
		ClarionObject co = po.getRawProperty(prop,false);
		if (co==null) return 0;
		return co.intValue();
	}
}
