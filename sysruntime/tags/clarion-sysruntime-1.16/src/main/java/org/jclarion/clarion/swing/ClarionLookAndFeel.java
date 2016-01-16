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

import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.UIManager.LookAndFeelInfo;

public class ClarionLookAndFeel 
{
    private static boolean initialized=false;

    public static void init(String setting)
    {
    	Win32DisplayChangeMemoryBugFix.init();
    	
        if (initialized) return;
        initialized=true;
        
        if (setting==null) setting="Nimbus";
        setting=setting.trim();
        if (setting.length()==0) setting="Nimbus";
        
        if (setting.equals("Nimbus")) {
            try {
                //UIManager.installLookAndFeel("Nimbus","nimbus.NimbusLookAndFeel");
                //UIManager.setLookAndFeel("nimbus.NimbusLookAndFeel");
                UIManager.setLookAndFeel("com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (InstantiationException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (UnsupportedLookAndFeelException e) {
                e.printStackTrace();
            }
            
            return;
        }

        for (LookAndFeelInfo info : UIManager.getInstalledLookAndFeels() ) {
            if (info.getName().equals(setting)) {
                try {
                    UIManager.setLookAndFeel(info.getClassName());
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } catch (InstantiationException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (UnsupportedLookAndFeelException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
