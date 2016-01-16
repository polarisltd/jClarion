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
package org.jclarion.clarion.print;

import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.control.StringControl;

public abstract class ReportStatistic 
{
    public static ReportStatistic SUM(ClarionObject target)
    {
        return new ReportStatistic(target) 
        {
            @Override
            public void add(ClarionObject obj) {
                target.increment(obj);
            }

            @Override
            public void reset() 
            {
                target.setValue(0);
            }

            @Override
            public ClarionObject get() 
            {
                return target;
            }

            @Override
            protected ClarionObject getDefaultTarget() 
            {
                return new ClarionDecimal();
            }
        };
    }

    public static ReportStatistic COUNT(ClarionObject target)
    {
        return new ReportStatistic(target) 
        {
            @Override
            public void add(ClarionObject obj) {
                target.increment(1);
            }

            @Override
            public void reset() 
            {
                target.setValue(0);
            }

            @Override
            public ClarionObject get() 
            {
                return target;
            }

            @Override
            protected ClarionObject getDefaultTarget() 
            {
                return new ClarionNumber(0);
            }
        };
    }

    public static ReportStatistic AVG(ClarionObject target)
    {
        return new ReportStatistic(target) 
        {
            private int count;
            private ClarionObject sum; 

            @Override
            public void add(ClarionObject obj) {
                count++;
                if (sum==null) sum=new ClarionDecimal();
                sum.increment(obj);
                if (target!=null) target.setValue(get());
            }

            @Override
            public void reset() 
            {
                count=0;
                sum=null;
                target.setValue(0);
            }

            @Override
            public ClarionObject get() 
            {
                if (count>0) return sum.divide(count);
                return new ClarionNumber(0);
            }

            @Override
            protected ClarionObject getDefaultTarget() 
            {
                return null;
            }
        };
    }

    public static ReportStatistic MIN(ClarionObject target)
    {
        return new ReportStatistic(target) 
        {
            private ClarionObject min; 

            @Override
            public void add(ClarionObject obj) {
                if (min==null || min.compareTo(obj)>0) {
                    min=obj.genericLike();
                } 
                if (target!=null) target.setValue(min);
            }

            @Override
            public void reset() 
            {
                min=null;
                target.clear();
            }

            @Override
            public ClarionObject get() 
            {
                if (min!=null) return min;
                return new ClarionNumber(0);
            }

            @Override
            protected ClarionObject getDefaultTarget() 
            {
                return null;
            }
        };
    }

    public static ReportStatistic MAX(ClarionObject target)
    {
        return new ReportStatistic(target) 
        {
            private ClarionObject max; 

            @Override
            public void add(ClarionObject obj) {
                if (max==null || max.compareTo(obj)<0) {
                    max=obj.genericLike();
                } 
                if (target!=null) target.setValue(max);
            }

            @Override
            public void reset() 
            {
                max=null;
                target.clear();
            }

            @Override
            public ClarionObject get() 
            {
                if (max!=null) return max;
                return new ClarionNumber(0);
            }

            @Override
            protected ClarionObject getDefaultTarget() 
            {
                return null;
            }
        };
    }
    
    
    protected ClarionObject target;
    private   StringControl control;
    
    public ReportStatistic(ClarionObject target)
    {
        if (target==null) target=getDefaultTarget();
        this.target=target;
    }

    public final void add()
    {
        add(control.getUseObject());
    }
    
    public abstract void add(ClarionObject obj);

    public abstract void reset();
    
    public abstract ClarionObject get();
    
    protected abstract ClarionObject getDefaultTarget();

    public void setControl(StringControl control) {
        this.control=control;
    }

    private boolean pagedItem;
    
    public void setPagedItem() 
    {
        pagedItem=true;
    }
    
    public boolean isPagedItem()
    {
        return pagedItem;
    }
}
