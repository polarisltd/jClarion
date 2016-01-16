package org.jclarion.clarion.print;

public class ReportFactory {

	private static ReportFactory sInstance;
	
	public static ReportFactory getInstance()
	{
		if (sInstance==null) {
			synchronized(ReportFactory.class) {
				if (sInstance==null) {
					sInstance=new ReportFactory();
				}
			}
		}
		return sInstance;
	}
	
	public static void setInstance(ReportFactory factory)
	{
		sInstance=factory;
	}
	
	public ReportFactory()
	{
	}

	public Page newPage(OpenReport report)
	{
		return new Page(report);
	}
}
