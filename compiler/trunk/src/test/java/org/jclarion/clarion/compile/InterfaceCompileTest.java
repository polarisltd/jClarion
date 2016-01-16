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
package org.jclarion.clarion.compile;


import org.jclarion.clarion.ClarionObject;

public class InterfaceCompileTest extends CompileTestHelper {

    public void testCompileDefinitionOnly()
    {
        compile(
                "    program\n",
                "myinterface  interface\n",
                "refresh   procedure\n",
                ".\n",
                "    code\n");
        
        assertNotNull(compiler.repository().get("Myinterface"));
    }

    public void testCompileDefinitionOnlyWithExplicitType()
    {
        compile(
                "    program\n",
                "myinterface  interface,type\n",
                "refresh   procedure,private\n",
                ".\n",
                "    code\n");
        
        assertNotNull(compiler.repository().get("Myinterface"));
    }
 
    public void testCompileDefinitionNested()
    {
        compile(
                "    program\n",
                "myinterface  interface,type\n",
                "refresh   procedure,private\n",
                ".\n",
                "myinterface2  interface(myinterface),type\n",
                "update   procedure(BYTE force)\n",
                ".\n",
                "    code\n");
        
        assertNotNull(compiler.repository().get("Myinterface"));
    }

    public void testCompileDefinitionInAClass()
    {
        compile(
                "    program\n",
                "myinterface  interface\n",
                "refresh   procedure\n",
                ".\n",
                "myclass   class,implements(myinterface)\n",
                "refresh procedure\n",
                ".\n",
                "    code\n");
        
        assertNotNull(compiler.repository().get("Myinterface"));

    }

    public void testCompileInterfaceDefined()
    {
        compile(
                "    program\n",
                "myinterface  interface\n",
                "refresh   procedure\n",
                ".\n",
                "myclass   class,implements(myinterface)\n",
                "refresh procedure\n",
                ".\n",
                "    code\n",
                "myclass.myinterface.refresh  procedure\n",
                "    code\n",
                "");
    }

    public void testCompileInterfaceReferencable()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "result   long\n",
                "pass     long\n",
                
                "myinterface  interface\n",
                "refresh   procedure,long\n",
                ".\n",
                
                "myclass   class,implements(myinterface)\n",
                "refresh procedure,long\n",
                ".\n",
                
                "    code\n",
                "    if pass<0 then result=myclass.myinterface.refresh().\n",
                "    if pass>0 then result=myclass.refresh().\n",
                
                "myclass.myinterface.refresh  procedure\n",
                "    code\n",
                "    return 1\n",
                
                "myclass.refresh  procedure\n",
                "    code\n",
                "    return 2\n",
                "");

        ClarionObject var = getMainVariable(cl,"pass");
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        var.setValue(-10);
        runClarionProgram(cl);
        assertEquals(1,getMainVariable(cl,"result").intValue());

        var.setValue(10);
        runClarionProgram(cl);
        assertEquals(2,getMainVariable(cl,"result").intValue());
    }

    
    public void testCompileInterfaceCanReferenceOwningClass()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "result   long\n",
                "pass     long\n",
                
                "myinterface  interface\n",
                "refresh   procedure(byte force),long\n",
                ".\n",
                
                "myclass   class,implements(myinterface)\n",
                "refresh procedure,long\n",
                ".\n",
                
                "    code\n",
                "    result=myclass.myinterface.refresh(pass)\n",
                
                "myclass.myinterface.refresh  procedure(force)\n",
                "    code\n",
                "    if force then return 1.\n",
                "    return self.refresh()\n",
                
                "myclass.refresh  procedure\n",
                "    code\n",
                "    return 2\n",
                "");

        ClarionObject var = getMainVariable(cl,"pass");
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        var.setValue(2);
        runClarionProgram(cl);
        assertEquals(1,getMainVariable(cl,"result").intValue());

        var.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,getMainVariable(cl,"result").intValue());
    }

    public void testCompileDeepInterface()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "result   long\n",
                "pass     long\n",
                
                "myinterface_r  interface\n",
                "refresh   procedure(byte force),long\n",
                ".\n",

                "myinterface  interface(myinterface_r)\n",
                ".\n",
                
                "myclass   class,implements(myinterface)\n",
                "refresh procedure,long\n",
                ".\n",
                
                "    code\n",
                "    result=myclass.myinterface.refresh(pass)\n",
                
                "myclass.myinterface.refresh  procedure(force)\n",
                "    code\n",
                "    if force then return 1.\n",
                "    return self.refresh()\n",
                
                "myclass.refresh  procedure\n",
                "    code\n",
                "    return 2\n",
                "");

        ClarionObject var = getMainVariable(cl,"pass");
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        var.setValue(2);
        runClarionProgram(cl);
        assertEquals(1,getMainVariable(cl,"result").intValue());

        var.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,getMainVariable(cl,"result").intValue());
    }

    public void testCompileDeepInterface2()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "result   long\n",
                "pass     long\n",
                
                "myinterface_r  interface\n",
                ".\n",

                "myinterface  interface(myinterface_r)\n",
                "refresh   procedure(byte force),long\n",
                ".\n",
                
                "myclass   class,implements(myinterface)\n",
                "refresh procedure,long\n",
                ".\n",
                
                "    code\n",
                "    result=myclass.myinterface.refresh(pass)\n",
                
                "myclass.myinterface.refresh  procedure(force)\n",
                "    code\n",
                "    if force then return 1.\n",
                "    return self.refresh()\n",
                
                "myclass.refresh  procedure\n",
                "    code\n",
                "    return 2\n",
                "");

        ClarionObject var = getMainVariable(cl,"pass");
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        var.setValue(2);
        runClarionProgram(cl);
        assertEquals(1,getMainVariable(cl,"result").intValue());

        var.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,getMainVariable(cl,"result").intValue());
    }

    public void testCompileDeepInterface3()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "result   long\n",
                "pass     long\n",
                
                "myinterface_r  interface\n",
                "refresh   procedure(byte force),long\n",
                ".\n",

                "myinterface  interface(myinterface_r)\n",
                "refresh   procedure(byte force),long\n",
                ".\n",
                
                "myclass   class,implements(myinterface)\n",
                "refresh procedure,long\n",
                ".\n",
                
                "    code\n",
                "    result=myclass.myinterface.refresh(pass)\n",
                
                "myclass.myinterface.refresh  procedure(force)\n",
                "    code\n",
                "    if force then return 1.\n",
                "    return self.refresh()\n",
                
                "myclass.refresh  procedure\n",
                "    code\n",
                "    return 2\n",
                "");

        ClarionObject var = getMainVariable(cl,"pass");
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        var.setValue(2);
        runClarionProgram(cl);
        assertEquals(1,getMainVariable(cl,"result").intValue());

        var.setValue(0);
        runClarionProgram(cl);
        assertEquals(2,getMainVariable(cl,"result").intValue());
    }
    
    
    public void testInteresting()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "result   long\n",
                "pass     long\n",
                
                "myinterface  interface\n",
                "refresh   procedure(),long\n",
                ".\n",
                
                "m1   class,implements(myinterface)\n",
                ".\n",

                "m2   class,implements(myinterface)\n",
                ".\n",

                "m3   class,implements(myinterface)\n",
                ".\n",
                
                "mi   &myinterface\n",
                
                "    code\n",
                "    execute pass\n",
                "      mi&=m1.myinterface\n",
                "      mi&=m2.myinterface\n",
                "      mi&=m3.myinterface\n",
                "    .\n",
                "    result=mi.refresh()\n",
                
                "m1.myinterface.refresh  procedure()\n",
                "    code\n",
                "    return 17\n",

                "m2.myinterface.refresh  procedure()\n",
                "    code\n",
                "    return 5\n",

                "m3.myinterface.refresh  procedure()\n",
                "    code\n",
                "    return 9\n",
                "");
                
        ClarionObject var = getMainVariable(cl,"pass");
        assertEquals(0,getMainVariable(cl,"result").intValue());
        
        var.setValue(1);
        runClarionProgram(cl);
        assertEquals(17,getMainVariable(cl,"result").intValue());

        var.setValue(2);
        runClarionProgram(cl);
        assertEquals(5,getMainVariable(cl,"result").intValue());

        var.setValue(3);
        runClarionProgram(cl);
        assertEquals(9,getMainVariable(cl,"result").intValue());
    }


    public void testCompileConflictingInterface()
    {
        compile(
            
        " program\n",
        
        "IEncoder            INTERFACE\n",
        "Encode               PROCEDURE(IMIMETarget MIMETarget,*CSTRING FilePath, *CSTRING FileName, BYTE Embedded=0)\n",
        "Encode               PROCEDURE(IMIMETarget MIMETarget,STRING Text,  *CSTRING FileName, BYTE Embedded=0)\n",
        "GetName              PROCEDURE(),STRING\n",
        "                    END\n",

        "myclass class,implements(iencoder),type\n",
        ".\n",

        "imimetarget interface\n",
        ".\n",
        
        "   code\n",
        
        "myclass.iencoder.Encode               PROCEDURE(IMIMETarget MIMETarget,*CSTRING FilePath, *CSTRING FileName, BYTE Embedded=0)\n",
        "    code\n",
        "    filename='fn'\n",

        "myclass.iencoder.Encode               PROCEDURE(IMIMETarget MIMETarget,STRING Text,  *CSTRING FileName, BYTE Embedded=0)\n",
        "    code\n",
        "    filename='fn'\n",
        
        "");
        
    }
    
}
