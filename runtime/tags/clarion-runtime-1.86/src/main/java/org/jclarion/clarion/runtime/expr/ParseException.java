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
package org.jclarion.clarion.runtime.expr;

public class ParseException extends Exception 
{
    /**
     * 
     */
    private static final long serialVersionUID = 4162398393642000350L;

    public ParseException(String message)
    {
        super(message);
    }

}
