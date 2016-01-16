package org.jclarion.clarion.compile.javaimport;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.lang.NotClarionVisible;

public class DefaultJavaImporter extends JavaImporter<Class<?>> 
{
	@Override
	public Class<?> resolve(String name) {
		try {
			return getClass().getClassLoader().loadClass(name);
		} catch (ClassNotFoundException e) {
		}

		try {
			return Thread.currentThread().getContextClassLoader()
					.loadClass(name);
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("Class Not Found:" + name);
		} finally {
		}
	}

	@Override
	public String getSuperClass(Class<?> item) {
		return item.getSuperclass().getName();
	}

	@Override
	public MethodImport[] getMethods(Class<?> item) {
		List<MethodImport> result = new ArrayList<MethodImport>();
		Method[] methods = item.getDeclaredMethods();
		main : for (Method method : methods) {
			if (!Modifier.isPublic(method.getModifiers())) continue;
			if (method.getAnnotation(NotClarionVisible.class) != null) continue;
			Class<?> java_params[] = method.getParameterTypes();
			Class<?> return_type = method.getReturnType();
			if (return_type != null) {
				if (return_type == Void.TYPE || return_type == Void.class) {
					return_type = null;
				}
			}
			if (return_type!=null && return_type.isArray()) continue;

			String[] args = new String[java_params.length];
			int scan = 0;
			for (Class<?> c : java_params) {
				if (c.isArray()) continue main;
				args[scan++] = c.getName();
			}

			MethodImport m = new MethodImport(method.getName(),
					return_type != null ? return_type.getName() : null, args);
			result.add(m);
		}
		return result.toArray(new MethodImport[result.size()]);
	}

	@Override
	public FieldImport[] getFields(Class<?> item) {
		List<FieldImport> result = new ArrayList<FieldImport>();
        Field fields[] = item.getDeclaredFields(); 
        for (final Field field : fields) {
            if (!Modifier.isPublic(field.getModifiers())) continue;
            if (Modifier.isStatic(field.getModifiers())) continue;
            result.add(new FieldImport(field.getName(),field.getDeclaringClass().getName()));
        }		
		return result.toArray(new FieldImport[result.size()]);
	}
}