/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.compile.setting;

import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.lang.LexType;

public class LabelPropertySettingParser extends AbstractPropertySettingParser<String> {

    private String defaultValue;
    
    public LabelPropertySettingParser(String key,String defaultValue) {
        super(key);
        this.defaultValue=defaultValue;
    }

    @Override
    protected String getValue(Parser p) {
        if (p.getLexer().lookahead().type!=LexType.label) return "";
        return p.getLexer().next().value;
    }

    @Override
    protected String getDefaultValue() {
        return defaultValue;
    }

}
