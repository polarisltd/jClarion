package org.jclarion.clarion.runtime;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.constants.Registry;
import org.jclarion.clarion.util.SharedWriter;

public class CWindowsRegistry 
{
    static CWindowsRegistry instance;

    private static String[] rootMapping = {
        "HKCR", // root
        "HKCU", // current user
        "HKLM", // local machine
        "HKU",  // users
        "???",  // performance
        "HKCC", // current config
        "???"   // dyn data
    };
    
    private static char[] toHex = "0123456789ABCDEF".toCharArray();

    private static String[] typeMapping = {
        "REG_NONE",
        "REG_SZ",
        "REG_EXPAND_SZ",
        "REG_BINARY",
        "REG_DWORD",
        "REG_DWORD_BIG_ENDIAN",
        "???", // link
        "REG_MULTI_SZ",
        "???", //resource
        "???", //requirements
        "???", //qword
        "???", //qword LE
    };
    
    private static String types="REG_SZ|REG_DWORD|REG_NONE|REG_MULTI_SZ|REG_BINARY|REG_EXPAND_SZ|REG_DWORD_BIG_ENDIAN|REG_DWORD_LITTLE_ENDIAN";
    
    private static Map<String,Integer> typeResolve;
    
    static {
        typeResolve=new HashMap<String,Integer>();
        typeResolve.put("REG_NONE",0);
        typeResolve.put("REG_SZ",1);
        typeResolve.put("REG_EXPAND_SZ",2);
        typeResolve.put("REG_BINARY",3);
        typeResolve.put("REG_DWORD",4);
        typeResolve.put("REG_DWORD_LITTLE_ENDIAN",4);
        typeResolve.put("REG_DWORD_BIG_ENDIAN",5);
        typeResolve.put("REG_MULTI_SZ",7);
    }
    
    private static Pattern keyExtract=Pattern.compile("^\\s+(.+?)\\s+("+types+")\\s+(.*)$",Pattern.MULTILINE);

    public static CWindowsRegistry instance()
    {
        if (instance==null) {
            synchronized(CWindowsRegistry.class) {
                if (instance==null) instance=new CWindowsRegistry();
            }
        }
        return instance;
    }
    
    public static class Result
    {
        public String result;
        public int    exitStatus;
        
        public Result(String result,int exitStatus)
        {
            this.result=result;
            this.exitStatus=exitStatus;
        }
    }
    
    public Result run(String ...args)
    {
        try {
            Process p = Runtime.getRuntime().exec(args);
            SharedWriter writer = new SharedWriter();
            BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
            char buffer[]=new char[128];
            while ( true ) {
                int len = br.read(buffer);
                if (len<=0) break;
                writer.write(buffer,0,len);
            }
            Result r= new Result(writer.toString(),p.waitFor());
            writer.close();
            return r;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        } catch (InterruptedException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    
    public static String get(int root,String key,String value,ClarionNumber valueType)
    {
        Result res = null;
        if (value!=null && value.trim().length()>0) {
            res=instance().run("reg","query",rootMapping[root-Registry.REG_FIRST]+"\\"+(key.trim()),"/v",value.trim());
        } else {
            res=instance().run("reg","query",rootMapping[root-Registry.REG_FIRST]+"\\"+(key.trim()),"/ve");
        }
        if (res==null) return "";
        String result=res.result;
        
        Matcher m = keyExtract.matcher(result); 
        if (!m.find()) return "";
        
        //String keyMatch = m.group(1); 
        String typeMatch = m.group(2); 
        String valueMatch = m.group(3);
        
        int type = typeResolve.get(typeMatch);
        if (valueType!=null) {
            valueType.setValue(type);
        }
        
        if (type==Registry.REG_DWORD || type==Registry.REG_DWORD_BIG_ENDIAN) {
            if (valueMatch.startsWith("0x")) {
                valueMatch=String.valueOf(Integer.parseInt(valueMatch.substring(2),16));
            }
        }

        if (type==Registry.REG_BINARY) {
            // decode hex
            StringBuilder writer = new StringBuilder();
            int scan=0;
            while (scan<valueMatch.length()) {
                writer.append((char) ( (fromHex(valueMatch.charAt(scan))<<4)+fromHex(valueMatch.charAt(scan+1)) ) );
                scan+=2;
            }
            valueMatch=writer.toString();
        }
        
        return valueMatch;
    }

    private static int fromHex(char charAt) {
        if (charAt>='0' && charAt<='9') return charAt-'0';
        if (charAt>='A' && charAt<='F') return charAt-'A'+10;
        if (charAt>='a' && charAt<='f') return charAt-'a'+10;
        return 0;
    }

    public static int put(int root,String key,String actualValue,String value,Integer valueType)
    {
        if (valueType==null) valueType=Registry.REG_SZ;
        
        if (valueType==Registry.REG_BINARY) {
            StringBuilder writer = new StringBuilder();
            for (int scan=0;scan<actualValue.length();scan++) {
                int v = actualValue.charAt(scan);
                writer.append(toHex[(v>>4)&15]);
                writer.append(toHex[(v)&15]);
            }
            actualValue=writer.toString();
        }
        
        Result r;
        if (value!=null) {
            r = instance().run("reg","add",
                    rootMapping[root-Registry.REG_FIRST]+"\\"+(key.trim()),
                    "/v",value.trim(),
                    "/t",typeMapping[valueType],
                    "/d",actualValue,
                    "/f");
        } else {
            r = instance().run("reg","add",
                    rootMapping[root-Registry.REG_FIRST]+"\\"+(key.trim()),
                    "/ve",
                    "/t",typeMapping[valueType],
                    "/d",actualValue,
                    "/f");
        }
        
        if (r==null) return -1;
        return r.exitStatus;
    }
    
    public static int delete(int root,String key,String value)
    {
        Result r;
        if (value!=null) {
            r = instance().run("reg","delete",
                    rootMapping[root-Registry.REG_FIRST]+"\\"+(key.trim()),
                    "/v",value.trim(),
                    "/f");
        } else {
            r = instance().run("reg","delete",
                    rootMapping[root-Registry.REG_FIRST]+"\\"+(key.trim()),
                    "/ve",
                    "/f");
        }
        
        if (r==null) return -1;
        return r.exitStatus;
    }
}
