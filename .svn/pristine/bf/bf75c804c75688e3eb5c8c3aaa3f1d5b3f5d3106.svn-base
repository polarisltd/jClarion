package org.jclarion.clarion.appgen.embed;

import java.util.Iterator;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;

import junit.framework.TestCase;

public class WildcardEmbedStoreTest extends TestCase {

	public void testTypicalWildCardFit()
	{
		WildcardEmbedStore<TestAdvise> store = new WildcardEmbedStore<TestAdvise>();
		store.add(create(1,7000,null,"Init","(File File,ErrorClass EC)"));
		store.add(create(2,5000));
		store.add(create(3,8000,null,"Kill","()"));
		store.add(create(4,2500,null,"PrimeFields","()"));
		store.add(create(5,7500,null,"BindFields","()"));
		store.add(create(6,6000,null,"ValidateFieldServer","(UNSIGNED Id,BYTE HandleErrors),BYTE"));
		store.add(create(7,10000));
		store.add(create(8,5000,null,"Open"));
		store.add(create(9,5000,null,"Open"));
		store.add(create(10,6000,null,"Open"));
		
		
		assertStore("2,7",store.get(new EmbedKey("test","Account","Init"),1,10000));

		assertStore("2,8,9,10,7",store.get(new EmbedKey("test","Account","Open"),1,10000));

		assertStore("2,8,9,10,7",store.get(new EmbedKey("test","Account","Open","Anything"),1,10000));

		assertStore("2,5,7",store.get(new EmbedKey("test","Txn","BindFields","()"),1,10000));

		assertStore("10,7",store.get(new EmbedKey("test","Account","Open","Anything"),5500,10000));

		assertStore("2,8,9",store.get(new EmbedKey("test","Account","Open","Anything"),4500,5500));

		assertStore("",store.get(new EmbedKey("test","Account","Open","Anything"),5100,5500));

		assertStore("10",store.get(new EmbedKey("test","Account","Open","Anything"),5100,6000));
	}

	public void testFitCompetingMatches()
	{
		WildcardEmbedStore<TestAdvise> store = new WildcardEmbedStore<TestAdvise>();
		store.add(create(1,7000,null,"Init"));
		store.add(create(3,8000,"Account",null));
		store.add(create(4,8000,"Account","Kill"));
		store.add(create(5,2000,"Invoice","Init"));
		store.add(create(6,1000));
		
		
		assertStore("6,1,3",store.get(new EmbedKey("test","Account","Init"),1,10000));

		assertStore("6,3,4",store.get(new EmbedKey("test","Account","Kill"),1,10000));

		assertStore("6,5,1",store.get(new EmbedKey("test","Invoice","Init"),1,10000));

		assertStore("6",store.get(new EmbedKey("test","Invoice","Kill"),1,10000));
	}
	
	public void testMerge()
	{
		WildcardEmbedStore<TestAdvise> store = new WildcardEmbedStore<TestAdvise>();
		store.add(create(1,7000,null,"Init","(File File,ErrorClass EC)"));
		store.add(create(2,5000));
		store.add(create(3,8000,null,"Kill","()"));
		store.add(create(4,2500,null,"PrimeFields","()"));
		store.add(create(5,7500,null,"BindFields","()"));
		store.add(create(6,6000,null,"ValidateFieldServer","(UNSIGNED Id,BYTE HandleErrors),BYTE"));
		store.add(create(7,10000));
		store.add(create(8,5000,null,"Open"));
		store.add(create(9,5000,null,"Open"));
		store.add(create(10,6000,null,"Open"));
		
		WildcardEmbedStore<TestAdvise> store2 = new WildcardEmbedStore<TestAdvise>();
		store.add(create(11,7000,null,"Init"));
		store.add(create(13,8000,"Account",null));
		store.add(create(14,8000,"Account","Kill"));
		store.add(create(15,2000,"Invoice","Init"));
		store.add(create(16,1000));
		
		store.addAll(store2);
		
		
		assertStore("16,2,11,13,7",store.get(new EmbedKey("test","Account","Init"),1,10000));

		assertStore("16,2,13,14,7",store.get(new EmbedKey("test","Account","Kill"),1,10000));

		assertStore("16,15,2,11,7",store.get(new EmbedKey("test","Invoice","Init"),1,10000));

		assertStore("16,2,3,7",store.get(new EmbedKey("test","Invoice","Kill","()"),1,10000));
		
	}

	public void testFitCompetingMatches2()
	{
		WildcardEmbedStore<TestAdvise> store = new WildcardEmbedStore<TestAdvise>();
		store.add(create(1,7000,null,"Init"));
		store.add(create(3,8000,"Account",null));
		store.add(create(4,8000,"Account","Kill"));
		store.add(create(5,2000,"Invoice","Init"));
		
		
		assertStore("1,3",store.get(new EmbedKey("test","Account","Init"),1,10000));

		assertStore("3,4",store.get(new EmbedKey("test","Account","Kill"),1,10000));

		assertStore("5,1",store.get(new EmbedKey("test","Invoice","Init"),1,10000));

		assertStore("",store.get(new EmbedKey("test","Invoice","Kill"),1,10000));
	}
	

	private void assertStore(String string, Iterator<? extends Advise> iterator) 
	{
		StringBuilder bld = new StringBuilder();
		while (iterator.hasNext()) {
			if (bld.length()>0) bld.append(',');
			bld.append(iterator.next());
		}
		assertEquals(string,bld.toString());
	}


	private TestAdvise create(int pos,int priority,String... bits) {
		return new TestAdvise(priority,pos,new EmbedKey("test",bits));
	}
	
	private static class TestAdvise extends AbstractAdvise
	{
		public TestAdvise(int priority, int instance,EmbedKey key) 
		{
			super(priority, 0,instance);
			this.key=key;
		}

		private EmbedKey key;
		
		
		@Override
		public void run(ExecutionEnvironment env,EmbedKey source) {
		}

		@Override
		public EmbedKey getKey() {
			return key;
		}
		
		public String toString()
		{
			return String.valueOf(getInstanceID());
		}
	}
}
