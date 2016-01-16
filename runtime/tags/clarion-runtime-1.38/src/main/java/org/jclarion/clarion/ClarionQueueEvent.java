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

public class ClarionQueueEvent {
    public enum EventType { ADD, PUT, SORT, DELETE, FREE }; 
    
    public ClarionQueueReader     queue;
    public EventType        event;
    public int              record;
    
    public ClarionQueueEvent(ClarionQueueReader queue,EventType event,int record)
    {
        this.queue=queue;
        this.event=event;
        this.record=record;
    }
    
    public String toString()
    {
        return event+" "+record;
    }
}
