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

import java.util.Stack;
import java.util.logging.Logger;

import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.primative.ActiveThreadMap;

public class CErrorImpl 
{
    private static Logger log = Logger.getLogger(CErrorImpl.class.getName());
	private static ActiveThreadMap<CErrorImpl> instance =new ActiveThreadMap<CErrorImpl>();
    
    public static CErrorImpl getInstance()
    {
    	CErrorImpl i = instance.get(Thread.currentThread());
    	if (i==null) {
    		i=new CErrorImpl();
    		instance.put(Thread.currentThread(),i);
    	}
        return i;
    }
    
    private static class ErrorStack
    {
        private int errorcode;
        private String error;    	
        private String fileerrorcode;
        private String fileerror;    	
        private String file;
        
        public ErrorStack clone()
        {
        	ErrorStack e = new ErrorStack();
        	e.errorcode=errorcode;
        	e.error=error;
        	e.fileerrorcode=fileerrorcode;
        	e.fileerror=fileerror;
        	e.file=file;
        	return e;
        }
    }
    
    private Stack<ErrorStack> errorStack=new Stack<ErrorStack>();    
    private ErrorStack error=new ErrorStack(); 
    
    private CErrorImpl()
    {
    	clearError();
    }
    
    public void setError(int errorcode,String error)
    {
    	if (error==null) error="";
        this.error.error=error;
        this.error.errorcode=errorcode;
        if (errorcode!=0)log.fine("setError "+errorcode+" : "+error);
    }

    public void setFileError(String errorcode,String error,String errorfile)
    {
    	if (error==null) error="";
    	if (errorcode==null) errorcode="";
    	if (errorfile==null) errorfile="";
        this.error.fileerror=error;
        this.error.fileerrorcode=errorcode;;
        this.error.file=errorfile;
        if (errorcode!=null && !errorcode.equals(""))log.fine("setFileError "+errorcode+" : "+errorfile+" : "+error);
    }
    
    public void clearError()
    {
        setError(0,"OK");
        setFileError("","","");
    }
    
    public int getErrorCode()
    {
        return error.errorcode;
    }
    
    public String getError()
    {
        return error.error;
    }

    public String getFileErrorCode()
    {
        return error.fileerrorcode;
    }
    
    public String getFileError()
    {
        return error.fileerror;
    }

    public String getErrorFile()
    {
        return error.file;
    }
    
    public void pushErorrs()
    {
    	errorStack.push(error);
    	error=error.clone();
    }
    
    public void popErrors()
    {
    	if (errorStack.isEmpty()) return;
    	error=errorStack.pop();
    }
    
}
