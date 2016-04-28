package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class ProcessView_4 extends ClarionView
{

	public ProcessView_4()
	{
		setTable(Main.detail);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.backOrdered}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.custNumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.discount}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.lineNumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.orderNumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.price}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.quantityOrdered}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.taxPaid}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.totalCost}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.productNumber}));
		ViewJoin vj1=new ViewJoin();
		vj1.setKey(Main.products.keyProductNumber);
		vj1.setFields(new ClarionObject[] {Main.detail.productNumber});
		vj1.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.description}));
		vj1.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.price}));
		vj1.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.productSKU}));
		this.add(vj1);
	}
}
