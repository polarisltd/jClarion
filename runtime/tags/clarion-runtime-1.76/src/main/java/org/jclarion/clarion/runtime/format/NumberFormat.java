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

import java.math.BigDecimal;

import org.jclarion.clarion.runtime.SimpleStringDecoder;

public class NumberFormat extends Formatter
{
    private enum Sign { NONE, PLUS, MINUS };
    private enum Fill { NONE, ZERO, SPACE, STAR };
    private enum Group { COMMA, SPACE, NONE, HYPHEN, PERIOD };
    private enum Decimal { NA,NONE, PERIOD, COMMA };
    
    private String  leadCurrency;
    private String  trailCurrency;
    private Sign    leadSign;
    private Sign    trailSign;
    private boolean paranthesis;
    private int     length;
    private Group   grouping;
    private Decimal decimal;
    private int     decimalSize;
    private boolean blank;
    
    private Fill     fill; 
    
    public NumberFormat(String format) {
        super(format);
        SimpleStringDecoder decoder = new SimpleStringDecoder(format);
        if (!decoder.pop('@')) throw new IllegalArgumentException("Invalid Picture");
        if (!decoder.pop("nN".toCharArray())) throw new IllegalArgumentException("Invalid Picture");
        
        leadCurrency=popCurrency(decoder);
        if (decoder.pop('(')) {
            paranthesis=true;
            leadSign=Sign.NONE;
        } else {
            leadSign=popSign(decoder);
        }
        
        fill=Fill.NONE;
        grouping=Group.COMMA;
        
        if (decoder.pop('0')) { fill=Fill.ZERO; grouping=Group.NONE; }
        else if (decoder.pop('_')) { fill=Fill.SPACE; grouping=Group.NONE; }
        else if (decoder.pop('*')) { fill=Fill.STAR; grouping=Group.NONE; }

        Integer result = decoder.popNumeric();
        if (result==null) throw new IllegalArgumentException("Invalid Picture");
        length=result;

        if (decoder.peekChar(0)=='.') {
            char c=decoder.peekChar(1);
            if (c<'0' || c>'9') {
                decoder.pop('.');
                grouping=Group.PERIOD;
            }
        } 
        else if (decoder.pop('-')) { grouping=Group.HYPHEN; }
        else if (decoder.pop('_')) { grouping=Group.SPACE; }


        decimal=Decimal.NA;
        if (decoder.pop('.')) {
            decimal=Decimal.PERIOD;
            Integer s = decoder.popNumeric();
            if (s==null) throw new IllegalArgumentException("Invalid Picture");
            decimalSize=s;
        } 
        else if (decoder.pop('v')) {
            decimal=Decimal.NONE;
            Integer s = decoder.popNumeric();
            if (s==null) throw new IllegalArgumentException("Invalid Picture");
            decimalSize=s;
        } 
        else if (decoder.pop('\'')) {
            decimal=Decimal.COMMA;
            Integer s = decoder.popNumeric();
            if (s==null) throw new IllegalArgumentException("Invalid Picture");
            decimalSize=s;
        } 

        if (paranthesis) {
            if (!decoder.pop(')'))  throw new IllegalArgumentException("Invalid Picture");
        } else {
            trailSign = popSign(decoder);
        }
        
        trailCurrency = popCurrency(decoder);
        
        if (decoder.pop("bB".toCharArray())) {
            blank=true;
        }
        
        if (!decoder.end()) throw new IllegalArgumentException("Invalid Picture");
    }

    private Sign popSign(SimpleStringDecoder decoder) {
        if (decoder.pop('-')) {
            return Sign.MINUS; 
        }
        if (decoder.pop('+')) {
            return Sign.PLUS; 
        }
        return Sign.NONE;
    }
    
    private String popCurrency(SimpleStringDecoder decoder) {
        if (decoder.pop('$')) {
            return "$";
        }
        if (decoder.pop('~')) {
            String result = decoder.popString('~');
            if (!decoder.pop('~')) throw new IllegalArgumentException("Invalid Picture");
            return result;
        }
        return "";
    }
    
    private boolean matches(String input,int offset,String match) {
        if (offset<0) return false;
        if (offset+match.length()>input.length()) return false;
        
        for (int scan=0;scan<match.length();scan++) {
            if (input.charAt(scan+offset)!=match.charAt(scan)) return false;
        }
        return true;
    }

    @Override
    public String deformat(String input) {

        clearError();
        
        int istart;
        int iend;
        
        istart=0;
        iend=input.length();
        
        while (istart<iend) {
            if (input.charAt(istart)==' ') {
                istart++;
            } else {
                break;
            }
        }
        while (istart<iend) {
            if (input.charAt(iend-1)==' ') {
                iend--;
            } else {
                break;
            }
        }
            
        if (leadCurrency.length()>0) {
            if (matches(input,istart,leadCurrency)) {
                istart=istart+leadCurrency.length();
            }
        }

        if (trailCurrency.length()>0) {
            if (matches(input,iend-trailCurrency.length(),trailCurrency)) {
                iend=iend-trailCurrency.length();
            }
        }

        boolean minus=false;
        
        if (matches(input,istart,"-")) {
            istart++;
            minus=true;
        }

        if (matches(input,iend-1,"-") && iend>istart) {
            minus=true;
            iend--;
        }

        if (matches(input,istart,"+")) istart++;
        if (matches(input,iend-1,"+") && iend>istart) iend--;

        if (iend-istart>=2) {
            if (input.charAt(istart)=='(' && input.charAt(iend-1)==')') {
                minus=!minus;
                istart++;
                iend--;
            }
        }

        // remove extraneous decimal precision
        boolean hasDecimal=false;
        for (int scan=istart;scan<iend;scan++) {
            if (input.charAt(scan)=='.') hasDecimal=true;
        }
        if (hasDecimal) {
            while (istart<iend) {
                if (input.charAt(iend-1)=='0') {
                    iend--;
                } else {
                    break;
                }
            }
            
            if (istart<iend) {
                if (input.charAt(iend-1)=='.') iend--;
            }
        }
        
        int minsize=iend-istart;
        if (minsize==0) minsize=1;
        if (this.decimal==Decimal.NONE) {
            if (minsize<this.decimalSize+2) {
                minsize=this.decimalSize+2;
            }
        } else {
            minsize+=1;
        }
        if (minus) minsize+=1;
        minsize+=1;
        
        char bits[]=new char[minsize];
        input.getChars(istart,iend,bits,bits.length-(iend-istart));
        
        int start=bits.length;
        
        boolean decimal=false;
        
        for (int scan=bits.length-1;scan>=bits.length-(iend-istart);scan--) {
            char c=  bits[scan];
            boolean keep=false;
            boolean skip=false;
            if (c>='0' && c<='9') keep=true;
            
            if (!keep) {
                if (!decimal) {
                    if (c=='.' && (this.decimal==Decimal.PERIOD || this.decimal==Decimal.NONE)) {
                        decimal=true;
                        keep=true;
                        c='.';
                    }
                    if (c==',' && this.decimal==Decimal.COMMA) {
                        decimal=true;
                        keep=true;
                        c='.';
                    }
                    if (keep) {
                        if (start==bits.length) {
                            skip=true;
                        }
                    }
                }
            }
            
            if (!keep) {
                char match='\0';
                if (grouping==Group.COMMA) match=',';
                if (grouping==Group.HYPHEN) match='-';
                if (grouping==Group.PERIOD) match='.';
                if (grouping==Group.SPACE) match=' ';
                if (match==c) {
                    skip=true;
                } else {
                    return errorString();
                }
            }
            
            if (keep) {
                if (!skip) {
                    bits[--start]=c;
                }
            }
        }

        // remove leading zeros
        while (start<bits.length) {
            if (bits[start]=='0' ) {
                start++;
            } else {
                break;
            }
        }
        
        // add '0' infront of dot
        if (start<bits.length) {
            if (bits[start]=='.') {
                bits[--start]='0';
            }
        }

        // zero pad NONE decimal encoding
        if (this.decimal==Decimal.NONE && !decimal) {
            while (bits.length-start<this.decimalSize+1) {
                bits[--start]='0';
            }
        } else {
            if (start==bits.length) {
                bits[--start]='0';
            }
        }

        // add minus sign
        if (minus) {
            
            boolean zero=true;
            for (int scan=start;scan<bits.length;scan++) {
                if (bits[scan]!='0' && bits[scan]!='.') {
                    zero=false;
                    break;
                }
            }
            if (!zero) {
                bits[--start]='-';
            }
        }
        
        String result = new String(bits,start,bits.length-start);
        
        if (this.decimal==Decimal.NONE && !decimal) {
            result=result.substring(0,result.length()-decimalSize)+"."+
                result.substring(result.length()-decimalSize);
        }
        
        return result;
    }

    @Override
    public String format(String input) {
        
        clearError();
        
        input=deformat(input);
        if (isError()) return input;
        
        if (blank) {
            boolean zero=true;
            for (int scan=0;scan<input.length();scan++) {
                char c = input.charAt(scan);
                if (c!='0' && c!='.') {
                    zero=false;
                    break;
                }
            }
            if (zero) {
                char b[]=new char[length];
                for (int scan=0;scan<b.length;scan++) {
                    b[scan]=' ';
                }
                return new String(b);
            }
        }

        String full = input;
        
        boolean minus=false;
        if (input.startsWith("-")) {
            minus=true;
            input=input.substring(1);
            if (isStrict()) {
                if (leadSign==Sign.NONE && trailSign==Sign.NONE) {
                    return errorString();
                }
            }
        }
        
        String main=input;
        String fraction="";
        
        int dpos = main.indexOf('.');
        if (dpos>=0) {
            fraction=main.substring(dpos+1);
            main=main.substring(0,dpos);
            if (main.length()==0) main="0";
        }
        
        if (fraction.length()>decimalSize) {
            if (isStrict()) {
                return errorString();
            }
            
            BigDecimal d = new BigDecimal(full);
            d=d.setScale(decimalSize,BigDecimal.ROUND_HALF_UP);
            return format(d.toString());
        }
        
        char result[]=new char[length];
        int start=result.length;
        
        // trailing currency
        for (int scan=trailCurrency.length()-1;scan>=0;scan--) {
            if (start==0) return errorString();
            result[--start]=trailCurrency.charAt(scan);
        }
        
        // trailing sign
        if (minus) {
            if (paranthesis) {
                if (start==0) return errorString();
                result[--start]=')';
            } else {
                if (trailSign==Sign.MINUS || trailSign==Sign.PLUS) {
                    if (start==0) return errorString();
                    result[--start]='-';
                }
            }
        } else {
            if (trailSign==Sign.PLUS) {
                if (start==0) return errorString();
                result[--start]='+';
            }
        }
        
        //decimal padding
        for (int scan=fraction.length();scan<decimalSize;scan++) {
            if (start==0) return errorString();
            result[--start]='0';
        }

        // decimal
        for (int scan=fraction.length()-1;scan>=0;scan--) {
            if (start==0) return errorString();
            result[--start]=fraction.charAt(scan);
        }
        
        // decimal separator
        if (decimal==Decimal.COMMA) {
            if (start==0) return errorString();
            result[--start]=',';
        }
        if (decimal==Decimal.PERIOD) {
            if (start==0) return errorString();
            result[--start]='.';
        }

        // predetermine how much space we have to work with
        int leadConsume=0;
        if (minus) {
            if (paranthesis) {
                leadConsume++;
            } else {
                if (leadSign==Sign.MINUS || leadSign==Sign.PLUS) leadConsume++;
            }
        } else {
            if (leadSign==Sign.PLUS) leadConsume++;
        }
        leadConsume+=leadCurrency.length();
        
        // primary number with grouping 
        
        int primaryScan=main.length()-1;
        
        int count=0;
        
        while ( true ) {
            
            if (fill==Fill.NONE) {
                if (primaryScan<0) break;
            } 
            if (start<=leadConsume) break;
            
            char c;
            if (primaryScan>=0) {
                c=main.charAt(primaryScan--);
            } else {
                c=' ';
                if (fill==Fill.STAR) c='*';
                if (fill==Fill.ZERO) c='0';
            }
            
            count++;
            if (count==4 && grouping!=Group.NONE) {
                if (primaryScan<=0 && start-2<leadConsume) {
                    // skip first grouping if insufficient space
                    count=1;
                }
            }

            if (count==4 && grouping!=Group.NONE) {
                if (start==0) return errorString();
                if (grouping==Group.COMMA) result[--start]=',';
                if (grouping==Group.HYPHEN) result[--start]='-';
                if (grouping==Group.PERIOD) result[--start]='.';
                if (grouping==Group.SPACE) result[--start]=' ';
                count=1;
            }
            if (start==0) return errorString();
            result[--start]=c;
        }
        
        if (primaryScan>=0) return errorString();
        
        if (minus) {
            if (paranthesis) {
                if (start==0) return errorString();
                result[--start]='(';
            } else {
                if (leadSign==Sign.MINUS || leadSign==Sign.PLUS) {
                    if (start==0) return errorString();
                    result[--start]='-';
                }
            }
        } else {
            if (leadSign==Sign.PLUS) {
                if (start==0) return errorString();
                result[--start]='+';
            }
        }

        // leading currency
        for (int scan=leadCurrency.length()-1;scan>=0;scan--) {
            if (start==0) return errorString();
            result[--start]=leadCurrency.charAt(scan);
        }
        
        while (start>0) {
            result[--start]=' ';
        }
        
        return new String(result);
    }

    @Override
    public int getMaxLen() {
        return length;
    }

    private String errorString() {
        setError();
        char e[]=new char[length];
        for (int scan=0;scan<e.length;scan++) {
            e[scan]='#';
        }
        return new String(e);
    }

    @Override
    public String getPictureRepresentation() {

        boolean minus=(leadSign!=Sign.NONE || trailSign!=Sign.NONE);
        
        
        char result[]=new char[length];
        int start=result.length;
        
        // trailing currency
        for (int scan=trailCurrency.length()-1;scan>=0;scan--) {
            result[--start]=trailCurrency.charAt(scan);
        }
        
        // trailing sign
        if (minus) {
            if (paranthesis) {
                result[--start]=')';
            } else {
                if (trailSign==Sign.MINUS || trailSign==Sign.PLUS) {
                    result[--start]='-';
                }
            }
        } else {
            if (trailSign==Sign.PLUS) {
                result[--start]='+';
            }
        }
        
        //decimal padding
        for (int scan=0;scan<decimalSize;scan++) {
            if (start==0) return errorString();
            result[--start]='#';
        }

        // decimal separator
        if (decimal==Decimal.COMMA) {
            if (start==0) return errorString();
            result[--start]=',';
        }
        if (decimal==Decimal.PERIOD) {
            if (start==0) return errorString();
            result[--start]='.';
        }

        // predetermine how much space we have to work with
        int leadConsume=0;
        if (minus) {
            if (paranthesis) {
                leadConsume++;
            } else {
                if (leadSign==Sign.MINUS || leadSign==Sign.PLUS) leadConsume++;
            }
        } else {
            if (leadSign==Sign.PLUS) leadConsume++;
        }
        leadConsume+=leadCurrency.length();
        
        // primary number with grouping 
        
        int count=0;
        
        while ( true ) {
            
            if (start<=leadConsume) break;
            
            char c=count==0?'#':'<';
            count++;
            if (count==4 && grouping!=Group.NONE) {
                if (start-2<leadConsume) {
                    count=1;
                }
            }

            if (count==4 && grouping!=Group.NONE) {
                if (start==0) return errorString();
                if (grouping==Group.COMMA) result[--start]=',';
                if (grouping==Group.HYPHEN) result[--start]='-';
                if (grouping==Group.PERIOD) result[--start]='.';
                if (grouping==Group.SPACE) result[--start]=' ';
                count=1;
            }
            result[--start]=c;
        }
        
        if (minus) {
            if (paranthesis) {
                if (start==0) return errorString();
                result[--start]='(';
            } else {
                if (leadSign==Sign.MINUS || leadSign==Sign.PLUS) {
                    if (start==0) return errorString();
                    result[--start]='-';
                }
            }
        } else {
            if (leadSign==Sign.PLUS) {
                if (start==0) return errorString();
                result[--start]='+';
            }
        }

        // leading currency
        for (int scan=leadCurrency.length()-1;scan>=0;scan--) {
            if (start==0) return errorString();
            result[--start]=leadCurrency.charAt(scan);
        }
        
        while (start>0) {
            result[--start]=' ';
        }
        
        return new String(result);
    }
}
