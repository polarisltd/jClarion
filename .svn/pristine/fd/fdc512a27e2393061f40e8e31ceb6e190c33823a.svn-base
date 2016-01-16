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
import java.sql.SQLException;

import junit.framework.TestCase;

import org.jclarion.clarion.jdbc.JDBCSource;
import org.jclarion.clarion.runtime.CError;

public class ClarionSQLFileBinaryTest extends TestCase
{

    public class Keycache extends ClarionSQLFile
    {
        public Keycache record=this;
        public ClarionKey codekey=Clarion.newKey("codekey").setNocase().setPrimary().setOptional().setName("codekey");
        public ClarionNumber clid=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setName("clid");
        public ClarionString code=Clarion.newString(16).setEncoding(ClarionString.STRING).setName("code");
        public ClarionString name=Clarion.newString(30).setEncoding(ClarionString.STRING).setName("name");
        public ClarionString op=Clarion.newString(3).setEncoding(ClarionString.STRING).setName("op");
        public ClarionString types=Clarion.newString(20).setEncoding(ClarionString.STRING).setName("types");
        public ClarionString flock=Clarion.newString(40).setEncoding(ClarionString.STRING).setName("flock");
        public ClarionString plock=Clarion.newString(40).setEncoding(ClarionString.STRING).setName("plock");

        public Keycache()
        {
            setSource(new ClarionString("mvntest"));
            setPrefix("KCH");
            setName("public.testkeycache");

            codekey.addAscendingField(code);
            addKey(codekey);

            addVariable("clid",clid);
            addVariable("code",code);
            addVariable("name",name);
            addVariable("op",op);
            addVariable("types",types);
            addVariable("flock",flock);
            addVariable("plock",plock);
        }
    }
    
    private Keycache keyCache;
    
    public void setUp()
    {
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP TABLE testkeycache");
        } catch (SQLException e) {
        }
        try {
            JDBCSource.get("mvntest").getConnection().createStatement().execute("DROP SEQUENCE testkeycache_pk_seq");
        } catch (SQLException e) {
        }
    }
    
    
    public void testInit()
    {
            try {
                Connection c=JDBCSource.get("mvntest").getConnection();  
                c.createStatement().execute("CREATE SEQUENCE TESTKEYCACHE_PK_SEQ MINVALUE 1 INCREMENT BY 1 START WITH 200 CACHE 5 NO CYCLE;");
                c.createStatement().execute("CREATE TABLE TESTKEYCACHE ( CLID BIGINT DEFAULT nextval('TESTKEYCACHE_PK_SEQ'), CODE VARCHAR(16), NAME VARCHAR(30), OP VARCHAR(3), TYPES VARCHAR(20), FLOCK bytea, PLOCK bytea)");
                c.createStatement().execute("ALTER TABLE TESTKEYCACHE ADD PRIMARY KEY (CLID)");
                c.createStatement().execute("insert into testkeycache (code,name,types,flock,plock) values ('admin','Administrator','11101111100000000000',E'KByTDOCc\\\\\\\\eM[__UH}[uuLqK\\177TlDQXgs__AjYuLLkv',E'Il_TNWM~^LsF}zcGnBzJjjpaYtLuZMZzajuyywWe')");
            } catch (SQLException e) {
                e.printStackTrace();
                fail(e.getMessage());
            }
        keyCache=new Keycache();
    }

    public void testReadBinary()
    {
        testInit();
        keyCache.open();
        assertEquals(0,CError.errorCode());
        keyCache.codekey.set();
        keyCache.next();
        assertEquals(0,CError.errorCode());
        assertEquals("KByTDOCc\\eM[__UH}[uuLqK\177TlDQXgs__AjYuLLk",keyCache.flock.toString());
        assertEquals("Il_TNWM~^LsF}zcGnBzJjjpaYtLuZMZzajuyywWe",keyCache.plock.toString());
    }

    public void testAddBinary()
    {
        testInit();
        keyCache.open();
        assertEquals(0,CError.errorCode());
        
        keyCache.clear();
        keyCache.code.setValue("aaa");
        keyCache.flock.setValue("KByTDOCc\\eM[__UH}[uuLqK\177TlDQXgs__AjYuLLk");
        keyCache.add();
        assertEquals(0,CError.errorCode());

        keyCache.codekey.set();
        keyCache.next();
        assertEquals(0,CError.errorCode());
        assertEquals("KByTDOCc\\eM[__UH}[uuLqK\177TlDQXgs__AjYuLLk",keyCache.flock.toString());
        assertEquals("",keyCache.plock.toString().trim());
    }

    public void testPutBinary()
    {
        testAddBinary();

        keyCache.flock.setValue(" ByTDOCc\\eM[__UH}[uuLqK\177TlDQXgs__AjYuLLk");
        keyCache.put();
        assertEquals(0,CError.errorCode());

        keyCache.codekey.set();
        keyCache.next();
        assertEquals(0,CError.errorCode());
        assertEquals(" ByTDOCc\\eM[__UH}[uuLqK\177TlDQXgs__AjYuLLk",keyCache.flock.toString());
        assertEquals("",keyCache.plock.toString().trim());
    }
    

    public void testNavigateWithBinary()
    {
        testInit();
        keyCache.open();
        assertEquals(0,CError.errorCode());
        
        keyCache.clear();
        keyCache.code.setValue("aaa");
        keyCache.flock.setValue("KByTDOCc\\eM[__UH}[uuLqK\177TlDQXgs__AjYuLLk");
        keyCache.add();
        assertEquals(0,CError.errorCode());

        keyCache.clear();
        keyCache.code.setValue("aab'");
        keyCache.flock.setValue("KByTDOCc\\eM[__UH}[uuLqK\177TlDQXgs__AjYuLLk");
        keyCache.add();
        assertEquals(0,CError.errorCode());

        assertEquals(0,CError.errorCode());
        keyCache.clear();
        keyCache.code.setValue("aac");
        keyCache.flock.setValue("KByTDOCc\\eM[__UH}[uuLqK\177TlDQXgs__AjYuLLk");
        keyCache.add();
        assertEquals(0,CError.errorCode());
        
        // scan through
        
        keyCache.set(keyCache.codekey);
        keyCache.next();
        assertEquals("aaa",keyCache.code.toString().trim());
        keyCache.next();
        assertEquals("aab'",keyCache.code.toString().trim());
        keyCache.next();
        assertEquals("aac",keyCache.code.toString().trim());
        
        // bounce around
        
        keyCache.previous();
        assertEquals("aab'",keyCache.code.toString().trim());
        keyCache.next();
        assertEquals("aac",keyCache.code.toString().trim());
        keyCache.previous();
        assertEquals("aab'",keyCache.code.toString().trim());
        keyCache.previous();
        assertEquals("aaa",keyCache.code.toString().trim());
        keyCache.next();
        assertEquals("aab'",keyCache.code.toString().trim());
        keyCache.previous();
        assertEquals("aaa",keyCache.code.toString().trim());
        
        // go straight to it
        
        keyCache.clear();
        keyCache.code.setValue("aab'");
        keyCache.get(keyCache.codekey);
        assertEquals(0,CError.errorCode());
        
        // delete it
        assertEquals(4,keyCache.records());

        keyCache.delete();
        assertEquals(0,CError.errorCode());
        
        assertEquals(3,keyCache.records());
        
        keyCache.set(keyCache.codekey);
        keyCache.next();
        assertEquals("aaa",keyCache.code.toString().trim());
        keyCache.next();
        assertEquals("aac",keyCache.code.toString().trim());
        
    }
    
    public void testAllChars()
    {
        testInit();
        keyCache.open();
        
        for (int scan=0;scan<256;scan++) {
            
            String lkup=String.valueOf(scan);
            while (lkup.length()<3) lkup="0"+lkup;
            
            keyCache.code.setValue(lkup);
            keyCache.flock.setValue(String.valueOf((char)scan));
            keyCache.add();
            assertEquals(0,CError.errorCode());
        }
        
        keyCache.codekey.setStart();
        for (int scan=0;scan<256;scan++) {
            keyCache.next();

            String lkup=String.valueOf(scan);
            while (lkup.length()<3) lkup="0"+lkup;
            assertEquals(lkup,keyCache.code.toString().trim());
            assertEquals(scan,(int)keyCache.flock.toString().charAt(0));
        }
        
    }
    
}
