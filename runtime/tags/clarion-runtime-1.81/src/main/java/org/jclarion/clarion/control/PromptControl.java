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

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;

import javax.swing.JLabel;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.swing.MnemonicConfig;
import org.jclarion.clarion.swing.MnemonicDecoder;

public class PromptControl extends AbstractControl {

    @Override
    public boolean isAcceptAllControl() {
        return false;
    }

    @Override
    public boolean validateInput() {
        return true;
    }
    
    @Override
    public int getCreateType() {
        return Create.PROMPT;
    }

    private JLabel label;
    
    @Override
    public void clearMetaData() {
        label=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"label",label);
    }
    
    
    
    @Override
	protected void handleAWTChange(int indx, ClarionObject value) {
    	if (indx==Prop.TEXT) {
            configurePrompt();
            
            JLabel lab=label;
            if (lab==null) return;
            
            Dimension ps = lab.getPreferredSize();
            Dimension s = lab.getSize();
            if (ps.width > s.width || ps.height > s.height) {
                if (ps.width > s.width)
                    s.width = ps.width;
                if (ps.height > s.height)
                    s.height = ps.height;
                lab.setSize(s);
            }
    	}
		super.handleAWTChange(indx, value);
	}

	@Override
	protected boolean isAWTChange(int indx) {
		if (indx==Prop.TEXT) return true;
		return super.isAWTChange(indx);
	}
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
        
        label = new JLabel();
        parent.add(label);
        configurePrompt();

        configureFont(label);
        configureColor(label);
        setPositionAndState();
    }
    

    private void configurePrompt()
    {
        JLabel label=this.label;
        if (label==null) return;
        MnemonicDecoder dec = new MnemonicDecoder(getProperty(Prop.TEXT)
                .toString().trim());
        label.setText(dec.getString());
        if (dec.getMnemonicPos() >= 0) {
            label.setDisplayedMnemonicIndex(dec.getMnemonicPos());
            getWindowOwner().getMnemonic(true).addMnemonic(this,
                    dec.getMnemonicChar(), MnemonicConfig.Mode.SELECTONLY, 1);
        }
    }

    @Override
    public Component getComponent() {
        return label;
    }

}
