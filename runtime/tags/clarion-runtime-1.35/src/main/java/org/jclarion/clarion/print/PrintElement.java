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
package org.jclarion.clarion.print;

import java.awt.Rectangle;

import org.jclarion.clarion.ClarionObject;

public interface PrintElement 
{
    public abstract void paint(Page r,PrintContext c);
    public abstract Rectangle getPreferredDimensions(Page r,PrintContext c);
    public abstract void update(Page page);
    public abstract boolean contains(ClarionObject object);
    public abstract boolean isResize();
}
