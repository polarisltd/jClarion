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

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.compile.grammar.Parser;

public class JoinedSettingParser extends SettingParser<Object>
{
    private List<SettingParser<?>> list=new ArrayList<SettingParser<?>>();
    
    public JoinedSettingParser(SettingParser<?>... parsers)
    {
        add(parsers);
    }

    public void add(SettingParser<?>... parsers)
    {
        for (int scan=0;scan<parsers.length;scan++) {
            list.add(parsers[scan]);
        }
    }


    @Override
    @SuppressWarnings("unchecked")
    public SettingResult<Object> get(Parser p) {
        
        for (SettingParser<?> scan : list) {
            SettingResult<?> r = scan.get(p);
            if (r!=null) return (SettingResult<Object>) r;
        }
        
        return null;
    }}
