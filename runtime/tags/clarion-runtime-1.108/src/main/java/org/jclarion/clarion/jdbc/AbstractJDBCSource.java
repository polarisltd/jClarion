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

public interface AbstractJDBCSource
{
    public abstract String     getName();
    public abstract void close();
    public abstract Connection getConnection() throws SQLException;
    public abstract Connection newConnection() throws SQLException;
    public abstract void put(Object key,Object value) throws SQLException;
    public abstract Object get(Object key) throws SQLException;
	public abstract void begin();
	public abstract void rollback();
	public abstract void commit();
}
