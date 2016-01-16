package org.jclarion.clarion.appgen.template.cmd;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.EOFSymbolValue;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ReadCmd extends Statement
{

	private String target;
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#READ") && params.size()==1) {
			this.target=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown");
	}

	public String getTarget() {
		return target;
	}

	@Override
	public String toString() {
		return "ReadCmd [target=" + target + "]";
	}


	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		BufferedReader br = scope.getReadSource();
		String line=null;
		if (br!=null) {
			try {
				line = br.readLine();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		SymbolEntry se = scope.getScope().get(target);
		if (line==null) {
			se.scalar().setValue(new EOFSymbolValue());
		} else {
			se.scalar().setValue(new StringSymbolValue(line));
		}
		return CodeResult.OK;
	}

	
}
