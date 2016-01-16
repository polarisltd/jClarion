package org.jclarion.clarion.ide.windowdesigner;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.lang.Lex;

public abstract class PropSerializer 
{
	public static Map<String,PropSerializer> props=new HashMap<String,PropSerializer>();
	static {
		props.put("ratio",new RatioSerializer());
		props.put("at",new MultiPropSerializer());
		props.put("font",new MultiPropSerializer());
		
		props.put("paper",new PaperSerializer());
		props.put("pre",new PreSerializer());
		props.put("from",new SimplePropSerializer());
		props.put("preview",new SimplePropSerializer());
		props.put("format",new SimplePropSerializer());
		props.put("drop",new SimplePropSerializer());
		props.put("bevel",new SimplePropSerializer());
		props.put("icon",new SpecialPropSerializer());
		props.put("std",new SimplePropSerializer());
		props.put("timer",new SimplePropSerializer());
		props.put("key",new SimplePropSerializer());
		props.put("hlp",new SimplePropSerializer());
		props.put("msg",new SimplePropSerializer());
		props.put("color",new SimplePropSerializer());
		props.put("value",new ValuePropSerializer());
		props.put("fill",new SimplePropSerializer());
		props.put("linewidth",new SimplePropSerializer());
		props.put("tip",new SimplePropSerializer());
		props.put("withprior",new SimplePropSerializer());
		props.put("withnext",new SimplePropSerializer());

		props.put("center",new AlignmentPropSerializer(Prop.CENTER,Prop.CENTEROFFSET));
		props.put("left",new AlignmentPropSerializer(Prop.LEFT,Prop.LEFTOFFSET));
		props.put("right",new AlignmentPropSerializer(Prop.RIGHT,Prop.RIGHTOFFSET));
		props.put("decimal",new AlignmentPropSerializer(Prop.DECIMAL,Prop.DECIMALOFFSET));
		
		props.put("use",new UsePropSerializer());
		
		props.put("max",new FlagPropSerializer());
		props.put("req",new FlagPropSerializer());
		props.put("resize",new FlagPropSerializer());
		props.put("centered",new FlagPropSerializer());
		props.put("readonly",new FlagPropSerializer());
		props.put("password",new FlagPropSerializer());
		props.put("landscape",new FlagPropSerializer());
		props.put("thous",new FlagPropSerializer());
		props.put("absolute",new FlagPropSerializer());
		props.put("round",new FlagPropSerializer());
		props.put("mm",new FlagPropSerializer());
		props.put("default",new FlagPropSerializer());
		props.put("vscroll",new FlagPropSerializer());
		props.put("hvscroll",new HVScrollPropSerializer());
		props.put("trn",new FlagPropSerializer());
		props.put("boxed",new FlagPropSerializer());
		props.put("double",new FlagPropSerializer());
		props.put("gray",new FlagPropSerializer());
		props.put("mdi",new FlagPropSerializer());
		props.put("system",new FlagPropSerializer());
		props.put("imm",new FlagPropSerializer());
		props.put("skip",new FlagPropSerializer());
		props.put("disable",new FlagPropSerializer());
		props.put("hide",new FlagPropSerializer());
		props.put("wizard",new FlagPropSerializer());
		props.put("nosheet",new FlagPropSerializer());
		props.put("nobar",new FlagPropSerializer());
		props.put("flat",new FlagPropSerializer());
		props.put("upr",new FlagPropSerializer());		
	}

	
	public static PropSerializer get(String name) {
		return props.get(name.toLowerCase());
	}

	public void deserialize(PropertyObject target,String type,Lex... params)
	{
		String[] result = new String[params.length];
		for (int scan=0;scan<result.length;scan++) {
			result[scan]=params[scan]==null ? null : params[scan].value;
		}
		deserialize(target,type,result);
	}
	
	public abstract void deserialize(PropertyObject target,String type,String... params);
}
