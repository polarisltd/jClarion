package org.jclarion.clarion.compile.expr;

import java.util.HashMap;
import java.util.Map;

public class DanglingContainer {
    private Map<String,DanglingExprType> dangles=new HashMap<String, DanglingExprType>();
    

    public DanglingExprType find(String name)
    {
        return dangles.get(name.toLowerCase());
    }
    
    public DanglingExprType get(String name)
    {
        DanglingExprType det = dangles.get(name.toLowerCase());
        if (det==null) {
            det=new DanglingExprType(name);
            dangles.put(name.toLowerCase(),det);
        }
        return det;
    }
}
