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

import java.util.Properties;

import java.io.IOException;
import java.io.InputStream;

public class PgProperties {

    private static Properties p;
    
    public static Properties get()
    {
        if (p==null) {
            p=new Properties();
            ClassLoader cl = PgProperties.class.getClassLoader();
            InputStream is = cl.getResourceAsStream("resources/schema.properties");
            if (is!=null) {
                try {
                    p.load(is);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return p;
    }
}
