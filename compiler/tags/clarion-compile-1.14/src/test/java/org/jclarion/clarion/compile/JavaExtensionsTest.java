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


public class JavaExtensionsTest extends CompileTestHelper
{
    public void testImportIgnoresMethodsBasedOnAnnotation()
    {
        getSource().addLexer("test.inc",
                "",
                "  omit('java-end',java)\n",
                "   blah blah blah\n",
                "  java-end\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.AnnotatedClass'\n",
                "  java-end\n",
                "test string(20)\n");
                
                
                ClassLoader cl = compile(
                        "  program\n",
                        "  include('test.inc')\n",
                        "myclass AnnotatedClass\n",
                        "  code\n",
                        "  test=myclass.getClarionString()\n",
                        "  assert(test='World','#1')\n",
                        "  test=myclass.getString()\n",
                        "  assert(test='Hello','#2')\n",
                        ""
                        );
                
                runClarionProgram(cl);
    }
    
    public void testImportReturningMethodViaInclude()
    {

        getSource().addLexer("test.inc",
        "",
        "  omit('java-end',java)\n",
        "   blah blah blah\n",
        "  java-end\n",
        "  compile('java-end',java)\n",
        "  @java-import 'org.jclarion.clarion.compile.SimpleClass'\n",
        "  java-end\n",
        "test string(20)\n");
        
        
        ClassLoader cl = compile(
                "  program\n",
                "  include('test.inc')\n",
                "myclass SimpleClass\n",
                "  code\n",
                "  test=myclass.getClarionString()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getString()\n",
                "  assert(test='Hello','#2')\n",
                ""
                );
        
        runClarionProgram(cl);
    }
    
    
    public void testImportReturningMethod()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass'\n",
                "  java-end\n",
                "test string(20)\n",
                "myclass SimpleClass\n",
                "  code\n",
                "  test=myclass.getClarionString()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getString()\n",
                "  assert(test='Hello','#2')\n",
                ""
                );
        
        runClarionProgram(cl);
    }

    public void testImportOnDifferentModules()
    {
        getSource().addLexer("m1.clw",
                "   member\n",
                "   map\n",
                "m1   procedure,string\n",
                "   .\n",
                "m1  procedure\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass'\n",
                "myclass SimpleClass\n",
                "   code\n",
                "   return myclass.getString()\n",
                "");

        getSource().addLexer("m2.clw",
                "   member\n",
                "   map\n",
                "m2   procedure,string\n",
                "   .\n",
                "m2  procedure\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass'\n",
                "myclass SimpleClass\n",
                "   code\n",
                "   return myclass.getString()\n",
                "");
        
        
        ClassLoader cl = compile(
                "  program\n",
                "  map\n",
                "    module('m1.clw')\n",
                "m1  procedure,string\n",
                "    .\n",
                "    module('m2.clw')\n",
                "m2  procedure,string\n",
                "    .\n",
                "  .",
                "  code\n",
                "  assert(m1()='Hello','#1')\n",
                "  assert(m2()='Hello','#1')\n",
                ""
                );
        
        runClarionProgram(cl);
    }
    
    public void testImportReturningMethodAlternateCasing()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass'\n",
                "  java-end\n",
                "test string(20)\n",
                "myclass SimpleClass\n",
                "  code\n",
                "  test=myclass.GETCLARIONSTRING()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getstring()\n",
                "  assert(test='Hello','#2')\n",
                ""
                );
        
        runClarionProgram(cl);
    }

    public void testImportReturningMethodAlternateCasing2()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  map\n",
                "GETCLARIONSTRING procedure\n",
                "getstring procedure\n",
                "  .\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass'\n",
                "  java-end\n",
                "test string(20)\n",
                "myclass SimpleClass\n",
                "  code\n",
                "  GETCLARIONSTRING\n",
                "GETCLARIONSTRING procedure\n",
                "   code\n",
                "  test=myclass.GETCLARIONSTRING()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getstring()\n",
                "  assert(test='Hello','#2')\n",
                ""
                );
        
        runClarionProgram(cl);
    }

    public void testPassByReferenceAndVoidReturn()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass'\n",
                "  java-end\n",
                "test string(20)\n",
                "myclass SimpleClass\n",
                "  code\n",
                "  myclass.setstring(test)\n",
                "  assert(test='Blah','#1')\n",
                ""
                );
        
        runClarionProgram(cl);
    }

    public void testInheritance_A()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass2'\n",
                "  java-end\n",
                "test string(20)\n",
                "myclass SimpleClass\n",
                "  code\n",
                "  test=myclass.getClarionString()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getString()\n",
                "  assert(test='Hello','#2')\n",
                ""
                );
        
        runClarionProgram(cl);
    }

    public void testInheritance_B()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass2'\n",
                "  java-end\n",
                "test string(20)\n",
                "myclass SimpleClass2\n",
                "  code\n",
                "  test=myclass.getClarionString()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getString()\n",
                "  assert(test='HelloO','#2')\n",
                "  test=myclass.getString2()\n",
                "  assert(test='Hello2','#3')\n",
                ""
                );
        
        runClarionProgram(cl);
    }

    public void testInheritance_C()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass2'\n",
                "  java-end\n",
                "test string(20)\n",
                "myclass class(SimpleClass2)\n",
                "getstring3 procedure,string\n",
                ".\n",
                "  code\n",
                "  test=myclass.getClarionString()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getString()\n",
                "  assert(test='HelloO','#2')\n",
                "  test=myclass.getString2()\n",
                "  assert(test='Hello2','#3')\n",
                "  test=myclass.getString3()\n",
                "  assert(test='clarion','#4')\n",
                "myclass.getstring3 procedure\n",
                "  code\n",
                "  return 'clarion'\n",
                ""
                );
        
        runClarionProgram(cl);
    }

    public void testInheritance_D()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass2'\n",
                "  java-end\n",
                "test string(20)\n",
                "myclass &SimpleClass\n",
                "  code\n",
                "  myclass &= new simpleclass2\n",
                "  test=myclass.getClarionString()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getString()\n",
                "  assert(test='HelloO','#2')\n",
                "  myclass &= new simpleclass\n",
                "  test=myclass.getClarionString()\n",
                "  assert(test='World','#1')\n",
                "  test=myclass.getString()\n",
                "  assert(test='Hello','#2')\n",
                ""
                );
        
        runClarionProgram(cl);
    }
    
    public void testAccessFields()
    {
        ClassLoader cl = compile(
                "  program\n",
                "  compile('java-end',java)\n",
                "  @java-import 'org.jclarion.clarion.compile.SimpleClass2'\n",
                "  java-end\n",
                "myclass SimpleClass\n",
                "  code\n",
                "  myclass.mystring='World'\n",
                "  myclass.myclass &= new simpleclass\n",
                "  myclass.myclass.myclass &= new simpleclass\n",
                ""
                );
        
        SimpleClass sc = (SimpleClass)getMainObject(cl,"myclass");
        assertEquals("Hello",sc.myString.toString());
        assertNull(sc.myClass);
        
        runClarionProgram(cl);
        
        assertEquals("World",sc.myString.toString());
        assertNotNull(sc.myClass);
        assertNotNull(sc.myClass.myClass);
        assertNull(sc.myClass.myClass.myClass);
    }
}
