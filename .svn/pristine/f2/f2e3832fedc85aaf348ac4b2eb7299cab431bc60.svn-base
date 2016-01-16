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
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.ExprJavaCode;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.java.SimpleJavaCode;
import org.jclarion.clarion.compile.rewrite.PatternRewriter;
import org.jclarion.clarion.compile.rewrite.RewriteFactory;
import org.jclarion.clarion.compile.scope.MethodScope;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.ProcedureScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;
import org.jclarion.clarion.compile.setting.ExprListSettingParser;
import org.jclarion.clarion.compile.setting.ExprSettingParser;
import org.jclarion.clarion.compile.setting.JoinedSettingParser;
import org.jclarion.clarion.compile.setting.LabelPropertySettingParser;
import org.jclarion.clarion.compile.setting.SettingParser;
import org.jclarion.clarion.compile.setting.SettingResult;
import org.jclarion.clarion.compile.setting.SimpleSettingParser;
import org.jclarion.clarion.compile.var.AliasVariable;
import org.jclarion.clarion.compile.var.ControlVariable;
import org.jclarion.clarion.compile.var.UseVar;
import org.jclarion.clarion.compile.var.UseVarSettingParser;
import org.jclarion.clarion.compile.var.UseVariable;
import org.jclarion.clarion.compile.var.TargetConstruct;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class TargetParser extends AbstractParser
{
    private static Logger log = Logger.getLogger(TargetParser.class.getName()); 

    public TargetParser(Parser parser, Lexer input) {
        super(parser, input);
    }
    
    private static SettingParser<?> controlSetting = new JoinedSettingParser(
            new UseVarSettingParser()
            ,new ExprSettingParser("right","left","decimal")
            ,new SimpleSettingParser("right","left","decimal","full","hscroll","vscroll","hvscroll","sum",
            "skip","req","center","trn","boxed","disable","hide","imm","pageno","separator")
            ,new ExprSettingParser("msg","tip","color","fill","key","hlp","reset","tally","std")
            ,new ExprListSettingParser("font",1,5)
            ,new ExprListSettingParser("at",2,4)
            ,new ExprListSettingParser("bevel",1,3)
    );

    private static RewriteFactory stringFactory = new RewriteFactory(
            PatternRewriter.create("pageno","setPageNo()") 
            ,PatternRewriter.create("sum","setSum()") 
            ,PatternRewriter.create("reset","setReset($)",ExprType.control) 
            ,PatternRewriter.create("tally","setTally($)",ExprType.control) 
    );

    
    private static RewriteFactory controlFactory = new RewriteFactory(
            PatternRewriter.create("text","setText($)").add(ExprType.rawstring,ExprType.string) 
            ,PatternRewriter.create("picture","setPicture($)",ExprType.picture) 
            ,PatternRewriter.create("center","setCenter()") 
            ,PatternRewriter.create("left","setLeft($)",ExprType.rawint).min(0) 
            ,PatternRewriter.create("right","setRight($)",ExprType.rawint).min(0) 
            ,PatternRewriter.create("decimal","setDecimal($)",ExprType.rawint).min(0) 
            ,PatternRewriter.create("boxed","setBoxed()") 
            ,PatternRewriter.create("bevel","setBevel($,$,$)",ExprType.rawint).range(1,3) 
            ,PatternRewriter.create("std","setStandard($)",ExprType.rawint) 
            ,PatternRewriter.create("at","setAt($,$,$,$)",ExprType.rawint).range(2,4)
            ,PatternRewriter.create("font","setFont($,$,$,$,$)",ExprType.rawstring,ExprType.rawint).range(1,5) 
            ,PatternRewriter.create("color","setColor($,$,$)",ExprType.rawint).range(1,3) 
            ,PatternRewriter.create("hlp","setHelp($)",ExprType.rawstring) 
            ,PatternRewriter.create("msg","setMsg($)",ExprType.rawstring) 
            ,PatternRewriter.create("tip","setTip($)",ExprType.rawstring) 
            ,PatternRewriter.create("alrt","setAlrt($)").add(ExprType.rawint,ExprType.rawstring) 
            ,PatternRewriter.create("imm","setImmediate()") 
            ,PatternRewriter.create("trn","setTransparent()") 
            ,PatternRewriter.create("disable","setDisabled()") 
            ,PatternRewriter.create("hide","setHidden()") 
            ,PatternRewriter.create("skip","setSkip()") 
    );

    private SettingParser<?> listSetting = new JoinedSettingParser(
            new SimpleSettingParser("full","column","nobar","hvscroll","vscroll")
            ,new ExprSettingParser("format","from","alrt","drop")
            ,controlSetting);

    private static RewriteFactory listFactory = new RewriteFactory(
            PatternRewriter.create("hvscroll","setHVScroll()") 
            ,PatternRewriter.create("vscroll","setVScroll()") 
            ,PatternRewriter.create("nobar","setNoBar()") 
            ,PatternRewriter.create("full","setFull()") 
            ,PatternRewriter.create("column","setColumn()") 
            ,PatternRewriter.create("from","setFrom($)",ExprType.queue) 
            ,PatternRewriter.create("format","setFormat($)",ExprType.rawstring) 
            ,PatternRewriter.create("drop","setDrop($)",ExprType.rawint) 
    );

    private SettingParser<?> textSetting = new JoinedSettingParser(
            new SimpleSettingParser("readonly","resize")
            ,controlSetting);

    private static RewriteFactory textFactory = new RewriteFactory(
            PatternRewriter.create("readonly","setReadOnly()") 
            ,PatternRewriter.create("resize","setResize()") 
            ,PatternRewriter.create("vscroll","setVScroll()") 
            ,PatternRewriter.create("hvscroll","setHVScroll()") 
            ,PatternRewriter.create("full","setFull()") 
    );

    private SettingParser<?> spinSetting = new JoinedSettingParser(
            new ExprSettingParser("step")
            ,new ExprListSettingParser("range",2,2)
            ,controlSetting);

    private static RewriteFactory spinFactory = new RewriteFactory(
            PatternRewriter.create("range","setRange($,$)",ExprType.rawint) 
            ,PatternRewriter.create("step","setStep($)",ExprType.rawint) 
    );
    
    private SettingParser<?> progressSetting = new JoinedSettingParser(
            new ExprListSettingParser("range",2,2)
            ,controlSetting);

    private static RewriteFactory progressFactory = new RewriteFactory(
            PatternRewriter.create("range","setRange($,$)",ExprType.rawint) 
    );
    
    private SettingParser<?> checkSetting = new JoinedSettingParser(
            new SimpleSettingParser("flat")
            ,new ExprSettingParser("icon")
            ,new ExprListSettingParser("value",2,2)
            ,controlSetting);

    private static RewriteFactory checkFactory = new RewriteFactory(
            PatternRewriter.create("value","setValue($,$)",ExprType.rawstring) 
            ,PatternRewriter.create("icon","setIcon($)",ExprType.rawstring) 
            ,PatternRewriter.create("flat","setFlat()") 
            ,PatternRewriter.create("key","setKey($)").add(ExprType.rawint,ExprType.rawstring) 
    );
    
    
    private SettingParser<?> radioSetting = new JoinedSettingParser(
            new SimpleSettingParser("flat")
            ,new ExprSettingParser("value","icon")
            ,controlSetting);

    private static RewriteFactory radioFactory = new RewriteFactory(
            PatternRewriter.create("flat","setFlat()") 
            ,PatternRewriter.create("value","setValue($)",ExprType.rawstring) 
            ,PatternRewriter.create("icon","setIcon($)",ExprType.rawstring) 
            ,PatternRewriter.create("key","setKey($)").add(ExprType.rawint,ExprType.rawstring) 
    );
    
    
    private SettingParser<?> imageSetting = new JoinedSettingParser(
            new SimpleSettingParser("centered")
            ,controlSetting);

    private static RewriteFactory imageFactory = new RewriteFactory(
            PatternRewriter.create("hvscroll","setHVScroll()") 
            ,PatternRewriter.create("centered","setCentered()") 
    );
    
    private SettingParser<?> entrySetting = new JoinedSettingParser(
            new SimpleSettingParser("readonly","upr","password","req")
            ,controlSetting);
    
    private static RewriteFactory entryFactory = new RewriteFactory(
            PatternRewriter.create("readonly","setReadOnly()") 
            ,PatternRewriter.create("upr","setUpper()") 
            ,PatternRewriter.create("req","setRequired()") 
            ,PatternRewriter.create("password","setPassword()") 
    );

    private SettingParser<?> sheetSetting = new JoinedSettingParser(
            new SimpleSettingParser("wizard","nosheet","spread")
            ,controlSetting);
    
    private static RewriteFactory sheetFactory = new RewriteFactory(
            PatternRewriter.create("wizard","setWizard()") 
            ,PatternRewriter.create("nosheet","setNoSheet()") 
            ,PatternRewriter.create("spread","setSpread()") 
            ,PatternRewriter.create("password","setPassword()") 
    );
    
    private SettingParser<?> buttonSetting = new JoinedSettingParser(
            new SimpleSettingParser("default","flat")
            ,new ExprSettingParser("icon","repeat","delay")
            ,controlSetting
    );
    private static RewriteFactory buttonFactory = new RewriteFactory(
            PatternRewriter.create("default","setDefault()") 
            ,PatternRewriter.create("flat","setFlat()") 
            ,PatternRewriter.create("icon","setIcon($)",ExprType.rawstring) 
            ,PatternRewriter.create("repeat","setRepeat($)",ExprType.rawint) 
            ,PatternRewriter.create("delay","setDelay($)",ExprType.rawint) 
            ,PatternRewriter.create("key","setKey($)").add(ExprType.rawint,ExprType.rawstring) 
    );

    private SettingParser<?> lineSetting = new JoinedSettingParser(
            new ExprSettingParser("linewidth")
            ,controlSetting
    );
    private static RewriteFactory lineFactory = new RewriteFactory(
            PatternRewriter.create("linewidth","setLineWidth($)",ExprType.rawint) 
    );

    private SettingParser<?> boxSetting = new JoinedSettingParser(
            new SimpleSettingParser("round")
            ,new ExprSettingParser("linewidth")
            ,controlSetting
    );

    private static RewriteFactory boxFactory = new RewriteFactory(
            PatternRewriter.create("linewidth","setLineWidth($)",ExprType.rawint) 
            ,PatternRewriter.create("round","setRound()") 
            ,PatternRewriter.create("fill","setFillColor($)",ExprType.rawint) 
    );
    
    private static RewriteFactory panelFactory = new RewriteFactory(
            PatternRewriter.create("fill","setFillColor($)",ExprType.rawint) 
    );
    
    private static SettingParser<?> windowSetting = new JoinedSettingParser(
            new SimpleSettingParser("toolbox","auto","hvscroll","vscroll",
            "noframe","modal","centered","maximize","max","resize","center","gray",
            "double","mdi","system","imm","tiled")
            ,new ExprSettingParser("icon","color","timer","hlp","alrt")
            ,new ExprListSettingParser("font",1,5)
            ,new ExprListSettingParser("at",4,4)
            ,new ExprListSettingParser("status",0,100)
    );

    private static RewriteFactory windowFactory = new RewriteFactory(
            PatternRewriter.create("text","setText($)").add(ExprType.rawstring,ExprType.string) 
            ,PatternRewriter.create("imm","setImmediate()") 
            ,PatternRewriter.create("tiled","setTiled()") 
            ,PatternRewriter.create("icon","setIcon($)",ExprType.rawstring) 
            ,PatternRewriter.create("at","setAt($,$,$,$)",ExprType.rawint) 
            ,PatternRewriter.create("font","setFont($,$,$,$,$)",ExprType.rawstring,ExprType.rawint).range(1,5) 
            ,PatternRewriter.create("center","setCenter()") 
            ,PatternRewriter.create("centered","setCentered()") 
            ,PatternRewriter.create("maximize","setMaximize()") 
            ,PatternRewriter.create("mdi","setMDI()") 
            ,PatternRewriter.create("system","setSystem()") 
            ,PatternRewriter.create("vscroll","setVScroll()") 
            ,PatternRewriter.create("hvscroll","setHVScroll()") 
            ,PatternRewriter.create("gray","setGray()") 
            ,PatternRewriter.create("double","setDouble()") 
            ,PatternRewriter.create("noframe","setNoFrame()") 
            ,PatternRewriter.create("resize","setResize()") 
            ,PatternRewriter.create("toolbox","setToolbox()") 
            ,PatternRewriter.create("hlp","setHelp($)",ExprType.rawstring) 
            ,PatternRewriter.create("max","setMax()") 
            ,PatternRewriter.create("modal","setModal()") 
            ,PatternRewriter.create("timer","setTimer($)",ExprType.rawint) 
            ,PatternRewriter.create("color","setColor($,$,$)",ExprType.rawint).range(1,3) 
            ,PatternRewriter.create("status","setStatus(@)",ExprType.rawint) 
    );

    private static SettingParser<?> reportSetting = new JoinedSettingParser(
            new SimpleSettingParser("trn","thous","landscape","mm")
            ,new ExprSettingParser("preview")
            ,new ExprListSettingParser("paper",1,3)
            ,new ExprListSettingParser("font",1,5)
            ,new ExprListSettingParser("at",4,4)
            ,new LabelPropertySettingParser("pre","")
    );

    private static RewriteFactory reportFactory = new RewriteFactory(
            PatternRewriter.create("text","setText($)").add(ExprType.rawstring,ExprType.string) 
            ,PatternRewriter.create("trn","setTransparent()") 
            ,PatternRewriter.create("thous","setThous()") 
            ,PatternRewriter.create("mm","setMM()") 
            ,PatternRewriter.create("landscape","setLandscape()") 
            ,PatternRewriter.create("at","setAt($,$,$,$)",ExprType.rawint) 
            ,PatternRewriter.create("font","setFont($,$,$,$,$)",ExprType.rawstring,ExprType.rawint).range(1,5) 
            ,PatternRewriter.create("paper","setPaper($,$,$)",ExprType.rawint).range(1,3) 
            ,PatternRewriter.create("preview","setPreview($)",ExprType.queue) 
    );
    
    private static SettingParser<?> reportComponentSetting = new JoinedSettingParser(
            new SimpleSettingParser("absolute")
            ,new ExprSettingParser("withprior","withnext")
            ,new ExprListSettingParser("font",1,5)
            ,new ExprListSettingParser("at",4,4)
            ,new UseVarSettingParser()
    );
    
    private static RewriteFactory reportComponentFactory = new RewriteFactory(
        PatternRewriter.create("breakvar","setVariable($)",ExprType.any) 
        ,PatternRewriter.create("absolute","setAbsolute()") 
        ,PatternRewriter.create("font","setFont($,$,$,$,$)",ExprType.rawstring,ExprType.rawint).range(1,5) 
        ,PatternRewriter.create("withprior","setWithPrior($)",ExprType.rawint) 
        ,PatternRewriter.create("withnext","setWithNext($)",ExprType.rawint)
    );
    
    private static final String ILLEGAL = "[^a-z0-9:_.]"; 
    //private static final String ILLEGAL = "."; 
    
    private Set<String> names=new HashSet<String>();
    
    public void getWindowDefinition(String label,ExprType type) {

        TargetConstruct wc = new TargetConstruct(label,type);
        ScopeStack.pushScope(wc);
        
        List<SettingResult<?>> results=new ArrayList<SettingResult<?>>();
        readOption(results);
        windowSetting.getList(parser(),results);
        
        emptyAll();

        StringBuilder id = new StringBuilder();
        genID(id,wc.getParent());
        if (id.length()>0) id.append(".");
        id.append(label);
        String sid = id.toString().toLowerCase().trim().replaceAll(ILLEGAL,"");
        if (names.contains(sid)) error("Generated ID is not unique : "+sid);
        names.add(sid);
        
        init(sid,"this",wc,results,windowFactory);
        TargetOverrides.getInstance().addOverrides(wc.getJavaClass(),"this",sid);
        wc.getJavaClass().addInit(
            new SimpleJavaCode("this.setId(\""+sid+"\");"));
        
        while (readControls(wc,"this",sid)) { }

        emptyEnd();
        end();
        emptyAny();

        ScopeStack.popScope();
        
        ScopeStack.getScope().addVariable(wc.getVariable());
    }

    private void genID(StringBuilder id,Scope wc)
    {
        genID(id,wc,null);
    }
    
    private void genID(StringBuilder id, Scope wc,Scope child) {
        if (wc==null) return;
        if ((wc instanceof ModuleScope) && child!=null) return;
        genID(id,wc.getParent(),wc);

        if (id.length()>0) {
            id.append(".");
        }
        
        if (wc instanceof MethodScope) {
            id.append(((MethodScope)wc).getClassScope().getName());
            id.append(".");
        }

        if (wc instanceof ProcedureScope) {
            id.append(((ProcedureScope)wc).getProcedure().getName());
        } else {
            id.append(wc.getName());
        }
    }

    public void getReportDefinition(String label) {

        TargetConstruct wc = new TargetConstruct(label,ExprType.report);
        ScopeStack.pushScope(wc);
        
        List<SettingResult<?>> results=new ArrayList<SettingResult<?>>();
        readOption(results);
        reportSetting.getList(parser(),results);
        
        emptyAll();

        String pre=null;
        Iterator<SettingResult<?>> iterator = results.iterator();
        while (iterator.hasNext()) {
            SettingResult<?> sr = iterator.next();
            if (sr.getName().equals("pre")) {
                iterator.remove();
                pre=(String)sr.getValue();
            }
        }
        
        init(null,"this",wc,results,reportFactory);

        while (readReportControls(wc,"this")) { }

        emptyEnd();
        end();
        emptyAny();

        ScopeStack.popScope();
        
        ScopeStack.getScope().addVariable(wc.getVariable());
        if (pre!=null) {
            ScopeStack.getScope().addVariable(new AliasVariable(pre,wc.getVariable(),false));    
        }
    }
    
    private static Set<String> reportControls = GrammarHelper.list("detail","header","footer","form","break");

    private boolean readReportControls(TargetConstruct wc, String parent) 
    {
        int pos = begin();
        
        String label = null;
        if (la().type==LexType.label) {
            label=next().value;
            label.toString(); // put here to suppress warning msg above
        }
        
        setIgnoreWhiteSpace(true);
        
        if (la().type!=LexType.label) {
            rollback(pos);
            setIgnoreWhiteSpace(false);
            return false;
        }
        
        String key = next().value.toLowerCase();
        if (!reportControls.contains(key)) {
            rollback(pos);
            setIgnoreWhiteSpace(false);
            return false;
        }

        commit(pos);
        
        List<SettingResult<?>> results=new ArrayList<SettingResult<?>>();
        
        if (key.equals("break")) {
            if (next().type!=LexType.lparam) error("Expected '('");
            Expr e = parser().expression();
            if (e==null) error("Expexted variable'");
            if (!(e instanceof VariableExpr)) error("Expexted variable'");
            results.add(new SettingResult<Expr>("breakvar",e));
            if (next().type!=LexType.rparam) error("Expected ')'");
        }
        
        reportComponentSetting.getList(parser(),results);
        
        String type = initControl(null,label,parent,wc,
            "Report"+GrammarHelper.capitalise(key),results,
            reportComponentFactory,controlFactory);

        emptyAll();
        
        if (key.equals("break")) {
            while (readReportControls(wc, type)) {}
        } else {
            while (readControls(wc, type,null)) {}
        }

        emptyEnd();
        end();
        emptyAny();
        
        return true;
    }
    
    
    private boolean readControls(TargetConstruct wc, String parent,String sid) {
        
        int pos = begin();
        
        String label = null;
        if (la().type==LexType.label) {
            label=next().value;
            label.toString();
        }
        
        setIgnoreWhiteSpace(true);
        
        if (la().type!=LexType.label) {
            rollback(pos);
            setIgnoreWhiteSpace(false);
            return false;
        }
        
        String key = next().value;

        List<SettingResult<?>> results=new ArrayList<SettingResult<?>>();
        
        if (key.equalsIgnoreCase("string")) {
            commit(pos);
            readOption(results);
            controlSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"StringControl",results,stringFactory,controlFactory);
            return true;
        }

        if (key.equalsIgnoreCase("spin")) {
            commit(pos);
            readOption(results);
            spinSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"SpinControl",results,spinFactory,controlFactory);
            return true;
        }

        if (key.equalsIgnoreCase("progress")) {
            commit(pos);
            readOption(results);
            progressSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"ProgressControl",results,progressFactory,controlFactory);
            return true;
        }
        
        if (key.equalsIgnoreCase("list")) {
            commit(pos);
            readOption(results);
            listSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"ListControl",results,listFactory,controlFactory);
            return true;
        }

        if (key.equalsIgnoreCase("combo")) {
            commit(pos);
            readOption(results);
            listSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"ComboControl",results,listFactory,controlFactory);
            return true;
        }
        
        
        if (key.equalsIgnoreCase("image")) {
            commit(pos);
            readOption(results);
            imageSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"ImageControl",results,imageFactory,controlFactory);
            return true;
        }

        if (key.equalsIgnoreCase("text")) {
            commit(pos);
            readOption(results);
            textSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"TextControl",results,textFactory,controlFactory);
            return true;
        }
        
        if (key.equalsIgnoreCase("box")) {
            commit(pos);
            readOption(results);
            boxSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"BoxControl",results,boxFactory,controlFactory);
            return true;
        }
        
        if (key.equalsIgnoreCase("prompt")) {
            commit(pos);
            readOption(results);
            entrySetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"PromptControl",results,controlFactory);
            return true;
        }
        
        if (key.equalsIgnoreCase("button")) {
            commit(pos);
            readOption(results);
            buttonSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"ButtonControl",results,buttonFactory,controlFactory);
            return true;
        }

        if (key.equalsIgnoreCase("line")) {
            commit(pos);
            lineSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"LineControl",results,lineFactory,controlFactory);
            return true;
        }

        if (key.equalsIgnoreCase("entry")) {
            commit(pos);
            readOption(results);
            entrySetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"EntryControl",results,entryFactory,controlFactory);
            return true;
        }

        if (key.equalsIgnoreCase("radio")) {
            commit(pos);
            readOption(results);
            radioSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"RadioControl",results,radioFactory,controlFactory);
            return true;
        }

        if (key.equalsIgnoreCase("check")) {
            commit(pos);
            readOption(results);
            checkSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"CheckControl",results,checkFactory,controlFactory);
            return true;
        }

        
        if (key.equalsIgnoreCase("group")) {
            commit(pos);
            readOption(results);
            controlSetting.getList(parser(),results);
            emptyAll();
            String gn = initControl(sid,label,parent,wc,"GroupControl",results,controlFactory);
            while (readControls(wc,gn,sid)) { }

            emptyEnd();
            end();
            emptyAny();
            
            return true;
        }

        if (key.equalsIgnoreCase("panel")) {
            commit(pos);
            readOption(results);
            controlSetting.getList(parser(),results);
            emptyAll();
            initControl(sid,label,parent,wc,"PanelControl",results,panelFactory,controlFactory);
            return true;
        }
        
        if (key.equalsIgnoreCase("option")) {
            commit(pos);
            readOption(results);
            controlSetting.getList(parser(),results);
            emptyAll();
            String gn = initControl(sid,label,parent,wc,"OptionControl",results,controlFactory);
            while (readControls(wc,gn,sid)) { }

            emptyEnd();
            end();
            emptyAny();
            
            return true;
        }
        
        if (key.equalsIgnoreCase("sheet")) {
            commit(pos);
            readOption(results);
            sheetSetting.getList(parser(),results);
            emptyAll();
            String gn = initControl(sid,label,parent,wc,"SheetControl",results,sheetFactory,controlFactory);
            while (readControls(wc,gn,sid)) { }

            emptyEnd();
            end();
            emptyAny();
            
            return true;
        }
        
        if (key.equalsIgnoreCase("tab")) {
            commit(pos);
            readOption(results);
            controlSetting.getList(parser(),results);
            emptyAll();
            String gn = initControl(sid,label,parent,wc,"TabControl",results,controlFactory);
            while (readControls(wc,gn,sid)) { }

            emptyEnd();
            end();
            emptyAny();
            
            return true;
        }
        
        if (key.equalsIgnoreCase("menubar")) {
            commit(pos);
            controlSetting.getList(parser(),results);
            emptyAll();
            String gn = initControl(sid,label,parent,wc,"MenubarControl",results,controlFactory);
            while (readControls(wc,gn,sid)) { }

            emptyEnd();
            end();
            emptyAny();
            
            return true;
        }

        if (key.equalsIgnoreCase("menu")) {
            commit(pos);
            readOption(results);
            controlSetting.getList(parser(),results);
            emptyAll();
            String gn = initControl(sid,label,parent,wc,"MenuControl",results,controlFactory);
            while (readControls(wc,gn,sid)) { }

            emptyEnd();
            end();
            emptyAny();
            
            return true;
        }

        if (key.equalsIgnoreCase("item")) {
            commit(pos);
            readOption(results);
            controlSetting.getList(parser(),results);
            emptyAll();
            
            boolean sep=false;
            for ( SettingResult<?> sr : results) {
                if (sr.getName().equals("separator")) sep=true;
            }
            
            if (sep) {
                Iterator<SettingResult<?>> sr = results.iterator();
                while (sr.hasNext()) {
                    if (sr.next().getName().equals("separator")) sr.remove();
                }
                initControl(sid,label,parent,wc,"SeparatorControl",results,controlFactory);
            } else {
                initControl(sid,label,parent,wc,"ItemControl",results,controlFactory);
            }
            return true;
        }
        
        
        rollback(pos);
        setIgnoreWhiteSpace(false);
        return false;
    }

    private void readOption(List<SettingResult<?>> results) {
        if (la().type==LexType.lparam) {
            next();
            Expr text=parser().expression();
            if (text!=null) {
                if (text.type().isa(ExprType.picture)) {
                    results.add(new SettingResult<Expr>("picture",text));
                } else {
                    results.add(new SettingResult<Expr>("text",text));
                }
            }
            if (next().type!=LexType.rparam) error("expected ')'");
        }
    }

    private static Expr[] emptyExpr=new Expr[0];

    private String initControl(String sid,String control,String parent, TargetConstruct wc, String type,
            List<SettingResult<?>> results, RewriteFactory... factories) 
    {
        if (control!=null) {
            control=Labeller.get(control,false);
        }
        
        String definedControl=control;
        
        if (control==null) {
            int id=wc.getNextControlID();
            control = "_C"+id;
        }
        
        if (definedControl==null) {
            wc.getJavaClass().addInit(new SimpleJavaCode(type+" "+control+"=new "+type+"();",ClarionCompiler.CLARION+".control."+type));
        } else {
            wc.addVariable(new ControlVariable(control,type));
            wc.getJavaClass().addInit(new SimpleJavaCode("this."+control+"=new "+type+"();",ClarionCompiler.CLARION+".control."+type));
        }
        
        if (definedControl!=null) {
            control="this."+control;
        }
        
        init(sid,control,wc,results,factories);
        wc.getJavaClass().addInit(new SimpleJavaCode(parent+".add("+control+");"));
        return control;
    }

    
    private void init(String sid,String prefix,TargetConstruct wc,List<SettingResult<?>> results,RewriteFactory... factories)
    {
        ExprBuffer bits[] = new ExprBuffer[factories.length];

        boolean any=false;
        
        UseVar uv=null;
        
        for ( SettingResult<?> setting : results ){
            String name = setting.getName();
            Object val = setting.getValue();
            
            if (name.equals("auto")) continue; /// ignore these ones
        
            if (val instanceof UseVar) {
                uv=(UseVar)val;
                continue;
            }
            
            Expr params[]=null;
            if (val instanceof Boolean) {
                params=emptyExpr;
            }
            if (val instanceof Expr) {
                params=new Expr[] { (Expr)val }; 
            }
            if (val instanceof Expr[]) {
                params=(Expr[])val;
            }
            
            if (params==null) error("Do not know how to deal with:"+name);

            boolean done=false;
            
            for (int scan=0;scan<factories.length;scan++) {
                Expr r = factories[scan].rewrite(name,params);
                if (r!=null) {
                    done=true;
                    any=true;
                    if (bits[scan]==null) {
                        bits[scan]=new ExprBuffer(0,null);
                    }
                    if (!bits[scan].isEmpty()) {
                        bits[scan].add(".");
                    }
                    bits[scan].add(r);
                }
            }
            if (!done) error("Do not know how to rewrite:"+name); 
        }

        if (any) {
            ExprBuffer combine= new ExprBuffer(0,null);
            combine.add(prefix);
            for (int scan=0;scan<bits.length;scan++) {
                if (bits[scan]==null) continue;
                combine.add(".");
                combine.add(bits[scan]);
            }
            combine.add(";");

            wc.getJavaClass().addInit(new ExprJavaCode(combine));
        }
        
        if (uv!=null) {
            UseVariable var = new UseVariable(wc,uv);
            
            // TODO: add to parent so parent can easily see it
            ScopeStack.getScope().getParent().addUseVariable(var);

            // add to window because window is real owner
            ScopeStack.getScope().addUseVariable(var);

            // initialise and register
            ExprBuffer eb = new ExprBuffer(0,null);
            eb.add("this.");
            eb.add(var.getJavaName());
            eb.add("=this.register(");
            eb.add(prefix);
            
            if (uv.getVariable()!=null) {
                if (uv.getVariable().type().isa(ExprType.any)) {
                    eb.add(".use(");
                    eb.add(uv.getVariable());
                    eb.add(")");
                } else {
                    log.warning("Inappropriate Use variable ignored:"+uv.getName());
                }
            }
            
            if (sid!=null) {
                
                sid=sid+"."+var.getName().toLowerCase().replaceAll(ILLEGAL,"");

                TargetOverrides.getInstance().addOverrides(wc.getJavaClass(),prefix,sid);            
                
                eb.add(",\"");
                eb.add(sid);
                eb.add("\");");
            } else {
                eb.add(");");
            }
            
            wc.getJavaClass().addInit(new ExprJavaCode(eb));
            
        } else {
            sid=null;
        }
        
    }

    //public JavaCode generate
    
    
}
