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
package org.jclarion.clarion.compile.java;

import java.util.Set;

import org.jclarion.clarion.compile.grammar.GrammarHelper;

public class Labeller 
{
    private static Set<String> reserved = GrammarHelper.list(
        "for","class","getClass","import","throw","default","final","float",
        "package","_owner","continue","break","wait","this");
    
    public static String get(String label,boolean typed)
    {
        StringBuilder conv=new StringBuilder();
        int scan = 0;
        
        char last=0;
        boolean upper=typed;
        
        boolean alpha=false;
        
        while (scan<label.length()) {           
            char c = label.charAt(scan++);
            if (c==':') {
            	last=c;
            	upper=true;
            	continue;
            }
            
            if (upper) {
            	if (c>='A' && c<='Z') {
            		conv.append(c);
            		alpha=true;
            		upper=false;
                    last=c;
            		continue;
            	}
            	if (c>='a' && c<='z') {
            		conv.append((char)(c-'a'+'A'));
            		alpha=true;
            		upper=false;
                    last=c;
            		continue;
            	}

            	if (last==':') {
            		conv.append('_');
            	}
            }
            last=c;
            
            if (c>='A' && c<='Z') {
        		conv.append((char)(c-'A'+'a'));
        		alpha=true;
        		continue;
            }
            
            if (!alpha && c>='a' && c<='z') {
            	alpha=true;
            }

            if (c==':') {
            	upper=true;
            	continue;
            }
            
            conv.append(c);
        }

        if (last==':') {
        	conv.append('_');
        }
        
        if (!alpha) {
        	conv.insert(0, typed ? 'A' : 'a');
        }
        
        String result = conv.toString();
        if (reserved.contains(result)) {
            result="_"+result;
        }
        return result;
    }
    
}
