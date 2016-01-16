package org.jclarion.clarion.view;

import org.jclarion.clarion.ClarionObject;

public interface ViewField 
{
    public abstract Iterable<ViewField> getSubFields();
    public ClarionObject getField();
}
