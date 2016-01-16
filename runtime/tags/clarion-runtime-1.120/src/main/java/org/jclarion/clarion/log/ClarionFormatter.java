package org.jclarion.clarion.log;

import java.util.Calendar;
import java.util.logging.Formatter;
import java.util.logging.LogRecord;

public class ClarionFormatter extends Formatter
{
	@Override
	public String format(LogRecord record) {
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(record.getMillis());
		StringBuilder sb = new StringBuilder();
		appendNumber(sb,c.get(Calendar.MONTH)-Calendar.JANUARY+1);
		sb.append('/');
		appendNumber(sb,c.get(Calendar.DAY_OF_MONTH));
		sb.append(' ');
		appendNumber(sb,c.get(Calendar.HOUR_OF_DAY));
		sb.append(':');
		appendNumber(sb,c.get(Calendar.MINUTE));
		sb.append(':');
		appendNumber(sb,c.get(Calendar.SECOND));
		sb.append(' ');
		sb.append(record.getLevel().getName().charAt(0));
		sb.append(' ');
		String name = record.getSourceClassName();
		if (name.startsWith("clarion.")) {
			sb.append(name,8,name.length());
		} else if (name.startsWith("org.jclarion.clarion.")) {
			sb.append(name,21,name.length());
		} else {
			sb.append(name);
		}
		sb.append(" - ");
		sb.append(record.getMessage());
		sb.append('\n');
		Throwable t=  record.getThrown();
		if (t!=null) {
			sb.append(t.getMessage());
			sb.append("\n");
			for (StackTraceElement st : t.getStackTrace()) {
				sb.append(st.toString());
				sb.append("\n");
			}
		}
		return sb.toString();
	}

	private void appendNumber(StringBuilder sb, int i) 
	{
		if (i<10) {
			sb.append('0');
			sb.append(i);
		} else {
			sb.append(i);
		}
	}
	

}
