package org.jclarion.clarion.test.simpleapp;

public class MainRecord {
	public static void main(String args[]) {
		org.jclarion.clarion.test.Record.main(new String[] { 
				"--name","testDefault",
				"--class","org.jclarion.clarion.test.SimpleAutoTest",
				"--main","org.jclarion.clarion.test.simpleapp.Main" });
	}
}
