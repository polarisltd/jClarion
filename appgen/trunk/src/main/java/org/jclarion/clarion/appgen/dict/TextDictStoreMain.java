package org.jclarion.clarion.appgen.dict;

import java.io.FileWriter;

public class TextDictStoreMain {

	public static void main(String[] args) throws Exception{
		{
			String filenameDict=null;
			if(args.length<1)System.out.println("convert txd. -> .dict. \n Usage: TextDictStoreMain path/to/file.txd path/to/file.dict");
            String filenameTxd = args[0];
            if(args.length>1)
            	filenameDict = args[1];
            else
                filenameDict = filenameTxd.substring(0, filenameTxd.lastIndexOf("."))+".dict";
			DictLoader al = new DictLoader();
			Dict d = al.loadDictionary(filenameTxd);
			
			TextDictStore store = new TextDictStore();
			FileWriter fw =new FileWriter(filenameDict); 
			store.save(d,fw);
			fw.close();	
		}
	}

}