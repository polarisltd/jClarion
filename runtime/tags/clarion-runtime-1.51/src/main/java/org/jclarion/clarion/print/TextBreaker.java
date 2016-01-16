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
package org.jclarion.clarion.print;


public class TextBreaker 
{
    private String text;
    private PrintContext graphics;
    private int width;

    private int pos;
    
    public TextBreaker(String text,PrintContext graphics,int width)
    {
        this.text=text;
        this.graphics=graphics;
        this.width=width;
        this.pos=0;
    }
    
    public String next()
    {
        if (pos>=text.length()) return null;
        int nextNL = text.indexOf('\n',pos);
        if (nextNL==-1) {
            nextNL=text.length();
        } else {
            nextNL+=1;
        }
        
        int end = nextNL; // end is not inclusive
        while (end>pos) {
            char c = text.charAt(end-1);
            if (c=='\n' || c=='\r' || c==' ' || c=='\t') {
                end--;
            } else {
                break;
            }
        }

        while ( true ) {
            if (end<=pos) break;
        
            if (graphics.stringWidth(text.substring(pos,end))>width) {
                int wordStart=end;
                while (wordStart>pos) {
                    char c = text.charAt(wordStart-1);
                    if (c==' ' || c=='\t') {
                        break;
                    } else {
                        wordStart--;
                    }
                }
                
                if (wordStart==pos) break;
                
                int wordEnd=wordStart;
                while (wordEnd>pos) {
                    char c = text.charAt(wordEnd-1);
                    if (c==' ' || c=='\t') {
                        wordEnd--;
                    } else {
                        break;
                    }
                }
                
                if (wordEnd==pos) break;
     
                nextNL=wordStart;
                end=wordEnd;
            } else {
                break;
            }
        }

        String result;
        
        if (end<=pos) {
            result="";
        } else {
            result=text.substring(pos,end);
        }
        
        pos=nextNL;
        return result;
    }
}
