package org.jclarion.clarion.ide;

import java.text.MessageFormat;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

@SuppressWarnings("rawtypes")
public class Messages {

	private static final String RESOURCE_BUNDLE_NAME = Messages.class.getName();
	private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle(RESOURCE_BUNDLE_NAME);

	private Messages() {
		// Empty
	}

	public static String getString(Class caller, String key) {
		String qualifiedKey = caller.getSimpleName() + "." + key;
		try {
			return RESOURCE_BUNDLE.getString(qualifiedKey);
		} catch (MissingResourceException e) {
			return "!" + qualifiedKey + "!";
		}
	}

	public static String getString(Class caller, String key, Object... args) {
		return MessageFormat.format(getString(caller, key), args);
	}

	public static ResourceBundle getResourceBundle() {
		return RESOURCE_BUNDLE;
	}

}
