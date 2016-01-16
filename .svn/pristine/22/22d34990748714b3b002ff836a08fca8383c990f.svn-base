package org.jclarion.clarion.compile.java;

import org.jclarion.clarion.compile.prototype.Param;

public class JavaMethodPrototype 
{
    private String name;
    private String types[];
    private int code;
    
    public JavaMethodPrototype(String name,String ...types)
    {
        this.name=name;
        this.types=types;
    }
    
    public JavaMethodPrototype(String label, Param[] clashTest) 
    {
        this.name=label;
        this.types=new String[clashTest.length];
        for (int scan=0;scan<types.length;scan++) {
            types[scan]=clashTest[scan].getType().getName().toLowerCase();
        }
    }

    @Override
    public int hashCode()
    {
        if (code==0) {
            code=3+name.hashCode();
            for (String type : types ) {
                code=code*17+type.hashCode();
            }
        }
        return code;
    }
    
    public boolean equals(Object o)
    {
        if (o instanceof JavaMethodPrototype) {
            JavaMethodPrototype so= (JavaMethodPrototype)o;
            if (!name.equals(so.name)) return false;
            if (types.length!=so.types.length) return false;
            for (int scan=0;scan<types.length;scan++) {
                if (!types[scan].equals(so.types[scan])) return false;
            }
            return true;
        }
        return false;
    }

}
