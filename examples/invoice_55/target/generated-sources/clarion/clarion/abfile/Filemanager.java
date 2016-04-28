package clarion.abfile;

import clarion.Bufferqueue;
import clarion.Filecallbackinterface;
import clarion.Params;
import clarion.aberror.Errorclass;
import clarion.abfile.Abfile;
import clarion.abfile.Fieldslist;
import clarion.abfile.Filekeyqueue;
import clarion.abfile.Filethreadqueue;
import clarion.abfile.Keyfieldqueue;
import clarion.abfile.Relationmanager;
import clarion.abfile.Savequeue;
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

@SuppressWarnings("all")
public class Filemanager
{
	public Filemanager aliasedfile=null;
	public ClarionGroup buffer=null;
	public Bufferqueue buffers=null;
	public ClarionNumber create=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Errorclass errors=null;
	public Fieldslist fields=null;
	public Object fieldtypes=null;
	public ClarionFile file=null;
	public ClarionAny filename=Clarion.newAny();
	public ClarionString filenamevalue=Clarion.newString(File.MAXFILENAME);
	public ClarionNumber hasautoinc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber inusefile=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber incallback=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber inclose=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber inrestore=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Filethreadqueue info=null;
	public Filekeyqueue keys=null;
	public ClarionNumber lazyopen=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber lockrecover=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber openmode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber primarykey=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Savequeue saved=null;
	public ClarionNumber skipheldrecords=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber cleanedup=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	private static class _Filecallbackinterface_Impl extends Filecallbackinterface
	{
		private Filemanager _owner;
		public _Filecallbackinterface_Impl(Filemanager _owner)
		{
			this._owner=_owner;
		}
		public ClarionNumber functioncalled(ClarionNumber opcode,Params parameters,ClarionString errcode,ClarionString errmsg)
		{
			if (opcode.equals(Driverop.CLOSE) && _owner.inrestore.boolValue() && _owner.info.opened.boolValue()) {
				_owner.info.opened.setValue(0);
				_owner.info.used.setValue(Constants.FALSE);
				_owner.info.put();
				_owner.close();
			}
			if (opcode.equals(Driverop.DESTROY)) {
				_owner.incallback.increment(1);
				if (!parameters.index.boolValue()) {
					Abfile.cleanup(_owner);
				}
				else if (_owner.info.used.boolValue()) {
				}
				_owner.incallback.decrement(1);
			}
			return Clarion.newNumber(Constants.TRUE);
		}
		public ClarionNumber functiondone(ClarionNumber opcode,Params parameters,ClarionString errcode,ClarionString errmsg)
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
		aliasedfile=null;
		buffer=null;
		buffers=null;
		create=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		errors=null;
		fields=null;
		fieldtypes=null;
		file=null;
		filename=Clarion.newAny();
		filenamevalue=Clarion.newString(File.MAXFILENAME);
		hasautoinc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		inusefile=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		incallback=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		inclose=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		inrestore=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		info=null;
		keys=null;
		lazyopen=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lockrecover=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		openmode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		primarykey=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		saved=null;
		skipheldrecords=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		cleanedup=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void destruct()
	{
		this.kill();
	}
	public ClarionNumber addfield(ClarionString p0,ClarionObject p1,ClarionString p2)
	{
		return addfield(p0,p1,p2,(ClarionString)null);
	}
	public ClarionNumber addfield(ClarionString tag,ClarionObject fld,ClarionString ftype,ClarionString fpicture)
	{
		if (this.findfield(tag.like()).boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		this.fields.clear();
		this.fields.tag.setValue(tag.upper());
		this.fields.fld.setReferenceValue(fld);
		this.fields.ftype.setValue(ftype);
		this.fields.fpicture.setValue(Clarion.newBool(fpicture==null).equals(Constants.TRUE) ? Clarion.newString("") : fpicture);
		this.fields.add(this.fields.ORDER().ascend(this.fields.tag));
		return (CError.errorCode()==0 ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.NOTIFY)).getNumber();
	}
	public void addkey(ClarionKey p0,ClarionString p1)
	{
		addkey(p0,p1,Clarion.newNumber(0));
	}
	public void addkey(ClarionKey k,ClarionString desc,ClarionNumber autoinc)
	{
		ClarionNumber cf=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionString fb=Clarion.newString(1000).setEncoding(ClarionString.CSTRING);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.keys.key.set(k);
		this.keys.description.setValue(desc);
		this.keys.fields.set(new Keyfieldqueue());
		this.keys.autoinc.setValue(autoinc);
		if (autoinc.boolValue()) {
			this.hasautoinc.setValue(1);
		}
		this.keys.dups.setValue(k.getProperty(Prop.DUP));
		this.keys.nocase.setValue(k.getProperty(Prop.NOCASE));
		this.keys.add();
		if (k.getProperty(Prop.PRIMARY).boolValue()) {
			this.primarykey.setValue(this.keys.records());
		}
		final ClarionObject loop_1=k.getProperty(Prop.COMPONENTS);for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.keys.fields.get().clear();
			this.keys.fields.get().ascend.setValue(k.getProperty(Prop.ASCENDING,i));
			cf.setValue(k.getProperty(Prop.FIELD,i));
			this.keys.fields.get().field.setReferenceValue(this.buffer.what(cf.intValue()));
			fb.setValue(this.file.getProperty(Prop.LABEL,cf));
			this.keys.fields.get().fieldname.set(Abfile.dupstring((this.keys.nocase.boolValue() && (this.keys.fields.get().field.getValue()) instanceof ClarionString ? Clarion.newString(ClarionString.staticConcat("UPPER(",fb,")")) : fb).getString()));
			this.keys.fields.get().add();
		}
	}
	public void bindfields()
	{
		CExpression.bind(this.buffer);
	}
	public ClarionNumber cancelautoinc()
	{
		return cancelautoinc((Relationmanager)null);
	}
	public ClarionNumber cancelautoinc(Relationmanager r)
	{
		ClarionNumber retval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (!this.usefile().boolValue()) {
			if (this.hasautoinc.boolValue() && this.info.autoincdone.boolValue()) {
				if (r==null) {
					this.file.delete();
				}
				else {
					retval.setValue(r.delete(Clarion.newNumber(0)));
				}
				if (!retval.boolValue()) {
					this.info.autoincdone.setValue(0);
					this.info.put();
				}
			}
		}
		return retval.like();
	}
	public void clearkey(ClarionKey p0,ClarionNumber p1,ClarionNumber p2)
	{
		clearkey(p0,p1,p2,Clarion.newNumber(0));
	}
	public void clearkey(ClarionKey p0,ClarionNumber p1)
	{
		clearkey(p0,p1,Clarion.newNumber(22));
	}
	public void clearkey(ClarionKey p0)
	{
		clearkey(p0,Clarion.newNumber(1));
	}
	public void clearkey(ClarionKey k,ClarionNumber lowcomp,ClarionNumber highcomp,ClarionNumber high)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.setkey(k);
		final ClarionNumber loop_1=highcomp.like();for (i.setValue(lowcomp);i.compareTo(loop_1)<=0;i.increment(1)) {
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
		this.inclose.increment(1);
		this.setthread();
		Abfile.filesmanager.noteclose(this);
		if (this.info.opened.boolValue()) {
			this.info.opened.decrement(1);
			if (!this.info.opened.boolValue()) {
				this.file.close();
				this.info.used.setValue(Constants.FALSE);
			}
			this.info.put();
		}
		this.inclose.decrement(1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber equalbuffer(ClarionNumber id)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		if (this.usefile().boolValue()) {
			return Clarion.newNumber(0);
		}
		this.buffers.id.setValue(id);
		this.buffers.get(this.buffers.ORDER().ascend(this.buffers.id));
		if (!this.buffer.getString().equals(this.buffers.buffer.get())) {
			return Clarion.newNumber(0);
		}
		final ClarionObject loop_1=this.file.getProperty(Prop.MEMOS);for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
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
		ClarionNumber returncode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returncode.setValue(this.tryfetch(key));
		if (returncode.boolValue()) {
			this.file.clear();
		}
		return returncode.like();
	}
	public ClarionNumber findfield(ClarionString tag)
	{
		this.fields.tag.setValue(tag.upper());
		this.fields.get(this.fields.ORDER().ascend(this.fields.tag));
		return (CError.errorCode()==0 ? Clarion.newNumber(Constants.TRUE) : Clarion.newNumber(Constants.FALSE)).getNumber();
	}
	public ClarionNumber getcomponents(ClarionKey k)
	{
		this.setkey(k);
		return Clarion.newNumber(this.keys.fields.get().records());
	}
	public ClarionNumber geteof()
	{
		this.setthread();
		return this.info.ateof.like();
	}
	public ClarionNumber geterror()
	{
		this.setthread();
		return this.info.lasterror.like();
	}
	public ClarionObject getfield(ClarionString tag)
	{
		ClarionAny rval=Clarion.newAny();
		if (this.findfield(tag.like()).boolValue()) {
			rval.setReferenceValue(this.fields.fld);
		}
		else {
			rval.setReferenceValue(null);
		}
		return rval;
	}
	public ClarionObject getfield(ClarionKey k,ClarionNumber b)
	{
		this.setkey(k);
		this.keys.fields.get().get(b);
		return this.keys.fields.get().field;
	}
	public ClarionNumber getfield(ClarionNumber idx,ClarionString tag,ClarionObject fld)
	{
		ClarionNumber rval=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
		if (CRun.inRange(idx,Clarion.newNumber(1),Clarion.newNumber(this.fields.records()))) {
			this.fields.get(idx);
			if (!(CError.errorCode()!=0)) {
				tag.setValue(this.fields.tag);
				fld.setValue(this.fields.fld);
				rval.setValue(Level.BENIGN);
			}
		}
		return rval.like();
	}
	public ClarionString getfieldtype(ClarionString tag)
	{
		return (this.findfield(tag.like()).equals(Constants.TRUE) ? this.fields.ftype : Clarion.newString("")).getString();
	}
	public ClarionNumber getfields()
	{
		return Clarion.newNumber(this.fields.records());
	}
	public ClarionString getfieldname(ClarionKey k,ClarionNumber b)
	{
		this.setkey(k);
		this.keys.fields.get().get(b);
		return this.keys.fields.get().fieldname.get().like();
	}
	public ClarionString getfieldname(ClarionObject fld)
	{
		ClarionNumber fnum=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		fnum.setValue(this.buffer.where(fld));
		return this.buffer.who(fnum.intValue());
	}
	public ClarionString getfieldpicture(ClarionString tag)
	{
		return (this.findfield(tag.like()).equals(Constants.TRUE) ? this.fields.fpicture : Clarion.newString("")).getString();
	}
	public ClarionString getname()
	{
		if (this.filename.getValue()==null) {
			return this.filenamevalue.like();
		}
		else {
			return this.filename.getString();
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
		this.skipheldrecords.setValue(0);
		this.openmode.setValue(0x42);
		this.create.setValue(1);
		this.lockrecover.setValue(10);
		this.primarykey.setValue(0);
		this.lazyopen.setValue(Constants.TRUE);
		this.filenamevalue.setValue(this.file.getProperty(Prop.NAME));
		Abfile.filesmanager.addfilemapping(this);
		this.cleanedup.setValue(Constants.FALSE);
		file.deregisterCallback(this.filecallbackinterface());
	}
	public ClarionNumber insert()
	{
		return this.insertserver(Clarion.newNumber(1));
	}
	public ClarionNumber insertserver(ClarionNumber handleerror)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		if (this.usefile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		if (this.validaterecord().boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		if (this.hasautoinc.boolValue()) {
			if (this.info.autoincdone.boolValue()) {
				this.file.put();
			}
			else {
				if (handleerror.boolValue() && this.primeautoinc().boolValue() || !handleerror.boolValue() && this.tryprimeautoinc().boolValue()) {
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
				this.info.autoincdone.setValue(0);
				this.info.put();
				return Clarion.newNumber(Level.BENIGN);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1==Constants.DUPKEYERR) {
				if (handleerror.boolValue()) {
					if (!this.hasautoinc.boolValue()) {
						this.file.get(Clarion.newString(String.valueOf(0)),null);
					}
					final int loop_1=this.keys.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
						this.keys.get(i);
						if (this.keys.key.get().duplicateCheck()) {
							this.throwmessage(Clarion.newNumber(Msg.DUPLICATEKEY),this.keys.description.like());
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
				}
				else {
					this.seterror(Clarion.newNumber(Msg.DUPLICATEKEY));
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				this.seterror(Clarion.newNumber(Msg.ADDFAILED));
				if (handleerror.boolValue()) {
					return this._throw();
				}
			}
		}
		return Clarion.newNumber(Level.NOTIFY);
	}
	public ClarionString keytoorder(ClarionKey k,ClarionNumber b)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString retval=Clarion.newString(512).setEncoding(ClarionString.CSTRING);
		if (!(k==null)) {
			if (!b.boolValue()) {
				b.setValue(1);
			}
			this.setkey(k);
			final int loop_1=this.keys.fields.get().records();for (i.setValue(b);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.keys.fields.get().get(i);
				retval.setValue(retval.concat(retval.equals("") ? Clarion.newString("") : Clarion.newString(","),!this.keys.fields.get().ascend.equals(0) ? Clarion.newString("") : Clarion.newString("-"),this.keys.fields.get().fieldname.get()));
			}
		}
		return retval.like();
	}
	public void kill()
	{
		Abfile.cleanup(this);
		if (!(this.file==null)) {
			this.file.registerCallback(this.filecallbackinterface(),Constants.TRUE!=0);
		}
	}
	public ClarionNumber next()
	{
		return this.nextserver(Clarion.newNumber(1));
	}
	public ClarionNumber nextserver(ClarionNumber p0)
	{
		return nextserver(p0,Clarion.newNumber(0));
	}
	public ClarionNumber nextserver(ClarionNumber handleerror,ClarionNumber prev)
	{
		if (this.usefile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		while (true) {
			this.info.ateof.setValue(0);
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
					this.info.ateof.setValue(1);
					this.info.put();
					return Clarion.newNumber(Level.NOTIFY);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.NOERROR) {
					return Clarion.newNumber(Level.BENIGN);
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.ISHELDERR) {
					if (this.skipheldrecords.boolValue()) {
						continue;
					}
					else {
						this.seterror(Clarion.newNumber(Msg.RECORDHELD));
						if (handleerror.boolValue()) {
							return this._throw();
						}
						else {
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break) {
					this.seterror(Clarion.newNumber(Msg.ABORTREADING));
					if (handleerror.boolValue()) {
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
		return this.openserver(Clarion.newNumber(1));
	}
	public ClarionNumber openfile(ClarionNumber handleerror)
	{
		for (int loop_1=2;loop_1>0;loop_1--) {
			this.file.open(this.openmode.intValue());
			if (CError.errorCode()==Constants.NOACCESSERR) {
				this.file.send(ClarionString.staticConcat("Recover=",this.lockrecover));
				this.file.open(this.openmode.intValue());
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
					this.info.ateof.setValue(0);
					this.info.autoincdone.setValue(0);
					this.info.put();
					return Clarion.newNumber(Level.BENIGN);
					// UNREACHABLE! :case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==Constants.RECORDLIMITERR) {
					if ((this.openmode.intValue() & 3)!=0) {
						this.openmode.setValue(this.openmode.intValue() & 0xf0);
						this._throw(Clarion.newNumber(Msg.RECORDLIMIT));
						continue;
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==Constants.NOACCESSERR) {
					if ((this.openmode.intValue() & 3)!=0) {
						this.openmode.setValue(this.openmode.intValue() & 0xf0);
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
							this.seterror(Clarion.newNumber(Msg.CREATEFAILED));
							try {
								openfile_anerror(handleerror);
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
					this.seterror(Clarion.newNumber(Msg.REBUILDKEY));
					if (handleerror.boolValue()) {
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
			openfile_harderror(handleerror);
		} catch (ClarionRoutineResult _crr) {
			return (ClarionNumber)_crr.getResult();
		}
		return Clarion.newNumber();
	}
	public void openfile_harderror(ClarionNumber handleerror) throws ClarionRoutineResult
	{
		this.seterror(Clarion.newNumber(Msg.OPENFAILED));
		openfile_anerror(handleerror);
	}
	public void openfile_anerror(ClarionNumber handleerror) throws ClarionRoutineResult
	{
		if (handleerror.boolValue()) {
			throw new ClarionRoutineResult(this._throw());
		}
		throw new ClarionRoutineResult(Clarion.newNumber(Level.NOTIFY));
	}
	public ClarionNumber openserver(ClarionNumber p0)
	{
		return openserver(p0,Clarion.newNumber(Constants.FALSE));
	}
	public ClarionNumber openserver(ClarionNumber handleerror,ClarionNumber forceopen)
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.setthread();
		Abfile.filesmanager.noteopen(this);
		this.bindfields();
		if (forceopen.boolValue() || !this.lazyopen.boolValue() && !this.info.opened.boolValue()) {
			rval.setValue(this.openfile(handleerror.like()));
			if (rval.boolValue()) {
				return rval.like();
			}
		}
		this.info.opened.increment(1);
		this.info.put();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionString position()
	{
		if (this.usefile().boolValue()) {
			return Clarion.newString("");
		}
		if (this.primarykey.boolValue()) {
			this.keys.get(this.primarykey);
			return this.keys.key.get().getPosition();
		}
		else {
			return this.file.getPosition();
		}
	}
	public ClarionNumber previous()
	{
		return this.nextserver(Clarion.newNumber(1),Clarion.newNumber(1));
	}
	public ClarionNumber primeautoinc()
	{
		return this.primeautoincserver(Clarion.newNumber(1));
	}
	public ClarionNumber primeautoincserver(ClarionNumber handleerror)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionString savekeys=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionString newkeys=Clarion.newString(2000).setEncoding(ClarionString.CSTRING);
		ClarionNumber saverec=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionAny autoval=Clarion.newAny();
		ClarionAny autoincfield=Clarion.newAny();
		ClarionNumber attempts=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		if (this.usefile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		if (!this.hasautoinc.boolValue() || this.info.autoincdone.boolValue()) {
			return Clarion.newNumber(Level.BENIGN);
		}
		while (true) {
			final int loop_1=this.keys.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.keys.get(i);
				if (this.keys.autoinc.boolValue()) {
					saverec.setValue(this.savebuffer());
					this.file.setNoMemo();
					if (this.keys.fields.get().records()==1) {
						this.keys.fields.get().get(1);
						autoincfield.setReferenceValue(this.keys.fields.get().field);
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
								autoval.setValue(autoincfield.add(1));
								case_1_break=true;
							}
							if (!case_1_break && case_1==Constants.BADRECERR) {
								autoval.setValue(1);
								case_1_break=true;
							}
							if (!case_1_break) {
								this.seterror(Clarion.newNumber(Msg.ABORTREADING));
								if (handleerror.boolValue()) {
									return this._throw();
								}
								else {
									return Clarion.newNumber(Level.NOTIFY);
								}
							}
						}
					}
					else {
						Abfile.concatgetcomponents(this.keys.fields.get(),savekeys,this.keys.autoinc.subtract(1).getNumber());
						this.keys.fields.get().get(this.keys.autoinc);
						autoincfield.setReferenceValue(this.keys.fields.get().field);
						autoincfield.clear(1);
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
								Abfile.concatgetcomponents(this.keys.fields.get(),newkeys,this.keys.autoinc.subtract(1).getNumber());
								if (savekeys.equals(newkeys)) {
									autoval.setValue(autoincfield.add(1));
								}
								else {
									autoval.setValue(1);
								}
								case_2_break=true;
							}
							if (!case_2_break && case_2==Constants.BADRECERR) {
								autoval.setValue(1);
								case_2_break=true;
							}
							if (!case_2_break) {
								this.seterror(Clarion.newNumber(Msg.ABORTREADING));
								if (handleerror.boolValue()) {
									return this._throw();
								}
								else {
									return Clarion.newNumber(Level.NOTIFY);
								}
							}
						}
					}
					this.restorebuffer(saverec);
					autoincfield.setValue(autoval);
				}
			}
			this.file.add();
			if (CError.errorCode()!=0) {
				attempts.increment(1);
				if (attempts.equals(3)) {
					this.seterror(Clarion.newNumber(Msg.RETRYAUTOINC));
					if (handleerror.boolValue()) {
						if (!this._throw().boolValue()) {
							attempts.setValue(0);
							continue;
						}
					}
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
			else {
				this.info.autoincdone.setValue(1);
				this.info.put();
				return Clarion.newNumber(Level.BENIGN);
			}
		}
	}
	public void primefields()
	{
	}
	public ClarionNumber primerecord()
	{
		return primerecord(Clarion.newNumber(0));
	}
	public ClarionNumber primerecord(ClarionNumber sc)
	{
		ClarionNumber bufferhandle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber bh2=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber result=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.aliasedfile==null) {
			if (!sc.boolValue()) {
				this.file.clear();
			}
			this.primefields();
			if (this.hasautoinc.boolValue()) {
				this.info.autoincdone.setValue(0);
				this.info.put();
				result.setValue(this.primeautoinc());
			}
			else {
				result.setValue(Level.BENIGN);
			}
		}
		else {
			this.aliasedfile.open();
			bufferhandle.setValue(this.aliasedfile.savefile());
			if (sc.boolValue()) {
				bh2.setValue(this.savebuffer());
				this.aliasedfile.restorebuffer(bh2,this);
			}
			result.setValue(this.aliasedfile.primerecord(sc.like()));
			if (!result.boolValue()) {
				bh2.setValue(this.aliasedfile.savefile());
				this.restorefile(bh2,this.aliasedfile);
			}
			this.aliasedfile.restorefile(bufferhandle);
			this.aliasedfile.close();
		}
		return result.like();
	}
	public void restorebuffer(ClarionNumber p0)
	{
		restorebuffer(p0,Clarion.newNumber(1));
	}
	public void restorebuffer(ClarionNumber id,ClarionNumber dorestore)
	{
		this.restorebuffer(id,this,dorestore.like());
	}
	public void restorebuffer(ClarionNumber p0,Filemanager p1)
	{
		restorebuffer(p0,p1,Clarion.newNumber(1));
	}
	public void restorebuffer(ClarionNumber id,Filemanager frm,ClarionNumber dorestore)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber memos=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!id.boolValue() && !dorestore.boolValue()) {
			return;
		}
		frm.buffers.id.setValue(id);
		frm.buffers.get(frm.buffers.ORDER().ascend(frm.buffers.id));
		if (dorestore.boolValue()) {
			this.buffer.setValue(frm.buffers.buffer.get());
		}
		restorebuffer_killbuffer(frm);
		memos.setValue(this.file.getProperty(Prop.MEMOS));
		final ClarionNumber loop_1=memos.like();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			frm.buffers.id.setValue(id.add(i));
			frm.buffers.get(frm.buffers.ORDER().ascend(frm.buffers.id));
			if (dorestore.boolValue()) {
				this.file.setClonedProperty(Prop.VALUE,i.negate(),frm.buffers.buffer.get());
			}
			restorebuffer_killbuffer(frm);
		}
		frm.buffers.id.setValue(id.add(memos).add(1));
		frm.buffers.get(frm.buffers.ORDER().ascend(frm.buffers.id));
		this.file.setNulls(frm.buffers.buffer.get());
		restorebuffer_killbuffer(frm);
		id.setValue(0);
	}
	public void restorebuffer_killbuffer(Filemanager frm)
	{
		//frm.buffers.buffer.get();
		frm.buffers.delete();
	}
	public void restorefile(ClarionNumber p0)
	{
		restorefile(p0,Clarion.newNumber(1));
	}
	public void restorefile(ClarionNumber id,ClarionNumber dorestore)
	{
		this.restorefile(id,this,dorestore.like());
	}
	public void restorefile(ClarionNumber p0,Filemanager p1)
	{
		restorefile(p0,p1,Clarion.newNumber(1));
	}
	public void restorefile(ClarionNumber id,Filemanager frm,ClarionNumber dorestore)
	{
		ClarionKey k=null;
		if (!this.usefile().boolValue()) {
			frm.saved.id.setValue(id);
			frm.saved.get(frm.saved.ORDER().ascend(frm.saved.id));
			if (dorestore.boolValue()) {
				if (this.aliasedfile==null) {
					this.file.restoreState(frm.saved.state.intValue());
				}
				else {
					if (this.primarykey.boolValue()) {
						this.keys.get(frm.primarykey);
						this.keys.key.get().reget(frm.saved.pos);
					}
					else {
						this.file.reget(frm.saved.pos);
					}
					this.file.next();
				}
			}
			this.restorebuffer(frm.saved.buffer,frm,dorestore.like());
			if (dorestore.boolValue()) {
				this.info.autoincdone.setValue(frm.saved.autoincdone);
				this.info.put();
			}
			this.file.freeState(frm.saved.state.intValue());
			frm.saved.delete();
			id.setValue(0);
		}
	}
	public ClarionNumber savebuffer()
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
		this.buffers.buffer.set(Abfile.dupstring(this.buffer.getString()));
		this.buffers.add(this.buffers.ORDER().ascend(this.buffers.id));
		memos.setValue(this.file.getProperty(Prop.MEMOS));
		final ClarionNumber loop_1=memos.like();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.buffers.id.setValue(id.add(i));
			this.buffers.buffer.set(Abfile.dupstring(this.file.getProperty(Prop.VALUE,i.negate()).getString()));
			this.buffers.add(this.buffers.ORDER().ascend(this.buffers.id));
		}
		this.buffers.id.setValue(id.add(memos).add(1));
		this.buffers.buffer.set(Abfile.dupstring(this.file.getNulls()));
		this.buffers.add(this.buffers.ORDER().ascend(this.buffers.id));
		return id.like();
	}
	public ClarionNumber savefile()
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
		this.saved.buffer.setValue(this.savebuffer());
		this.saved.state.setValue(this.file.getState());
		if (this.primarykey.boolValue()) {
			this.keys.get(this.primarykey);
			this.saved.pos.setValue(this.keys.key.get().getPosition());
		}
		else {
			this.saved.pos.setValue(this.file.getPosition());
		}
		this.saved.autoincdone.setValue(this.info.autoincdone);
		this.saved.add();
		return id.like();
	}
	public void seterror(ClarionNumber err)
	{
		this.errors.seterrors();
		this.info.lasterror.setValue(err);
		this.info.put();
	}
	public void setkey(ClarionKey k)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.keys.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.keys.get(i);
			if (this.keys.key.get()==k) break;
		}
	}
	public void setname(ClarionString st)
	{
		this.filename.setValue(st);
	}
	public void setthread()
	{
		ClarionNumber thisthread=Clarion.newNumber(1).setEncoding(ClarionNumber.SIGNED);
		if (this.file.getProperty(Prop.THREAD).boolValue()) {
			thisthread.setValue(CRun.getThreadID());
		}
		this.info.id.setValue(thisthread);
		this.info.get(this.info.ORDER().ascend(this.info.id));
		if (CError.errorCode()!=0) {
			this.info.clear();
			this.info.id.setValue(thisthread);
			this.info.add(this.info.ORDER().ascend(this.info.id));
		}
		this.errors.setfile(this.getname());
	}
	public ClarionNumber _throw(ClarionNumber errnum)
	{
		this.seterror(errnum.like());
		return this._throw();
	}
	public ClarionNumber _throw()
	{
		return this.errors.takeerror(this.info.lasterror.like());
	}
	public ClarionNumber throwmessage(ClarionNumber errnum,ClarionString me)
	{
		return this.errors.throwmessage(errnum.like(),me.like());
	}
	public ClarionNumber tryfetch(ClarionKey key)
	{
		if (this.usefile().boolValue()) {
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
	public ClarionNumber tryinsert()
	{
		return this.insertserver(Clarion.newNumber(0));
	}
	public ClarionNumber trynext()
	{
		return this.nextserver(Clarion.newNumber(0));
	}
	public ClarionNumber tryopen()
	{
		return this.openserver(Clarion.newNumber(0));
	}
	public ClarionNumber tryprevious()
	{
		return this.nextserver(Clarion.newNumber(0),Clarion.newNumber(1));
	}
	public ClarionNumber tryprimeautoinc()
	{
		return this.primeautoincserver(Clarion.newNumber(0));
	}
	public ClarionNumber tryreget(ClarionString p)
	{
		if (this.usefile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		if (this.primarykey.boolValue()) {
			this.keys.get(this.primarykey);
			this.keys.key.get().reget(p);
		}
		else {
			this.file.reget(p);
		}
		return (CError.errorCode()==0 ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.NOTIFY)).getNumber();
	}
	public ClarionNumber tryupdate()
	{
		return this.updateserver(Clarion.newNumber(0));
	}
	public ClarionNumber update()
	{
		return this.updateserver(Clarion.newNumber(1));
	}
	public ClarionNumber updateserver(ClarionNumber handleerror)
	{
		ClarionString hold=Clarion.newString(1024);
		if (this.usefile().boolValue()) {
			return Clarion.newNumber(Level.FATAL);
		}
		if (this.validaterecord().boolValue()) {
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
				this.seterror((handleerror.equals(2) ? Clarion.newNumber(Msg.CONCURRENCYFAILEDFROMFORM) : Clarion.newNumber(Msg.CONCURRENCYFAILED)).getNumber());
				if (handleerror.boolValue()) {
					this._throw();
				}
				this.file.watch();
				this.tryreget(hold.like());
				case_1_break=true;
			}
			if (!case_1_break) {
				this.seterror(Clarion.newNumber(Msg.PUTFAILED));
				if (handleerror.boolValue()) {
					return this._throw();
				}
			}
		}
		return Clarion.newNumber(Level.NOTIFY);
	}
	public ClarionNumber usefile()
	{
		return usefile(Clarion.newNumber(Usetype.USES));
	}
	public ClarionNumber usefile(ClarionNumber usage)
	{
		ClarionNumber i=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveid=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.inusefile.setValue(Constants.TRUE);
		this.setthread();
		if (!usage.equals(Usetype.BENIGN)) {
			Abfile.filesmanager.noteusage(this,usage.like());
		}
		if (this.lazyopen.boolValue()) {
			if (!this.info.used.boolValue()) {
				if (this.info.opened.compareTo(1)<0) {
					this.inusefile.setValue(Constants.FALSE);
					return this._throw(Clarion.newNumber(Msg.USECLOSEDFILE));
				}
				saveid.setValue(this.savebuffer());
				i.setValue(this.openfile(Clarion.newNumber(1)));
				this.restorebuffer(saveid,Clarion.newNumber(1));
			}
		}
		this.inusefile.setValue(Constants.FALSE);
		return i.like();
	}
	public ClarionNumber validatefield(ClarionNumber field)
	{
		return this.validatefieldserver(field.like(),Clarion.newNumber(1));
	}
	public ClarionNumber tryvalidatefield(ClarionNumber field)
	{
		return this.validatefieldserver(field.like(),Clarion.newNumber(0));
	}
	public ClarionNumber validatefieldserver(ClarionNumber field,ClarionNumber handleerrors)
	{
		ClarionNumber bufferhandle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber rval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (!(this.aliasedfile==null)) {
			bufferhandle.setValue(this.aliasedfile.savebuffer());
			this.aliasedfile.buffer.setValue(this.buffer.getString());
			rval.setValue(this.aliasedfile.validatefield(field.like()));
			this.aliasedfile.restorebuffer(bufferhandle);
		}
		return rval.like();
	}
	public ClarionNumber validatefields(ClarionNumber p0,ClarionNumber p1)
	{
		return validatefields(p0,p1,(ClarionNumber)null);
	}
	public ClarionNumber validatefields(ClarionNumber low,ClarionNumber high,ClarionNumber u)
	{
		ClarionNumber bufferhandle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber retval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (this.aliasedfile==null) {
			final ClarionNumber loop_1=high.like();for (i.setValue(low);i.compareTo(loop_1)<=0;i.increment(1)) {
				retval.setValue(this.validatefield(i.like()));
				if (retval.boolValue()) {
					if (!(u==null)) {
						u.setValue(i);
					}
					break;
				}
			}
		}
		else {
			bufferhandle.setValue(this.aliasedfile.savebuffer());
			this.aliasedfile.buffer.setValue(this.buffer.getString());
			retval.setValue(this.aliasedfile.validatefields(low.like(),high.like(),u));
			this.aliasedfile.restorebuffer(bufferhandle);
		}
		return retval.like();
	}
	public ClarionNumber validaterecord()
	{
		return validaterecord((ClarionNumber)null);
	}
	public ClarionNumber validaterecord(ClarionNumber u)
	{
		ClarionNumber bufferhandle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber result=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.aliasedfile==null) {
			result.setValue(this.validatefields(Clarion.newNumber(1),this.file.getProperty(Prop.FIELDS).getNumber(),u));
		}
		else {
			bufferhandle.setValue(this.aliasedfile.savebuffer());
			this.aliasedfile.buffer.setValue(this.buffer.getString());
			result.setValue(this.aliasedfile.validaterecord(u));
			this.aliasedfile.restorebuffer(bufferhandle);
		}
		return result.like();
	}
	public ClarionNumber deleterecord()
	{
		return deleterecord(Clarion.newNumber(1));
	}
	public ClarionNumber deleterecord(ClarionNumber query)
	{
		this.file.delete();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber deleted()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
}
