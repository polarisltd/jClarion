package org.jclarion.clarion.ide.view.properties;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.jclarion.clarion.constants.Propprint;

public class PaperPropertySection extends AbstractComboPropertySection {

	static List<String> paper=new ArrayList<String>();
	static {
		for (String s : "10X14|11X17|A3|A4|A4SMALL|A5|B4|B5|CSHEET|DSHEET|ENV_10|ENV_11|ENV_12|ENV_14|ENV_9|ENV_B4|ENV_B5|ENV_B6|ENV_C3|ENV_C4|ENV_C5|ENV_C6|ENV_C65|ENV_DL|ENV_ITALY|ENV_MONARCH|ENV_PERSONAL|ESHEET|EXECUTIVE|FANFOLD_LGL_GERMAN|FANFOLD_STD_GERMAN|FANFOLD_US|FOLIO|LAST|LEDGER|LEGAL|LETTER|LETTERSMALL|NOTE|QUARTO|STATEMENT|TABLOID|USER".split("\\|")) {
			paper.add("PAPER:"+s);
		}
	}
	
	public PaperPropertySection() {
		super();
	}

	@Override
	Collection<String> getValues() {
		return paper;
	}

	@Override
	String getLabel() {
		return "Paper";
	}

	@Override
	String getValueAsString() {
		return getPropertyManager().getString(Propprint.PAPER);
	}

	@Override
	void setValueAsString(String value) {
		getPropertyManager().setProp(Propprint.PAPER,getValueAsString(),value);
	}

}
