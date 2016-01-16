/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.runtime;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;

/** 
 * glue many memory objects together (serially) and treat them as a single object
 * 
 * @author barney
 */

public class ManyGlue extends ClarionMemoryModel
{
    private List<ClarionMemoryModel> elements;
    private ClarionMemoryChangeListener notifyChildChange;

    public static ManyGlue array(ClarionMemoryModel array[]) {
        ManyGlue result = new ManyGlue();
        for (int scan=0;scan<array.length;scan++) {
            if (array[scan]!=null) {
                result.add(array[scan]);
            }
        }
        return result;
    }
    
    public ManyGlue()
    {
        elements=new ArrayList<ClarionMemoryModel>();
        notifyChildChange=new ClarionMemoryChangeListener() {
            @Override
            public void objectChanged(ClarionMemoryModel model) {
                notifyChange();
            }
        };
    }
    
    public void add(ClarionMemoryModel model)
    {
        elements.add(model);
        model.addChangeListener(notifyChildChange);
    }
    

    @Override
    public void deserialize(InputStream os) throws IOException {
        for ( ClarionMemoryModel element : elements ) {
            element.deserialize(os);
        }
    }

    @Override
    public void serialize(OutputStream is) throws IOException {
        for ( ClarionMemoryModel element : elements ) {
            element.serialize(is);
        }
    }

    @Override
    public Object getLockedObject(Thread t) {
        return this;
    }

}
