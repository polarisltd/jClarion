package org.jclarion.clarion.appgen.dict;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.Collection;
import java.util.List;

import org.jclarion.clarion.appgen.lang.SourceEncoder;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;

public class TextDictStore {

	
	public static void main(String args[]) throws IOException 
	{
		DictLoader al = new DictLoader();
		Dict d = al.loadDictionary("/home/barney/personal/c8/java/clarion/c9/src/main/clarion/common/c8odbc.txd");
		
		TextDictStore store = new TextDictStore();
		FileWriter fw =new FileWriter("target/app/c8odbc.dict"); 
		store.save(d,fw);
		fw.close();	
	}
	
	public void save(Dict dict,Writer target) throws IOException
	{
		for (File file : dict.getFiles()) {
			target.append(file.getFile().renderUnsplit());
			if (file.isThreaded()) {
				target.append(",THREAD");
			}
			appendParams(target,file);
			appendString(target,"LONGDESC",file.getDescription());
			appendMetaData(target,file);
			target.append('\n');

			
			for (Key key : file.getKeys()) {
				target.append(key.getKey().renderUnsplit());
				appendParams(target,key);
				if (key.getKey().getComment()!=null && key.getKey().getComment().length()>0) {
					target.append(" !").append(key.getKey().getComment());
				}				
				appendMetaData(target,key);
				target.append('\n');
			}

			target.append(file.getRecord().renderUnsplit());
			target.append('\n');

			for (Field field : file.getFields()) {
				target.append(field.getField().renderUnsplit());
				appendParams(target,field);
				if (field.getField().getComment()!=null && field.getField().getComment().length()>0) {
					target.append(" !").append(field.getField().getComment());
				}
				appendMetaData(target,field);
				appendMetaData(target,"QUICK",field.getQuickCode());
				target.append('\n');
			}
			target.append(".\n\n");
		}		
		

		for (RelationKey key : dict.getRelations()) {
			if (key.isOneToMany()) continue;
			target.append("RELATE ");
				
			if (key.getKey()!=null) {
				target.append(key.getFile().getFile().getValue("PRE"));
				target.append(":");
				target.append(key.getKey().getKey().getName());
			} else {
				target.append(key.getFile().getFile().getName());	
			}
			target.append(" ");
			if (key.isOneToMany()) {
				target.append("<");
			} else {
				target.append('>');
			}
			target.append(" ");
			if (key.getOther().getKey()!=null) {
				target.append(key.getOther().getFile().getFile().getValue("PRE"));
				target.append(':');
				target.append(key.getOther().getKey().getKey().getName());
			} else {
				target.append(key.getOther().getFile().getFile().getName());					
			}
			if (key.getDeleteMode().length()>0) {		
				target.append(" DELETE(").append(key.getDeleteMode()).append(")");
			}
			if (key.getUpdateMode().length()>0) {
				target.append(" UPDATE(").append(key.getUpdateMode()).append(")");
			}
			target.append("\n");
			for (Join j : key.getJoins()) {
				if (j.getFrom()==null || j.getTo()==null) continue;
				target.append("\t");
				target.append(key.getFile().getFile().getValue("PRE")).append(":");
				target.append(j.getFrom().getField().getName());
				target.append(" = ");
				target.append(key.getOther().getFile().getFile().getValue("PRE")).append(":");
				target.append(j.getTo().getField().getName());
				target.append("\n");
			}
			target.append(".\n\n");
		}
	}

	private void appendParams(Writer target, Identity file) throws IOException 
	{
		appendParams(target,file.getParameters().values());
	}

	private void appendMetaData(Writer target, Identity file) throws IOException
	{
		appendMetaData(target,"SCREEN",file.getScreenControls());
		appendMetaData(target,"REPORT",file.getReportControls());
	}
	
	private void appendMetaData(Writer target, String string,List<Definition> controls)
		throws IOException
	{
		if (controls==null) return;
		if (controls.isEmpty()) return;
		for (Definition d : controls) {
			target.append("\n\t\t\t\t#").append(string).append(" ");
			target.append(d.getStatement().renderUnsplit());
		}
	}

	private void appendParams(Writer target,Collection<DefinitionProperty> values)
		throws IOException
	{ 
		if (values.isEmpty()) return;
		for (DefinitionProperty dp : values) {
			target.append(",");
			target.append(dp.render());
		}
	}

	public void appendString(Writer target,String name,String value) throws IOException
	{
		if (value==null || value.length()==0) return;
		target.append(',').append(name).append('(').append(SourceEncoder.encodeString(value)).append(')');
	}
}
