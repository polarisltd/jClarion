package clarion;

import clarion.Positiongroup;
import clarion.Windowresizeclass;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Abresize
{

	public static void restoreControls(Windowresizeclass self)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(self.controlQueue.records())<=0;i.increment(1)) {
			self.controlQueue.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			Abresize.setSize(self.controlQueue.id.like(),self.controlQueue.pos);
		}
	}
	public static void getSizeInfo(ClarionNumber controlID,Positiongroup s)
	{
		CWin.getPosition(controlID.intValue(),s.xPos,s.yPos,s.width,s.height);
		if (!controlID.boolValue()) {
			s.width.setValue(Clarion.getControl(0).getProperty(Prop.CLIENTWIDTH));
			s.height.setValue(Clarion.getControl(0).getProperty(Prop.CLIENTHEIGHT));
		}
	}
	public static void setSize(ClarionNumber controlID,Positiongroup s)
	{
		Positiongroup c=new Positiongroup();
		Abresize.getSizeInfo(controlID.like(),c);
		if (!c.getString().equals(s.getString())) {
			if (Clarion.getControl(controlID).getProperty(Prop.NOWIDTH).boolValue()) {
				CWin.setPosition(controlID.intValue(),s.xPos.intValue(),s.yPos.intValue(),null,s.height.intValue());
			}
			else {
				CWin.setPosition(controlID.intValue(),s.xPos.intValue(),s.yPos.intValue(),s.width.intValue(),s.height.intValue());
			}
		}
	}
	public static void setPriorities(Windowresizeclass self,Positiongroup currentSize)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (!currentSize.width.equals(self.previousWin.width) && !currentSize.height.equals(self.previousWin.height)) {
			setPriorities_FullResize(i,self);
		}
		else if (currentSize.width.equals(self.previousWin.width)) {
			setPriorities_VerticalResize(i,self);
		}
		else {
			setPriorities_HorizontalResize(i,self);
		}
	}
	public static void setPriorities_HorizontalResize(ClarionNumber i,Windowresizeclass self)
	{
		for (i.setValue(1);i.compareTo(self.resizeList.records())<=0;i.increment(1)) {
			self.resizeList.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			self.resizeList.priority.setValue(self.resizeList.after.xPos);
			self.resizeList.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public static void setPriorities_FullResize(ClarionNumber i,Windowresizeclass self)
	{
		for (i.setValue(1);i.compareTo(self.resizeList.records())<=0;i.increment(1)) {
			self.resizeList.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			self.resizeList.priority.setValue(self.resizeList.after.xPos.power(2).add(self.resizeList.after.yPos.power(2)));
			self.resizeList.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public static void setPriorities_VerticalResize(ClarionNumber i,Windowresizeclass self)
	{
		for (i.setValue(1);i.compareTo(self.resizeList.records())<=0;i.increment(1)) {
			self.resizeList.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			self.resizeList.priority.setValue(self.resizeList.after.yPos);
			self.resizeList.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
}
