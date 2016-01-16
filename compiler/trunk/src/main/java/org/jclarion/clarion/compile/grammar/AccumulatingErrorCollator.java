package org.jclarion.clarion.compile.grammar;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.lang.Lexer;

public class AccumulatingErrorCollator extends AbstractErrorCollator
{
	public static class Entry
	{
		private boolean 				warning;
		private String 					message;
		private String 					source;
		private int	   					lineNumber;
		private int						charStart;
		private int						charEnd;
		private StackTraceElement[] 	stackTrace;
		private Throwable				exception;
		
		public Entry(boolean warning,String message, String source,int lineNumber,int charStart,int charEnd,Throwable exception) {
			super();
			this.warning=warning;
			this.message = message;
			this.source = source;
			this.lineNumber = lineNumber;
			this.exception = exception;
			this.charStart=charStart;
			this.charEnd=charEnd;
			stackTrace=Thread.currentThread().getStackTrace();
		}

		public String getMessage() {
			return message;
		}

		public String getSource() {
			return source;
		}

		public int getLineNumber() {
			return lineNumber;
		}

		public StackTraceElement[] getStackTrace() {
			return stackTrace;
		}

		public Throwable getException() {
			return exception;
		}

		public int getCharStart() {
			return charStart;
		}

		public int getCharEnd() {
			return charEnd;
		}
		
		public boolean isWarning()
		{
			return warning;
		}
	}
	
	private List<Entry> errors=new ArrayList<Entry>();
	
	@Override
	public void error(Lexer source, int lineNumber, int charStart,int charEnd,String message, Throwable t,boolean canRecover) 
	{
		errors.add(new Entry(false,message,source.getStream().getName(),lineNumber,charStart,charEnd,t));
		
		if (!canRecover) {
			if (t==null) {
				throw new AccumulatingClarionCompileError(message);
			} else {
				throw new AccumulatingClarionCompileError(message,t);
			}
		} 
	}
	
	public List<Entry> getErrors()
	{
		return errors;
	}
	
	public void clearErrors()
	{
		errors.clear();
	}

	@Override
	public void warning(Lexer source, int lineNumber, int charStart,int charEnd, String message) {
		errors.add(new Entry(true,message,source.getStream().getName(),lineNumber,charStart,charEnd,null));
	}

}
