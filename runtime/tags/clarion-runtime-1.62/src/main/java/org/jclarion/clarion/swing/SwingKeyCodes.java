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
package org.jclarion.clarion.swing;

import java.awt.event.KeyEvent;
import java.util.Map;
import java.util.HashMap;

import javax.swing.KeyStroke;


import org.jclarion.clarion.constants.*;

public class SwingKeyCodes 
{
    public static final int CLARION_SHIFT   = 0x100;
    public static final int CLARION_CTRL    = 0x200;
    public static final int CLARION_ALT     = 0x400;
    
    public static class ModifierMap
    {
        public int awt;
        public int clarion;
        
        public ModifierMap(int awt,int clarion)
        {
            this.awt=awt;
            this.clarion=clarion;
        }
    }
    
    private static SwingKeyCodes instance ; 
    
    public static SwingKeyCodes getInstance()
    {
        if (instance==null) {
            synchronized(SwingKeyCodes.class) {
                if (instance==null) {
                    instance=new SwingKeyCodes();
                }
            }
        }
        return instance;
    }

    public ModifierMap[] modifierMap;
    
    private Map<KeyStroke,Integer> codes;

    private void addFunctionKey(int keyCode,int clarionCode)
    {
        for (ModifierMap m : modifierMap ) {
            codes.put(KeyStroke.getKeyStroke(keyCode,m.awt),clarionCode+m.clarion);
        }
    }
    
    public SwingKeyCodes()
    {
        modifierMap = new ModifierMap[] {
                new ModifierMap(0,0),
                new ModifierMap(KeyEvent.SHIFT_DOWN_MASK,CLARION_SHIFT),
                new ModifierMap(KeyEvent.ALT_DOWN_MASK,CLARION_ALT),
                new ModifierMap(KeyEvent.CTRL_DOWN_MASK,CLARION_CTRL),

                new ModifierMap(KeyEvent.SHIFT_DOWN_MASK+KeyEvent.ALT_DOWN_MASK,CLARION_SHIFT+CLARION_ALT),
                new ModifierMap(KeyEvent.SHIFT_DOWN_MASK+KeyEvent.CTRL_DOWN_MASK,CLARION_SHIFT+CLARION_CTRL),
                new ModifierMap(KeyEvent.ALT_DOWN_MASK+KeyEvent.CTRL_DOWN_MASK,CLARION_ALT+CLARION_CTRL),
                new ModifierMap(KeyEvent.SHIFT_DOWN_MASK+KeyEvent.ALT_DOWN_MASK+KeyEvent.CTRL_DOWN_MASK,CLARION_SHIFT+CLARION_ALT+CLARION_CTRL)
        };
        
        codes=new HashMap<KeyStroke, Integer>();

        addFunctionKey(KeyEvent.VK_F1,Constants.F1KEY);
        addFunctionKey(KeyEvent.VK_F2,Constants.F2KEY);
        addFunctionKey(KeyEvent.VK_F3,Constants.F3KEY);
        addFunctionKey(KeyEvent.VK_F4,Constants.F4KEY);
        addFunctionKey(KeyEvent.VK_F5,Constants.F5KEY);
        addFunctionKey(KeyEvent.VK_F6,Constants.F6KEY);
        addFunctionKey(KeyEvent.VK_F7,Constants.F7KEY);
        addFunctionKey(KeyEvent.VK_F8,Constants.F8KEY);
        addFunctionKey(KeyEvent.VK_F9,Constants.F9KEY);
        addFunctionKey(KeyEvent.VK_F10,Constants.F10KEY);
        addFunctionKey(KeyEvent.VK_F11,Constants.F11KEY);
        addFunctionKey(KeyEvent.VK_F12,Constants.F12KEY);
        addFunctionKey(KeyEvent.VK_LEFT,Constants.LEFTKEY);
        addFunctionKey(KeyEvent.VK_RIGHT,Constants.RIGHTKEY);
        addFunctionKey(KeyEvent.VK_UP,Constants.UPKEY);
        addFunctionKey(KeyEvent.VK_DOWN,Constants.DOWNKEY);
        addFunctionKey(KeyEvent.VK_PAGE_DOWN,Constants.PGDNKEY);
        addFunctionKey(KeyEvent.VK_PAGE_UP,Constants.PGUPKEY);
        addFunctionKey(KeyEvent.VK_END,Constants.ENDKEY);
        addFunctionKey(KeyEvent.VK_HOME,Constants.HOMEKEY);
        addFunctionKey(KeyEvent.VK_DELETE,Constants.DELETEKEY);
        addFunctionKey(KeyEvent.VK_INSERT,Constants.INSERTKEY);

        //addFunctionKey(KeyEvent.VK_ENTER,Constants.ENTERKEY);
        //addFunctionKey(KeyEvent.VK_BACK_SPACE,Constants.BSKEY);
        //addFunctionKey(KeyEvent.VK_SPACE,Constants.SPACEKEY);
    }
    
    public int toClarionState(KeyEvent event)
    {
        int state=0;

        int modifiers = event.getModifiersEx();
        
        if ((modifiers & KeyEvent.SHIFT_DOWN_MASK)!=0) {
            state|=0x0100;
        }

        if ((modifiers & KeyEvent.CTRL_DOWN_MASK)!=0) {
            state|=0x0200;
        }

        if ((modifiers & KeyEvent.ALT_DOWN_MASK)!=0) {
            state|=0x0400;
        }

        /**
        if ((modifiers & KeyEvent.VK_CA)!=0) {
            state|=0x1000;
        }

        if ((event.stateMask & SWT.NUM_LOCK)!=0) {
            state|=0x2000;
        }

        if ((event.stateMask & SWT.SCROLL_LOCK)!=0) {
            state|=0x4000;
        }
        **/

        return state;
    }

    public int toClarionChar(KeyEvent event)
    {
        if (event.getKeyChar()==KeyEvent.CHAR_UNDEFINED) return 0;
        return event.getKeyChar();
    }
    
    public int toClarionCode(KeyEvent event)
    {
        int code=0;
        
        Integer remap = codes.get(KeyStroke.getKeyStrokeForEvent(event));
                
        if (remap!=null) {
            code=remap;
        } else {
            int modifiers = event.getModifiersEx();
            int icode=event.getKeyChar();
            if ( ((modifiers & KeyEvent.CTRL_DOWN_MASK)!=0) && (event.getID()==KeyEvent.KEY_PRESSED)) {
                icode=event.getKeyCode();
            }
            
            if (icode>='a' && icode<='z') {
                code=icode-'a'+'A';
            }
            if (icode>='A' && icode<='Z') {
                code=icode;
            }
            if (icode>='0' && icode<='9') {
                code=icode;
            }
            if (icode==KeyEvent.VK_SPACE) {
                code=Constants.SPACEKEY;
            }
            if (icode==KeyEvent.VK_ENTER) {
                code=Constants.ENTERKEY;
            }
            
            if (icode==KeyEvent.VK_BACK_SPACE) {
                code=Constants.BSKEY;
            }

            if (icode==KeyEvent.VK_ESCAPE) {
                code=Constants.ESCKEY;
            }

            if (icode==KeyEvent.VK_DELETE) {
                code=Constants.DELETEKEY;
            }
            
            if (code>0) {
                

                if ((modifiers & KeyEvent.SHIFT_DOWN_MASK)!=0) {
                    code|=0x0100;
                }

                if ((modifiers & KeyEvent.CTRL_DOWN_MASK)!=0) {
                    code|=0x0200;
                }

                if ((modifiers & KeyEvent.ALT_DOWN_MASK)!=0) {
                    code|=0x0400;
                }
            }
        }
        
        return code;
    }
}
