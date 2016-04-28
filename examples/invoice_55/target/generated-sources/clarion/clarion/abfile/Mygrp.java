package clarion.abfile;

import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Mygrp extends ClarionGroup
{
	public RefVariable<ClarionFile> fr=new RefVariable<ClarionFile>(null);

	public Mygrp()
	{
		this.addVariable("Fr",this.fr);
	}
}
