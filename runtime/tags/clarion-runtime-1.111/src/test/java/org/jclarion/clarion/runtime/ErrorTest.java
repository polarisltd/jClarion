package org.jclarion.clarion.runtime;

import java.util.Random;

import junit.framework.TestCase;

public class ErrorTest extends TestCase
{
	public void testSimple()
	{
		CErrorImpl.getInstance().clearError();
		assertEquals(0,CError.errorCode());
		assertEquals("",CError.fileErrorCode());
		assertEquals("",CError.fileError());
		assertEquals("",CError.errorFile());

		CErrorImpl.getInstance().setError(5,"Some Error");
		CErrorImpl.getInstance().setFileError("25","Exception","foo");
		assertEquals(5,CError.errorCode());
		assertEquals("Some Error",CError.error());
		assertEquals("25",CError.fileErrorCode());
		assertEquals("Exception",CError.fileError());
		assertEquals("foo",CError.errorFile());
		
		CError.pushErrors();

		assertEquals(5,CError.errorCode());
		assertEquals("Some Error",CError.error());
		assertEquals("25",CError.fileErrorCode());
		assertEquals("Exception",CError.fileError());
		assertEquals("foo",CError.errorFile());

		CErrorImpl.getInstance().setError(3,"Some Other");
		CErrorImpl.getInstance().setFileError("10","Another Exception","bar");

		assertEquals(3,CError.errorCode());
		assertEquals("Some Other",CError.error());
		assertEquals("10",CError.fileErrorCode());
		assertEquals("Another Exception",CError.fileError());
		assertEquals("bar",CError.errorFile());

		CError.pushErrors();
		CErrorImpl.getInstance().clearError();

		assertEquals(0,CError.errorCode());
		assertEquals("OK",CError.error());
		assertEquals("",CError.fileErrorCode());
		assertEquals("",CError.fileError());
		assertEquals("",CError.errorFile());

		CError.popErrors();

		assertEquals(3,CError.errorCode());
		assertEquals("Some Other",CError.error());
		assertEquals("10",CError.fileErrorCode());
		assertEquals("Another Exception",CError.fileError());
		assertEquals("bar",CError.errorFile());

		CError.popErrors();
		
		assertEquals(5,CError.errorCode());
		assertEquals("Some Error",CError.error());
		assertEquals("25",CError.fileErrorCode());
		assertEquals("Exception",CError.fileError());
		assertEquals("foo",CError.errorFile());
		
		CError.popErrors();
		
		assertEquals(5,CError.errorCode());
		assertEquals("Some Error",CError.error());
		assertEquals("25",CError.fileErrorCode());
		assertEquals("Exception",CError.fileError());
		assertEquals("foo",CError.errorFile());
	}

	public class ErrorThread extends Thread
	{
		private Exception myException;
		
		@Override
		public void run() 
		{
			try {
				Random r = new Random();
				for (int scan=0;scan<500000;scan++) {
					int v = r.nextInt(100)+1;
					CErrorImpl.getInstance().clearError();
					assertEquals(0,CError.errorCode());
					CErrorImpl.getInstance().setError(v,"Some Error");
					assertEquals(v,CError.errorCode());
				}
			} catch (Exception e) {
				e.printStackTrace();
				myException=e;
			}
		}
	}
	

	
	public void testThreaded() throws InterruptedException
	{
		ErrorThread et[] = new ErrorThread[10];
		for (int scan=0;scan<10;scan++) {
			et[scan]=new ErrorThread();
		}
		for (int scan=0;scan<10;scan++) {
			et[scan].start();
		}
		for (int scan=0;scan<10;scan++) {
			et[scan].join();
		}
		for (int scan=0;scan<10;scan++) {
			assertNull(et[scan].myException);
		}
	}
}
