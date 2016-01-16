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

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.runtime.CRun;

/**
 * Model JDBC connection - shared by SQL files
 * 
 * @author barney
 *
 */
public class JDBCSource 
{
    private static Map<String,AbstractJDBCSource> sources=new HashMap<String, AbstractJDBCSource>();
    
    private static AbstractSourceFactory factory=new PgSourceFactory();
    
    public static AbstractJDBCSource get(String name)
    {
        name=name.toLowerCase().trim();
        AbstractJDBCSource result = sources.get(name);
        if (result==null) {
            synchronized(sources) {
                result = sources.get(name);
            }
            
            if (result==null) {
                result = factory.createSource(name);
                synchronized(sources) {
                    
                    if (sources.size()==0) {
                        CRun.addShutdownHook(new Runnable() { 
                            public void run()
                            {
                                sources.clear();
                            }
                        } );
                    }
                    sources.put(name,result);
                }
            }
        }
        return result;
    }

    public static void register(AbstractJDBCSource source)
    {
        synchronized(sources) {
            sources.put(source.getName().toLowerCase(),source);
        }
    }
}
