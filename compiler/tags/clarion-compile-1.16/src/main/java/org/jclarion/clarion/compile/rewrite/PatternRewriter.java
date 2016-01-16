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

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.NullExpr;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.SystemCallExpr;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.var.Variable;

public class PatternRewriter implements Rewriter 
{
    private String              name;
    private List<Expr>          pattern;
    private List<ExprMutator>   rules;
    
    private static Expr SINGLE = new NullExpr ();
    private static Expr MULTIPLE = new NullExpr ();
    
    private static class PositionExpr extends Expr
    {
        private int getPosition()
        {
            return pos;
        }

        public PositionExpr(int pos) {
            super(0,null);
            this.pos=pos;
        }

        private int pos;

        @Override
        public void toJavaString(StringBuilder target) {
        }

        @Override
        public void collate(JavaDependencyCollector collector) {
        }

        @Override
        public boolean utilises(Set<Variable> vars) {
            return false;
        }

        @Override
        public boolean utilisesReferenceVariables() {
            // TODO Auto-generated method stub
            return false;
        }
    }
    
    private int         precedence;
    private ExprType    out;

    private int         minParam=-1;
    private int         maxParam=-1;
    
    private String      depend[];
    private boolean     call;
    
    public static PatternRewriter create(int prec,ExprType out,String name,String pattern)
    {
        return new PatternRewriter(prec,out,name,pattern);
    }

    public static PatternRewriter create(String name,String pattern,ExprType... types)
    {
        return create(JavaPrec.POSTFIX,null,name,pattern,types);
    }
    
    public static PatternRewriter create(ExprType out,String name,String pattern,ExprType... types)
    {
        return create(JavaPrec.POSTFIX,out,name,pattern,types);
    }
    
    public static PatternRewriter create(int prec,ExprType out,String name,String pattern,ExprType... types)
    {
        PatternRewriter pr = new PatternRewriter(prec,out,name,pattern);
        for (int scan=0;scan<types.length;scan++) {
            pr.add(types[scan]);
        }
        return pr;
    }
    
    public PatternRewriter(int prec,ExprType out,String name,String pattern)
    {
        this.precedence=prec;
        this.out=out;
        this.name=name;
        this.pattern=new ArrayList<Expr>();
        this.rules=new ArrayList<ExprMutator>();
        
        int last=0;
        int scan=0;
        
        int t_max=0;
        boolean t_multiple=false;
        
        while (scan<pattern.length()) {
            char c = pattern.charAt(scan);

            if (c=='$') {
                this.pattern.add(new SimpleExpr(0,null,pattern.substring(last,scan)));
                this.pattern.add(SINGLE);
                last=scan+1;
                t_max++;
            }

            if (c=='@') {
                this.pattern.add(new SimpleExpr(0,null,pattern.substring(last,scan)));
                this.pattern.add(MULTIPLE);
                last=scan+1;
                t_max++;
                t_multiple=true;
            }
            
            if (c==':' && scan+1<pattern.length()) {
                char t = pattern.charAt(scan+1);
                if (t>='1' && t<='9') {
                    
                    int pos = t-'0';
                    
                    this.pattern.add(new SimpleExpr(0,null,pattern.substring(last,scan)));
                    this.pattern.add(new PositionExpr(pos));
                    scan+=2;
                    last=scan;
                    if (pos>t_max) t_max=pos;
                    continue;
                }
            }
            
            scan++;
            
        }
        if (last<pattern.length()) {
            this.pattern.add(new SimpleExpr(0,null,pattern.substring(last)));
        }
        
        minParam=t_max;
        if (!t_multiple) maxParam=t_max;
    }

    public PatternRewriter add(ExprType... type)
    {
        rules.add(new CastExprMutator(type));
        return this;
    }

    public PatternRewriter min(int min)
    {
        this.minParam=min;
        return this;
    }

    public PatternRewriter max(int min)
    {
        this.maxParam=min;
        return this;
    }

    public PatternRewriter exact(int val)
    {
        this.maxParam=val;
        this.minParam=val;
        return this;
    }

    public PatternRewriter range(int min,int max)
    {
        this.maxParam=max;
        this.minParam=min;
        return this;
    }

    public PatternRewriter depend(String... depend)
    {
        this.depend=depend;
        return this;
    }

    public PatternRewriter rt(String... depend)
    {
        if (this.depend!=null) throw new IllegalStateException("Already set");
        for (int scan=0;scan<depend.length;scan++) {
            depend[scan]=ClarionCompiler.CLARION+"."+depend[scan];
        }
        this.depend=depend;
        return this;
    }

    public PatternRewriter depend(Class<?>... depend)
    {
        if (this.depend!=null) throw new IllegalStateException("Already set");
        this.depend=new String[depend.length];
        for (int scan=0;scan<depend.length;scan++) {
            this.depend[scan]=depend[scan].getName();
        }
        return this;
    }
    
    
    public PatternRewriter call()
    {
        this.call=true;
        return this;
    }
    
    public PatternRewriter add(int prec)
    {
        rules.add(new WrapExprMutator(prec));
        return this;
    }

    public PatternRewriter add(int prec,ExprType... type)
    {
        rules.add(new JoinExprMutator(new CastExprMutator(type),new WrapExprMutator(prec)));
        return this;
    }
    
    
    @Override
    public String getName() {
        return name;
    }

    @Override 
    public RewrittenExpr rewrite(Expr[] in) {

        RewrittenExpr result=new RewrittenExpr();
        
        if (minParam>=0 && in.length<minParam) return null;
        if (maxParam>=0 && in.length>maxParam) return null;
        
        ExprBuffer buffer = new ExprBuffer(precedence,out);
        
        int in_scan=0;
        
        Iterator<Expr> pattern_scan=pattern.iterator();
        Iterator<ExprMutator> rule_scan=rules.iterator();

        ExprMutator rule = null; 
        
        while (pattern_scan.hasNext()) {
            
            Expr bit = pattern_scan.next();
            
            if (bit instanceof PositionExpr) {
                
                int pos = ((PositionExpr)bit).getPosition()-1;
                
                if (pos>=in.length) {
                    bit=null;
                } else {
                    bit=in[pos];
                    if (bit!=null) {
                        if (pos>=rules.size()) {
                            rule=rules.get(rules.size()-1);
                        } else {
                            rule=rules.get(pos);
                        }
                        result.adjustMatchScore(rule.getMatchScore(bit));
                        bit=rule.mutate(bit);
                        if (bit==null) return null;
                    }
                }

                while (in_scan<=pos) {
                    in_scan++;
                    if (rule_scan.hasNext()) {
                        rule = rule_scan.next();
                    }
                }
            }
            
            if (bit==SINGLE) {
                
                if (rule_scan.hasNext()) {
                    rule = rule_scan.next();
                }
                
                if (in_scan<in.length) {
                    bit=in[in_scan++];
                    if (bit!=null) {
                        result.adjustMatchScore(rule.getMatchScore(bit));
                        bit=rule.mutate(bit);
                        if (bit==null) return null;
                    }
                }
            }
            
            if (bit==MULTIPLE) {
                
                if (rule_scan.hasNext()) {
                    rule = rule_scan.next();
                }

                if (in_scan<in.length) {
                    bit=in[in_scan++];
                    if (bit!=null) {
                        result.adjustMatchScore(rule.getMatchScore(bit));
                        bit=rule.mutate(bit);
                        if (bit==null) return null;
                    }
                    if (bit==null) bit=SINGLE;
                    buffer.add(bit);
                    while (in_scan<in.length) {
                        buffer.add(",");
                        bit=in[in_scan++];
                        if (rule_scan.hasNext()) {
                            rule = rule_scan.next();
                        }
                        if (bit!=null) {
                            bit=rule.mutate(bit);
                        }
                        if (bit==null) bit=SINGLE;
                        buffer.add(bit);
                    }
                    continue;
                }
            }
            
            if (bit==null) bit=SINGLE;
            buffer.add(bit);
        }

        if (in_scan<in.length) return null;
        
        // TODO Auto-generated method stub

        Expr ret = buffer;
        
        if (depend!=null) {
            ret=new DependentExpr(ret,depend);
        }
        if (call) {
            ret=new SystemCallExpr(ret);
        }

        result.setExpr(ret);
        return result;
    }

    @Override
    public int getMax() {
        return maxParam;
    }

    @Override
    public int getMin() {
        return minParam;
    }

    @Override
    public ExprType getType() {
        return out;
    }
}
