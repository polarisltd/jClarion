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

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import junit.framework.TestCase;

public class CConfigTest extends TestCase {

    public void setUp() throws IOException
    {
        File f;
        f = new File("test.ini");
        f.delete();
        BufferedWriter bw=new BufferedWriter(new FileWriter(f));
        for (int scan=0;scan<lines.length;scan++) {
            bw.write(lines[scan]);
            bw.write('\n');
        }
        bw.close();
        
        f = new File("test.properties");
        f.delete();
    }

    public void testImport()
    {
        new FileConfigImpl("test.ini");
        File f = new File("test.properties");
        assertTrue(f.exists());
    }

    public void testImport2()
    {
        new FileConfigImpl("test.ini");
        File f = new File("test.properties");
        assertTrue(f.exists());
    }

    public void testAllCharsEncodeDecodeCorrectly()
    {
        CConfigImpl c = new FileConfigImpl("test.ini");
        
        StringBuilder sb=new StringBuilder();
        for (int i=0;i<2000;i++) {
            sb.setLength(0);
            sb.append((char)i);
            sb.append((char)(i+1));
            sb.append((char)(i+2));
            sb.append((char)(i+3));
            sb.append((char)(i+4));
            String s = sb.toString();
            c.setProperty(s,s,s);
        }
        
        c.finish();
        
        c = new FileConfigImpl("test.ini");
        for (int i=0;i<2000;i++) {
            sb.setLength(0);
            sb.append((char)i);
            sb.append((char)(i+1));
            sb.append((char)(i+2));
            sb.append((char)(i+3));
            sb.append((char)(i+4));
            String s = sb.toString();
            String k = c.getProperty(s,s);
            assertNotNull(s,k);
            assertEquals(s,s.toLowerCase(),k.toLowerCase());
        }
        
    }
    
    public class RaceThread extends Thread
    {
    	private CConfigImpl i;
		private String[] keys;
		private int ok;
		private Map<String,String> params;
		private List<String> sk;
		private int loop;

		public RaceThread(CConfigImpl i,Map<String,String> params,int loop,String... keys)
    	{
    		this.i=i;
    		this.keys=keys;
    		this.params=params;
    		sk=new ArrayList<String>();
    		sk.addAll(params.keySet());
    		this.loop=loop;
    	}
		
		public void run()
		{
			for (int scan=0;scan<loop;scan++) {
				i.setProperty("test",keys[scan%keys.length],"V:"+scan);
				
				if (scan%3==0) {
					String key = sk.get((int)Math.random()*sk.size());
					String val = params.get(key);
					
					int indx = key.indexOf('.');
					
					try {
						assertEquals(val,i.getProperty(key.substring(0,indx),key.substring(indx+1)));
						ok++;
					} catch (Exception ex) { 
						ex.printStackTrace();
					}
					// do a read test
				}
			}
		}
    }
    
    private void add(String file,String... contents) throws IOException
    {
    	FileWriter fw = new FileWriter(file,true);
    	for (String s : contents) {
    		fw.write(s);
    		fw.write('\n');
    	}
    	fw.close();
    }
    
    private void copyFile(String from,String to) throws IOException 
    {
    	FileOutputStream fos = new FileOutputStream(to);
    	FileInputStream fis = new FileInputStream(from);
    	byte[] buffer = new byte[65536];
    	while ( true ) {
    		int len = fis.read(buffer);
    		if (len<=0) break;
    		fos.write(buffer,0,len);
    	}
    	fos.close();
    	fis.close();
    }
    
    public void testRepairWithNewFile() throws InterruptedException,IOException
    {
    	CConfigImpl i = new FileConfigImpl("test.ini");
    	i.finish();
    	assertEquals("133",i.getProperty("browseAccountNotifications", "XPos"));
    	
    	copyFile("test.properties","test.properties.new");
    	add("test.properties.new","browseaccountnotifications.xpos=120");
    	add("test.properties.new","browseaccountnotifications.foo=bar");

    	i = new FileConfigImpl("test.ini");
    	i.finish();
    	assertEquals("120",i.getProperty("browseAccountNotifications", "XPos"));
    	assertEquals("bar",i.getProperty("browseAccountNotifications", "Foo"));
    	assertEquals("83",i.getProperty("browseAccountNotifications", "YPos"));
    	assertFalse((new File("test.properties.new")).exists());
    	assertFalse((new File("test.properties.old")).exists());
    	
    }

    public void testRepairWithLargeOldFile() throws InterruptedException,IOException
    {
    	CConfigImpl i = new FileConfigImpl("test.ini");
    	i.finish();
    	assertEquals("133",i.getProperty("browseAccountNotifications", "XPos"));
    	
    	copyFile("test.properties","test.properties.old");
    	add("test.properties.old","browseaccountnotifications.xpos=120");
    	add("test.properties.old","browseaccountnotifications.foo=bar");

    	i = new FileConfigImpl("test.ini");
    	i.finish();
    	assertEquals("120",i.getProperty("browseAccountNotifications", "XPos"));
    	assertEquals("bar",i.getProperty("browseAccountNotifications", "Foo"));
    	assertEquals("83",i.getProperty("browseAccountNotifications", "YPos"));
    	assertFalse((new File("test.properties.new")).exists());
    	assertFalse((new File("test.properties.old")).exists());
    	
    }

    public void testRepairWithSmallerNewFile() throws InterruptedException,IOException
    {
    	CConfigImpl i = new FileConfigImpl("test.ini");
    	i.finish();
    	assertEquals("133",i.getProperty("browseAccountNotifications", "XPos"));
    	
    	copyFile("test.properties","test.properties.old");
    	(new File("test.properties")).delete();
    	add("test.properties","browseaccountnotifications.xpos=120");
    	add("test.properties","browseaccountnotifications.foo=bar");
    	
    	i = new FileConfigImpl("test.ini");
    	i.finish();
    	assertEquals("133",i.getProperty("browseAccountNotifications", "XPos"));
    	assertNull(i.getProperty("browseAccountNotifications", "Foo"));
    	assertEquals("83",i.getProperty("browseAccountNotifications", "YPos"));
    	assertFalse((new File("test.properties.new")).exists());
    	assertFalse((new File("test.properties.old")).exists());
    	
    }
    
    public void testRacingInstancesWithFlushing() throws InterruptedException 
    {
        CConfigImpl i1 = new FileConfigImpl("test.ini");
        CConfigImpl i2 = new FileConfigImpl("test.ini");
        
        Map<String,String> params=new HashMap<String,String>();
        params.putAll(i1.getProperties());

        
        RaceThread r1 = new RaceThread(i1,params,10000,"foo","bar","baz");
        RaceThread r2 = new RaceThread(i2,params,10000,"this","baz","bee");
        
        r1.start();
        r2.start();
        
        r1.join();
        r2.join();
        
        long start=System.currentTimeMillis();
        
        while (System.currentTimeMillis()<start+1500) {
        	RaceThread r3 = new RaceThread(i1,params,100000,"foo","bar","baz");
        	r3.start();
        	r3.join();
        }
        
        i1 = new FileConfigImpl("test.ini");
        
        for (Map.Entry<String,String> scan : params.entrySet()) {
        	String key = scan.getKey();
        	int dot = key.indexOf('.');
        	assertEquals(scan.getValue(),i1.getProperty(key.substring(0,dot),key.substring(dot+1)));
        }
    }
    
    public void testRacingInstances() throws InterruptedException
    {
        CConfigImpl i1 = new FileConfigImpl("test.ini");
        CConfigImpl i2 = new FileConfigImpl("test.ini");
        
        i1.setProperty("LTest","KeyA","ValueA");
        assertEquals("ValueA",i1.getProperty("LTest","KeyA"));
        assertEquals("ValueA",i2.getProperty("LTest","KeyA"));

        i2.setProperty("LTest","KeyB","ValueB");
        assertEquals("ValueA",i1.getProperty("LTest","KeyA"));
        assertEquals("ValueA",i2.getProperty("LTest","KeyA"));
        assertEquals("ValueB",i1.getProperty("LTest","KeyB"));
        assertEquals("ValueB",i2.getProperty("LTest","KeyB"));

        i1.setProperty("LTest","KeyC","ValueC");
        i2.setProperty("LTest","KeyD","ValueD");
        
        Thread.sleep(6000);

        assertEquals("ValueA",i1.getProperty("LTest","KeyA"));
        assertEquals("ValueA",i2.getProperty("LTest","KeyA"));
        assertEquals("ValueB",i1.getProperty("LTest","KeyB"));
        assertEquals("ValueB",i2.getProperty("LTest","KeyB"));
        assertEquals("ValueC",i1.getProperty("LTest","KeyC"));
        assertEquals("ValueC",i2.getProperty("LTest","KeyC"));
        assertEquals("ValueD",i1.getProperty("LTest","KeyD"));
        assertEquals("ValueD",i2.getProperty("LTest","KeyD"));
}
    
    public void testGetProperty()
    {
        assertEquals("10.100.100.1",CConfigStore.getProperty("LInternetSpares","host",null,"test.ini").toString());
        assertEquals("10.100.100.1",CConfigStore.getProperty("LInternetSpares","host","def","test.ini").toString());
        assertEquals("10.100.100.1",CConfigStore.getProperty("LInternetSpares","Host","def","test.ini").toString());
        assertEquals("10.100.100.1",CConfigStore.getProperty("LInternetspares","Host","def","test.ini").toString());
        assertEquals("def",CConfigStore.getProperty("LInternetSpares","hosty","def","test.ini").toString());
        assertEquals("",CConfigStore.getProperty("LInternetSpares","hosty",null,"test.ini").toString());
    }

    public void testConversionOnlyHappensOnce()
    {
        CConfigImpl c1 = new FileConfigImpl("test.ini");
        c1.setProperty("test","key","value");
        assertEquals("value",c1.getProperty("test","key"));
        c1.finish();
        
        c1 = new FileConfigImpl("test.ini");
        assertEquals("value",c1.getProperty("test","key"));
    }

    public void testConversionOnlyHappensOnceMultipleChanges()
    {
        CConfigImpl c1 = new FileConfigImpl("test.ini");
        for (int scan=0;scan<300;scan++) {
            c1.setProperty("test","key","value:"+scan);
        }
        assertEquals("value:299",c1.getProperty("test","key"));
        c1.finish();
        
        c1 = new FileConfigImpl("test.ini");
        assertEquals("value:299",c1.getProperty("test","key"));
    }

    public void testConversionFlushHappensOnlyAfter20Percent()
    {
        CConfigImpl c1 = new FileConfigImpl("test.ini");
        c1.finish();
        
        File f = new File("test.properties");
        long size=f.length();
        
        c1 = new FileConfigImpl("test.ini");
        for (int scan=0;scan<300;scan++) {
            c1.setProperty("test","key","value:"+(scan%10));
            c1.finish();
            
            if (scan==120 || scan==240) {
                assertTrue(f.length()<size);
                size=f.length();
            } else {
                size+=18;  //test.key=value:n\n
                assertEquals("p:"+scan,size,f.length());
            }

            if (scan%47==23) {
                c1 = new FileConfigImpl("test.ini");
            }
            assertEquals("value:"+(scan%10),c1.getProperty("test","key"));
        }
    }
    
    
    public void testChangePropertyByUnknownIsDetected()
    {
        CConfigImpl c1 = new FileConfigImpl("test.ini");
        CConfigImpl c2 = new FileConfigImpl("test.ini");
        
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        c1.setProperty("test","key","value");
        
        assertEquals("value",c1.getProperty("test","key"));
        assertEquals("value",c2.getProperty("test","key"));
        
        
        c2.setProperty("test","key","newvalue");

        assertEquals("newvalue",c1.getProperty("test","key"));
        assertEquals("newvalue",c2.getProperty("test","key"));
        
        c1.finish();
        c2.finish();
    }

    public void testSetPropertyWithSpecialChars()
    {
        CConfigStore.setProperty("tsection","key","\\\\Escaped","test.ini");
        CConfigStore.getInstance("test.ini");
        assertEquals("\\\\Escaped",CConfigStore.getProperty("tsection","key","","test.ini").toString());
    }
    
    public void testSetProperty()
    {
        for (int scan=1;scan<100;scan++) {
            CConfigStore.setProperty("tsection","key"+scan,"Val "+scan,"test.ini");
        }

        for (int scan=1;scan<100;scan++) {
            assertEquals("Val "+scan,CConfigStore.getProperty("tsection","key"+scan,null,"test.ini").toString());
        }

        for (int scan=1;scan<100;scan++) {
            CConfigStore.setProperty("tSection","kEy"+scan,"Val2 "+scan,"test.ini");
        }

        for (int scan=1;scan<100;scan++) {
            assertEquals("Val2 "+scan,CConfigStore.getProperty("tsection","key"+scan,null,"test.ini").toString());
        }
        
        File f = new File("test.properties");
        long l1 = f.lastModified();
        
        Properties p;
        
        p= new Properties();
        try {
            p.load(new FileReader(f));
        } catch (IOException e) {
            fail();
        }
        for (int scan=1;scan<100;scan++) {
            assertEquals("Val2 "+scan,p.getProperty("tsection.key"+scan));
        }
        
        long n1 = System.currentTimeMillis();
        CConfigStore.getInstance("test.ini").finish();
        long n2 = System.currentTimeMillis();
        
        assertTrue(n2-n1>500);
        
        long l2 = f.lastModified();

        assertTrue(l2-l1>500);
        
        for (int scan=1;scan<100;scan++) {
            assertEquals("Val2 "+scan,CConfigStore.getProperty("tsection","key"+scan,null,"test.ini").toString());
        }

        p= new Properties();
        try {
            p.load(new FileReader(f));
        } catch (IOException e) {
            fail();
        }
        for (int scan=1;scan<100;scan++) {
            assertEquals("Val2 "+scan,p.getProperty("tsection.key"+scan));
        }
    }
    
    private String lines[] = new String[] {
            "[LGeneral]",
            "LastLogin=admin",
            "[getNewOrUsed]",
            "Maximize=No",
            "XPos=298",
            "YPos=137",
            "Height=92",
            "Width=185",
            "[UnisReports]",
            "Maximize=No",
            "XPos=413",
            "YPos=130",
            "[Units]",
            "Maximize=No",
            "XPos=431",
            "YPos=194",
            "[MainMenu]",
            "Maximize=No",
            "XPos=316",
            "YPos=68",
            "[Main]",
            "Maximize=Yes",
            "[__Dont_Touch_Me__]",
            "Sectors=0",
            "[SpareParts]",
            "Maximize=No",
            "XPos=223",
            "YPos=78",
            "[Workshop]",
            "Maximize=No",
            "XPos=78",
            "YPos=106",
            "[ViewUnit]",
            "Maximize=No",
            "XPos=469",
            "YPos=136",
            "[BrowseAllDealerUnits]",
            "Maximize=No",
            "XPos=312",
            "YPos=161",
            "[ShowUnits]",
            "Maximize=No",
            "XPos=443",
            "YPos=56",
            "[SelAnyUnit]",
            "Maximize=No",
            "XPos=298",
            "YPos=138",
            "[ViewSaleInvoices]",
            "Maximize=No",
            "XPos=272",
            "YPos=80",
            "[AccountsMainMenu]",
            "Maximize=No",
            "XPos=205",
            "YPos=60",
            "[SellPurchase]",
            "Maximize=No",
            "XPos=431",
            "YPos=65",
            "[ShowUnitSales]",
            "Maximize=No",
            "XPos=363",
            "YPos=68",
            "[BrowseType]",
            "Maximize=No",
            "XPos=467",
            "YPos=98",
            "[BrowseMake]",
            "Maximize=No",
            "XPos=467",
            "YPos=98",
            "[AddModifyPurchaseUnit]",
            "Maximize=No",
            "XPos=421",
            "YPos=98",
            "[doSelectCustomer]",
            "Maximize=No",
            "XPos=27",
            "YPos=176",
            "[SelectUnit]",
            "Maximize=No",
            "XPos=112",
            "YPos=74",
            "[AddModifySellUnit]",
            "Maximize=No",
            "XPos=253",
            "YPos=107",
            "[LSpares]",
            "CustDefOrd=1",
            "[SelFranch]",
            "Maximize=No",
            "XPos=65",
            "YPos=76",
            "[CustomerOrderQuery]",
            "Maximize=No",
            "XPos=298",
            "YPos=164",
            "[DailyOrder]",
            "Maximize=No",
            "XPos=280",
            "YPos=147",
            "[SparePartsSM]",
            "Maximize=No",
            "XPos=156",
            "YPos=139",
            "[Reports]",
            "Maximize=No",
            "XPos=373",
            "YPos=171",
            "[TestOwnership]",
            "Maximize=No",
            "XPos=361",
            "YPos=58",
            "[BrowseWorkType]",
            "Maximize=No",
            "XPos=298",
            "YPos=80",
            "[NewEstimate]",
            "Maximize=No",
            "XPos=280",
            "YPos=63",
            "[ShowEstimates]",
            "Maximize=No",
            "XPos=139",
            "YPos=78",
            "[ShowWorkshop]",
            "Maximize=No",
            "XPos=389",
            "YPos=98",
            "[ModifyEstimate]",
            "Maximize=No",
            "XPos=395",
            "YPos=54",
            "[selStock]",
            "Maximize=No",
            "XPos=316",
            "YPos=96",
            "[AddEstUnit]",
            "Maximize=No",
            "XPos=298",
            "YPos=79",
            "[ModifyJob]",
            "Maximize=No",
            "XPos=342",
            "YPos=183",
            "[ViewJob]",
            "Maximize=No",
            "XPos=376",
            "YPos=108",
            "[BrowseAllJobs]",
            "Maximize=No",
            "XPos=349",
            "YPos=174",
            "[Setup]",
            "Maximize=No",
            "XPos=141",
            "YPos=17",
            "[SelectOrder]",
            "Maximize=No",
            "XPos=68",
            "YPos=10",
            "[BrowseDailyOrderItems]",
            "Maximize=No",
            "XPos=149",
            "YPos=76",
            "[LPrinters]",
            "Invoice=PDFCreator",
            "Report=PDFCreator",
            "Docket=PDFCreator",
            "DocketFont=16 cpi",
            "DocketCFont=control",
            "DocketIndent=0.22",
            "DocketWidth=0",
            "DocketChars=0",
            "DocketFeed=0",
            "ShowPrintDialog=N",
            "DocketOpen=",
            "DocketCut=",
            "[LPOS]",
            "PrintDest=AD",
            "LookupMethod=M",
            "Font=8",
            "YPICImportEnable=N",
            "YPICImportDir=C:\\Program Files\\YPIC",
            "YPECImportEnable=N",
            "YPECImportDir=C:\\Program Files\\YPEC",
            "HPICImportEnable=N",
            "HPICImportDir=C:\\Program Files\\Honda\\Parts\\Orders",
            "IHSImportEnable=N",
            "IHSImportDir=C:\\Program Files\\Honda\\Parts\\Data\\PICKLIST.DAT",
            "MercuryImportEnable=N",
            "MercuryImportDir=C:\\midaswin\\dmsin",
            "OPEAImportEnable=Y",
            "OPEAImportDir=C:\\opea\\",
            "[LAdvanced]",
            "ConfirmAppClose=1",
            "[LWorkshop]",
            "OpenTillOnCashPickup=N",
            "[selSupplier]",
            "Maximize=No",
            "XPos=147",
            "YPos=41",
            "[ShowBrowser]",
            "Maximize=No",
            "XPos=429",
            "YPos=159",
            "[PickupJob]",
            "Maximize=No",
            "XPos=343",
            "YPos=42",
            "[Utilities]",
            "Maximize=No",
            "XPos=516",
            "YPos=138",
            "[LInternetSpares]",
            "host=10.100.100.1",
            "port=12001",
            "deleteRequest=true",
            "deleteAllRequest=true",
            "notifyItemValue=false",
            "noQty=false",
            "noPrice=false",
            "notifyItemValueAmt=0",
            "c8Drive=",
            "mapSize=3",
            "1.category=acc",
            "1.refcode=1",
            "2.category=Allied",
            "2.refcode=37",
            "3.category=Cassons",
            "3.refcode=8",
            "[ViewChangePart]",
            "Maximize=No",
            "XPos=365",
            "YPos=127",
            "[selMaster]",
            "Maximize=No",
            "XPos=244",
            "YPos=133",
            "[SelectAccount]",
            "Maximize=No",
            "XPos=280",
            "YPos=147",
            "[ConfirmPayment]",
            "Maximize=No",
            "XPos=298",
            "YPos=164",
            "[Payment]",
            "Maximize=No",
            "XPos=280",
            "YPos=147",
            "[AccountsMenu]",
            "Maximize=No",
            "XPos=482",
            "YPos=137",
            "[CompleteJob]",
            "Maximize=No",
            "XPos=343",
            "YPos=42",
            "[AddLabour]",
            "Maximize=No",
            "XPos=343",
            "YPos=42",
            "[selJob]",
            "Maximize=No",
            "XPos=273",
            "YPos=83",
            "Height=187",
            "Width=341",
            "[ModifyJobUnit]",
            "Maximize=No",
            "XPos=361",
            "YPos=58",
            "[ModifyUnit]",
            "Maximize=No",
            "XPos=52",
            "YPos=38",
            "[BrowseUnitLine]",
            "Maximize=No",
            "XPos=163",
            "YPos=79",
            "[AddFloorplanCost]",
            "Maximize=No",
            "XPos=316",
            "YPos=126",
            "[ViewAccounts]",
            "Maximize=No",
            "XPos=419",
            "YPos=183",
            "[AccUpdate]",
            "Maximize=No",
            "XPos=73",
            "YPos=47",
            "[viewInvoice]",
            "Maximize=No",
            "XPos=79",
            "YPos=158",
            "[ReprintInvoiceMenu]",
            "Maximize=No",
            "XPos=226",
            "YPos=172",
            "[preEditFranch]",
            "Maximize=No",
            "XPos=280",
            "YPos=146",
            "[editFranch]",
            "Maximize=No",
            "XPos=185",
            "YPos=92",
            "[BrowseMF]",
            "Maximize=No",
            "XPos=313",
            "YPos=203",
            "[UpdateMF]",
            "Maximize=No",
            "XPos=459",
            "YPos=178",
            "[EOM]",
            "Maximize=No",
            "XPos=280",
            "YPos=146",
            "[MoveParts]",
            "Maximize=No",
            "XPos=280",
            "YPos=146",
            "[selStockType]",
            "Maximize=No",
            "XPos=409",
            "YPos=204",
            "[PreStockList]",
            "Maximize=No",
            "XPos=391",
            "YPos=188",
            "[PreStockSummary]",
            "Maximize=No",
            "XPos=391",
            "YPos=188",
            "[ApplyUnitsQuery]",
            "Maximize=No",
            "XPos=76",
            "YPos=55",
            "[ShowFilteredReports]",
            "Maximize=No",
            "XPos=240",
            "YPos=119",
            "[GetTwoDates]",
            "Maximize=No",
            "XPos=258",
            "YPos=135",
            "[UnitsQBE]",
            "Maximize=No",
            "XPos=485",
            "YPos=153",
            "[ViewAuditTrail]",
            "Maximize=No",
            "XPos=174",
            "YPos=181",
            "[PreStatements]",
            "Maximize=No",
            "XPos=577",
            "YPos=38",
            "[ViewAccount]",
            "Maximize=No",
            "XPos=369",
            "YPos=127",
            "[ViewCustNA]",
            "Maximize=No",
            "XPos=280",
            "YPos=147",
            "[ViewDeletedTR]",
            "Maximize=No",
            "XPos=280",
            "YPos=147",
            "[AccountsReports]",
            "Maximize=No",
            "XPos=146",
            "YPos=65",
            "[AccountQBE]",
            "Maximize=No",
            "XPos=262",
            "YPos=130",
            "[ApplyAccountQuery]",
            "Maximize=No",
            "XPos=259",
            "YPos=79",
            "[SelectInvoice]",
            "Maximize=No",
            "XPos=15",
            "YPos=-2",
            "[SelAccountByPhone]",
            "Maximize=No",
            "XPos=367",
            "YPos=165",
            "[doSelAccount]",
            "Maximize=No",
            "XPos=273",
            "YPos=83",
            "[AddInvoice]",
            "Maximize=No",
            "XPos=403",
            "YPos=170",
            "[RolloverConfirm]",
            "Maximize=No",
            "XPos=403",
            "YPos=170",
            "[ViewTransactions]",
            "Maximize=No",
            "XPos=20",
            "YPos=22",
            "[LOrder]",
            "SelectTab=2",
            "[AvancedOrders]",
            "Maximize=No",
            "XPos=298",
            "YPos=164",
            "[UpdateSingleNote]",
            "Maximize=No",
            "XPos=75",
            "YPos=7",
            "[ViewReceivedOrder]",
            "Maximize=No",
            "XPos=109",
            "YPos=47",
            "[BrowseReceivedOrders]",
            "Maximize=No",
            "XPos=80",
            "YPos=47",
            "[RunCustOrdQuery]",
            "Maximize=No",
            "XPos=229",
            "YPos=73",
            "[NewJob]",
            "Maximize=No",
            "XPos=343",
            "YPos=42",
            "[selEstimates]",
            "Maximize=No",
            "XPos=361",
            "YPos=58",
            "[BrowseStaff]",
            "Maximize=No",
            "XPos=316",
            "YPos=95",
            "[BrowseDependancies]",
            "Maximize=No",
            "XPos=343",
            "YPos=42",
            "[AddNewParts]",
            "Maximize=No",
            "XPos=349",
            "YPos=34",
            "[calcMarkup]",
            "Maximize=No",
            "XPos=316",
            "YPos=178",
            "[selSuperceedMasterPart]",
            "Maximize=No",
            "XPos=280",
            "YPos=146",
            "[selSuperceedStockPart]",
            "Maximize=No",
            "XPos=280",
            "YPos=146",
            "[updPrices]",
            "Maximize=No",
            "XPos=419",
            "YPos=205",
            "[BrosweWSParts]",
            "Maximize=No",
            "XPos=361",
            "YPos=58",
            "[SalesProfit]",
            "Maximize=No",
            "XPos=391",
            "YPos=188",
            "[browseUnitCost]",
            "Maximize=No",
            "XPos=85",
            "YPos=153",
            "[ModifyORCLine]",
            "Maximize=No",
            "XPos=379",
            "YPos=125",
            "[ModifyUnitGroup]",
            "Maximize=No",
            "XPos=485",
            "YPos=114",
            "[ViewUnitJobs]",
            "Maximize=No",
            "XPos=466",
            "YPos=55",
            "[HelpAbout]",
            "Maximize=No",
            "XPos=76",
            "YPos=61",
            "[SaleRollback]",
            "Maximize=No",
            "XPos=381",
            "YPos=85",
            "[UpdUnitLine]",
            "Maximize=No",
            "XPos=181",
            "YPos=95",
            "[SimpleWorkshopJob]",
            "Maximize=No",
            "XPos=487",
            "YPos=153",
            "[MergeCustUnit]",
            "Maximize=No",
            "XPos=461",
            "YPos=73",
            "[ModifyJobRecord]",
            "Maximize=No",
            "XPos=246",
            "YPos=96",
            "[ViewTransactionHistory]",
            "Maximize=No",
            "XPos=117",
            "YPos=210",
            "[CustTransfer]",
            "Maximize=No",
            "XPos=381",
            "YPos=85",
            "[PickupConfirm]",
            "Maximize=No",
            "XPos=361",
            "YPos=58",
            "[PrePartsOnOrderList]",
            "Maximize=No",
            "XPos=391",
            "YPos=188",
            "[browseTypes]",
            "Maximize=No",
            "XPos=96",
            "YPos=109",
            "[PreHistoryList]",
            "Maximize=No",
            "XPos=391",
            "YPos=188",
            "[browseAlterns]",
            "Maximize=No",
            "XPos=298",
            "YPos=163",
            "[addAltern]",
            "Maximize=No",
            "XPos=298",
            "YPos=163",
            "[alternsMenu]",
            "Maximize=No",
            "XPos=280",
            "YPos=146",
            "[preSTakeSheets]",
            "Maximize=No",
            "XPos=391",
            "YPos=188",
            "[PreDeadStockList]",
            "Maximize=No",
            "XPos=391",
            "YPos=188",
            "[PreStockRetail]",
            "Maximize=No",
            "XPos=391",
            "YPos=188",
            "[BrowseAccounts]",
            "Maximize=No",
            "XPos=412",
            "YPos=141",
            "[stocktakeEntry]",
            "Maximize=No",
            "XPos=143",
            "YPos=170",
            "[ModifyQty]",
            "Maximize=No",
            "XPos=298",
            "YPos=162",
            "[deletePart]",
            "Maximize=No",
            "XPos=523",
            "YPos=161",
            "[doMaxCheck]",
            "Maximize=No",
            "XPos=49",
            "YPos=71",
            "[PreMaxCheck]",
            "Maximize=No",
            "XPos=270",
            "YPos=225",
            "[UpdateStaff]",
            "Maximize=No",
            "XPos=334",
            "YPos=111",
            "[BrowseOther]",
            "Maximize=No",
            "XPos=253",
            "YPos=143",
            "[updateSupplier]",
            "Maximize=No",
            "XPos=436",
            "YPos=201",
            "[browseSupplier]",
            "Maximize=No",
            "XPos=418",
            "YPos=185",
            "[ModifyEstUnit]",
            "Maximize=No",
            "XPos=298",
            "YPos=79",
            "[ShowReports]",
            "Maximize=No",
            "XPos=257",
            "YPos=80",
            "[ViewAccountJobs]",
            "Maximize=No",
            "XPos=465",
            "YPos=192",
            "[BrowseCustomers]",
            "Maximize=No",
            "XPos=447",
            "YPos=175",
            "[ViewFinePrint]",
            "Maximize=No",
            "XPos=375",
            "YPos=210",
            "[ModifyFinePrint]",
            "Maximize=No",
            "XPos=240",
            "YPos=111",
            "[BuyUsedUnit]",
            "Maximize=No",
            "XPos=447",
            "YPos=175",
            "[ConfirmTransfer]",
            "Maximize=No",
            "XPos=183",
            "YPos=196",
            "[SellUnit]",
            "Maximize=No",
            "XPos=165",
            "YPos=179",
            "[ShowSales]",
            "Maximize=No",
            "XPos=429",
            "YPos=159",
            "[UpdFormulae]",
            "Maximize=No",
            "XPos=289",
            "YPos=176",
            "[BrowseFormulae]",
            "Maximize=No",
            "XPos=271",
            "YPos=159",
            "[UpdateDependancies]",
            "Maximize=No",
            "XPos=361",
            "YPos=58",
            "[BrowseWaitReasons]",
            "Maximize=No",
            "XPos=419",
            "YPos=135",
            "[TransferUnit]",
            "Maximize=No",
            "XPos=389",
            "YPos=110",
            "[TestGST]",
            "Maximize=No",
            "XPos=470",
            "YPos=116",
            "Height=68",
            "Width=201",
            "[ViewTrialBalance]",
            "Maximize=No",
            "XPos=280",
            "YPos=146",
            "[PrePrnTransList]",
            "Maximize=No",
            "XPos=280",
            "YPos=118",
            "[UpdateWSParts]",
            "Maximize=No",
            "XPos=379",
            "YPos=74",
            "[browseAccountNotifications]",
            "Maximize=No",
            "XPos=133",
            "YPos=83",
            "[browseNotifications]",
            "Maximize=No",
            "XPos=95",
            "YPos=15",
            "[createTestMessage]",
            "Maximize=No",
            "XPos=88",
            "YPos=39",
            "Height=188",
            "Width=358",
            "[RelationalQuery]",
            "Maximize=No",
            "XPos=145",
            "YPos=156",
            "[MailMergeTemplate]",
            "Maximize=No",
            "XPos=136",
            "YPos=41",
            "Height=291",
            "Width=465",
            "[ShowNewEstimates]",
            "Maximize=No",
            "XPos=91",
            "YPos=118",
            "[AddEstimateGroup]",
            "Maximize=No",
            "XPos=210",
            "YPos=134",
            "[BrowseDailyOrd]",
            "Maximize=No",
            "XPos=211",
            "YPos=112",
            "[QuickEmail]",
            "Maximize=No",
            "XPos=437",
            "YPos=199",
            "[QuickSMS]",
            "Maximize=No",
            "XPos=437",
            "YPos=199",
            "[getEmailAddress]",
            "Maximize=No",
            "XPos=340",
            "YPos=121",
            "[ChangePassword]",
            "Maximize=No",
            "XPos=196",
            "YPos=95",
            "[LJobBrowse]",
            "Action1=1",
            "Action6=2",
            "Action4=1",
            "Action5=1",
            "Action0=2",
            "[selectSchedMechanic]",
            "Maximize=No",
            "XPos=15",
            "YPos=-2",
            "[BrowseLedger]",
            "Maximize=Yes",
            "XPos=280",
            "YPos=121",
            "Height=270",
            "Width=495",
            "[Business]",
            "Maximize=No",
            "XPos=262",
            "YPos=104",
            "[UpdateLedger]",
            "Maximize=No",
            "XPos=152",
            "YPos=189",
            "Height=182",
            "Width=393",
            "[LedgerQBE]",
            "Maximize=No",
            "XPos=263",
            "YPos=151",
            "[InvHeadQBE]",
            "Maximize=No",
            "XPos=263",
            "YPos=151",
            "[LDebug]",
            "File=0",
            "POSDebug=1",
            "[SelectJob]",
            "Maximize=Yes",
            "[selectUnallocatedTransactions]",
            "Maximize=No",
            "XPos=277",
            "YPos=49",
            "[CorrectBalance]",
            "Maximize=No",
            "XPos=387",
            "YPos=143",                
    };
    
}
