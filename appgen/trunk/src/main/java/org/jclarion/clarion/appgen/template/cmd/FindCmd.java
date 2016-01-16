package org.jclarion.clarion.appgen.template.cmd;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.user.SymbolFixKey;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

/**
 * At this time, all this business of multi values is quite confusing.  Working with some javascript puesdo code
 * 
 * controlUse = "line items"
 * file = [ "header", "detail", "inventory" ]
 * fileDesc = { "header" => "Invoices", "detail" => "line Items", "inventory" => "stock items" }
 * fileSize = { "header" => 10, "detail" => 20, "inventory" => 30 }
 * 
 * Calling #FIND(fileDesc,controlUse) does the following:
 * file = "detail"
 * fileDesc = "lineItems"
 * fileSize = 20
 * 
 * While calling #FIX(file,"header") does the following:
 * file = "header"
 * fileDesc = "Invoices"
 * fileSize = 10
 *
 * And calling #SELECT(file,4) does the following:
 * file = "inventory"
 * fileDesc = "stock items"
 * fileSize = 30
 * 
 * Quite shitty really; because something like fileDesc has global scope,
 * Essentially multi value symbols are like clarion queues. There is queue collection content and then there is current working copy.  
 * 
 * Now #FIND() can accept a 3rd parameter.  a limit, which limits dependent symbol that can be searched. As a variable like fileDesc can have 
 * multiple dependent variables.
 * 
 * Assume #FIX and #SET are quite different things.  #FIX primes dependent vars only, whereas #SET primes for adding new variable
 *
 * I think with a bit of effort we can create a much improved internal structure.   
 * 
 * @author barney
 *
 */
public class FindCmd extends Statement
{
	private String key;
	private CExpr find;
	private String limit;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#FIND") && params.size()>=2 && params.size()<=3) {
			key=params.get(0).getString();
			find=params.get(1).getExpression();
			if (params.size()==3) {
				limit=params.get(2).getString();
			}
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getKey() {
		return key;
	}

	public CExpr getFind() {
		return find;
	}

	public String getLimit() {
		return limit;
	}

	@Override
	public String toString() {
		return "FindCmd [key=" + key + ", find=" + find + ", limit=" + limit
				+ "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		SymbolEntry symbol = scope.getScope().get(key);
		if (symbol==null) throw new IllegalStateException("Symbol not found"); 
		
		SymbolValue value = SymbolValue.construct(scope.eval(find));
		
		List<SymbolEntry> keys= new ArrayList<SymbolEntry>();
		for (SymbolEntry s : symbol.getDependencies()) {
			keys.add(s);
		}
		int limit=0;
		if (this.limit!=null) {
			while (!keys.get(limit).getName().equalsIgnoreCase(this.limit)) {
				limit++;
			}
		}
				
		String limit_values[] = new String[limit];
		for (int scan=0;scan<limit_values.length;scan++) {
			limit_values[scan]=keys.get(scan).getValue().getString();
		}
		
		
		for (SymbolFixKey key : symbol.getStore().find(value,limit)) {
			boolean match=true;
			for (int scan=0;scan<limit_values.length;scan++) {
				if (!limit_values[scan].equals(key.getValue(scan))) {
					match=false;
					break;
				}
			}
			if (!match) continue;
			
			boolean fixed=false;
			for (int scan=0;scan<keys.size();scan++) {
				if (key==null) {
					System.err.println("KEY IS NULL! while looking for "+value+" in "+this.key);
					symbol.getStore().find(value,limit).iterator().hasNext();
				}
				SymbolValue newValue = new StringSymbolValue(key.getValue(scan));
				ListSymbolValue oldValue = keys.get(scan).list().values(); 
				if (fixed || oldValue.value()==null || !oldValue.value().equals(newValue)) {
					//fixed=true;
					oldValue.fix(newValue);
				}
			}
			if (symbol.list()!=null) {
				if (!symbol.list().values().fix(value)) {
					throw new IllegalStateException("failed to fix! "+value+" in : "+symbol.list().values()+" with: "+key);
				}
			}
			if (!symbol.getValue().equals(value)) {
				throw new IllegalStateException("A find was claimed but it does not match");
			}
			return CodeResult.OK;
		}
		// unfix latest 
		keys.get(keys.size()-1).list().values().clear();
		//symbol.clear();
		return CodeResult.OK;
	}
	
}

