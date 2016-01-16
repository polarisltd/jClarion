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

import java.sql.Connection;
import java.sql.SQLException;


import org.jclarion.clarion.jdbc.JDBCSource;


public class CompileRealFileTest extends CompileTestHelper
{
	public void tearDown()
	{
        JDBCSource.get("c8").close();
	}
	
    public void setUp()
    {
        super.setUp();
        try {
            JDBCSource.get("c8").getConnection().createStatement().execute("DROP TABLE testfranch");
        } catch (SQLException e) { }
        try {
            JDBCSource.get("c8").getConnection().createStatement().execute("DROP SEQUENCE testfranch_pk_seq");
        } catch (SQLException e) { }
        try {
            JDBCSource.get("c8").getConnection().createStatement().execute("DROP TABLE testdate");
        } catch (SQLException e) { }
    }
    
    public void testInit()
    {
        
            try {
                Connection c=JDBCSource.get("c8").getConnection();  

                c.createStatement().execute("CREATE SEQUENCE TESTFRANCH_PK_SEQ MINVALUE 1 INCREMENT BY 1 START WITH 200 CACHE 5 NO CYCLE;");
                c.createStatement().execute("CREATE TABLE TESTFRANCH ( CLID BIGINT DEFAULT nextval('TESTFRANCH_PK_SEQ'), LOCK SMALLINT, REFCODE SMALLINT, HEADER VARCHAR(30), FILENAME VARCHAR(8), ACCOUNTNUM VARCHAR(20), CREDCODE VARCHAR(10), PAYTAX VARCHAR(1), SPARE VARCHAR(1), DISCTRADE NUMERIC(5,2), USEMASTER VARCHAR(1), SPARE_2 SMALLINT, MARKUP1 NUMERIC(7,2), MARKUP2 NUMERIC(7,2), MARKUP3 NUMERIC(7,2), MARKUP4 NUMERIC(7,2), MARKUP5 NUMERIC(7,2), PRICEBRK1 NUMERIC(7,2), PRICEBRK2 NUMERIC(7,2), PRICEBRK3 NUMERIC(7,2), PRICEBRK4 NUMERIC(7,2), PRICEBRK5 NUMERIC(7,2), SWITCH_1 VARCHAR(1), SWITCH_2 VARCHAR(1), SWITCH_3 VARCHAR(1), SWITCH_4 VARCHAR(1), SWITCH_5 VARCHAR(1))");
                c.createStatement().execute("ALTER TABLE TESTFRANCH ADD PRIMARY KEY (CLID)");

                c.createStatement().execute("INSERT INTO TESTFRANCH (refcode,header) " +
                        "VALUES (11,'Honda'),(55,'Yamaha'),(4,'Suzuki')");
                
            } catch (SQLException e) {
                e.printStackTrace();
                fail(e.getMessage());
            }
    }
    
    public void testDatetime()
    {
        ClassLoader cl = compile(
                "   program\n",
                "Franch               FILE,DRIVER('ODBC'),OWNER('c8'),NAME('testdate'),PRE(PSI),BINDABLE\n",
                "PrimaryKey               KEY(PSI:ID),NAME('pkey'),PRIMARY\n",
                "dateKEY                  KEY(PSI:timeStampField),DUP,NAME('datekey'),OPT\n",
                "Record                   RECORD,PRE()\n",
                "id                          LONG,NAME('id')\n",
                "timeStampField              string(8),NAME('timeStampField')\n",
                "timeStampGroup				group,over(timeStampField)\n",
                "date						long\n",
                "time						long\n",
                ".\n",
                "                         END\n",
                "                     END\n",
                "\n",
                "   code\n",
                "   create(franch)\n",
                "   open(franch)\n",
                "   assert(errorcode()=0,'#1')\n",
                
                "   psi:id=1\n",
                "   psi:timeStampGroup.date=today()\n",
                "   psi:timeStampGroup.time=clock()\n",
                "   add(franch)\n",
                
                "   clear(franch)\n",
                "   assert(psi:timeStampGroup.date=0,'#2')\n",
                "   assert(psi:timeStampGroup.time=0,'#3')\n",

                "   set(psi:dateKEY)\n",
                "   next(franch)\n",
                "   assert(psi:timeStampGroup.date=today(),'#4')\n",
                "   assert(abs(psi:timeStampGroup.time-clock())<200,'#5')\n",
                "   next(franch)\n",
        "");
        
        runClarionProgram(cl);
    	
    }
    
    public void testKeyScan()
    {
        testInit();
        
        ClassLoader cl = compile(
                "   program\n",
                "Franch               FILE,DRIVER('ODBC'),OWNER('c8'),NAME('testfranch'),PRE(PSI),BINDABLE\n",
                "REFKEY                   KEY(PSI:REFCODE),NAME('refkey'),NOCASE,OPT,PRIMARY\n",
                "HEADERKEY                KEY(PSI:HEADER),DUP,NAME('headerkey'),NOCASE,OPT\n",
                "CREDKEY                  KEY(PSI:CREDCODE),DUP,NAME('credkey'),NOCASE,OPT\n",
                "Record                   RECORD,PRE()\n",
                "clid                        LONG,NAME('clid')\n",
                "LOCK                        BYTE,NAME('lock')\n",
                "REFCODE                     BYTE,NAME('refcode')\n",
                "HEADER                      STRING(30),NAME('header')\n",
                "FILENAME                    STRING(8),NAME('filename')\n",
                "ACCOUNTNUM                  STRING(20),NAME('accountnum')\n",
                "CREDCODE                    STRING(10),NAME('credcode')\n",
                "PAYTAX                      STRING(1),NAME('paytax')\n",
                "SPARE                       STRING(1),NAME('spare')\n",
                "DISCTRADE                   DECIMAL(5,2),NAME('disctrade')\n",
                "USEMASTER                   STRING(1),NAME('usemaster')\n",
                "SPARE_2                     BYTE,NAME('spare_2')\n",
                "MARKUP1                     DECIMAL(7,2),NAME('markup1')\n",
                "MARKUP2                     DECIMAL(7,2),NAME('markup2')\n",
                "MARKUP3                     DECIMAL(7,2),NAME('markup3')\n",
                "MARKUP4                     DECIMAL(7,2),NAME('markup4')\n",
                "MARKUP5                     DECIMAL(7,2),NAME('markup5')\n",
                "PRICEBRK1                   DECIMAL(7,2),NAME('pricebrk1')\n",
                "PRICEBRK2                   DECIMAL(7,2),NAME('pricebrk2')\n",
                "PRICEBRK3                   DECIMAL(7,2),NAME('pricebrk3')\n",
                "PRICEBRK4                   DECIMAL(7,2),NAME('pricebrk4')\n",
                "PRICEBRK5                   DECIMAL(7,2),NAME('pricebrk5')\n",
                "SWITCH_1                    STRING(1),NAME('switch_1')\n",
                "SWITCH_2                    STRING(1),NAME('switch_2')\n",
                "SWITCH_3                    STRING(1),NAME('switch_3')\n",
                "SWITCH_4                    STRING(1),NAME('switch_4')\n",
                "SWITCH_5                    STRING(1),NAME('switch_5')\n",
                "                         END\n",
                "                     END\n",
                "\n",
                "   code\n",
                "   open(franch)\n",
                "   assert(errorcode()=0,'#1')\n",
                
                "   set(psi:headerkey)\n",
                "   next(franch)\n",
                "   assert(psi:header='Honda','#2')\n",
                "   next(franch)\n",
                "   assert(psi:header='Suzuki','#3')\n",
                "   next(franch)\n",
                "   assert(psi:header='Yamaha','#4')\n",

                "   set(psi:headerkey)\n",
                "   next(franch)\n",
                "   assert(psi:header='Honda','#2')\n",
                "   next(franch)\n",
                "   assert(psi:header='Suzuki','#3')\n",
                "   next(franch)\n",
                "   assert(psi:header='Yamaha','#4')\n",
        "");
        
        runClarionProgram(cl);
    }
    
}
