package clarion;

import clarion.Errorclass;
import clarion.Token;
import clarion.equates.Constants;
import clarion.equates.Msg;
import clarion.equates.Tokentype;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Attributeparser
{
	public Errorclass errors;
	public ClarionString caller;
	public Token token;
	public Attributeparser()
	{
		errors=null;
		caller=null;
		token=new Token();
	}

	public ClarionNumber getNextToken(ClarionString comment,ClarionNumber strLen,ClarionString endList,ClarionNumber pos)
	{
		ClarionNumber strPos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber inQuote=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (pos.compareTo(strLen)<=0 && comment.stringAt(pos).val()==Clarion.newString(" ").val()) {
			pos.increment(1);
		}
		if (pos.compareTo(strLen)<=0) {
			{
				int case_1=comment.stringAt(pos).val();
				boolean case_1_break=false;
				if (case_1==Clarion.newString(Constants.ATTRIBUTETYPESEPERATOR).val()) {
					this.token.type.setValue(Tokentype.ATTRIBUTETYPESEPERATOR);
					pos.increment(1);
					return Clarion.newNumber(Constants.FALSE);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1==Clarion.newString(Constants.ATTRIBUTESEPERATOR).val()) {
					this.token.type.setValue(Tokentype.ATTRIBUTESEPERATOR);
					pos.increment(1);
					return Clarion.newNumber(Constants.FALSE);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1==Clarion.newString(Constants.ATTRIBUTELISTSTART).val()) {
					this.token.type.setValue(Tokentype.WRITER_ATTRIBUTESEPERATOR);
					pos.increment(1);
					return Clarion.newNumber(Constants.FALSE);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1==Clarion.newString(Constants.ATTRIBUTELISTEND).val()) {
					this.token.type.setValue(Tokentype.ATTRIBUTELISTEND);
					pos.increment(1);
					return Clarion.newNumber(Constants.FALSE);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1==Clarion.newString(Constants.WRITERSEPERATOR).val()) {
					this.token.type.setValue(Tokentype.WRITERSEPERATOR);
					pos.increment(1);
					return Clarion.newNumber(Constants.FALSE);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break) {
					this.token.type.setValue(Tokentype.STRING);
					strPos.setValue(1);
					if (comment.stringAt(pos).val()==Clarion.newString(Constants.QUOTECHAR).val()) {
						inQuote.setValue(Constants.TRUE);
						pos.increment(1);
					}
					else {
						inQuote.setValue(Constants.FALSE);
					}
					this.token.str.setValue(" ");
					while (pos.compareTo(strLen)<=0) {
						if (inQuote.boolValue()) {
							if (comment.stringAt(pos).val()==Clarion.newString(Constants.QUOTECHAR).val()) {
								pos.increment(1);
								if (pos.compareTo(strLen)>0 || comment.stringAt(pos).val()!=Clarion.newString(Constants.QUOTECHAR).val()) {
									inQuote.setValue(Constants.FALSE);
									break;
								}
							}
						}
						else if (endList.inString(comment.stringAt(pos).toString(),1,1)!=0) {
							break;
						}
						this.token.str.setStringAt(strPos,comment.stringAt(pos));
						strPos.increment(1);
						pos.increment(1);
					}
					if (inQuote.boolValue() && !(this.errors==null)) {
						this.errors.setField(pos.subtract(1).getString());
						this.errors.throwMessage(Clarion.newNumber(Msg.RWPPOORCOMMENT),comment.like());
					}
					return Clarion.newNumber(Constants.FALSE);
				}
			}
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
		return Clarion.newNumber();
	}
	public void processAttribute(ClarionString attrType,ClarionString attrValue)
	{
	}
	public void init()
	{
		init((Errorclass)null);
	}
	public void init(Errorclass ec)
	{
		if (ec==null) {
			this.errors=null;
		}
		else {
			this.errors=ec;
		}
	}
	public void processAttributes(ClarionString attributeList)
	{
		ClarionString attrType=Clarion.newString(256);
		ClarionString blankStr=Clarion.newString(1);
		ClarionNumber pos=Clarion.newNumber(1).setEncoding(ClarionNumber.SIGNED);
		ClarionNumber endOfLine=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber haveError=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		ClarionNumber ignoreAttributes=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber strLen=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionString endList=Clarion.newString(3);
		ClarionNumber pState=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		strLen.setValue(attributeList.clip().len());
		while (true) {
			if (pState.equals(0)) {
				endList.setStringAt(1,Constants.ATTRIBUTELISTSTART);
				endList.setStringAt(2,Constants.ATTRIBUTELISTSTART);
				endList.setStringAt(3,Constants.ATTRIBUTELISTSTART);
			}
			else if (pState.equals(2)) {
				endList.setStringAt(1,Constants.ATTRIBUTESEPERATOR);
				endList.setStringAt(2,Constants.ATTRIBUTELISTEND);
				endList.setStringAt(3,Constants.ATTRIBUTETYPESEPERATOR);
			}
			endOfLine.setValue(this.getNextToken(attributeList,strLen.like(),endList,pos));
			if (endOfLine.boolValue()) {
				if (!pState.equals(4) && !pState.equals(0)) {
					haveError.setValue(Constants.TRUE);
				}
				break;
			}
			else {
				{
					ClarionNumber case_1=pState;
					boolean case_1_break=false;
					if (case_1.equals(0)) {
						if (this.token.type.equals(Tokentype.STRING)) {
							pState.setValue(1);
							ignoreAttributes.setValue(!this.token.str.upper().equals(this.caller.upper()) && !this.token.str.upper().equals("ALL") ? 1 : 0);
						}
						else {
							haveError.setValue(Constants.TRUE);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1.equals(1)) {
						if (!this.token.type.equals(Tokentype.WRITER_ATTRIBUTESEPERATOR)) {
							haveError.setValue(Constants.TRUE);
						}
						else {
							pState.setValue(2);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1.equals(2)) {
						if (!this.token.type.equals(Tokentype.STRING)) {
							haveError.setValue(Constants.TRUE);
						}
						else {
							pState.setValue(3);
							if (!ignoreAttributes.boolValue()) {
								attrType.setValue(this.token.str.upper());
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1.equals(3)) {
						if (this.token.type.equals(Tokentype.ATTRIBUTESEPERATOR)) {
							pState.setValue(2);
						}
						else if (this.token.type.equals(Tokentype.ATTRIBUTELISTEND)) {
							pState.setValue(4);
						}
						else if (this.token.type.equals(Tokentype.ATTRIBUTETYPESEPERATOR)) {
							pState.setValue(5);
						}
						else {
							haveError.setValue(Constants.TRUE);
						}
						if (!ignoreAttributes.boolValue() && !haveError.boolValue() && !pState.equals(5)) {
							this.processAttribute(attrType,blankStr);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1.equals(4)) {
						if (!this.token.type.equals(Tokentype.WRITERSEPERATOR)) {
							haveError.setValue(Constants.TRUE);
						}
						else {
							pState.setValue(0);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1.equals(5)) {
						if (this.token.type.equals(Tokentype.ATTRIBUTESEPERATOR)) {
							pState.setValue(2);
						}
						else if (this.token.type.equals(Tokentype.ATTRIBUTELISTEND)) {
							pState.setValue(4);
						}
						else {
							haveError.setValue(Constants.TRUE);
						}
						if (!ignoreAttributes.boolValue() && !haveError.boolValue()) {
							this.processAttribute(attrType,this.token.str);
						}
						case_1_break=true;
					}
					if (!case_1_break) {
						break;
					}
				}
				if (haveError.boolValue()) {
					break;
				}
			}
		}
		if (haveError.boolValue() && !(this.errors==null)) {
			this.errors.setField(pos.getString());
			this.errors.throwMessage(Clarion.newNumber(Msg.RWPPOORCOMMENT),attributeList.like());
		}
	}
}
