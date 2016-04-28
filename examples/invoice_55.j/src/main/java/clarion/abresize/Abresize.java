package clarion.abresize;

import clarion.Positiongroup;
import clarion.abresize.Windowresizeclass;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Abresize
{

	public static void restorecontrols(Windowresizeclass self)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=self.controlqueue.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			self.controlqueue.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			Abresize.setsize(self.controlqueue.id.like(),self.controlqueue.pos);
		}
	}
	public static void getsizeinfo(ClarionNumber controlid,Positiongroup s)
	{
		CWin.getPosition(controlid.intValue(),s.xpos,s.ypos,s.width,s.height);
		if (!controlid.boolValue()) {
			s.width.setValue(Clarion.getControl(0).getProperty(Prop.CLIENTWIDTH));
			s.height.setValue(Clarion.getControl(0).getProperty(Prop.CLIENTHEIGHT));
		}
	}
	public static void setsize(ClarionNumber controlid,Positiongroup s)
	{
		Positiongroup c=new Positiongroup();
		Abresize.getsizeinfo(controlid.like(),c);
		if (!c.getString().equals(s.getString())) {
			if (Clarion.getControl(controlid).getProperty(Prop.NOWIDTH).boolValue()) {
				CWin.setPosition(controlid.intValue(),s.xpos.intValue(),s.ypos.intValue(),null,s.height.intValue());
			}
			else {
				CWin.setPosition(controlid.intValue(),s.xpos.intValue(),s.ypos.intValue(),s.width.intValue(),s.height.intValue());
			}
		}
	}
	public static void setpriorities(Windowresizeclass self,Positiongroup currentsize)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (!currentsize.width.equals(self.previouswin.width) && !currentsize.height.equals(self.previouswin.height)) {
			setpriorities_fullresize(i,self);
		}
		else if (currentsize.width.equals(self.previouswin.width)) {
			setpriorities_verticalresize(i,self);
		}
		else {
			setpriorities_horizontalresize(i,self);
		}
	}
	public static void setpriorities_horizontalresize(ClarionNumber i,Windowresizeclass self)
	{
		final int loop_1=self.resizelist.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			self.resizelist.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			self.resizelist.priority.setValue(self.resizelist.after.xpos);
			self.resizelist.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public static void setpriorities_fullresize(ClarionNumber i,Windowresizeclass self)
	{
		final int loop_1=self.resizelist.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			self.resizelist.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			self.resizelist.priority.setValue(self.resizelist.after.xpos.power(2).add(self.resizelist.after.ypos.power(2)));
			self.resizelist.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
	public static void setpriorities_verticalresize(ClarionNumber i,Windowresizeclass self)
	{
		final int loop_1=self.resizelist.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			self.resizelist.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			self.resizelist.priority.setValue(self.resizelist.after.ypos);
			self.resizelist.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
	}
}
