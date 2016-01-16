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
package org.jclarion.clarion.compile.rewrite;

import org.jclarion.clarion.compile.expr.Expr;

public class JoinExprMutator implements ExprMutator
{
    private ExprMutator mutators[];
    
    public JoinExprMutator(ExprMutator... mutators) {
        this.mutators=mutators;
    }

    @Override
    public Expr mutate(Expr in) {
        for (int scan=0;scan<mutators.length;scan++) {
            in=mutators[scan].mutate(in);
        }
        return in;
    }

    @Override
    public int getMatchScore(Expr in) {
        int score=0;
        for (int scan=0;scan<mutators.length;scan++) {
            int newScore=mutators[scan].getMatchScore(in);
            if (newScore>score) score=newScore;
        }
        return score;
    }
    
}
