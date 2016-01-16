package org.jclarion.clarion.swing.gui;

import java.util.Random;

import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

import junit.framework.TestCase;

public class NetworkQueueTest extends TestCase {

	
	public void testSerializeDeserializeQueue()
	{
		ClarionQueue local=new ClarionQueue();
		ClarionString s1 = new ClarionString(50);
		ClarionString s2 = new ClarionString();
		ClarionNumber n = new ClarionNumber();
		ClarionDecimal d = new ClarionDecimal(10,2);
		
		local.addVariable("s1",s1);
		local.addVariable("s2",s2);
		local.addVariable("n",n);
		local.addVariable("d",d);

		NetworkQueue nq = new NetworkQueue(local,null);
		
		ClarionQueue remote = NetworkQueue.reconstruct(null,(Object[])nq.getMetaData());
		
		assertQueueSame(local,remote);
		
		Random r = new Random();
		
		for (int loop=0;loop<5000;loop++) {
			for (int op=r.nextInt(20);op>0;op--) {
				
				int type = r.nextInt(45);
				
				if (type<=20) {
					if (local.records()==0) continue;
					local.get(r.nextInt(local.records())+1);
				}
				if (type<=40) {
					if (r.nextBoolean()) s1.setValue(randomString(r));
					if (r.nextBoolean()) s2.setValue(randomString(r));
					if (r.nextBoolean()) n.setValue(r.nextInt());
					if (r.nextBoolean()) d.setValue(r.nextInt(10000000)+"."+r.nextInt(100));
				}
				if (type<=20) {
					local.put();
				} else if (type<=40) {
					local.add();
				} else if (type<=43) {
					if (local.records()==0) continue;
					local.get(r.nextInt(local.records())+1);
					local.delete();
				} else {
					local.free();
				}
			}
			
			remote = NetworkQueue.reconstruct(remote,(Object[])nq.getMetaData());
			assertQueueSame(local,remote);
		}
		
	}

	private String randomString(Random r) {
		char c[] = new char[r.nextInt(50)];
		for (int scan=0;scan<c.length;scan++) {
			c[scan]=(char)(r.nextInt(126-32)+32);
		}
		return new String(c);
	}

	private void assertQueueSame(ClarionQueue local, ClarionQueue remote) {
		assertNotSame(local,remote);
		assertEquals(local.records(),remote.records());
		assertEquals(local.getVariableCount(),remote.getVariableCount());
		for (int scan=1;scan<=local.records();scan++) {
			local.get(scan);
			remote.get(scan);
			for (int col=1;col<=local.getVariableCount();col++) {
				assertEquals(local.flatWhat(col),remote.flatWhat(col));
			}
		}
	}
	
}
