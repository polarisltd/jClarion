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

import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.swing.gui.RemoteTypes;

public class KeyedClarionEvent extends ClarionEvent 
{

    private int keyCode;
    private int keyChar;
    private int keyState;
    
    public KeyedClarionEvent()
    {
    }

    public KeyedClarionEvent(int event,AbstractControl field, boolean window,
            int keyCode,int keyChar,int keyState) 
    {
        super(event, field, window);
        this.keyCode=keyCode;
        this.keyChar=keyChar;
        this.keyState=keyState;
    }
    
    

    @Override
	public Object[] getMetaData() {
		return new Object[] { super.getMetaData() , keyCode, keyChar, keyState };
	}

	@Override
	public void setMetaData(Object[] o) {
		super.setMetaData((Object[])o[0]);
		keyCode=(Integer)o[1];
		keyChar=(Integer)o[2];
		keyState=(Integer)o[3];
	}

	@Override
	public int getType() {
		return RemoteTypes.SEM_KEY_EVENT;
	}


	public int getKeyCode() {
        return keyCode;
    }

    public int getKeyChar() {
        return keyChar;
    }

    public int getKeyState() {
        return keyState;
    }
}
