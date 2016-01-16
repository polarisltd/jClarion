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
package org.jclarion.clarion.control;

import java.util.Iterator;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.*;

public class ControlIterator implements Iterator<AbstractControl> 
{
    private AbstractControl start;
    private boolean scanHidden=false;
    private boolean scanDisabled=false;
    private boolean loop=true;
    private boolean scanSheets=false;
    
    public ControlIterator(AbstractControl start)
    {
        this(start,false);
    }
    
    private AbstractControl next;
    private AbstractControl cursor;
    private boolean include;
    
    public ControlIterator(AbstractControl start,boolean include)
    {
        this.start=null;
        cursor=start;
        this.include=include;
    }

    public ControlIterator(AbstractTarget win)
    {
        this.start=null;
        
        Iterator<AbstractControl> i=win.getControls().iterator();
        if (i.hasNext()) {
            cursor=i.next();
        } else {
            cursor=null;
        }
        this.include=true;
    }
    
    public void resetStart()
    {
        start=cursor;
    }
    
    @Override
    public boolean hasNext() {
        if (next!=null) return true;
        
        if (include) {
            include=false;
            if (cursor!=null) {
                if (isAllowed(cursor)) {
                    start=cursor;
                    next=cursor;
                    return true;
                }
            }
        }
        
        while ( cursor!=null ) {
            AbstractControl test=null;
            
            // try child first
            if (test==null) {
                
                Iterator<? extends AbstractControl> kids;
                kids = cursor.getChildren().iterator();
                while (kids.hasNext() && test==null) {
                    AbstractControl sibling = kids.next();
                    if (isAllowed(sibling)) {
                        test=sibling;
                    }
                }
            }
            
            // try sibling or ancestor sibling next
            while (test==null) {
                AbstractControl parent = cursor.getParent();
                Iterator<? extends AbstractControl> kids;
                if (parent==null) {
                    kids = cursor.getOwner().getControls().iterator();
                } else {
                    kids = parent.getChildren().iterator();
                }
                while (kids.hasNext()) {
                    if (kids.next()==cursor) break;
                }
                while (kids.hasNext() && test==null) {
                    AbstractControl sibling = kids.next();
                    if (isAllowed(sibling)) {
                        test=sibling;
                    }
                }
                if (next!=null) break;
                if (parent==null) break;
                cursor=parent;
            }

            // last ditch - try from the beginning
            if (test==null & loop) {
                Iterator<AbstractControl> kids;
                kids = cursor.getOwner().getControls().iterator();
                while (kids.hasNext() && test==null) {
                    AbstractControl sibling = kids.next();
                    if (isAllowed(sibling)) {
                        test=sibling;
                    }
                }
            }

            if (start==null) {
                start=test;
            } else {
                if (test==start) test=null;
            }
            
            if (test!=null) {
                cursor=test;
                next=test;
                return true;
            } else {
                cursor=null;
            }
        }
        return false;
        
    }

    public boolean isAllowed(AbstractControl control)
    {
        return isAllowed(control,true);
    }
    
    public boolean isAllowed(AbstractControl control,boolean tab)
    {
        while (control!=null) {
            boolean result =_isDoAllowed(control,tab);
            if (!result) return false;
            control=control.getParent();
        }
        return true;
    }

    public boolean isAllowedShallow(AbstractControl control)
    {
        return _isDoAllowed(control,true);
    }

    public boolean _isDoAllowed(AbstractControl control,boolean tabVisible)
    {
        if (control==null) return false;
        
        ClarionObject tests;
        
        if (scanDisabled==false) {
            tests=control.getRawProperty(Prop.DISABLE);
            if (tests!=null && tests.boolValue()) return false;
        }

        if (scanHidden==false) {
            tests=control.getRawProperty(Prop.HIDE);
            if (tests!=null && tests.boolValue()) return false;
        }
        
        if (scanSheets==false) {
            AbstractControl parent = control;
            if (tabVisible) parent=parent.getParent();
            if (parent!=null) {
                if (parent instanceof TabControl) {
                    AbstractControl sheet = parent.getParent();
                    tests = sheet.getRawProperty(Prop.SELSTART);
                    if (tests==null) return false;
                    int choice=tests.intValue();
                    if (choice<=0) return false;
                    if (sheet.getChild(choice-1)!=parent) return false;
                }
            }
        }
        
        return true;
    }

    @Override
    public AbstractControl next() {
        if (!hasNext()) return null;
        AbstractControl result=next;
        next=null;
        return result;
    }

    public AbstractControl peekNext() {
        if (!hasNext()) return null;
        return next;
    }
    
    @Override
    public void remove() {
        // TODO Auto-generated method stub
        
    }

    public void setStart(AbstractControl start) {
        this.start = start;
    }

    public void setScanHidden(boolean scanHidden) {
        this.scanHidden = scanHidden;
    }

    public void setScanDisabled(boolean scanVisible) {
        this.scanDisabled = scanVisible;
    }

    public void setLoop(boolean loop) {
        this.loop = loop;
    }

    public void setScanSheets(boolean scanSheets) {
        this.scanSheets = scanSheets;
    }

}
