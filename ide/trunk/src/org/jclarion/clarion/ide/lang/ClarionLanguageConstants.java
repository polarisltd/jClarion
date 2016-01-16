package org.jclarion.clarion.ide.lang;

public class ClarionLanguageConstants {

	/**
	 * Input list of words used to populate {@link #KEYWORDS} with lower and
	 * upper case words. This list needn't be in any particular case
	 */
	private static final String[] SRC_KEYWORDS = {
		".",
		"accept",
		"case",
		"code",
		"cycle",
		"else",
		"end",
		"if",
		"of",
		"procedure",
		"return",
		"self",
		"then",
		"window"
	};

	/**
	 * Input list of words used to populate {@link #TYPES} with lower and
	 * upper case words. This list needn't be in any particular case
	 */
	private static final String[] SRC_TYPES = {
		"button",
		"entry",
		"font",
		"group",
		"long",
		"string"
	};

	/**
	 * Input list of words used to populate {@link #ATTRIBUTES} with lower and
	 * upper case words. This list needn't be in any particular case
	 */
	private static final String[] SRC_ATTRIBUTES = {
		"at",
		"bevel",
		"boxed",
		"center",
		"font",
		"gray",
		"mdi",
		"std",
		"use"
	};

	/** Mixed case keywords are not supported */
	public static final String[] KEYWORDS = populate(SRC_KEYWORDS);
	/** Mixed case keywords are not supported */
	public static final String[] TYPES = populate(SRC_TYPES);
	/** Mixed case keywords are not supported */
	public static final String[] ATTRIBUTES = populate(SRC_ATTRIBUTES);

	private static String[] populate(String[] src) {
		int srcLength = src.length;
		String[] dst = new String[srcLength * 2];
		for (int i = 0, n = srcLength; i < n; i++) {
			dst[i] = src[i].toLowerCase();
			dst[i + srcLength] = src[i].toUpperCase();
		}
		return dst;
	}

}
