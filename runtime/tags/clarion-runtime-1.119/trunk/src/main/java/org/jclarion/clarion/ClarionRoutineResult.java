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
package org.jclarion.clarion;

/**
 * For routine calls that call 'return' in clarion source - this is modelled as
 * an exception
 * 
 * @author barney
 *
 */
public class ClarionRoutineResult extends Throwable 
{
    /**
     * 
     */
    private static final long serialVersionUID = -6728431352634157801L;
    private Object object;
    
    public ClarionRoutineResult()
    {
    }
    
    public ClarionRoutineResult(Object object)
    {
        this.object=object;
    }
    
    public Object getResult()
    {
        return object;
    }
}
