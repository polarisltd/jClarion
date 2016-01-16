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
package org.jclarion.clarion.compile.grammar;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.ReturningExpr;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.setting.EquateDefSettingParser;
import org.jclarion.clarion.compile.setting.ExprSettingParser;
import org.jclarion.clarion.compile.setting.JoinedSettingParser;
import org.jclarion.clarion.compile.setting.SettingParser;
import org.jclarion.clarion.compile.setting.SettingResult;
import org.jclarion.clarion.compile.setting.SimpleSettingParser;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class PrototypeParser extends AbstractParser 
{
    public PrototypeParser(ClarionCompiler compiler,Parser parser) 
    {
        super(compiler,parser);
    }
    
    private static Set<String> procedureLabels = GrammarHelper.list(
            "code","execute","accept","break",
            "cycle","do","elsif","else","loop","while",
            "until","function","procedure","end",
            "routine","return","of","orof","case","begin");
 
    public boolean isProcedureLabel(String test)
    {
        return !procedureLabels.contains(test.toLowerCase());
    }
    
    public String procedureLabel()
    {
        Lex l = la();
        if (l.type!=LexType.label) return null;
        if (procedureLabels.contains(l.value.toLowerCase())) return null;
        return next().value;
    }    
    public ExprType getType()
    {
        return getType(next());
    }
        
    public ExprType getType(Lex tlex)
    {
        ExprType type=null;
     
        if (tlex.type==LexType.use) return ExprType.any;
        
        if (tlex.type!=LexType.label) error("Expected label");
        
        // try for simple type
        type=ExprType.get(collapseType(tlex.value.toString()));
        
        if (type==null) type=compiler.getScope().getType(tlex.value);
        
        // create placeholder type and hope it gets resolved 
        // in the near future
        if (type==null) {
            type=compiler.dangles().get(tlex.value);
            compiler.getScope().addType(type);
            //MainScope.main.addType(type);
        }
        
        return type;
    }

    public Param[] getParams(boolean implementation)
    {
        if (la().type!=LexType.lparam) return new Param[0];
        next();
        if (la().type==LexType.rparam) {
            next();
            return new Param[0];
        }

        List<Param> params=new ArrayList<Param>();
        
        while ( true ) {
            if (la().type==LexType.eof) error("Unexpected EOF");
            
            params.add(getParam(implementation));
            
            if (la().type==LexType.param) {
                next();
            } else {
                break;
            }
        }
        
        if (next().type!=LexType.rparam) error("Expected ')'");
        
        return (Param[])params.toArray(new Param[params.size()]);
    }
    
    /**
     * Get prototype param format is
     * 
     *  '<' [CONST] {type} {label} [=expr] '>' 
     *  
     *  if implementation is false then label is optional
     *  if implementation is true then type is optional
     *  
     * @return
     */
    public Param getParam(boolean implementation)
    {
        
        boolean optional = false;
        boolean reference = false;
        boolean constant = false;
        ExprType type=null;
        String label=null;
        Expr paramDefault=null;
        
        if (la().value.equals("<")) {
            optional=true;
            next();
        }
        
        if (la().value.equalsIgnoreCase("const")) {
            next();
            constant=true;
        }
        
        boolean typeDefined = !implementation;
        // try and get type
        if (la().value.equals("*")) {
            next();
            typeDefined=true;
            reference=true;
        }

        // peek ahead if we have labels before ',' ')' or nl then we have a typedef
        if (!typeDefined) {
            int scan=1;
            while (true) {
                Lex la = la(scan++);
                if (la.type==LexType.eof) break;
                if (la.type==LexType.nl) break;
                if (la.type==LexType.param) break;
                if (la.type==LexType.rparam) break;
                if (la.type==LexType.label) {
                    typeDefined=true;
                    break;
                }
            }
        }

        if (typeDefined) {
            type = getType();
        }
        
        // next get label
        if (la().type==LexType.label) {
            label=next().value;
        }
        
        if (implementation && label==null) error("Label not specified"); 

        if (la().value.equals("=")) {
            next();
            paramDefault=parser().expression().cast(type);
        }
        
        if (optional) {
            if (!next().value.equals(">")) error("Expected '>'");
        }
        
        return new Param(
                label,type,reference,
                (optional || paramDefault!=null)?true:false,
                paramDefault,constant);
    }
    
    
    private SettingParser<?> prototypeSettings = new JoinedSettingParser(
        new SimpleSettingParser("raw","pascal","type","proc","derived","virtual","protected","private"),
        new ExprSettingParser("name"),
        new EquateDefSettingParser("dll", false),
        new SettingParser<ReturningExpr>() {
            @Override
            public SettingResult<ReturningExpr> get(Parser p) {
                
                boolean reference=false; 
                
                if (p.la().value.equals("*")) {
                    reference=true;
                    next();
                }
                
                return new SettingResult<ReturningExpr>("return",new ReturningExpr(getType(),reference));
            }
            
        }
    );

    public Procedure getModulePrototype()
    {
        Procedure p = getPrototype();
        if (p!=null) return p;

        if (la().type!=LexType.ws) return null;
        if (la(1).type!=LexType.label) return null;

        setIgnoreWhiteSpace(true);
        int pos = begin();

        String label = procedureLabel();
        if (label==null) {
            setIgnoreWhiteSpace(false);
            rollback(pos);
            return null;
        }
        commit(pos);
        
        Param[] params = getParams(false);
        
        p=new Procedure(label,params);
        
        SettingResult<?> r[] = prototypeSettings.getArray(parser());
        for (int scan=0;scan<r.length;scan++) {
            String name = r[scan].getName();
            Object value = r[scan].getValue();
            
            if (value instanceof Boolean) {
                p.setModifier(name);
                continue;
            }
            
            if (name.equalsIgnoreCase("name")) {
                p.setExternalName(value.toString());
                continue;
            }
            
            if (name.equalsIgnoreCase("return")) {
                p.setResult((ReturningExpr)value);
            }
        }

        emptyAll();
        
        return p;
    }
    
    public Procedure getPrototype()
    {
        int pos = begin();
        
        if (la().type==LexType.ws) next();
        Lex label = next();
        if (label.type!=LexType.label) {
            rollback(pos);
            return null;
        }
        
        setIgnoreWhiteSpace(true);
        
        Lex proctype=next();
        if (!proctype.value.equalsIgnoreCase("procedure") && !proctype.value.equalsIgnoreCase("function")) {
            setIgnoreWhiteSpace(false);
            rollback(pos);
            return null;
        }
        
        commit(pos);

        Param[] params=getParams(false);
        Procedure p = new Procedure(label.value,params);
        
        SettingResult<?> r[] = prototypeSettings.getArray(parser());
        for (int scan=0;scan<r.length;scan++) {
            String name = r[scan].getName();
            Object value = r[scan].getValue();
            
            if (value instanceof Boolean) {
                p.setModifier(name);
                continue;
            }

            if (name.equalsIgnoreCase("name")) {
                p.setExternalName(value.toString());
                continue;
            }
            
            if (name.equalsIgnoreCase("return")) {
                p.setResult((ReturningExpr)value);
            }
        }

        emptyAll();
        
        return p;
    }
    
    public boolean getMap()
    {
        if (la().type!=LexType.ws || la(1).type!=LexType.label || !la(1).value.equalsIgnoreCase("map")) 
            return false;
        
        setIgnoreWhiteSpace(true);
        next();

        parser().setMode(ParserMode.MAP);
        
        emptyEnd();
        
        getMapContents();

        end();
        parser().setMode(ParserMode.DATA);
        emptyAny();
        return true;
    }
        
    
    public void getMapContents()
    {
        while ( true ) {
            if (isIgnoreWhiteSpace()) break;
            if (getModule()) continue; 
            Procedure p = getModulePrototype();
            if (p!=null) {
                Scope s = compiler.getScope();
                s.addProcedure(p,!(s instanceof ModuleScope));
                continue;
            }
            break;
        }
    }
    
    private static ModuleScope module;
    
    public boolean getModule()
    {
        if (la().type!=LexType.ws) return false;
        if (la(1).type!=LexType.label) return false;
        if (!la(1).value.equalsIgnoreCase("module")) return false;
        
        setIgnoreWhiteSpace(true);
        next();
        parser().setMode(ParserMode.MODULE);

        if (next().type!=LexType.lparam) error("Expected '('");
        String name=next().value;
        if (next().type!=LexType.rparam) error("Expected ')'");

        module = compiler.main().get(name);
        
        emptyEnd();

        getModuleContents();

        emptyEnd();
        end();
        parser().setMode(ParserMode.MAP);
        emptyAny();
        
        return true;
    }
    
    public void getModuleContents()
    {
        while ( true ) {
            if (isIgnoreWhiteSpace()) break;
            Procedure p = getModulePrototype();
            if (p!=null) {
                p=module.addProcedure(p,false);
                compiler.getScope().addProcedure(p,true);
                continue;
            }
            break;
        }
    }
}
