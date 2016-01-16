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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;
import java.util.Set;

import org.jclarion.clarion.jdbc.JDBCSource;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.constants.*;

import junit.framework.TestCase;

public class ClarionSQLFileSQLASCIITest extends TestCase {

    public class TestFile extends ClarionSQLFile
    {
        public ClarionKey partkey=Clarion.newKey("partkey").setPrimary().setOptional().setName("partkey");
        public ClarionKey rpartkey=Clarion.newKey("rpartkey").setPrimary().setOptional().setName("rpartkey").setNocase();
        public ClarionKey positionkey=Clarion.newKey("positionkey");
        public ClarionKey desckey=Clarion.newKey("desckey").setNocase().setOptional().setName("desckey").setDuplicate();
        public ClarionKey suppkey=Clarion.newKey("suppkey").setOptional().setName("suppkey");
        public ClarionKey partnumkey=Clarion.newKey("partnumkey").setOptional().setName("partnumkey");
        public ClarionString remarks=Clarion.newString(300).setEncoding(ClarionString.STRING).setName("remarks");
        public ClarionNumber clid=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setName("clid");
        public ClarionNumber lock=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).setName("lock");
        public ClarionString partnum=Clarion.newString(20).setEncoding(ClarionString.STRING).setName("partnum");
        public ClarionNumber franchise=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).setName("franchise");
        public ClarionString format=Clarion.newString(20).setEncoding(ClarionString.STRING).setName("format");
        public ClarionString superS=Clarion.newString(20).setEncoding(ClarionString.STRING).setName("supers");
        public ClarionString header=Clarion.newString(30).setEncoding(ClarionString.STRING).setName("header");
        public ClarionString suppcode=Clarion.newString(10).setEncoding(ClarionString.STRING).setName("suppcode");
        public ClarionString typecode=Clarion.newString(10).setEncoding(ClarionString.STRING).setName("typecode");
        public ClarionString suppreordno=Clarion.newString(20).setEncoding(ClarionString.STRING).setName("suppreordno");
        public ClarionNumber created=Clarion.newNumber().setEncoding(ClarionNumber.DATE).setName("created");
        public ClarionNumber ctime=Clarion.newNumber().setEncoding(ClarionNumber.TIME).setName("ctime");
        public ClarionString location=Clarion.newString(6).setEncoding(ClarionString.STRING).setName("location");
        public ClarionString explodes=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("explodes");
        public ClarionString group=Clarion.newString(2).setEncoding(ClarionString.STRING).setName("fgroup");
        public ClarionString headerhld=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("headerhld");
        public ClarionString retailhld=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("retailhld");
        public ClarionNumber minqty=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("minqty");
        public ClarionNumber maxqty=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("maxqty");
        public ClarionNumber ecordqty=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("ecordqty");
        public ClarionNumber packqty=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("packqty");
        public ClarionNumber qtyonhand=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtyonhand");
        public ClarionNumber qtysuppord=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtysuppord");
        public ClarionNumber qtycustord=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtycustord");
        public ClarionNumber lqtyord=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("lqtyord");
        public ClarionNumber lqtyrec=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("lqtyrec");
        public ClarionNumber lorddate=Clarion.newNumber().setEncoding(ClarionNumber.DATE).setName("lorddate");
        public ClarionNumber lordnum=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setName("lordnum");
        public ClarionNumber linvdate=Clarion.newNumber().setEncoding(ClarionNumber.DATE).setName("linvdate");
        public ClarionString linvnum=Clarion.newString(10).setEncoding(ClarionString.STRING).setName("linvnum");
        public ClarionNumber lastrecno=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setName("lastrecno");
        public ClarionDecimal tax=Clarion.newDecimal(5,2).setEncoding(ClarionDecimal.DECIMAL).setName("tax");
        public ClarionDecimal dailydisc=Clarion.newDecimal(5,2).setEncoding(ClarionDecimal.DECIMAL).setName("dailydisc");
        public ClarionDecimal stockdisc=Clarion.newDecimal(5,2).setEncoding(ClarionDecimal.DECIMAL).setName("stockdisc");
        public ClarionDecimal retprice=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("retprice");
        public ClarionDecimal list=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("list");
        public ClarionDecimal lastincost=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("lastincost");
        public ClarionDecimal valathand=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("valathand");
        public ClarionDecimal valuesold=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("valuesold");
        public ClarionNumber qtyjan=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtyjan");
        public ClarionNumber qtyfeb=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtyfeb");
        public ClarionNumber qtymar=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtymar");
        public ClarionNumber qtyapr=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtyapr");
        public ClarionNumber qtymay=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtymay");
        public ClarionNumber qtyjun=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtyjun");
        public ClarionNumber qtyjul=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtyjul");
        public ClarionNumber qtyaug=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtyaug");
        public ClarionNumber qtysep=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtysep");
        public ClarionNumber qtyoct=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtyoct");
        public ClarionNumber qtynov=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtynov");
        public ClarionNumber qtydec=Clarion.newNumber().setEncoding(ClarionNumber.SHORT).setName("qtydec");

        public TestFile()
        {
            setSource(Clarion.newString("mvntest_sqlascii"));
            setPrefix("Stk");
            setName("public.teststock");

            partkey.addAscendingField(franchise).addAscendingField(partnum);
            addKey(partkey);

            rpartkey.addAscendingField(franchise).addDescendingField(partnum);
            addKey(rpartkey);
            
            positionkey.addAscendingField(clid);
            addKey(positionkey);

            desckey.addAscendingField(franchise).addAscendingField(header);
            addKey(desckey);

            suppkey.addAscendingField(franchise).addAscendingField(suppcode).addAscendingField(partnum);
            addKey(suppkey);

            partnumkey.addAscendingField(partnum).addAscendingField(franchise);
            addKey(partnumkey);

            addVariable("remarks",remarks);
            addVariable("clid",clid);
            addVariable("lock",lock);
            addVariable("partnum",partnum);
            addVariable("franchise",franchise);
            addVariable("format",format);
            addVariable("supers",superS);
            addVariable("header",header);
            addVariable("suppcode",suppcode);
            addVariable("typecode",typecode);
            addVariable("suppreordno",suppreordno);
            addVariable("created",created);
            addVariable("location",location);
            addVariable("ctime",ctime);
            addVariable("explodes",explodes);
            addVariable("group",group);
            addVariable("headerhld",headerhld);
            addVariable("retailhld",retailhld);
            addVariable("minqty",minqty);
            addVariable("maxqty",maxqty);
            addVariable("ecordqty",ecordqty);
            addVariable("packqty",packqty);
            addVariable("qtyonhand",qtyonhand);
            addVariable("qtysuppord",qtysuppord);
            addVariable("qtycustord",qtycustord);
            addVariable("lqtyord",lqtyord);
            addVariable("lqtyrec",lqtyrec);
            addVariable("lorddate",lorddate);
            addVariable("lordnum",lordnum);
            addVariable("linvdate",linvdate);
            addVariable("linvnum",linvnum);
            addVariable("lastrecno",lastrecno);
            addVariable("tax",tax);
            addVariable("dailydisc",dailydisc);
            addVariable("stockdisc",stockdisc);
            addVariable("retprice",retprice);
            addVariable("list",list);
            addVariable("lastincost",lastincost);
            addVariable("valathand",valathand);
            addVariable("valuesold",valuesold);
            addVariable("qtyjan",qtyjan);
            addVariable("qtyfeb",qtyfeb);
            addVariable("qtymar",qtymar);
            addVariable("qtyapr",qtyapr);
            addVariable("qtymay",qtymay);
            addVariable("qtyjun",qtyjun);
            addVariable("qtyjul",qtyjul);
            addVariable("qtyaug",qtyaug);
            addVariable("qtysep",qtysep);
            addVariable("qtyoct",qtyoct);
            addVariable("qtynov",qtynov);
            addVariable("qtydec",qtydec);
        }
    }

    
    public TestFile testFile;

    public void setUp() throws SQLException
    {
        try {
            JDBCSource.get("mvntest_sqlascii").getConnection().createStatement().execute("DROP TABLE teststock");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        try {
            JDBCSource.get("mvntest_sqlascii").getConnection().createStatement().execute("DROP SEQUENCE teststock_pk_seq");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public void tearDown()
    {
        if (testFile!=null) {
            testFile.close();
        }
        //ClarionFile.closeEverything();
        try {
            JDBCSource.get("mvntest_sqlascii").getConnection().close();
        } catch (SQLException e) {
        }
    }

    /**
     * This test verifies that strings written are not encoded using UTF-8 
     * 
     * @throws SQLException
     */
    public void testBinaryString() throws SQLException
    {
        testFile=new TestFile();
        testFile.create();
        assertEquals(0,CError.errorCode());
        testFile.open();
        assertEquals(0,CError.errorCode());

        Connection c = JDBCSource.get("mvntest_sqlascii").getConnection();
        try {
            Statement s = c.createStatement();
            try {
                for (char scan=1;scan<256;scan++) {
                    s.execute("DELETE From teststock");
                    
                    String test = "Some"+scan+"Awesome String";
                    
                    testFile.franchise.setValue(1);
                    testFile.clid.setValue(1);
                    testFile.header.setValue(test);
                    testFile.add();
                    assertEquals(0,CError.errorCode());
                    
                    if (scan==1) System.out.println(testFile.getProperty(Prop.SQL));
        
                    ResultSet rs = null; 
                    rs = s.executeQuery("SELECT header from teststock");
                    try {
                        assertTrue(rs.next());
                        byte btest[] = rs.getBytes(1);
                        assertEquals("("+(int)scan+")",19,btest.length);
                        for (int s2=0;s2<19;s2++) {
                            assertEquals(btest[s2]&0xff,test.charAt(s2));
                        }
                    } finally {
                        rs.close();
                    }
                    
                    testFile.clear();
                    testFile.set();
                    testFile.next();
                    assertEquals(""+scan,test,testFile.header.toString().trim());
                }
            } finally {
                s.close();
            }
        } finally {
            c.close();
        }

        
    }
    
    public void testReadBinaryStringWithUTF8Encoding() throws SQLException
    {
        testFile=new TestFile();
        testFile.create();
        assertEquals(0,CError.errorCode());
        testFile.open();
        assertEquals(0,CError.errorCode());

        Connection c = JDBCSource.get("mvntest_sqlascii").getConnection();
        try {
            Statement s = c.createStatement();
            try {
                for (char scan=1;scan<256;scan++) {
                    s.execute("DELETE From teststock");

                    String test = "Some"+scan+"Awesome String";
                    PreparedStatement ps = c.prepareStatement("INSERT into teststock (clid,franchise,header) values (1,1,?)");
                    try {
                        ps.setString(1,test);
                        ps.execute();
                    } finally {
                        ps.close();
                    }
                    
                    ResultSet rs = null; 
                    rs = s.executeQuery("SELECT header from teststock");
                    try {
                        assertTrue(rs.next());
                        byte btest[] = rs.getBytes(1);
                        // verify that we are indeed encoding with UTF-8
                        if (scan>127) {
                            assertEquals(20,btest.length);
                        } else {
                            assertEquals(19,btest.length);
                            for (int s2=0;s2<19;s2++) {
                                assertEquals(btest[s2]&0xff,test.charAt(s2));
                            }
                        }
                    } finally {
                        rs.close();
                    }
                    
                    testFile.clear();
                    testFile.set();
                    testFile.next();
                    assertEquals(""+scan,test,testFile.header.toString().trim());
                }
            } finally {
                s.close();
            }
        } finally {
            c.close();
        }

        
    }
    
    public void testAddThenPutPutsOnAddedRecord() throws SQLException
    {
        testFile=new TestFile();
        testFile.create();
        assertEquals(0,CError.errorCode());
        testFile.open();
        assertEquals(0,CError.errorCode());

        testFile.franchise.setValue(1);
        testFile.clid.setValue(1);
        testFile.add();
        assertEquals(0,CError.errorCode());
        
        testFile.partnumkey.setStart();
        testFile.previous();
        assertEquals(0,CError.errorCode());
        
        testFile.franchise.increment(1);
        testFile.clid.setValue(2);
        testFile.add();
        assertEquals(0,CError.errorCode());
        
        testFile.partnum.setValue("Test");
        testFile.put();
        assertEquals("UPDATE public.teststock SET partnum='Test' WHERE (franchise=2 AND partnum='')",testFile.getProperty(Prop.SQL).toString());
        assertEquals(0,CError.errorCode());

        testFile.partnumkey.setStart();
        testFile.next();
        assertEquals(1,testFile.franchise.intValue());
        assertEquals("",testFile.partnum.toString().trim());
        testFile.next();
        assertEquals(2,testFile.franchise.intValue());
        assertEquals("Test",testFile.partnum.toString().trim());
        testFile.next();
        assertEquals(33,CError.errorCode());
    }
    
    public void testCreate() throws SQLException
    {
        testFile=new TestFile();
        testFile.open();
        assertEquals(2,CError.errorCode());
        testFile.create();
        assertEquals(0,CError.errorCode());
        testFile.open();
        assertEquals(0,CError.errorCode());
        assertEquals(52,testFile.getFileState().changed.length);
        //assertEquals(52,testFile.getFileState().isnull.length);
        
        testFile.close();
        testFile.create();
        assertEquals(90,CError.errorCode());
        
        assertSQL("select 1 from pg_class where relname='teststock'");
        
        testFile.open();

        testFile.franchise.setValue(1);
        testFile.partnum.setValue("HI");
        testFile.add();
        assertEquals(0,CError.errorCode());

        assertEquals(1,testFile.records());

        testFile.clid.setValue(1);
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("HI");
        testFile.add();
        assertEquals(40,CError.errorCode());
        assertEquals(1,testFile.records());

        testFile.clid.setValue(2);
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("hi");
        testFile.add();
        assertEquals(40,CError.errorCode());
        assertEquals(1,testFile.records());

        testFile.partnum.setValue("hithere");
        testFile.add();
        assertEquals(0,CError.errorCode());
        assertEquals(2,testFile.records());
    }

    public void testInit()
    {
            try {
                Connection c=JDBCSource.get("mvntest_sqlascii").getConnection(); 
                c.createStatement().execute("CREATE SEQUENCE TESTSTOCK_PK_SEQ MINVALUE 1 INCREMENT BY 1 START WITH 200 CACHE 5 NO CYCLE;");
                c.createStatement().execute("CREATE TABLE TESTSTOCK ( CLID SERIAL NOT NULL, LOCK SMALLINT, PARTNUM VARCHAR(20), FRANCHISE SMALLINT, FORMAT VARCHAR(20), SUPERS CHAR(20), HEADER VARCHAR(30), SUPPCODE VARCHAR(10), TYPECODE VARCHAR(10), SUPPREORDNO VARCHAR(20), CREATED DATE, LOCATION VARCHAR(6), CTIME TIME, EXPLODES VARCHAR(1), FGROUP VARCHAR(2), HEADERHLD VARCHAR(1), RETAILHLD VARCHAR(1), MINQTY SMALLINT, MAXQTY SMALLINT, ECORDQTY SMALLINT, PACKQTY SMALLINT, QTYONHAND SMALLINT, QTYSUPPORD SMALLINT, QTYCUSTORD SMALLINT, LQTYORD SMALLINT, LQTYREC SMALLINT, LORDDATE DATE, LORDNUM BIGINT, LINVDATE DATE, LINVNUM VARCHAR(10), LASTRECNO BIGINT, TAX NUMERIC(5,2), DAILYDISC NUMERIC(5,2), STOCKDISC NUMERIC(5,2), RETPRICE NUMERIC(7,2), LIST NUMERIC(7,2), LASTINCOST NUMERIC(7,2), VALATHAND NUMERIC(7,2), VALUESOLD NUMERIC(7,2), QTYJAN SMALLINT, QTYFEB SMALLINT, QTYMAR SMALLINT, QTYAPR SMALLINT, QTYMAY SMALLINT, QTYJUN SMALLINT, QTYJUL SMALLINT, QTYAUG SMALLINT, QTYSEP SMALLINT, QTYOCT SMALLINT, QTYNOV SMALLINT, QTYDEC SMALLINT, SWITCH_1 VARCHAR(1), SWITCH_2 VARCHAR(1), SWITCH_3 VARCHAR(1), SWITCH_4 VARCHAR(1), SWITCH_5 VARCHAR(1), REMARKS text)");
                c.createStatement().execute("ALTER TABLE ONLY TESTSTOCK ADD PRIMARY KEY (CLID)");
                c.createStatement().execute("CREATE UNIQUE INDEX TESTSTOCK_PARTKEY_1 ON TESTSTOCK (FRANCHISE,PARTNUM)");
                c.createStatement().execute("commit");

            } catch (SQLException e) {
                e.printStackTrace();
                fail(e.getMessage());
            }
        testFile=new TestFile();
    }

    public void testKeyEquality()
    {
       TestFile tf = new TestFile();
       ClarionKey t;
       
       t=Clarion.newKey("test");
       t.addAscendingField(tf.franchise).addAscendingField(tf.partnum);
       tf.addKey(t);
       assertTrue(tf.partkey.equals(t));
       
       t=Clarion.newKey("test");
       t.addAscendingField(tf.franchise);
       tf.addKey(t);
       assertFalse(tf.partkey.equals(t));

       t=Clarion.newKey("test");
       t.addAscendingField(tf.franchise).addDescendingField(tf.partnum);
       tf.addKey(t);
       assertFalse(tf.partkey.equals(t));

       t=Clarion.newKey("test");
       t.addAscendingField(tf.franchise).addAscendingField(tf.partnum).addAscendingField(tf.created);
       tf.addKey(t);
       assertFalse(tf.partkey.equals(t));

       t=Clarion.newKey("test");
       t.addAscendingField(tf.franchise);
       t.addField(tf.partnum,false,null);
       tf.addKey(t);
       assertTrue(tf.partkey.equals(t));

       t=Clarion.newKey("test");
       t.addAscendingField(tf.franchise);
       t.addField(tf.partnum,false,"upper");
       tf.addKey(t);
       assertFalse(tf.partkey.equals(t));
       
       t=Clarion.newKey("test");
       t.addAscendingField(tf.franchise).addAscendingField(tf.partnum).addAscendingField(tf.created);
       t.setNocase();
       tf.addKey(t);
       assertFalse(tf.partkey.equals(t));
    }
    
    
    
    public void testGetDetails()
    {
        testInit();
        assertEquals("Stk:remarks",testFile.who(1).toString());
    }

    public void testOpen()
    {
        testInit();
        testFile.open();
        assertEquals(52,testFile.getFileState().changed.length);
        //assertEquals(52,testFile.getFileState().isnull.length);
    }

    public void testGetFileProperties() {
        testOpen();
        assertEquals(6,testFile.getProperty(Prop.KEYS).intValue());
        assertEquals("public.teststock",testFile.getProperty(Prop.NAME).toString());
        assertEquals("JDBC",testFile.getProperty(Prop.DRIVER).toString());
        assertEquals("mvntest_sqlascii",testFile.getProperty(Prop.OWNER).toString());
        assertEquals(52,testFile.getProperty(Prop.FIELDS).intValue());

        assertEquals("partkey",testFile.partkey.getProperty(Prop.LABEL).toString());
        assertEquals("Stk:remarks",testFile.getProperty(Prop.LABEL,1).toString());
        assertEquals("Stk:clid",testFile.getProperty(Prop.LABEL,2).toString());
        assertEquals("clid",testFile.getProperty(Prop.NAME,2).toString());
    }

    public void testGetKeyProperties() {
        testOpen();

        assertEquals(1,testFile.partkey.getProperty(Prop.PRIMARY).intValue());
        assertEquals(0,testFile.partkey.getProperty(Prop.DUP).intValue());
        assertEquals(1,testFile.desckey.getProperty(Prop.DUP).intValue());
        assertEquals(0,testFile.partkey.getProperty(Prop.NOCASE).intValue());

        assertEquals(2,testFile.partkey.getProperty(Prop.COMPONENTS).intValue());
        assertEquals(5,testFile.partkey.getProperty(Prop.FIELD,1).intValue());
        assertEquals(4,testFile.partkey.getProperty(Prop.FIELD,2).intValue());

        assertEquals("1",testFile.partkey.getProperty(Prop.ASCENDING,1).toString());
        assertEquals("1",testFile.partkey.getProperty(Prop.ASCENDING,2).toString());

        assertEquals("1",testFile.rpartkey.getProperty(Prop.ASCENDING,1).toString());
        assertEquals("",testFile.rpartkey.getProperty(Prop.ASCENDING,2).toString());
    } 

    public void testGetClarionKey() {
        testOpen();
        assertSame(testFile.partkey,testFile.getKey(Clarion.newNumber(1)));
        assertSame(testFile.rpartkey,testFile.getKey(Clarion.newNumber(2)));
        assertSame(testFile.positionkey,testFile.getKey(Clarion.newNumber(3)));
        assertSame(testFile.desckey,testFile.getKey(Clarion.newNumber(4)));
        assertSame(testFile.suppkey,testFile.getKey(Clarion.newNumber(5)));
        assertSame(testFile.partnumkey,testFile.getKey(Clarion.newNumber(6)));
        assertSame(null,testFile.getKey(Clarion.newNumber(7)));
    }
    
    public void testPutAfterResetNPEBug()
    {
        testOpen();
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("111");
        testFile.add();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("222");
        testFile.add();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("333");
        testFile.add();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("444");
        testFile.add();

        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        testFile.header.setValue("a");
        testFile.put();
        assertEquals(0,CError.errorCode());
        testFile.header.setValue("b");
        testFile.put();
        assertEquals(0,CError.errorCode());
    	
        testFile.partkey.setStart();
        testFile.next();
        testFile.partkey.setStart();
        testFile.header.setValue("c");
        testFile.put();
        assertEquals(33,CError.errorCode());
    }
    
    public void testNullPointerQuickScanBug()
    {
        testOpen();
        
        testFile.setQuickScan();
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("111");
        testFile.add();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("222");
        testFile.add();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("333");
        testFile.add();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("444");
        testFile.add();

        testFile.franchise.setValue(2);
        testFile.partkey.set();
        testFile.next();
        assertEquals(33,CError.errorCode());
        
        testFile.partkey.set();
        testFile.next();
        assertEquals(33,CError.errorCode());
        
    }
    
    public void testNoCaseKeys()
    {
        testOpen();
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("abc");
        testFile.add();
        testFile.franchise.setValue(2);
        testFile.partnum.setValue("ABC");
        testFile.add();
        testFile.franchise.setValue(3);
        testFile.partnum.setValue("abc");
        testFile.add();
        testFile.franchise.setValue(4);
        testFile.partnum.setValue("Ktm");
        testFile.add();
        
        testFile.partnumkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(1,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(3,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(2,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,testFile.franchise.intValue());
        testFile.next();
        assertEquals(33,CError.errorCode());
        
        testFile.clear();
        testFile.partnum.setValue("abc");
        testFile.partnumkey.set();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(1,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(3,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(2,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,testFile.franchise.intValue());
        testFile.next();
        assertEquals(33,CError.errorCode());

        testFile.clear();
        testFile.partnum.setValue("ABC");
        testFile.partnumkey.set();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(2,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,testFile.franchise.intValue());
        testFile.next();
        assertEquals(33,CError.errorCode());
        
        
        testFile.partnumkey.setNocase();
        testFile.partnumkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(1,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(2,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(3,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,testFile.franchise.intValue());
        testFile.next();
        assertEquals(33,CError.errorCode());

        testFile.clear();
        testFile.partnum.setValue("ABC");
        testFile.partnumkey.set();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(1,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(2,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(3,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,testFile.franchise.intValue());
        testFile.next();
        assertEquals(33,CError.errorCode());

        testFile.clear();
        testFile.partnum.setValue("abc");
        testFile.partnumkey.set();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(1,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(2,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(3,testFile.franchise.intValue());
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,testFile.franchise.intValue());
        testFile.next();
        assertEquals(33,CError.errorCode());
        

        ClarionKey testkey=Clarion.newKey("partnumkey").setOptional().setName("partnumkey").setNocase();
        testkey.addAscendingField(testFile.partnum);
        testFile.addKey(testkey);
        
        testFile.clear();
        testFile.partnum.setValue("ktm");
        testFile.get(testkey);
        assertEquals(0,CError.errorCode());
        assertEquals(4,testFile.franchise.intValue());
        
        testFile.clear();
        testFile.partnum.setValue("KTM");
        testFile.get(testkey);
        assertEquals(0,CError.errorCode());
        assertEquals(4,testFile.franchise.intValue());
    }
    
    public void testChange()
    {
        testInit();
        testFile.open();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TEST123");
        testFile.header.setValue("TEST-123");
        
        assertTrue(testFile.getFileState().changed[testFile.where(testFile.franchise)-1]);
        assertTrue(testFile.getFileState().changed[testFile.where(testFile.partnum)-1]);
        assertTrue(testFile.getFileState().changed[testFile.where(testFile.header)-1]);
        assertFalse(testFile.getFileState().changed[testFile.where(testFile.clid)-1]);
    }

    public void testAddNewlineIntoTextBlock()
    {
        testInit();
        testFile.open();
        assertEquals(0,testFile.records());
        assertEquals(0,testFile.records());
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TEST123");
        testFile.header.setValue("TEST-123\u0080");
        testFile.remarks.setValue("Some comments\nSome more comments\n");
        testFile.add();

        testFile.clear();
        testFile.set();
        testFile.next();

        assertEquals(1,testFile.franchise.intValue());
        assertEquals("TEST123",testFile.partnum.toString().trim());
        assertEquals("TEST-123\u0080",testFile.header.toString().trim());
        assertEquals("Some comments\nSome more comments",testFile.remarks.toString().trim());
        
    }

    public void testAddBinaryChars()
    {
        testInit();
        testFile.open();
        assertEquals(0,testFile.records());
        for (int scan=1;scan<256;scan++) {
            testFile.franchise.setValue(1);
            
            String lkup=String.valueOf(scan);
            while (lkup.length()<3) lkup="0"+lkup;
            
            testFile.partnum.setValue("TEST"+lkup);
            testFile.header.setValue("TEST-123:"+((char)scan));
            testFile.add();
            assertEquals(""+scan+" "+CError.error(),0,CError.errorCode());
        }
        assertEquals(255,testFile.records());

        testFile.clear();

        testFile.partkey.setStart();
        for (int scan=1;scan<256;scan++) {
            testFile.next();
            
            String lkup=String.valueOf(scan);
            while (lkup.length()<3) lkup="0"+lkup;
            
            assertEquals("TEST"+lkup,testFile.partnum.toString().trim());
            
            String val = "TEST-123:"+((char)scan);
            while (val.length()!=30) val=val+" ";
            
            assertEquals(""+scan+" "+val,val,testFile.header.toString());
        }
    }

    public void testOptimiseCursorBug() throws SQLException
    {
        testInit();
        testFile.open();
        assertEquals(0,testFile.records());
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TEST123");
        testFile.header.setValue("TEST-123");
        testFile.add();
        
        testFile.setProperty(Prop.SQL,"BEGIN");

        testFile.partnumkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());

        testFile.setProperty(Prop.SQL,"COMMIT");
        testFile.setProperty(Prop.SQL,"ROLLBACK");

        testFile.partnumkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());

        testFile.header.setValue("New Header");
        testFile.put();
        assertEquals(0,CError.errorCode());
        
        testFile.close();
        
        JDBCSource.get(testFile.getProperty(Prop.OWNER).toString().trim()).getConnection().close();

        testFile.open();
        testFile.partnumkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("New Header",testFile.header.toString().trim());
    }

    public void testManualBegin() throws SQLException
    {
        testInit();
        testFile.open();
        assertEquals(0,testFile.records());
        
        for (String test : new String[] { " Begin;  ", "begin","BEGIN","BEGIN;","beGIN  ; ",
                "start transaction","start   transaction ;"}) {
            testFile.setProperty(Prop.SQL, test);
            
            assertFalse(testFile.getFileState().global.source.getConnection().getAutoCommit());
            
            testFile.franchise.setValue(1);
            testFile.partnum.setValue("TEST123");
            testFile.header.setValue("TEST-123");
            testFile.add();
            assertEquals(0, CError.errorCode());
            testFile.setProperty(Prop.SQL, "rollback");
            
            assertTrue(testFile.getFileState().global.source.getConnection().getAutoCommit());
            
            assertEquals(0, testFile.records());
        }
    }

    public void testManualRollback() throws SQLException
    {
        testInit();
        testFile.open();
        assertEquals(0,testFile.records());
        
        for (String test : new String[] { " rollback;  ", "rollback","ROLLBACK","ROLLBACK;","rollBACK  ; "}) {
            testFile.setProperty(Prop.SQL, "begin");
            
            assertFalse(testFile.getFileState().global.source.getConnection().getAutoCommit());
            
            testFile.franchise.setValue(1);
            testFile.partnum.setValue("TEST123");
            testFile.header.setValue("TEST-123");
            testFile.add();
            assertEquals(0, CError.errorCode());
            testFile.setProperty(Prop.SQL, test);
            
            assertTrue(testFile.getFileState().global.source.getConnection().getAutoCommit());
            
            assertEquals(0, testFile.records());
        }
    }

    public void testManualCommit() throws SQLException
    {
        testInit();
        testFile.open();
        assertEquals(0,testFile.records());
        
        for (String test : new String[] { " commit;  ", "commit","COMMIT","COMMIT;","commIT  ; "}) {
            testFile.setProperty(Prop.SQL, "begin");
            
            assertFalse(testFile.getFileState().global.source.getConnection().getAutoCommit());
            
            testFile.franchise.setValue(1);
            testFile.partnum.setValue("TEST123");
            testFile.header.setValue("TEST-123");
            testFile.add();
            assertEquals(0, CError.errorCode());
            testFile.setProperty(Prop.SQL, test);
            
            assertTrue(testFile.getFileState().global.source.getConnection().getAutoCommit());
            testFile.setProperty(Prop.SQL, "rollback");
            
            assertEquals(1, testFile.records());
            testFile.setProperty(Prop.SQL, "delete from teststock;");
        }
    }
    
    public void testAdd()
    {
        testInit();
        testFile.open();
        assertEquals(0,testFile.records());
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TEST123");
        testFile.header.setValue("TEST-123");

        testFile.add();
        assertEquals(0,CError.errorCode());
        assertEquals(1,testFile.records());

        testFile.add();
        assertEquals(Constants.DUPKEYERR,CError.errorCode());
        assertEquals(1,testFile.records());

        testFile.partnum.setValue("TEST456");
        testFile.header.setValue("TEST-456");
        testFile.add();
        assertEquals(0,CError.errorCode());

        testFile.partnum.setValue("TEST789");
        testFile.header.setValue("TEST-789");
        testFile.add();
        assertEquals(0,CError.errorCode());

        assertEquals(3,testFile.records());
        
        for (int scan=100;scan<200;scan++) {
            testFile.partnum.setValue("T"+scan);
            testFile.header.setValue("T-"+scan);
            testFile.add();
            assertEquals(0,CError.errorCode());
        }
        
        assertEquals(103,testFile.records());
    }

    public void testAddWithAutoInc()
    {
        testAdd();
        assertEquals(103,testFile.records());

        testFile.partkey.setStart();
        testFile.next();

        testFile.partnum.setValue("T100A");
        testFile.add();
        assertEquals(0,CError.errorCode());
        
        assertEquals(104,testFile.records());
    }
    
    public void testDuplicate()
    {
        testAdd();
        
        testFile.clear();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TEST123");
        assertTrue(testFile.partkey.duplicateCheck());
        testFile.partnum.setValue("TEST124");
        assertFalse(testFile.partkey.duplicateCheck());
    }

    public void testSimpleUnsortedScan()
    {
        testAdd();
        testFile.set();
        
        Set<String> bits=new HashSet<String>();
        
        while ( true ) {
            testFile.next();
            if (CError.errorCode()==Constants.BADRECERR) break;
            assertEquals(0,CError.errorCode());
            
            bits.add(testFile.partnum.toString().trim());
        }
        
        assertEquals(103,bits.size());
        
        assertTrue(bits.contains("TEST123"));
        assertTrue(bits.contains("TEST456"));
        assertTrue(bits.contains("TEST789"));
    }

    public void testScanCompositeKey() throws SQLException
    {
        testInit();
        testFile.open();
        
        for (int scan=100;scan<150;scan++) {
            testFile.franchise.setValue(1);
            testFile.partnum.setValue("T"+scan);
            testFile.header.setValue("T-"+scan);
            testFile.add();
            assertEquals(0,CError.errorCode());
        }

        for (int scan=50;scan<100;scan++) {
            testFile.franchise.setValue(2);
            testFile.partnum.setValue("T"+scan);
            testFile.header.setValue("T-"+scan);
            testFile.add();
            assertEquals(0,CError.errorCode());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.franchise.setValue(3);
            if (scan<10) {
                testFile.partnum.setValue("T0"+scan);
            } else {
                testFile.partnum.setValue("T"+scan);
            }
            testFile.header.setValue("T-"+scan);
            testFile.add();
            assertEquals(0,CError.errorCode());
        }
        
        assertEquals(150,testFile.records());

        testFile.partkey.setStart();

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,1,testFile.franchise.intValue());
            assertEquals("T"+(100+scan),testFile.partnum.toString().trim());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,2,testFile.franchise.intValue());
            assertEquals("T"+(50+scan),testFile.partnum.toString().trim());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,3,testFile.franchise.intValue());
            if (scan<10) {
                assertEquals("T0"+(scan),testFile.partnum.toString().trim());
            } else {
                assertEquals("T"+(scan),testFile.partnum.toString().trim());
            }
        }
    }

    public void testScanCompositeKeyWithKeyBindingOptimisation()
    {
        testInit();
        testFile.open();
        testFile.setKeyBinding();
        
        for (int scan=100;scan<150;scan++) {
            testFile.franchise.setValue(1);
            testFile.partnum.setValue("T"+scan);
            testFile.header.setValue("T-"+scan);
            testFile.add();
            assertEquals(0,CError.errorCode());
        }

        for (int scan=50;scan<100;scan++) {
            testFile.franchise.setValue(2);
            testFile.partnum.setValue("T"+scan);
            testFile.header.setValue("T-"+scan);
            testFile.add();
            assertEquals(0,CError.errorCode());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.franchise.setValue(3);
            if (scan<10) {
                testFile.partnum.setValue("T0"+scan);
            } else {
                testFile.partnum.setValue("T"+scan);
            }
            testFile.header.setValue("T-"+scan);
            testFile.add();
            assertEquals(0,CError.errorCode());
        }
        
        assertEquals(150,testFile.records());

        testFile.clear();
        testFile.partkey.set();

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,1,testFile.franchise.intValue());
            assertEquals("T"+(100+scan),testFile.partnum.toString().trim());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,2,testFile.franchise.intValue());
            assertEquals("T"+(50+scan),testFile.partnum.toString().trim());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,3,testFile.franchise.intValue());
            if (scan<10) {
                assertEquals("T0"+(scan),testFile.partnum.toString().trim());
            } else {
                assertEquals("T"+(scan),testFile.partnum.toString().trim());
            }
        }
        
        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        
        testFile.clear();
        testFile.franchise.setValue(1);
        testFile.partkey.set();

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,1,testFile.franchise.intValue());
            assertEquals("T"+(100+scan),testFile.partnum.toString().trim());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,2,testFile.franchise.intValue());
            assertEquals("T"+(50+scan),testFile.partnum.toString().trim());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,3,testFile.franchise.intValue());
            if (scan<10) {
                assertEquals("T0"+(scan),testFile.partnum.toString().trim());
            } else {
                assertEquals("T"+(scan),testFile.partnum.toString().trim());
            }
        }

        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());

        testFile.clear();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T116");
        testFile.partkey.set();

        for (int scan=16;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,1,testFile.franchise.intValue());
            assertEquals("T"+(100+scan),testFile.partnum.toString().trim());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,2,testFile.franchise.intValue());
            assertEquals("T"+(50+scan),testFile.partnum.toString().trim());
        }

        for (int scan=0;scan<50;scan++) {
            testFile.next();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,3,testFile.franchise.intValue());
            if (scan<10) {
                assertEquals("T0"+(scan),testFile.partnum.toString().trim());
            } else {
                assertEquals("T"+(scan),testFile.partnum.toString().trim());
            }
        }

        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());

        testFile.clear();
        testFile.franchise.setValue(3);
        testFile.partnum.setValue("T24");
        testFile.partkey.set();

        for (int scan=24;scan>=0;scan--) {
            testFile.previous();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,3,testFile.franchise.intValue());
            if (scan<10) {
                assertEquals("T0"+(scan),testFile.partnum.toString().trim());
            } else {
                assertEquals("T"+(scan),testFile.partnum.toString().trim());
            }
        }

        for (int scan=49;scan>=0;scan--) {
            testFile.previous();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,2,testFile.franchise.intValue());
            assertEquals("T"+(50+scan),testFile.partnum.toString().trim());
        }

        for (int scan=49;scan>=0;scan--) {
            testFile.previous();
            
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,1,testFile.franchise.intValue());
            assertEquals("T"+(100+scan),testFile.partnum.toString().trim());
        }


        
        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        
        testFile.clear();
        testFile.partkey.set();
        
        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    
    public void testKeyScanForward1()
    {
        testAdd();
        testFile.partkey.setStart();
        
        for (int scan=100;scan<200;scan++) {
            testFile.next();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST456",testFile.partnum.toString().trim());
        
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST789",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanFromPosition1()
    {
        testAdd();
        
        testFile.clear();
        
        testFile.partkey.set();
        
        for (int scan=100;scan<200;scan++) {
            testFile.next();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST456",testFile.partnum.toString().trim());
        
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST789",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanFromPosition2()
    {
        testAdd();
        
        testFile.clear();
        testFile.franchise.setValue(1);
        
        testFile.partkey.set();
        
        for (int scan=100;scan<200;scan++) {
            testFile.next();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST456",testFile.partnum.toString().trim());
        
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST789",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanFromPosition3()
    {
        testAdd();
        
        testFile.clear();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T150");
        
        testFile.partkey.set();
        
        for (int scan=150;scan<200;scan++) {
            testFile.next();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST456",testFile.partnum.toString().trim());
        
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST789",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanFromPosition4()
    {
        testAdd();
        
        testFile.clear();
        testFile.franchise.setValue(2);
        
        testFile.partkey.set();
        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    
    public void testKeyScanReverse1()
    {
        testAdd();
        testFile.partkey.setStart();
        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST789",testFile.partnum.toString().trim());
        
        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST456",testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        for (int scan=199;scan>=100;scan--) {
            testFile.previous();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanReversePosition1()
    {
        testAdd();
        testFile.clear();
        testFile.franchise.setValue(2);
        testFile.partkey.set();
        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST789",testFile.partnum.toString().trim());
        
        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST456",testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        for (int scan=199;scan>=100;scan--) {
            testFile.previous();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanReversePosition2()
    {
        testAdd();
        testFile.clear();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TEST222");
        testFile.partkey.set();

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        for (int scan=199;scan>=100;scan--) {
            testFile.previous();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanReversePosition3()
    {
        testAdd();
        testFile.clear();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T150");
        testFile.partkey.set();

        for (int scan=150;scan>=100;scan--) {
            testFile.previous();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanRandom()
    {
        testAdd();
        testFile.partkey.setStart();

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T100",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T101",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T102",testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("T101",testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("T100",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T101",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T102",testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("T101",testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("T100",testFile.partnum.toString().trim());
    
        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T101",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T102",testFile.partnum.toString().trim());
    }
    
    
    public void testKeyScanReversePosition4()
    {
        testAdd();
        testFile.clear();
        testFile.franchise.setValue(1);
        testFile.partkey.set();

        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    public void testKeyScanForward2()
    {
        testAdd();
        testFile.rpartkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST789",testFile.partnum.toString().trim());
        
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST456",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        for (int scan=199;scan>=100;scan--) {
            testFile.next();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testKeyScanReverse2()
    {
        testAdd();
        testFile.rpartkey.setStart();
        
        for (int scan=100;scan<200;scan++) {
            testFile.previous();
            assertEquals(0,CError.errorCode());
            assertEquals("T"+scan,testFile.partnum.toString().trim());
        }

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST123",testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST456",testFile.partnum.toString().trim());
        
        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals("TEST789",testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testPutCanAlterPrimaryKeySettings() {
        testAdd();

        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        
        testFile.franchise.setValue(999);
        testFile.partnum.setValue("XXX");
        testFile.put();
        assertEquals("UPDATE public.teststock SET partnum='XXX',franchise=999 WHERE (franchise=1 AND partnum='T100')",testFile.getProperty(Prop.SQL).toString());

        testFile.partkey.setStart();
        testFile.previous();
        assertEquals(0,CError.errorCode());
        assertEquals(999,testFile.franchise.intValue());
        assertEquals("XXX",testFile.partnum.toString().trim());
    }
    
    public void testPut() {
        testAdd();

        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        
        testFile.format.setValue("Format!");
        testFile.location.setValue("OTSHR");
        testFile.put();
        assertEquals(0,CError.errorCode());
        assertEquals("UPDATE public.teststock SET format='Format!',location='OTSHR' WHERE (franchise=1 AND partnum='T100')",testFile.getProperty(Prop.SQL).toString());
        
        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Format!",testFile.format.toString().trim());
        assertEquals("OTSHR",testFile.location.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("",testFile.format.toString().trim());
        
        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());

        System.gc();
        Thread.yield();
        
        
        testFile.format.setValue("Reformat!");
        
        testFile.put();
        assertEquals(0,CError.errorCode());
        assertEquals("UPDATE public.teststock SET format='Reformat!' WHERE (franchise=1 AND partnum='T100')",testFile.getProperty(Prop.SQL).toString());

        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Reformat!",testFile.format.toString().trim());
        assertEquals("OTSHR",testFile.location.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("",testFile.format.toString().trim());
        
    }
    
    public void testVariousFieldTypes() {
        testOpen();
        
        testFile.clear();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TEST");
        testFile.add();
        assertEquals(0,CError.errorCode());
        testFile.set();
        testFile.next();
        assertEquals(0,CError.errorCode());
        
        assertEquals("0.00",testFile.dailydisc.toString());
        assertEquals("0",testFile.created.toString());
        assertEquals("0",testFile.ctime.toString());
        assertEquals("0",testFile.ecordqty.toString());
        
        testFile.dailydisc.setValue("-12.34");
        testFile.created.setValue(CDate.date(11,2,1977));
        testFile.ecordqty.setValue(5);
        testFile.ctime.setValue(9*360000+30*6000+12*100+1);

        testFile.put();
        assertEquals("UPDATE public.teststock SET created='1977-11-02',ctime='09:30:12',ecordqty=5,dailydisc=-12.34 WHERE (franchise=1 AND partnum='TEST')",testFile.getProperty(Prop.SQL).toString());
        
        testFile.set();
        testFile.next();

        assertEquals("-12.34",testFile.dailydisc.toString());
        assertEquals(""+CDate.date(11,2,1977),testFile.created.toString());
        assertEquals(""+(9*360000+30*6000+12*100+1),testFile.ctime.toString());
        assertEquals("5",testFile.ecordqty.toString());
        
    }

    
    
    public void testClose() 
    {
        testAdd();
        testFile.close();
        assertEquals(0,testFile.records());
        assertEquals(Constants.NOTOPENERR,CError.errorCode());
        testFile.open();
        assertEquals(103,testFile.records());
        assertEquals(0,CError.errorCode());
        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T100",testFile.partnum.toString().trim());
    }

    public void testDeleteIsNotConfusedByBufferChanges() {
        testAdd();

        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T100",testFile.partnum.toString().trim());
        
        testFile.franchise.setValue(999);
        testFile.partnum.setValue("1234");
        
        testFile.delete();
        assertEquals(0,CError.errorCode());
        assertEquals("DELETE FROM public.teststock WHERE (franchise=1 AND partnum='T100')",testFile.getProperty(Prop.SQL).toString());

        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T101",testFile.partnum.toString().trim());
    }
    
    public void testDelete() {
        testAdd();

        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T100",testFile.partnum.toString().trim());
        
        testFile.delete();
        assertEquals(0,CError.errorCode());
        assertEquals("DELETE FROM public.teststock WHERE (franchise=1 AND partnum='T100')",testFile.getProperty(Prop.SQL).toString());
        
        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T101",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T102",testFile.partnum.toString().trim());

        testFile.delete();
        assertEquals(0,CError.errorCode());
        assertEquals("DELETE FROM public.teststock WHERE (franchise=1 AND partnum='T102')",testFile.getProperty(Prop.SQL).toString());
        
        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T101",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T103",testFile.partnum.toString().trim());
        
    }

    public void testLock()
    {
        testOpen();
        testFile.lock();
        assertEquals(0,CError.errorCode());
    }

    public void testUnlock()
    {
        testOpen();
        testFile.unlock();
        assertEquals(0,CError.errorCode());
    }

    
    public void testWatch() {
        testAdd();
        
        testFile.watch();
        
        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        
        testFile.format.setValue("Format!");
        testFile.put();
        assertEquals(0,CError.errorCode());

        testFile.format.setValue("Formaty!");
        testFile.put();
        assertEquals(0,CError.errorCode());
        
        String types[]=new String[] {
                "UPDATE teststock set created='1977-1-12' WHERE clid="+testFile.clid.toString(),                
                "UPDATE teststock set ctime='12:12:10' WHERE clid="+testFile.clid.toString(),                
                "UPDATE teststock set location='OTSHR' WHERE clid="+testFile.clid.toString(),                
                "UPDATE teststock set qtyjan=3 WHERE clid="+testFile.clid.toString(),                
                "UPDATE teststock set dailydisc=10 WHERE clid="+testFile.clid.toString(),                
        };
        
        for (int scan=0;scan<types.length;scan++) {
            testFile.watch();
            testFile.partkey.setStart();
            testFile.next();
            assertEquals("Formaty!",testFile.format.toString().trim());
            assertEquals(0,CError.errorCode());
        
            try {
                testFile.getFileState().global.source.getConnection().createStatement().execute(
                    types[scan]);
            } catch (SQLException e) {
                fail(e.getMessage());
            }
        
            testFile.format.setValue("Format 2!");
            testFile.put();
            assertEquals(Constants.RECORDCHANGEDERR,CError.errorCode());
        
            testSql("SELECT 1 FROM teststock WHERE clid="+testFile.clid.toString()+" AND format='Formaty!'");
        }

        testFile.put();
        assertEquals(0,CError.errorCode());

        testSql("SELECT 1 FROM teststock WHERE clid="+testFile.clid.toString()+" AND format='Format 2!'");
        
        testFile.partkey.setStart();
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("Format 2!",testFile.format.toString().trim());
    }

    public void testGet() {
        testAdd();

        
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T130");
        testFile.get(testFile.partkey);
        assertEquals(0,CError.errorCode());
        assertEquals("T-130",testFile.header.toString().trim());

        testFile.clear();
        testFile.franchise.setValue(2);
        testFile.partnum.setValue("T130");
        testFile.get(testFile.partkey);
        assertEquals(Constants.NORECERR,CError.errorCode());
        assertEquals("",testFile.header.toString().trim());
    }
    
    public void testReget() {
        testAdd();
        
        testFile.partkey.setStart();
        
        testFile.next();
        assertEquals("T100",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals("T101",testFile.partnum.toString().trim());
        
        ClarionString p1 = testFile.partkey.getPosition();
        
        testFile.next();
        assertEquals("T102",testFile.partnum.toString().trim());

        testFile.next();
        assertEquals("T103",testFile.partnum.toString().trim());

        ClarionString p2 = testFile.partkey.getPosition();
        
        testFile.next();
        assertEquals("T104",testFile.partnum.toString().trim());
        
        testFile.partkey.reget(p1);
        assertEquals("T101",testFile.partnum.toString().trim());
        assertEquals("T-101",testFile.header.toString().trim());
        testFile.partkey.reget(p2);
        assertEquals("T103",testFile.partnum.toString().trim());
        assertEquals("T-103",testFile.header.toString().trim());

        testFile.next();
        assertEquals("T105",testFile.partnum.toString().trim());

        testFile.partkey.reget(p1);
        assertEquals("T101",testFile.partnum.toString().trim());
        assertEquals("T-101",testFile.header.toString().trim());
        testFile.partkey.reget(p2);
        assertEquals("T103",testFile.partnum.toString().trim());
        assertEquals("T-103",testFile.header.toString().trim());

        testFile.next();
        assertEquals("T106",testFile.partnum.toString().trim());
        
        testFile.partkey.reget(p1);
        assertEquals("T101",testFile.partnum.toString().trim());
        assertEquals("T-101",testFile.header.toString().trim());
        testFile.partkey.reget(p2);
        assertEquals("T103",testFile.partnum.toString().trim());
        assertEquals("T-103",testFile.header.toString().trim());
        
        testFile.previous();
        assertEquals("T105",testFile.partnum.toString().trim());
        
        testFile.partkey.reget(p1);
        assertEquals("T101",testFile.partnum.toString().trim());
        assertEquals("T-101",testFile.header.toString().trim());
        testFile.partkey.reget(p2);
        assertEquals("T103",testFile.partnum.toString().trim());
        assertEquals("T-103",testFile.header.toString().trim());

        testFile.next();
        assertEquals("T106",testFile.partnum.toString().trim());
        
        testFile.partkey.reget(p1);
        assertEquals("T101",testFile.partnum.toString().trim());
        assertEquals("T-101",testFile.header.toString().trim());
        testFile.partkey.reget(p2);
        assertEquals("T103",testFile.partnum.toString().trim());
        assertEquals("T-103",testFile.header.toString().trim());
    }

    public void testReset() {
        testAdd();

        testFile.partkey.setStart();

        testFile.next();
        assertEquals("T100", testFile.partnum.toString().trim());

        testFile.next();
        assertEquals("T101", testFile.partnum.toString().trim());

        ClarionString p1 = testFile.partkey.getPosition();

        testFile.next();
        assertEquals("T102", testFile.partnum.toString().trim());

        testFile.next();
        assertEquals("T103", testFile.partnum.toString().trim());

        ClarionString p2 = testFile.partkey.getPosition();

        testFile.next();
        assertEquals("T104", testFile.partnum.toString().trim());
        
        testFile.partkey.reset(p1);
        
        testFile.next();
        assertEquals("T101", testFile.partnum.toString().trim());

        testFile.partkey.reset(p2);
        
        testFile.next();
        assertEquals("T103", testFile.partnum.toString().trim());
        
        testFile.next();
        assertEquals("T104", testFile.partnum.toString().trim());
        
        testFile.partkey.reset(p1);
        
        testFile.previous();
        assertEquals("T101", testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals("T100", testFile.partnum.toString().trim());

        testFile.partkey.reset(p2);
        
        testFile.previous();
        assertEquals("T103", testFile.partnum.toString().trim());

        testFile.previous();
        assertEquals("T102", testFile.partnum.toString().trim());

        testFile.partkey.reset(p2);
        
        testFile.next();
        assertEquals("T103", testFile.partnum.toString().trim());

        testFile.next();
        assertEquals("T104", testFile.partnum.toString().trim());
    }

    public void testUseNulls()
    {
        testAdd();

        testFile.partkey.setStart();

        testFile.next();
        assertEquals("T-100", testFile.header.toString().trim());
        
        testFile.header.setNull();
        testFile.put();

        testSql("SELECT 1 FROM teststock WHERE clid="+testFile.clid.toString()+" AND header IS NULL");

        testFile.partkey.setStart();

        testFile.next();
        assertEquals("", testFile.header.toString().trim());
    }

    public void testGetNulls() {
        testOpen();
        
        testFile.clear();
        assertEquals("0000000000000000000000000000000000000000000000000000",testFile.getNulls().toString());
        testFile.header.setNull();
        assertEquals("0000000100000000000000000000000000000000000000000000",testFile.getNulls().toString());
        // should clear clear null vars?
        testFile.clear();
        assertEquals("0000000000000000000000000000000000000000000000000000",testFile.getNulls().toString());
        testFile.header.setValue("hello");
        assertEquals("0000000000000000000000000000000000000000000000000000",testFile.getNulls().toString());
        testFile.header.setNull();
        assertEquals("0000000100000000000000000000000000000000000000000000",testFile.getNulls().toString());
        testFile.clear();
        assertEquals("0000000000000000000000000000000000000000000000000000",testFile.getNulls().toString());
    }

    public void testSetNulls() {
        testOpen();
        
        testFile.clear();
        assertEquals("0000000000000000000000000000000000000000000000000000",testFile.getNulls().toString());
        testFile.setNulls(Clarion.newString("0000000100000000000000000000000000000000000000000000"));
        assertEquals("0000000100000000000000000000000000000000000000000000",testFile.getNulls().toString());
    }
    
    public void testStatePreserveBuffer()
    {
        testOpen();
        
        testFile.header.setValue("Crap");
        testFile.retprice.setValue("19.95");

        int s1 = testFile.getState();

        testFile.header.setValue("Crap 2");
        testFile.retprice.setValue("6.50");
    
        int s2 = testFile.getState();
        
        testFile.restoreState(s1);
        assertEquals("Crap",testFile.header.toString().trim());
        assertEquals("19.95",testFile.retprice.toString().trim());

        testFile.restoreState(s2);
        assertEquals("Crap 2",testFile.header.toString().trim());
        assertEquals("6.50",testFile.retprice.toString().trim());

        testFile.restoreState(s1);
        assertEquals("Crap",testFile.header.toString().trim());
        assertEquals("19.95",testFile.retprice.toString().trim());

        testFile.restoreState(s2);
        assertEquals("Crap 2",testFile.header.toString().trim());
        assertEquals("6.50",testFile.retprice.toString().trim());
    }

    public void testStatePreserveSetStart()
    {
        testAdd();
        
        testFile.partkey.setStart();
        
        int s1 = testFile.getState();
        
        testFile.rpartkey.setStart();
        testFile.next();
        assertEquals("TEST789", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("TEST456", testFile.partnum.toString().trim());
        
        testFile.restoreState(s1);
        
        testFile.next();
        assertEquals("T100", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T101", testFile.partnum.toString().trim());
        
        testFile.restoreState(s1);
        
        testFile.next();
        assertEquals("T100", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T101", testFile.partnum.toString().trim());
    }

    public void testStatePreserveSetPositioned()
    {
        testAdd();
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T150");
        testFile.partkey.set();
        
        int s1 = testFile.getState();

        testFile.next();
        assertEquals("T150", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T151", testFile.partnum.toString().trim());
        
        testFile.rpartkey.setStart();
        testFile.next();
        assertEquals("TEST789", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("TEST456", testFile.partnum.toString().trim());
        
        testFile.restoreState(s1);
        
        testFile.next();
        assertEquals("T150", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T151", testFile.partnum.toString().trim());
        
        testFile.restoreState(s1);
        
        testFile.next();
        assertEquals("T150", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T151", testFile.partnum.toString().trim());
    }

    public void testStatePreserveActiveIteration()
    {
        testAdd();
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T150");
        testFile.partkey.set();

        testFile.next();
        assertEquals("T150", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T151", testFile.partnum.toString().trim());
        
        int s1 = testFile.getState();

        testFile.rpartkey.setStart();
        testFile.next();
        assertEquals("TEST789", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("TEST456", testFile.partnum.toString().trim());
        
        testFile.restoreState(s1);
        
        testFile.next();
        assertEquals("T152", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T153", testFile.partnum.toString().trim());
        
        testFile.restoreState(s1);
        
        testFile.next();
        assertEquals("T152", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T153", testFile.partnum.toString().trim());

        testFile.restoreState(s1);
        
        testFile.previous();
        assertEquals("T150", testFile.partnum.toString().trim());
    }

    public void testStatePreserveActiveIterationInUserSearch()
    {
        testAdd();
        
        StringBuilder bits = new StringBuilder();
        
        for (int scan=1;scan<=testFile.getVariableCount();scan++ ) {
            if (bits.length()>0) bits.append(",");
            bits.append(testFile.what(scan).getName());
        }
        
        testFile.setProperty(Prop.SQL,"SELECT "+bits.toString()+" FROM teststock where partnum>='T150' order by franchise,partnum");

        testFile.next();
        assertEquals("T150", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T151", testFile.partnum.toString().trim());
        
        int s1 = testFile.getState();

        testFile.rpartkey.setStart();
        testFile.next();
        assertEquals("TEST789", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("TEST456", testFile.partnum.toString().trim());
        
        testFile.restoreState(s1);
        
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T152", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T153", testFile.partnum.toString().trim());
        
        testFile.restoreState(s1);
        
        testFile.next();
        assertEquals("T154", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T155", testFile.partnum.toString().trim());

        testFile.restoreState(s1);
    }
    
    public void testStatePreserveChangeAndNulls()
    {
        testAdd();
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T150");
        testFile.partkey.set();

        testFile.next();
        assertEquals("T150", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals("T151", testFile.partnum.toString().trim());

        testFile.qtyjan.setValue(1);
        testFile.location.setNull();

        int s1 = testFile.getState();

        testFile.qtyfeb.setValue(1);
        testFile.header.setNull();
        
        testFile.restoreState(s1);
        
        testFile.put();
        assertEquals(0,CError.errorCode());
        assertEquals("UPDATE public.teststock SET location=null,qtyjan=1 WHERE (franchise=1 AND partnum='T151')",testFile.getProperty(Prop.SQL).toString());
        
        testFile.freeState(s1);
    }

    public void testDirectSQLNonSelect()
    {
        testAdd();
        assertEquals(103,testFile.records());
        testFile.setProperty(Prop.SQL,"DELETE from teststock");
        assertEquals(0,testFile.records());
    }

    public void testTransactionFramingViaDirectSQL()
    {
        testAdd();
        assertEquals(103,testFile.records());

        testFile.setProperty(Prop.SQL,"BEGIN");
        testFile.setProperty(Prop.SQL,"DELETE from teststock");
        assertEquals(0,testFile.records()); 
        testFile.setProperty(Prop.SQL,"ROLLBACK");
        assertEquals(103,testFile.records());
        
        testFile.setProperty(Prop.SQL,"BEGIN");
        testFile.setProperty(Prop.SQL,"DELETE from teststock");
        assertEquals(0,testFile.records());
        testFile.setProperty(Prop.SQL,"COMMIT");
        assertEquals(0,testFile.records());
        
    }
    
    public void testDirectSQLSelect()
    {
        testAdd();
        testFile.setProperty(Prop.SQL,"SELECT remarks,clid,lock,partnum,franchise,format,supers,header,suppcode,typecode,suppreordno,created,location,ctime,explodes,fgroup,headerhld,retailhld,minqty,maxqty,ecordqty,packqty,qtyonhand,qtysuppord,qtycustord,lqtyord,lqtyrec,lorddate,lordnum,linvdate,linvnum,lastrecno,tax,dailydisc,stockdisc,retprice,list,lastincost,valathand,valuesold,qtyjan,qtyfeb,qtymar,qtyapr,qtymay,qtyjun,qtyjul,qtyaug,qtysep,qtyoct,qtynov,qtydec FROM public.teststock WHERE header='T-121'");
        testFile.next();
        assertEquals(0,CError.errorCode());
        assertEquals("T121", testFile.partnum.toString().trim());
        testFile.next();
        assertEquals(33,CError.errorCode());
        testFile.next();
        assertEquals(33,CError.errorCode());
    }
    
    private void testSql(String sql)
    {
        try {
            ResultSet rs = testFile.getFileState().global.source.getConnection().createStatement().executeQuery(sql);
            assertTrue(rs.next());
            assertEquals(1,rs.getInt(1));
            rs.close();
        } catch (SQLException ex) {
            fail(ex.getMessage());
        }
    }

    public void testCursorOptimiseEvenInManualTxnFrames() throws SQLException
    {
        TestFile tf2 = new TestFile();
        
        testInit();
        tf2.open();
        testFile.open();
        testFile.clear();
        testFile.franchise.setValue(1);
        
        for (int scan=0;scan<510;scan++) {
            testFile.partnum.setValue("T"+spad(scan));
            testFile.header.setValue("T-"+spad(scan));
            testFile.add();
            assertEquals(0,CError.errorCode());
        }
        
        assertEquals(510,testFile.records());

        tf2.setProperty(Prop.SQL,"BEGIN");
        
        // verify outcome of 500 fetch limit
        testFile.partkey.setStart();
        for (int scan=0;scan<100;scan++) {
            testFile.next();
            assertEquals("T"+spad(scan),testFile.partnum.toString().trim());
            assertEquals("T-"+spad(scan),testFile.header.toString().trim());
        }
        
        tf2.setProperty(Prop.SQL,"rollback");
        
        for (int scan=100;scan<500;scan++) {
            testFile.next();
            assertEquals(""+scan,"T"+spad(scan),testFile.partnum.toString().trim());
            assertEquals("T-"+spad(scan),testFile.header.toString().trim());
        }

        try {
            testFile.next();
            fail("Expected Runtime Exception");
        } catch (RuntimeException ex) { }
    }

    
    public void testCursoredSystem() throws SQLException
    {
        testInit();
        testFile.open();
        testFile.clear();
        testFile.franchise.setValue(1);
        
        for (int scan=0;scan<510;scan++) {
            testFile.partnum.setValue("T"+spad(scan));
            testFile.header.setValue("T-"+spad(scan));
            testFile.add();
            assertEquals(0,CError.errorCode());
        }
        
        assertEquals(510,testFile.records());
        
        // ONE - test basic read
        
        testFile.partkey.setStart();
        for (int scan=0;scan<510;scan++) {
            testFile.next();
            assertEquals("T"+spad(scan),testFile.partnum.toString().trim());
            assertEquals("T-"+spad(scan),testFile.header.toString().trim());
        }
        
        // TWO - update actually does an update 

        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T120");
        testFile.partkey.set();
        testFile.next();
        testFile.header.setValue("Some header");
        testFile.put();
        
        assertSQL("SELECT 1 from teststock where partnum='T120' AND header='Some header'");


        // 3 - delete
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T120");
        testFile.partkey.set();
        testFile.next();
        testFile.delete();
        
        assertSQL("SELECT 1 WHERE EXISTS ( SELECT 1 from teststock where partnum='T119')");
        assertSQL("SELECT 1 WHERE NOT EXISTS ( SELECT 1 from teststock where partnum='T120')");

        // 4 - insert
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T119");
        testFile.partkey.set();
        testFile.next();
        testFile.partnum.setValue("T120");
        testFile.add();
        assertSQL("SELECT 1 from teststock where partnum='T120' AND header='T-119'");
        
        // verify outcome of 500 fetch limit
        testFile.partkey.setStart();
        for (int scan=0;scan<100;scan++) {
            testFile.next();
            assertEquals("T"+spad(scan),testFile.partnum.toString().trim());
            assertEquals("T-"+spad(scan),testFile.header.toString().trim());
        }
        
        testFile.delete();
        
        for (int scan=100;scan<500;scan++) {
            testFile.next();
            assertEquals(""+scan,"T"+spad(scan),testFile.partnum.toString().trim());
            if (scan==120) {
                assertEquals("T-119",testFile.header.toString().trim());
            } else {
                assertEquals("T-"+spad(scan),testFile.header.toString().trim());
            }
        }

        try {
            testFile.next();
            fail("Expected Runtime Exception");
        } catch (RuntimeException ex) { }
        
        // read the lot one more time
        testFile.partkey.setStart();
        for (int scan=0;scan<99;scan++) {
            testFile.next();
            assertEquals("T"+spad(scan),testFile.partnum.toString().trim());
            assertEquals("T-"+spad(scan),testFile.header.toString().trim());
        }
        
        for (int scan=100;scan<510;scan++) {
            testFile.next();
            assertEquals(""+scan,"T"+spad(scan),testFile.partnum.toString().trim());
            if (scan==120) {
                assertEquals("T-119",testFile.header.toString().trim());
            } else {
                assertEquals("T-"+spad(scan),testFile.header.toString().trim());
            }
        }

        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T060");
        testFile.partkey.set();
        testFile.next();
        assertEquals("T-060",testFile.header.toString().trim());
        assertSQL("SELECT 1 WHERE EXISTS ( SELECT 1 from teststock where partnum='T060')");
        testFile.delete();
        assertSQL("SELECT 1 WHERE NOT EXISTS ( SELECT 1 from teststock where partnum='T060')");
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("T050");
        testFile.partkey.set();
        testFile.next();
        assertEquals("T-050",testFile.header.toString().trim());
        testFile.partnum.setValue("T051");
        testFile.put();
        assertEquals(40,CError.errorCode());
        testFile.partnum.setValue("K050");
        testFile.put();
        assertEquals(0,CError.errorCode());
        assertSQL("SELECT 1 from teststock where partnum='K050'");
        
        testFile.partkey.setStart();
        testFile.next();
        assertEquals("K050",testFile.partnum.toString().trim());
        assertEquals("T-050",testFile.header.toString().trim());
        
        for (int scan=0;scan<50;scan++) {
            testFile.next();
            assertEquals("T"+spad(scan),testFile.partnum.toString().trim());
            assertEquals("T-"+spad(scan),testFile.header.toString().trim());
        }

        for (int scan=51;scan<60;scan++) {
            testFile.next();
            assertEquals("T"+spad(scan),testFile.partnum.toString().trim());
            assertEquals("T-"+spad(scan),testFile.header.toString().trim());
        }

        for (int scan=61;scan<99;scan++) {
            testFile.next();
            assertEquals("T"+spad(scan),testFile.partnum.toString().trim());
            assertEquals("T-"+spad(scan),testFile.header.toString().trim());
        }
        
        for (int scan=100;scan<510;scan++) {
            testFile.next();
            assertEquals(""+scan,"T"+spad(scan),testFile.partnum.toString().trim());
            if (scan==120) {
                assertEquals("T-119",testFile.header.toString().trim());
            } else {
                assertEquals("T-"+spad(scan),testFile.header.toString().trim());
            }
        }
    }
    
    private void assertSQL(String string) throws SQLException 
    {
	Connection c = JDBCSource.get("mvntest_sqlascii").newConnection();
	try {
        	ResultSet rs = c.createStatement().executeQuery(string);
	        assertTrue(rs.next());
	        assertTrue(rs.getInt(1)>0);
	       rs.close();
	} finally {
		c.close();
	}
    }

    private String spad(int scan)
    {
        String s = String.valueOf(scan);
        while (s.length()<3) s="0"+s;
        return s;
    }

}
