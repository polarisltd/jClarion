package clarion;

import clarion.HideAccessAccounts;
import clarion.HideAccessTransactions;
import clarion.HideRelateAccounts;
import clarion.HideRelateTransactions;
import clarion.Main;

public class Cardrbc0
{
	public static HideAccessAccounts hideAccessAccounts;
	public static HideRelateAccounts hideRelateAccounts;
	public static HideAccessTransactions hideAccessTransactions;
	public static HideRelateTransactions hideRelateTransactions;

	public static void cARDRBC0DctInit()
	{
		Main.relateAccounts=Cardrbc0.hideRelateAccounts;
		Main.relateTransactions=Cardrbc0.hideRelateTransactions;
	}
	public static void cARDRBC0DctKill()
	{
		Cardrbc0.hideRelateAccounts.kill();
		Cardrbc0.hideRelateTransactions.kill();
	}
	public static void cARDRBC0FilesInit()
	{
		Cardrbc0.hideRelateAccounts.init();
		Cardrbc0.hideRelateTransactions.init();
	}
}
