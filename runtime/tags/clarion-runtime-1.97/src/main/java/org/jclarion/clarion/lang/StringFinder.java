package org.jclarion.clarion.lang;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Pattern;

public class StringFinder {

	public static void main(String args[]) throws IOException {
		Pattern regex=null;
		for (String file : args ) {
			if (regex==null) {
				regex=Pattern.compile(file);
			} else {
				File f = new File(file);
				FileReader fr = new FileReader(f);
				Lexer lxr = new Lexer(fr,file);
				while ( true ) {
					Lex l = lxr.next();
					if (l.type==LexType.eof) break;
					if (l.type==LexType.string) {
						if (regex.matcher(l.value).find()) {
							System.out.println(file+" "+l.value);
						}
					}
				}
				fr.close();
			}
		}
	}
}
