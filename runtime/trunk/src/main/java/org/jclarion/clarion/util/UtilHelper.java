package org.jclarion.clarion.util;

public class UtilHelper {

	public static StackTraceElement[] setCodePoint(){
        StackTraceElement    trace[];
        trace=Thread.currentThread().getStackTrace();
		return trace;		
	}

	/**
	 * 
	 * @param trace
	 * @return
	 * 
	 * usage example:  log.fine("create() ENTRY \n"+UtilHelper.formatStackTrace(UtilHelper.setCodePoint()));
	 */
	public static String formatStackTrace(StackTraceElement[] trace)
	    {
	        StringBuilder sb = new StringBuilder();
	        for(StackTraceElement e : trace){
	        	sb.append(e.toString()).append('\n');
	        }
	        return sb.toString();
	    }
	
	
}
