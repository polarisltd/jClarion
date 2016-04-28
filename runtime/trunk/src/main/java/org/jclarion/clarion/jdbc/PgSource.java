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

import java.io.IOException;
import java.io.InputStream;
import java.io.Writer;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Logger;

import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.primative.ActiveThreadMap;
import org.jclarion.clarion.primative.Cleanup;
import org.jclarion.clarion.runtime.CConfig;
import org.jclarion.clarion.runtime.CRun;

public class PgSource implements AbstractJDBCSource
{
    public static Logger log = Logger.getLogger(JDBCSource.class.getName());
    
    private String name;
    
    private static class MyConnection implements Cleanup
    {
        public Map<Object,Object> map;
        public Connection connection;
        
        public MyConnection(Connection connection2) {
            connection=connection2;
            map=new HashMap<Object, Object>();
        }

        @Override
        public void cleanup() {
            Connection t = connection;
            if (t!=null) {
                try {
                    t.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private ActiveThreadMap<MyConnection> connection;
    
    public PgSource(String name)
    {
        connection=new ActiveThreadMap<MyConnection>();
        connection.schedulePack(15000); // every 15 seconds 
        
        this.name=name;
        CRun.addShutdownHook(new Runnable() { 
            public void run()
            {
                connection.clear();
            }
        } );
        
    }
    

    @Override
    public Connection getConnection() throws SQLException 
    {
        return getMyConnection().connection;
    }
    
    private MyConnection getMyConnection() throws SQLException
    {
        MyConnection tConnection;
        synchronized(this.connection) {
            tConnection=this.connection.get(Thread.currentThread());
        }
        
        boolean refuseToReConnect=false;
        
        try {
            if (tConnection!=null && tConnection.connection!=null && tConnection.connection.isClosed()) {
            	if (tConnection.connection!=null && !tConnection.connection.getAutoCommit() ) {
            		if (tConnection.map.get(ClarionSQLFile.FORCED_AUTO_COMMIT)==null) {
            			refuseToReConnect=true;
            		}
            	}
                log.warning("Connection Lost - invisibly reconnecting");
                tConnection=null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (refuseToReConnect) {
    		throw new SQLException("Connection failed while in middle of a transaction. Refusing to reconnect until rollback");
        }
        
        if (tConnection==null || tConnection.connection==null) {
            tConnection=new MyConnection(newConnection());
            synchronized(this.connection) {
                this.connection.put(Thread.currentThread(),tConnection);
            }

            if (tConnection.connection!=null) {
                Statement s = tConnection.connection.createStatement();
                try {
                    ResultSet rs = s.executeQuery("SHOW server_encoding");
                    try {
                        if (rs.next()) {
                            tConnection.map.put("encoding",rs.getString(1));
                        }
                    } finally {
                        rs.close();
                    }
                } finally {
                    s.close();
                }
            }
        }
        if (tConnection.connection==null) throw new SQLException("Connect establish connection"); 
        return tConnection;
    }
    
    public void copyConnection(Thread from,Thread to)
    {
        synchronized(this.connection) {
            this.connection.put(to,this.connection.get(from));
        }
    }

    @Override
    public Connection newConnection()
    {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
        }
        
        Connection result=null;
        
        try {
            String details = CConfig.getProperty("source",name,"","db.properties").toString();
            String connect[] = PgSourceFinder.getHostData(details);
            if (connect.length>=4) {
                Properties p = new Properties();
                p.setProperty("user",connect[1]);
                p.setProperty("password",connect[2]);
                String dbUrl = "jdbc:postgresql://"+connect[0]+":"+connect[3]+"/"+connect[1];
                log.info("Connecting to DB! "+dbUrl);
                result = DriverManager.getConnection(dbUrl,p);
                try {
                    String ip = InetAddress.getByName(connect[0]).getHostAddress();
                    CConfig.setProperty("altsource",name,ip+":"+connect[1]+":"+connect[2]+":"+connect[3],"db.properties");
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        if (result==null) {  // still not connected? Then use alternative source.
            String details = CConfig.getProperty("altsource",name,"","db.properties").toString();
            String connect[] = PgSourceFinder.getHostData(details);
            if (connect.length>=4) {
                try {
                    log.info("Connecting to DB!");
                    Properties p = new Properties();
                    p.setProperty("user",connect[1]);
                    p.setProperty("password",connect[2]);
                    result = DriverManager.getConnection("jdbc:postgresql://"+connect[0]+":"+connect[3]+"/"+connect[1],p);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return result;
    }
    

    @Override
    public String getName() {
        return name;
    }


    public void put(Object key,Object value) throws SQLException
    {
        if (value==null) {
            getMyConnection().map.remove(key);
        } else {
            getMyConnection().map.put(key,value);
        }
    }
    
    public Object get(Object key) throws SQLException
    {
        return getMyConnection().map.get(key);
    }
    
    
    public static void decodeSQLASCIIString(InputStream is,Writer c_helper) throws IOException
    {
        while ( true ) {
            int b1 = is.read();
            if (b1==-1) break;
            
            if ((b1&0xe0)==0xc0) {
                // could be UTF-8
                int b2 = is.read();
                if (b2!=-1 && (b2&0xc0)==0x80) {
                    // is UTF-8 !
                    c_helper.write(((b1&31)<<6)+(b2&63));
                    continue;
                } else {
                    // incorrect!
                    c_helper.write(b1);
                    if (b2!=-1) {
                        c_helper.write(b2);
                    }
                }
            } else {
                c_helper.write(b1);
            }
        }
        is.close();
    }

    
	@Override
	public void close() {
        MyConnection tConnection;
        synchronized(this.connection) {
            tConnection=this.connection.remove(Thread.currentThread());
        }
        if (tConnection==null) return;
        if (tConnection.connection!=null) {
        	try {
        		tConnection.connection.close();
        	} catch (SQLException ex) { }
        }
	}


	@Override
	public void begin() {
		try {
			MyConnection mc = getMyConnection();
			if (mc.map.get(ClarionSQLFile.FORCED_AUTO_COMMIT)!=null) {
				mc.map.remove(ClarionSQLFile.FORCED_AUTO_COMMIT);
				// already in a transaction frame
				return;
			}
			
			if (mc.connection.getAutoCommit()) {
				try {
					mc.connection.rollback();
				} catch (SQLException ex){  }
				mc.connection.setAutoCommit(false);
			}
		} catch (SQLException e) {
			ClarionSQLFile.setError(null,e);
			return;
		}		
	}

	@Override
	public void rollback() {
		try {
			MyConnection mc = getMyConnection();
			try {
				mc.connection.rollback();
			} catch (SQLException ex){
				ClarionSQLFile.setError(null,ex);
			}
			try {
				mc.connection.setAutoCommit(true);
			} catch (SQLException ex){  }
			mc.map.remove(ClarionSQLFile.FORCED_AUTO_COMMIT);
		} catch (SQLException e) {			
			ClarionSQLFile.setError(null,e);
		}		
		
        MyConnection tConnection;
        synchronized(this.connection) {
            tConnection=this.connection.get(Thread.currentThread());
        }
        if (tConnection==null) return;
        if (tConnection.connection==null) return;
        try {
        	// if open and in auto commit then keep the link
			if (!tConnection.connection.isClosed() && tConnection.connection.getAutoCommit()) return;  
		} catch (SQLException e) {
			e.printStackTrace();
		}
        close();
	}

	@Override
	public void commit() {
		try {
			MyConnection mc = getMyConnection();
			try {
				mc.connection.commit();
			} catch (SQLException ex){  
				ClarionSQLFile.setError(null,ex);				
			}
			try {
				mc.connection.rollback();
			} catch (SQLException ex){  }
			try {
				mc.connection.setAutoCommit(true);
			} catch (SQLException ex){  }
		} catch (SQLException e) {
			ClarionSQLFile.setError(null,e);
			return;
		}		
	}
}
