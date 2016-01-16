package org.jclarion.clarion;

import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.runtime.CRun;

public class ClarionNotifyEvent extends ClarionEvent
{
    private int code;
    private int thread;
    private ClarionObject parameter;
    
    public ClarionNotifyEvent(int code,ClarionObject parameter)
    {
        super(Event.NOTIFY,0,false);
        this.code=code;
        this.parameter=parameter;
        this.thread=CRun.getThreadID();
    }

    public int getCode() {
        return code;
    }

    public int getThread() {
        return thread;
    }

    public ClarionObject getParameter() {
        return parameter;
    }
}
