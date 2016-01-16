package org.jclarion.clarion.view;

import java.util.Iterator;

import org.jclarion.clarion.ClarionObject;

public class ViewFieldArray implements ViewField, Iterable<ViewField>
{
    private ClarionObject[] object;
    
    public ViewFieldArray(ClarionObject object[])
    {
        this.object=object;
    }

    @Override
    public ClarionObject getField() {
        return null;
    }

    @Override
    public Iterable<ViewField> getSubFields() {
        return this;
    }

    @Override
    public Iterator<ViewField> iterator() 
    {
        return new Iterator<ViewField>()
        {
            int count=0;
            
            @Override
            public boolean hasNext() {
                return count<object.length;
            }

            @Override
            public ViewField next() {
                return new SingleViewField(object[count++]);
            }

            @Override
            public void remove() {
            }
        };
    }
}
