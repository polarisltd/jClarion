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
package org.jclarion.clarion.jdbc;

import java.sql.Connection;
import java.sql.SQLException;

import junit.framework.TestCase;

public class JDBCSourceTest extends TestCase {

    public void testStuff() throws SQLException
    {
        Connection c = JDBCSource.get("mvntest").newConnection();
        c.createStatement().execute("begin");
        c.createStatement().executeQuery("select txid_current()");
        c.setAutoCommit(false);
        c.createStatement().executeQuery("select count(*) from test");
        c.createStatement().execute("commit");
        c.createStatement().execute("rollback");
        c.createStatement().execute("commit");
        c.createStatement().execute("rollback");
    }
    
    
    public void testCreateConnection() throws SQLException
    {
        assertNotNull(JDBCSource.get("mvntest"));
        assertSame(JDBCSource.get("mvntest"),JDBCSource.get("mvntest"));
        assertNotSame(JDBCSource.get("mvntest"),JDBCSource.get("mvntest2"));

        assertNotNull(JDBCSource.get("mvntest").getConnection());

        assertSame(JDBCSource.get("mvntest").getConnection(),JDBCSource.get("mvntest").getConnection());
        assertNotSame(JDBCSource.get("mvntest").getConnection(),JDBCSource.get("mvntest2").getConnection());
    }
}
