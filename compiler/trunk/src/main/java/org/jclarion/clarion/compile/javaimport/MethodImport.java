package org.jclarion.clarion.compile.javaimport;

import java.util.Arrays;

public class MethodImport {
	private String name;
	private String ret;
	private String[] args;

	public MethodImport(String name,String ret,String ...args)
	{
		this.name=name;
		this.ret=ret;
		this.args=args;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRet() {
		return ret;
	}

	public void setRet(String ret) {
		this.ret = ret;
	}

	public String[] getArgs() {
		return args;
	}

	public void setArgs(String[] args) {
		this.args = args;
	}

	@Override
	public String toString() {
		return "MethodImport [name=" + name + ", ret=" + ret + ", args="
				+ Arrays.toString(args) + "]";
	}
	
	
}
