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
package org.jclarion.clarion.swing;

import org.jclarion.clarion.runtime.CWinImpl;

public class SwingTask implements Runnable
{
    private Runnable task;

    public SwingTask(Runnable task)
    {
        this.task=task;
    }

    @Override
    public void run() {
        CWinImpl.run(task);
    }
    
}
