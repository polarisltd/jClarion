package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprScope;
import org.jclarion.clarion.runtime.expr.LabelExprResult;

/**
 * A symbol value represents a symbol as stored in a clarion App file and as manipulated within Template system.
 * 
 * A symbol can represent a singular value that this emitted into generated code like this. i.e. %VarType = LONG
 *     MyValue %VarType
 *     
 * Or a symbal can be an array which is iterated. i.e.
 *     #FOR(%File)
 *         open(%File)
 *     #FOREND
 *     
 * Array symbols have their backing array and they also have their current value, known as fixed value.    
 * 
 * Symbols can be defined in App file or in Template code, there are also system symbols.  i.e. %File derives from
 * contents of Dictionary file.
 * 
 * Many symbols have one final property; a notion of a dependency. For example the symbol %FileDescription is dependent upon %File,
 * value returned by %FileDescription varies depending on what %File is currently fixed to.  A symbol can be dependent upon multiple 
 * symbols.  This is how collections such as multi dimensional lists and Maps are implemented in clarion template.  Ugly : yes.
 * 
 * Symbols operate in a nested scope.  i.e. Control Scope -> Procedure Scope -> Application Scope -> System Scope
 * 
 * Scalar Symbols are non-mutable.
 *    
 * @author barney
 */

public abstract class SymbolValue implements Cloneable,Comparable<SymbolValue>,LabelExprResult {
	
	public static SymbolValue construct(Lex l)
	{
		if (l.type==LexType.integer) {
			return new IntSymbolValue(Integer.parseInt(l.value));
		}
		if (l.type==LexType.string) {
			return new StringSymbolValue(l.value);
		}
		if (l.type==LexType.picture) {
			return new StringSymbolValue(l.value);
		}
		if (l.type==LexType.label) {
			return new LabelSymbolValue(l.value);
		}
		return null;
	}

	public static SymbolValue construct(Lexer lexer) 
	{
		Lex l = lexer.next();
		if (l.type==LexType.use && lexer.lookahead().type==LexType.label) {
			return new LabelSymbolValue("?"+lexer.next().value);
		}
		if (l.type==LexType.operator && l.value.equals("-")) {
			if (lexer.lookahead().type==LexType.label) {
				return new LabelSymbolValue("-"+lexer.next().value);
			}
			if (lexer.lookahead().type==LexType.integer) {
				return new IntSymbolValue(-Integer.parseInt(lexer.next().value));
			}
		}
		
		return construct(l);
	}	
	
	public static SymbolValue construct(String value)
	{
		if (value==null) {
			return new NullSymbolValue();
		}
		return new StringSymbolValue(value);
	}

	public static SymbolValue construct(int value)
	{
		return new IntSymbolValue(value);
	}

	public abstract int 			getInt();
	public abstract String 			getString();
	
	@Override
	public abstract SymbolValue		clone();

	public static SymbolValue construct(ClarionObject obj) 
	{
		if (obj==null) {
			throw new IllegalStateException("No object");
		}
		if (obj instanceof ClarionNumber)  {
			return new IntSymbolValue(obj.intValue());
		}
		if (obj instanceof EOFObject)  {
			return new EOFSymbolValue();
		}
		if (obj instanceof NullObject)  {
			return new NullSymbolValue();
		}
		if (obj instanceof DefinitionObject)  {
			return new DefinitionSymbolValue( ((DefinitionObject)obj).getDefinition() );
		}
		return new StringSymbolValue(obj.toString());
	}
	
	@Override
	public int compareTo(SymbolValue o) 
	{
		return getString().compareTo(o.getString());
	}	
	
	@Override
	public int hashCode() {
		return getString().hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		return getString().equals(((SymbolValue)obj).getString());
	}
	
	
	public abstract ClarionObject asClarionObject();

	public boolean contains(SymbolValue value)
	{
		return equals(value);
	}

	@Override
	public ClarionObject execute(CExprScope scope, CExpr... params) {
		return asClarionObject();
	}

	public static SymbolValue construct(boolean flag) {
		if (flag) {
			return IntSymbolValue.ONE;
		} else {
			return IntSymbolValue.ZERO;
		}
	}

	public static SymbolValue constructBlank(boolean flag) {
		if (flag) {
			return IntSymbolValue.ONE;
		} else {
			return StringSymbolValue.BLANK;
		}
	}

	public abstract String serialize();
	
	
}

