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

import java.io.File;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.runtime.CConfig;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CWin;

public class PgManager 
{
    public PgManager()
    {
    }
    
    public static void main(String args[])
    {
        PgManager m = new PgManager();
        m.init(Clarion.newString("direct"));
    }
    
    public void init(ClarionString name)
    {
        PgSourceFinder s = new PgSourceFinder(null,name.toString().trim());
        s.run();
    }

    public void backup(ClarionString _name)
    {
        String name=_name.toString().trim();
        try {
            Connection c = JDBCSource.get(name).newConnection();
            try {
                PgBackup pb = new PgBackup(c);
                
                String directory = CConfig.getProperty("backupdir",name,".."+File.separator+name+"backup","backup.properties").toString();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                
                String basefile = directory+File.separator+sdf.format(new Date(System.currentTimeMillis()));
                
                String file = basefile;
                int scan=-1;
                while (CFile.isFile(file+".zip")) {
                    scan++;
                    file=basefile+"_"+((char)('a'+scan));
                }
                
                pb.setFileName(file+".zip");
                if (pb.dialog()) {
                    pb.backup();
                    
                    file = pb.getFileName();
                    int last = file.lastIndexOf(File.separator);
                    if (last>-1) {
                        CConfig.setProperty("backupdir",name,file.substring(0,last),"backup.properties");                        
                    }
                    
                }
            } finally {
                c.close();
            }
        } catch (SQLException e) {
            CWin.message(
                    new ClarionString("Database Error\n"+e.getMessage()),
                    new ClarionString("Backup Failed"),
                    Icon.HAND);
            e.printStackTrace();
        }
    }

}
