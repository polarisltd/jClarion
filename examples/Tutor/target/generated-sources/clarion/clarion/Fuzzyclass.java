package clarion;

import clarion.Abfuzzy;
import clarion.equates.Constants;
import clarion.equates.Matchoption;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;

public class Fuzzyclass
{
	public ClarionArray<ClarionArray<ClarionNumber>> baseValue;
	public ClarionString doc;
	public ClarionNumber noCase;
	public ClarionString query;
	public ClarionArray<ClarionNumber> qWordPos;
	public ClarionNumber res;
	public ClarionArray<ClarionArray<ClarionNumber>> resultIndex;
	public ClarionNumber ret;
	public ClarionArray<ClarionArray<ClarionNumber>> returnIndex;
	public ClarionArray<ClarionNumber> returnIndexDone;
	public ClarionNumber wordCnt;
	public ClarionNumber wordOnly;
	public ClarionArray<ClarionString> words;
	public Fuzzyclass()
	{
		baseValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS).dim(Constants.MAXWORDS);
		doc=Clarion.newString().setEncoding(ClarionString.ASTRING);
		noCase=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		query=Clarion.newString().setEncoding(ClarionString.ASTRING);
		qWordPos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(Constants.MAXWORDS);
		res=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		resultIndex=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(Constants.MAXWORDS).dim(Constants.MAXRESULTS);
		ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnIndex=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS).dim(Constants.MAXWORDLEN);
		returnIndexDone=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDS);
		wordCnt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		wordOnly=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		words=Clarion.newString(Constants.MAXWORDLEN).setEncoding(ClarionString.CSTRING).dim(Constants.MAXWORDS);
		construct();
	}

	public ClarionNumber _computePercentage(ClarionString doc,ClarionNumber pos,ClarionString word,ClarionNumber whichWord)
	{
		ClarionNumber res=Clarion.newNumber(100).setEncoding(ClarionNumber.BYTE);
		ClarionString a=Clarion.newString(1);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		l.setValue(word.len());
		if (this.noCase.boolValue() && !doc.sub(pos.intValue(),l.intValue()).equals(this.query.sub(this.qWordPos.get(whichWord.intValue()).intValue(),l.intValue()))) {
			res.decrement(10);
		}
		if (!l.equals(doc.len())) {
			a.setValue(doc.sub(pos.add(l).intValue(),1));
			res.setValue(this._isWordDelimiter(a.like()).equals(Constants.TRUE) ? res : a.equals("-") ? res.subtract(2) : res.subtract(5));
			if (pos.equals(1)) {
				return res.subtract(10).getNumber();
			}
			else {
				res.decrement(15);
				a.setValue(doc.sub(pos.subtract(1).intValue(),1));
				res.setValue(this._isWordDelimiter(a.like(),Clarion.newNumber(Constants.TRUE)).equals(Constants.TRUE) ? res : a.equals("-") ? res.subtract(3) : res.subtract(10));
			}
		}
		return res.like();
	}
	public void _computeReturnIndex(ClarionNumber whichWord)
	{
		ClarionString s=Clarion.newString(Constants.MAXWORDLEN).setEncoding(ClarionString.CSTRING);
		ClarionArray<ClarionNumber> si=Clarion.newNumber(1).setEncoding(ClarionNumber.BYTE).dim(Constants.MAXWORDLEN);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		s.setValue(this.words.get(whichWord.intValue()));
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
		for (i.setValue(1);i.compareTo(s.len())<=0;i.increment(1)) {
			this.returnIndex.get(whichWord.intValue()).get(i.intValue()).setValue(si.get(i.intValue()));
		}
		this.returnIndexDone.get(whichWord.intValue()).setValue(Constants.TRUE);
	}
	public ClarionNumber _evaluate(ClarionString doc)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		for (i.setValue(1);i.compareTo(this.wordCnt)<=0;i.increment(1)) {
			ret.increment(this.baseValue.get(this.wordCnt.intValue()).get(i.intValue()).multiply(this._evaluateWord(doc.like(),this.words.get(i.intValue()).like(),i.like())).multiply("0.01"));
		}
		return ret.like();
	}
	public ClarionNumber _evaluateWord(ClarionString doc,ClarionString word,ClarionNumber whichWord)
	{
		ClarionNumber percentage=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber best=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		for (i.setValue(1);i.compareTo(Constants.MAXRESULTS)<=0;i.increment(1)) {
			if (!this.resultIndex.get(whichWord.intValue()).get(i.intValue()).boolValue()) {
				break;
			}
			percentage.setValue(this._computePercentage(doc.like(),this.resultIndex.get(whichWord.intValue()).get(i.intValue()).like(),word.like(),whichWord.like()));
			if (percentage.compareTo(best)>0) {
				best.setValue(percentage);
			}
		}
		return best.like();
	}
	public ClarionNumber _getReturnIndex(ClarionNumber whichWord,ClarionNumber idx)
	{
		if (!this.returnIndexDone.get(whichWord.intValue()).boolValue()) {
			this._computeReturnIndex(whichWord.like());
		}
		return this.returnIndex.get(whichWord.intValue()).get(idx.intValue()).like();
	}
	public ClarionNumber _isWordDelimiter(ClarionString p0)
	{
		return _isWordDelimiter(p0,Clarion.newNumber(Constants.FALSE));
	}
	public ClarionNumber _isWordDelimiter(ClarionString c,ClarionNumber leading)
	{
		if (leading.boolValue()) {
			return Clarion.newNumber(c.equals("") || c.equals("'") || c.equals("\"") ? 1 : 0);
		}
		else {
			return Clarion.newNumber(c.equals("") || c.equals(".") || c.equals(",") || c.equals("!") || c.equals("?") || c.equals("'") || c.equals("\"") ? 1 : 0);
		}
	}
	public void _splitQuery(ClarionString query)
	{
		ClarionNumber i=Clarion.newNumber(0).setEncoding(ClarionNumber.USHORT);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber k=Clarion.newNumber(1).setEncoding(ClarionNumber.BYTE);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber blanks=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.words.clear();
		this.wordCnt.clear();
		this.qWordPos.clear();
		query.setValue(query.left());
		l.setValue(query.len());
		if (!l.boolValue()) {
			return;
		}
		CRun._assert(l.compareTo(Constants.MAXDOCLEN)<=0);
		for (j.setValue(1);j.compareTo(l)<=0;j.increment(1)) {
			if (!query.sub(j.intValue(),1).equals("")) {
				if (blanks.boolValue()) {
					blanks.setValue(Constants.FALSE);
					this.qWordPos.get(k.intValue()).setValue(j);
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
		this.wordCnt.setValue(k);
	}
	public void _findMatches(ClarionString doc)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionArray<ClarionNumber> idx=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT).dim(this.wordCnt.intValue());
		ClarionArray<ClarionNumber> found=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT).dim(this.wordCnt.intValue());
		ClarionArray<ClarionNumber> candidate=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(this.wordCnt.intValue());
		l.setValue(doc.len());
		for (i.setValue(1);i.compareTo(l)<=0;i.increment(1)) {
			for (j.setValue(1);j.compareTo(this.wordCnt)<=0;j.increment(1)) {
				if (this.words.get(j.intValue()).stringAt(idx.get(j.intValue())).equals(doc.sub(i.intValue(),1))) {
					if (idx.get(j.intValue()).equals(1)) {
						if (this.wordOnly.boolValue() && i.compareTo(1)>0 && !this._isWordDelimiter(doc.sub(i.subtract(1).intValue(),1),Clarion.newNumber(Constants.TRUE)).boolValue()) {
							continue;
						}
						else {
							candidate.get(j.intValue()).setValue(i);
						}
					}
					if (idx.get(j.intValue()).equals(this.words.get(j.intValue()).len())) {
						if (!(this.wordOnly.boolValue() && i.compareTo(l)<0 && !this._isWordDelimiter(doc.sub(i.add(1).intValue(),1)).boolValue())) {
							this.resultIndex.get(j.intValue()).get(found.get(j.intValue()).intValue()).setValue(candidate.get(j.intValue()));
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
							idx.get(j.intValue()).setValue(this._getReturnIndex(j.like(),idx.get(j.intValue()).like()));
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
		this.baseValue.get(1).get(1).setValue(100);
		this.baseValue.get(2).get(1).setValue(65);
		this.baseValue.get(2).get(2).setValue(35);
		this.baseValue.get(3).get(1).setValue(50);
		this.baseValue.get(3).get(2).setValue(30);
		this.baseValue.get(3).get(3).setValue(20);
		this.baseValue.get(4).get(1).setValue(40);
		this.baseValue.get(4).get(2).setValue(30);
		this.baseValue.get(4).get(3).setValue(20);
		this.baseValue.get(4).get(4).setValue(10);
		this.baseValue.get(5).get(1).setValue(34);
		this.baseValue.get(5).get(2).setValue(27);
		this.baseValue.get(5).get(3).setValue(20);
		this.baseValue.get(5).get(4).setValue(13);
		this.baseValue.get(5).get(5).setValue(6);
		this.baseValue.get(6).get(1).setValue(29);
		this.baseValue.get(6).get(2).setValue(24);
		this.baseValue.get(6).get(3).setValue(19);
		this.baseValue.get(6).get(4).setValue(14);
		this.baseValue.get(6).get(5).setValue(9);
		this.baseValue.get(6).get(6).setValue(5);
		this.baseValue.get(7).get(1).setValue(25);
		this.baseValue.get(7).get(2).setValue(21);
		this.baseValue.get(7).get(3).setValue(17);
		this.baseValue.get(7).get(4).setValue(14);
		this.baseValue.get(7).get(5).setValue(11);
		this.baseValue.get(7).get(6).setValue(8);
		this.baseValue.get(7).get(7).setValue(4);
		this.baseValue.get(8).get(1).setValue(20);
		this.baseValue.get(8).get(2).setValue(18);
		this.baseValue.get(8).get(3).setValue(15);
		this.baseValue.get(8).get(4).setValue(14);
		this.baseValue.get(8).get(5).setValue(11);
		this.baseValue.get(8).get(6).setValue(10);
		this.baseValue.get(8).get(7).setValue(7);
		this.baseValue.get(8).get(8).setValue(5);
		this.baseValue.get(9).get(1).setValue(20);
		this.baseValue.get(9).get(2).setValue(17);
		this.baseValue.get(9).get(3).setValue(15);
		this.baseValue.get(9).get(4).setValue(13);
		this.baseValue.get(9).get(5).setValue(11);
		this.baseValue.get(9).get(6).setValue(9);
		this.baseValue.get(9).get(7).setValue(7);
		this.baseValue.get(9).get(8).setValue(5);
		this.baseValue.get(9).get(9).setValue(3);
		this.baseValue.get(10).get(1).setValue(19);
		this.baseValue.get(10).get(2).setValue(17);
		this.baseValue.get(10).get(3).setValue(15);
		this.baseValue.get(10).get(4).setValue(13);
		this.baseValue.get(10).get(5).setValue(11);
		this.baseValue.get(10).get(6).setValue(9);
		this.baseValue.get(10).get(7).setValue(7);
		this.baseValue.get(10).get(8).setValue(5);
		this.baseValue.get(10).get(9).setValue(3);
		this.baseValue.get(10).get(10).setValue(1);
	}
	public void init()
	{
		this.noCase.clear();
		this.wordOnly.clear();
		Abfuzzy.fuzzyObject=this;
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
		match_ClearVar();
		if (!this.query.equals(query)) {
			this.query.setValue(query);
			this._splitQuery(this.noCase.intValue()==1 ?query.upper():query);
			this.returnIndexDone.clear();
		}
		this._findMatches(this.noCase.intValue()==1 ?doc.upper():doc);
		return this._evaluate(doc.like());
	}
	public void match_ClearVar()
	{
		this.resultIndex.clear();
	}
	public void setOption(ClarionNumber p0)
	{
		setOption(p0,Clarion.newNumber(Constants.TRUE));
	}
	public void setOption(ClarionNumber whichOption,ClarionNumber value)
	{
		{
			ClarionNumber case_1=whichOption;
			boolean case_1_break=false;
			if (case_1.equals(Matchoption.NOCASE)) {
				if (!this.noCase.equals(value.boolValue() ? 1 : 0)) {
					this.noCase.setValue(value.boolValue() ? 1 : 0);
					this.query.clear();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Matchoption.WORDONLY)) {
				this.wordOnly.setValue(value.boolValue() ? 1 : 0);
				case_1_break=true;
			}
		}
	}
}
