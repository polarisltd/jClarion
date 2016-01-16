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
package org.jclarion.clarion.hooks;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public interface Filecallbackinterface {

    public abstract void functionDone(ClarionNumber newNumber, FilecallbackParams params,
            ClarionString newString, ClarionString newString2);

    public abstract void functionCalled(ClarionNumber newNumber,
            FilecallbackParams params, ClarionString newString,
            ClarionString newString2);

}
