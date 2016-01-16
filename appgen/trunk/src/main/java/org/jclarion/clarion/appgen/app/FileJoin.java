package org.jclarion.clarion.appgen.app;

public class FileJoin {
	private File 	parent;
	private File 	child;
	private boolean inner;
	private String  expression;
	
	public FileJoin(File parent,File child,boolean inner,String expression)
	{
		this.parent=parent;
		this.child=child;
		this.inner=inner;
		this.expression=expression;
	}

	public FileJoin(FileJoin base, File parent) 
	{
		this.parent=parent;
		this.child=base.child.clone(this);
		this.inner=base.inner;
		this.expression=base.expression;		
	}

	public File getParent() {
		return parent;
	}

	public File getChild() {
		return child;
	}

	public boolean isInner() {
		return inner;
	}

	public String getExpression() {
		return expression;
	}

	public void setInner(boolean inner) {
		this.inner = inner;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}
	
	public void clearExpression()
	{
		this.expression=null;
	}
	
	public void delete()
	{
		parent.delete(this);
	}

	public PrimaryFile getPrimary() {
		return parent.getPrimary();
	}

	@Override
	public String toString() {
		return "FileJoin [child=" + child + ", inner=" + inner
				+ ", expression=" + expression + "]";
	}
	
	
}
