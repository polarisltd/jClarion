package clarion.equates;

@SuppressWarnings("all")
public class Datatype
{
	public static final int BYTE=1;
	public static final int SHORT=Datatype.BYTE+1;
	public static final int USHORT=Datatype.BYTE+2;
	public static final int DATE=Datatype.BYTE+3;
	public static final int TIME=Datatype.BYTE+4;
	public static final int LONG=Datatype.BYTE+5;
	public static final int ULONG=Datatype.BYTE+6;
	public static final int SREAL=Datatype.BYTE+7;
	public static final int REAL=Datatype.BYTE+8;
	public static final int DECIMAL=Datatype.BYTE+9;
	public static final int PDECIMAL=Datatype.BYTE+10;
	public static final int BFLOAT4=13;
	public static final int BFLOAT8=Datatype.BFLOAT4+1;
	public static final int STRING=18;
	public static final int CSTRING=Datatype.STRING+1;
	public static final int PSTRING=Datatype.STRING+2;
	public static final int MEMO=Datatype.STRING+3;
	public static final int BLOB=27;
}
