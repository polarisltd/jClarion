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
package org.jclarion.clarion.compile.var;

import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.EquateClass;
import org.jclarion.clarion.compile.java.Labeller;

public class EquateClasses {
    
    public static Map<String,EquateClass> classes=new HashMap<String, EquateClass>();
    
    public static void clean()
    {
        classes.clear();
    }
    
    public static String[] split(String label)
    {
        String result[]=new String[2];
        
        int lastColon = label.lastIndexOf(':');
        if (lastColon>-1) {
            result[0]=label.substring(0,lastColon);
            result[1]=label.substring(lastColon+1);
        } else {
            result[1]=label;
        }
    
        return result;
    }
    
    public static EquateClass get(String base)
    {
        if (base==null) base="Constants";
        base=base.toLowerCase();
        String lookup = base;
        EquateClass jc = classes.get(lookup);
        
        if (jc==null) {
            base=base.toLowerCase();
        
            StringTokenizer tok = new StringTokenizer(base,":");
            String bits[] = new String[tok.countTokens()];
            
            for (int scan=0;scan<bits.length;scan++) {
                bits[scan]=Labeller.get(tok.nextToken(),false).toLowerCase();
            }
            
            bits[bits.length-1]=GrammarHelper.capitalise(bits[bits.length-1]);
            
            String pkg=null;
            
            if (bits.length>1) {
                StringBuilder sb_pkg=new StringBuilder();
                for (int scan=0;scan<bits.length-1;scan++) {
                    if (scan>0) sb_pkg.append('.');
                    sb_pkg.append(bits[scan]);
                }
                pkg=sb_pkg.toString();
            }
            
            jc=new EquateClass(pkg,bits[bits.length-1]);
            classes.put(lookup,jc);
            ClassRepository.add(jc,bits[bits.length-1]);
        }
        
        return jc;
    }
}
