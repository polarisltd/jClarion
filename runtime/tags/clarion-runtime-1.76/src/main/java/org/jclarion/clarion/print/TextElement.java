package org.jclarion.clarion.print;

import java.awt.Rectangle;

import org.jclarion.clarion.runtime.format.Formatter;

public interface TextElement {
	public abstract String 		getText();
    public abstract Rectangle 	getDimension();
    public abstract String 		getUnformattedText();
    public abstract Formatter   getFormatter();
}
