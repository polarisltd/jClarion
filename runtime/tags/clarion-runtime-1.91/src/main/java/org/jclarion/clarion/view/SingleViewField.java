package org.jclarion.clarion.view;

import org.jclarion.clarion.ClarionObject;

public class SingleViewField implements ViewField
{
    private ClarionObject object;
    
    public SingleViewField(ClarionObject object)
    {
        this.object=object;
    }

    @Override
    public ClarionObject getField() {
        return object;
    }

    @Override
    public Iterable<ViewField> getSubFields() {
        return null;
    }
}
