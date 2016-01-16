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

public class ClarionSQLDateTimeTest  extends TestCase 
{
	public class TimeStampGroup extends ClarionGroup
	{
		public ClarionNumber date = Clarion.newNumber().setEncoding(ClarionNumber.DATE);
		public ClarionNumber time = Clarion.newNumber().setEncoding(ClarionNumber.TIME);
		
		public TimeStampGroup()
		{
			addVariable("date",date);
			addVariable("time",time);
		}
	}
	
    public class TestFile extends ClarionSQLFile
    {
        public ClarionKey primarykey=Clarion.newKey("pkey").setPrimary().setName("partkey");
        public ClarionKey datekey=Clarion.newKey("datekey").setOptional().setName("partkey");
    	
        public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setName("id");
        public ClarionString timeStampField=Clarion.newString(8).setName("timestampfield");
        public TimeStampGroup timeStampGroup=new TimeStampGroup();
        public TestFile()
        {
            setSource(Clarion.newString("mvntest"));
            setPrefix("Stk");
            setName("testdatetime");
            timeStampGroup.setOver(timeStampField);

            primarykey.addAscendingField(id);
            addKey(primarykey);

            datekey.addAscendingField(timeStampField);
            addKey(datekey);

            addVariable("id",id);
            addVariable("timeStampField",timeStampField);
            addVariable("timeStampGroup",timeStampGroup);
        }
    }

    
    public TestFile testFile;

    public void setUp() throws SQLException
    {
        //new org.jclarion.clarion.log.Debug();
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP TABLE testdatetime");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute(
            "CREATE TABLE TESTDATETIME ( ID BIGINT, timestampfield timestamp )");
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

    public void testOpen()
    {
    	testFile=new TestFile();
    	testFile.open();
    	assertEquals(0,CError.errorCode());
    	testFile.close();
    }
    
    public void testAddSimple()
    {
    	testFile=new TestFile();
    	testFile.open();
    	assertEquals(0,CError.errorCode());
    	
    	testFile.id.setValue(10);
    	testFile.timeStampGroup.date.setValue(CDate.date(7,20,1969));
    	testFile.timeStampGroup.time.setValue((10*3600+45*60+11)*100+1);
    	testFile.add();
    	assertEquals(0,CError.errorCode());
    	assertEquals("INSERT INTO testdatetime (id,timestampfield) VALUES (10,'1969-07-20 10:45:11')",testFile.getProperty(Prop.SQL).toString());
    	
    	testFile.timeStampGroup.clear();
    	assertEquals(0,testFile.timeStampGroup.date.intValue());
    	assertEquals(0,testFile.timeStampGroup.time.intValue());
    	
    	testFile.id.setValue(10);
    	testFile.get(testFile.primarykey);
    	assertEquals(0,CError.errorCode());
    	assertEquals(CDate.date(7,20,1969),testFile.timeStampGroup.date.intValue());
    	assertEquals((10*3600+45*60+11)*100+1,testFile.timeStampGroup.time.intValue());
    	
    	testFile.close();
    }

    public void testCreate()
    {
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP TABLE testdatetime");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    	testFile=new TestFile();
    	testFile.open();
    	assertEquals(2,CError.errorCode());
    	testFile.create();
    	assertEquals(0,CError.errorCode());
    	testFile.open();
    	assertEquals(0,CError.errorCode());
    	testFile.close();
    	testUpdate();
    	
    	testFile.remove();
    	testFile.open();
    	assertEquals(2,CError.errorCode());
    }
    
    public void testUpdate()
    {
    	testFile=new TestFile();
    	testFile.open();
    	assertEquals(0,CError.errorCode());
    	
    	testFile.id.setValue(10);
    	testFile.timeStampGroup.date.setValue(CDate.date(7,20,1969));
    	testFile.timeStampGroup.time.setValue((10*3600+45*60+11)*100+1);
    	testFile.add();
    	assertEquals(0,CError.errorCode());

    	testFile.id.setValue(11);
    	testFile.timeStampGroup.date.setValue(CDate.date(12,5,1953));
    	testFile.timeStampGroup.time.setValue((10*3600+45*60+11)*100+1);
    	testFile.add();
    	assertEquals(0,CError.errorCode());
    	
    	testFile.id.setValue(5);
    	testFile.timeStampGroup.date.setValue(CDate.date(1,16,2001));
    	testFile.timeStampGroup.time.setValue((10*3600+45*60+11)*100+1);
    	testFile.add();
    	assertEquals(0,CError.errorCode());

    	testFile.id.setValue(11);
    	testFile.get(testFile.primarykey);
    	assertEquals(0,CError.errorCode());
    	assertEquals(CDate.date(12,5,1953),testFile.timeStampGroup.date.intValue());
    	assertEquals((10*3600+45*60+11)*100+1,testFile.timeStampGroup.time.intValue());
    	
    	testFile.timeStampGroup.date.setValue(CDate.date(11,6,1953));
    	testFile.put();
    	assertEquals(0,CError.errorCode());
    	assertEquals("UPDATE testdatetime SET timestampfield='1953-11-06 10:45:11' WHERE (id=11)",testFile.getProperty(Prop.SQL).toString());

    	testFile.id.setValue(10);
    	testFile.get(testFile.primarykey);
    	assertEquals(0,CError.errorCode());
    	assertEquals(CDate.date(7,20,1969),testFile.timeStampGroup.date.intValue());
    	assertEquals((10*3600+45*60+11)*100+1,testFile.timeStampGroup.time.intValue());
    	
    	testFile.timeStampGroup.date.setValue(0);
    	testFile.put();
    	assertEquals(0,CError.errorCode());
    	assertEquals("UPDATE testdatetime SET timestampfield=null WHERE (id=10)",testFile.getProperty(Prop.SQL).toString());
    	
    	testFile.datekey.setStart();
    	testFile.next();
    	assertEquals(0,CError.errorCode());
    	assertEquals(10,testFile.id.intValue());
    	assertEquals(0,testFile.timeStampGroup.date.intValue());
    	assertEquals(0,testFile.timeStampGroup.time.intValue());

    	testFile.next();
    	assertEquals(0,CError.errorCode());
    	assertEquals(11,testFile.id.intValue());
    	assertEquals(CDate.date(11,6,1953),testFile.timeStampGroup.date.intValue());
    	assertEquals((10*3600+45*60+11)*100+1,testFile.timeStampGroup.time.intValue());

    	testFile.next();
    	assertEquals(0,CError.errorCode());
    	assertEquals(5,testFile.id.intValue());
    	assertEquals(CDate.date(1,16,2001),testFile.timeStampGroup.date.intValue());
    	assertEquals((10*3600+45*60+11)*100+1,testFile.timeStampGroup.time.intValue());

    	testFile.next();
    	assertEquals(33,CError.errorCode());
    	
    	testFile.close();
    }
}
