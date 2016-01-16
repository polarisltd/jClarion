package org.jclarion.clarion.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Random;

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.swing.TestGUIFactory;
import org.jclarion.clarion.swing.gui.GUIModel;

import junit.framework.TestCase;

public class FileSystemTest extends TestCase
{
	public void testFileSystem() throws IOException
	{
		FileFactoryRepository.getInstance().create("test.txt");
		ClarionRandomAccessFile f = FileFactoryRepository.getInstance().getRandomAccessFile("test.txt"); 
		byte[] buffer=new byte[8000000]; // 8mb max
		int size=0;
		int pos=0;
		
		Random r = new Random();
		
		for (int scan=0;scan<10000;scan++) {
			
			// one of 3 things. read, write or length
			int command = r.nextInt(10);
			
			if (command==0) {
				assertEquals(size,f.length());
				continue;
			}

			int newPos=pos;
			if (size>0 && r.nextBoolean()) {
				newPos=r.nextInt(size);
			}
			
			if (command<6) {
				// read
				if (newPos!=pos) {
					f.seek(newPos);
					pos=newPos;
				}
			
				int read = r.nextInt(32768);
				if (read==0) continue;
				
				byte b[] = new byte[512];
				
				while (read>0) {
					int v = f.read(b,0,read<512 ? read : 512 );
					if (v<=0) break;
					for (int t=0;t<v;t++) {
						assertEquals(buffer[pos],b[t]);
						pos++;
						read--;
					}
				}
				if (read>0) {
					assertEquals(size,pos);
				}
				continue;
			}
			
			{
				if (newPos!=pos) {
					f.seek(newPos);
					pos=newPos;
				}

				int len = r.nextInt(32768);
				if (pos+len > buffer.length ) len=buffer.length-pos;
				if (len==0) continue;
				byte b[] = new byte[len+r.nextInt(8192)];				
				r.nextBytes(b);
				System.arraycopy(b,0,buffer,pos,len);
				pos+=len;
				if (pos>size) size=pos;
				f.write(b,0,len);
			}			
		}
		f.close();
		
		FileInputStream fis = new FileInputStream("test.txt");
		byte b[] = new byte[1024];
		pos=0;
		while ( true ) {
			int read = fis.read(b);
			if (read<=0) break;
			for (int scan=0;scan<read;scan++) {
				assertEquals(buffer[pos++],b[scan]);
			}
		}
		fis.close();
		assertEquals(size,pos);
		
		FileFactoryRepository.getInstance().delete("test.txt");
		assertFalse((new File("test.txt")).exists());
	}

	public void testNetworkAccess() throws IOException
	{
		TestGUIFactory factory = null;
		try {
			factory=new TestGUIFactory();
			GUIModel.setFactory(factory);
			testFileSystem();
		} finally {
			factory.shutdown();
			GUIModel.setFactory(null);
		}
	}
}
