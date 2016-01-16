package org.jclarion.clarion.print.text;

import java.awt.Rectangle;

import org.jclarion.clarion.print.PrintObject;
import org.jclarion.clarion.print.TextElement;

public class Column implements Comparable<Column>
{
	private int x1;
	private int x2;
	private String key;
	
	public Column(int x,int width)
	{
		if (width<0) {
			x2=x;
			x1=x+width;
		} else {
			x1=x;
			x2=x+width;
		}
	}
	
	public Column(int x1,int x2,String key)
	{
		this.x1=x1;
		this.x2=x2;
		this.key=key;
	}
	
	public Column(PrintObject po,TextElement te) {
		Rectangle r = te.getDimension();
		int x = po.getPositionedX()+r.x+po.getX();
		int width = r.width;
		if (width<0) {
			x2=x;
			x1=x+width;
		} else {
			x1=x;
			x2=x+width;
		}
		key = te.getText();
	}

	public int hashCode()
	{
		return x1*17+x2;		
	}
	
	public boolean equals(Object o) {
		Column co = (Column)o;
		if (co.x1!=x1) return false;
		if (co.x2!=x2) return false;
		return true;
	}

	public boolean overlaps(Column c)
	{
		int o_x1=c.x1>x1 ? c.x1 : x1;
		int o_x2=c.x2<x2 ? c.x2 : x2;

		if (o_x2<=o_x1) return false;
		
		int width=(o_x2-o_x1)*100;

		if (x1<x2 && width/(x2-x1)<=80) {
			if (c.x1<c.x2 && width/(c.x2-c.x1)<=80) return false;
		}
		
		return true;
	}

	public int getX1() {
		return x1;
	}

	public int getX2() {
		return x2;
	}

	@Override
	public int compareTo(Column o) {
		if (o.x1!=x1) return x1-o.x1;
		return x2-o.x2;
	}

	public Column increment()
	{
		return new Column(x1,x2-x1+1);
	}

	public String toString()
	{
		if (key!=null) {
			return "{"+x1+","+x2+","+key+"}";
		} else {
			return "{"+x1+","+x2+"}";			
		}
	}
}
