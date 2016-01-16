/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.constants;

import java.util.HashMap;
import java.util.Map;

public class Prop
{
	public static final int TEXT=0x7c00;
	public static final int TYPE=0x7c01;
	public static final int AT=0x7c02;
	public static final int XPOS=0x7c02;
	public static final int YPOS=0x7c03;
	public static final int WIDTH=0x7c04;
	public static final int HEIGHT=0x7c05;
	public static final int CENTER=0x7c06;
	public static final int CENTEROFFSET=0x7c07;
	public static final int LEFT=0x7c08;
	public static final int LEFTOFFSET=0x7c09;
	public static final int DECIMAL=0x7c0a;
	public static final int DECIMALOFFSET=0x7c0b;
	public static final int RIGHT=0x7c0c;
	public static final int RIGHTOFFSET=0x7c0d;
	public static final int ABOVE=0x7c0a;
	public static final int ABOVESIZE=0x7c0b;
	public static final int BELOW=0x7c06;
	public static final int BELOWSIZE=0x7c07;
	public static final int CLASS=0x7c0e;
	public static final int VBXFILE=0x7c0e;
	public static final int VBXNAME=0x7c0f;
	public static final int FONT=0x7c10;
	public static final int FONTNAME=0x7c10;
	public static final int FONTSIZE=0x7c11;
	public static final int FONTCOLOR=0x7c12;
	public static final int FONTSTYLE=0x7c13;
	public static final int TIPSFONT=0x10;
	public static final int STATUSFONT=0x14;
	public static final int RANGE=0x7c14;
	public static final int RANGELOW=0x7c14;
	public static final int RANGEHIGH=0x7c15;
	public static final int VCR=0x7c16;
	public static final int VCRFEQ=0x7c17;
	public static final int DOUBLE=0x7c19;
	public static final int RESIZE=0x7c1a;
	public static final int NOFRAME=0x7c1b;
	public static final int MM=0x7c1c;
	public static final int THOUS=0x7c1d;
	public static final int POINTS=0x7c1e;
	public static final int PIXELS=0x7c1e;
	public static final int SUM=0x7c40;
	public static final int AVE=0x7c41;
	public static final int MAX=0x7c42;
	public static final int MIN=0x7c43;
	public static final int CNT=0x7c44;
	public static final int PAGENO=0x7c45;
	public static final int PAGE=0x7c50;
	public static final int ABSOLUTE=0x7c51;
	public static final int ALONE=0x7c52;
	public static final int PREVIEW=0x7c53;
	public static final int FLUSHPREVIEW=0x7c54;
	public static final int FIRST=0x7c55;
	public static final int LAST=0x7c56;
	public static final int INS=0x7c57;
	public static final int OVR=0x7c58;
	public static final int BOXED=0x7c59;
	public static final int CAP=0x7c5a;
	public static final int COLUMN=0x7c5c;
	public static final int CURSOR=0x7c5d;
	public static final int DEFAULT=0x7c5e;
	public static final int DISABLE=0x7c5f;
	public static final int DROP=0x7c60;
	public static final int FILL=0x7c61;
	public static final int FROM=0x7c62;
	public static final int FULL=0x7c63;
	public static final int GRAY=0x7c64;
	public static final int HIDE=0x7c65;
	public static final int HLP=0x7c66;
	public static final int HSCROLL=0x7c67;
	public static final int ICON=0x7c68;
	public static final int ICONIZE=0x7c69;
	public static final int IMM=0x7c6a;
	public static final int KEY=0x7c6b;
	public static final int LANDSCAPE=0x7c6c;
	public static final int MARK=0x7c6d;
	public static final int MASK=0x7c6e;
	public static final int MAXIMIZE=0x7c6f;
	public static final int MDI=0x7c70;
	public static final int META=0x7c71;
	public static final int MODAL=0x7c72;
	public static final int MSG=0x7c73;
	public static final int NOBAR=0x7c74;
	public static final int NOMERGE=0x7c75;
	public static final int PAGEAFTER=0x7c77;
	public static final int PAGEAFTERNUM=0x7c77;
	public static final int PAGEBEFORE=0x7c78;
	public static final int PAGEBEFORENUM=0x7c79;
	public static final int PASSWORD=0x7c7a;
	public static final int READONLY=0x7c7b;
	public static final int REQ=0x7c7c;
	public static final int RESET=0x7c7d;
	public static final int ROUND=0x7c7e;
	public static final int SCROLL=0x7c7f;
	public static final int SEPARATE=0x7c80;
	public static final int SKIP=0x7c81;
	public static final int STD=0x7c82;
	public static final int STEP=0x7c83;
	public static final int SYSTEM=0x7c84;
	public static final int FORMAT=0x7c85;
	public static final int TIMER=0x7c86;
	public static final int CHECK=0x7c87;
	public static final int TRN=0x7c88;
	public static final int UPR=0x7c89;
	public static final int VSCROLL=0x7c8b;
	public static final int WITHNEXT=0x7c8c;
	public static final int WITHPRIOR=0x7c8d;
	public static final int ITEMS=0x7c8e;
	public static final int SELECTED=0x7c8f;
	public static final int SELSTART=0x7c8f;
	public static final int SELEND=0x7c90;
	public static final int AUTO=0x7c91;
	public static final int TOOLBOX=0x7c92;
	public static final int PALETTE=0x7c93;
	public static final int IMAGEBITS=0x7c94;
	public static final int THREAD=0x7c95;
	public static final int HANDLE=0x7c96;
	public static final int ACTIVE=0x7c97;
	public static final int VBXEVENT=0x7c98;
	public static final int FOLLOWS=0x7c99;
	public static final int ACCEPTALL=0x7c9a;
	public static final int TOUCHED=0x7c9b;
	public static final int VSCROLLPOS=0x7c9e;
	public static final int CLIPBITS=0x7c9f;
	public static final int TIP=0x7ca0;
	public static final int TOOLTIP=Prop.TIP;
	public static final int LFNSUPPORT=0x7ca5;
	public static final int PROGRESS=0x7ca6;
	public static final int VISIBLE=0x7ca7;
	public static final int ENABLED=0x7ca8;
	public static final int WIZARD=0x7ca9;
	public static final int CHOICEFEQ=0x7caa;
	public static final int CLIENTHANDLE=0x7cab;
	public static final int LINECOUNT=0x7cac;
	public static final int MINWIDTH=0x7cad;
	public static final int MINHEIGHT=0x7cae;
	public static final int MAXWIDTH=0x7caf;
	public static final int MAXHEIGHT=0x7cb0;
	public static final int NOTIPS=0x7cb1;
	public static final int TIPDELAY=0x7cb2;
	public static final int TIPDISPLAY=0x7cb3;
	public static final int WNDPROC=0x7cb4;
	public static final int CLIENTWNDPROC=0x7cb5;
	public static final int IMAGEBLOB=0x7cb6;
	public static final int SPREAD=0x7cb7;
	public static final int SIZE=0x7cb9;
	public static final int SCREENTEXT=0x7cba;
	public static final int HSCROLLPOS=0x7cbb;
	public static final int LAZYDISPLAY=0x7cbc;
	public static final int DEFERMOVE=0x7cbd;
	public static final int APPINSTANCE=0x7cbe;
	public static final int VALUE=0x7cbf;
	public static final int TRUEVALUE=0x7cbf;
	public static final int FALSEVALUE=0x7cc0;
	public static final int DDETIMEOUT=0x7cc1;
	public static final int TABROWS=0x7cc2;
	public static final int NUMTABS=0x7cc3;
	public static final int LIBVERSION=0x7cc4;
	public static final int EXEVERSION=0x7cc5;
	public static final int CREATE=0x7cc6;
	public static final int SAVEAS=0x7cc7;
	public static final int OPEN=0x7cc8;
	public static final int BLOB=0x7cc9;
	public static final int DOVERB=0x7cca;
	public static final int SIZEMODE=0x7ccb;
	public static final int SELECTINTERFACE=0x7ccc;
	public static final int ADDREF=0x7ccd;
	public static final int RELEASE=0x7cce;
	public static final int DEACTIVATE=0x7ccf;
	public static final int UPDATE=0x7cd0;
	public static final int PASTE=0x7cd1;
	public static final int REPORTEXCEPTION=0x7cd2;
	public static final int PASTELINK=0x7cd3;
	public static final int COPY=0x7cd4;
	public static final int CANPASTE=0x7cd5;
	public static final int CANPASTELINK=0x7cd6;
	public static final int WINDOWUI=0x7cd7;
	public static final int DESIGNMODE=0x7cd8;
	public static final int CTRL=0x7cd9;
	public static final int GRABHANDLES=0x7cda;
	public static final int OLE=0x7cdb;
	public static final int ISRADIO=0x7cdc;
	public static final int LASTEVENTNAME=0x7cdd;
	public static final int CLSID=0x7cde;
	public static final int PROGID=0x7cdf;
	public static final int BEVELSTYLE=0x7ce0;
	public static final int JOIN=0x7ce2;
	public static final int NOSHEET=0x7ce3;
	public static final int BEVEL=0x7ce4;
	public static final int BEVELOUTER=0x7ce4;
	public static final int BEVELINNER=0x7ce5;
	public static final int LINEWIDTH=0x7ce7;
	public static final int ANGLE=0x7ce9;
	public static final int AUTOSIZE=0x7cea;
	public static final int CLIP=0x7ceb;
	public static final int STRETCH=0x7cec;
	public static final int ZOOM=0x7ced;
	public static final int COMPATIBILITY=0x7cee;
	public static final int DESIGN=0x7cef;
	public static final int DOCUMENT=0x7cf0;
	public static final int LINK=0x7cf1;
	public static final int CREATEFROMFILE=Prop.DOCUMENT;
	public static final int CREATELINKTOFILE=Prop.LINK;
	public static final int ALIGN=0x7cf2;
	public static final int CANCEL=0x7cf3;
	public static final int TEXTALIGN=0x7cf4;
	public static final int OBJECT=0x7cf5;
	public static final int LICENSE=0x7cf6;
	public static final int LANGUAGE=0x7cf8;
	public static final int COLOR=0x7cfa;
	public static final int BACKGROUND=0x7cfa;
	public static final int FILLCOLOR=0x7cfa;
	public static final int SELECTEDCOLOR=0x7cfb;
	public static final int SELECTEDFILLCOLOR=0x7cfc;
	public static final int LINEHEIGHT=0x7cfd;
	public static final int DROPWIDTH=0x7cfe;
	public static final int ALWAYSDROP=0x7cff;
	public static final int UP=0x7a00;
	public static final int DOWN=0x7a01;
	public static final int UPSIDEDOWN=0x7a02;
	public static final int HEADERHEIGHT=0x7a03;
	public static final int CHECKED=0x7a04;
	public static final int AUTOPAPER=0x7a05;
	public static final int SINGLE=0x7a06;
	public static final int PARENT=0x7a07;
	public static final int REPEAT=0x7a08;
	public static final int EVENTSWAITING=0x7a09;
	public static final int DDEMODE=0x7a0a;
	public static final int THREADING=0x7a0b;
	public static final int TEMPNAMEFUNC=0x7a0c;
	public static final int DELAY=0x7a0f;
	public static final int BREAKVAR=0x7a10;
	public static final int USE=0x7a10;
	public static final int FEQ=0x7a11;
	public static final int LISTFEQ=0x7a12;
	public static final int BUTTONFEQ=0x7a13;
	public static final int FLAT=0x7a14;
	public static final int WALLPAPER=0x7a15;
	public static final int TILED=0x7a16;
	public static final int CENTERED=0x7a17;
	public static final int TILEIMAGE=Prop.TILED;
	public static final int CENTERIMAGE=Prop.CENTERED;
	public static final int CHILDINDEX=0x7a18;
	public static final int INTOOLBAR=0x7a19;
	public static final int PRINTMODE=0x7a1a;
	public static final int REJECTCODE=0x7a1b;
	public static final int VLBPROC=0x7a1c;
	public static final int VLBVAL=0x7a1d;
	public static final int TEMPIMAGE=0x7a1e;
	public static final int TEMPPATH=0x7a20;
	public static final int TEMPPAGEPATH=0x7a20;
	public static final int TEMPIMAGEPATH=0x7a21;
	public static final int LIBHOOK=0x7a30;
	public static final int COLORDIALOGHOOK=0x7a30;
	public static final int FILEDIALOGHOOK=0x7a31;
	public static final int FONTDIALOGHOOK=0x7a32;
	public static final int PRINTERDIALOGHOOK=0x7a33;
	public static final int HALTHOOK=0x7a34;
	public static final int MESSAGEHOOK=0x7a35;
	public static final int STOPHOOK=0x7a36;
	public static final int ASSERTHOOK=0x7a37;
	public static final int FATALERRORHOOK=0x7a38;
	public static final int CHARSET=0x7a39;
	public static final int FONTCHARSET=0x7a3a;
	public static final int SYSTEMPROPHOOK=0x7a3b;
	public static final int ASSERTHOOK2=0x7a3c;
	public static final int INITASTRINGHOOK=0x7a3d;
	public static final int NOWIDTH=0x7a40;
	public static final int NOHEIGHT=0x7a41;
	public static final int NEXTPAGENO=0x7a42;
	public static final int XORIGIN=0x7a43;
	public static final int YORIGIN=0x7a44;
	public static final int TARGET=0x7a45;
	public static final int TOGETHER=0x7a46;
	public static final int DOCK=0x7a47;
	public static final int DOCKED=0x7a48;
	public static final int BROKENTABS=0x7a49;
	public static final int IMAGEINSTANCE=0x7a4a;
	public static final int GLOBALHELP=0x7a4b;
	public static final int BUFFER=0x7a4c;
	public static final int CLIENTX=0x7a4d;
	public static final int CLIENTY=0x7a4e;
	public static final int CLIENTWIDTH=0x7a4f;
	public static final int CLIENTHEIGHT=0x7a50;
	public static final int USEADDRESS=0x7a52;
	public static final int FLUSHPAGENUMFUNC=0x7a54;
	public static final int STATUS=0x7d00;
	public static final int STATUSTEXT=0x7d01;
	public static final int DRAGID=0x7d02;
	public static final int DROPID=0x7d03;
	public static final int VBXEVENTARG=0x7d04;
	public static final int EDIT=0x7d05;
	public static final int ALRT=0x7d06;
	public static final int ICONLIST=0x7d07;
	public static final int LINE=0x7d08;
	public static final int TALLY=0x7d09;
	public static final int CHILD=0x7d0a;
	public static final int NEXTFIELD=0x7d0b;
	public static final int SNAPWIDTH=0x7d0c;
	public static final int SNAPHEIGHT=0x7d0d;
	public static final int CURRENTKEY=0x7300;
	public static final int LOGOUT=0x7301;
	public static final int LOG=0x7302;
	public static final int PROFILE=0x7303;
	public static final int DETAILS=0x7329;
	public static final int WATCHED=0x7304;
	public static final int HELD=0x7305;
	public static final int PROGRESSEVENTS=0x7306;
	public static final int COMPLETED=0x7307;
	public static final int DRIVER=0x730d;
	public static final int DRIVERLOGSOUTALIAS=0x730e;
	public static final int KEYS=0x730f;
	public static final int BLOBS=0x7310;
	public static final int MEMOS=0x7311;
	public static final int FIELDS=0x7312;
	public static final int ENCRYPT=0x7313;
	public static final int DRIVERSTRING=0x7314;
	public static final int OWNER=0x7315;
	public static final int NAME=0x7316;
	public static final int LABEL=0x7317;
	public static final int OEM=0x7318;
	public static final int RECLAIM=0x7319;
	public static final int SQLDRIVER=0x7344;
	public static final int FILESIZE=0x7347;
	public static final int SUPPORTSOP=0x7348;
	public static final int SUPPORTSTYPE=0x7349;
	public static final int RECORD=0x734b;
	public static final int COMPONENTS=0x731a;
	public static final int DUP=0x731b;
	public static final int OPT=0x731c;
	public static final int NOCASE=0x731d;
	public static final int PRIMARY=0x731e;
	public static final int FIELD=0x731f;
	public static final int ASCENDING=0x7320;
	public static final int BINARY=0x7321;
	public static final int PLACES=0x7322;
	public static final int DIM=0x7323;
	public static final int OVER=0x7324;
	public static final int ORDER=0x7ce6;
	public static final int FILTER=0x7cb8;
	public static final int JOINEXPRESSION=0x7212;
	public static final int FILES=0x7325;
	public static final int FILE=0x7326;
	public static final int PROFILEINTOFILES=0x7327;
	public static final int INNER=0x7328;
	public static final int FIELDSFILE=0x734a;
	public static final int SQL=0x7200;
	public static final int ORDERALLTABLES=0x7211;
	public static final int SQLFILTER=0x7221;
	public static final int LOGFILE=0x7222;
	public static final int WHERE=0x7223;
	public static final int FETCHSIZE=0x7341;
	public static final int ALIAS=0x7244;
	public static final int DISCONNECT=0x7245;
	public static final int SQLORDER=0x7248;
	public static final int SQLJOINEXPRESSION=0x7249;
	public static final int HINT=0x7241;
	public static final int APPENDBUFFER=0x7342;
	public static final int CONNECTSTRING=0x7201;
	public static final int LOGINTIMEOUT=0x7202;
	public static final int HENV=0x7203;
	public static final int HDBC=0x7204;
	public static final int HSTMT=0x7205;
	public static final int ORDERINSELECT=0x7206;
	public static final int QUOTESTRING=0x7243;
	public static final int LOGONSCREEN=0x7246;
	public static final int ALWAYSREBIND=0x7247;
	public static final int DBMSVER=0x724a;
	public static final int ISOLATIONLEVEL=0x724b;
	public static final int MAXSTATEMENTS=0x724c;
	public static final int STMTATTR=0x724d;
	public static final int LOGOUTISOLATIONLEVEL=0x724e;
	public static final int FULLBUILD=0x7230;
	public static final int POSITIONBLOCK=0x7343;
	public static final int PAGELEVELLOCKING=0x734d;

	private static Map<Integer,String> propStrings=new HashMap<Integer, String>();
	private static Map<String,Integer> propIDs=new HashMap<String, Integer>();
	
	public static String getPropString(int prop)
	{
	    String s = propStrings.get(prop);
	    if (s==null) s = Integer.toHexString(prop)+"h";
	    return s;
	}

	public static int getPropID(String s)
	{
		Integer i = propIDs.get(s.toLowerCase());
		if (i==null) return -1;
		return i;
	}
	
	public static String getPropStringOrNull(int prop)
	{
	    return propStrings.get(prop);
	}
	
	static {
        put(TEXT,"TEXT");
        put(TYPE,"TYPE");
        put(AT,"AT");
        put(XPOS,"XPOS");
        put(YPOS,"YPOS");
        put(WIDTH,"WIDTH");
        put(HEIGHT,"HEIGHT");
        put(CENTER,"CENTER");
        put(CENTEROFFSET,"CENTEROFFSET");
        put(LEFT,"LEFT");
        put(LEFTOFFSET,"LEFTOFFSET");
        put(DECIMAL,"DECIMAL");
        put(DECIMALOFFSET,"DECIMALOFFSET");
        put(RIGHT,"RIGHT");
        put(RIGHTOFFSET,"RIGHTOFFSET");
        put(ABOVE,"ABOVE");
        put(ABOVESIZE,"ABOVESIZE");
        put(BELOW,"BELOW");
        put(BELOWSIZE,"BELOWSIZE");
        put(CLASS,"CLASS");
        put(VBXFILE,"VBXFILE");
        put(VBXNAME,"VBXNAME");
        put(FONT,"FONT");
        put(FONTNAME,"FONTNAME");
        put(FONTSIZE,"FONTSIZE");
        put(FONTCOLOR,"FONTCOLOR");
        put(FONTSTYLE,"FONTSTYLE");
        put(TIPSFONT,"TIPSFONT");
        put(STATUSFONT,"STATUSFONT");
        put(RANGE,"RANGE");
        put(RANGELOW,"RANGELOW");
        put(RANGEHIGH,"RANGEHIGH");
        put(VCR,"VCR");
        put(VCRFEQ,"VCRFEQ");
        put(DOUBLE,"DOUBLE");
        put(RESIZE,"RESIZE");
        put(NOFRAME,"NOFRAME");
        put(MM,"MM");
        put(THOUS,"THOUS");
        put(POINTS,"POINTS");
        put(PIXELS,"PIXELS");
        put(SUM,"SUM");
        put(AVE,"AVE");
        put(MAX,"MAX");
        put(MIN,"MIN");
        put(CNT,"CNT");
        put(PAGENO,"PAGENO");
        put(PAGE,"PAGE");
        put(ABSOLUTE,"ABSOLUTE");
        put(ALONE,"ALONE");
        put(PREVIEW,"PREVIEW");
        put(FLUSHPREVIEW,"FLUSHPREVIEW");
        put(FIRST,"FIRST");
        put(LAST,"LAST");
        put(INS,"INS");
        put(OVR,"OVR");
        put(BOXED,"BOXED");
        put(CAP,"CAP");
        put(COLUMN,"COLUMN");
        put(CURSOR,"CURSOR");
        put(DEFAULT,"DEFAULT");
        put(DISABLE,"DISABLE");
        put(DROP,"DROP");
        put(FILL,"FILL");
        put(FROM,"FROM");
        put(FULL,"FULL");
        put(GRAY,"GRAY");
        put(HIDE,"HIDE");
        put(HLP,"HLP");
        put(HSCROLL,"HSCROLL");
        put(ICON,"ICON");
        put(ICONIZE,"ICONIZE");
        put(IMM,"IMM");
        put(KEY,"KEY");
        put(LANDSCAPE,"LANDSCAPE");
        put(MARK,"MARK");
        put(MASK,"MASK");
        put(MAXIMIZE,"MAXIMIZE");
        put(MDI,"MDI");
        put(META,"META");
        put(MODAL,"MODAL");
        put(MSG,"MSG");
        put(NOBAR,"NOBAR");
        put(NOMERGE,"NOMERGE");
        put(PAGEAFTER,"PAGEAFTER");
        put(PAGEAFTERNUM,"PAGEAFTERNUM");
        put(PAGEBEFORE,"PAGEBEFORE");
        put(PAGEBEFORENUM,"PAGEBEFORENUM");
        put(PASSWORD,"PASSWORD");
        put(READONLY,"READONLY");
        put(REQ,"REQ");
        put(RESET,"RESET");
        put(ROUND,"ROUND");
        put(SCROLL,"SCROLL");
        put(SEPARATE,"SEPARATE");
        put(SKIP,"SKIP");
        put(STD,"STD");
        put(STEP,"STEP");
        put(SYSTEM,"SYSTEM");
        put(FORMAT,"FORMAT");
        put(TIMER,"TIMER");
        put(CHECK,"CHECK");
        put(TRN,"TRN");
        put(UPR,"UPR");
        put(VSCROLL,"VSCROLL");
        put(WITHNEXT,"WITHNEXT");
        put(WITHPRIOR,"WITHPRIOR");
        put(ITEMS,"ITEMS");
        put(SELECTED,"SELECTED");
        put(SELSTART,"SELSTART");
        put(SELEND,"SELEND");
        put(AUTO,"AUTO");
        put(TOOLBOX,"TOOLBOX");
        put(PALETTE,"PALETTE");
        put(IMAGEBITS,"IMAGEBITS");
        put(THREAD,"THREAD");
        put(HANDLE,"HANDLE");
        put(ACTIVE,"ACTIVE");
        put(VBXEVENT,"VBXEVENT");
        put(FOLLOWS,"FOLLOWS");
        put(ACCEPTALL,"ACCEPTALL");
        put(TOUCHED,"TOUCHED");
        put(VSCROLLPOS,"VSCROLLPOS");
        put(CLIPBITS,"CLIPBITS");
        put(TIP,"TIP");
        put(TOOLTIP,"TOOLTIP");
        put(LFNSUPPORT,"LFNSUPPORT");
        put(PROGRESS,"PROGRESS");
        put(VISIBLE,"VISIBLE");
        put(ENABLED,"ENABLED");
        put(WIZARD,"WIZARD");
        put(CHOICEFEQ,"CHOICEFEQ");
        put(CLIENTHANDLE,"CLIENTHANDLE");
        put(LINECOUNT,"LINECOUNT");
        put(MINWIDTH,"MINWIDTH");
        put(MINHEIGHT,"MINHEIGHT");
        put(MAXWIDTH,"MAXWIDTH");
        put(MAXHEIGHT,"MAXHEIGHT");
        put(NOTIPS,"NOTIPS");
        put(TIPDELAY,"TIPDELAY");
        put(TIPDISPLAY,"TIPDISPLAY");
        put(WNDPROC,"WNDPROC");
        put(CLIENTWNDPROC,"CLIENTWNDPROC");
        put(IMAGEBLOB,"IMAGEBLOB");
        put(SPREAD,"SPREAD");
        put(SIZE,"SIZE");
        put(SCREENTEXT,"SCREENTEXT");
        put(HSCROLLPOS,"HSCROLLPOS");
        put(LAZYDISPLAY,"LAZYDISPLAY");
        put(DEFERMOVE,"DEFERMOVE");
        put(APPINSTANCE,"APPINSTANCE");
        put(VALUE,"VALUE");
        put(TRUEVALUE,"TRUEVALUE");
        put(FALSEVALUE,"FALSEVALUE");
        put(DDETIMEOUT,"DDETIMEOUT");
        put(TABROWS,"TABROWS");
        put(NUMTABS,"NUMTABS");
        put(LIBVERSION,"LIBVERSION");
        put(EXEVERSION,"EXEVERSION");
        put(CREATE,"CREATE");
        put(SAVEAS,"SAVEAS");
        put(OPEN,"OPEN");
        put(BLOB,"BLOB");
        put(DOVERB,"DOVERB");
        put(SIZEMODE,"SIZEMODE");
        put(SELECTINTERFACE,"SELECTINTERFACE");
        put(ADDREF,"ADDREF");
        put(RELEASE,"RELEASE");
        put(DEACTIVATE,"DEACTIVATE");
        put(UPDATE,"UPDATE");
        put(PASTE,"PASTE");
        put(REPORTEXCEPTION,"REPORTEXCEPTION");
        put(PASTELINK,"PASTELINK");
        put(COPY,"COPY");
        put(CANPASTE,"CANPASTE");
        put(CANPASTELINK,"CANPASTELINK");
        put(WINDOWUI,"WINDOWUI");
        put(DESIGNMODE,"DESIGNMODE");
        put(CTRL,"CTRL");
        put(GRABHANDLES,"GRABHANDLES");
        put(OLE,"OLE");
        put(ISRADIO,"ISRADIO");
        put(LASTEVENTNAME,"LASTEVENTNAME");
        put(CLSID,"CLSID");
        put(PROGID,"PROGID");
        put(BEVELSTYLE,"BEVELSTYLE");
        put(JOIN,"JOIN");
        put(NOSHEET,"NOSHEET");
        put(BEVEL,"BEVEL");
        put(BEVELOUTER,"BEVELOUTER");
        put(BEVELINNER,"BEVELINNER");
        put(LINEWIDTH,"LINEWIDTH");
        put(ANGLE,"ANGLE");
        put(AUTOSIZE,"AUTOSIZE");
        put(CLIP,"CLIP");
        put(STRETCH,"STRETCH");
        put(ZOOM,"ZOOM");
        put(COMPATIBILITY,"COMPATIBILITY");
        put(DESIGN,"DESIGN");
        put(DOCUMENT,"DOCUMENT");
        put(LINK,"LINK");
        put(CREATEFROMFILE,"CREATEFROMFILE");
        put(CREATELINKTOFILE,"CREATELINKTOFILE");
        put(ALIGN,"ALIGN");
        put(CANCEL,"CANCEL");
        put(TEXTALIGN,"TEXTALIGN");
        put(OBJECT,"OBJECT");
        put(LICENSE,"LICENSE");
        put(LANGUAGE,"LANGUAGE");
        put(COLOR,"COLOR");
        put(BACKGROUND,"BACKGROUND");
        put(FILLCOLOR,"FILLCOLOR");
        put(SELECTEDCOLOR,"SELECTEDCOLOR");
        put(SELECTEDFILLCOLOR,"SELECTEDFILLCOLOR");
        put(LINEHEIGHT,"LINEHEIGHT");
        put(DROPWIDTH,"DROPWIDTH");
        put(ALWAYSDROP,"ALWAYSDROP");
        put(UP,"UP");
        put(DOWN,"DOWN");
        put(UPSIDEDOWN,"UPSIDEDOWN");
        put(HEADERHEIGHT,"HEADERHEIGHT");
        put(CHECKED,"CHECKED");
        put(AUTOPAPER,"AUTOPAPER");
        put(SINGLE,"SINGLE");
        put(PARENT,"PARENT");
        put(REPEAT,"REPEAT");
        put(EVENTSWAITING,"EVENTSWAITING");
        put(DDEMODE,"DDEMODE");
        put(THREADING,"THREADING");
        put(TEMPNAMEFUNC,"TEMPNAMEFUNC");
        put(DELAY,"DELAY");
        put(BREAKVAR,"BREAKVAR");
        put(USE,"USE");
        put(FEQ,"FEQ");
        put(LISTFEQ,"LISTFEQ");
        put(BUTTONFEQ,"BUTTONFEQ");
        put(FLAT,"FLAT");
        put(WALLPAPER,"WALLPAPER");
        put(TILED,"TILED");
        put(CENTERED,"CENTERED");
        put(TILEIMAGE,"TILEIMAGE");
        put(CENTERIMAGE,"CENTERIMAGE");
        put(CHILDINDEX,"CHILDINDEX");
        put(INTOOLBAR,"INTOOLBAR");
        put(PRINTMODE,"PRINTMODE");
        put(REJECTCODE,"REJECTCODE");
        put(VLBPROC,"VLBPROC");
        put(VLBVAL,"VLBVAL");
        put(TEMPIMAGE,"TEMPIMAGE");
        put(TEMPPATH,"TEMPPATH");
        put(TEMPPAGEPATH,"TEMPPAGEPATH");
        put(TEMPIMAGEPATH,"TEMPIMAGEPATH");
        put(LIBHOOK,"LIBHOOK");
        put(COLORDIALOGHOOK,"COLORDIALOGHOOK");
        put(FILEDIALOGHOOK,"FILEDIALOGHOOK");
        put(FONTDIALOGHOOK,"FONTDIALOGHOOK");
        put(PRINTERDIALOGHOOK,"PRINTERDIALOGHOOK");
        put(HALTHOOK,"HALTHOOK");
        put(MESSAGEHOOK,"MESSAGEHOOK");
        put(STOPHOOK,"STOPHOOK");
        put(ASSERTHOOK,"ASSERTHOOK");
        put(FATALERRORHOOK,"FATALERRORHOOK");
        put(CHARSET,"CHARSET");
        put(FONTCHARSET,"FONTCHARSET");
        put(SYSTEMPROPHOOK,"SYSTEMPROPHOOK");
        put(ASSERTHOOK2,"ASSERTHOOK2");
        put(INITASTRINGHOOK,"INITASTRINGHOOK");
        put(NOWIDTH,"NOWIDTH");
        put(NOHEIGHT,"NOHEIGHT");
        put(NEXTPAGENO,"NEXTPAGENO");
        put(XORIGIN,"XORIGIN");
        put(YORIGIN,"YORIGIN");
        put(TARGET,"TARGET");
        put(TOGETHER,"TOGETHER");
        put(DOCK,"DOCK");
        put(DOCKED,"DOCKED");
        put(BROKENTABS,"BROKENTABS");
        put(IMAGEINSTANCE,"IMAGEINSTANCE");
        put(GLOBALHELP,"GLOBALHELP");
        put(BUFFER,"BUFFER");
        put(CLIENTX,"CLIENTX");
        put(CLIENTY,"CLIENTY");
        put(CLIENTWIDTH,"CLIENTWIDTH");
        put(CLIENTHEIGHT,"CLIENTHEIGHT");
        put(USEADDRESS,"USEADDRESS");
        put(FLUSHPAGENUMFUNC,"FLUSHPAGENUMFUNC");
        put(STATUS,"STATUS");
        put(STATUSTEXT,"STATUSTEXT");
        put(DRAGID,"DRAGID");
        put(DROPID,"DROPID");
        put(VBXEVENTARG,"VBXEVENTARG");
        put(EDIT,"EDIT");
        put(ALRT,"ALRT");
        put(ICONLIST,"ICONLIST");
        put(LINE,"LINE");
        put(TALLY,"TALLY");
        put(CHILD,"CHILD");
        put(NEXTFIELD,"NEXTFIELD");
        put(SNAPWIDTH,"SNAPWIDTH");
        put(SNAPHEIGHT,"SNAPHEIGHT");
        put(CURRENTKEY,"CURRENTKEY");
        put(LOGOUT,"LOGOUT");
        put(LOG,"LOG");
        put(PROFILE,"PROFILE");
        put(DETAILS,"DETAILS");
        put(WATCHED,"WATCHED");
        put(HELD,"HELD");
        put(PROGRESSEVENTS,"PROGRESSEVENTS");
        put(COMPLETED,"COMPLETED");
        put(DRIVER,"DRIVER");
        put(DRIVERLOGSOUTALIAS,"DRIVERLOGSOUTALIAS");
        put(KEYS,"KEYS");
        put(BLOBS,"BLOBS");
        put(MEMOS,"MEMOS");
        put(FIELDS,"FIELDS");
        put(ENCRYPT,"ENCRYPT");
        put(DRIVERSTRING,"DRIVERSTRING");
        put(OWNER,"OWNER");
        put(NAME,"NAME");
        put(LABEL,"LABEL");
        put(OEM,"OEM");
        put(RECLAIM,"RECLAIM");
        put(SQLDRIVER,"SQLDRIVER");
        put(FILESIZE,"FILESIZE");
        put(SUPPORTSOP,"SUPPORTSOP");
        put(SUPPORTSTYPE,"SUPPORTSTYPE");
        put(RECORD,"RECORD");
        put(COMPONENTS,"COMPONENTS");
        put(DUP,"DUP");
        put(OPT,"OPT");
        put(NOCASE,"NOCASE");
        put(PRIMARY,"PRIMARY");
        put(FIELD,"FIELD");
        put(ASCENDING,"ASCENDING");
        put(BINARY,"BINARY");
        put(PLACES,"PLACES");
        put(DIM,"DIM");
        put(OVER,"OVER");
        put(ORDER,"ORDER");
        put(FILTER,"FILTER");
        put(JOINEXPRESSION,"JOINEXPRESSION");
        put(FILES,"FILES");
        put(FILE,"FILE");
        put(PROFILEINTOFILES,"PROFILEINTOFILES");
        put(INNER,"INNER");
        put(FIELDSFILE,"FIELDSFILE");
        put(SQL,"SQL");
        put(ORDERALLTABLES,"ORDERALLTABLES");
        put(SQLFILTER,"SQLFILTER");
        put(LOGFILE,"LOGFILE");
        put(WHERE,"WHERE");
        put(FETCHSIZE,"FETCHSIZE");
        put(ALIAS,"ALIAS");
        put(DISCONNECT,"DISCONNECT");
        put(SQLORDER,"SQLORDER");
        put(SQLJOINEXPRESSION,"SQLJOINEXPRESSION");
        put(HINT,"HINT");
        put(APPENDBUFFER,"APPENDBUFFER");
        put(CONNECTSTRING,"CONNECTSTRING");
        put(LOGINTIMEOUT,"LOGINTIMEOUT");
        put(HENV,"HENV");
        put(HDBC,"HDBC");
        put(HSTMT,"HSTMT");
        put(ORDERINSELECT,"ORDERINSELECT");
        put(QUOTESTRING,"QUOTESTRING");
        put(LOGONSCREEN,"LOGONSCREEN");
        put(ALWAYSREBIND,"ALWAYSREBIND");
        put(DBMSVER,"DBMSVER");
        put(ISOLATIONLEVEL,"ISOLATIONLEVEL");
        put(MAXSTATEMENTS,"MAXSTATEMENTS");
        put(STMTATTR,"STMTATTR");
        put(LOGOUTISOLATIONLEVEL,"LOGOUTISOLATIONLEVEL");
        put(FULLBUILD,"FULLBUILD");
        put(POSITIONBLOCK,"POSITIONBLOCK");
        put(PAGELEVELLOCKING,"PAGELEVELLOCKING");	    
	}
	
	private static void put(int id,String value)
	{
		propStrings.put(id,value);
		propIDs.put(value.toLowerCase(),id);
	}
	
}
