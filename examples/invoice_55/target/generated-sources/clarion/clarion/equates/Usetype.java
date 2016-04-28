package clarion.equates;

@SuppressWarnings("all")
public class Usetype
{
	public static final int CORRUPTS=1;
	public static final int USES=Usetype.CORRUPTS+1;
	public static final int RETURNS=Usetype.CORRUPTS+2;
	public static final int BENIGN=Usetype.CORRUPTS+3;
}
