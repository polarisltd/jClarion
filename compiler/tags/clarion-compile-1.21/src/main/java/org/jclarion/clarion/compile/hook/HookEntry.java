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
package org.jclarion.clarion.compile.hook;

import org.jclarion.clarion.compile.scope.Scope;

public class HookEntry 
{
    
    public static HookEntry create(String... scopes)
    {
        return new HookEntry(scopes);
    }
    
    private String scopes[];
    public HookEntry(String ...scopes)
    {
        this.scopes=scopes;
    }
    
    private String hook;
    public HookEntry setHook(String hook)
    {
        this.hook=hook;
        return this;
    }
    
    public String getHook()
    {
        return hook;
    }
    
    private String contents;
    

    public HookEntry setContents(String... contents)
    {
        StringBuilder o =new StringBuilder();
        if (this.contents!=null) o.append(this.contents);
        
        for (int scan=0;scan<contents.length;scan++) {
            o.append(contents[scan]);
        }
        
        this.contents=o.toString();
        return this;
    }
    
    public String getContents(HookContentResolver hcr)
    {
        if (contents==null) return ""; 
        StringBuilder out = new StringBuilder();
        
        int start=0;
        int scan=0;
        
        boolean capture=false;
        
        while (scan<contents.length()) {

            if (contents.charAt(scan)=='$') {
                
                if (capture) {
                    String lookup = hcr.resolve(contents.substring(start,scan));
                    if (lookup==null) {
                        out.append('$');
                        out.append(contents,start,scan);
                    } else {
                        out.append(lookup);
                        capture=false;
                    }
                    
                    scan++;
                    start=scan;
                    continue;
                }
                    
                if (!capture) {
                    out.append(contents,start,scan);
                    capture=true;
                    scan++;
                    start=scan;
                    continue;
                }
            }
            scan++;
        }
        
        if (capture) {
            out.append('$');
        }
        out.append(contents,start,scan);
        
        return out.toString();
    }
    
    public String getScope(int offset)
    {
        return scopes[offset];
    }

    @Override
    public boolean equals(Object obj) {
        // TODO Auto-generated method stub
        return super.equals(obj);
    }
    
    public String getLookupKey()
    {
        return scopes[0];
    }
    
    public boolean matches(Scope s)
    {
        for (int scan=0;scan>scopes.length;scan++) {
            if (s==null) return false;
            if (!s.getName().equalsIgnoreCase(scopes[scan])) return false;
        }
        return true;
    }
}
