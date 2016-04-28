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

public abstract class Formatter 
{
    public static Formatter construct(String type) {
        if (type.length()<2) throw new IllegalArgumentException("Invalid picture:"+type);
        if (type.charAt(0)!='@') throw new IllegalArgumentException("Invalid picture:"+type);
        char c = type.charAt(1);
        if (c=='s' || c=='S') return new StringFormat(type);
        if (c=='n' || c=='N') return new NumberFormat(type);
        if (c=='d' || c=='D') return new DateFormat(type);
        if (c=='t' || c=='T') return new TimeFormat(type);
        if (c=='p' || c=='P') return new PatternFormat(type);
        if (c=='k' || c=='K') return new KeyinFormat(type);  // this is new picture in 6.2 or jclarion was not implemented before
        throw new IllegalArgumentException("Invalid picture:"+type);
    }
    
    public String picture;

    public Formatter(String picture)
    {
        this.picture=picture;
    }
    
    public String getPicture() {
        return picture;
    }
    
    
    public abstract String getPictureRepresentation();
    
    public abstract String format(String input);
    
    public abstract String deformat(String input);
    
    public abstract int getMaxLen();
    
    private boolean error;
    
    public void setError()
    {
        error=true;
    }

    public void clearError()
    {
        error=false;
    }
    
    public boolean isError()
    {
        return error;
    }
    
    private boolean strict;
    public void setStrictMode()
    {
        strict=true;
    }
    
    public boolean isStrict()
    {
        return strict;
    }

	public boolean isComputerCoded() {
		return false;
	}

}
