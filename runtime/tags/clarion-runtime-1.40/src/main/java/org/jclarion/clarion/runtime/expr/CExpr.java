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

import java.util.Iterator;
import java.util.Stack;

import org.jclarion.clarion.ClarionObject;

public abstract class CExpr 
{
    /**
     *  Work out expression type
     *  
     * @return
     */
    public abstract CExprType getType();

    /**
     *  Force expr type to a new cast
     *  
     * @return
     */
    public abstract void cast(CExprType type);
    
    /**
     * Return whether or not expression type is fixed. i.e. cannot be easily recast
     */
    public abstract boolean isRecastableType();
    
    /**
     * Generate result
     * @return
     */
    public abstract ClarionObject eval();
    
    /**
     * Return order of precendence. 
     * 
     * Low number = low order of precedence (i.e. bool etc)
     * 
     * Hi number = high order of precendence (i.e. * % / etc ). Highest is constants
     * 
     * When rebuilding expressions (i.e. SQL) you need to paran anything whose
     * precendence is lower then yourself i.e.
     * 
     * Sum(Prod,Prod) = 2*3 + 6*3 
     * 
     * Prod(Sum,Sum)  = (2+3) * (6+3)
     */
    public abstract int precendence();
    
    public abstract Iterator<CExpr> directChildren();
    
    /**
     * Generate SQL capable string.
     * 
     *  if strict is false (not strict mode) then it will generate
     *  expression faithfully without consideration as to whether or
     *  not it will yield legal SQL
     *  
     *  If strict mode is set - then only faithful SQL will be yielded
     *  return result in this case will indicate whether or not 
     *  this call of generateString yielded SQL. 
     *  
     *  If a method returns false it must preserve StringBuilder as is 
     *  
     *  e.g. Pow() will always return false.
     *  e.g. BoolExpr will return false if there are any 'OR' components which are
     *  not strict SQL
     */
    public abstract boolean generateString(StringBuilder out,boolean strict);
    
    public Iterator<CExpr> iterator()
    {
        return new JoinIterator(new OneIterator(this),new DeepIterator(this));
    }

    protected static class GenericOp
    {
        public CExpr right;
    }

    public static class DeepIterator implements Iterator<CExpr>
    {
        private Stack<Iterator<CExpr>> stack;
        private Iterator<CExpr> current;
        
        public DeepIterator(CExpr base)
        {
            stack=new Stack<Iterator<CExpr>>();
            current=base.directChildren();
        }

        @Override
        public boolean hasNext() {
            if (current==null) return false;
            while (!current.hasNext()) {
                if (stack.isEmpty()) {
                    current=null;
                    return false;
                }
                current=stack.pop();
            }
            
            return true;
        }

        @Override
        public CExpr next() {
            if (!hasNext()) return null;
            
            CExpr next = current.next();
            if (current.hasNext()) { 
                // only push it if it has something more to offer
                stack.push(current); 
            }
            current=next.directChildren();
            if (current==null) return null;
            
            return next;
        }

        @Override
        public void remove() {
        }
    }
    
    public static class ZeroIterator implements Iterator<CExpr>
    {
        @Override
        public boolean hasNext() {
            return false;
        }

        @Override
        public CExpr next() {
            return null;
        }

        @Override
        public void remove() {
        }
    }
    
    public static class OneIterator implements Iterator<CExpr>
    {
        private CExpr e;
        
        public OneIterator(CExpr e)
        {
            this.e=e;
        }
        
        @Override
        public boolean hasNext() {
            return (e!=null);
        }

        @Override
        public CExpr next() {
            CExpr r =e;
            e=null;
            return r;
        }

        @Override
        public void remove() {
        }
    }

    public static class TwoIterator implements Iterator<CExpr>
    {
        private CExpr e1;
        private CExpr e2;
        
        public TwoIterator(CExpr e1,CExpr e2)
        {
            this.e1=e1;
            this.e2=e2;
        }
        
        @Override
        public boolean hasNext() {
            return (e1!=null || e2!=null);
        }

        @Override
        public CExpr next() {
            CExpr r =null;
            if (e1!=null) {
                r=e1;
                e1=null;
            } else if (e2!=null) {
                r=e2;
                e2=null;
            }
            return r;
        }

        @Override
        public void remove() {
        }
    }

    public static class OpIterable implements Iterable<CExpr>
    {
        private Iterable<? extends GenericOp> op;
        
        public OpIterable(Iterable<? extends GenericOp> op) {
            this.op=op;
        }
        
        @Override
        public Iterator<CExpr> iterator() {
            return new OpIterator(op.iterator());
        }
        
    }
    
    public static class OpIterator implements Iterator<CExpr>
    {
        private Iterator<? extends GenericOp> op;
        
        public OpIterator(Iterator<? extends GenericOp> op)
        {
            this.op=op;
        }

        @Override
        public boolean hasNext() {
            return op.hasNext();
        }

        @Override
        public CExpr next() {
            GenericOp o = op.next();
            if (o==null) return null;
            return o.right;
        }

        @Override
        public void remove() {
        }
    }
    
    public static class JoinIterator implements Iterator<CExpr>
    {
        private Iterator<CExpr> e1;
        private Iterator<CExpr> e2;
        
        public JoinIterator(Iterator<CExpr> e1,Iterator<CExpr> e2)
        {
            this.e1=e1;
            this.e2=e2;
        }

        public JoinIterator(CExpr e1,Iterable<CExpr> e2)
        {
            this.e1=new OneIterator(e1);
            this.e2=e2.iterator();;
        }

        public static JoinIterator generic(CExpr e1,Iterable<? extends GenericOp> e2) 
        {
            return new JoinIterator(new OneIterator(e1),new OpIterator(e2.iterator()));
        }

        @Override
        public boolean hasNext() {
            return (e1.hasNext() || e2.hasNext());
        }

        @Override
        public CExpr next() {
            if (e1.hasNext()) return e1.next();
            if (e2.hasNext()) return e2.next();
            return null;
        }

        @Override
        public void remove() {
        }
    }

    protected CExprType resolveCasts(Iterable<CExpr> in)
    {
        CExprType type=null;
        boolean   force=false;
        
        for ( CExpr scan : in ) {
            if (type==null || !force) {
                type=scan.getType();
                force=!scan.isRecastableType();
                continue;
            }
        }
        return type;
    }

    protected boolean isRecastableType(Iterable<CExpr> in)
    {
        for ( CExpr scan : in ) {
            if (!scan.isRecastableType()) return false; 
        }
        return true;
    }
    
    protected void cast(Iterable<CExpr> in,CExprType type)
    {
        for ( CExpr scan : in ) {
            scan.cast(type);
        }
    }
    
}
