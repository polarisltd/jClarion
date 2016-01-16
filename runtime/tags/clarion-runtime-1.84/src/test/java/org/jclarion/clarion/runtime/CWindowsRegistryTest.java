package org.jclarion.clarion.runtime;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.constants.Registry;
import org.jclarion.clarion.runtime.CWindowsRegistry.Result;

import junit.framework.TestCase;

public class CWindowsRegistryTest extends TestCase {

    public void setUp()
    {
        CWindowsRegistry.instance=new CWindowsRegistry()
        {
            @Override
            public Result run(String... args) {
                return assertRun(args);
            }
            
        };
    }
    
    public void tearDown()
    {
        CWindowsRegistry.instance=null;
    }
    
    public void testGet() {
        
        setRunAsserts(0,
                "! REG.EXE VERSION 3.0\n"+
                "\n"+
                "HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\n"+
                "   DevicePath  REG_EXPAND_SZ   %SystemRoot%\\inf\n",
                "reg","query","HKLM\\Software\\Microsoft\\Windows\\CurrentVersion","/v","DevicePath");
        
        ClarionNumber result=new ClarionNumber();
        assertEquals("%SystemRoot%\\inf",CWindowsRegistry.get(Registry.REG_LOCAL_MACHINE,"Software\\Microsoft\\Windows\\CurrentVersion","DevicePath",result));
        assertEquals(Registry.REG_EXPAND_SZ,result.intValue());

        setRunAsserts(0,
                "! REG.EXE VERSION 3.0\n"+
                "\n"+
                "HKEY_LOCAL_MACHINE\\Software\\NSIS\n"+
                "   <NO NAME>   REG_SZ  C:\\Program Files\\NSIS\n",
                "reg","query","HKLM\\Software\\NSIS","/ve");
        
        assertEquals("C:\\Program Files\\NSIS",CWindowsRegistry.get(Registry.REG_LOCAL_MACHINE,"Software\\NSIS",null,result));
        assertEquals(Registry.REG_SZ,result.intValue());

        setRunAsserts(0,
                "! REG.EXE VERSION 3.0\n"+
                "\n"+
                "HKEY_LOCAL_MACHINE\\Software\\NSIS\n"+
                "   <NO NAME>   REG_SZ  C:\\Program Files\\NSIS\n",
                "reg","query","HKLM\\Software\\NSIS","/ve");
        
        assertEquals("C:\\Program Files\\NSIS",CWindowsRegistry.get(Registry.REG_LOCAL_MACHINE,"Software\\NSIS","",result));
        assertEquals(Registry.REG_SZ,result.intValue());

        setRunAsserts(0,
                "! REG.EXE VERSION 3.0\n"+
                "\n"+
                "HKEY_LOCAL_MACHINE\\Software\\NSIS\n"+
                "   <NO NAME>   REG_SZ  C:\\Program Files\\NSIS\n",
                "reg","query","HKLM\\Software\\NSIS","/ve");
        
        assertEquals("C:\\Program Files\\NSIS",CWindowsRegistry.get(Registry.REG_LOCAL_MACHINE,"Software\\NSIS","",null));
        assertEquals(Registry.REG_SZ,result.intValue());

        setRunAsserts(0,
                "! REG.EXE VERSION 3.0\n"+
                "\n"+
                "HKEY_LOCAL_MACHINE\\Software\\NSIS\n"+
                "  SM_ConfigureProgramsExisted REG_DWORD       0x1\n",
                "reg","query","HKLM\\Software\\NSIS","/ve");
        
        assertEquals("1",CWindowsRegistry.get(Registry.REG_LOCAL_MACHINE,"Software\\NSIS","",result));
        assertEquals(Registry.REG_DWORD,result.intValue());

        setRunAsserts(0,
                "! REG.EXE VERSION 3.0\n"+
                "\n"+
                "HKEY_LOCAL_MACHINE\\Software\\NSIS\n"+
                "  SM_ConfigureProgramsExisted REG_DWORD       0x15\n",
                "reg","query","HKLM\\Software\\NSIS","/ve");
        
        assertEquals("21",CWindowsRegistry.get(Registry.REG_LOCAL_MACHINE,"Software\\NSIS","",result));
        assertEquals(Registry.REG_DWORD,result.intValue());
        
        setRunAsserts(0,
                "! REG.EXE VERSION 3.0\n"+
                "\n"+
                "HKEY_LOCAL_MACHINE\\Software\\NSIS\n"+
                "  SM_ConfigureProgramsExisted REG_BINARY       414243\n",
                "reg","query","HKLM\\Software\\NSIS","/ve");
        
        assertEquals("ABC",CWindowsRegistry.get(Registry.REG_LOCAL_MACHINE,"Software\\NSIS","",result));
        assertEquals(Registry.REG_BINARY,result.intValue());
        
        
    }

    public void testPut() {
        
        setRunAsserts(0,"Command Ran Successfully!\n",
                "reg","add","HKLM\\Software\\Test","/v","Item","/t","REG_SZ","/d","SomeValue","/f");
        assertEquals(0,CWindowsRegistry.put(Registry.REG_LOCAL_MACHINE,"Software\\Test","SomeValue","Item",null));

        setRunAsserts(3,"Error!\n",
                "reg","add","HKLM\\Software\\Test","/v","Item","/t","REG_DWORD","/d","SomeValue","/f");
        assertEquals(3,CWindowsRegistry.put(Registry.REG_LOCAL_MACHINE,"Software\\Test","SomeValue","Item",Registry.REG_DWORD));

        setRunAsserts(0,"Yep\n",
                "reg","add","HKLM\\Software\\Test","/ve","/t","REG_DWORD","/d","SomeValue","/f");
        assertEquals(0,CWindowsRegistry.put(Registry.REG_LOCAL_MACHINE,"Software\\Test","SomeValue",null,Registry.REG_DWORD));
    }

    public void testDelete() {
        setRunAsserts(0,"Command Ran Successfully!\n",
                "reg","delete","HKLM\\Software\\Test","/v","Item","/f");
        assertEquals(0,CWindowsRegistry.delete(Registry.REG_LOCAL_MACHINE,"Software\\Test","Item"));

        setRunAsserts(4,"Command Ran Successfully!\n",
                "reg","delete","HKCU\\Software\\Test","/ve","/f");
        assertEquals(4,CWindowsRegistry.delete(Registry.REG_CURRENT_USER,"Software\\Test",null));
    }
    
    private Result r;
    private String args[];
    
    public void setRunAsserts(int returnCode,String content,String ...args)
    {
        r=new Result(content,returnCode);
        this.args=args;
    }

    public Result assertRun(String ...args)
    {
        assertEquals(args.length,this.args.length);
        for (int scan=0;scan<args.length;scan++) {
            assertEquals(args[scan],this.args[scan]);
        }
        return r;
    }
}
