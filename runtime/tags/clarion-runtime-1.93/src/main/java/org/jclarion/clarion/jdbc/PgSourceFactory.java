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

import org.jclarion.clarion.runtime.CConfig;

public class PgSourceFactory implements AbstractSourceFactory 
{

    @Override
    public AbstractJDBCSource createSource(String name) 
    {
        String cfg = CConfig.getProperty("source",name,"","db.properties");
        if (cfg.equals("")) {
            PgSourceFinder psf = new PgSourceFinder(name);
            psf.run();
            if (psf.getSelection()==null) {
                System.exit(1);
            }
            CConfig.setProperty("source",name,psf.getSelection(),"db.properties");
            return new PgSource(name);
        } else {
            return new PgSource(name);
        }
    }
}
