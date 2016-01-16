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

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.compile.grammar.GrammarHelper;

public class Labeller 
{
    private static Map<String,String> labels=new HashMap<String, String>();

    private static Set<String> reserved = GrammarHelper.list(
        "for","class","getClass","import","throw","default","final","float",
        "package","_owner","continue","break");
    
    public static void clear()
    {
        labels.clear();
    }
    
    public static String lookupIndex(String in,boolean typed)
    {
        StringBuilder sb = new StringBuilder(in.length()+1);
        if (typed) sb.append("+");
        for (int scan=0;scan<in.length();scan++) {
            char c = in.charAt(scan);
            if (c>='A' && c<='Z') c=(char)(c-'A'+'a');
            sb.append(c);
        }
        return sb.toString();
    }
    
    public static String get(String label,boolean typed)
    {
        String lookup = lookupIndex(label,typed); 
        
        String result = labels.get(lookup);
        if (result!=null) return result;

        // convert - according to following rules
        // ':' followed by alpha - case the alpha
        // ':' followed by ':' - ignore 
        // ':' in other circumstances - convert to '_'
        // first alpha must be lower case
        // if string has no alphas prefix 'A'
        
        // if all upper case then force to lower case 
        // while scanning check for presence of any alpha
        boolean forceLower=true;
        boolean anyAlpha=false;
        for (int scan=0;scan<label.length();scan++) {
            char c = label.charAt(scan);
            if (c>='a' && c<='z') {
                forceLower=false;
                anyAlpha=true;
                break;
            }
            if (c>='A' && c<='Z') {
                anyAlpha=true;
            }
        }
        
        boolean firstAlpha=false;
        
        StringBuilder conv=new StringBuilder();
        if (!anyAlpha) {
            firstAlpha=true;
            conv.append(typed?'A':'a');
        }
        
        char last=0;
        char curr=0;
        char next=label.length()>0?label.charAt(0):((char)0);
        
        int scan = 0;
        while (scan<label.length()) {
           
            last=curr;
            curr = next;
            next = scan+1<label.length()?label.charAt(scan+1):((char)0);
            scan++;
            
            char c = curr;
            
            if (forceLower && c>='A' && c<='Z') c=(char)(c-'A'+'a');
            
            if ((c>='A' && c<='Z') || (c>='a' && c<='z')) {
                
                if (!firstAlpha) {
                    if (c>='A' && c<='Z' && !typed) c=(char)(c-'A'+'a');
                    if (c>='a' && c<='z' && typed) c=(char)(c-'a'+'A');
                    firstAlpha=true;
                } else {
                    if (last==':') {
                        if (c>='a' && c<='z') c=(char)(c-'a'+'A');
                    }
                }
            }
            
            if (c==':') {
                if (next==':') {
                    continue;   // skip it
                }
                if ((next>='A' && next<='Z') || (next>='a' && next<='z')) {
                    continue;   // skip it
                }
                c='_';
            }
            
            if ( (c>='a' && c<='z') || 
                 (c>='A' && c<='Z') || 
                 (c>='0' && c<='9') ||
                 c=='_') 
            {
                conv.append(c);
            }
        }
 
        result = conv.toString();
        
        if (reserved.contains(result)) {
            result="_"+result;
        }
        
        labels.put(lookup,result);
        return result;
    }
    
}
