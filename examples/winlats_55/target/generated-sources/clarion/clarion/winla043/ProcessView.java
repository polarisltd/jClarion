package clarion.winla043;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class ProcessView extends ClarionView
{

	public ProcessView()
	{
		setTable(Main.ggk);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.baits}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.bkk}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.datums}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.d_k}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.kk}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.par_nr}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.pvn_proc}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.pvn_tips}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.reference}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.rs}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.summa}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.summav}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.u_nr}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.ggk.val}));
	}
}
