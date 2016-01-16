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
package org.jclarion.clarion;

import java.sql.SQLException;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.jdbc.JDBCSource;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;

import junit.framework.TestCase;

public class ClarionSQLDateTest  extends TestCase 
{
    public class TestFile extends ClarionSQLFile
    {
        public ClarionKey datekey=Clarion.newKey("datekey").setPrimary().setOptional().setName("partkey");
        public ClarionKey cdatekey=Clarion.newKey("cdatekey").setPrimary().setOptional().setName("rpartkey").setNocase();
        public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setName("id");
        public ClarionString partnum=Clarion.newString(20).setEncoding(ClarionString.STRING).setName("partnum");
        public ClarionNumber created=Clarion.newNumber().setEncoding(ClarionNumber.DATE).setName("created");

        public TestFile()
        {
            setSource(Clarion.newString("mvntest"));
            setPrefix("Stk");
            setName("testdate");

            datekey.addAscendingField(created).addAscendingField(partnum);
            addKey(datekey);

            cdatekey.addDescendingField(created).addAscendingField(partnum);
            addKey(cdatekey);
            
            addVariable("id",id);
            addVariable("partnum",partnum);
            addVariable("created",created);
        }
    }

    
    public TestFile testFile;

    public void setUp() throws SQLException
    {
        //new org.jclarion.clarion.log.Debug();
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP TABLE testdate");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute(
            "CREATE TABLE TESTDATE ( ID BIGINT, PARTNUM VARCHAR(20), CREATED DATE )");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public void tearDown()
    {
        try {
            JDBCSource.get("mvntest").getConnection().close();
        } catch (SQLException ex) { }
    }

    public void testOptimizedNulls()
    {
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute(
            "ALTER TABLE TESTDATE ALTER COLUMN CREATED SET NOT NULL");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    
        testFile=new TestFile();
        testFile.open();

        Object[][] data = new Object[][] {
                new Object[] { 1,   "PARTA",    0 },
                new Object[] { 2,   "PARTB",    0 },
                new Object[] { 3,   "PARTC",    0 },
                new Object[] { 4,   "PARTD",    date(1969,7,16) },  // apollo 11
                new Object[] { 5,   "PARTA",    date(1969,11,14) }, // apollo 12
                new Object[] { 6,   "PARTB",    date(1971,1,31) },  // apollo 14
                new Object[] { 7,   "PARTC",    date(2001,6,6) },
                new Object[] { 8,   "PARTD",    date(2038,1,20) },  // day after 32bit apocalypse
                new Object[] { 9,   "PARTA",    date(2038,1,20) },  // day after 32bit apocalypse
                new Object[] { 10,   "PARTE",    date(2038,1,20) },  // day after 32bit apocalypse
        };
        
        for (int scan=0;scan<data.length;scan++) {
            testFile.id.setValue(data[scan][0]);
            testFile.partnum.setValue(data[scan][1]);
            testFile.created.setValue(data[scan][2]);
            testFile.add();
        }
        
        assertEquals(7,testFile.records());
        
        testFile.datekey.setStart();
        assertScan(1,new int[] { 4,5,6,7,9,8,10 });
        assertEquals("SELECT id,partnum,created FROM testdate ORDER BY created,partnum",testFile.getProperty(Prop.SQL).toString());
        assertScan(-1,new int[] { 8,9,7,6,5 });
        assertEquals("SELECT id,partnum,created FROM testdate WHERE (created<'2038-01-20' OR (created='2038-01-20' AND (partnum<'PARTE'))) ORDER BY created DESC,partnum DESC",testFile.getProperty(Prop.SQL).toString());
        testFile.datekey.set();
        assertScan(1,new int[] { 5,6,7,9,8,10 });        
        assertEquals("SELECT id,partnum,created FROM testdate WHERE (created>'1969-11-14' OR (created='1969-11-14' AND (partnum>='PARTA'))) ORDER BY created,partnum",testFile.getProperty(Prop.SQL).toString());
    }
    
    public void testAdd()
    {
        testFile=new TestFile();
        testFile.open();

        Object[][] data = new Object[][] {
                new Object[] { 1,   "PARTA",    0 },
                new Object[] { 2,   "PARTB",    0 },
                new Object[] { 3,   "PARTC",    0 },
                new Object[] { 4,   "PARTD",    date(1969,7,16) },  // apollo 11
                new Object[] { 5,   "PARTA",    date(1969,11,14) }, // apollo 12
                new Object[] { 6,   "PARTB",    date(1971,1,31) },  // apollo 14
                new Object[] { 7,   "PARTC",    date(2001,6,6) },
                new Object[] { 8,   "PARTD",    date(2038,1,20) },  // day after 32bit apocalypse
        };
        
        for (int scan=0;scan<data.length;scan++) {
            testFile.id.setValue(data[scan][0]);
            testFile.partnum.setValue(data[scan][1]);
            testFile.created.setValue(data[scan][2]);
            testFile.add();
        }
        
        assertEquals(8,testFile.records());
    }
    
    public void testScanUp()
    {
        testAdd();
        testFile.datekey.setStart();
        
        assertScan(1,new int[] { 1,2,3,4,5,6,7,8 });
    }

    public void testScanDown()
    {
        testAdd();
        testFile.datekey.setStart();
        
        assertScan(-1,new int[] { 8,7,6,5,4,3,2,1 });
    }

    public void testScanAround()
    {
        testAdd();
        testFile.datekey.setStart();
        
        assertScan(1,new int[] { 1,2,3,4,5,6,7,8 });
        assertScan(-1,new int[] { 7,6,5,4,3,2,1 });
    }

    public void testScanRKey2()
    {
        testAdd();
        testFile.cdatekey.setStart();
        assertScan(1,new int[] { 8,7,6,5 });
        testFile.cdatekey.set();
        assertScan(-1,new int[] { 5,6,7,8 });
        assertScan(-1,new int[] { });
        testFile.cdatekey.set();
        assertScan(-1,new int[] { 8 });
        testFile.cdatekey.set();
        assertScan(1,new int[] { 8,7,6,5,4,1,2 });
        testFile.cdatekey.set();
        assertScan(1,new int[] { 2,3 });
        testFile.cdatekey.set();
        assertScan(-1,new int[] { 3,2,1,4,5,6 });
    }

    public void testScanRKey2WithLimit()
    {
        testAdd();
        testFile.setLimit(10);
        testFile.cdatekey.setStart();
        assertScan(1,new int[] { 8,7,6,5 });
        testFile.cdatekey.set();
        assertScan(-1,new int[] { 5,6,7,8 });
        assertScan(-1,new int[] { });
        testFile.cdatekey.set();
        assertScan(-1,new int[] { 8 });
        testFile.cdatekey.set();
        assertScan(1,new int[] { 8,7,6,5,4,1,2 });
        testFile.cdatekey.set();
        assertScan(1,new int[] { 2,3 });
        testFile.cdatekey.set();
        assertScan(-1,new int[] { 3,2,1,4,5,6 });
    }
    
    public void testScanAroundWithRKey()
    {
        testAdd();
        testFile.cdatekey.setStart();
        
        assertScan(1,new int[] { 8,7,6,5,4,1,2,3 });
        assertScan(-1,new int[] { 2,1,4,5,6,7,8 });
        assertScan(-1,new int[] { });
    }

    
    public void testForwardFromAllPoints()
    {
        testAdd();
        testFile.datekey.setStart();
        
        assertScan(1,new int[] { 1,2,3,4,5,6,7,8 });
        
        for (int scan=1;scan<8;scan++) {
            int bits[];
            
            bits = new int[8-scan];
            for (int s=0;s<bits.length;s++) { bits[s]=7-s; }
            assertScan(-1,bits);
            
            for (int s=0;s<bits.length;s++) { bits[s]=s+scan+1; };
            assertScan(1,bits);
            
        }
    }

    public void testBackwardFromAllPoints()
    {
        testAdd();
        testFile.datekey.setStart();
        
        assertScan(-1,new int[] { 8,7,6,5,4,3,2,1 });
        
        for (int scan=1;scan<8;scan++) {
            int bits[];
            
            bits = new int[8-scan];
            for (int s=0;s<bits.length;s++) { bits[s]=s+2; }
            assertScan(1,bits);
            
            for (int s=0;s<bits.length;s++) { bits[s]=8-scan-s; };
            assertScan(-1,bits);
            
        }
    }

    public void testFromArbitraryPoints()
    {
        testAdd();
        
        Object[][] data = new Object[][] {
                new Object[] { 0,"",new int[] {1,2,3,4,5,6,7,8} , new int[] { } },
                new Object[] { 0,"PARTB1",new int[] {3,4,5,6,7,8}, new int[] {2,1} },
                new Object[] { 0,"PARTB",new int[] {2,3,4,5,6,7,8}, new int[] {2,1} },
                new Object[] { date(1969,7,15),"",new int[] {4,5,6,7,8}, new int[] {3,2,1} },
                new Object[] { date(1969,7,15),"PARTE",new int[] {4,5,6,7,8}, new int[] {3,2,1} },
                new Object[] { date(1969,7,16),"",new int[] {4,5,6,7,8}, new int[] {3,2,1} },
                new Object[] { date(1969,7,16),"PARTD",new int[] {4,5,6,7,8}, new int[] {4,3,2,1} },
                new Object[] { date(1969,7,16),"PARTE",new int[] {5,6,7,8}, new int[] {4,3,2,1} },
                new Object[] { date(1969,7,17),"",new int[] {5,6,7,8}, new int[] {4,3,2,1} },
        };

        for (Object[] content : data ) {
            testFile.clear();
            testFile.created.setValue(content[0]);
            testFile.partnum.setValue(content[1]);
            testFile.datekey.set();

            assertScan(1,(int[])content[2]);
            testFile.next();
            assertEquals(33,CError.errorCode());

            testFile.clear();
            testFile.created.setValue(content[0]);
            testFile.partnum.setValue(content[1]);
            testFile.datekey.set();
            assertScan(-1,(int[])content[3]);
            testFile.previous();
            assertEquals(33,CError.errorCode());
        }
    }
    
    

    private void assertScan(int i, int[] vals) 
    {
        for ( int test : vals ) {
            if (i>0) {
                testFile.next();
            } else {
                testFile.previous();
            }
            assertEquals(0,CError.errorCode());
            assertEquals(test,testFile.id.intValue());
        }
    }

    private int date(int year,int month,int day)
    {
        return CDate.date(month,day,year);
    }
}
