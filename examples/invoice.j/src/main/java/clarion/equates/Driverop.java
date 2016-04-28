package clarion.equates;

public class Driverop
{
	public static final int ADD=1;
	public static final int BOF=Driverop.ADD+1;
	public static final int BUILDFILE=Driverop.ADD+2;
	public static final int APPEND=Driverop.ADD+3;
	public static final int BUILDDYN=Driverop.ADD+4;
	public static final int BUILDKEY=Driverop.ADD+5;
	public static final int CLOSE=Driverop.ADD+6;
	public static final int COMMIT=Driverop.ADD+7;
	public static final int COPY=Driverop.ADD+8;
	public static final int CREATE=Driverop.ADD+9;
	public static final int DELETE=Driverop.ADD+10;
	public static final int DUPLICATE=Driverop.ADD+11;
	public static final int EMPTY=Driverop.ADD+12;
	public static final int EOF=Driverop.ADD+13;
	public static final int GETFILEKEY=Driverop.ADD+14;
	public static final int GETFILEPTR=Driverop.ADD+15;
	public static final int GETKEYPTR=Driverop.ADD+16;
	public static final int HOLD=Driverop.ADD+17;
	public static final int LOCK=20;
	public static final int LOGOUT=22;
	public static final int NAME=Driverop.LOGOUT+1;
	public static final int NEXT=Driverop.LOGOUT+2;
	public static final int OPEN=Driverop.LOGOUT+3;
	public static final int PACK=Driverop.LOGOUT+4;
	public static final int POINTERFILE=Driverop.LOGOUT+5;
	public static final int POINTERKEY=Driverop.LOGOUT+6;
	public static final int FLUSH=Driverop.LOGOUT+7;
	public static final int PUT=Driverop.LOGOUT+8;
	public static final int PREVIOUS=Driverop.LOGOUT+9;
	public static final int RECORDSFILE=Driverop.LOGOUT+10;
	public static final int RECORDSKEY=Driverop.LOGOUT+11;
	public static final int BUILDDYNFILTER=Driverop.LOGOUT+12;
	public static final int STARTTRAN=Driverop.LOGOUT+13;
	public static final int RELEASE=Driverop.LOGOUT+14;
	public static final int REMOVE=Driverop.LOGOUT+15;
	public static final int RENAME=Driverop.LOGOUT+16;
	public static final int ENDTRAN=Driverop.LOGOUT+17;
	public static final int ROLLBACK=Driverop.LOGOUT+18;
	public static final int SETFILE=Driverop.LOGOUT+19;
	public static final int SETFILEKEY=Driverop.LOGOUT+20;
	public static final int SETFILEPTR=Driverop.LOGOUT+21;
	public static final int SETKEY=Driverop.LOGOUT+22;
	public static final int SETKEYKEY=Driverop.LOGOUT+23;
	public static final int SETKEYPTR=Driverop.LOGOUT+24;
	public static final int SETKEYKEYPTR=Driverop.LOGOUT+25;
	public static final int SHARE=Driverop.LOGOUT+26;
	public static final int SKIP=Driverop.LOGOUT+27;
	public static final int UNLOCK=Driverop.LOGOUT+28;
	public static final int ADDLEN=Driverop.LOGOUT+29;
	public static final int BYTES=Driverop.LOGOUT+30;
	public static final int GETFILEPTRLEN=Driverop.LOGOUT+31;
	public static final int PUTFILEPTR=Driverop.LOGOUT+32;
	public static final int PUTFILEPTRLEN=Driverop.LOGOUT+33;
	public static final int STREAM=Driverop.LOGOUT+34;
	public static final int DUPLICATEKEY=Driverop.LOGOUT+35;
	public static final int WATCH=Driverop.LOGOUT+36;
	public static final int APPENDLEN=Driverop.LOGOUT+37;
	public static final int SEND=Driverop.LOGOUT+38;
	public static final int POSITIONFILE=Driverop.LOGOUT+39;
	public static final int POSITIONKEY=Driverop.LOGOUT+40;
	public static final int RESETFILE=Driverop.LOGOUT+41;
	public static final int RESETKEY=Driverop.LOGOUT+42;
	public static final int NOMEMO=Driverop.LOGOUT+43;
	public static final int REGETFILE=Driverop.LOGOUT+44;
	public static final int REGETKEY=Driverop.LOGOUT+45;
	public static final int NULL=Driverop.LOGOUT+46;
	public static final int SETNULL=Driverop.LOGOUT+47;
	public static final int SETNONNULL=Driverop.LOGOUT+48;
	public static final int SETPROPERTY=Driverop.LOGOUT+49;
	public static final int GETPROPERTY=Driverop.LOGOUT+50;
	public static final int GETBLOBDATA=75;
	public static final int PUTBLOBDATA=Driverop.GETBLOBDATA+1;
	public static final int BLOBSIZE=Driverop.GETBLOBDATA+2;
	public static final int SETBLOBPROPERTY=Driverop.GETBLOBDATA+3;
	public static final int GETBLOBPROPERTY=Driverop.GETBLOBDATA+4;
	public static final int BUFFER=Driverop.GETBLOBDATA+5;
	public static final int SETVIEWFIELDS=Driverop.GETBLOBDATA+6;
	public static final int CLEARFILE=Driverop.GETBLOBDATA+7;
	public static final int RESETVIEWFILE=Driverop.GETBLOBDATA+8;
	public static final int BUILDEVENT=Driverop.GETBLOBDATA+9;
	public static final int SETKEYPROPERTY=Driverop.GETBLOBDATA+10;
	public static final int GETKEYPROPERTY=Driverop.GETBLOBDATA+11;
	public static final int DOPROPERTY=88;
	public static final int DOKEYPROPERTY=Driverop.DOPROPERTY+1;
	public static final int DOBLOBPROPERTY=Driverop.DOPROPERTY+2;
	public static final int VIEWSTART=92;
	public static final int VIEWSTOP=Driverop.VIEWSTART+1;
	public static final int GETNULLS=96;
	public static final int SETNULLS=Driverop.GETNULLS+1;
	public static final int GETSTATE=Driverop.GETNULLS+2;
	public static final int RESTORESTATE=Driverop.GETNULLS+3;
	public static final int CALLBACK=Driverop.GETNULLS+4;
	public static final int FREESTATE=102;
	public static final int DESTROY=104;
}