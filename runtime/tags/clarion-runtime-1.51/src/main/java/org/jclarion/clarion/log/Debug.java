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
package org.jclarion.clarion.log;

import java.io.IOException;
import java.util.Properties;
import java.util.logging.LogManager;

import org.jclarion.clarion.util.SharedOutputStream;

public class Debug 
{
    @SuppressWarnings("deprecation")
    public Debug()
    {
        Properties p = new Properties();
        p.setProperty("handlers","java.util.logging.ConsoleHandler");
        p.setProperty(".level","INFO");
        p.setProperty("org.jclarion.level","FINEST");
        p.setProperty("java.util.logging.ConsoleHandler.level","FINEST");
        p.setProperty("java.util.logging.ConsoleHandler.formatter","java.util.logging.SimpleFormatter");

        SharedOutputStream sos = new SharedOutputStream();
        p.save(sos,"temp");
        try {
            LogManager.getLogManager().readConfiguration(sos.getInputStream());
        } catch (SecurityException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
