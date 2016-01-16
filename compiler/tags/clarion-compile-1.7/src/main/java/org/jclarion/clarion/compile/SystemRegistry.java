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
package org.jclarion.clarion.compile;

import java.util.HashSet;
import java.util.Set;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.rewrite.PatternRewriter;
import org.jclarion.clarion.compile.rewrite.RegisterRewriter;
import org.jclarion.clarion.compile.rewrite.RewriteFactory;
import org.jclarion.clarion.compile.rewrite.Rewriter;

/**
 * Register all standard clarion commands and classes here 
 * 
 * @author barney
 *
 */

public class SystemRegistry {

    private static SystemRegistry instance;
    
    public static SystemRegistry getInstance()
    {
        // assuming compiler is only even single threaded - no need
        // to synchronize instance construction
        if (instance==null) instance=new SystemRegistry();
        return instance;
    }
    
    private RewriteFactory factory;
    private Set<String> loadedFiles=new HashSet<String>(); 
    
    protected SystemRegistry()
    {
        factory=new RewriteFactory();
        init();
    }
    
    protected void init()
    {
        // views
        register(
         PatternRewriter.create(null,"open","$.open()",ExprType.view).call()
        ,PatternRewriter.create(null,"flush","$.flush()",ExprType.view).call()
        ,PatternRewriter.create(null,"close","$.close()",ExprType.view).call()
        ,PatternRewriter.create(null,"set","$.set()",ExprType.view).call()
        ,PatternRewriter.create(null,"delete","$.delete()",ExprType.view).call()
        ,PatternRewriter.create(null,"put","$.put()",ExprType.view).call()
        ,PatternRewriter.create(ExprType.rawint,"records","$.records()",ExprType.view).call()
        ,PatternRewriter.create(null,"watch","$.watch()",ExprType.view).call()
        ,PatternRewriter.create(null,"reset","$.reset($)",ExprType.view,ExprType.string).call()
        ,PatternRewriter.create(null,"reget","$.reget($)",ExprType.view,ExprType.string).call()
        ,PatternRewriter.create(null,"reset","$.reset($)",ExprType.view,ExprType.file).call()
        ,PatternRewriter.create(ExprType.string,"position","$.getPosition()",ExprType.view).call()
        ,PatternRewriter.create(null,"set","$.set($)",ExprType.view,ExprType.rawint).call()
        ,PatternRewriter.create(null,"next","$.next()",ExprType.view).call()
        ,PatternRewriter.create(null,"previous","$.previous()",ExprType.view).call()
        ,PatternRewriter.create(null,"buffer","$.buffer(@)",ExprType.view,ExprType.rawint).call().exact(5)
        );

        // clearing and memory
        register(
         PatternRewriter.create(null,"clear","$.clear()").add(ExprType.any,ExprType.group).call()
        ,PatternRewriter.create(null,"clear","CArray.clear($)",ExprType.any.changeArrayIndexCount(1)).call().rt("runtime.CArray")
        ,PatternRewriter.create(null,"clear","CArray.clear($)",ExprType.any.changeArrayIndexCount(2)).call().rt("runtime.CArray")
        ,PatternRewriter.create(null,"clear","$.clear($)").add(ExprType.any,ExprType.group).add(ExprType.rawint).call()
        ,PatternRewriter.create(null,"clear","CMemory.clear($)",ExprType.object).call().rt("runtime.CMemory")
        ,PatternRewriter.create(null,"size","CMemory.size($)",ExprType.object).call().rt("runtime.CMemory")
        );

        // misc variable manipulation routines
        register(
         PatternRewriter.create(null,"setnull","$.setNull()",ExprType.any).call()
        ,PatternRewriter.create(ExprType.any,"what","$.what($)",ExprType.group,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.rawint,"where","$.where($)",ExprType.group,ExprType.any).call()
        ,PatternRewriter.create(ExprType.string,"who","$.who($)",ExprType.group,ExprType.rawint).call()
        ,PatternRewriter.create(JavaPrec.RELATIONAL,ExprType.rawboolean,"isstring","($.getValue()) instanceof ClarionString",ExprType.any).rt("ClarionString")
        );

        // decimal
        register(
         PatternRewriter.create(ExprType.decimal,"abs","$.abs()",ExprType.decimal).call()
        ,PatternRewriter.create(ExprType.decimal,"round","$.round($)",ExprType.decimal,ExprType.rawint).call()
        );

        // number
        register(
         PatternRewriter.create(JavaPrec.BAND,ExprType.rawint,"band","$ & $",ExprType.rawint)
        ,PatternRewriter.create(JavaPrec.BOR,ExprType.rawint,"bor","$ | $",ExprType.rawint)
        ,PatternRewriter.create(JavaPrec.BXOR,ExprType.rawint,"bxor","$ ^ $",ExprType.rawint)
        ,PatternRewriter.create(ExprType.rawint,"bshift","ClarionNumber.shift($,$)",ExprType.rawint).call().rt("ClarionNumber")
        ,PatternRewriter.create(ExprType.rawint,"int","$.intValue()",ExprType.any).call()
        ,PatternRewriter.create(ExprType.number,"abs","$.abs()",ExprType.number).call()
        ,PatternRewriter.create(ExprType.rawint,"random","CRun.random($,$)",ExprType.rawint).call().rt("runtime.CRun")
        );
        
        // string manipulation
        register(
         PatternRewriter.create(ExprType.rawboolean,"numeric","$.isNumeric()",ExprType.any).call()
        ,PatternRewriter.create(ExprType.rawboolean,"isupper","$.isUpper()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.rawboolean,"isalpha","$.isAlpha()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.rawint,"instring",":2.inString(:1)",ExprType.rawstring,ExprType.string).call()
        ,PatternRewriter.create(ExprType.rawint,"instring",":2.inString(:1,:3,:4)",ExprType.rawstring,ExprType.string,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.string,"clip","$.clip()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.string,"sub","$.sub($,$)",ExprType.string,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.string,"format","$.format($)",ExprType.string).add(ExprType.rawstring,ExprType.picture).call()
        ,PatternRewriter.create(ExprType.string,"deformat","$.deformat($)",ExprType.string).add(ExprType.rawstring,ExprType.picture).call()
        ,PatternRewriter.create(ExprType.string,"left","$.left()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.string,"left","$.left($)",ExprType.string,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.string,"right","$.right()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.string,"right","$.right($)",ExprType.string,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.string,"center","$.center($)",ExprType.string,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.string,"center","$.center($)",ExprType.string,ExprType.rawint).call()
        ,PatternRewriter.create(ExprType.string,"lower","$.lower()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.string,"upper","$.upper()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.rawint,"len","$.len()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.rawint,"val","$.val()",ExprType.string).call()
        ,PatternRewriter.create(ExprType.string,"chr","ClarionString.chr($)",ExprType.rawint).call().rt("ClarionString")
        ,PatternRewriter.create(ExprType.string,"all","$.all($)",ExprType.string,ExprType.rawint).call()
        );

        // date manipulation
        register(
         PatternRewriter.create(ExprType.rawint,"today","CDate.today()").call().rt("runtime.CDate")
        ,PatternRewriter.create(ExprType.rawint,"clock","CDate.clock()").call().rt("runtime.CDate")
        ,PatternRewriter.create(ExprType.rawint,"date","CDate.date($,$,$)",ExprType.rawint).call().rt("runtime.CDate")
        ,PatternRewriter.create(ExprType.rawint,"year","CDate.year($)",ExprType.rawint).call().rt("runtime.CDate")
        ,PatternRewriter.create(ExprType.rawint,"month","CDate.month($)",ExprType.rawint).call().rt("runtime.CDate")
        ,PatternRewriter.create(ExprType.rawint,"day","CDate.day($)",ExprType.rawint).call().rt("runtime.CDate")
        );

        // errors
        register(
         PatternRewriter.create(ExprType.rawstring,"error","CError.error()").call().rt("runtime.CError")
        ,PatternRewriter.create(ExprType.rawstring,"fileerrorcode","CError.fileErrorCode()").call().rt("runtime.CError")
        ,PatternRewriter.create(ExprType.rawstring,"fileerror","CError.fileError()").call().rt("runtime.CError")
        ,PatternRewriter.create(ExprType.rawstring,"errorfile","CError.errorFile()").call().rt("runtime.CError")
        ,PatternRewriter.create(ExprType.rawint,"errorcode","CError.errorCode()").call().rt("runtime.CError")
        );

        // targets
        register(
         PatternRewriter.create(null,"open","$.open()",ExprType.target).call()
        ,PatternRewriter.create(null,"open","$.open($)",ExprType.window).call()
        ,PatternRewriter.create(null,"close","$.close()",ExprType.target).call()
        );
        
        // windowing - controls etc
        register(
         PatternRewriter.create(null,"disable","CWin.disable(@)",ExprType.rawint).call().range(1,2).rt("runtime.CWin")
        ,PatternRewriter.create(null,"enable","CWin.enable(@)",ExprType.rawint).call().range(1,2).rt("runtime.CWin")
        ,PatternRewriter.create(null,"hide","CWin.hide(@)",ExprType.rawint).call().range(1,2).rt("runtime.CWin")
        ,PatternRewriter.create(null,"unhide","CWin.unhide(@)",ExprType.rawint).call().range(1,2).rt("runtime.CWin")
        ,PatternRewriter.create(null,"select","CWin.select(@)",ExprType.rawint).call().range(1,3).rt("runtime.CWin")
        ,PatternRewriter.create(null,"select","CWin.select()").call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"update","CWin.update(@)",ExprType.rawint).call().range(1,2).rt("runtime.CWin")
        ,PatternRewriter.create(null,"update","CWin.update()").call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"select","CWin.select($,$)",ExprType.object,ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"change","CWin.change($,$)",ExprType.rawint,ExprType.any).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"alert","CWin.alert(@)",ExprType.rawint).range(1,2).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"event","CWin.event()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"field","CWin.field()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"focus","CWin.focus()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"accepted","CWin.accepted()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"keycode","CWin.keyCode()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"keychar","CWin.keyChar()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"keystate","CWin.keyState()").call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"setkeycode","CWin.setKeyCode($)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"setkeychar","CWin.setKeyChar($)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"presskey","CWin.pressKey($)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"forwardkey","CWin.forwardKey($)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"alias","CWin.aliasKey($,$)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"alias","CWin.clearAliasKey($)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"alias","CWin.clearAllAliasKeys()",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.string,"contents","CWin.contents($)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"choice","CWin.choice($)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"choice","CWin.choice()").call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"post","CWin.post(@)",ExprType.rawint).call().range(1,2).rt("runtime.CWin")
        ,PatternRewriter.create(null,"post","CWin.post($,$,$)",ExprType.rawint,ExprType.rawint,ExprType.object).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"display","CWin.display()").call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"display","CWin.display(@)",ExprType.rawint).call().range(1,2).rt("runtime.CWin")
        ,PatternRewriter.create(null,"setcursor","CWin.setCursor(@)",ExprType.rawstring).call().range(0,1).rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"mousex","CWin.getMouseX()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"mousey","CWin.getMouseY()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"popup","CWin.popup($)",ExprType.rawstring).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"popup","CWin.popup($,$,$)",ExprType.rawstring,ExprType.rawint).range(2,3).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"setposition","CWin.setPosition($,$,$,$,$)",ExprType.rawint).range(1,5).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"box","CWin.box($,$,$,$)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"getposition","CWin.getPosition($,$,$,$,$)",ExprType.rawint,ExprType.number).range(1,5).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"setfont","CWin.setFont($,$,$,$,$,$)",ExprType.rawint,ExprType.rawstring,ExprType.rawint).range(1,6).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"settarget","CWin.setTarget($)",ExprType.target).call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"settarget","CWin.setTarget()").call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"destroy","CWin.removeControl(@)",ExprType.rawint).call().range(1,2).rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"create","CWin.createControl($,$,$)",ExprType.rawint).call().range(2,3).rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"lastfield","CWin.getLastField()").call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"firstfield","CWin.getFirstField()").call().rt("runtime.CWin")
//        ,PatternRewriter.create(null,"registerevent","CWin.register($,$,$)",ExprType.rawint).call().rt("runtime.CWin")
//        ,PatternRewriter.create(null,"unregisterevent","CWin.unregister($,$,$)",ExprType.rawint).call().rt("runtime.CWin")
        ,new RegisterRewriter("registerevent","register")
        ,new RegisterRewriter("unregisterevent","unregister")
        );
        
        // queues
        register(
         PatternRewriter.create(null,"sort","$.sort($)",ExprType.queue,ExprType.string).call()
        ,PatternRewriter.create(null,"add","$.add()",ExprType.queue).call()
        ,PatternRewriter.create(null,"add","$.add($)",ExprType.queue).add(ExprType.string,ExprType.number,ExprType.any,ExprType.rawint).call()
        ,PatternRewriter.create(null,"get","$.get($)",ExprType.queue).add(ExprType.string,ExprType.number,ExprType.any,ExprType.rawint).call()
        ,PatternRewriter.create(null,"put","$.put()",ExprType.queue).call()
        ,PatternRewriter.create(null,"put","$.put($)",ExprType.queue,ExprType.string).call()
        ,PatternRewriter.create(null,"delete","$.delete()",ExprType.queue).call()
        ,PatternRewriter.create(null,"free","$.free()",ExprType.queue).call()
        ,PatternRewriter.create(ExprType.rawint,"records","$.records()",ExprType.queue).call()
        ,PatternRewriter.create(ExprType.rawint,"pointer","$.getPointer()",ExprType.queue).call()
        ,PatternRewriter.create(ExprType.rawint,"position","$.getPosition()",ExprType.queue).call()
        );

        // files
        register(
         PatternRewriter.create(null,"create","$.create()",ExprType.file).call()
        ,PatternRewriter.create(null,"open","$.open()",ExprType.file).call()
        ,PatternRewriter.create(null,"open","$.open($)",ExprType.file,ExprType.rawint).call()
        ,PatternRewriter.create(null,"flush","$.flush()",ExprType.file).call()
        ,PatternRewriter.create(null,"close","$.close()",ExprType.file).call()
        ,PatternRewriter.create(null,"watch","$.watch()",ExprType.file).call()
        ,PatternRewriter.create(null,"build","$.build()",ExprType.file).call()
        ,PatternRewriter.create(null,"stream","$.stream()",ExprType.file).call()
        ,PatternRewriter.create(ExprType.string,"position","$.getPosition()",ExprType.file).call()
        ,PatternRewriter.create(ExprType.rawint,"pointer","$.getPointer()",ExprType.file).call()
        ,PatternRewriter.create(ExprType.rawstring,"name","$.getName()",ExprType.file).call()
        ,PatternRewriter.create(null,"reget","$.reget($)").add(ExprType.file,ExprType.key).add(ExprType.string).call()
        ,PatternRewriter.create(null,"reset","$.reget($)").add(ExprType.file,ExprType.key).add(ExprType.string).call()
        ,PatternRewriter.create(null,"remove","$.remove()",ExprType.file).call()
        ,PatternRewriter.create(null,"send","$.send($)",ExprType.file,ExprType.rawstring).call()
        ,PatternRewriter.create(null,"next","$.next()",ExprType.file).call()
        ,PatternRewriter.create(null,"previous","$.previous()",ExprType.file).call()
        ,PatternRewriter.create(ExprType.rawboolean,"eof","$.eof()",ExprType.file).call()
        ,PatternRewriter.create(ExprType.rawboolean,"bof","$.bof()",ExprType.file).call()
        ,PatternRewriter.create(null,"add","$.add()",ExprType.file).call()
        ,PatternRewriter.create(null,"add","$.add($)",ExprType.file,ExprType.rawint).call()
        ,PatternRewriter.create(null,"put","$.put()",ExprType.file).call()
        ,PatternRewriter.create(null,"delete","$.delete()",ExprType.file).call()
        ,PatternRewriter.create(null,"exists","$.exists()",ExprType.file).call()
        ,PatternRewriter.create(null,"lock","$.lock()",ExprType.file).call()
        ,PatternRewriter.create(null,"unlock","$.unlock()",ExprType.file).call()
        ,PatternRewriter.create(ExprType.rawint,"records","$.records()",ExprType.file).call()
        ,PatternRewriter.create(null,"get","$.get($)",ExprType.file,ExprType.key).call()
        ,PatternRewriter.create(null,"get","$.get($,$)").add(ExprType.file).add(ExprType.string,ExprType.number).add(ExprType.rawint).call().range(2,3)
        ,PatternRewriter.create(null,"set","$.set()").add(ExprType.file).call()
        ,PatternRewriter.create(null,"set","$.setStart()",ExprType.key).call()
        ,PatternRewriter.create(null,"set","$.set($)",ExprType.key,ExprType.key).call().exact(2)
        ,PatternRewriter.create(null,"buffer","$.buffer($,$,$,$)",ExprType.file,ExprType.rawint).range(1,5).call()
        ,PatternRewriter.create(ExprType.string,"position","$.getPosition()",ExprType.key).call()
        ,PatternRewriter.create(ExprType.string,"getnulls","$.getNulls()",ExprType.file).call()
        ,PatternRewriter.create(null,"setnulls","$.setNulls($)",ExprType.file,ExprType.string).call()
        ,PatternRewriter.create(ExprType.rawint,"getstate","$.getState()",ExprType.file).call()
        ,PatternRewriter.create(null,"restorestate","$.restoreState($)",ExprType.file,ExprType.rawint).call()
        ,PatternRewriter.create(null,"freestate","$.freeState($)",ExprType.file,ExprType.rawint).call()
        ,PatternRewriter.create(null,"logout","ClarionFile.logout($)",ExprType.rawint).call().rt("ClarionFile")
        ,PatternRewriter.create(null,"commit","ClarionFile.commit()").call().rt("ClarionFile")
        ,PatternRewriter.create(null,"rollback","ClarionFile.rollback()").call().rt("ClarionFile")
        ,PatternRewriter.create(ExprType.rawboolean,"duplicate","$.duplicateCheck()").add(ExprType.file,ExprType.key).call()
        ,PatternRewriter.create(null,"set","$.set($)",ExprType.file,ExprType.rawint).call()
        );
        
        // reports
        register(
         PatternRewriter.create(null,"endpage","$.endPage()",ExprType.report).call()
        ,PatternRewriter.create(null,"print","$.print()",ExprType.control).call()
        );
        
        // runtime expression evaluation
        register(
         PatternRewriter.create(ExprType.string,"evaluate","CExpression.evaluate($)",ExprType.rawstring).call().rt("runtime.CExpression")
        //,PatternRewriter.create(null,"bind","CExpression.bind($,$)",ExprType.rawstring,ExprType.any).call().rt("runtime.CExpression")
        ,PatternRewriter.create(null,"bind","CExpression.bind($)",ExprType.group).call().rt("runtime.CExpression")
        ,PatternRewriter.create(null,"unbind","CExpression.unbind($)").add(ExprType.rawstring,ExprType.group).call().rt("runtime.CExpression")
        ,PatternRewriter.create(null,"pushbind","CExpression.pushBind()").call().rt("runtime.CExpression")
        ,PatternRewriter.create(null,"pushbind","CExpression.pushBind($)",ExprType.rawboolean).call().rt("runtime.CExpression")
        ,PatternRewriter.create(null,"popbind","CExpression.popBind()").call().rt("runtime.CExpression")
        );
  
        // other
        register(
         PatternRewriter.create(null,"dispose","// dispose $",ExprType.object).call()
        ,PatternRewriter.create(null,"assert","CRun._assert($)",ExprType.rawboolean).call().rt("runtime.CRun")
        ,PatternRewriter.create(null,"assert","CRun._assert($,$)",ExprType.rawboolean,ExprType.rawstring).call().rt("runtime.CRun")
        ,PatternRewriter.create(null,"beep","CWin.beep()").call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"beep","CWin.beep($)",ExprType.rawint).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawint,"message","CWin.message(@)",ExprType.string,ExprType.string,ExprType.rawstring,ExprType.rawint).call().range(1,6).rt("runtime.CWin")
        );
        
        // environment and devices
        register(
         PatternRewriter.create(ExprType.string,"command","CRun.command($)",ExprType.rawstring).call().rt("runtime.CRun")
        
        ,PatternRewriter.create(ExprType.string,"getini","CConfig.getProperty($,$,$,$)",ExprType.rawstring).call().rt("runtime.CConfig")
        ,PatternRewriter.create(null,"putini","CConfig.setProperty($,$,$,$)",ExprType.rawstring).call().rt("runtime.CConfig")

        ,PatternRewriter.create(ExprType.string,"path","CFile.getPath()").call().rt("runtime.CFile")
        ,PatternRewriter.create(null,"setpath","CFile.setPath($)",ExprType.rawstring).call().rt("runtime.CFile")
        ,PatternRewriter.create(ExprType.string,"shortpath","CFile.getShortPath($)",ExprType.rawstring).call().rt("runtime.CFile")
        ,PatternRewriter.create(null,"directory","CFile.getDirectoryListing($,$,$)",ExprType.queue,ExprType.rawstring,ExprType.rawint).call().rt("runtime.CFile")

        ,PatternRewriter.create(ExprType.string,"clipboard","CWin.getClipboard()").call().rt("runtime.CWin")
        ,PatternRewriter.create(null,"setclipboard","CWin.setClipboard($)",ExprType.string).call().rt("runtime.CWin")
        );
        
        // resources
        register(
         PatternRewriter.create(ExprType.printer,"printer","ClarionPrinter.getInstance()").call().rt("ClarionPrinter")
        ,PatternRewriter.create(ExprType.system,"system","ClarionSystem.getInstance()").call().rt("ClarionSystem")

        ,PatternRewriter.create(null,"remove","CFile.deleteFile($)",ExprType.rawstring).call().rt("runtime.CFile")
        ,PatternRewriter.create(ExprType.rawboolean,"exists","CFile.isFile($)",ExprType.rawstring).call().rt("runtime.CFile")

        ,PatternRewriter.create(ExprType.rawboolean,"printerdialog","CWin.printerDialog($,$)",ExprType.string,ExprType.rawint).range(1,2).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawboolean,"filedialog","CWin.fileDialog($,$,$,$)",ExprType.rawstring,ExprType.string,ExprType.rawstring,ExprType.rawint).range(2,4).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawboolean,"colordialog","CWin.colorDialog($,$,$)",ExprType.rawstring,ExprType.number,ExprType.rawint).range(2,3).call().rt("runtime.CWin")
        ,PatternRewriter.create(ExprType.rawboolean,"fontdialog","CWin.fontDialog($,$,$,$,$,$)",ExprType.rawstring,ExprType.string,ExprType.number).range(2,6).call().rt("runtime.CWin")
        );

        // control structure like
        register(
         PatternRewriter.create(ExprType.rawint,"systemparametersinfo","// systemparametersinfo(@)",ExprType.rawint).exact(4).call()
        ,PatternRewriter.create(null,"halt","CRun.halt($,$)",ExprType.rawint,ExprType.rawstring).range(0,2).call().rt("runtime.CRun")
        ,PatternRewriter.create(null,"stop","CRun.stop($)",ExprType.rawstring).range(0,1).call().rt("runtime.CRun")
        ,PatternRewriter.create(JavaPrec.TERNARY,ExprType.any,"choose","$ ? $ : $",ExprType.rawboolean,ExprType.any).call()
//      ,PatternRewriter.create(ExprType.any,"choose","CRun.choose($,new ClarionObject[] { @ })",ExprType.rawint,ExprType.any).call().rt("runtime.CRun","ClarionObject").min(3)
        ,PatternRewriter.create(JavaPrec.TERNARY,ExprType.rawint,"choose","$ ? 1 : 0",ExprType.rawboolean).call()
        ,PatternRewriter.create(ExprType.rawint,"thread","CRun.getThreadID()").call().rt("runtime.CRun")
        ,PatternRewriter.create(null,"yield","CRun.yield()").call().rt("runtime.CRun")
        ,PatternRewriter.create(ExprType.rawboolean,"inrange","CRun.inRange($,$,$)",ExprType.any).call().rt("runtime.CRun")
        ,PatternRewriter.create(ExprType.number,"inlist","CRun.inlist($,new ClarionString[] {@})",ExprType.rawstring,ExprType.string).call().rt("runtime.CRun","ClarionString")
        );
        
        // memory 
        register(
         PatternRewriter.create(ExprType.rawint,"address","CMemory.address($)",ExprType.object).call().rt("runtime.CMemory")
        ,PatternRewriter.create(ExprType.rawint,"address","CMemory.address($)",ExprType.object.changeArrayIndexCount(1)).call().rt("runtime.CMemory")
        ,PatternRewriter.create(ExprType.rawint,"tied","CMemory.tied($,$)",ExprType.rawstring,ExprType.rawint).call().rt("runtime.CMemory")
        ,PatternRewriter.create(ExprType.rawint,"tie","CMemory.tie($,$,$)",ExprType.rawstring,ExprType.rawint).call().rt("runtime.CMemory")
        ,PatternRewriter.create(null,"untie","CMemory.untie($,$)",ExprType.rawstring,ExprType.rawint).call().rt("runtime.CMemory")
        ,PatternRewriter.create(ExprType.rawint,"peek","CMemory.peek($,$)",ExprType.object,ExprType.rawint).call().rt("runtime.CMemory")
        ,PatternRewriter.create(null,"poke","CMemory.poke($,$)",ExprType.object).call().rt("runtime.CMemory")
        );

        // other misc 
        register(
         PatternRewriter.create(null,"callback","$.registerCallback($,$)",ExprType.file,ExprType.object,ExprType.rawboolean).call()
        ,PatternRewriter.create(null,"callback","$.deregisterCallback($)",ExprType.file,ExprType.object).call()
        );

    }

    public static void main(String args[]) { 
        
    }
    
    public void register(Rewriter... w)
    {
        factory.add(w);
    }
   
    public Expr call(String name,Expr e[])
    {
        return factory.rewrite(name,e);
    }
    
    public Iterable<Rewriter> get(String name)
    {
        return factory.get(name);
    }

    public void load(String className) 
    {
        if (loadedFiles.contains(className)) return;
        loadedFiles.add(className);
        
        try {
            Class<?> c = getClass().getClassLoader().loadClass(className);
            Object o = c.newInstance();
            ((Runnable)o).run();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }
}
