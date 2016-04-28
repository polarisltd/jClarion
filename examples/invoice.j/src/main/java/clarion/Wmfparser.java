package clarion;

import clarion.Abwmfpar;
import clarion.Arcformatgrp;
import clarion.Checkformatgrp;
import clarion.Chordformatgrp;
import clarion.Core;
import clarion.Ellipseformatgrp;
import clarion.Errorclass;
import clarion.Groupformatgrp;
import clarion.Imageformatgrp;
import clarion.Ireportgenerator;
import clarion.Lineformatgrp;
import clarion.Metafileheader;
import clarion.Metaheader;
import clarion.Metarecord;
import clarion.Pointqueue;
import clarion.Posgrp;
import clarion.Queuebrush;
import clarion.Queuedc;
import clarion.Queuefonts;
import clarion.Queueholes;
import clarion.Queueobjects;
import clarion.Queuepens;
import clarion.Radioformatgrp;
import clarion.Rectformatgrp;
import clarion.Sliceformatqueue;
import clarion.Stringformatgrp;
import clarion.Stylegrp;
import clarion.Textformatqueue;
import clarion.Windows;
import clarion.equates.Brush;
import clarion.equates.Color;
import clarion.equates.Constants;
import clarion.equates.Esctype;
import clarion.equates.Eto;
import clarion.equates.File;
import clarion.equates.Font;
import clarion.equates.Level;
import clarion.equates.Meta;
import clarion.equates.Msg;
import clarion.equates.Pen;
import clarion.equates.Prop;
import clarion.equates.Type;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;

public class Wmfparser
{
	public Errorclass errors;
	public Ireportgenerator reportGenerator;
	public ClarionString filename;
	public ClarionNumber fileOpen;
	public ClarionNumber currentObject;
	public ClarionNumber firstSlice;
	public ClarionNumber insideArc;
	public ClarionNumber insideBox;
	public ClarionNumber insideCheck;
	public ClarionNumber insideChord;
	public ClarionNumber insideEllipse;
	public ClarionNumber insideImage;
	public ClarionNumber insideLine;
	public ClarionNumber insideGroup;
	public ClarionNumber insidePie;
	public ClarionNumber insidePolygon;
	public ClarionNumber insideRadio;
	public ClarionNumber insideString;
	public ClarionNumber insideText;
	public Posgrp pos;
	public Stylegrp style;
	public Arcformatgrp arcFormat;
	public Checkformatgrp checkFormat;
	public Ellipseformatgrp ellipseFormat;
	public Imageformatgrp imageFormat;
	public Lineformatgrp lineFormat;
	public Groupformatgrp groupFormat;
	public Radioformatgrp radioFormat;
	public Rectformatgrp rectFormat;
	public Stringformatgrp stringFormat;
	public Pointqueue pointQ;
	public Sliceformatqueue sliceFormatQ;
	public Textformatqueue textFormatQ;
	public Queuedc dc;
	public Queuebrush brush;
	public Queuefonts fontS;
	public Queuepens pens;
	public Queueobjects objects;
	public Queueholes holes;
	public ClarionNumber lineStartXPos;
	public ClarionNumber lineStartYPos;
	public ClarionString tempText;
	public ClarionNumber tempTextLen;
	public ClarionString comment;
	public ClarionString preserveComment;
	public ClarionNumber boxLeft;
	public ClarionNumber boxTop;
	public ClarionNumber boxRight;
	public ClarionNumber boxBottom;
	public ClarionNumber pixelsPerInch;
	public ClarionReal toInch;
	public ClarionNumber wMFFPos;
	public ClarionNumber windowOriginX;
	public ClarionNumber windowOriginY;
	public Wmfparser()
	{
		errors=null;
		reportGenerator=null;
		filename=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		fileOpen=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		currentObject=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		firstSlice=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideArc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideBox=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideCheck=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideChord=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideEllipse=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideImage=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideLine=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideGroup=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insidePie=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insidePolygon=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideRadio=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideString=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insideText=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		pos=new Posgrp();
		style=new Stylegrp();
		arcFormat=new Arcformatgrp();
		checkFormat=new Checkformatgrp();
		ellipseFormat=new Ellipseformatgrp();
		imageFormat=new Imageformatgrp();
		lineFormat=new Lineformatgrp();
		groupFormat=new Groupformatgrp();
		radioFormat=new Radioformatgrp();
		rectFormat=new Rectformatgrp();
		stringFormat=new Stringformatgrp();
		pointQ=null;
		sliceFormatQ=null;
		textFormatQ=null;
		dc=null;
		brush=null;
		fontS=null;
		pens=null;
		objects=null;
		holes=null;
		lineStartXPos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		lineStartYPos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		tempText=Clarion.newString(256);
		tempTextLen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		comment=Clarion.newString(Constants.MAXATTRIBUTESIZE);
		preserveComment=Clarion.newString(Constants.MAXATTRIBUTESIZE);
		boxLeft=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		boxTop=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		boxRight=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		boxBottom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		pixelsPerInch=Clarion.newNumber(360).setEncoding(ClarionNumber.USHORT);
		toInch=Clarion.newReal();
		wMFFPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		windowOriginX=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		windowOriginY=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		construct();
	}

	public void construct()
	{
		this.pointQ=new Pointqueue();
		this.sliceFormatQ=new Sliceformatqueue();
		this.textFormatQ=new Textformatqueue();
		this.fontS=new Queuefonts();
		this.brush=new Queuebrush();
		this.pens=new Queuepens();
		this.holes=new Queueholes();
		this.objects=new Queueobjects();
		this.dc=new Queuedc();
		this.currentObject.setValue(0);
		this.dc.clear();
		this.dc.bKColor.setValue(Color.NONE);
		this.dc.currentFont.setValue(-1);
		this.dc.currentPen.setValue(-1);
		this.dc.currentBrush.setValue(-1);
		this.insideBox.setValue(0);
		this.insideCheck.setValue(0);
		this.insideImage.setValue(0);
		this.insideGroup.setValue(0);
		this.insideRadio.setValue(0);
		this.insideString.setValue(0);
		this.insideText.setValue(0);
	}
	public void destruct()
	{
		if (this.fileOpen.equals(Constants.TRUE)) {
			this.closeFile();
		}
		this.kill();
		//this.pointQ;
		//this.sliceFormatQ;
		//this.textFormatQ;
		//this.fontS;
		//this.brush;
		//this.pens;
		//this.holes;
		//this.dc;
		//this.objects;
	}
	public ClarionNumber getBoxLeft()
	{
		return this.boxLeft.like();
	}
	public ClarionNumber getBoxTop()
	{
		return this.boxTop.like();
	}
	public ClarionNumber getBoxRight()
	{
		return this.boxRight.like();
	}
	public ClarionNumber getBoxBottom()
	{
		return this.boxBottom.like();
	}
	public void init(ClarionString fname,Ireportgenerator rptgen,Errorclass ec)
	{
		this.filename.setValue(fname.clip());
		this.fileOpen.setValue(Constants.FALSE);
		this.wMFFPos.setValue(1);
		this.errors=ec;
		this.reportGenerator=rptgen;
		this.dc.clear();
		this.currentObject.setValue(0);
		this.dc.bKColor.setValue(Color.NONE);
		this.dc.currentFont.setValue(-1);
		this.dc.currentPen.setValue(-1);
		this.dc.currentBrush.setValue(-1);
		this.windowOriginX.setValue(0);
		this.windowOriginY.setValue(0);
	}
	public void kill()
	{
		this.pointQ.free();
		this.sliceFormatQ.free();
		this.textFormatQ.free();
		this.fontS.free();
		this.brush.free();
		this.pens.free();
		this.holes.free();
		this.dc.free();
		this.objects.free();
	}
	public ClarionNumber openFile()
	{
		ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.fileOpen.equals(Constants.TRUE)) {
			if (!Abwmfpar.wMFInFile.getProperty(Prop.NAME).getString().upper().equals(this.filename.upper())) {
				ret.setValue(this.closeFile());
				if (!ret.equals(Level.BENIGN)) {
					return ret.like();
				}
			}
		}
		this.errors.setFile(this.filename.like());
		Abwmfpar.wMFInFile.setClonedProperty(Prop.NAME,this.filename);
		Abwmfpar.wMFInFile.open();
		if (CError.errorCode()!=0) {
			return this.errors._throw(Clarion.newNumber(Msg.OPENFAILED));
		}
		this.fileOpen.setValue(Constants.TRUE);
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber run()
	{
		return this.processFile();
	}
	public ClarionNumber closeFile()
	{
		if (this.fileOpen.equals(Constants.TRUE)) {
			Abwmfpar.wMFInFile.close();
			if (CError.errorCode()!=0) {
				return this.errors._throw(Clarion.newNumber(Msg.CLOSEFAILED));
			}
			this.fileOpen.setValue(Constants.FALSE);
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber addObject(ClarionNumber type)
	{
		if (this.holes.records()!=0) {
			this.holes.get(1);
			this.objects.id.setValue(this.holes.id);
			this.holes.delete();
		}
		else {
			this.objects.id.setValue(this.currentObject);
			this.currentObject.increment(1);
		}
		this.objects.type.setValue(type);
		this.objects.get(this.objects.ORDER().ascend(this.objects.id));
		this.objects.add();
		return this.objects.id.like();
	}
	public ClarionNumber processHeader()
	{
		Metafileheader metafileheader=(Metafileheader)(new Metafileheader()).setOver(Abwmfpar.wMFInFile.buffer);
		Metaheader metaheader=(Metaheader)(new Metaheader()).setOver(Abwmfpar.wMFInFile.buffer);
		Abwmfpar.wMFInFile.get(this.wMFFPos,CMemory.size(metafileheader));
		if (CError.errorCode()!=0) {
			return this.errors._throw(Clarion.newNumber(Msg.OPENFAILED));
		}
		if (!metafileheader.key.equals((int)0x9ac6cdd7l)) {
			return this.errors._throw(Clarion.newNumber(Msg.WMFFILENOTVALID));
		}
		this.pixelsPerInch.setValue(metafileheader.inch);
		this.toInch.setValue(Clarion.newNumber(1000).divide(this.pixelsPerInch));
		this.boxLeft.setValue(metafileheader.bboxLeft.multiply(this.toInch));
		this.boxTop.setValue(metafileheader.bboxTop.multiply(this.toInch));
		this.boxRight.setValue(metafileheader.bboxRight.multiply(this.toInch));
		this.boxBottom.setValue(metafileheader.bboxBottom.multiply(this.toInch));
		this.wMFFPos.increment(CMemory.size(metafileheader));
		Abwmfpar.wMFInFile.get(this.wMFFPos,CMemory.size(metaheader));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Level.FATAL);
		}
		this.wMFFPos.increment(CMemory.size(metaheader));
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber processFile()
	{
		ClarionNumber ret=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		while (true) {
			ret.setValue(this.takeRecord());
			if (!ret.equals(Level.BENIGN)) {
				break;
			}
		}
		return (ret.equals(Level.NOTIFY) ? Clarion.newNumber(Level.BENIGN) : ret).getNumber();
	}
	public ClarionNumber takeRecord()
	{
		Metarecord metarecord=(Metarecord)(new Metarecord()).setOver(Abwmfpar.wMFInFile.buffer);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber viaSign=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber textStart=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber textLen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionString tmpCString=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionString bandName=Clarion.newString(10).setEncoding(ClarionString.CSTRING);
		ClarionString lOCPath=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionString lOCDrive=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionString lOCDir=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionString lOCName=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		ClarionString lOCExtension=Clarion.newString(File.MAXFILEPATH).setEncoding(ClarionString.CSTRING);
		Abwmfpar.wMFInFile.get(this.wMFFPos,CMemory.size(metarecord.size));
		if (CError.errorCode()!=0) {
			if (CError.errorCode()==Constants.BADRECERR) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				return this.errors._throw(Clarion.newNumber(Msg.GETRECORDFAILED));
			}
		}
		if (!metarecord.size.boolValue()) {
			return this.errors._throw(Clarion.newNumber(Msg.WMFFILENOTVALID));
		}
		Abwmfpar.wMFInFile.get(this.wMFFPos,metarecord.size.multiply(2).intValue());
		this.wMFFPos.increment(metarecord.size.multiply(2));
		{
			ClarionNumber case_1=metarecord.funct;
			boolean case_1_break=false;
			if (case_1.equals(Meta.ABORTDOC)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.ANIMATEPALETTE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.ARC)) {
				this.arcFormat.startX.setValue(this.windowOriginY.add(metarecord.shortGrp.param4).multiply(this.toInch));
				this.arcFormat.startY.setValue(this.windowOriginX.add(metarecord.shortGrp.param3).multiply(this.toInch));
				this.arcFormat.endX.setValue(this.windowOriginY.add(metarecord.shortGrp.param2).multiply(this.toInch));
				this.arcFormat.endY.setValue(this.windowOriginX.add(metarecord.shortGrp.param1).multiply(this.toInch));
				this.arcFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param7).multiply(this.toInch));
				this.arcFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param8).multiply(this.toInch));
				this.arcFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param5).multiply(this.toInch));
				this.arcFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param4).multiply(this.toInch));
				this.pens.id.setValue(this.dc.currentPen);
				this.pens.get(this.pens.ORDER().ascend(this.pens.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Pen"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.arcFormat.style.borderStyle.setValue(this.pens.style);
				this.arcFormat.style.borderColor.setValue(this.pens.color);
				this.arcFormat.style.borderWidth.setValue(this.pens.width);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.BITBLT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CHORD)) {
				this.arcFormat.startX.setValue(this.windowOriginY.add(metarecord.shortGrp.param4).multiply(this.toInch));
				this.arcFormat.startY.setValue(this.windowOriginX.add(metarecord.shortGrp.param3).multiply(this.toInch));
				this.arcFormat.endX.setValue(this.windowOriginY.add(metarecord.shortGrp.param2).multiply(this.toInch));
				this.arcFormat.endY.setValue(this.windowOriginX.add(metarecord.shortGrp.param1).multiply(this.toInch));
				this.arcFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param7).multiply(this.toInch));
				this.arcFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param8).multiply(this.toInch));
				this.arcFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param5).multiply(this.toInch));
				this.arcFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param4).multiply(this.toInch));
				this.brush.id.setValue(this.dc.currentBrush);
				this.brush.get(this.brush.ORDER().ascend(this.brush.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Brush"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.arcFormat.style.backgroundColor.setValue(this.brush.color);
				this.arcFormat.style.backgroundStyle.setValue(this.brush.style);
				this.pens.id.setValue(this.dc.currentPen);
				this.pens.get(this.pens.ORDER().ascend(this.pens.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Pen"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.arcFormat.style.borderStyle.setValue(this.pens.style);
				this.arcFormat.style.borderColor.setValue(this.pens.color);
				this.arcFormat.style.borderWidth.setValue(this.pens.width);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEBITMAP)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEBITMAPINDIRECT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEBRUSH)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEBRUSHINDIRECT)) {
				this.brush.id.setValue(this.addObject(Clarion.newNumber(Type.BRUSH)));
				this.brush.style.setValue(metarecord.brushIndirect.style);
				{
					ClarionNumber case_2=this.brush.style;
					boolean case_2_break=false;
					boolean case_2_match=false;
					case_2_match=false;
					if (case_2.equals(Brush.HOLLOW)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Brush.NULL)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Brush.PATTERN)) {
						this.brush.color.setValue(Color.NONE);
						case_2_break=true;
					}
					if (!case_2_break) {
						this.brush.color.setValue(metarecord.brushIndirect.color);
					}
				}
				this.brush.hatch.setValue(metarecord.brushIndirect.hatch);
				this.brush.add();
				this.dc.currentBrush.setValue(this.brush.id);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEFONTINDIRECT)) {
				this.fontS.id.setValue(this.addObject(Clarion.newNumber(Type.FONT)));
				viaSign.setValue(metarecord.params.get(1));
				this.fontS.size.setValue((new Windows()).mulDiv(viaSign.abs(),Clarion.newNumber(72),this.pixelsPerInch.like()));
				this.fontS.color.setValue(this.dc.textColor);
				this.fontS.style.setValue(metarecord.params.get(5).intValue() & Font.WEIGHT);
				this.fontS.angle.setValue(metarecord.params.get(3).divide(10));
				if ((metarecord.params.get(6).intValue() & 255)!=0) {
					this.fontS.style.increment(Font.ITALIC);
				}
				if (ClarionNumber.shift(metarecord.params.get(6).intValue(),-8)!=0) {
					this.fontS.style.increment(Font.UNDERLINE);
				}
				if ((metarecord.params.get(7).intValue() & 255)!=0) {
					this.fontS.style.increment(Font.STRIKEOUT);
				}
				textStart.setValue(6+9*2+1);
				CRun._assert(metarecord.size.multiply(2).compareTo(textStart)>0);
				this.fontS.face.setValue(Abwmfpar.wMFInFile.buffer.stringAt(textStart,metarecord.size.multiply(2)));
				this.fontS.add();
				this.dc.currentFont.setValue(this.fontS.id);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEPALETTE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEPATTERNBRUSH)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEPENINDIRECT)) {
				this.pens.id.setValue(this.addObject(Clarion.newNumber(Type.PEN)));
				this.pens.width.setValue(metarecord.penIndirect.width);
				this.pens.style.setValue(metarecord.penIndirect.style);
				if (this.pens.style.equals(Pen.NULL)) {
					this.pens.color.setValue(Color.NONE);
				}
				else {
					this.pens.color.setValue(metarecord.penIndirect.color);
				}
				this.pens.add();
				this.dc.currentPen.setValue(this.pens.id);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.CREATEREGION)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.DELETEOBJECT)) {
				this.objects.id.setValue(metarecord.params.get(1));
				this.objects.get(this.objects.ORDER().ascend(this.objects.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Object"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.objects.delete();
				this.holes.id.setValue(metarecord.params.get(1));
				this.holes.add(this.holes.ORDER().ascend(this.holes.id));
				if (CError.errorCode()!=0) {
					return this.errors._throw(Clarion.newNumber(Msg.WMFADDQUEUEFAILED));
				}
				this.fontS.id.setValue(metarecord.params.get(1));
				this.fontS.get(this.fontS.ORDER().ascend(this.fontS.id));
				if (!(CError.errorCode()!=0)) {
					this.fontS.delete();
				}
				else {
					this.pens.id.setValue(metarecord.params.get(1));
					this.pens.get(this.pens.ORDER().ascend(this.pens.id));
					if (!(CError.errorCode()!=0)) {
						this.pens.delete();
					}
					else {
						this.brush.id.setValue(metarecord.params.get(1));
						this.brush.get(this.brush.ORDER().ascend(this.brush.id));
						if (!(CError.errorCode()!=0)) {
							this.brush.delete();
						}
						else {
							this.errors.setField(Clarion.newString("Brush"));
							return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
						}
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.DIBBITBLT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.DIBCREATEPATTERNBRUSH)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.DIBSTRETCHBLT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.DRAWTEXT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.ELLIPSE)) {
				this.ellipseFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param3).multiply(this.toInch));
				this.ellipseFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param4).multiply(this.toInch));
				this.ellipseFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
				this.ellipseFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
				this.brush.id.setValue(this.dc.currentBrush);
				this.brush.get(this.brush.ORDER().ascend(this.brush.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Brush"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.ellipseFormat.style.backgroundColor.setValue(this.brush.color);
				this.ellipseFormat.style.backgroundStyle.setValue(this.brush.style);
				this.pens.id.setValue(this.dc.currentPen);
				this.pens.get(this.pens.ORDER().ascend(this.pens.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Pen"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.ellipseFormat.style.borderStyle.setValue(this.pens.style);
				this.ellipseFormat.style.borderColor.setValue(this.pens.color);
				this.ellipseFormat.style.borderWidth.setValue(this.pens.width);
				{
					ClarionNumber case_3=this.insideRadio;
					boolean case_3_break=false;
					if (case_3.equals(1)) {
						this.radioFormat.outer.setValue(this.ellipseFormat.getString());
						this.insideRadio.increment(1);
						case_3_break=true;
					}
					if (!case_3_break && case_3.equals(2)) {
						this.radioFormat.inner.setValue(this.ellipseFormat.getString());
						this.radioFormat.checked.setValue(Constants.TRUE);
						case_3_break=true;
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.ENDDOC)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.ENDPAGE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.ESCAPE)) {
				if (metarecord.escapeGrp.magic.equals(1319)) {
					{
						ClarionNumber case_4=metarecord.escapeGrp.type;
						boolean case_4_break=false;
						if (case_4.equals(Esctype.IMAGENAME)) {
							this.tempText.setValue(Abwmfpar.wMFInFile.buffer.stringAt(39,Clarion.newNumber(39).add(metarecord.escapeGrp.sLen).subtract(1)));
							this.tempTextLen.setValue(metarecord.escapeGrp.sLen);
							case_4_break=true;
						}
						if (!case_4_break && case_4.equals(Esctype.IMAGEINFO)) {
							tmpCString.setValue(Abwmfpar.wMFInFile.buffer.stringAt(25,25+File.MAXFILEPATH));
							this.tempText.setValue(tmpCString);
							this.tempTextLen.setValue(this.tempText.clip().len());
							case_4_break=true;
						}
						if (!case_4_break && case_4.equals(Esctype.STARTCONTROL)) {
							this.comment.setValue(Abwmfpar.wMFInFile.buffer.stringAt(39,Clarion.newNumber(39).add(metarecord.escapeGrp.sLen).subtract(1)));
							this.tempText.setValue("");
							this.tempTextLen.setValue(0);
							{
								ClarionString case_5=metarecord.escapeGrp.ctlName;
								boolean case_5_break=false;
								boolean case_5_match=false;
								case_5_match=false;
								if (case_5.equals("ARC")) {
									this.insideArc.setValue(Constants.TRUE);
									this.arcFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("BOX")) {
									this.insideBox.setValue(Constants.TRUE);
									this.rectFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("CHECK")) {
									this.insideCheck.setValue(Constants.TRUE);
									this.checkFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("CHORD")) {
									this.insideChord.setValue(Constants.TRUE);
									this.arcFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("ELLIPSE")) {
									this.insideEllipse.setValue(Constants.TRUE);
									this.ellipseFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("LINE")) {
									this.insideLine.setValue(Constants.TRUE);
									this.lineFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("IMAGE")) {
									this.insideImage.setValue(Constants.TRUE);
									this.imageFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("OPTION")) {
									case_5_match=true;
								}
								if (case_5_match || case_5.equals("GROUP")) {
									this.insideGroup.setValue(Constants.TRUE);
									this.groupFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("RADIO")) {
									this.insideRadio.setValue(Constants.TRUE);
									this.radioFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("STRING")) {
									case_5_match=true;
								}
								if (case_5_match || case_5.equals("SMARTSTRING")) {
									this.insideString.setValue(Constants.TRUE);
									this.stringFormat.clear();
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("TEXT")) {
									this.insideText.setValue(Constants.TRUE);
									if (metarecord.escapeGrp.isSplit.boolValue()) {
										this.comment.setValue(this.preserveComment);
									}
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("PIE")) {
									this.insidePie.setValue(Constants.TRUE);
									this.firstSlice.setValue(Constants.TRUE);
									case_5_break=true;
								}
								case_5_match=false;
								if (!case_5_break && case_5.equals("POLYGON")) {
									this.insidePolygon.setValue(Constants.TRUE);
									case_5_break=true;
								}
							}
							case_4_break=true;
						}
						if (!case_4_break && case_4.equals(Esctype.ENDCONTROL)) {
							{
								ClarionString case_6=metarecord.escapeGrp.ctlName;
								boolean case_6_break=false;
								boolean case_6_match=false;
								case_6_match=false;
								if (case_6.equals("ARC")) {
									if (this.insideArc.boolValue()) {
										this.reportGenerator.processArc(this.arcFormat,this.comment.like());
										this.insideArc.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("BOX")) {
									if (this.insideBox.boolValue()) {
										this.reportGenerator.processRectangle(this.rectFormat,this.comment.like());
										this.insideBox.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("CHECK")) {
									if (this.insideCheck.boolValue()) {
										this.reportGenerator.processCheck(this.checkFormat,this.tempText.stringAt(1,this.tempTextLen),this.comment.like());
										this.insideCheck.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("CHORD")) {
									if (this.insideChord.boolValue()) {
										this.reportGenerator.processChord((Chordformatgrp)this.arcFormat.castTo(Chordformatgrp.class),this.comment.like());
										this.insideChord.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("ELLIPSE")) {
									if (this.insideEllipse.boolValue()) {
										this.reportGenerator.processEllipse(this.ellipseFormat,this.comment.like());
										this.insideEllipse.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("LINE")) {
									if (this.insideLine.boolValue()) {
										this.reportGenerator.processLine(this.lineFormat,this.comment.like());
										this.insideLine.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("IMAGE")) {
									if (this.insideImage.boolValue()) {
										if (this.tempText.stringAt(1,this.tempTextLen).clip().boolValue()) {
											lOCPath.setValue(this.tempText.stringAt(1,this.tempTextLen));
											(new Core()).pathSplit(lOCPath,lOCDrive,lOCDir,lOCName,lOCExtension);
											lOCPath.setValue(ClarionSystem.getInstance().getProperty(Prop.TEMPIMAGEPATH).concat(lOCName,lOCExtension));
											this.reportGenerator.processImage(this.imageFormat,lOCPath.like(),this.comment.like());
										}
										this.insideImage.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("OPTION")) {
									case_6_match=true;
								}
								if (case_6_match || case_6.equals("GROUP")) {
									if (this.insideGroup.boolValue()) {
										this.reportGenerator.processGroup(this.groupFormat,this.tempText.stringAt(1,this.tempTextLen),this.comment.like());
										this.insideGroup.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("RADIO")) {
									if (this.insideRadio.boolValue()) {
										this.reportGenerator.processRadio(this.radioFormat,this.tempText.stringAt(1,this.tempTextLen),this.comment.like());
										this.insideRadio.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("STRING")) {
									case_6_match=true;
								}
								if (case_6_match || case_6.equals("SMARTSTRING")) {
									if (this.insideString.boolValue()) {
										this.reportGenerator.processString(this.stringFormat,this.tempText.stringAt(1,this.tempTextLen),this.comment.like());
										this.insideString.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("TEXT")) {
									if (this.insideText.boolValue()) {
										if (metarecord.escapeGrp.isSplit.boolValue()) {
											this.preserveComment.setValue(this.comment);
										}
										this.reportGenerator.processText(this.textFormatQ,this.comment.like());
										this.textFormatQ.free();
										this.insideText.setValue(Constants.FALSE);
									}
									else {
										if (!metarecord.escapeGrp.isSplit.boolValue()) {
											this.errors.setField(metarecord.escapeGrp.ctlName.like());
											return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
										}
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("PIE")) {
									if (this.insidePie.boolValue()) {
										this.reportGenerator.processPie(this.sliceFormatQ,this.pos,this.comment.like());
										this.sliceFormatQ.free();
										this.insidePie.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6.equals("POLYGON")) {
									if (this.insidePolygon.boolValue()) {
										this.reportGenerator.processPolygon(this.pointQ,this.style,this.comment.like());
										this.pointQ.free();
										this.insidePolygon.setValue(Constants.FALSE);
									}
									else {
										this.errors.setField(metarecord.escapeGrp.ctlName.like());
										return this.errors._throw(Clarion.newNumber(Msg.WMFINVALIDCONTROL));
									}
									case_6_break=true;
								}
							}
							case_4_break=true;
						}
						if (!case_4_break && case_4.equals(Esctype.STARTBAND)) {
							bandName.setValue(Abwmfpar.wMFInFile.buffer.stringAt(15,25));
							this.reportGenerator.processBand(bandName.like(),Clarion.newNumber(Constants.TRUE));
							case_4_break=true;
						}
						if (!case_4_break && case_4.equals(Esctype.ENDBAND)) {
							bandName.setValue(Abwmfpar.wMFInFile.buffer.stringAt(15,25));
							this.reportGenerator.processBand(bandName.like(),Clarion.newNumber(Constants.FALSE));
							case_4_break=true;
						}
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.EXCLUDECLIPRECT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.EXTFLOODFILL)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.EXTTEXTOUT)) {
				this.stringFormat.clear();
				textStart.setValue(15);
				textLen.setValue(metarecord.params.get(3));
				this.stringFormat.topText.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
				this.stringFormat.leftText.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
				if (metarecord.params.get(4).boolValue()) {
					textStart.increment(8);
				}
				if ((metarecord.params.get(4).intValue() & Eto.CLIPPED+Eto.OPAQUE)!=0) {
					this.stringFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param5).multiply(this.toInch));
					this.stringFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param6).multiply(this.toInch));
					this.stringFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param7).multiply(this.toInch));
					this.stringFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param8).multiply(this.toInch));
				}
				else {
					this.stringFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
					this.stringFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
					this.stringFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).add(textLen.multiply(this.fontS.size).multiply("5.5")).multiply(this.toInch));
					this.stringFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).add(this.fontS.size.multiply("9.5")).multiply(this.toInch));
				}
				if (textLen.compareTo(0)>0 && metarecord.size.multiply(2).compareTo(textStart)>=0) {
					this.fontS.id.setValue(this.dc.currentFont);
					this.fontS.get(this.fontS.ORDER().ascend(this.fontS.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Fonts"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.stringFormat.size.setValue(this.fontS.size);
					this.stringFormat.style.setValue(this.fontS.style);
					this.stringFormat.face.setValue(this.fontS.face);
					this.stringFormat.angle.setValue(this.fontS.angle);
					if (this.dc.textColor.boolValue()) {
						this.stringFormat.color.setValue(this.dc.textColor);
					}
					else {
						this.stringFormat.color.setValue(this.fontS.color);
					}
					if (this.dc.bKMode.equals(Constants.TRANSPARENT)) {
						this.stringFormat.backgroundColor.setValue(Color.NONE);
					}
					else {
						this.stringFormat.backgroundColor.setValue(this.dc.bKColor);
					}
					this.tempText.setValue(Abwmfpar.wMFInFile.buffer.stringAt(textStart,textStart.add(textLen).subtract(1)));
					this.tempTextLen.setValue(textLen);
					if (this.insideGroup.boolValue()) {
						this.groupFormat.header.setValue(this.stringFormat.getString());
					}
					else if (this.insideCheck.boolValue()) {
						this.checkFormat.prompt.setValue(this.stringFormat.getString());
					}
					else if (this.insideRadio.boolValue()) {
						this.radioFormat.prompt.setValue(this.stringFormat.getString());
					}
					else if (this.insideText.boolValue()) {
						this.textFormatQ.text.setValue(Abwmfpar.wMFInFile.buffer.stringAt(textStart,textStart.add(textLen).subtract(1)));
						this.textFormatQ.format.setValue(this.stringFormat.getString());
						this.textFormatQ.add();
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.FILLREGION)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.FLOODFILL)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.FRAMEREGION)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.INTERSECTCLIPRECT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.INVERTREGION)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.LINETO)) {
				{
					ClarionNumber case_7=this.insideGroup;
					boolean case_7_break=false;
					if (case_7.equals(1)) {
						this.pens.id.setValue(this.dc.currentPen);
						this.pens.get(this.pens.ORDER().ascend(this.pens.id));
						if (CError.errorCode()!=0) {
							this.errors.setField(Clarion.newString("Pen"));
							return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
						}
						this.groupFormat.lineStyle.setValue(this.pens.style);
						this.groupFormat.lineColor.setValue(this.pens.color);
						this.groupFormat.lineWidth.setValue(this.pens.width);
						this.groupFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
						if (this.groupFormat.pos.left.equals(this.groupFormat.x1)) {
							this.groupFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
							this.insideGroup.increment(2);
						}
						else {
							this.insideGroup.increment(1);
						}
						case_7_break=true;
					}
					if (!case_7_break && case_7.equals(2)) {
						this.groupFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
						this.insideGroup.increment(1);
						case_7_break=true;
					}
					if (!case_7_break && case_7.equals(3)) {
						this.groupFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
						this.insideGroup.increment(1);
						case_7_break=true;
					}
					if (!case_7_break && case_7.equals(4)) {
						this.insideGroup.increment(1);
						case_7_break=true;
					}
					if (!case_7_break && case_7.equals(5)) {
						this.groupFormat.x2.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
						case_7_break=true;
					}
					if (!case_7_break) {
						if (this.insideCheck.boolValue()) {
							this.checkFormat.checked.setValue(Constants.TRUE);
						}
						else {
							this.lineFormat.pos.left.setValue(this.lineStartXPos);
							this.lineFormat.pos.top.setValue(this.lineStartYPos);
							this.lineFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
							this.lineFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
							this.pens.id.setValue(this.dc.currentPen);
							this.pens.get(this.pens.ORDER().ascend(this.pens.id));
							if (CError.errorCode()!=0) {
								this.errors.setField(Clarion.newString("Pen"));
								return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
							}
							this.lineFormat.style.setValue(this.pens.style);
							this.lineFormat.color.setValue(this.pens.color);
							this.lineFormat.width.setValue(this.pens.width);
						}
						this.lineStartXPos.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
						this.lineStartYPos.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.MOVETO)) {
				if (this.insideGroup.boolValue()) {
					this.groupFormat.x1.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
					this.groupFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
				}
				else {
					this.lineStartXPos.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
					this.lineStartYPos.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.OFFSETCLIPRGN)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.OFFSETVIEWPORTORG)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.OFFSETWINDOWORG)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.PAINTREGION)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.PATBLT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.PIE)) {
				if (this.insidePie.boolValue()) {
					this.brush.id.setValue(this.dc.currentBrush);
					this.brush.get(this.brush.ORDER().ascend(this.brush.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Brush"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.sliceFormatQ.format.style.backgroundColor.setValue(this.brush.color);
					this.sliceFormatQ.format.style.backgroundStyle.setValue(this.brush.style);
					this.pens.id.setValue(this.dc.currentPen);
					this.pens.get(this.pens.ORDER().ascend(this.pens.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Pen"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.sliceFormatQ.format.style.borderStyle.setValue(this.pens.style);
					this.sliceFormatQ.format.style.borderColor.setValue(this.pens.color);
					this.sliceFormatQ.format.style.borderWidth.setValue(this.pens.width);
					if (this.firstSlice.boolValue()) {
						this.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param7).multiply(this.toInch));
						this.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param8).multiply(this.toInch));
						this.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param5).multiply(this.toInch));
						this.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param6).multiply(this.toInch));
						this.firstSlice.setValue(Constants.FALSE);
					}
					this.sliceFormatQ.format.startX.setValue(this.windowOriginX.add(metarecord.shortGrp.param4).multiply(this.toInch));
					this.sliceFormatQ.format.startY.setValue(this.windowOriginY.add(metarecord.shortGrp.param3).multiply(this.toInch));
					this.sliceFormatQ.format.endX.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
					this.sliceFormatQ.format.endY.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
					this.sliceFormatQ.add();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.POLYGON)) {
				if (this.insidePolygon.boolValue()) {
					this.brush.id.setValue(this.dc.currentBrush);
					this.brush.get(this.brush.ORDER().ascend(this.brush.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Brush"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.style.backgroundColor.setValue(this.brush.color);
					this.style.backgroundStyle.setValue(this.brush.style);
					this.pens.id.setValue(this.dc.currentPen);
					this.pens.get(this.pens.ORDER().ascend(this.pens.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Pen"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.style.borderStyle.setValue(this.pens.style);
					this.style.borderColor.setValue(this.pens.color);
					this.style.borderWidth.setValue(this.pens.width);
					for (i.setValue(1);i.compareTo(metarecord.params.get(1))<=0;i.increment(1)) {
						this.pointQ.xPos.setValue(this.windowOriginX.add(metarecord.params.get(i.multiply(2).intValue())).multiply(this.toInch));
						this.pointQ.yPos.setValue(this.windowOriginY.add(metarecord.params.get(i.multiply(2).add(1).intValue())).multiply(this.toInch));
						this.pointQ.add();
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.POLYLINE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.POLYPOLYGON)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.REALIZEPALETTE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.RECTANGLE)) {
				if (this.insideCheck.boolValue()) {
					this.checkFormat.prompt.setValue(this.stringFormat.getString());
					this.checkFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param3).multiply(this.toInch));
					this.checkFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param4).multiply(this.toInch));
					this.checkFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
					this.checkFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
					this.brush.id.setValue(this.dc.currentBrush);
					this.brush.get(this.brush.ORDER().ascend(this.brush.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Brush"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.checkFormat.style.backgroundColor.setValue(this.brush.color);
					this.checkFormat.style.backgroundStyle.setValue(this.brush.style);
					this.pens.id.setValue(this.dc.currentPen);
					this.pens.get(this.pens.ORDER().ascend(this.pens.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Pen"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.checkFormat.style.borderStyle.setValue(this.pens.style);
					this.checkFormat.style.borderColor.setValue(this.pens.color);
					this.checkFormat.style.borderWidth.setValue(this.pens.width);
				}
				else if (this.insideBox.boolValue()) {
					this.rectFormat.clear();
					this.rectFormat.ell_width.setValue(0);
					this.rectFormat.ell_height.setValue(0);
					this.rectFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param3).multiply(this.toInch));
					this.rectFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param4).multiply(this.toInch));
					this.rectFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param1).multiply(this.toInch));
					this.rectFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param2).multiply(this.toInch));
					this.brush.id.setValue(this.dc.currentBrush);
					this.brush.get(this.brush.ORDER().ascend(this.brush.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Brush"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.rectFormat.style.backgroundColor.setValue(this.brush.color);
					this.rectFormat.style.backgroundStyle.setValue(this.brush.style);
					this.pens.id.setValue(this.dc.currentPen);
					this.pens.get(this.pens.ORDER().ascend(this.pens.id));
					if (CError.errorCode()!=0) {
						this.errors.setField(Clarion.newString("Pen"));
						return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
					}
					this.rectFormat.style.borderStyle.setValue(this.pens.style);
					this.rectFormat.style.borderColor.setValue(this.pens.color);
					this.rectFormat.style.borderWidth.setValue(this.pens.width);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.RESETDC)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.RESIZEPALETTE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.RESTOREDC)) {
				this.dc.get(this.dc.records());
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Device Context"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.dc.delete();
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.ROUNDRECT)) {
				this.rectFormat.clear();
				this.rectFormat.ell_width.setValue(metarecord.params.get(1).multiply(this.toInch));
				this.rectFormat.ell_height.setValue(metarecord.params.get(2).multiply(this.toInch));
				this.rectFormat.pos.top.setValue(this.windowOriginY.add(metarecord.shortGrp.param5).multiply(this.toInch));
				this.rectFormat.pos.left.setValue(this.windowOriginX.add(metarecord.shortGrp.param6).multiply(this.toInch));
				this.rectFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.shortGrp.param3).multiply(this.toInch));
				this.rectFormat.pos.right.setValue(this.windowOriginX.add(metarecord.shortGrp.param4).multiply(this.toInch));
				this.brush.id.setValue(this.dc.currentBrush);
				this.brush.get(this.brush.ORDER().ascend(this.brush.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Brush"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.rectFormat.style.backgroundColor.setValue(this.brush.color);
				this.rectFormat.style.backgroundStyle.setValue(this.brush.style);
				this.pens.id.setValue(this.dc.currentPen);
				this.pens.get(this.pens.ORDER().ascend(this.pens.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("Pen"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				this.rectFormat.style.borderStyle.setValue(this.pens.style);
				this.rectFormat.style.borderColor.setValue(this.pens.color);
				this.rectFormat.style.borderWidth.setValue(this.pens.width);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SAVEDC)) {
				this.dc.add();
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SCALEVIEWPORTEXT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SCALEWINDOWEXT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SELECTCLIPREGION)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SELECTOBJECT)) {
				this.objects.id.setValue(metarecord.params.get(1));
				this.objects.get(this.objects.ORDER().ascend(this.objects.id));
				if (CError.errorCode()!=0) {
					this.errors.setField(Clarion.newString("object"));
					return this.errors._throw(Clarion.newNumber(Msg.WMFOBJECTIDNOTFOUND));
				}
				{
					ClarionNumber case_8=this.objects.type;
					boolean case_8_break=false;
					if (case_8.equals(Type.FONT)) {
						this.dc.currentFont.setValue(this.objects.id);
						case_8_break=true;
					}
					if (!case_8_break && case_8.equals(Type.PEN)) {
						this.dc.currentPen.setValue(this.objects.id);
						case_8_break=true;
					}
					if (!case_8_break && case_8.equals(Type.BRUSH)) {
						this.dc.currentBrush.setValue(this.objects.id);
						case_8_break=true;
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SELECTPALETTE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETBKCOLOR)) {
				this.dc.bKColor.setValue(metarecord.longGrp.param1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETBKMODE)) {
				this.dc.bKMode.setValue(metarecord.longGrp.param1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETDIBTODEV)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETMAPMODE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETMAPPERFLAGS)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETPALENTRIES)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETPIXEL)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETPOLYFILLMODE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETRELABS)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETROP2)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETSTRETCHBLTMODE)) {
				this.insideImage.setValue(Constants.TRUE);
				this.imageFormat.stretchMode.setValue(metarecord.params.get(1));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETTEXTALIGN)) {
				this.dc.textAlign.setValue(metarecord.longGrp.param1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETTEXTCHAREXTRA)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETTEXTCOLOR)) {
				this.dc.textColor.setValue(metarecord.longGrp.param1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETTEXTJUSTIFICATION)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETVIEWPORTEXT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETVIEWPORTORG)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETWINDOWEXT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.SETWINDOWORG)) {
				this.windowOriginX.setValue(metarecord.shortGrp.param2.negate());
				this.windowOriginY.setValue(metarecord.shortGrp.param1.negate());
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.STARTDOC)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.STARTPAGE)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.STRETCHBLT)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.STRETCHDIB)) {
				this.imageFormat.pos.top.setValue(this.windowOriginY.add(metarecord.params.get(10)).multiply(this.toInch));
				this.imageFormat.pos.left.setValue(this.windowOriginX.add(metarecord.params.get(11)).multiply(this.toInch));
				this.imageFormat.pos.bottom.setValue(this.windowOriginY.add(metarecord.params.get(10)).add(metarecord.params.get(8)).multiply(this.toInch));
				this.imageFormat.pos.right.setValue(this.windowOriginX.add(metarecord.params.get(11)).add(metarecord.params.get(9)).multiply(this.toInch));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Meta.TEXTOUT)) {
				case_1_break=true;
			}
			if (!case_1_break) {
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
}
