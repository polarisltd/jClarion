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

import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;

import javax.swing.AbstractButton;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.MnemonicConfig;
import org.jclarion.clarion.swing.MnemonicDecoder;
import org.jclarion.clarion.swing.gui.CommandList;

public abstract class AbstractButtonControl extends AbstractControl 
{
    private boolean clickOnFocus;
    
    @Override
    public void clearMetaData() 
    {
        clickOnFocus=false;
        super.clearMetaData();
    }
    
    @Override
    protected void debugMetaData(StringBuilder sb) 
    {
        super.debugMetaData(sb);
        debugMetaData(sb,"clickOnFocus",null);
    }
    
    
    public abstract AbstractButton getButton();

    public static final int CONFIGURE_BUTTON=100;
    
    @Override
	public CommandList getCommandList() {
    	return super.getCommandList()
    		.add("CONFIGURE_BUTTON",CONFIGURE_BUTTON)
    	;
    }
    
    
    @Override
	public Object command(int command, Object... params) 
    {
    	switch(command) {
    		case CONFIGURE_BUTTON: {
                AbstractButton button = getButton();

                MnemonicDecoder dec = new MnemonicDecoder(getProperty(Prop.TEXT).toString());

                button.setText(dec.getString());
                if (dec.getMnemonicPos() > -1) {
                    char mn = dec.getMnemonicChar();
                    getWindowOwner().getMnemonic(true).addMnemonic(this, mn,MnemonicConfig.Mode.ACCEPT, 0);
                    button.setDisplayedMnemonicIndex(dec.getMnemonicPos());
                }

                if (this instanceof KeyableControl) {
                    int key = ((KeyableControl)this).getKey();
                    if (key != 0) {
                        getWindowOwner().getMnemonic(true).addMnemonic(this,key, MnemonicConfig.Mode.ACCEPT, 0);
                    }
                }
    		}
    	}
		return super.command(command, params);
	}

	public final void configureButton() 
    {
    	CWinImpl.run(this,CONFIGURE_BUTTON);
    }
    
    public void initButton() 
    {
        getButton().addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {
                if (clickOnFocus) {
                    clickOnFocus=false;
                    getButton().doClick();
                }
            }
            @Override
            public void focusLost(FocusEvent e) {
            }
        });

    }


    public void doClickOnFocus()
    {
        clickOnFocus=true;
    }

    @Override
    public void accept() 
    {
        AbstractButton button=getButton();
        if (button==null) return;
        
        if (button.isFocusOwner()) {
            button.doClick();
        } else {
            if (getParent() instanceof AbstractMenuItemControl || (!button.isFocusable()))
            {
                button.doClick();
            } else {
                clickOnFocus=true;
                button.requestFocusInWindow();
            }
        }
    }

    
}
