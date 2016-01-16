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
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public abstract class SettingParser<T> 
{
    public abstract SettingResult<T> get(Parser p);

    @SuppressWarnings("unchecked")
    public SettingResult<T>[] getArray(Parser p)
    {
        List<SettingResult<T>> r = getList(p);
        
        SettingResult<T>[] result = new SettingResult[r.size()];
        return r.toArray(result);
    }

    public List<SettingResult<T>> getList(Parser p)
    {
        List<SettingResult<T>> results=new ArrayList<SettingResult<T>>();
        doGetList(p,results);
        return results;
    }

    public void getList(Parser p,List<SettingResult<?>> results)
    {
        doGetList(p,results);
    }
    
    @SuppressWarnings({"unchecked","rawtypes"})
    private void doGetList(Parser p,List results)
    {
        Lexer l = p.getLexer();
        
        while ( l.lookahead().type==LexType.param ) 
        {
            int pos = l.begin();
            l.next();
            SettingResult<T> sr = get(p);
            if (sr!=null) {
                results.add(sr);
                l.commit(pos);
            } else {
                l.rollback(pos);
                break;
            }
        }
    }
}
