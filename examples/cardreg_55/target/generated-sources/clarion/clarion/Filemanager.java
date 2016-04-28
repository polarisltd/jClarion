package clarion;

import clarion.Abfile;
import clarion.Bufferqueue;
import clarion.Errorclass;
import clarion.Fieldslist;
import clarion.Filecallbackinterface;
import clarion.Filekeyqueue;
import clarion.Filethreadqueue;
import clarion.Keyfieldqueue;
import clarion.Params;
import clarion.Relationmanager;
import clarion.Savequeue;
import clarion.equates.Constants;
import clarion.equates.Driverop;
import clarion.equates.File;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Usetype;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CRun;

public class Filemanager
{
	public Filemanager aliasedFile;
	public ClarionGroup buffer;
	public Bufferqueue buffers;
	public ClarionNumber create;
	public Errorclass errors;
	public Fieldslist fields;
	public Object fieldTypes;
	public ClarionFile file;
	public ClarionAny fileName;
	public ClarionString fileNameValue;
	public ClarionNumber hasAutoInc;
	public ClarionNumber inUseFile;
	public ClarionNumber inCallBack;
	public ClarionNumber inClose;
	public ClarionNumber inRestore;
	public Filethreadqueue info;
	public Filekeyqueue keys;
	public ClarionNumber lazyOpen;
	public ClarionNumber lockRecover;
	public ClarionNumber openMode;
	public ClarionNumber primaryKey;
	public Savequeue saved;
	public ClarionNumber skipHeldRecords;
	public ClarionNumber cleanedUp;

	private static class _Filecallbackinterface_Impl extends Filecallbackinterface
	{
		private Filemanager _owner;
		public _Filecallbackinterface_Impl(Filemanager _owner)
		{
			this._owner=_owner;
		}
		public ClarionNumber functionCalled(ClarionNumber opCode,Params parameters,ClarionString errCode,ClarionString errMsg)
		{
			if (opCode.equals(Driverop.CLOSE) && _owner.inRestore.boolValue() && _owner.info.opened.boolValue()) {
				_owner.info.opened.setValue(0);
				_owner.info.used.setValue(Constants.FALSE);
				_owner.info.put();
				_owner.close();
			}
			if (opCode.equals(Driverop.DESTROY)) {
				_owner.inCallBack.increment(1);
				if (!parameters.index.boolValue()) {
					Abfile.cleanUp(_owner);
				}
				else if (_owner.info.used.boolValue()) {
				}
				_owner.inCallBack.decrement(1);
			}
			return Clarion.newNumber(Constants.TRUE);
		}
		public ClarionNumber functionDone(ClarionNumber opCode,Params parameters,ClarionString errCode,ClarionString errMsg)
		{
			return Clarion.newNumber(Constants.TRUE);
		}
	}
	private Filecallbackinterface _Filecallbackinterface_inst;
	public Filecallbackinterface filecallbackinterface()
	{
		if (_Filecallbackinterface_inst==null) _Filecallbackinterface_inst=new _Filecallbackinterface_Impl(this);
		return _Filecallbackinterface_inst;
	}
	public Filemanager()
	{
		aliasedFile=null;
		buffer=null;
		buffers=null;
		create=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		errors=null;
		fields=null;
		fieldTypes=null;
		file=null;
		fileName=Clarion.newAny();
		fileNameValue=Clarion.newString(File.MAXFILENAME);
		hasAutoInc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		inUseFile=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		inCallBack=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		inClose=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		inRestore=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		info=null;
		keys=null;
		lazyOpen=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lockRecover=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		openMode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		primaryKey=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		saved=null;
		skipHeldRecords=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		cleanedUp=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void destruct()
	{
		this.kill();
	}
	public ClarionNumber addField(ClarionString p0,ClarionObject p1,ClarionString p2)
	{
		return addField(p0,p1,p2,(ClarionString)null);
	}
	public ClarionNumber addField(ClarionString tag,ClarionObject fld,ClarionString fType,ClarionString fPicture)
	{
		if (this.findField(tag.like()).boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		this.fields.clear();
		this.fields.tag.setValue(tag.upper());
		this.fields.fld.setReferenceValue(fld);
		this.fields.fType.setValue(fType);
		this.fields.fPicture.setValue(Clarion.newBool(fPicture==null).equals(Constants.TRUE) ? Clarion.newString("") : fPicture);
		this.fields.add(this.fields.ORDER().ascend(this.fields.tag));
		return (CError.errorCode()==0 ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.NOTIFY)).getNumber();
	}
	public void addKey(ClarionKey p0,ClarionString p1)
	{
		addKey(p0,p1,Clarion.newNumber(0));
	}
	public void addKey(ClarionKey k,ClarionString desc,ClarionNumber autoInc)
	{
		ClarionNumber cf=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString fb=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.keys.key.set(k);
		this.keys.description.setValue(desc);
		this.keys.fields.set(new Keyfieldqueue());
		this.keys.autoInc.setValue(autoInc);
		if (autoInc.boolValue()) {
			this.hasAutoInc.setValue(1);
		}
		this.keys.dups.setValue(k.getProperty(Prop.DUP));
		this.keys.noCase.setValue(k.getProperty(Prop.NOCASE));
		this.keys.add();
		if (k.getProperty(Prop.PRIMARY).boolValue()) {
			this.primaryKey.setValue(this.keys.records());
		}
		for (i.setValue(1);i.compareTo(k.getProperty(Prop.COMPONENTS))<=0;i.increment(1)) {
			this.keys.fields.get().clear();
			this.keys.fields.get().ascend.setValue(k.getProperty(Prop.ASCENDING,i));
			cf.setValue(k.getProperty(Prop.FIELD,i));
			this.keys.fields.get().field.setReferenceValue(this.buffer.what(cf.intValue()));
			fb.setValue(this.file.getProperty(Prop.LABEL,cf));
			this.keys.fields.get().fieldName.set(Abfile.dupString((this.keys.noCase.boolValue() && (this.keys.fields.get().field.getValue()) instanceof ClarionString ? Clarion.newString(ClarionString.staticConcat("UPPER(",fb,")")) : fb).getString()));
			this.keys.fields.get().add();
		}
	}
	public void bindFields()
	{
		CExpression.bind(this.buffer);
	}
	public ClarionNumber cancelAutoInc()
	{
		return cancelAutoInc((Relationmanager)null);
	}
	public ClarionNumber cancelAutoInc(Relationmanager r)
	{
		ClarionNumber retVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (!this.useFile().boolValue()) {
			if (this.hasAutoInc.boolValue() && this.info.autoIncDone.boolValue()) {
				if (r==null) {
					this.file.delete();
				}
				else {
					retVal.setValue(r.delete(Clarion.newNumber(0)));
				}
				if (!retVal.boolValue()) {
					this.info.autoIncDone.setValue(0);
					this.info.put();
				}
			}
		}
		return retVal.like();
	}
	public void clearKey(ClarionKey p0,ClarionNumber p1,ClarionNumber p2)
	{
		clearKey(p0,p1,p2,Clarion.newNumber(0));
	}
	public void clearKey(ClarionKey p0,ClarionNumber p1)
	{
		clearKey(p0,p1,Clarion.newNumber(22));
	}
	public void clearKey(ClarionKey p0)
	{
		clearKey(p0,Clarion.newNumber(1));
	}
	public void clearKey(ClarionKey k,ClarionNumber lowComp,ClarionNumber highComp,ClarionNumber high)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.setKey(k);
		for (i.setValue(lowComp);i.compareTo(highComp)<=0;i.increment(1)) {
			this.keys.fields.get().get(i);
			if (CError.errorCode()!=0) {
				return;
			}
			if (this.keys.fields.get().ascend.boolValue() ^ high.boolValue()) {
				this.keys.fields.get().field.clear(-1);
			}
			else {
				this.keys.fields.get().field.clear(1);
			}
		}
	}
	public ClarionNumber close()
	{
		this.inClose.increment(1);
		this.setThread();
		Abfile.filesManager.noteClose(this);
		if (this.info.opened.boolValue()) {
			this.info.opened.decrement(1);
			if (!this.info.opened.boolValue()) {
				this.file.close();
				this.info.used.setValue(Constants.FALSE);
			}
			this.info.put();
		}
		this.inClose.decrement(1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber equalBuffer(ClarionNumber id)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		if (this.useFile().boolValue()) {
			return Clarion.newNumber(0);
		}
		this.buffers.id.setValue(id);
		this.buffers.get(this.buffers.ORDER().ascend(this.buffers.id));
		if (!this.buffer.getString().equals(this.buffers.buffer.get())) {
			return Clarion.newNumber(0);
		}
		for (i.setValue(1);i.compareTo(this.file.getProperty(Prop.MEMOS))<=0;i.increment(1)) {
			this.buffers.id.setValue(id.add(i));
			this.buffers.get(this.buffers.ORDER().ascend(this.buffers.id));
			if (!this.file.getProperty(Prop.VALUE,i.negate()).equals(this.buffers.buffer.get())) {
				return Clarion.newNumber(0);
			}
		}
		return Clarion.newNumber(1);
	}
	public ClarionNumber fetch(ClarionKey key)
	{
		ClarionNumber returnCode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnCode.setValue(this.tryFetch(key));
		if (returnCode.boolValue()) {
			this.file.clear();
		}
		return returnCode.like();
	}
	public ClarionNumber findField(ClarionString tag)
	{
		this.fields.tag.setValue(tag.upper());
		this.fields.get(this.fields.ORDER().ascend(this.fields.tag));
		return (CError.errorCode()==0 ? Clarion.newNumber(Constants.TRUE) : Clarion.newNumber(Constants.FALSE)).getNumber();
	}
	public ClarionNumber getComponents(ClarionKey k)
	{
		this.setKey(k);
		return Clarion.newNumber(this.keys.fields.get().records());
	}
	public ClarionNumber getEOF()
	{
		this.setThread();
		return this.info.atEOF.like();
	}
	public ClarionNumber getError()
	{
		this.setThread();
		return this.info.lastError.like();
	}
	public ClarionObject getField(ClarionString tag)
	{
		ClarionAny rVal=Clarion.newAny();
		if (this.findField(tag.like()).boolValue()) {
			rVal.setReferenceValue(this.fields.fld);
		}
		else {
			rVal.setReferenceValue(null);
		}
		return rVal;
	}
	public ClarionObject getField(ClarionKey k,ClarionNumber b)
	{
		this.setKey(k);
		this.keys.fields.get().get(b);
		return this.keys.fields.get().field;
	}
	public ClarionNumber getField(ClarionNumber idx,ClarionString tag,ClarionObject fld)
	{
		ClarionNumber rVal=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
		if (CRun.inRange(idx,Clarion.newNumber(1),Clarion.newNumber(this.fields.records()))) {
			this.fields.get(idx);
			if (!(CError.errorCode()!=0)) {
				tag.setValue(this.fields.tag);
				fld.setValue(this.fields.fld);
				rVal.setValue(Level.BENIGN);
			}
		}
		return rVal.like();
	}
	public ClarionString getFieldType(ClarionString tag)
	{
		return (this.findField(tag.like()).equals(Constants.TRUE) ? this.fields.fType : Clarion.newString("")).getString();
	}
	public ClarionNumber getFields()
	{
		return Clarion.newNumber(this.fields.records());
	}
	public ClarionString getFieldName(ClarionKey k,ClarionNumber b)
	{
		this.setKey(k);
		this.keys.fields.get().get(b);
		return this.keys.fields.get().fieldName.get().like();
	}
	public ClarionString getFieldName(ClarionObject fld)
	{
		ClarionNumber fNum=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		fNum.setValue(this.buffer.where(fld));
		return this.buffer.who(fNum.intValue());
	}
	public ClarionString getFieldPicture(ClarionString tag)
	{
		return (this.findField(tag.like()).equals(Constants.TRUE) ? this.fields.fPicture : Clarion.newString("")).getString();
	}
	public ClarionString getName()
	{
		if (this.fileName.getValue()==null) {
			return this.fileNameValue.like();
		}
		else {
			return this.fileName.getString();
		}
	}
	public void init(ClarionFile file,Errorclass e)
	{
		this.errors=e;
		this.file=file;
		this.info=new Filethreadqueue();
		this.keys=new Filekeyqueue();
		this.buffers=new Bufferqueue();
		this.saved=new Savequeue();
		this.fields=new Fieldslist();
		this.skipHeldRecords.setValue(0);
		this.openMode.setValue(0x42);
		this.create.setValue(1);
		this.lockRecover.setValue(10);
		this.primaryKey.setValue(0);
		this.lazyOpen.setValue(Constants.TRUE);
		this.fileNameValue.setValue(this.file.getProperty(Prop.NAME));
		Abfile.filesManager.addFileMapping(this);
		this.cleanedUp.setValue(Constants.FALSE);
		file.deregisterCallback(this.filecallbackinterface());
	}
	public ClarionNumber insert()
	{
		return this.insertServer(Clarion.newNumber(1));
	}
	public ClarionNumber insertServer(ClarionNumber handleError)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (this.useFile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		if (this.validateRecord().boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		if (this.hasAutoInc.boolValue()) {
			if (this.info.autoIncDone.boolValue()) {
				this.file.put();
			}
			else {
				if (handleError.boolValue() && this.primeAutoInc().boolValue() || !handleError.boolValue() && this.tryPrimeAutoInc().boolValue()) {
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
		}
		else {
			this.file.add();
		}
		{
			int case_1=CError.errorCode();
			boolean case_1_break=false;
			if (case_1==Constants.NOERROR) {
				this.info.autoIncDone.setValue(0);
				this.info.put();
				return Clarion.newNumber(Level.BENIGN);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1==Constants.DUPKEYERR) {
				if (handleError.boolValue()) {
					if (!this.hasAutoInc.boolValue()) {
						this.file.get(Clarion.newString(String.valueOf(0)),null);
					}
					for (i.setValue(1);i.compareTo(this.keys.records())<=0;i.increment(1)) {
						this.keys.get(i);
						if (this.keys.key.get().duplicateCheck()) {
							this.throwMessage(Clarion.newNumber(Msg.DUPLICATEKEY),this.keys.description.like());
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
				}
				else {
					this.setError(Clarion.newNumber(Msg.DUPLICATEKEY));
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				this.setError(Clarion.newNumber(Msg.ADDFAILED));
				if (handleError.boolValue()) {
					return this._throw();
				}
			}
		}
		return Clarion.newNumber(Level.NOTIFY);
	}
	public ClarionString keyToOrder(ClarionKey k,ClarionNumber b)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString retVal=Clarion.newString(512).setEncoding(ClarionString.CSTRING);
		if (!(k==null)) {
			if (!b.boolValue()) {
				b.setValue(1);
			}
			this.setKey(k);
			for (i.setValue(b);i.compareTo(this.keys.fields.get().records())<=0;i.increment(1)) {
				this.keys.fields.get().get(i);
				retVal.setValue(retVal.concat(retVal.equals("") ? Clarion.newString("") : Clarion.newString(","),!this.keys.fields.get().ascend.equals(0) ? Clarion.newString("") : Clarion.newString("-"),this.keys.fields.get().fieldName.get()));
			}
		}
		return retVal.like();
	}
	public void kill()
	{
		Abfile.cleanUp(this);
		if (!(this.file==null)) {
			this.file.registerCallback(this.filecallbackinterface(),Constants.TRUE!=0);
		}
	}
	public ClarionNumber next()
	{
		return this.nextServer(Clarion.newNumber(1));
	}
	public ClarionNumber nextServer(ClarionNumber p0)
	{
		return nextServer(p0,Clarion.newNumber(0));
	}
	public ClarionNumber nextServer(ClarionNumber handleError,ClarionNumber prev)
	{
		if (this.useFile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		while (true) {
			this.info.atEOF.setValue(0);
			this.info.put();
			if (prev.boolValue()) {
				this.file.previous();
			}
			else {
				this.file.next();
			}
			{
				int case_1=CError.errorCode();
				boolean case_1_break=false;
				if (case_1==Constants.BADRECERR) {
					this.info.atEOF.setValue(1);
					this.info.put();
					return Clarion.newNumber(Level.NOTIFY);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.NOERROR) {
					return Clarion.newNumber(Level.BENIGN);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.ISHELDERR) {
					if (this.skipHeldRecords.boolValue()) {
						continue;
					}
					else {
						this.setError(Clarion.newNumber(Msg.RECORDHELD));
						if (handleError.boolValue()) {
							return this._throw();
						}
						else {
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break) {
					this.setError(Clarion.newNumber(Msg.ABORTREADING));
					if (handleError.boolValue()) {
						return this._throw();
					}
					else {
						return Clarion.newNumber(Level.FATAL);
					}
				}
			}
		}
	}
	public ClarionNumber open()
	{
		return this.openServer(Clarion.newNumber(1));
	}
	public ClarionNumber openFile(ClarionNumber handleError)
	{
		for (int loop_1=2;loop_1>0;loop_1--) {
			this.file.open(this.openMode.intValue());
			if (CError.errorCode()==Constants.NOACCESSERR) {
				this.file.send(ClarionString.staticConcat("Recover=",this.lockRecover));
				this.file.open(this.openMode.intValue());
			}
			{
				int case_1=CError.errorCode();
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1==Constants.NOERROR) {
					case_1_match=true;
				}
				if (case_1_match || case_1==Constants.ISOPENERR) {
					this.info.used.setValue(Constants.TRUE);
					this.info.atEOF.setValue(0);
					this.info.autoIncDone.setValue(0);
					this.info.put();
					return Clarion.newNumber(Level.BENIGN);
					// UNREACHABLE! :case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==Constants.RECORDLIMITERR) {
					if ((this.openMode.intValue() & 3)!=0) {
						this.openMode.setValue(this.openMode.intValue() & 0xf0);
						this._throw(Clarion.newNumber(Msg.RECORDLIMIT));
						continue;
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==Constants.NOACCESSERR) {
					if ((this.openMode.intValue() & 3)!=0) {
						this.openMode.setValue(this.openMode.intValue() & 0xf0);
						this._throw(Clarion.newNumber(Msg.ACCESSDENIED));
						continue;
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==Constants.NOFILEERR) {
					if (this.create.boolValue()) {
						this.file.create();
						if (CError.errorCode()!=0) {
							this.setError(Clarion.newNumber(Msg.CREATEFAILED));
							try {
								openFile_AnError(handleError);
							} catch (ClarionRoutineResult _crr) {
								return (ClarionNumber)_crr.getResult();
							}
						}
						else {
							continue;
						}
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==Constants.BADKEYERR) {
					this.setError(Clarion.newNumber(Msg.REBUILDKEY));
					if (handleError.boolValue()) {
						this._throw();
						this.file.build();
						if (CError.errorCode()!=0) {
							return this._throw(Clarion.newNumber(Msg.REBUILDFAILED));
						}
						else {
							continue;
						}
					}
					else {
						return Clarion.newNumber(Level.NOTIFY);
					}
					// UNREACHABLE! :case_1_break=true;
				}
			}
			if (1!=0) break;
		}
		try {
			openFile_HardError(handleError);
		} catch (ClarionRoutineResult _crr) {
			return (ClarionNumber)_crr.getResult();
		}
		return Clarion.newNumber();
	}
	public void openFile_HardError(ClarionNumber handleError) throws ClarionRoutineResult
	{
		this.setError(Clarion.newNumber(Msg.OPENFAILED));
		openFile_AnError(handleError);
	}
	public void openFile_AnError(ClarionNumber handleError) throws ClarionRoutineResult
	{
		if (handleError.boolValue()) {
			throw new ClarionRoutineResult(this._throw());
		}
		throw new ClarionRoutineResult(Clarion.newNumber(Level.NOTIFY));
	}
	public ClarionNumber openServer(ClarionNumber p0)
	{
		return openServer(p0,Clarion.newNumber(Constants.FALSE));
	}
	public ClarionNumber openServer(ClarionNumber handleError,ClarionNumber forceOpen)
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.setThread();
		Abfile.filesManager.noteOpen(this);
		this.bindFields();
		if (forceOpen.boolValue() || !this.lazyOpen.boolValue() && !this.info.opened.boolValue()) {
			rVal.setValue(this.openFile(handleError.like()));
			if (rVal.boolValue()) {
				return rVal.like();
			}
		}
		this.info.opened.increment(1);
		this.info.put();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionString position()
	{
		if (this.useFile().boolValue()) {
			return Clarion.newString("");
		}
		if (this.primaryKey.boolValue()) {
			this.keys.get(this.primaryKey);
			return this.keys.key.get().getPosition();
		}
		else {
			return this.file.getPosition();
		}
	}
	public ClarionNumber previous()
	{
		return this.nextServer(Clarion.newNumber(1),Clarion.newNumber(1));
	}
	public ClarionNumber primeAutoInc()
	{
		return this.primeAutoIncServer(Clarion.newNumber(1));
	}
	public ClarionNumber primeAutoIncServer(ClarionNumber handleError)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionString saveKeys=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionString newKeys=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionNumber saveRec=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionAny autoVal=Clarion.newAny();
		ClarionAny autoIncField=Clarion.newAny();
		ClarionNumber attempts=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		if (this.useFile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		if (!this.hasAutoInc.boolValue() || this.info.autoIncDone.boolValue()) {
			return Clarion.newNumber(Level.BENIGN);
		}
		while (true) {
			for (i.setValue(1);i.compareTo(this.keys.records())<=0;i.increment(1)) {
				this.keys.get(i);
				if (this.keys.autoInc.boolValue()) {
					saveRec.setValue(this.saveBuffer());
					this.file.setNoMemo();
					if (this.keys.fields.get().records()==1) {
						this.keys.fields.get().get(1);
						autoIncField.setReferenceValue(this.keys.fields.get().field);
						this.keys.key.get().setStart();
						if (this.keys.fields.get().ascend.boolValue()) {
							this.file.previous();
						}
						else {
							this.file.next();
						}
						{
							int case_1=CError.errorCode();
							boolean case_1_break=false;
							if (case_1==Constants.NOERROR) {
								autoVal.setValue(autoIncField.add(1));
								case_1_break=true;
							}
							if (!case_1_break && case_1==Constants.BADRECERR) {
								autoVal.setValue(1);
								case_1_break=true;
							}
							if (!case_1_break) {
								this.setError(Clarion.newNumber(Msg.ABORTREADING));
								if (handleError.boolValue()) {
									return this._throw();
								}
								else {
									return Clarion.newNumber(Level.NOTIFY);
								}
							}
						}
					}
					else {
						Abfile.concatGetComponents(this.keys.fields.get(),saveKeys,this.keys.autoInc.subtract(1).getNumber());
						this.keys.fields.get().get(this.keys.autoInc);
						autoIncField.setReferenceValue(this.keys.fields.get().field);
						autoIncField.clear(1);
						this.keys.key.get().set(this.keys.key.get());
						if (this.keys.fields.get().ascend.boolValue()) {
							this.file.previous();
						}
						else {
							this.file.next();
						}
						{
							int case_2=CError.errorCode();
							boolean case_2_break=false;
							if (case_2==Constants.NOERROR) {
								Abfile.concatGetComponents(this.keys.fields.get(),newKeys,this.keys.autoInc.subtract(1).getNumber());
								if (saveKeys.equals(newKeys)) {
									autoVal.setValue(autoIncField.add(1));
								}
								else {
									autoVal.setValue(1);
								}
								case_2_break=true;
							}
							if (!case_2_break && case_2==Constants.BADRECERR) {
								autoVal.setValue(1);
								case_2_break=true;
							}
							if (!case_2_break) {
								this.setError(Clarion.newNumber(Msg.ABORTREADING));
								if (handleError.boolValue()) {
									return this._throw();
								}
								else {
									return Clarion.newNumber(Level.NOTIFY);
								}
							}
						}
					}
					this.restoreBuffer(saveRec);
					autoIncField.setValue(autoVal);
				}
			}
			this.file.add();
			if (CError.errorCode()!=0) {
				attempts.increment(1);
				if (attempts.equals(3)) {
					this.setError(Clarion.newNumber(Msg.RETRYAUTOINC));
					if (handleError.boolValue()) {
						if (!this._throw().boolValue()) {
							attempts.setValue(0);
							continue;
						}
					}
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
			else {
				this.info.autoIncDone.setValue(1);
				this.info.put();
				return Clarion.newNumber(Level.BENIGN);
			}
		}
	}
	public void primeFields()
	{
	}
	public ClarionNumber primeRecord()
	{
		return primeRecord(Clarion.newNumber(0));
	}
	public ClarionNumber primeRecord(ClarionNumber sc)
	{
		ClarionNumber bufferHandle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber bh2=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber result=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.aliasedFile==null) {
			if (!sc.boolValue()) {
				this.file.clear();
			}
			this.primeFields();
			if (this.hasAutoInc.boolValue()) {
				this.info.autoIncDone.setValue(0);
				this.info.put();
				result.setValue(this.primeAutoInc());
			}
			else {
				result.setValue(Level.BENIGN);
			}
		}
		else {
			this.aliasedFile.open();
			bufferHandle.setValue(this.aliasedFile.saveFile());
			if (sc.boolValue()) {
				bh2.setValue(this.saveBuffer());
				this.aliasedFile.restoreBuffer(bh2,this);
			}
			result.setValue(this.aliasedFile.primeRecord(sc.like()));
			if (!result.boolValue()) {
				bh2.setValue(this.aliasedFile.saveFile());
				this.restoreFile(bh2,this.aliasedFile);
			}
			this.aliasedFile.restoreFile(bufferHandle);
			this.aliasedFile.close();
		}
		return result.like();
	}
	public void restoreBuffer(ClarionNumber p0)
	{
		restoreBuffer(p0,Clarion.newNumber(1));
	}
	public void restoreBuffer(ClarionNumber id,ClarionNumber doRestore)
	{
		this.restoreBuffer(id,this,doRestore.like());
	}
	public void restoreBuffer(ClarionNumber p0,Filemanager p1)
	{
		restoreBuffer(p0,p1,Clarion.newNumber(1));
	}
	public void restoreBuffer(ClarionNumber id,Filemanager frm,ClarionNumber doRestore)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber memos=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!id.boolValue() && !doRestore.boolValue()) {
			return;
		}
		frm.buffers.id.setValue(id);
		frm.buffers.get(frm.buffers.ORDER().ascend(frm.buffers.id));
		if (doRestore.boolValue()) {
			this.buffer.setValue(frm.buffers.buffer.get());
		}
		restoreBuffer_KillBuffer(frm);
		memos.setValue(this.file.getProperty(Prop.MEMOS));
		for (i.setValue(1);i.compareTo(memos)<=0;i.increment(1)) {
			frm.buffers.id.setValue(id.add(i));
			frm.buffers.get(frm.buffers.ORDER().ascend(frm.buffers.id));
			if (doRestore.boolValue()) {
				this.file.setClonedProperty(Prop.VALUE,i.negate(),frm.buffers.buffer.get());
			}
			restoreBuffer_KillBuffer(frm);
		}
		frm.buffers.id.setValue(id.add(memos).add(1));
		frm.buffers.get(frm.buffers.ORDER().ascend(frm.buffers.id));
		this.file.setNulls(frm.buffers.buffer.get());
		restoreBuffer_KillBuffer(frm);
		id.setValue(0);
	}
	public void restoreBuffer_KillBuffer(Filemanager frm)
	{
		//frm.buffers.buffer.get();
		frm.buffers.delete();
	}
	public void restoreFile(ClarionNumber p0)
	{
		restoreFile(p0,Clarion.newNumber(1));
	}
	public void restoreFile(ClarionNumber id,ClarionNumber doRestore)
	{
		this.restoreFile(id,this,doRestore.like());
	}
	public void restoreFile(ClarionNumber p0,Filemanager p1)
	{
		restoreFile(p0,p1,Clarion.newNumber(1));
	}
	public void restoreFile(ClarionNumber id,Filemanager frm,ClarionNumber doRestore)
	{
		ClarionKey k=null;
		if (!this.useFile().boolValue()) {
			frm.saved.id.setValue(id);
			frm.saved.get(frm.saved.ORDER().ascend(frm.saved.id));
			if (doRestore.boolValue()) {
				if (this.aliasedFile==null) {
					this.file.restoreState(frm.saved.state.intValue());
				}
				else {
					if (this.primaryKey.boolValue()) {
						this.keys.get(frm.primaryKey);
						this.keys.key.get().reget(frm.saved.pos);
					}
					else {
						this.file.reget(frm.saved.pos);
					}
					this.file.next();
				}
			}
			this.restoreBuffer(frm.saved.buffer,frm,doRestore.like());
			if (doRestore.boolValue()) {
				this.info.autoIncDone.setValue(frm.saved.autoIncDone);
				this.info.put();
			}
			this.file.freeState(frm.saved.state.intValue());
			frm.saved.delete();
			id.setValue(0);
		}
	}
	public ClarionNumber saveBuffer()
	{
		ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber memos=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		id.setValue(this.buffers.records());
		if (id.boolValue()) {
			this.buffers.get(id);
			id.setValue(this.buffers.id.add(1));
		}
		else {
			id.setValue(1);
		}
		this.buffers.id.setValue(id);
		this.buffers.buffer.set(Abfile.dupString(this.buffer.getString()));
		this.buffers.add(this.buffers.ORDER().ascend(this.buffers.id));
		memos.setValue(this.file.getProperty(Prop.MEMOS));
		for (i.setValue(1);i.compareTo(memos)<=0;i.increment(1)) {
			this.buffers.id.setValue(id.add(i));
			this.buffers.buffer.set(Abfile.dupString(this.file.getProperty(Prop.VALUE,i.negate()).getString()));
			this.buffers.add(this.buffers.ORDER().ascend(this.buffers.id));
		}
		this.buffers.id.setValue(id.add(memos).add(1));
		this.buffers.buffer.set(Abfile.dupString(this.file.getNulls()));
		this.buffers.add(this.buffers.ORDER().ascend(this.buffers.id));
		return id.like();
	}
	public ClarionNumber saveFile()
	{
		ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		id.setValue(this.saved.records());
		if (id.boolValue()) {
			this.saved.get(id);
			id.setValue(this.saved.id.add(1));
		}
		else {
			id.setValue(1);
		}
		this.saved.id.setValue(id);
		this.saved.buffer.setValue(this.saveBuffer());
		this.saved.state.setValue(this.file.getState());
		if (this.primaryKey.boolValue()) {
			this.keys.get(this.primaryKey);
			this.saved.pos.setValue(this.keys.key.get().getPosition());
		}
		else {
			this.saved.pos.setValue(this.file.getPosition());
		}
		this.saved.autoIncDone.setValue(this.info.autoIncDone);
		this.saved.add();
		return id.like();
	}
	public void setError(ClarionNumber err)
	{
		this.errors.setErrors();
		this.info.lastError.setValue(err);
		this.info.put();
	}
	public void setKey(ClarionKey k)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.keys.records())<=0;i.increment(1)) {
			this.keys.get(i);
			if (this.keys.key.get()==k) break;
		}
	}
	public void setName(ClarionString st)
	{
		this.fileName.setValue(st);
	}
	public void setThread()
	{
		ClarionNumber thisThread=Clarion.newNumber(1).setEncoding(ClarionNumber.SIGNED);
		if (this.file.getProperty(Prop.THREAD).boolValue()) {
			thisThread.setValue(CRun.getThreadID());
		}
		this.info.id.setValue(thisThread);
		this.info.get(this.info.ORDER().ascend(this.info.id));
		if (CError.errorCode()!=0) {
			this.info.clear();
			this.info.id.setValue(thisThread);
			this.info.add(this.info.ORDER().ascend(this.info.id));
		}
		this.errors.setFile(this.getName());
	}
	public ClarionNumber _throw(ClarionNumber errNum)
	{
		this.setError(errNum.like());
		return this._throw();
	}
	public ClarionNumber _throw()
	{
		return this.errors.takeError(this.info.lastError.like());
	}
	public ClarionNumber throwMessage(ClarionNumber errNum,ClarionString me)
	{
		return this.errors.throwMessage(errNum.like(),me.like());
	}
	public ClarionNumber tryFetch(ClarionKey key)
	{
		if (this.useFile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		this.file.get(key);
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		else {
			return Clarion.newNumber(Level.BENIGN);
		}
	}
	public ClarionNumber tryInsert()
	{
		return this.insertServer(Clarion.newNumber(0));
	}
	public ClarionNumber tryNext()
	{
		return this.nextServer(Clarion.newNumber(0));
	}
	public ClarionNumber tryOpen()
	{
		return this.openServer(Clarion.newNumber(0));
	}
	public ClarionNumber tryPrevious()
	{
		return this.nextServer(Clarion.newNumber(0),Clarion.newNumber(1));
	}
	public ClarionNumber tryPrimeAutoInc()
	{
		return this.primeAutoIncServer(Clarion.newNumber(0));
	}
	public ClarionNumber tryReget(ClarionString p)
	{
		if (this.useFile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		if (this.primaryKey.boolValue()) {
			this.keys.get(this.primaryKey);
			this.keys.key.get().reget(p);
		}
		else {
			this.file.reget(p);
		}
		return (CError.errorCode()==0 ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.NOTIFY)).getNumber();
	}
	public ClarionNumber tryUpdate()
	{
		return this.updateServer(Clarion.newNumber(0));
	}
	public ClarionNumber update()
	{
		return this.updateServer(Clarion.newNumber(1));
	}
	public ClarionNumber updateServer(ClarionNumber handleError)
	{
		ClarionString hold=Clarion.newString(1024);
		if (this.useFile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		if (this.validateRecord().boolValue()) {
			return Clarion.newNumber(Level.USER);
		}
		hold.setValue(this.position());
		this.file.put();
		{
			int case_1=CError.errorCode();
			boolean case_1_break=false;
			if (case_1==Constants.NOERROR) {
				return Clarion.newNumber(Level.BENIGN);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1==Constants.RECORDCHANGEDERR) {
				this.setError((handleError.equals(2) ? Clarion.newNumber(Msg.CONCURRENCYFAILEDFROMFORM) : Clarion.newNumber(Msg.CONCURRENCYFAILED)).getNumber());
				if (handleError.boolValue()) {
					this._throw();
				}
				this.file.watch();
				this.tryReget(hold.like());
				case_1_break=true;
			}
			if (!case_1_break) {
				this.setError(Clarion.newNumber(Msg.PUTFAILED));
				if (handleError.boolValue()) {
					return this._throw();
				}
			}
		}
		return Clarion.newNumber(Level.NOTIFY);
	}
	public ClarionNumber useFile()
	{
		return useFile(Clarion.newNumber(Usetype.USES));
	}
	public ClarionNumber useFile(ClarionNumber usage)
	{
		ClarionNumber i=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveID=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.inUseFile.setValue(Constants.TRUE);
		this.setThread();
		if (!usage.equals(Usetype.BENIGN)) {
			Abfile.filesManager.noteUsage(this,usage.like());
		}
		if (this.lazyOpen.boolValue()) {
			if (!this.info.used.boolValue()) {
				if (this.info.opened.compareTo(1)<0) {
					this.inUseFile.setValue(Constants.FALSE);
					return this._throw(Clarion.newNumber(Msg.USECLOSEDFILE));
				}
				saveID.setValue(this.saveBuffer());
				i.setValue(this.openFile(Clarion.newNumber(1)));
				this.restoreBuffer(saveID,Clarion.newNumber(1));
			}
		}
		this.inUseFile.setValue(Constants.FALSE);
		return i.like();
	}
	public ClarionNumber validateField(ClarionNumber field)
	{
		return this.validateFieldServer(field.like(),Clarion.newNumber(1));
	}
	public ClarionNumber tryValidateField(ClarionNumber field)
	{
		return this.validateFieldServer(field.like(),Clarion.newNumber(0));
	}
	public ClarionNumber validateFieldServer(ClarionNumber field,ClarionNumber handleErrors)
	{
		ClarionNumber bufferHandle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber rVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (!(this.aliasedFile==null)) {
			bufferHandle.setValue(this.aliasedFile.saveBuffer());
			this.aliasedFile.buffer.setValue(this.buffer.getString());
			rVal.setValue(this.aliasedFile.validateField(field.like()));
			this.aliasedFile.restoreBuffer(bufferHandle);
		}
		return rVal.like();
	}
	public ClarionNumber validateFields(ClarionNumber p0,ClarionNumber p1)
	{
		return validateFields(p0,p1,(ClarionNumber)null);
	}
	public ClarionNumber validateFields(ClarionNumber low,ClarionNumber high,ClarionNumber u)
	{
		ClarionNumber bufferHandle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber retVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (this.aliasedFile==null) {
			for (i.setValue(low);i.compareTo(high)<=0;i.increment(1)) {
				retVal.setValue(this.validateField(i.like()));
				if (retVal.boolValue()) {
					if (!(u==null)) {
						u.setValue(i);
					}
					break;
				}
			}
		}
		else {
			bufferHandle.setValue(this.aliasedFile.saveBuffer());
			this.aliasedFile.buffer.setValue(this.buffer.getString());
			retVal.setValue(this.aliasedFile.validateFields(low.like(),high.like(),u));
			this.aliasedFile.restoreBuffer(bufferHandle);
		}
		return retVal.like();
	}
	public ClarionNumber validateRecord()
	{
		return validateRecord((ClarionNumber)null);
	}
	public ClarionNumber validateRecord(ClarionNumber u)
	{
		ClarionNumber bufferHandle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber result=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.aliasedFile==null) {
			result.setValue(this.validateFields(Clarion.newNumber(1),this.file.getProperty(Prop.FIELDS).getNumber(),u));
		}
		else {
			bufferHandle.setValue(this.aliasedFile.saveBuffer());
			this.aliasedFile.buffer.setValue(this.buffer.getString());
			result.setValue(this.aliasedFile.validateRecord(u));
			this.aliasedFile.restoreBuffer(bufferHandle);
		}
		return result.like();
	}
	public ClarionNumber deleteRecord()
	{
		return deleteRecord(Clarion.newNumber(1));
	}
	public ClarionNumber deleteRecord(ClarionNumber query)
	{
		this.file.delete();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber deleted()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
}
