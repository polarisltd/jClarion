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
package org.jclarion.clarion.runtime;

import org.jclarion.clarion.crash.Crash;

public class MonitoredRunnable implements Runnable
{
    private Runnable target;

    public MonitoredRunnable(Runnable target)
    {
        this.target=target;
    }

    @Override
    public void run() {
        try {
            CRun.initThread();
            target.run();
        } catch (Throwable t ) {
            Crash.getInstance().log(t);
            Crash.getInstance().crash();
        } finally {
            ThreadCleanupTasks.cleanup();
        }
    }

}
