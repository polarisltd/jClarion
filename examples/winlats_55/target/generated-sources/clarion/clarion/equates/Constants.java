package clarion.equates;

@SuppressWarnings("all")
public class Constants
{
	public static final int FALSE=0;
	public static final int TRUE=1;
	public static final int _NOPOS=0x8000;
	public static final int TPSREADONLY=1;
	public static final int INSERTRECORD=1;
	public static final int CHANGERECORD=2;
	public static final int DELETERECORD=3;
	public static final int SELECTRECORD=4;
	public static final int REQUESTCOMPLETED=1;
	public static final int REQUESTCANCELLED=2;
	public static final int READONLY=0x0;
	public static final int WRITEONLY=0x1;
	public static final int READWRITE=0x2;
	public static final int ANYACCESS=0x0;
	public static final int DENYALL=0x10;
	public static final int DENYWRITE=0x20;
	public static final int DENYREAD=0x30;
	public static final int DENYNONE=0x40;
	public static final int TBARBRWFIRST=2000;
	public static final int TBARBRWINSERT=Constants.TBARBRWFIRST;
	public static final int TBARBRWCHANGE=Constants.TBARBRWFIRST+1;
	public static final int TBARBRWDELETE=Constants.TBARBRWFIRST+2;
	public static final int TBARBRWSELECT=Constants.TBARBRWFIRST+3;
	public static final int TBARBRWBOTTOM=Constants.TBARBRWFIRST+4;
	public static final int TBARBRWTOP=Constants.TBARBRWFIRST+5;
	public static final int TBARBRWPAGEDOWN=Constants.TBARBRWFIRST+6;
	public static final int TBARBRWPAGEUP=Constants.TBARBRWFIRST+7;
	public static final int TBARBRWDOWN=Constants.TBARBRWFIRST+8;
	public static final int TBARBRWUP=Constants.TBARBRWFIRST+9;
	public static final int TBARBRWLOCATE=Constants.TBARBRWFIRST+10;
	public static final int TBARBRWHISTORY=Constants.TBARBRWFIRST+11;
	public static final int TBARBRWHELP=Constants.TBARBRWFIRST+12;
	public static final int TBARBRWLAST=Constants.TBARBRWHELP;
	public static final int VCRFORWARD=Constants.TBARBRWDOWN;
	public static final int VCRBACKWARD=Constants.TBARBRWUP;
	public static final int VCRPAGEFORWARD=Constants.TBARBRWPAGEDOWN;
	public static final int VCRPAGEBACKWARD=Constants.TBARBRWPAGEUP;
	public static final int VCRFIRST=Constants.TBARBRWTOP;
	public static final int VCRLAST=Constants.TBARBRWBOTTOM;
	public static final int VCRINSERT=Constants.TBARBRWINSERT;
	public static final int VCRNONE=0;
	public static final int FORMMODE=1;
	public static final int BROWSEMODE=2;
	public static final int TREEMODE=3;
	public static final int LOCATEONPOSITION=1;
	public static final int LOCATEONVALUE=2;
	public static final int LOCATEONEDIT=3;
	public static final int FILLBACKWARD=1;
	public static final int FILLFORWARD=2;
	public static final int REFRESHONPOSITION=1;
	public static final int REFRESHONQUEUE=2;
	public static final int REFRESHONTOP=3;
	public static final int REFRESHONBOTTOM=4;
	public static final int REFRESHONCURRENT=5;
	public static final int _KEYCODESPRESENT_=1;
	public static final int KEY0=0x30;
	public static final int KEY1=0x31;
	public static final int KEY2=0x32;
	public static final int KEY3=0x33;
	public static final int KEY4=0x34;
	public static final int KEY5=0x35;
	public static final int KEY6=0x36;
	public static final int KEY7=0x37;
	public static final int KEY8=0x38;
	public static final int KEY9=0x39;
	public static final int AKEY=0x41;
	public static final int BKEY=0x42;
	public static final int CKEY=0x43;
	public static final int DKEY=0x44;
	public static final int EKEY=0x45;
	public static final int FKEY=0x46;
	public static final int GKEY=0x47;
	public static final int HKEY=0x48;
	public static final int IKEY=0x49;
	public static final int JKEY=0x4a;
	public static final int KKEY=0x4b;
	public static final int LKEY=0x4c;
	public static final int MKEY=0x4d;
	public static final int NKEY=0x4e;
	public static final int OKEY=0x4f;
	public static final int PKEY=0x50;
	public static final int QKEY=0x51;
	public static final int RKEY=0x52;
	public static final int SKEY=0x53;
	public static final int TKEY=0x54;
	public static final int UKEY=0x55;
	public static final int VKEY=0x56;
	public static final int WKEY=0x57;
	public static final int XKEY=0x58;
	public static final int YKEY=0x59;
	public static final int ZKEY=0x5a;
	public static final int F1KEY=0x70;
	public static final int F2KEY=0x71;
	public static final int F3KEY=0x72;
	public static final int F4KEY=0x73;
	public static final int F5KEY=0x74;
	public static final int F6KEY=0x75;
	public static final int F7KEY=0x76;
	public static final int F8KEY=0x77;
	public static final int F9KEY=0x78;
	public static final int F10KEY=0x79;
	public static final int F11KEY=0x7a;
	public static final int F12KEY=0x7b;
	public static final int ASTKEY=0x6a;
	public static final int BSKEY=0x8;
	public static final int CAPSLOCKKEY=0x14;
	public static final int DECIMALKEY=0x6e;
	public static final int DELETEKEY=0x2e;
	public static final int DOWNKEY=0x28;
	public static final int ENDKEY=0x23;
	public static final int ENTERKEY=0xd;
	public static final int ESCKEY=0x1b;
	public static final int HOMEKEY=0x24;
	public static final int INSERTKEY=0x2d;
	public static final int LEFTKEY=0x25;
	public static final int MINUSKEY=0x6d;
	public static final int PAUSEKEY=0x13;
	public static final int PGDNKEY=0x22;
	public static final int PGUPKEY=0x21;
	public static final int PLUSKEY=0x6b;
	public static final int PRINTKEY=0x2c;
	public static final int RIGHTKEY=0x27;
	public static final int SLASHKEY=0x6f;
	public static final int SPACEKEY=0x20;
	public static final int TABKEY=0x9;
	public static final int UPKEY=0x26;
	public static final int KEYPAD0=0x60;
	public static final int KEYPAD1=0x61;
	public static final int KEYPAD2=0x62;
	public static final int KEYPAD3=0x63;
	public static final int KEYPAD4=0x64;
	public static final int KEYPAD5=0x65;
	public static final int KEYPAD6=0x66;
	public static final int KEYPAD7=0x67;
	public static final int KEYPAD8=0x68;
	public static final int KEYPAD9=0x69;
	public static final int MOUSELEFT=0x1;
	public static final int MOUSERIGHT=0x2;
	public static final int MOUSECENTER=0x3;
	public static final int MOUSELEFT2=0x5;
	public static final int MOUSERIGHT2=0x6;
	public static final int MOUSECENTER2=0x7;
	public static final int MOUSELEFTUP=0x81;
	public static final int MOUSERIGHTUP=0x82;
	public static final int MOUSECENTERUP=0x83;
	public static final int ALT0=0x430;
	public static final int ALT1=0x431;
	public static final int ALT2=0x432;
	public static final int ALT3=0x433;
	public static final int ALT4=0x434;
	public static final int ALT5=0x435;
	public static final int ALT6=0x436;
	public static final int ALT7=0x437;
	public static final int ALT8=0x438;
	public static final int ALT9=0x439;
	public static final int ALTA=0x441;
	public static final int ALTB=0x442;
	public static final int ALTC=0x443;
	public static final int ALTD=0x444;
	public static final int ALTE=0x445;
	public static final int ALTF=0x446;
	public static final int ALTG=0x447;
	public static final int ALTH=0x448;
	public static final int ALTI=0x449;
	public static final int ALTJ=0x44a;
	public static final int ALTK=0x44b;
	public static final int ALTL=0x44c;
	public static final int ALTM=0x44d;
	public static final int ALTN=0x44e;
	public static final int ALTO=0x44f;
	public static final int ALTP=0x450;
	public static final int ALTQ=0x451;
	public static final int ALTR=0x452;
	public static final int ALTS=0x453;
	public static final int ALTT=0x454;
	public static final int ALTU=0x455;
	public static final int ALTV=0x456;
	public static final int ALTW=0x457;
	public static final int ALTX=0x458;
	public static final int ALTY=0x459;
	public static final int ALTZ=0x45a;
	public static final int ALTF1=0x470;
	public static final int ALTF2=0x471;
	public static final int ALTF3=0x472;
	public static final int ALTF4=0x473;
	public static final int ALTF5=0x474;
	public static final int ALTF6=0x475;
	public static final int ALTF7=0x476;
	public static final int ALTF8=0x477;
	public static final int ALTF9=0x478;
	public static final int ALTF10=0x479;
	public static final int ALTF11=0x47a;
	public static final int ALTF12=0x47b;
	public static final int ALTAST=0x46a;
	public static final int ALTBS=0x408;
	public static final int ALTDECIMAL=0x46e;
	public static final int ALTDELETE=0x42e;
	public static final int ALTDOWN=0x428;
	public static final int ALTEND=0x423;
	public static final int ALTENTER=0x40d;
	public static final int ALTESC=0x41b;
	public static final int ALTHOME=0x424;
	public static final int ALTINSERT=0x42d;
	public static final int ALTLEFT=0x425;
	public static final int ALTMINUS=0x46d;
	public static final int ALTPAUSE=0x413;
	public static final int ALTPGDN=0x422;
	public static final int ALTPGUP=0x421;
	public static final int ALTPLUS=0x46b;
	public static final int ALTPRINT=0x42c;
	public static final int ALTRIGHT=0x427;
	public static final int ALTSLASH=0x46f;
	public static final int ALTSPACE=0x420;
	public static final int ALTTAB=0x409;
	public static final int ALTUP=0x426;
	public static final int ALTPAD0=0x460;
	public static final int ALTPAD1=0x461;
	public static final int ALTPAD2=0x462;
	public static final int ALTPAD3=0x463;
	public static final int ALTPAD4=0x464;
	public static final int ALTPAD5=0x465;
	public static final int ALTPAD6=0x466;
	public static final int ALTPAD7=0x467;
	public static final int ALTPAD8=0x468;
	public static final int ALTPAD9=0x469;
	public static final int ALTMOUSELEFT=0x401;
	public static final int ALTMOUSERIGHT=0x402;
	public static final int ALTMOUSECENTER=0x403;
	public static final int ALTMOUSELEFT2=0x405;
	public static final int ALTMOUSERIGHT2=0x406;
	public static final int ALTMOUSECENTER2=0x407;
	public static final int CTRL0=0x230;
	public static final int CTRL1=0x231;
	public static final int CTRL2=0x232;
	public static final int CTRL3=0x233;
	public static final int CTRL4=0x234;
	public static final int CTRL5=0x235;
	public static final int CTRL6=0x236;
	public static final int CTRL7=0x237;
	public static final int CTRL8=0x238;
	public static final int CTRL9=0x239;
	public static final int CTRLA=0x241;
	public static final int CTRLB=0x242;
	public static final int CTRLC=0x243;
	public static final int CTRLD=0x244;
	public static final int CTRLE=0x245;
	public static final int CTRLF=0x246;
	public static final int CTRLG=0x247;
	public static final int CTRLH=0x248;
	public static final int CTRLI=0x249;
	public static final int CTRLJ=0x24a;
	public static final int CTRLK=0x24b;
	public static final int CTRLL=0x24c;
	public static final int CTRLM=0x24d;
	public static final int CTRLN=0x24e;
	public static final int CTRLO=0x24f;
	public static final int CTRLP=0x250;
	public static final int CTRLQ=0x251;
	public static final int CTRLR=0x252;
	public static final int CTRLS=0x253;
	public static final int CTRLT=0x254;
	public static final int CTRLU=0x255;
	public static final int CTRLV=0x256;
	public static final int CTRLW=0x257;
	public static final int CTRLX=0x258;
	public static final int CTRLY=0x259;
	public static final int CTRLZ=0x25a;
	public static final int CTRLF1=0x270;
	public static final int CTRLF2=0x271;
	public static final int CTRLF3=0x272;
	public static final int CTRLF4=0x273;
	public static final int CTRLF5=0x274;
	public static final int CTRLF6=0x275;
	public static final int CTRLF7=0x276;
	public static final int CTRLF8=0x277;
	public static final int CTRLF9=0x278;
	public static final int CTRLF10=0x279;
	public static final int CTRLF11=0x27a;
	public static final int CTRLF12=0x27b;
	public static final int CTRLAST=0x26a;
	public static final int CTRLBS=0x208;
	public static final int CTRLDECIMAL=0x26e;
	public static final int CTRLDELETE=0x22e;
	public static final int CTRLDOWN=0x228;
	public static final int CTRLEND=0x223;
	public static final int CTRLENTER=0x20d;
	public static final int CTRLESC=0x21b;
	public static final int CTRLHOME=0x224;
	public static final int CTRLINSERT=0x22d;
	public static final int CTRLLEFT=0x225;
	public static final int CTRLMINUS=0x26d;
	public static final int CTRLPAUSE=0x213;
	public static final int CTRLPGDN=0x222;
	public static final int CTRLPGUP=0x221;
	public static final int CTRLPLUS=0x26b;
	public static final int CTRLPRINT=0x22c;
	public static final int CTRLRIGHT=0x227;
	public static final int CTRLSLASH=0x26f;
	public static final int CTRLSPACE=0x220;
	public static final int CTRLTAB=0x209;
	public static final int CTRLUP=0x226;
	public static final int CTRLPAD0=0x260;
	public static final int CTRLPAD1=0x261;
	public static final int CTRLPAD2=0x262;
	public static final int CTRLPAD3=0x263;
	public static final int CTRLPAD4=0x264;
	public static final int CTRLPAD5=0x265;
	public static final int CTRLPAD6=0x266;
	public static final int CTRLPAD7=0x267;
	public static final int CTRLPAD8=0x268;
	public static final int CTRLPAD9=0x269;
	public static final int CTRLMOUSELEFT=0x201;
	public static final int CTRLMOUSERIGHT=0x202;
	public static final int CTRLMOUSECENTER=0x203;
	public static final int CTRLMOUSELEFT2=0x205;
	public static final int CTRLMOUSERIGHT2=0x206;
	public static final int CTRLMOUSECENTER2=0x207;
	public static final int SHIFT0=0x130;
	public static final int SHIFT1=0x131;
	public static final int SHIFT2=0x132;
	public static final int SHIFT3=0x133;
	public static final int SHIFT4=0x134;
	public static final int SHIFT5=0x135;
	public static final int SHIFT6=0x136;
	public static final int SHIFT7=0x137;
	public static final int SHIFT8=0x138;
	public static final int SHIFT9=0x139;
	public static final int SHIFTA=0x141;
	public static final int SHIFTB=0x142;
	public static final int SHIFTC=0x143;
	public static final int SHIFTD=0x144;
	public static final int SHIFTE=0x145;
	public static final int SHIFTF=0x146;
	public static final int SHIFTG=0x147;
	public static final int SHIFTH=0x148;
	public static final int SHIFTI=0x149;
	public static final int SHIFTJ=0x14a;
	public static final int SHIFTK=0x14b;
	public static final int SHIFTL=0x14c;
	public static final int SHIFTM=0x14d;
	public static final int SHIFTN=0x14e;
	public static final int SHIFTO=0x14f;
	public static final int SHIFTP=0x150;
	public static final int SHIFTQ=0x151;
	public static final int SHIFTR=0x152;
	public static final int SHIFTS=0x153;
	public static final int SHIFTT=0x154;
	public static final int SHIFTU=0x155;
	public static final int SHIFTV=0x156;
	public static final int SHIFTW=0x157;
	public static final int SHIFTX=0x158;
	public static final int SHIFTY=0x159;
	public static final int SHIFTZ=0x15a;
	public static final int SHIFTF1=0x170;
	public static final int SHIFTF2=0x171;
	public static final int SHIFTF3=0x172;
	public static final int SHIFTF4=0x173;
	public static final int SHIFTF5=0x174;
	public static final int SHIFTF6=0x175;
	public static final int SHIFTF7=0x176;
	public static final int SHIFTF8=0x177;
	public static final int SHIFTF9=0x178;
	public static final int SHIFTF10=0x179;
	public static final int SHIFTF11=0x17a;
	public static final int SHIFTF12=0x17b;
	public static final int SHIFTAST=0x16a;
	public static final int SHIFTBS=0x108;
	public static final int SHIFTDECIMAL=0x16e;
	public static final int SHIFTDELETE=0x12e;
	public static final int SHIFTDOWN=0x128;
	public static final int SHIFTEND=0x123;
	public static final int SHIFTENTER=0x10d;
	public static final int SHIFTESC=0x11b;
	public static final int SHIFTHOME=0x124;
	public static final int SHIFTINSERT=0x12d;
	public static final int SHIFTLEFT=0x125;
	public static final int SHIFTMINUS=0x16d;
	public static final int SHIFTPAUSE=0x113;
	public static final int SHIFTPGDN=0x122;
	public static final int SHIFTPGUP=0x121;
	public static final int SHIFTPLUS=0x16b;
	public static final int SHIFTPRINT=0x12c;
	public static final int SHIFTRIGHT=0x127;
	public static final int SHIFTSLASH=0x16f;
	public static final int SHIFTSPACE=0x120;
	public static final int SHIFTTAB=0x109;
	public static final int SHIFTUP=0x126;
	public static final int SHIFTPAD0=0x160;
	public static final int SHIFTPAD1=0x161;
	public static final int SHIFTPAD2=0x162;
	public static final int SHIFTPAD3=0x163;
	public static final int SHIFTPAD4=0x164;
	public static final int SHIFTPAD5=0x165;
	public static final int SHIFTPAD6=0x166;
	public static final int SHIFTPAD7=0x167;
	public static final int SHIFTPAD8=0x168;
	public static final int SHIFTPAD9=0x169;
	public static final int SHIFTMOUSELEFT=0x101;
	public static final int SHIFTMOUSERIGHT=0x102;
	public static final int SHIFTMOUSECENTER=0x103;
	public static final int SHIFTMOUSELEFT2=0x105;
	public static final int SHIFTMOUSERIGHT2=0x106;
	public static final int SHIFTMOUSECENTER2=0x107;
	public static final int ALTSHIFT0=0x530;
	public static final int ALTSHIFT1=0x531;
	public static final int ALTSHIFT2=0x532;
	public static final int ALTSHIFT3=0x533;
	public static final int ALTSHIFT4=0x534;
	public static final int ALTSHIFT5=0x535;
	public static final int ALTSHIFT6=0x536;
	public static final int ALTSHIFT7=0x537;
	public static final int ALTSHIFT8=0x538;
	public static final int ALTSHIFT9=0x539;
	public static final int ALTSHIFTA=0x541;
	public static final int ALTSHIFTB=0x542;
	public static final int ALTSHIFTC=0x543;
	public static final int ALTSHIFTD=0x544;
	public static final int ALTSHIFTE=0x545;
	public static final int ALTSHIFTF=0x546;
	public static final int ALTSHIFTG=0x547;
	public static final int ALTSHIFTH=0x548;
	public static final int ALTSHIFTI=0x549;
	public static final int ALTSHIFTJ=0x54a;
	public static final int ALTSHIFTK=0x54b;
	public static final int ALTSHIFTL=0x54c;
	public static final int ALTSHIFTM=0x54d;
	public static final int ALTSHIFTN=0x54e;
	public static final int ALTSHIFTO=0x54f;
	public static final int ALTSHIFTP=0x550;
	public static final int ALTSHIFTQ=0x551;
	public static final int ALTSHIFTR=0x552;
	public static final int ALTSHIFTS=0x553;
	public static final int ALTSHIFTT=0x554;
	public static final int ALTSHIFTU=0x555;
	public static final int ALTSHIFTV=0x556;
	public static final int ALTSHIFTW=0x557;
	public static final int ALTSHIFTX=0x558;
	public static final int ALTSHIFTY=0x559;
	public static final int ALTSHIFTZ=0x55a;
	public static final int ALTSHIFTF1=0x570;
	public static final int ALTSHIFTF2=0x571;
	public static final int ALTSHIFTF3=0x572;
	public static final int ALTSHIFTF4=0x573;
	public static final int ALTSHIFTF5=0x574;
	public static final int ALTSHIFTF6=0x575;
	public static final int ALTSHIFTF7=0x576;
	public static final int ALTSHIFTF8=0x577;
	public static final int ALTSHIFTF9=0x578;
	public static final int ALTSHIFTF10=0x579;
	public static final int ALTSHIFTF11=0x57a;
	public static final int ALTSHIFTF12=0x57b;
	public static final int ALTSHIFTAST=0x56a;
	public static final int ALTSHIFTBS=0x508;
	public static final int ALTSHIFTDECIMAL=0x56e;
	public static final int ALTSHIFTDELETE=0x52e;
	public static final int ALTSHIFTDOWN=0x528;
	public static final int ALTSHIFTEND=0x523;
	public static final int ALTSHIFTENTER=0x50d;
	public static final int ALTSHIFTESC=0x51b;
	public static final int ALTSHIFTHOME=0x524;
	public static final int ALTSHIFTINSERT=0x52d;
	public static final int ALTSHIFTLEFT=0x525;
	public static final int ALTSHIFTMINUS=0x56d;
	public static final int ALTSHIFTPAUSE=0x513;
	public static final int ALTSHIFTPGDN=0x522;
	public static final int ALTSHIFTPGUP=0x521;
	public static final int ALTSHIFTPLUS=0x56b;
	public static final int ALTSHIFTPRINT=0x52c;
	public static final int ALTSHIFTRIGHT=0x527;
	public static final int ALTSHIFTSLASH=0x56f;
	public static final int ALTSHIFTSPACE=0x520;
	public static final int ALTSHIFTTAB=0x509;
	public static final int ALTSHIFTUP=0x526;
	public static final int ALTSHIFTPAD0=0x560;
	public static final int ALTSHIFTPAD1=0x561;
	public static final int ALTSHIFTPAD2=0x562;
	public static final int ALTSHIFTPAD3=0x563;
	public static final int ALTSHIFTPAD4=0x564;
	public static final int ALTSHIFTPAD5=0x565;
	public static final int ALTSHIFTPAD6=0x566;
	public static final int ALTSHIFTPAD7=0x567;
	public static final int ALTSHIFTPAD8=0x568;
	public static final int ALTSHIFTPAD9=0x569;
	public static final int ALTSHIFTMOUSELEFT=0x501;
	public static final int ALTSHIFTMOUSERIGHT=0x502;
	public static final int ALTSHIFTMOUSECENTER=0x503;
	public static final int ALTSHIFTMOUSELEFT2=0x505;
	public static final int ALTSHIFTMOUSERIGHT2=0x506;
	public static final int ALTSHIFTMOUSECENTER2=0x507;
	public static final int CTRLSHIFT0=0x330;
	public static final int CTRLSHIFT1=0x331;
	public static final int CTRLSHIFT2=0x332;
	public static final int CTRLSHIFT3=0x333;
	public static final int CTRLSHIFT4=0x334;
	public static final int CTRLSHIFT5=0x335;
	public static final int CTRLSHIFT6=0x336;
	public static final int CTRLSHIFT7=0x337;
	public static final int CTRLSHIFT8=0x338;
	public static final int CTRLSHIFT9=0x339;
	public static final int CTRLSHIFTA=0x341;
	public static final int CTRLSHIFTB=0x342;
	public static final int CTRLSHIFTC=0x343;
	public static final int CTRLSHIFTD=0x344;
	public static final int CTRLSHIFTE=0x345;
	public static final int CTRLSHIFTF=0x346;
	public static final int CTRLSHIFTG=0x347;
	public static final int CTRLSHIFTH=0x348;
	public static final int CTRLSHIFTI=0x349;
	public static final int CTRLSHIFTJ=0x34a;
	public static final int CTRLSHIFTK=0x34b;
	public static final int CTRLSHIFTL=0x34c;
	public static final int CTRLSHIFTM=0x34d;
	public static final int CTRLSHIFTN=0x34e;
	public static final int CTRLSHIFTO=0x34f;
	public static final int CTRLSHIFTP=0x350;
	public static final int CTRLSHIFTQ=0x351;
	public static final int CTRLSHIFTR=0x352;
	public static final int CTRLSHIFTS=0x353;
	public static final int CTRLSHIFTT=0x354;
	public static final int CTRLSHIFTU=0x355;
	public static final int CTRLSHIFTV=0x356;
	public static final int CTRLSHIFTW=0x357;
	public static final int CTRLSHIFTX=0x358;
	public static final int CTRLSHIFTY=0x359;
	public static final int CTRLSHIFTZ=0x35a;
	public static final int CTRLSHIFTF1=0x370;
	public static final int CTRLSHIFTF2=0x371;
	public static final int CTRLSHIFTF3=0x372;
	public static final int CTRLSHIFTF4=0x373;
	public static final int CTRLSHIFTF5=0x374;
	public static final int CTRLSHIFTF6=0x375;
	public static final int CTRLSHIFTF7=0x376;
	public static final int CTRLSHIFTF8=0x377;
	public static final int CTRLSHIFTF9=0x378;
	public static final int CTRLSHIFTF10=0x379;
	public static final int CTRLSHIFTF11=0x37a;
	public static final int CTRLSHIFTF12=0x37b;
	public static final int CTRLSHIFTAST=0x36a;
	public static final int CTRLSHIFTBS=0x308;
	public static final int CTRLSHIFTDECIMAL=0x36e;
	public static final int CTRLSHIFTDELETE=0x32e;
	public static final int CTRLSHIFTDOWN=0x328;
	public static final int CTRLSHIFTEND=0x323;
	public static final int CTRLSHIFTENTER=0x30d;
	public static final int CTRLSHIFTESC=0x31b;
	public static final int CTRLSHIFTHOME=0x324;
	public static final int CTRLSHIFTINSERT=0x32d;
	public static final int CTRLSHIFTLEFT=0x325;
	public static final int CTRLSHIFTMINUS=0x36d;
	public static final int CTRLSHIFTPAUSE=0x313;
	public static final int CTRLSHIFTPGDN=0x322;
	public static final int CTRLSHIFTPGUP=0x321;
	public static final int CTRLSHIFTPLUS=0x36b;
	public static final int CTRLSHIFTPRINT=0x32c;
	public static final int CTRLSHIFTRIGHT=0x327;
	public static final int CTRLSHIFTSLASH=0x36f;
	public static final int CTRLSHIFTSPACE=0x320;
	public static final int CTRLSHIFTTAB=0x309;
	public static final int CTRLSHIFTUP=0x326;
	public static final int CTRLSHIFTPAD0=0x360;
	public static final int CTRLSHIFTPAD1=0x361;
	public static final int CTRLSHIFTPAD2=0x362;
	public static final int CTRLSHIFTPAD3=0x363;
	public static final int CTRLSHIFTPAD4=0x364;
	public static final int CTRLSHIFTPAD5=0x365;
	public static final int CTRLSHIFTPAD6=0x366;
	public static final int CTRLSHIFTPAD7=0x367;
	public static final int CTRLSHIFTPAD8=0x368;
	public static final int CTRLSHIFTPAD9=0x369;
	public static final int CTRLSHIFTMOUSELEFT=0x301;
	public static final int CTRLSHIFTMOUSERIGHT=0x302;
	public static final int CTRLSHIFTMOUSECENTER=0x303;
	public static final int CTRLSHIFTMOUSELEFT2=0x305;
	public static final int CTRLSHIFTMOUSERIGHT2=0x306;
	public static final int CTRLSHIFTMOUSECENTER2=0x307;
	public static final int CTRLALT0=0x630;
	public static final int CTRLALT1=0x631;
	public static final int CTRLALT2=0x632;
	public static final int CTRLALT3=0x633;
	public static final int CTRLALT4=0x634;
	public static final int CTRLALT5=0x635;
	public static final int CTRLALT6=0x636;
	public static final int CTRLALT7=0x637;
	public static final int CTRLALT8=0x638;
	public static final int CTRLALT9=0x639;
	public static final int CTRLALTA=0x641;
	public static final int CTRLALTB=0x642;
	public static final int CTRLALTC=0x643;
	public static final int CTRLALTD=0x644;
	public static final int CTRLALTE=0x645;
	public static final int CTRLALTF=0x646;
	public static final int CTRLALTG=0x647;
	public static final int CTRLALTH=0x648;
	public static final int CTRLALTI=0x649;
	public static final int CTRLALTJ=0x64a;
	public static final int CTRLALTK=0x64b;
	public static final int CTRLALTL=0x64c;
	public static final int CTRLALTM=0x64d;
	public static final int CTRLALTN=0x64e;
	public static final int CTRLALTO=0x64f;
	public static final int CTRLALTP=0x650;
	public static final int CTRLALTQ=0x651;
	public static final int CTRLALTR=0x652;
	public static final int CTRLALTS=0x653;
	public static final int CTRLALTT=0x654;
	public static final int CTRLALTU=0x655;
	public static final int CTRLALTV=0x656;
	public static final int CTRLALTW=0x657;
	public static final int CTRLALTX=0x658;
	public static final int CTRLALTY=0x659;
	public static final int CTRLALTZ=0x65a;
	public static final int CTRLALTF1=0x670;
	public static final int CTRLALTF2=0x671;
	public static final int CTRLALTF3=0x672;
	public static final int CTRLALTF4=0x673;
	public static final int CTRLALTF5=0x674;
	public static final int CTRLALTF6=0x675;
	public static final int CTRLALTF7=0x676;
	public static final int CTRLALTF8=0x677;
	public static final int CTRLALTF9=0x678;
	public static final int CTRLALTF10=0x679;
	public static final int CTRLALTF11=0x67a;
	public static final int CTRLALTF12=0x67b;
	public static final int CTRLALTAST=0x66a;
	public static final int CTRLALTBS=0x608;
	public static final int CTRLALTDECIMAL=0x66e;
	public static final int CTRLALTDELETE=0x62e;
	public static final int CTRLALTDOWN=0x628;
	public static final int CTRLALTEND=0x623;
	public static final int CTRLALTENTER=0x60d;
	public static final int CTRLALTESC=0x61b;
	public static final int CTRLALTHOME=0x624;
	public static final int CTRLALTINSERT=0x62d;
	public static final int CTRLALTLEFT=0x625;
	public static final int CTRLALTMINUS=0x66d;
	public static final int CTRLALTPAUSE=0x613;
	public static final int CTRLALTPGDN=0x622;
	public static final int CTRLALTPGUP=0x621;
	public static final int CTRLALTPLUS=0x66b;
	public static final int CTRLALTPRINT=0x62c;
	public static final int CTRLALTRIGHT=0x627;
	public static final int CTRLALTSLASH=0x66f;
	public static final int CTRLALTSPACE=0x620;
	public static final int CTRLALTTAB=0x609;
	public static final int CTRLALTUP=0x626;
	public static final int CTRLALTPAD0=0x660;
	public static final int CTRLALTPAD1=0x661;
	public static final int CTRLALTPAD2=0x662;
	public static final int CTRLALTPAD3=0x663;
	public static final int CTRLALTPAD4=0x664;
	public static final int CTRLALTPAD5=0x665;
	public static final int CTRLALTPAD6=0x666;
	public static final int CTRLALTPAD7=0x667;
	public static final int CTRLALTPAD8=0x668;
	public static final int CTRLALTPAD9=0x669;
	public static final int CTRLALTMOUSELEFT=0x601;
	public static final int CTRLALTMOUSERIGHT=0x602;
	public static final int CTRLALTMOUSECENTER=0x603;
	public static final int CTRLALTMOUSELEFT2=0x605;
	public static final int CTRLALTMOUSERIGHT2=0x606;
	public static final int CTRLALTMOUSECENTER2=0x607;
	public static final int NOERROR=0;
	public static final int NOFILEERR=2;
	public static final int NOPATHERR=3;
	public static final int TOOMANYERR=4;
	public static final int NOACCESSERR=5;
	public static final int BADMEMERR=7;
	public static final int NOMEMERR=8;
	public static final int BADDRIVEERR=15;
	public static final int NOENTRYERR=30;
	public static final int ISLOCKEDERR=32;
	public static final int BADRECERR=33;
	public static final int NORECERR=35;
	public static final int BADFILEERR=36;
	public static final int NOTOPENERR=37;
	public static final int INVKEYERR=38;
	public static final int DUPKEYERR=40;
	public static final int ISHELDERR=43;
	public static final int BADNAMEERR=45;
	public static final int BADKEYERR=46;
	public static final int INVALIDFILEERR=47;
	public static final int BADTRANERR=48;
	public static final int ISOPENERR=52;
	public static final int NOCREATEERR=54;
	public static final int NOSHAREERR=55;
	public static final int LOGACTIVEERR=56;
	public static final int BADMEMOERR=57;
	public static final int EXCLREQERR=63;
	public static final int SHAREVIOERR=64;
	public static final int CANTROLLERR=65;
	public static final int MEMOMISSING=73;
	public static final int TYPEDESCERR=75;
	public static final int BADINDEXERR=76;
	public static final int INDEXACCESSERR=77;
	public static final int BADPARMERR=78;
	public static final int BADFIELDTYPEERR=79;
	public static final int NODRIVERSUPPORT=80;
	public static final int RECORDCHANGEDERR=89;
	public static final int FILESYSTEMERR=90;
	public static final int NOLOGOUTERR=91;
	public static final int BUILDACTIVEERR=92;
	public static final int BUILDCANCELLEDERR=93;
	public static final int RECORDLIMITERR=94;
}