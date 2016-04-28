package clarion.abfuzzy;

import clarion.abfuzzy.Abfuzzy;
import clarion.equates.Constants;
import clarion.equates.Matchoption;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Fuzzyclass
{
	public ClarionArray<ClarionArray<ClarionNumber>> basevalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS).dim(Constants.MAXWORDS);
	public ClarionString doc=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionNumber nocase=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString query=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionArray<ClarionNumber> qwordpos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(Constants.MAXWORDS);
	public ClarionNumber res=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionArray<ClarionArray<ClarionNumber>> resultindex=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(Constants.MAXWORDS).dim(Constants.MAXRESULTS);
	public ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionArray<ClarionArray<ClarionNumber>> returnindex=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS).dim(Constants.MAXWORDLEN);
	public ClarionArray<ClarionNumber> returnindexdone=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS);
	public ClarionNumber wordcnt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber wordonly=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionArray<ClarionString> words=Clarion.newString(Constants.MAXWORDLEN).setEncoding(ClarionString.CSTRING).dim(Constants.MAXWORDS);
	public Fuzzyclass()
	{
		basevalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS).dim(Constants.MAXWORDS);
		doc=Clarion.newString().setEncoding(ClarionString.ASTRING);
		nocase=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		query=Clarion.newString().setEncoding(ClarionString.ASTRING);
		qwordpos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(Constants.MAXWORDS);
		res=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		resultindex=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(Constants.MAXWORDS).dim(Constants.MAXRESULTS);
		ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnindex=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS).dim(Constants.MAXWORDLEN);
		returnindexdone=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS);
		wordcnt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		wordonly=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		words=Clarion.newString(Constants.MAXWORDLEN).setEncoding(ClarionString.CSTRING).dim(Constants.MAXWORDS);
		if (this.getClass()==Fuzzyclass.class) construct();
	}

	public ClarionNumber _computepercentage(ClarionString doc,ClarionNumber pos,ClarionString word,ClarionNumber whichword)
	{
		ClarionNumber res=Clarion.newNumber(100).setEncoding(ClarionNumber.BYTE);
		ClarionString a=Clarion.newString(1);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		l.setValue(word.len());
		if (this.nocase.boolValue() && !doc.sub(pos.intValue(),l.intValue()).equals(this.query.sub(this.qwordpos.get(whichword.intValue()).intValue(),l.intValue()))) {
			res.decrement(10);
		}
		if (!l.equals(doc.len())) {
			a.setValue(doc.sub(pos.add(l).intValue(),1));
			res.setValue(this._isworddelimiter(a.like()).equals(Constants.TRUE) ? res : a.equals("-") ? res.subtract(2) : res.subtract(5));
			if (pos.equals(1)) {
				return res.subtract(10).getNumber();
			}
			else {
				res.decrement(15);
				a.setValue(doc.sub(pos.subtract(1).intValue(),1));
				res.setValue(this._isworddelimiter(a.like(),Clarion.newNumber(Constants.TRUE)).equals(Constants.TRUE) ? res : a.equals("-") ? res.subtract(3) : res.subtract(10));
			}
		}
		return res.like();
	}
	public void _computereturnindex(ClarionNumber whichword)
	{
		ClarionString s=Clarion.newString(Constants.MAXWORDLEN).setEncoding(ClarionString.CSTRING);
		ClarionArray<ClarionNumber> si=Clarion.newNumber(1).setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDLEN);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		s.setValue(this.words.get(whichword.intValue()));
		i.setValue(1);
		j.setValue(0);
		si.get(1).setValue(0);
		while (true) {
			if (!j.boolValue() || s.stringAt(i).equals(s.stringAt(j))) {
				i.increment(1);
				j.increment(1);
				si.get(i.intValue()).setValue(j);
			}
			else {
				j.setValue(si.get(j.intValue()));
			}
			if (i.compareTo(s.len())>0) break;
		}
		final int loop_1=s.len();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.returnindex.get(whichword.intValue()).get(i.intValue()).setValue(si.get(i.intValue()));
		}
		this.returnindexdone.get(whichword.intValue()).setValue(Constants.TRUE);
	}
	public ClarionNumber _evaluate(ClarionString doc)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		final ClarionNumber loop_1=this.wordcnt.like();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			ret.increment(this.basevalue.get(this.wordcnt.intValue()).get(i.intValue()).multiply(this._evaluateword(doc.like(),this.words.get(i.intValue()).like(),i.like())).multiply("0.01"));
		}
		return ret.like();
	}
	public ClarionNumber _evaluateword(ClarionString doc,ClarionString word,ClarionNumber whichword)
	{
		ClarionNumber percentage=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber best=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		final int loop_1=Constants.MAXRESULTS;for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			if (!this.resultindex.get(whichword.intValue()).get(i.intValue()).boolValue()) {
				break;
			}
			percentage.setValue(this._computepercentage(doc.like(),this.resultindex.get(whichword.intValue()).get(i.intValue()).like(),word.like(),whichword.like()));
			if (percentage.compareTo(best)>0) {
				best.setValue(percentage);
			}
		}
		return best.like();
	}
	public ClarionNumber _getreturnindex(ClarionNumber whichword,ClarionNumber idx)
	{
		if (!this.returnindexdone.get(whichword.intValue()).boolValue()) {
			this._computereturnindex(whichword.like());
		}
		return this.returnindex.get(whichword.intValue()).get(idx.intValue()).like();
	}
	public ClarionNumber _isworddelimiter(ClarionString p0)
	{
		return _isworddelimiter(p0,Clarion.newNumber(Constants.FALSE));
	}
	public ClarionNumber _isworddelimiter(ClarionString c,ClarionNumber leading)
	{
		if (leading.boolValue()) {
			return Clarion.newNumber(c.equals("") || c.equals("'") || c.equals("\"") ? 1 : 0);
		}
		else {
			return Clarion.newNumber(c.equals("") || c.equals(".") || c.equals(",") || c.equals("!") || c.equals("?") || c.equals("'") || c.equals("\"") ? 1 : 0);
		}
	}
	public void _splitquery(ClarionString query)
	{
		ClarionNumber i=Clarion.newNumber(0).setEncoding(ClarionNumber.USHORT);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber k=Clarion.newNumber(1).setEncoding(ClarionNumber.BYTE);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber blanks=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.words.clear();
		this.wordcnt.clear();
		this.qwordpos.clear();
		query.setValue(query.left());
		l.setValue(query.len());
		if (!l.boolValue()) {
			return;
		}
		CRun._assert(l.compareTo(Constants.MAXDOCLEN)<=0);
		final ClarionNumber loop_1=l.like();for (j.setValue(1);j.compareTo(loop_1)<=0;j.increment(1)) {
			if (!query.sub(j.intValue(),1).equals("")) {
				if (blanks.boolValue()) {
					blanks.setValue(Constants.FALSE);
					this.qwordpos.get(k.intValue()).setValue(j);
				}
				i.increment(1);
				this.words.get(k.intValue()).setStringAt(i,query.sub(j.intValue(),1));
			}
			else {
				if (!blanks.boolValue()) {
					blanks.setValue(Constants.TRUE);
					this.words.get(k.intValue()).setStringAt(i.add(1),"\u0000");
					i.setValue(0);
					k.increment(1);
				}
			}
		}
		this.words.get(k.intValue()).setStringAt(i.add(1),"\u0000");
		this.wordcnt.setValue(k);
	}
	public void _findmatches(ClarionString doc)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionArray<ClarionNumber> idx=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT).dim(this.wordcnt.intValue());
		ClarionArray<ClarionNumber> found=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT).dim(this.wordcnt.intValue());
		ClarionArray<ClarionNumber> candidate=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(this.wordcnt.intValue());
		l.setValue(doc.len());
		final ClarionNumber loop_2=l.like();for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
			final ClarionNumber loop_1=this.wordcnt.like();for (j.setValue(1);j.compareTo(loop_1)<=0;j.increment(1)) {
				if (this.words.get(j.intValue()).stringAt(idx.get(j.intValue())).equals(doc.sub(i.intValue(),1))) {
					if (idx.get(j.intValue()).equals(1)) {
						if (this.wordonly.boolValue() && i.compareTo(1)>0 && !this._isworddelimiter(doc.sub(i.subtract(1).intValue(),1),Clarion.newNumber(Constants.TRUE)).boolValue()) {
							continue;
						}
						else {
							candidate.get(j.intValue()).setValue(i);
						}
					}
					if (idx.get(j.intValue()).equals(this.words.get(j.intValue()).len())) {
						if (!(this.wordonly.boolValue() && i.compareTo(l)<0 && !this._isworddelimiter(doc.sub(i.add(1).intValue(),1)).boolValue())) {
							this.resultindex.get(j.intValue()).get(found.get(j.intValue()).intValue()).setValue(candidate.get(j.intValue()));
							found.get(j.intValue()).increment(1);
						}
						idx.get(j.intValue()).setValue(1);
					}
					else {
						idx.get(j.intValue()).increment(1);
					}
				}
				else {
					if (idx.get(j.intValue()).compareTo(1)>0) {
						while (true) {
							idx.get(j.intValue()).setValue(this._getreturnindex(j.like(),idx.get(j.intValue()).like()));
							if (this.words.get(j.intValue()).stringAt(idx.get(j.intValue())).equals(doc.sub(i.intValue(),1))) {
								candidate.get(j.intValue()).setValue(i.subtract(idx.get(j.intValue())).add(1));
								idx.get(j.intValue()).increment(1);
								break;
							}
							if (idx.get(j.intValue()).equals(1)) break;
						}
					}
				}
			}
		}
	}
	public void construct()
	{
		this.basevalue.get(1).get(1).setValue(100);
		this.basevalue.get(2).get(1).setValue(65);
		this.basevalue.get(2).get(2).setValue(35);
		this.basevalue.get(3).get(1).setValue(50);
		this.basevalue.get(3).get(2).setValue(30);
		this.basevalue.get(3).get(3).setValue(20);
		this.basevalue.get(4).get(1).setValue(40);
		this.basevalue.get(4).get(2).setValue(30);
		this.basevalue.get(4).get(3).setValue(20);
		this.basevalue.get(4).get(4).setValue(10);
		this.basevalue.get(5).get(1).setValue(34);
		this.basevalue.get(5).get(2).setValue(27);
		this.basevalue.get(5).get(3).setValue(20);
		this.basevalue.get(5).get(4).setValue(13);
		this.basevalue.get(5).get(5).setValue(6);
		this.basevalue.get(6).get(1).setValue(29);
		this.basevalue.get(6).get(2).setValue(24);
		this.basevalue.get(6).get(3).setValue(19);
		this.basevalue.get(6).get(4).setValue(14);
		this.basevalue.get(6).get(5).setValue(9);
		this.basevalue.get(6).get(6).setValue(5);
		this.basevalue.get(7).get(1).setValue(25);
		this.basevalue.get(7).get(2).setValue(21);
		this.basevalue.get(7).get(3).setValue(17);
		this.basevalue.get(7).get(4).setValue(14);
		this.basevalue.get(7).get(5).setValue(11);
		this.basevalue.get(7).get(6).setValue(8);
		this.basevalue.get(7).get(7).setValue(4);
		this.basevalue.get(8).get(1).setValue(20);
		this.basevalue.get(8).get(2).setValue(18);
		this.basevalue.get(8).get(3).setValue(15);
		this.basevalue.get(8).get(4).setValue(14);
		this.basevalue.get(8).get(5).setValue(11);
		this.basevalue.get(8).get(6).setValue(10);
		this.basevalue.get(8).get(7).setValue(7);
		this.basevalue.get(8).get(8).setValue(5);
		this.basevalue.get(9).get(1).setValue(20);
		this.basevalue.get(9).get(2).setValue(17);
		this.basevalue.get(9).get(3).setValue(15);
		this.basevalue.get(9).get(4).setValue(13);
		this.basevalue.get(9).get(5).setValue(11);
		this.basevalue.get(9).get(6).setValue(9);
		this.basevalue.get(9).get(7).setValue(7);
		this.basevalue.get(9).get(8).setValue(5);
		this.basevalue.get(9).get(9).setValue(3);
		this.basevalue.get(10).get(1).setValue(19);
		this.basevalue.get(10).get(2).setValue(17);
		this.basevalue.get(10).get(3).setValue(15);
		this.basevalue.get(10).get(4).setValue(13);
		this.basevalue.get(10).get(5).setValue(11);
		this.basevalue.get(10).get(6).setValue(9);
		this.basevalue.get(10).get(7).setValue(7);
		this.basevalue.get(10).get(8).setValue(5);
		this.basevalue.get(10).get(9).setValue(3);
		this.basevalue.get(10).get(10).setValue(1);
	}
	public void init()
	{
		this.nocase.clear();
		this.wordonly.clear();
		Abfuzzy.fuzzyobject=this;
	}
	public void kill()
	{
	}
	public ClarionNumber match(ClarionString doc,ClarionString query)
	{
		if (!doc.boolValue()) {
			return Clarion.newNumber(0);
		}
		else if (!query.boolValue()) {
			return Clarion.newNumber(100);
		}
		match_clearvar();
		if (!this.query.equals(query)) {
			this.query.setValue(query);
			this._splitquery(this.nocase.intValue()==1 ?query.upper():query);
			this.returnindexdone.clear();
		}
		this._findmatches(this.nocase.intValue()==1 ?doc.upper():doc);
		return this._evaluate(doc.like());
	}
	public void match_clearvar()
	{
		this.resultindex.clear();
	}
	public void setoption(ClarionNumber p0)
	{
		setoption(p0,Clarion.newNumber(Constants.TRUE));
	}
	public void setoption(ClarionNumber whichoption,ClarionNumber value)
	{
		{
			ClarionNumber case_1=whichoption;
			boolean case_1_break=false;
			if (case_1.equals(Matchoption.NOCASE)) {
				if (!this.nocase.equals(value.boolValue() ? 1 : 0)) {
					this.nocase.setValue(value.boolValue() ? 1 : 0);
					this.query.clear();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Matchoption.WORDONLY)) {
				this.wordonly.setValue(value.boolValue() ? 1 : 0);
				case_1_break=true;
			}
		}
	}
}
