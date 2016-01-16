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


public class ViewTest extends CompileTestHelper
{
    public void testSimpleViewCompile()
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
                
                "myView        view(notes)\n",
                "               project(mem:entitytype)\n",
                "               project(mem:entityid)\n",
                "   . \n",
                
                "   code\n",
                "");
        
    }
    
    
    public void testJoinA()
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
                
                "myView        view(notes)\n",
                "   join(vled:primarykey,mem:entityid)\n",
                "      project(vled:refkey)\n",
                "      project(vled:refvalue)\n",
                "   . \n",
                "   project(mem:entitytype)\n",
                "   project(mem:entityid)\n",
                "   . \n",
                
                "   code\n",
                "");
        
    }

    public void testJoinAWithInner()
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
                
                "myView        view(notes)\n",
                "   join(vled:primarykey,mem:entityid),inner\n",
                "      project(vled:refkey)\n",
                "      project(vled:refvalue)\n",
                "   . \n",
                "   project(mem:entitytype)\n",
                "   project(mem:entityid)\n",
                "   . \n",
                
                "   code\n",
                "");
        
    }

    public void testJoinB()
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
                
                "myView        view(notes)\n",
                "   join(browseledger_view,'vled:audit=mem:entityid')\n",
                "      project(vled:refkey)\n",
                "      project(vled:refvalue)\n",
                "   . \n",
                "   project(mem:entitytype)\n",
                "   project(mem:entityid)\n",
                "   . \n",
                
                "   code\n",
                "");
        
    }
    
}
