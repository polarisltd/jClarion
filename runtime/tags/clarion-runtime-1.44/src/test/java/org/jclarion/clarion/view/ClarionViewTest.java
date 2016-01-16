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
package org.jclarion.clarion.view;

import java.sql.Connection;
import java.sql.SQLException;

import org.jclarion.clarion.BindProcedure;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.jdbc.JDBCSource;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.constants.*;

import junit.framework.TestCase;

public class ClarionViewTest extends TestCase {

    private class Stock extends ClarionSQLFile
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

        public Stock()
        {
            setSource(Clarion.newString("mvntest"));
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

    public class Franch extends ClarionSQLFile
    {
        public Franch record=this;
        public ClarionKey refkey=Clarion.newKey("refkey").setNocase().setPrimary().setOptional().setName("refkey");
        public ClarionKey headerkey=Clarion.newKey("headerkey").setNocase().setOptional().setName("headerkey").setDuplicate();
        public ClarionKey credkey=Clarion.newKey("credkey").setNocase().setOptional().setName("credkey").setDuplicate();
        public ClarionNumber clid=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setName("clid");
        public ClarionNumber lock=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).setName("lock");
        public ClarionNumber refcode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).setName("refcode");
        public ClarionString header=Clarion.newString(30).setEncoding(ClarionString.STRING).setName("header");
        public ClarionString filename=Clarion.newString(8).setEncoding(ClarionString.STRING).setName("filename");
        public ClarionString accountnum=Clarion.newString(20).setEncoding(ClarionString.STRING).setName("accountnum");
        public ClarionString credcode=Clarion.newString(10).setEncoding(ClarionString.STRING).setName("credcode");
        public ClarionString paytax=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("paytax");
        public ClarionString spare=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("spare");
        public ClarionDecimal disctrade=Clarion.newDecimal(5,2).setEncoding(ClarionDecimal.DECIMAL).setName("disctrade");
        public ClarionString usemaster=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("usemaster");
        public ClarionNumber spare_2=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).setName("spare_2");
        public ClarionDecimal markup1=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("markup1");
        public ClarionDecimal markup2=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("markup2");
        public ClarionDecimal markup3=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("markup3");
        public ClarionDecimal markup4=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("markup4");
        public ClarionDecimal markup5=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("markup5");
        public ClarionDecimal pricebrk1=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("pricebrk1");
        public ClarionDecimal pricebrk2=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("pricebrk2");
        public ClarionDecimal pricebrk3=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("pricebrk3");
        public ClarionDecimal pricebrk4=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("pricebrk4");
        public ClarionDecimal pricebrk5=Clarion.newDecimal(7,2).setEncoding(ClarionDecimal.DECIMAL).setName("pricebrk5");
        public ClarionString switch_1=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("switch_1");
        public ClarionString switch_2=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("switch_2");
        public ClarionString switch_3=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("switch_3");
        public ClarionString switch_4=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("switch_4");
        public ClarionString switch_5=Clarion.newString(1).setEncoding(ClarionString.STRING).setName("switch_5");

        public Franch()
        {
            setSource(Clarion.newString("mvntest"));
            setPrefix("PSI");
            setName("public.testfranch");

            refkey.addAscendingField(refcode);
            addKey(refkey);

            headerkey.addAscendingField(header);
            addKey(headerkey);

            credkey.addAscendingField(credcode);
            addKey(credkey);

            addVariable("clid",clid);
            addVariable("lock",lock);
            addVariable("refcode",refcode);
            addVariable("header",header);
            addVariable("filename",filename);
            addVariable("accountnum",accountnum);
            addVariable("credcode",credcode);
            addVariable("paytax",paytax);
            addVariable("spare",spare);
            addVariable("disctrade",disctrade);
            addVariable("usemaster",usemaster);
            addVariable("spare_2",spare_2);
            addVariable("markup1",markup1);
            addVariable("markup2",markup2);
            addVariable("markup3",markup3);
            addVariable("markup4",markup4);
            addVariable("markup5",markup5);
            addVariable("pricebrk1",pricebrk1);
            addVariable("pricebrk2",pricebrk2);
            addVariable("pricebrk3",pricebrk3);
            addVariable("pricebrk4",pricebrk4);
            addVariable("pricebrk5",pricebrk5);
            addVariable("switch_1",switch_1);
            addVariable("switch_2",switch_2);
            addVariable("switch_3",switch_3);
            addVariable("switch_4",switch_4);
            addVariable("switch_5",switch_5);
        }
    }
    
    private Stock stock;
    private Franch franch;

    public void modView(ClarionView v)
    {
    }
    
    public boolean isModded()
    {
        return false;
    }
    
    public String limit()
    {
        return "";
    }
    
    public void tearDown()
    {
        CExpression.popBind();
    }

    public void setUp()
    {
        CExpression.pushBind();
        
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP TABLE teststock");
        } catch (SQLException e) {
        }
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP SEQUENCE teststock_pk_seq");
        } catch (SQLException e) {
        }
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP TABLE testfranch");
        } catch (SQLException e) {
        }
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP SEQUENCE testfranch_pk_seq");
        } catch (SQLException e) {
        }
    }
    
    
    public void testInit()
    {
        
            try {
                Connection c=JDBCSource.get("mvntest").getConnection();  
                c.createStatement().execute("CREATE SEQUENCE TESTSTOCK_PK_SEQ MINVALUE 1 INCREMENT BY 1 START WITH 200 CACHE 5 NO CYCLE;");
                c.createStatement().execute("CREATE TABLE TESTSTOCK ( CLID BIGINT DEFAULT nextval('TESTSTOCK_PK_SEQ'), LOCK SMALLINT, PARTNUM VARCHAR(20), FRANCHISE SMALLINT, FORMAT VARCHAR(20), SUPERS VARCHAR(20), HEADER VARCHAR(30), SUPPCODE VARCHAR(10), TYPECODE VARCHAR(10), SUPPREORDNO VARCHAR(20), CREATED DATE, LOCATION VARCHAR(6), CTIME TIME, EXPLODES VARCHAR(1), FGROUP VARCHAR(2), HEADERHLD VARCHAR(1), RETAILHLD VARCHAR(1), MINQTY SMALLINT, MAXQTY SMALLINT, ECORDQTY SMALLINT, PACKQTY SMALLINT, QTYONHAND SMALLINT, QTYSUPPORD SMALLINT, QTYCUSTORD SMALLINT, LQTYORD SMALLINT, LQTYREC SMALLINT, LORDDATE DATE, LORDNUM BIGINT, LINVDATE DATE, LINVNUM VARCHAR(10), LASTRECNO BIGINT, TAX NUMERIC(5,2), DAILYDISC NUMERIC(5,2), STOCKDISC NUMERIC(5,2), RETPRICE NUMERIC(7,2), LIST NUMERIC(7,2), LASTINCOST NUMERIC(7,2), VALATHAND NUMERIC(7,2), VALUESOLD NUMERIC(7,2), QTYJAN SMALLINT, QTYFEB SMALLINT, QTYMAR SMALLINT, QTYAPR SMALLINT, QTYMAY SMALLINT, QTYJUN SMALLINT, QTYJUL SMALLINT, QTYAUG SMALLINT, QTYSEP SMALLINT, QTYOCT SMALLINT, QTYNOV SMALLINT, QTYDEC SMALLINT, SWITCH_1 VARCHAR(1), SWITCH_2 VARCHAR(1), SWITCH_3 VARCHAR(1), SWITCH_4 VARCHAR(1), SWITCH_5 VARCHAR(1), REMARKS text)");
                c.createStatement().execute("ALTER TABLE TESTSTOCK ADD PRIMARY KEY (CLID)");
                c.createStatement().execute("CREATE UNIQUE INDEX TESTSTOCK_PARTKEY_1 ON TESTSTOCK (FRANCHISE,PARTNUM)");

                c.createStatement().execute("CREATE SEQUENCE TESTFRANCH_PK_SEQ MINVALUE 1 INCREMENT BY 1 START WITH 200 CACHE 5 NO CYCLE;");
                c.createStatement().execute("CREATE TABLE TESTFRANCH ( CLID BIGINT DEFAULT nextval('TESTFRANCH_PK_SEQ'), LOCK SMALLINT, REFCODE SMALLINT, HEADER VARCHAR(30), FILENAME VARCHAR(8), ACCOUNTNUM VARCHAR(20), CREDCODE VARCHAR(10), PAYTAX VARCHAR(1), SPARE VARCHAR(1), DISCTRADE NUMERIC(5,2), USEMASTER VARCHAR(1), SPARE_2 SMALLINT, MARKUP1 NUMERIC(7,2), MARKUP2 NUMERIC(7,2), MARKUP3 NUMERIC(7,2), MARKUP4 NUMERIC(7,2), MARKUP5 NUMERIC(7,2), PRICEBRK1 NUMERIC(7,2), PRICEBRK2 NUMERIC(7,2), PRICEBRK3 NUMERIC(7,2), PRICEBRK4 NUMERIC(7,2), PRICEBRK5 NUMERIC(7,2), SWITCH_1 VARCHAR(1), SWITCH_2 VARCHAR(1), SWITCH_3 VARCHAR(1), SWITCH_4 VARCHAR(1), SWITCH_5 VARCHAR(1))");

                c.createStatement().execute("ALTER TABLE TESTFRANCH ADD PRIMARY KEY (CLID)");

                c.createStatement().execute("INSERT INTO TESTFRANCH (refcode,header) " +
                		"VALUES (11,'Honda'),(55,'Yamaha'),(4,'Suzuki')");
                c.createStatement().execute("INSERT INTO TESTSTOCK (franchise,partnum,format,header,retprice,created) " +
                		"VALUES (11, '04201VA3800', '04201-VA3-800', 'AH SHIFT SLIDER SET', 30.15,'2009-01-01'), " +
                		"(11, '06001MEN000', '06001-MEN-000', 'AD CLUTCH KIT', 309.60,'2009-01-01'), " +
                		"(11, '06110051020', '06110-051-020', 'AH 06110051T20', 94.20,'2009-01-02'), " +
                		"(11, '06110459405', '06110-459-405', 'AH GASKET KIT,A', 69.25,'2009-01-01'), " +
                		"(11, '06111883405', '06111-883-405', 'AH GASKET,KIT', 62.15,'2009-01-02'), " +
                		"(55, '1UY1344002', '1UY-13440-02', 'AA OIL FILTER', 26.75,'2009-01-01'), " +
                		"(55, '21W2631201', '21W-26312-01', 'AA THROTTLE CABLE #2_ bottom', 9.95,'2009-01-01'), " +
                		"(55, '4EL1546103', '4EL-15461-03', 'AA GASKET,CLUTCH COVER', 29.15,'2009-01-01'), " +
                		"(55, '4WV1419028', '4WV-14190-28', 'AA NEEDLE & SEAT ASSY', 71.55,'2009-01-02'), " +
                		"(55, '4WV1490J00', '4WV-1490J-00', 'AA NEEDLE, 6HH23-94', 52.65,'2009-01-02'), " +
                		"(4, '0142106605', '01421-06605', '15 BOLT,STUD,M6 L:60', 3.65,'2009-01-01'), " +
                		"(4, '015000620A', '01500-0620A', '11 BOLT, GEAR SHIFT LINK', 3.65,'2009-01-01'), " +
                		"(4, '015000835B', '01500-0835B', '12 BOLT', 6.45,'2009-01-01'), " +
                		"(4, '015001045A', '01500-1045A', '13 BOLT', 6.45,'2009-01-01'), " +
                		"(4, '015470650B', '01547-0650B', '10 BOLT', 5.80,'2009-01-02')");

            } catch (SQLException e) {
                e.printStackTrace();
                fail(e.getMessage());
            }
        stock=new Stock();
        franch=new Franch();
    }

    public void testQuickScanBindingDefect()
    {
        testInit();
        stock.open();
        
        ClarionView cv = new ClarionView();
        cv.buffer(5,null,null,null);
        cv.setTable(stock);
        cv.open();

        CExpression.bind(stock);
        cv.setOrder("+stk:franchise,+stk:partnum");
        
        cv.set();
        
        cv.next();
        assertEquals("0142106605",stock.partnum.toString().trim());

        cv.next();
        assertEquals("015000620A",stock.partnum.toString().trim());

        cv.next();
        assertEquals("015000835B",stock.partnum.toString().trim());

        cv.next();
        assertEquals("015001045A",stock.partnum.toString().trim());

        stock.partnum.setValue("0142106605");
        stock.get(stock.partkey);

        stock.partnum.setValue("015001045A");
        assertEquals("15 BOLT,STUD,M6 L:60",stock.header.toString().trim());
        
        cv.set(2);
        
        cv.next();
        assertEquals("015001045A",stock.partnum.toString().trim());
        assertEquals("13 BOLT",stock.header.toString().trim());

        cv.next();
        assertEquals("015470650B",stock.partnum.toString().trim());
        assertEquals("10 BOLT",stock.header.toString().trim());
    }

    public void testOtherBoundBug()
    {
        testInit();
        stock.open();
        
        ClarionView cv = new ClarionView();
        cv.buffer(5,null,null,null);
        cv.setTable(stock);
        cv.open();

        ClarionNumber dealer = new ClarionNumber(11);
        ClarionNumber other = new ClarionNumber(55);
        
        CExpression.bind(stock);
        CExpression.bind("dealer",dealer);
        CExpression.bind("other",other);

        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:franchise=dealer");
        
        cv.set();
        cv.next();
        assertEquals("04201VA3800",stock.partnum.toString().trim());

        stock.partnum.setValue("04201VA3800a");
        cv.set(2);
        cv.next();
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        cv.next();
        assertEquals("06110051020",stock.partnum.toString().trim());
        
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:franchise=other");
        
        cv.set();
        cv.next();
        assertEquals("1UY1344002",stock.partnum.toString().trim());

    }
    
    public void testBoundBug()
    {
        testInit();
        stock.open();
        
        ClarionView cv = new ClarionView();
        cv.buffer(5,null,null,null);
        cv.setTable(stock);
        cv.open();

        ClarionNumber dealer = new ClarionNumber(11);
        ClarionNumber other = new ClarionNumber(-1);
        
        CExpression.bind(stock);
        CExpression.bind("dealer",dealer);
        CExpression.bind("other",other);

        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:franchise=dealer");
        
        cv.set();
        cv.next();
        assertEquals("04201VA3800",stock.partnum.toString().trim());

        stock.partnum.setValue("04201VA3800a");
        cv.set(2);
        cv.next();
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        cv.next();
        assertEquals("06110051020",stock.partnum.toString().trim());
        
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:franchise=other");
        
        cv.set();
        cv.next();
        assertEquals(33,CError.errorCode());
        assertEquals("06110051020",stock.partnum.toString().trim());
    }

    public void testBoundBug2()
    {
        testInit();
        stock.open();
        
        ClarionView cv = new ClarionView();
        cv.buffer(5,null,null,null);
        cv.setTable(stock);
        cv.open();

        ClarionNumber dealer = new ClarionNumber(11);
        ClarionNumber other = new ClarionNumber(-1);
        
        CExpression.bind(stock);
        CExpression.bind("dealer",dealer);
        CExpression.bind("other",other);

        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:franchise=dealer");
        
        cv.set();
        cv.next();
        assertEquals("04201VA3800",stock.partnum.toString().trim());

        stock.partnum.setValue("04201VA3800a");
        cv.set(2);
        cv.next();
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        cv.next();
        assertEquals("06110051020",stock.partnum.toString().trim());
        
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:franchise>=other");
        
        stock.franchise.setValue(5);
        cv.set(2);
        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
    }
    
    public void testOpen()
    {
        testInit();
        stock.open();
        assertEquals(0,CError.errorCode());
        franch.open();
        assertEquals(0,CError.errorCode());
    }

    public void testSimpleView()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        
        modView(cv);
        cv.open();
        cv.set();
        cv.next();
        assertEquals("SELECT A.clid,A.lock,A.refcode,A.header,A.filename,A.accountnum,A.credcode,A.paytax,A.spare,A.disctrade,A.usemaster,A.spare_2,A.markup1,A.markup2,A.markup3,A.markup4,A.markup5,A.pricebrk1,A.pricebrk2,A.pricebrk3,A.pricebrk4,A.pricebrk5,A.switch_1,A.switch_2,A.switch_3,A.switch_4,A.switch_5 FROM public.testfranch A",cv.getProperty(Prop.SQL).toString());
    }

    public void testPut()
    {
        testInit();
        stock.open();
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        CExpression.bind(stock);
        modView(cv);
        cv.open();
        cv.setOrder("+stk:franchise,+stk:partnum");
        
        cv.set();
        cv.next();
        assertEquals(0,CError.errorCode());
        //"(4, '0142106605', '01421-06605', '15 BOLT,STUD,M6 L:60', 3.65,'2009-01-01'), " +
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        assertEquals("01421-06605",stock.format.toString().trim());
        
        stock.format.setValue("014-21-06-605");
        cv.put();
        assertEquals(0,CError.errorCode());
        assertEquals("UPDATE public.teststock SET format='014-21-06-605' WHERE (franchise=4 AND partnum='0142106605')",stock.getProperty(Prop.SQL).toString());

        stock.clear();
        
        cv.set();
        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        assertEquals("014-21-06-605",stock.format.toString().trim());

        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());
        assertEquals("01500-0620A",stock.format.toString().trim());
    }

    public void testDelete()
    {
        testInit();
        stock.open();
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        CExpression.bind(stock);
        modView(cv);
        cv.open();
        cv.setOrder("+stk:franchise,+stk:partnum");
        
        cv.set();
        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        assertEquals("01421-06605",stock.format.toString().trim());
        
        cv.delete();
        assertEquals(0,CError.errorCode());
        assertEquals("DELETE FROM public.teststock WHERE (franchise=4 AND partnum='0142106605')",stock.getProperty(Prop.SQL).toString());

        stock.clear();
        
        cv.set();
        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());
        assertEquals("01500-0620A",stock.format.toString().trim());
    }
    
    
    
    public void testSimpleViewBackAndForward()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        
        modView(cv);
        cv.open();
        cv.set();
        cv.previous();
        assertEquals("SELECT A.clid,A.lock,A.refcode,A.header,A.filename,A.accountnum,A.credcode,A.paytax,A.spare,A.disctrade,A.usemaster,A.spare_2,A.markup1,A.markup2,A.markup3,A.markup4,A.markup5,A.pricebrk1,A.pricebrk2,A.pricebrk3,A.pricebrk4,A.pricebrk5,A.switch_1,A.switch_2,A.switch_3,A.switch_4,A.switch_5 FROM public.testfranch A",cv.getProperty(Prop.SQL).toString());
        cv.next();
        assertEquals("SELECT A.clid,A.lock,A.refcode,A.header,A.filename,A.accountnum,A.credcode,A.paytax,A.spare,A.disctrade,A.usemaster,A.spare_2,A.markup1,A.markup2,A.markup3,A.markup4,A.markup5,A.pricebrk1,A.pricebrk2,A.pricebrk3,A.pricebrk4,A.pricebrk5,A.switch_1,A.switch_2,A.switch_3,A.switch_4,A.switch_5 FROM public.testfranch A",cv.getProperty(Prop.SQL).toString());
        cv.next();
        cv.previous();
        assertEquals("SELECT A.clid,A.lock,A.refcode,A.header,A.filename,A.accountnum,A.credcode,A.paytax,A.spare,A.disctrade,A.usemaster,A.spare_2,A.markup1,A.markup2,A.markup3,A.markup4,A.markup5,A.pricebrk1,A.pricebrk2,A.pricebrk3,A.pricebrk4,A.pricebrk5,A.switch_1,A.switch_2,A.switch_3,A.switch_4,A.switch_5 FROM public.testfranch A",cv.getProperty(Prop.SQL).toString());
        cv.previous();
    }

    
    
    public void testSimpleViewRestrictedParameters()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.filename));
        
        modView(cv);
        cv.open();
        cv.set();
        cv.next();
        assertEquals("SELECT A.filename,A.refcode,A.header,A.credcode FROM public.testfranch A",cv.getProperty(Prop.SQL).toString());
    }

    public void testSimpleViewRestrictedParameters2()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.filename));
        cv.add((new ViewProject()).setField(franch.usemaster));
        
        modView(cv);
        cv.open();
        cv.set();
        cv.next();
        assertEquals("SELECT A.filename,A.usemaster,A.refcode,A.header,A.credcode FROM public.testfranch A",cv.getProperty(Prop.SQL).toString());
    }

    public void testSimpleViewRestrictedParameters3()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setFields(new ClarionObject[] { franch.filename,franch.usemaster } ));
        
        modView(cv);
        cv.open();
        cv.set();
        cv.next();
        assertEquals("SELECT A.filename,A.usemaster,A.refcode,A.header,A.credcode FROM public.testfranch A",cv.getProperty(Prop.SQL).toString());
    }

    public void testSimpleViewRestrictedParameters4()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.header));
        
        modView(cv);
        cv.open();
        cv.set();
        cv.next();
        assertEquals("SELECT A.header,A.refcode,A.credcode FROM public.testfranch A",cv.getProperty(Prop.SQL).toString());
    }
    
    
    public void testSimpleOuterJoin()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        
        ViewJoin vj = new ViewJoin();
        vj.setTable(stock);
        vj.add((new ViewProject()).setField(stock.clid));
        vj.setKey(stock.partkey);
        vj.setFields(new ClarionObject[] { franch.refcode } );
        
        cv.add(vj);
        
        modView(cv);
        cv.open();
        cv.set();
        cv.next();
        assertEquals("SELECT A.clid,A.refcode,A.header,A.credcode,B.clid,B.franchise,B.partnum,B.header,B.suppcode FROM public.testfranch A LEFT OUTER JOIN public.teststock B ON (B.franchise=A.refcode)",cv.getProperty(Prop.SQL).toString());
        cv.close();
    }

    public void testSimpleInnerJoin()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        
        ViewJoin vj = new ViewJoin();
        vj.setTable(stock);
        vj.add((new ViewProject()).setField(stock.clid));
        vj.setKey(stock.partkey);
        vj.setFields(new ClarionObject[] { franch.refcode } );
        vj.setInnerJoin();
        
        cv.add(vj);
        modView(cv);

        
        assertEquals(2,cv.getProperty(Prop.FILES).intValue());
        assertSame(franch,cv.getFile(1));
        assertSame(stock,cv.getFile(2));

        cv.open();
        
        cv.set();
        cv.next();
        assertEquals("SELECT A.clid,A.refcode,A.header,A.credcode,B.clid,B.franchise,B.partnum,B.header,B.suppcode FROM public.testfranch A INNER JOIN public.teststock B ON (B.franchise=A.refcode)",cv.getProperty(Prop.SQL).toString());
        cv.close();
    }
    
    public void testSimpleOuterJoin2()
    {
        testOpen();
        
        CExpression.bind(stock);
        CExpression.bind(franch);
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        
        ViewJoin vj = new ViewJoin();
        vj.setTable(stock);
        vj.add((new ViewProject()).setField(stock.clid));
        vj.setJoinExpression("stk:franchise=psi:refcode");
        
        cv.add(vj);
        
        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        cv.set();
        cv.next();
        assertEquals("SELECT A.clid,A.refcode,A.header,A.credcode,B.clid,B.franchise,B.partnum,B.header,B.suppcode FROM public.testfranch A LEFT OUTER JOIN public.teststock B ON (B.franchise=A.refcode)",cv.getProperty(Prop.SQL).toString());
        cv.close();
    }

    public void testSimpleOuterJoin2NoPriorBinding()
    {
        testOpen();
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        
        ViewJoin vj = new ViewJoin();
        vj.setTable(stock);
        vj.add((new ViewProject()).setField(stock.clid));
        vj.setJoinExpression("stk:franchise=psi:refcode");
        
        cv.add(vj);
        
        modView(cv);
        cv.open();
        assertEquals(801,CError.errorCode());
    }
    
    public void testOrderingWithBinding()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000835B",stock.partnum.toString().trim());
    }

    public void testUpperOrdering()
    {
        testOpen();
 
        stock.franchise.setValue(55);
        
        stock.partnum.setValue("1UY1344002");
        stock.get(stock.partkey);
        stock.header.setValue("aa oIL FILTE");
        stock.put();

        stock.partnum.setValue("4WV1419028");
        stock.get(stock.partkey);
        stock.header.setValue("AA NEEDLEA & SEAT ASSY");
        stock.put();

        stock.partnum.setValue("4WV1490J00");
        stock.get(stock.partkey);
        stock.header.setValue("AA NEEDLEB, 6HH23-94");
        stock.put();
        
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+upper(stk:HEADER)");

        
        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set(1);
        assertEquals(0,CError.errorCode());
        
        
        cv.next();
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        cv.next();
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        cv.next();
        assertEquals("21W2631201",stock.partnum.toString().trim());

        assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.franchise>=55) ORDER BY A.franchise,UPPER(A.header)"+limit(),cv.getProperty(Prop.SQL).toString());

        cv.previous();
        assertEquals("1UY1344002",stock.partnum.toString().trim());

        if (isModded()) {
            assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.franchise=55) AND (upper(A.header)<'AA THROTTLE CABLE #2_ BOTTOM') ORDER BY A.franchise DESC,UPPER(A.header) DESC LIMIT 25",cv.getProperty(Prop.SQL).toString());
        } else {
            assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.franchise<55 OR (A.franchise=55 AND (upper(A.header)<'AA THROTTLE CABLE #2_ BOTTOM'))) ORDER BY A.franchise DESC,UPPER(A.header) DESC"+limit(),cv.getProperty(Prop.SQL).toString());
        }

        cv.next();
        assertEquals("21W2631201",stock.partnum.toString().trim());

        if (isModded()) {
            assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.franchise=55) AND (upper(A.header)>'AA OIL FILTE') ORDER BY A.franchise,UPPER(A.header) LIMIT 25",cv.getProperty(Prop.SQL).toString());
        } else {
            assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.franchise>55 OR (A.franchise=55 AND (upper(A.header)>'AA OIL FILTE'))) ORDER BY A.franchise,UPPER(A.header)",cv.getProperty(Prop.SQL).toString());
        }
    }
    
    public void testOrderingIterate()
    {
        testOpen();
     
        CExpression.bind(franch);
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        cv.setOrder("+psi:refcode");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());

        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());

        cv.previous();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.previous();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());
        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());
    }

    public void testOrderingIterateQuickScan()
    {
        testOpen();
     
        CExpression.bind(franch);
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        cv.setOrder("+psi:refcode");
        cv.buffer(25,null,null,null);

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());

        ClarionString pos = cv.getPosition();
        
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        
        cv.reset(cv.getPosition());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());

        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());

        cv.previous();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());

        cv.reset(cv.getPosition());
        cv.previous();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());

        cv.previous();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());
        
        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());

        cv.reset(pos);
        cv.previous();
        assertEquals(0,CError.errorCode());
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());
        
        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    
    }
    

    public void testOrderingImplicite()
    {
        testOpen();
     
        CExpression.bind(franch);
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        cv.setOrder("psi:refcode");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());

        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    public void testOrderingReverse()
    {
        testOpen();
     
        CExpression.bind(franch);
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        cv.setOrder("-psi:refcode");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());

        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testOrderingAll()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000835B",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015001045A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110459405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());
        

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    
    public void testOrderingSetTwice()
    {
        testOpen();
     
        CExpression.bind(franch);
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        cv.setOrder("-psi:refcode");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());

        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());

        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        
    }

    public void testOrderingChange1()
    {
        testOpen();
     
        CExpression.bind(franch);
        
        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.add((new ViewProject()).setField(franch.clid));
        cv.setOrder("-psi:refcode");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());

        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());

        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        
        cv.setProperty(Prop.ORDER,"psi:header");
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(11,franch.refcode.intValue());
        assertEquals("Honda",franch.header.toString().trim());
        cv.next();
        assertEquals(4,franch.refcode.intValue());
        assertEquals("Suzuki",franch.header.toString().trim());
        cv.next();
        assertEquals(55,franch.refcode.intValue());
        assertEquals("Yamaha",franch.header.toString().trim());

        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    
    public void testOrderingMixed()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,-stk:partnum");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015001045A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000835B",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110459405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
        

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    
    public void testOrderingRestricted()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,-stk:partnum");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        stock.franchise.setValue(11);
        stock.partnum.setValue("ZZZ");
        cv.set(1);
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110459405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015001045A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000835B",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110459405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
        

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        
    }

    public void testSQLFilter1()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:partnum>'4'");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.partnum>'4') ORDER BY A.franchise,A.partnum"+limit(),cv.getProperty(Prop.SQL).toString());
        
        cv.previous();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.previous();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    
    public void testDateFilter()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.add((new ViewProject()).setField(stock.created));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:created>="+CDate.date(1,2,2009));

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        assertEquals("SELECT A.clid,A.created,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.created>='2009-01-02') ORDER BY A.franchise,A.partnum"+limit(),cv.getProperty(Prop.SQL).toString());
        
        cv.previous();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testDateFilterViaBoundVariable()
    {
        testOpen();
     
        ClarionNumber gt = new ClarionNumber();
        gt.setValue(CDate.date(1,2,2009));
        
        CExpression.bind(stock);
        CExpression.bind("gt",gt);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.add((new ViewProject()).setField(stock.created));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:created>=gt");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        assertEquals("SELECT A.clid,A.created,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.created>='2009-01-02') ORDER BY A.franchise,A.partnum"+limit(),cv.getProperty(Prop.SQL).toString());
        
        cv.previous();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    
    public void testDateFilterWithoutExplicitInclusionOfDateField()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:created>="+CDate.date(1,2,2009));

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.created>='2009-01-02') ORDER BY A.franchise,A.partnum"+limit(),cv.getProperty(Prop.SQL).toString());
        
        cv.previous();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testDateFilterSQLFilter()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setProperty(Prop.SQLFILTER,"+A.created>='2009-01-02'");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.created>='2009-01-02') ORDER BY A.franchise,A.partnum"+limit(),cv.getProperty(Prop.SQL).toString());
        
        cv.previous();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testDateFilterSQLFilterPostSet()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());

        cv.setProperty(Prop.SQLFILTER,"+A.created>='2009-01-02'");
        
        cv.next();
        assertEquals(0,CError.errorCode());
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        assertEquals("SELECT A.clid,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.created>='2009-01-02') ORDER BY A.franchise,A.partnum"+limit(),cv.getProperty(Prop.SQL).toString());
        
        cv.previous();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    public void testSQLFilter2()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.add((new ViewProject()).setField(stock.retprice));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("stk:partnum>'4' AND stk:retprice>=50");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        assertEquals("SELECT A.clid,A.retprice,A.franchise,A.partnum,A.header,A.suppcode FROM public.teststock A WHERE (A.partnum>'4' AND A.retprice>=50) ORDER BY A.franchise,A.partnum"+limit(),cv.getProperty(Prop.SQL).toString());
        
        cv.previous();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(Constants.BADRECERR,CError.errorCode());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testClientFilter()
    {
        testOpen();
     
        CExpression.bind(stock);
        CExpression.bind("len",new BindProcedure() {

            @Override
            public ClarionObject execute(ClarionString[] p) {
                ClarionObject co = new ClarionNumber(p[0].clip().len());
                return co;
            }
        });
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("LEN(stk:header)>=15");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110459405",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    public void testMixedFilter()
    {
        testOpen();
     
        CExpression.bind(stock);
        CExpression.bind("len",new BindProcedure() {

            @Override
            public ClarionObject execute(ClarionString[] p) {
                ClarionObject co = new ClarionNumber(p[0].clip().len());
                return co;
            }
        });
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("LEN(stk:header)>=15 AND stk:header<='AAZ'");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testAndSQLFilter()
    {
        testOpen();
     
        CExpression.bind(stock);
        CExpression.bind("len",new BindProcedure() {

            @Override
            public ClarionObject execute(ClarionString[] p) {
                ClarionObject co = new ClarionNumber(p[0].clip().len());
                return co;
            }
        });
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("LEN(stk:header)>=15 AND stk:header<='AAZ'");
        
        cv.setProperty(Prop.SQLFILTER,"+A.retprice>25");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }

    public void testSQLFilterOverrides()
    {
        testOpen();
     
        CExpression.bind(stock);
        CExpression.bind("len",new BindProcedure() {

            @Override
            public ClarionObject execute(ClarionString[] p) {
                ClarionObject co = new ClarionNumber(p[0].clip().len());
                return co;
            }
        });
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");
        cv.setFilter("LEN(stk:header)>=15 AND stk:header<='AAZ'");
        
        cv.setProperty(Prop.SQLFILTER,"A.retprice>25");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110459405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());
        

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
    
    public void testRecords()
    {
        testOpen();
     
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,-stk:partnum");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(15,cv.records());

        stock.franchise.setValue(11);
        cv.set(1);
        assertEquals(15,cv.records());
        
        cv.setProperty(Prop.FILTER,"stk:partnum>'4'");
        cv.set();
        assertEquals(3,cv.records());
    }    
    

    /** 
     * Required for BrowseClass. Position string yielded by
     * View cannot evaluate to neg boolean. i.e. must contain more
     * than just space (' ') chars
     */
    public void testGetPositionStringCannotEvalToFalse()
    {
        testOpen();

        try {
            Connection c=JDBCSource.get("mvntest").getConnection();
            c.createStatement().execute("INSERT INTO TESTFRANCH (refcode,header) " +
                    "VALUES (32,'Toro')");
        } catch (SQLException e) {
            e.printStackTrace();
            fail(e.getMessage());
        }

        ClarionView cv = new ClarionView();
        cv.setTable(franch);
        cv.setOrder("+psi:header");
        CExpression.bind(franch);
        
        modView(cv);
        cv.open();
        cv.set();
        
        cv.next();
        assertEquals("Honda",franch.header.toString().trim());
        assertEquals(11,franch.refcode.intValue());

        cv.next();
        assertEquals("Suzuki",franch.header.toString().trim());
        assertEquals(4,franch.refcode.intValue());

        cv.next();
        assertEquals("Toro",franch.header.toString().trim());
        assertEquals(32,franch.refcode.intValue());

        cv.previous();
        assertEquals("Suzuki",franch.header.toString().trim());
        assertEquals(4,franch.refcode.intValue());
        
        cv.next();
        assertEquals("Toro",franch.header.toString().trim());
        assertEquals(32,franch.refcode.intValue());
        
        ClarionString pos = cv.getPosition();
        pos.toString();
        assertTrue(pos.boolValue());

        cv.next();
        assertEquals("Yamaha",franch.header.toString().trim());
        assertEquals(55,franch.refcode.intValue());
        
        cv.reset(pos);
        
        cv.next();
        assertEquals("Toro",franch.header.toString().trim());
        assertEquals(32,franch.refcode.intValue());
    }    
    
    /** 
     * Interrupt and resume sequential processing
     */
    public void testGetPositionAndReset()
    {
        testOpen();
        
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000835B",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015001045A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        
        
        ClarionString cs = cv.getPosition();
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110459405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());
        

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
        

        cv.reset(cs);

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110051020",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06110459405",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06111883405",stock.partnum.toString().trim());
        

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());

        
        cv.reset(cs);
        
        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
        
        cv.previous();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.previous();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015001045A",stock.partnum.toString().trim());

    }

    
    /** 
     * Interrupt and resume sequential processing
     */
    public void testResetFileAsTechniqueToChangeOrderingMidSequence()
    {
        testOpen();
        
        CExpression.bind(stock);
        
        ClarionView cv = new ClarionView();
        cv.setTable(stock);
        cv.add((new ViewProject()).setField(stock.clid));
        cv.setOrder("+stk:franchise,+stk:partnum");

        modView(cv);
        cv.open();
        assertEquals(0,CError.errorCode());
        
        cv.set();
        assertEquals(0,CError.errorCode());
        
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("0142106605",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000620A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015000835B",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015001045A",stock.partnum.toString().trim());
        cv.next();
        assertEquals(4,stock.franchise.intValue());
        assertEquals("015470650B",stock.partnum.toString().trim());

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());
        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());
        
        
        cv.setOrder("+stk:franchise,-stk:partnum");
        cv.reset(stock);

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("06001MEN000",stock.partnum.toString().trim());

        cv.next();
        assertEquals(11,stock.franchise.intValue());
        assertEquals("04201VA3800",stock.partnum.toString().trim());

        
        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1490J00",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4WV1419028",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("4EL1546103",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("21W2631201",stock.partnum.toString().trim());

        cv.next();
        assertEquals(55,stock.franchise.intValue());
        assertEquals("1UY1344002",stock.partnum.toString().trim());
        
        cv.next();
        assertEquals(Constants.BADRECERR,CError.errorCode());
    }
}
