package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class AtParam {
	private int height=-1;
	private int width=-1;
	private int y=-1;
	private int x=-1;

	public AtParam(List<Parameter> src) throws ParseException
	{
		if (src.size()>0 && !src.get(0).isEmpty()) {
			x = src.get(0).getInt();
		}
		if (src.size()>1 && !src.get(1).isEmpty()) {
			y = src.get(1).getInt();
		}
		if (src.size()>2 && !src.get(2).isEmpty()) {
			width = src.get(2).getInt();
		}
		if (src.size()>3 && !src.get(3).isEmpty()) {
			height = src.get(3).getInt();
		}
	}

	public int getHeight() {
		return height;
	}

	public int getWidth() {
		return width;
	}

	public int getY() {
		return y;
	}

	public int getX() {
		return x;
	}

	@Override
	public String toString() {
		return "["+x+","+y+","+width+","+height+"]";
	}
	
	
	
}
