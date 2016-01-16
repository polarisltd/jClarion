package org.jclarion.clarion.appgen.template;

public class TemplateExecutionError extends RuntimeException
{
	private static final long serialVersionUID = 1384073430087002612L;
	private String message;

	public TemplateExecutionError(String message, Throwable cause)
	{
		super(message,cause);
		this.message=message;
	}

	public TemplateExecutionError(String message)
	{
		super(message);
		this.message=message;
	}

	@Override
	public String getMessage() {
		return message;
	}
	
	public void append(String cmd) {
		message=message+cmd;
	}

	

}
