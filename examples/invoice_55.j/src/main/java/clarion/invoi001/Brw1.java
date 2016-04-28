package clarion.invoi001;

import clarion.abbrowse.Browseclass;
import clarion.abbrowse.Browseeipmanager;
import clarion.abfile.Relationmanager;
import clarion.abquery.Queryclass_4;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Eipaction;
import clarion.equates.Proplist;
import clarion.invoi001.QueueBrowse_1;
import clarion.invoi001.Quickwindow;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Brw1 extends Browseclass
{
	public QueueBrowse_1 q=null;
	Browseeipmanager brw1Eipmanager;
	Quickwindow quickwindow;
	public Brw1(Browseeipmanager brw1Eipmanager,Quickwindow quickwindow)
	{
		this.brw1Eipmanager=brw1Eipmanager;
		this.quickwindow=quickwindow;
		q=null;
	}

	public void init(ClarionNumber listbox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listbox.like(),posit,v,q,rm,wm);
		this.eip=brw1Eipmanager;
		this.selectcontrol.setValue(quickwindow._select_2);
		this.hideselect.setValue(1);
		this.arrowaction.setValue(Eipaction.DEFAULT+Eipaction.REMAIN+Eipaction.RETAINCOLUMN);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertcontrol.setValue(quickwindow._insert_3);
			this.changecontrol.setValue(quickwindow._change_3);
			this.deletecontrol.setValue(quickwindow._delete_3);
		}
	}
	public void updatequery(Queryclass_4 p0) // %%%%% this method should be in child class e.g. Brw1
	{
		updatequery(p0,Clarion.newNumber(1));
	}
	public void updatequery(Queryclass_4 qc,ClarionNumber caseless) // %%%%% this method should be in child class e.g. Brw1
	{
		ClarionNumber i=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		ClarionString fn=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		CRun._assert(this.query==null);
		this.query=qc;
		while (Clarion.getControl(this.ilc.getcontrol()).getProperty(Proplist.EXISTS,i).boolValue()) {
			fn.setValue(this.listqueue.who(Clarion.getControl(this.ilc.getcontrol()).getProperty(Proplist.FIELDNO,i).getNumber()));
			if (caseless.boolValue()) {
				fn.setValue(ClarionString.staticConcat("UPPER(",fn,")"));
			}
			if (fn.boolValue()) {
				qc.additem(fn.like(),Clarion.getControl(this.ilc.getcontrol()).getProperty(Proplist.HEADER,i).getString(),Clarion.getControl(this.ilc.getcontrol()).getProperty(Proplist.PICTURE,i).getString());
			}
			i.increment(1);
		}
	}



}
