package org.jclarion.clarion.appgen.template.cmd;
import java.io.IOException;
import java.io.Reader;
import java.nio.CharBuffer;
import java.util.List;



import org.jclarion.clarion.appgen.template.BufferedWriteTarget;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.WriteTarget;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class AppendCmd extends Statement
{
	private CExpr file;
	private String section;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("SECTION")) {
			section="";
			return;
		}
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#APPEND") && params.size()==1) {
			file=params.get(0).getExpression();
			return;
		}
		if (name.equals("SECTION") && params.size()==1) {
			section=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getFile() {
		return file;
	}

	public String getSection() {
		return section;
	}

	@Override
	public String toString() {
		return "AppendCmd [file=" + file + ", section=" + section + "]";
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		WriteTarget a = scope.getWriteTarget();
		
		String filename = scope.getTargetPath()+scope.eval(file).toString();
		
		if (filename.indexOf('$')>-1) {
			BufferedWriteTarget sw = scope.getBuffer(filename);
			if (sw!=null) {
				try {
					sw.flushInto(a);
				} catch (IOException e) {
					e.printStackTrace();
				}
				return CodeResult.OK;
			}
		}
		
		try {
			Reader r = scope.getReader(filename,false);
			if (r==null) scope.error("File not found");
			char[] buffer=new char[65536];
			CharBuffer cb = CharBuffer.wrap(buffer);
			while (true) {				
				int len = r.read(buffer);
				if (len<=0) break;
				cb.rewind();
				cb.limit(len);
				a.append(cb);
			}
			r.close();
		} catch (IOException ex) { 
			ex.printStackTrace();
			scope.error(ex.getMessage());
		}
		return CodeResult.OK;
	}	
}
