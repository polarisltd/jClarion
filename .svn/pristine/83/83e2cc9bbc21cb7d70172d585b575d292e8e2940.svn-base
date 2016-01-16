package org.jclarion.clarion.ide.builder;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.jdt.core.Flags;
import org.eclipse.jdt.core.IAnnotation;
import org.eclipse.jdt.core.IField;
import org.eclipse.jdt.core.IJavaProject;
import org.eclipse.jdt.core.ILocalVariable;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.jdt.core.IType;
import org.eclipse.jdt.core.JavaModelException;
import org.eclipse.jdt.core.Signature;
import org.jclarion.clarion.compile.javaimport.FieldImport;
import org.jclarion.clarion.compile.javaimport.JavaImporter;
import org.jclarion.clarion.compile.javaimport.MethodImport;

public class EclipseJavaImporter extends JavaImporter<IType>
{
	private IJavaProject project;

	public EclipseJavaImporter(IJavaProject project)
	{
		this.project=project;
	}

	@Override
	public IType resolve(String arg0) {
		try {
			IType t = project.findType(arg0);
			if (t==null || !t.exists()) return null;
			return t;
		} catch (JavaModelException e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public FieldImport[] getFields(IType arg0) {
		try {
			List<FieldImport> result = new ArrayList<FieldImport>();
			for (IField f : arg0.getFields()) {
				int flg = f.getFlags();
				if (!Flags.isPublic(flg)) continue;
				if (Flags.isStatic(flg)) continue;
				
				String type = resolveSignature(arg0,f.getTypeSignature());
				if (type==ERROR) continue;
				if (type.equals("void")) type=null;
				result.add(new FieldImport(f.getElementName(),type));
			}
			return result.toArray(new FieldImport[result.size()]);
		} catch (JavaModelException ex) {
			return new FieldImport[0];
		}
	}

	@Override
	public MethodImport[] getMethods(IType arg0) {
		try {
			List<MethodImport> result = new ArrayList<MethodImport>();
			main: for (IMethod f : arg0.getMethods()) {
				int flg = f.getFlags();
				if (!Flags.isPublic(flg)) continue;
				if (f.isConstructor()) continue;
				if (f.getElementName().startsWith("<")) continue;
				IAnnotation ia = f.getAnnotation("org.jclarion.clarion.lang.NotClarionVisible");
				if (ia!=null && ia.exists()) continue;
				
				String type = resolveSignature(arg0,f.getReturnType());
				if (type==ERROR) continue;
				if (type.equals("void")) type=null;
				
				ILocalVariable params[] = f.getParameters();
				String paramNames[] = new String[params.length];
				
				for (int scan=0;scan<params.length;scan++) {
					paramNames[scan]=resolveSignature(arg0,params[scan].getTypeSignature());
					if (paramNames[scan]==null) continue main;
				}
				MethodImport mi =new MethodImport(f.getElementName(),type,paramNames);
				result.add(mi);				
			}
			return result.toArray(new MethodImport[result.size()]);
		} catch (JavaModelException ex) {
			return new MethodImport[0];
		}
	}

	@Override
	public String getSuperClass(IType arg0) {
		try {
			return arg0.getSuperclassName();
		} catch (JavaModelException e) {
			return null;
		}
	}

	private static final String ERROR ="ERROR";
	private Map<String,String> resolvedSigs=new HashMap<String,String>(); 
	
	private String resolveSignature(IType base,String in)
	{
		String result = resolvedSigs.get(in);
		if (result==null) {
			result=doResolveSignature(base,in);
			if (result==null) result=ERROR;
			resolvedSigs.put(in,result);
		}
		return result;
	}

	private String doResolveSignature(IType base,String in) {
		
		if (in.length()==0) return null;
		char type = in.charAt(0);
		if (type=='[') return null;
		if (type==Signature.C_BOOLEAN) return boolean.class.toString();
		if (type==Signature.C_BYTE) return byte.class.toString();
		if (type==Signature.C_CHAR) return char.class.toString();
		if (type==Signature.C_INT) return int.class.toString();
		if (type==Signature.C_VOID) return void.class.toString();
		if (type==Signature.C_UNRESOLVED) {
			
			String packageName = Signature.getSignatureQualifier(in);
			String typeName = Signature.getSignatureSimpleName(in);
			String fullName;
			if (packageName!=null && packageName.length()>0) {
				fullName=packageName+"."+typeName;
			} else {
				fullName=typeName;
			}

			try {
				String[][] resolved = base.resolveType(fullName);
				if (resolved.length>0 && resolved[0].length==2) {
					String result=resolved[0][0]+"."+resolved[0][1];
					return result;
				}
			}
			catch(JavaModelException jme) { }
		}
		if (type==Signature.C_RESOLVED) {
			int end = in.lastIndexOf('<');
			if (end==-1) {
				end = in.lastIndexOf(';');
			}
			if (end==-1) {
				end = in.length();
			}
			return in.substring(1,end);
		}
		System.out.println("Cannot decode : "+in);
		return null;
	}
}
