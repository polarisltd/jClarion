package clarion;

import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.RadioControl;

public class Window_2 extends ClarionWindow
{
	public int _okButton=0;
	public int _cancelButton=0;
	public int _button3=0;
	public int _lOCReportChoice=0;
	public int _lOCReportChoiceRadio1=0;
	public int _lOCReportChoiceRadio2=0;
	public int _lOCReportChoiceRadio3=0;
	public int _lOCReportChoiceRadio4=0;
	public Window_2(ClarionString lOCReportChoice)
	{
		this.setText("Select a Report for ").setAt(null,null,205,100).setImmediate().setIcon("CREDCARD.ICO").setHelp("~PickAReport").setSystem().setGray().setMDI();
		this.setId("pickareport.window");
		ButtonControl _C1=new ButtonControl();
		_C1.setIcon(Icon.PRINT).setDefault().setAt(174,15,16,16).setRight(null).setTip("Print this Report");
		this._okButton=this.register(_C1,"pickareport.window.okbutton");
		this.add(_C1);
		ButtonControl _C2=new ButtonControl();
		_C2.setIcon(Icon.NOPRINT).setAt(174,35,16,16).setRight(null).setTip("Cancel - Do Not Print").setStandard(Std.CLOSE);
		this._cancelButton=this.register(_C2,"pickareport.window.cancelbutton");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setIcon(Icon.HELP).setAt(174,66,16,16).setStandard(Std.HELP);
		this._button3=this.register(_C3,"pickareport.window.button3");
		this.add(_C3);
		OptionControl _C4=new OptionControl();
		_C4.setText("Pick a Report ").setAt(25,10,141,74).setBoxed().setFont("Arial",9,null,Font.BOLD,null);
		this._lOCReportChoice=this.register(_C4.use(lOCReportChoice),"pickareport.window.loc:reportchoice");
		this.add(_C4);
		RadioControl _C5=new RadioControl();
		_C5.setValue("Open").setText("Open Transactions for this Account").setAt(38,21,null,null);
		this._lOCReportChoiceRadio1=this.register(_C5,"pickareport.window.loc:reportchoice:radio1");
		_C4.add(_C5);
		RadioControl _C6=new RadioControl();
		_C6.setValue("History").setText("Transaction History on this Account").setAt(38,36,null,null).setFont("Arial",9,null,Font.BOLD,null);
		this._lOCReportChoiceRadio2=this.register(_C6,"pickareport.window.loc:reportchoice:radio2");
		_C4.add(_C6);
		RadioControl _C7=new RadioControl();
		_C7.setValue("Purchases").setText("Purchases Made on this Account").setAt(38,51,null,null).setFont("Arial",9,null,Font.BOLD,null);
		this._lOCReportChoiceRadio3=this.register(_C7,"pickareport.window.loc:reportchoice:radio3");
		_C4.add(_C7);
		RadioControl _C8=new RadioControl();
		_C8.setValue("Payments").setText("Payment History on this Account").setAt(38,66,null,null).setFont("Arial",9,null,Font.BOLD,null);
		this._lOCReportChoiceRadio4=this.register(_C8,"pickareport.window.loc:reportchoice:radio4");
		_C4.add(_C8);
	}
}
