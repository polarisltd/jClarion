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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.control.AbstractControl;

public class MnemonicConfig 
{
    public enum Mode { SELECTONLY, ACCEPT };
    
    public class Entry
    {
        public AbstractControl     control;
        public int                 key;
        public Mode                mode;
        public int offset;
        
        public Entry(AbstractControl control,int key,Mode mode,int offset)
        {
            this.control=control;
            this.key=key;
            this.mode=mode;
            this.offset=offset;
        }
    }
    
    private Map<Integer,List<Entry>> mnemonics=new HashMap<Integer, List<Entry>>();
    private Set<Integer> keys=new HashSet<Integer>();
    
    public void addMnemonic(AbstractControl ac,int c,Mode mode,int offset)
    {
        doAddMnemonic(ac,c,mode,offset);
        if ((c>='A' && c<='Z') || (c>='0' && c<='9')) {
            doAddMnemonic(ac,c+0x400,mode,offset);
        }
    }
    
    public void doAddMnemonic(AbstractControl ac,int c,Mode mode,int offset)
    {
        Entry e = new Entry(ac,c,mode,offset);
        
        List<Entry> list = mnemonics.get(ac.getUseID());
        
        if (list==null) {
            list=new ArrayList<Entry>();
            mnemonics.put(ac.getUseID(),list);
        }
        
        list.add(e);
        keys.add(c);
    }
    
    public boolean isKeyOfInterest(int id)
    {
        return keys.contains(id);
    }
    
    public Entry match(AbstractControl id,int c)
    {
        return match(id.getUseID(),c);
    }
    
    public Entry match(int id,int c)
    {
        List<Entry> list = mnemonics.get(id);
        if (list==null) return null;
        for (Entry test : list ) {
            if (test.key==c) {
                return test;
            }
        }
        return null;
    }
}
