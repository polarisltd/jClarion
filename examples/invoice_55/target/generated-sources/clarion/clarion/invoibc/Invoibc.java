package clarion.invoibc;

import clarion.invoibc0.Invoibc0;

@SuppressWarnings("all")
public class Invoibc
{

	public static void dctinit()
	{
		Invoibc0.invoibc0Dctinit();
		Invoibc0.invoibc0Filesinit();
	}
	public static void dctkill()
	{
		Invoibc0.invoibc0Dctkill();
	}
}
