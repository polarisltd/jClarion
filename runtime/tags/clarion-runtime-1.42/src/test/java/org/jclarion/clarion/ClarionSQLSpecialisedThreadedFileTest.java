package org.jclarion.clarion;

import java.sql.SQLException;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.jdbc.JDBCSource;
import org.jclarion.clarion.runtime.CError;

import junit.framework.TestCase;

public class ClarionSQLSpecialisedThreadedFileTest  extends TestCase 
{
    public class TestFile extends ClarionSQLFile
    {
        public ClarionKey partkey=Clarion.newKey("partkey").setPrimary().setOptional().setName("partkey");
        public ClarionString partnum=Clarion.newString(20).setEncoding(ClarionString.STRING).setName("partnum");
        public ClarionNumber franchise=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).setName("franchise");
        public ClarionString header=Clarion.newString(30).setEncoding(ClarionString.STRING).setName("header");

        public TestFile()
        {
            setSource(Clarion.newString("mvntest"));
            setPrefix("Stk");
            setName("public.teststock");

            partkey.addAscendingField(franchise).addAscendingField(partnum);
            addKey(partkey);

            addVariable("partnum",partnum);
            addVariable("franchise",franchise);
            addVariable("header",header);
        }
    }

    public TestFile testFile;

    public void setUp() throws SQLException
    {
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP TABLE teststock");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    private ThreadHelper helper;
    
    public void tearDown()
    {
        if (helper!=null) {
            helper.tearDown();
            helper=null;
        }
        if (testFile!=null) {
            testFile.close();
        }
        //ClarionFile.closeEverything();
        try {
            JDBCSource.get("mvntest").getConnection().close();
        } catch (SQLException e) {
        }
    }

    public void testThreadedPut()
    {
        testFile=new TestFile();
        testFile.getThread();
        testFile.create();
        testFile.open();
        assertEquals(0,CError.errorCode());
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TESTA");
        testFile.header.setValue("Test Part A");
        testFile.add();
        assertEquals(0,CError.errorCode());
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TESTB");
        testFile.header.setValue("Test Part B");
        testFile.add();
        assertEquals(0,CError.errorCode());

        assertEquals(0,CError.errorCode());
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TESTC");
        testFile.header.setValue("Test Part C");
        testFile.add();

        assertEquals(0,CError.errorCode());
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TESTD");
        testFile.header.setValue("Test Part D");
        testFile.add();
        assertEquals(0,CError.errorCode());

        helper=new ThreadHelper();
        ThreadHelper.TestThread t = helper.createThread();
        
        t.runAndWait(new Runnable() {
            @Override
            public void run() {
                testFile.franchise.setValue(1);
                testFile.partnum.setValue("TESTA");
                testFile.get(testFile.partkey);
                assertEquals(0,CError.errorCode());
                assertEquals("Test Part A",testFile.header.toString().trim());
                
                testFile.header.setValue("New Description");
                testFile.put();
                assertEquals(0,CError.errorCode());
                assertEquals("UPDATE public.teststock SET header='New Description' WHERE (franchise=1 AND partnum='TESTA')",testFile.getProperty(Prop.SQL).toString());
                
            } } ,5000);
        
        testFile.franchise.setValue(1);
        testFile.partnum.setValue("TESTA");
        testFile.get(testFile.partkey);
        assertEquals(0,CError.errorCode());
        assertEquals("New Description",testFile.header.toString().trim());

        final ClarionObject k = testFile.header.getThreadLockedClone();
        t.runAndWait(new Runnable() {
            public void run() {
                k.setValue("A Brand New Description");
            }
        },5000);
        
        testFile.put();
        
        assertEquals(0,CError.errorCode());
        assertEquals("UPDATE public.teststock SET header='A Brand New Description' WHERE (franchise=1 AND partnum='TESTA')",testFile.getProperty(Prop.SQL).toString());
    }
}
