package org.jclarion.clarion.swing.gui;

public class RemoteCommand
{
	public int			command;
	public RemoteWidget source;
	public Object[]	    params;
	public int 			response;
	
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		sb.append("cmd:").append(command);
		sb.append(" resp:").append(response);
		if (source!=null) {
			sb.append(" src:").append(source.getClass().getName());
		}
		sb.append(" params:[");
		for (int scan=0;scan<params.length;scan++) {
			if (scan>0) sb.append(",");
			sb.append(params[scan]);
		}
		sb.append("]");
		return sb.toString();
	}
}
