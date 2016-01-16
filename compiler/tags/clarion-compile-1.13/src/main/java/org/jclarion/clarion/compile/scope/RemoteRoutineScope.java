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
package org.jclarion.clarion.compile.scope;


public class RemoteRoutineScope extends RoutineScope
{
    //private ReturningScope       local;
    //private RoutineScope         remote;
    
    public RemoteRoutineScope(String name,ReturningScope local,RoutineScope remote) 
    {
        super(name,local);
    //    this.remote=remote;
    }
}
