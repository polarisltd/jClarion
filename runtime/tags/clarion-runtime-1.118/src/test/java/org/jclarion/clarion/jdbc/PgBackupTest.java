package org.jclarion.clarion.jdbc;

import java.io.IOException;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Calendar;
import java.util.Random;

import org.jclarion.clarion.util.SharedWriter;


import junit.framework.TestCase;

/**
 * PgBackup includes its own implementation of various toString(), to try and squeeze a few more
 * milliseconds out of system by writing outputs directly to outputstream as soon as possible
 * instead of churning String objects.  Also optimises outputs to minimise size. i.e. instead of
 * writing 0.00, write 0 instead. Or 01:15:03, write: 1:15:3 
 * 
 * @author barney
 */
public class PgBackupTest extends TestCase 
{

	public void testEncodings()
	{
		assertEncoding("123",123,123);
		assertEncoding("100",100,100);
		assertEncoding("0",0,0);
		assertEncoding("-1234",-1234,-1234);
		assertEncoding("'hello'","hello",0);
		assertEncoding("E'hello\\n'","hello\n",0);
		assertEncoding("E'hello\\rWorld'","hello\rWorld",0);
		assertEncoding("E'hello\\\\'","hello\\",0);

		assertEncoding("123.45",new BigDecimal("123.45"),0);
		assertEncoding("1.45",new BigDecimal("1.45"),0);
		assertEncoding("1.4",new BigDecimal("1.40"),0);
		assertEncoding("1",new BigDecimal("1.00"),0);
		assertEncoding("0.01",new BigDecimal("0.01"),0);
		assertEncoding("0.45",new BigDecimal("0.45"),0);
		assertEncoding("-2147483648",-2147483648,-2147483648);
		assertEncoding("2147483647",2147483647,2147483647);
		assertEncoding("-2147483648",new BigDecimal("-2147483648"),0);
		assertEncoding("-21474836.48",new BigDecimal("-21474836.48"),0);
		assertEncoding("2147483647",new BigDecimal("2147483647"),0);
		assertEncoding("21474836.47",new BigDecimal("21474836.47"),0);
		assertEncoding("1234567.45",new BigDecimal("1234567.45"),0);
		assertEncoding("-1234567.45",new BigDecimal("-1234567.45"),0);
		assertEncoding("-12345678989.45",new BigDecimal("-12345678989.45"),0);
		assertEncoding("0.025",new BigDecimal("0.025"),0);
		assertEncoding("0.02",new BigDecimal("0.0200"),0);
		assertEncoding("123.45",new BigDecimal("0123.45"),0);
		assertEncoding("5000",new BigDecimal("5000"),0);
		assertEncoding("50000",(new BigDecimal("5000")).movePointRight(1),0);
		assertEncoding("0.001",(new BigDecimal("1")).movePointLeft(3),0);
		assertEncoding("'2011-1-12'",new java.sql.Date(date(2011,1,12,0,0,0)),0);
		assertEncoding("'0011-1-12'",new java.sql.Date(date(11,1,12,0,0,0)),0);
		assertEncoding("'13:54:12'",new java.sql.Time(date(2011,1,12,13,54,12)),0);
		assertEncoding("'2011-11-1 5:11:50'",new java.sql.Timestamp(date(2011,11,1,5,11,50)),0);
	}
	
	public void testManyInt()
	{
		Random r= new Random();
		SharedWriter sw = new SharedWriter();
		PgBackup sb  =new PgBackup();
		try {
			for (int scan=0;scan<100000;scan++) {
				sw.reset();
				int i = r.nextInt();
				sb.writeObject(sw,i,false);
				String s = sw.toString();
				assertEquals(s,Integer.toString(i));
			}
		} catch (IOException ex) { 
			fail(ex.getMessage());
		}
	}

	public void testManyBigDecimal()
	{
		Random r= new Random();
		SharedWriter sw = new SharedWriter();
		PgBackup sb  =new PgBackup();
		int same=0;
		try {
			for (int scan=0;scan<100000;scan++) {
				sw.reset();
				int i = r.nextInt();
				int scale = r.nextInt(4);
				BigDecimal bd = new BigDecimal(i).movePointLeft(scale);
				sb.writeObject(sw,bd,false);
				BigDecimal x = new BigDecimal(sw.toString());
				assertTrue(x.compareTo(bd)==0);
				if (bd.equals(x)) same++;
			}
		} catch (IOException ex) { 
			fail(ex.getMessage());
		}
		//System.out.println(same);
	}

	public void testManyMassiveDecimal()
	{
		Random r= new Random();
		SharedWriter sw = new SharedWriter();
		PgBackup sb  =new PgBackup();
		int same=0;
		try {
			for (int scan=0;scan<100000;scan++) {
				sw.reset();
				byte b[]=new byte[1+r.nextInt(20)];
				r.nextBytes(b);
				int scale = r.nextInt(6);
				BigDecimal bd = new BigDecimal(new BigInteger(b)).movePointLeft(scale);
				sb.writeObject(sw,bd,false);
				BigDecimal x = new BigDecimal(sw.toString());
				assertTrue(x.compareTo(bd)==0);
				if (bd.equals(x)) same++;
			}
		} catch (IOException ex) { 
			fail(ex.getMessage());
		}
		//System.out.println(same);
	}
	
	public void testManyLong()
	{
		Random r= new Random();
		SharedWriter sw = new SharedWriter();
		PgBackup sb  =new PgBackup();
		try {
			for (int scan=0;scan<100000;scan++) {
				sw.reset();
				long i = r.nextLong();
				sb.writeObject(sw,i,false);
				String s = sw.toString();
				assertEquals(s,Long.toString(i));
			}
		} catch (IOException ex) { 
			fail(ex.getMessage());
		}
	}

	public void testManySmallLong()
	{
		Random r= new Random();
		SharedWriter sw = new SharedWriter();
		PgBackup sb  =new PgBackup();
		try {
			for (int scan=0;scan<100000;scan++) {
				sw.reset();
				long i = r.nextInt();
				sb.writeObject(sw,i,false);
				String s = sw.toString();
				assertEquals(s,Long.toString(i));
			}
		} catch (IOException ex) { 
			fail(ex.getMessage());
		}
	}
	
	private long date(int i, int j, int k, int l, int m, int n) 
	{
		Calendar c=Calendar.getInstance();
		c.set(i, j-1+Calendar.JANUARY, k, l, m, n);
		return c.getTimeInMillis();
	}

	private void assertEncoding(String string, Object o,int val) 
	{
		StringWriter sw = new StringWriter();
		try {
			PgBackup sb  =new PgBackup();
			assertEquals(val,sb.writeObject(sw, o,false));
			assertEquals(string,sw.toString());
		} catch (IOException ex) {
			fail(ex.getMessage());
		}
	}
	
	
}
