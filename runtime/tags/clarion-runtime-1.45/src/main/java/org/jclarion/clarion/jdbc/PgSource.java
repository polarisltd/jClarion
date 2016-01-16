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

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Logger;

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
        try {
            if (tConnection!=null && tConnection.connection!=null && tConnection.connection.isClosed()) {
                log.warning("Connection Lost - invisibly reconnecting");
                tConnection=null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        if (tConnection==null || tConnection.connection==null) {
            tConnection=new MyConnection(newConnection());
            synchronized(this.connection) {
                this.connection.put(Thread.currentThread(),tConnection);
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
                result = DriverManager.getConnection("jdbc:postgresql://"+connect[0]+":"+connect[3]+"/"+connect[1],p);
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
        
        if (result==null) {
            String details = CConfig.getProperty("altsource",name,"","db.properties").toString();
            String connect[] = PgSourceFinder.getHostData(details);
            if (connect.length>=4) {
                try {
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
}
