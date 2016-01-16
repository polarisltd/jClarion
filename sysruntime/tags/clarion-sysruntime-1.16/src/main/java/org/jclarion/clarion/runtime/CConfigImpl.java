package org.jclarion.clarion.runtime;

import java.util.Map;

public abstract class CConfigImpl 
{
    public abstract String getProperty(String section,String key);
    public abstract void setProperty(String section,String key,String value);
    public abstract Map<String,String> getProperties();
    
    public void finish() {
    }
}
