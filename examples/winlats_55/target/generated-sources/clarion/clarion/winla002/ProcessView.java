package clarion.winla002;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class ProcessView extends ClarionView
{

	public ProcessView()
	{
		setTable(Main.bankas_k);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.adrese1}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.adrese2}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.gnet_flag}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.index}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.kods}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.kor_k}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.nos_a}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.nos_p}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.nos_s}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.spec}));
	}
}
