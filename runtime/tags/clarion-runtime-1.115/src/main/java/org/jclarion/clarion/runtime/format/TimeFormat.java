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
package org.jclarion.clarion.runtime.format;


import org.jclarion.clarion.runtime.SimpleStringDecoder;

/**
 * Time Format
 * 
 * @t {0} {type} [{sep}] [{b}]
 * 
 * {0} = zero pad hours/minutes/seconds etc
 * 
 * {type} = 
 *    1 hh:mm
 *    2 hhmm
 *    3 hh:mmXM
 *    4 hh:mm:ss
 *    5 hhmmss
 *    6 hh:mm:ssXM
 *    7 Windows short type (not supported here)
 *    8 Windows long type  (not supported here) 
 *  
 * {sep} = either '(comma) .(dot) -(hypen) _(space) 
 *  
 * @author barney
 *
 */
public class TimeFormat extends Formatter
{
    private static String formats[] = {
        "H:m",
        "Hm",
        "h:ma",
        "H:m:s",
        "Hms",
        "h:m:sa",
        "h:ma",
        "h:m:sa",
    };

    
    private String          format=null;
    private String          pattern_representation=null;
    private boolean         blank=false;
    private boolean			interval=false;
    private char            sep=':';
    private boolean         pad=false;
    
    public TimeFormat(String picture)
    {
        super(picture);
        SimpleStringDecoder ssd = new SimpleStringDecoder(picture);
        if (!ssd.pop('@')) ssd.error("Invalid Format");
        if (!ssd.pop('t')) ssd.error("Invalid Format");
        
        pad = ssd.pop('0');
        
        
        Integer type = ssd.popNumeric();
        if (type==null) ssd.error("Invalid format");
        int itype = type;
        if (itype<1 || itype>8) ssd.error("Invalid format");
        
        switch(ssd.peekChar(0)) {
            case '.':
                ssd.pop('.');
                sep='.';
                break;
            case '\'':
                ssd.pop('\'');
                sep=',';
                break;
            case '-':
                ssd.pop('-');
                sep='-';
                break;
            case '_':
                ssd.pop('_');
                sep=' ';
                break;
        }
        
        if (ssd.pop('b')) blank=true;
        if (ssd.pop('i')) interval=true;
        if (ssd.pop('b')) blank=true;
        if (!ssd.end()) ssd.error("Invalid Format");
        
        format=formats[type-1];
        
        StringBuilder pr=new StringBuilder(); 
        for (int scan=0;scan<format.length();scan++) {

            char c=format.charAt(scan);
            
            if (c=='H' || c=='h') {
                if (pad) {
                    pr.append("##");
                } else {
                    pr.append("<#");
                }
            }
            if (c=='m' || c=='s') {
                pr.append("##");
            }
            if (c=='a') {
                pr.append("XM");
            }
            if (c==':') {
                pr.append(sep);
            }
        }
        pattern_representation=pr.toString();
    }
    
    @Override
    public String deformat(String input) {
        clearError();

        input=input.trim().toLowerCase();
        if (input.length()==0) return "";
        
        boolean isPM=false;
        boolean isAM=false;
        
        String bits[]=new String[4];
        
        int count=0;
        int str_scan=0;
        while (str_scan<input.length()) {
        	
        	// trim leading
        	while (str_scan<input.length()) {
        		char test = input.charAt(str_scan);
        		if (test==' ' || test=='\t') {
        			str_scan++;
        			continue;
        		}
        		break;
        	}
        	if (str_scan>=input.length()) break;
        	
        	int str_from=str_scan;
        	while (str_scan<input.length()) {
        		char test = input.charAt(str_scan);
        		if (test==' ' || test=='\t' || test==':' || test=='.' || test==',' || test=='-') {
        			break;
        		}
        		str_scan++;
        	}

        	String s = input.substring(str_from,str_scan);
        	if (count==4) {
        		return error();
        	}
        	str_scan++;

        	
        	// trim trailing
        	while (str_scan<input.length()) {
        		char test = input.charAt(str_scan);
        		if (test==' ' || test=='\t') {
        			str_scan++;
        			continue;
        		}
        		break;
        	}
        	
            if (str_scan>=input.length()) {
                if (s.endsWith("pm")) {
                    isPM=true;
                    s=s.substring(0,s.length()-2);
                }
                else if (s.endsWith("am")) {
                    isAM=true;
                    s=s.substring(0,s.length()-2);
                }  
            }
            bits[count++]=s;
        }
        
        if (count==0) return "";
        
        if (count==1) {
        	
        	if (bits.length>6) {
        		return error();
        	}
        	
        	if (bits[0].length()>1) {
        		while (bits[count-1].length()>2) {
        			
        			int inc = bits[count-1].length();
        			if ((inc&1)==1) {
        				inc=1;
        			} else {
        				inc=2;
        			}
        			bits[count]=bits[count-1].substring(inc);
        			bits[count-1]=bits[count-1].substring(0,inc);
        			count++;
        		}
        	}
        }
        
        int time[]=new int[3];
        if (count==4) count=3;
        for (int scan=0;scan<count;scan++) {
            try {
                time[scan]=Integer.parseInt(bits[scan]);
            } catch (NumberFormatException ex) { }
        }

        if (isAM || isPM) {
            if (time[0]==0) return error();
            if (time[0]==12) time[0]=0;
            if (isPM) time[0]+=12;
        }
        
        if (!interval && time[0]>=24) return error();
        if (time[1]>=60) return error();
        if (time[2]>=60) return error();
        
        return String.valueOf(time[0]*360000+time[1]*6000+time[2]*100+1);
    }

    @Override
    public String format(String input) {
        clearError();
        
        int time=0;
        input=input.trim();
        if (input.length()>0) {
            try {
                time=Integer.parseInt(input);
            } catch (NumberFormatException ex) {
                return error();
            }
        }
        
        if (time==0) {
            if (blank) return "";
            if (format.indexOf(':')==-1) return "";
            if (format.indexOf('s')>=0) return " "+sep+" "+sep+" ";
            return " "+sep+" ";
        }
        
        StringBuilder result = new StringBuilder(10);
        
        for (int scan=0;scan<format.length();scan++) {
            char c = format.charAt(scan);
            
            if (c=='H') {
                int v = (time-1)/360000;
                if (v>=10 || pad) {
                    result.append((char)(v/10+'0'));
                }
                result.append((char)(v%10+'0'));
            }
            
            if (c=='h') {
                int v = (time-1)/360000;
                v=v%12;
                if (v==0) v=12;
                if (v>=10 || pad) {
                    result.append((char)(v/10+'0'));
                }
                result.append((char)(v%10+'0'));
            }

            if (c=='m') {
                int v = (time-1)/6000%60;
                result.append((char)(v/10+'0'));
                result.append((char)(v%10+'0'));
            }

            if (c=='s') {
                int v = (time-1)/100%60;
                result.append((char)(v/10+'0'));
                result.append((char)(v%10+'0'));
            }

            if (c=='a') {
                if (time-1<(12*60*60*100)) {
                    result.append("AM");
                } else {
                    result.append("PM");
                }
            }
            
            if (c==':') {
                result.append(sep);
            }
        }

        return result.toString();
    }

    @Override
    public int getMaxLen() {
        return 10;
    }
    
    private String error()
    {
        setError();
        return "##########";
    }

    @Override
    public String getPictureRepresentation() {
        return pattern_representation;
    }

    @Override
	public boolean isComputerCoded() {
		return true;
	}
    
}
