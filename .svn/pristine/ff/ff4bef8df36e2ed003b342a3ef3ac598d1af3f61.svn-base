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


import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionObject;

/**
 * TODO - test structure is correct. Best way to do this is in
 * clarion itself - so need to wait until system functions
 * like add() etc come online
 * 
 * @author barney
 */
public class FileCompileTest extends CompileTestHelper {


    public void testCompileFile()
    {
        ClassLoader cl = compile(
        "       program\n",
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.testnotes'),PRE(MEM),BINDABLE,THREAD,CREATE\n",
        "entitykey                KEY(VMEM:entitytype,VMEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(VMEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n" +
        "       code\n",
        "       open(notes)\n",
        "       close(notes)\n",
        "");

        ClarionFile cf = (ClarionFile)getMainObject(cl,"notes");
        assertEquals("MEM",cf.getPrefix());
    }

    public void testKeyAccess()
    {
        ClassLoader cl = compile(
        "       program\n",
        "PROP:Keys               EQUATE (730FH)\n",
        "PROP:Key            EQUATE(7C6BH)  ! integer\n",
        "PROP:Components         EQUATE (731AH)\n",
        "PROP:Ascending          EQUATE (7320H)  ! Get order of key component n\n",
        "PROP:Field              EQUATE (731FH)  ! Get Field number of key component n\n",
        
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.notes'),PRE(MEM),BINDABLE,THREAD,CREATE\n",
        "entitykey                KEY(MEM:entitytype,MEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(MEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n" +
        "result  pstring(200)\n",
        "k &key\n",
        "       code\n",
        "       result = notes{prop:keys}&':'\n",
        "       loop i#=1 to notes{prop:keys}\n",
        "          k &= notes{prop:key,i#}\n",
        "          loop j#=1 to k{prop:components}\n",
        "             result=result&','&k{prop:field,j#}\n",
        "          .\n",
        "          result=result&'|'\n",
        "       .\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(result.toString(),"2:,3,4|,2|",result.toString());
    }
    
    public void testAccessRecord()
    {
        ClassLoader cl = compile(
        "       program\n",
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.notes'),PRE(MEM),BINDABLE,THREAD\n",
        "entitykey                KEY(MEM:entitytype,MEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(MEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n" +
        "result   long\n",
        "       code\n",
        "       result=size(mem:record)\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals(0,result.intValue());
        
        runClarionProgram(cl);
        assertEquals(1000+4+2+4+40,result.intValue());
    }

    public void testKeyViaProperty()
    {
        compile(
        "       program\n",
        
        "PROP:Key            EQUATE(7C6BH)  ! integer\n",
        
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.notes'),PRE(MEM),BINDABLE,THREAD\n",
        "entitykey                KEY(MEM:entitytype,MEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(MEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n" +
        "mykey  &KEY\n",
        "       code\n",
        "       mykey &= notes{prop:key,1}\n", 
        "");
    }
    
    public void testAccessNameProperty()
    {
        ClassLoader cl = compile(
        "       program\n",
        "PROP:Name               EQUATE (7316H) \n",
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.notes'),PRE(MEM),BINDABLE,THREAD\n",
        "entitykey                KEY(MEM:entitytype,MEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(MEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n" +
        "result   pstring(20)\n",
        "       code\n",
        "       result=notes{prop:name}\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("",result.toString());
        
        runClarionProgram(cl);
        assertEquals(result.toString(),"public.notes",result.toString());
    }

    
    public void testAccessKeyLabelProperty()
    {
        ClassLoader cl = compile(
        "       program\n",
        "PROP:Label               EQUATE (7317H) \n",
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.notes'),PRE(MEM),BINDABLE,THREAD\n",
        "entitykey                KEY(MEM:entitytype,MEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(MEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n" +
        "result   pstring(20)\n",
        "       code\n",
        "       result=mem:entitykey{prop:label}\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("",result.toString());
        
        runClarionProgram(cl);
        assertEquals(result.toString(),"entitykey",result.toString());
    }
    
    public void testAccessNamePropertyViaProcedure()
    {
        ClassLoader cl = compile(
        "       program\n",
        "PROP:Name               EQUATE (7316H) \n",
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.notes'),PRE(MEM),BINDABLE,THREAD\n",
        "entitykey                KEY(MEM:entitytype,MEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(MEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n" +
        "result   pstring(20)\n",
        
        "    map\n",
        "dotest procedure(File f)\n",
        "    .\n",
        "       code\n",
        "       dotest(notes)\n",
        "dotest procedure(f)\n",
        "       code\n",
        "       result=f{prop:name}\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("",result.toString());
        
        runClarionProgram(cl);
        assertEquals(result.toString(),"public.notes",result.toString());
    }
    
    
    public void testCompleFile2()
    {

        
        compile(
        "       program\n",
        "browseledger_view    FILE,DRIVER('ODBC'),OWNER('c8'),NAME('public.browseledger_view'),PRE(vled),BINDABLE\n",
        "datekey                  KEY(vled:date,vled:time,vled:audit),OPT\n",
        "primarykey               KEY(vled:audit),OPT,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "audit                       LONG,NAME('audit')\n",
        "tparent                     LONG,NAME('parent')\n",
        "date                        DATE,NAME('date')\n",
        "time                        TIME,NAME('time')\n",
        "status                      STRING(1),NAME('status')\n",
        "amount                      PDECIMAL(9,2),NAME('amount')\n",
        "gst                         PDECIMAL(9,2),NAME('gst')\n",
        "batype                      STRING(3),NAME('batype')\n",
        "type                        STRING(2),NAME('type')\n",
        "ext_type                    STRING(1),NAME('ext_type')\n",
        "ext_clid                    LONG,NAME('ext_clid')\n",
        "ext_desc                    STRING(20),NAME('ext_desc')\n",
        "clerk                       LONG,NAME('clerk')\n",
        "clerkcode                   STRING(6),NAME('clerkcode')\n",
        "accid                       LONG,NAME('accid')\n",
        "acccode                     STRING(10),NAME('acccode')\n",
        "refkey                      STRING(16),NAME('refkey')\n",
        "refvalue                    STRING(64),NAME('refvalue')\n",
        "repstatus                   BYTE,NAME('repstatus')\n",
        "                         END\n",
        "                     END\n",
        "   code\n",
        "");
        
    }
    
    public void testCompleFile3()
    {

        
        compile(
        "       program\n",
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.notes'),PRE(MEM),BINDABLE\n",
        "entitykey                KEY(MEM:entitytype,MEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(MEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n",
        "browseledger_view    FILE,DRIVER('ODBC'),OWNER('c8'),NAME('public.browseledger_view'),PRE(vled),BINDABLE\n",
        "datekey                  KEY(vled:date,vled:time,vled:audit),OPT\n",
        "primarykey               KEY(vled:audit),OPT,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "audit                       LONG,NAME('audit')\n",
        "tparent                     LONG,NAME('parent')\n",
        "date                        DATE,NAME('date')\n",
        "time                        TIME,NAME('time')\n",
        "status                      STRING(1),NAME('status')\n",
        "amount                      PDECIMAL(9,2),NAME('amount')\n",
        "gst                         PDECIMAL(9,2),NAME('gst')\n",
        "batype                      STRING(3),NAME('batype')\n",
        "type                        STRING(2),NAME('type')\n",
        "ext_type                    STRING(1),NAME('ext_type')\n",
        "ext_clid                    LONG,NAME('ext_clid')\n",
        "ext_desc                    STRING(20),NAME('ext_desc')\n",
        "clerk                       LONG,NAME('clerk')\n",
        "clerkcode                   STRING(6),NAME('clerkcode')\n",
        "accid                       LONG,NAME('accid')\n",
        "acccode                     STRING(10),NAME('acccode')\n",
        "refkey                      STRING(16),NAME('refkey')\n",
        "refvalue                    STRING(64),NAME('refvalue')\n",
        "repstatus                   BYTE,NAME('repstatus')\n",
        "                         END\n",
        "                     END\n",
        "   code\n",
        "");
        
    }

    public void testCompileResolveLike()
    {

        
        compile(
        "       program\n",
        "ODBCSource           String(20)\n",
        "\n",        
        "notes                FILE,DRIVER('ODBC'),OWNER(ODBCSource),NAME('public.notes'),PRE(MEM),BINDABLE\n",
        "entitykey                KEY(MEM:entitytype,MEM:entityid),DUP,NAME('entitykey'),NOCASE,OPT\n",
        "positionkey              KEY(MEM:clid),NAME('|READONLY'),NOCASE,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "notes                       STRING(1000),NAME('notes')\n",
        "clid                        LONG,NAME('clid')\n",
        "entitytype                  SHORT,NAME('entitytype')\n",
        "entityid                    LONG,NAME('entityid')\n",
        "description                 STRING(40),NAME('description')\n",
        "                         END\n",
        "                     END\n",
        "browseledger_view    FILE,DRIVER('ODBC'),OWNER('c8'),NAME('public.browseledger_view'),PRE(vled),BINDABLE\n",
        "datekey                  KEY(vled:date,vled:time,vled:audit),OPT\n",
        "primarykey               KEY(vled:audit),OPT,PRIMARY\n",
        "Record                   RECORD,PRE()\n",
        "audit                       LONG,NAME('audit')\n",
        "tparent                     LONG,NAME('parent')\n",
        "date                        DATE,NAME('date')\n",
        "time                        TIME,NAME('time')\n",
        "status                      STRING(1),NAME('status')\n",
        "amount                      PDECIMAL(9,2),NAME('amount')\n",
        "gst                         PDECIMAL(9,2),NAME('gst')\n",
        "batype                      STRING(3),NAME('batype')\n",
        "type                        STRING(2),NAME('type')\n",
        "ext_type                    STRING(1),NAME('ext_type')\n",
        "ext_clid                    LONG,NAME('ext_clid')\n",
        "ext_desc                    STRING(20),NAME('ext_desc')\n",
        "clerk                       LONG,NAME('clerk')\n",
        "clerkcode                   STRING(6),NAME('clerkcode')\n",
        "accid                       LONG,NAME('accid')\n",
        "acccode                     STRING(10),NAME('acccode')\n",
        "refkey                      STRING(16),NAME('refkey')\n",
        "refvalue                    STRING(64),NAME('refvalue')\n",
        "repstatus                   BYTE,NAME('repstatus')\n",
        "                         END\n",
        "                     END\n",
        
        "result       like(mem:notes)\n",
        
        "   code\n",
        "");
        
    }
    
}
