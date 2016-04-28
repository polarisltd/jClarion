package clarion;

import clarion.Arcformatgrp;
import clarion.Checkformatgrp;
import clarion.Chordformatgrp;
import clarion.Ellipseformatgrp;
import clarion.Errorclass;
import clarion.Groupformatgrp;
import clarion.Imageformatgrp;
import clarion.Lineformatgrp;
import clarion.Pointqueue;
import clarion.Posgrp;
import clarion.Printpreviewfilequeue;
import clarion.Radioformatgrp;
import clarion.Rectformatgrp;
import clarion.Sliceformatqueue;
import clarion.Stringformatgrp;
import clarion.Stylegrp;
import clarion.Textformatqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public abstract class Ireportgenerator
{

	public void init()
	{
		init((Errorclass)null);
	}
	public abstract void init(Errorclass ec);
	public abstract ClarionNumber openDocument(ClarionNumber totalPages);
	public abstract ClarionNumber closeDocument();
	public abstract ClarionNumber openPage(ClarionNumber boxLeft,ClarionNumber boxTop,ClarionNumber boxRight,ClarionNumber boxBottom);
	public abstract ClarionNumber closePage();
	public ClarionNumber askProperties()
	{
		return askProperties(Clarion.newNumber(0));
	}
	public abstract ClarionNumber askProperties(ClarionNumber force);
	public abstract ClarionString whoAmI();
	public abstract ClarionString displayName();
	public abstract ClarionString displayIcon();
	public abstract void processArc(Arcformatgrp pFormatGrp,ClarionString pExtendControlAttr);
	public abstract void processBand(ClarionString type,ClarionNumber start);
	public abstract void processCheck(Checkformatgrp pFormatGrp,ClarionString text,ClarionString pExtendControlAttr);
	public abstract void processChord(Chordformatgrp pFormatGrp,ClarionString pExtendControlAttr);
	public abstract void processEllipse(Ellipseformatgrp pFormatGrp,ClarionString pExtendControlAttr);
	public abstract void processImage(Imageformatgrp pFormatGrp,ClarionString iName,ClarionString pExtendControlAttr);
	public abstract void processLine(Lineformatgrp pFormatGrp,ClarionString pExtendControlAttr);
	public abstract void processGroup(Groupformatgrp pFormatGrp,ClarionString text,ClarionString pExtendControlAttr);
	public abstract void processPie(Sliceformatqueue pSliceFormatQueue,Posgrp pPosGroup,ClarionString pExtendControlAttr);
	public abstract void processPolygon(Pointqueue pPointQueue,Stylegrp pStyleGrp,ClarionString pExtendControlAttr);
	public abstract void processRadio(Radioformatgrp pFormatGrp,ClarionString text,ClarionString pExtendControlAttr);
	public abstract void processRectangle(Rectformatgrp pFormatGrp,ClarionString pExtendControlAttr);
	public abstract void processString(Stringformatgrp pFormatGrp,ClarionString text,ClarionString pExtendControlAttr);
	public abstract void processText(Textformatqueue pTextFormatQueue,ClarionString pExtendControlAttr);
	public abstract void setResultQueue(Printpreviewfilequeue outputFile);
	public abstract ClarionNumber supportResultQueue();
}
