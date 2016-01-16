package org.jclarion.clarion.appgen.template;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.template.cmd.AbortCmd;
import org.jclarion.clarion.appgen.template.cmd.AddCmd;
import org.jclarion.clarion.appgen.template.cmd.AliasCmd;
import org.jclarion.clarion.appgen.template.cmd.AppCmd;
import org.jclarion.clarion.appgen.template.cmd.AppendCmd;
import org.jclarion.clarion.appgen.template.cmd.AssertCmd;
import org.jclarion.clarion.appgen.template.cmd.AtCmd;
import org.jclarion.clarion.appgen.template.cmd.AtStartCmd;
import org.jclarion.clarion.appgen.template.cmd.BoxedCmd;
import org.jclarion.clarion.appgen.template.cmd.ButtonCmd;
import org.jclarion.clarion.appgen.template.cmd.CallCmd;
import org.jclarion.clarion.appgen.template.cmd.CaseCmd;
import org.jclarion.clarion.appgen.template.cmd.ClassCmd;
import org.jclarion.clarion.appgen.template.cmd.ClearCmd;
import org.jclarion.clarion.appgen.template.cmd.CloseCmd;
import org.jclarion.clarion.appgen.template.cmd.CodeCmd;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.CommentCmd;
import org.jclarion.clarion.appgen.template.cmd.ControlCmd;
import org.jclarion.clarion.appgen.template.cmd.CreateCmd;
import org.jclarion.clarion.appgen.template.cmd.DebugCmd;
import org.jclarion.clarion.appgen.template.cmd.DeclareCmd;
import org.jclarion.clarion.appgen.template.cmd.DefaultCmd;
import org.jclarion.clarion.appgen.template.cmd.DeleteCmd;
import org.jclarion.clarion.appgen.template.cmd.DisplayCmd;
import org.jclarion.clarion.appgen.template.cmd.ElseCmd;
import org.jclarion.clarion.appgen.template.cmd.EmbedPoint;
import org.jclarion.clarion.appgen.template.cmd.EmptyEmbedCmd;
import org.jclarion.clarion.appgen.template.cmd.EnableCmd;
import org.jclarion.clarion.appgen.template.cmd.EndCmd;
import org.jclarion.clarion.appgen.template.cmd.EquateCmd;
import org.jclarion.clarion.appgen.template.cmd.ErrorCmd;
import org.jclarion.clarion.appgen.template.cmd.ExportCmd;
import org.jclarion.clarion.appgen.template.cmd.ExtensionCmd;
import org.jclarion.clarion.appgen.template.cmd.FieldCmd;
import org.jclarion.clarion.appgen.template.cmd.FindCmd;
import org.jclarion.clarion.appgen.template.cmd.FixCmd;
import org.jclarion.clarion.appgen.template.cmd.FlowControlCmd;
import org.jclarion.clarion.appgen.template.cmd.ForCmd;
import org.jclarion.clarion.appgen.template.cmd.FreeCmd;
import org.jclarion.clarion.appgen.template.cmd.GenerateCmd;
import org.jclarion.clarion.appgen.template.cmd.ConditionalCmd;
import org.jclarion.clarion.appgen.template.cmd.GlobalDataCmd;
import org.jclarion.clarion.appgen.template.cmd.GroupCmd;
import org.jclarion.clarion.appgen.template.cmd.IfCmd;
import org.jclarion.clarion.appgen.template.cmd.IgnoreCmd;
import org.jclarion.clarion.appgen.template.cmd.ImageCmd;
import org.jclarion.clarion.appgen.template.cmd.ImportCmd;
import org.jclarion.clarion.appgen.template.cmd.IncludeCmd;
import org.jclarion.clarion.appgen.template.cmd.IndentCmd;
import org.jclarion.clarion.appgen.template.cmd.InsertCmd;
import org.jclarion.clarion.appgen.template.cmd.InvokeCmd;
import org.jclarion.clarion.appgen.template.cmd.LocalDataCmd;
import org.jclarion.clarion.appgen.template.cmd.LoopCmd;
import org.jclarion.clarion.appgen.template.cmd.ModuleCmd;
import org.jclarion.clarion.appgen.template.cmd.MsgCmd;
import org.jclarion.clarion.appgen.template.cmd.OpenCmd;
import org.jclarion.clarion.appgen.template.cmd.PDefineCmd;
import org.jclarion.clarion.appgen.template.cmd.PostEmbedCmd;
import org.jclarion.clarion.appgen.template.cmd.PreEmbedCmd;
import org.jclarion.clarion.appgen.template.cmd.PrepareCmd;
import org.jclarion.clarion.appgen.template.cmd.PrintCmd;
import org.jclarion.clarion.appgen.template.cmd.PriorityCmd;
import org.jclarion.clarion.appgen.template.cmd.ProcedureCmd;
import org.jclarion.clarion.appgen.template.cmd.ProgramCmd;
import org.jclarion.clarion.appgen.template.cmd.ProjectCmd;
import org.jclarion.clarion.appgen.template.cmd.PromptCmd;
import org.jclarion.clarion.appgen.template.cmd.PurgeCmd;
import org.jclarion.clarion.appgen.template.cmd.QueryCmd;
import org.jclarion.clarion.appgen.template.cmd.ReadCmd;
import org.jclarion.clarion.appgen.template.cmd.ReleaseCmd;
import org.jclarion.clarion.appgen.template.cmd.RemoveCmd;
import org.jclarion.clarion.appgen.template.cmd.ReplaceCmd;
import org.jclarion.clarion.appgen.template.cmd.RestrictCmd;
import org.jclarion.clarion.appgen.template.cmd.ResumeCmd;
import org.jclarion.clarion.appgen.template.cmd.ReturnCmd;
import org.jclarion.clarion.appgen.template.cmd.SectionCmd;
import org.jclarion.clarion.appgen.template.cmd.SelectCmd;
import org.jclarion.clarion.appgen.template.cmd.ServiceCmd;
import org.jclarion.clarion.appgen.template.cmd.SetCmd;
import org.jclarion.clarion.appgen.template.cmd.SheetCmd;
import org.jclarion.clarion.appgen.template.cmd.SuspendCmd;
import org.jclarion.clarion.appgen.template.cmd.SystemCmd;
import org.jclarion.clarion.appgen.template.cmd.TabCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateCmd;
import org.jclarion.clarion.appgen.template.cmd.UnfixCmd;
import org.jclarion.clarion.appgen.template.cmd.UtilityCmd;
import org.jclarion.clarion.appgen.template.cmd.ValidateCmd;
import org.jclarion.clarion.appgen.template.cmd.WithCmd;
import org.jclarion.clarion.runtime.expr.ParseException;

public class TemplateParser {
	
	private static Map<String,Class<? extends CommandItem>> commands=new HashMap<String,Class<? extends CommandItem>>();
	
	static {
		commands.put("DEBUG",DebugCmd.class);
		commands.put("PROMPT",PromptCmd.class);
		commands.put("TEMPLATE",TemplateCmd.class);
		commands.put("HELP",IgnoreCmd.class);
		commands.put("APPLICATION",AppCmd.class);
		commands.put("LOCALDATA",LocalDataCmd.class);
		commands.put("ENDLOCALDATA",EndCmd.class);
		commands.put("SHEET",SheetCmd.class);
		commands.put("TAB",TabCmd.class);
		commands.put("BOXED",BoxedCmd.class);
		commands.put("ENABLE",EnableCmd.class);
		commands.put("ENDENABLE",EndCmd.class);
		commands.put("ENDBOXED",EndCmd.class);
		commands.put("ENDTAB",EndCmd.class);
		commands.put("BUTTON",ButtonCmd.class);
		commands.put("ENDBUTTON",EndCmd.class);
		commands.put("ENDSHEET",EndCmd.class);
		commands.put("ENDCASE",EndCmd.class);
		commands.put("MESSAGE",MsgCmd.class);
		commands.put("DECLARE",DeclareCmd.class);
		commands.put("FREE",FreeCmd.class);
		commands.put("SET",SetCmd.class);
		commands.put("PROJECT",ProjectCmd.class);
		commands.put("CREATE",CreateCmd.class);
		commands.put("IF",IfCmd.class);
		commands.put("ELSIF",ConditionalCmd.class);
		commands.put("CASE",CaseCmd.class);
		commands.put("OF",ConditionalCmd.class);
		commands.put("OROF",ConditionalCmd.class);
		commands.put("ELSE",ElseCmd.class);
		commands.put("ENDIF",EndCmd.class);
		commands.put("END",EndCmd.class);	// loose one.
		commands.put("FIND",FindCmd.class);
		commands.put("FIX",FixCmd.class);
		commands.put("GENERATE",GenerateCmd.class);
		commands.put("CLOSE",CloseCmd.class);
		commands.put("REMOVE",RemoveCmd.class);
		commands.put("ABORT",AbortCmd.class);
		commands.put("CYCLE",FlowControlCmd.class);
		commands.put("BREAK",FlowControlCmd.class);
		commands.put("FOR",ForCmd.class);
		commands.put("ENDFOR",EndCmd.class);
		commands.put("EMBED",EmbedPoint.class);
		commands.put("REPLACE",ReplaceCmd.class);
		commands.put("ADD",AddCmd.class);
		commands.put("INSERT",InsertCmd.class);
		commands.put("PROCEDURE",ProcedureCmd.class);
		commands.put("AT",AtCmd.class);
		commands.put("ENDAT",EndCmd.class);
		commands.put("INCLUDE",IncludeCmd.class);
		commands.put("PROGRAM",ProgramCmd.class);
		commands.put("CLASS",ClassCmd.class);
		commands.put("GROUP",GroupCmd.class);
		commands.put("ERROR",ErrorCmd.class);
		commands.put("RETURN",ReturnCmd.class);
		commands.put("SUSPEND",SuspendCmd.class);
		commands.put("RESUME",ResumeCmd.class);
		commands.put("RELEASE",ReleaseCmd.class);
		commands.put("DEFAULT",DefaultCmd.class);
		commands.put("ENDDEFAULT",EndCmd.class);
		commands.put("DISPLAY",DisplayCmd.class);
		commands.put("SELECT",SelectCmd.class);
		commands.put("LOOP",LoopCmd.class);
		commands.put("ENDLOOP",EndCmd.class);
		commands.put("DELETE",DeleteCmd.class);
		commands.put("CODE",CodeCmd.class);
		commands.put("RESTRICT",RestrictCmd.class);
		commands.put("ENDRESTRICT",EndCmd.class);
		commands.put("ACCEPT",FlowControlCmd.class);
		commands.put("REJECT",FlowControlCmd.class);
		commands.put("PREPARE",PrepareCmd.class);
		commands.put("ENDPREPARE",EndCmd.class);
		commands.put("OPEN",OpenCmd.class);
		commands.put("READ",ReadCmd.class);
		commands.put("CONTROL",ControlCmd.class);
		commands.put("ATSTART",AtStartCmd.class);
		commands.put("ENDAT",EndCmd.class);
		commands.put("GLOBALDATA",GlobalDataCmd.class);
		commands.put("ENDGLOBALDATA",EndCmd.class);
		commands.put("EXTENSION",ExtensionCmd.class);
		commands.put("FIELD",FieldCmd.class);
		commands.put("ENDFIELD",EndCmd.class);
		commands.put("MODULE",ModuleCmd.class);
		commands.put("PREEMBED",PreEmbedCmd.class);
		commands.put("POSTEMBED",PostEmbedCmd.class);
		commands.put("CLEAR",ClearCmd.class);
		commands.put("UNFIX",UnfixCmd.class);
		commands.put("SYSTEM",SystemCmd.class);
		commands.put("CALL",CallCmd.class);
		commands.put("WITH",WithCmd.class);
		commands.put("ENDWITH",EndCmd.class);
		commands.put("EQUATE",EquateCmd.class);
		commands.put("COMMENT",CommentCmd.class);
		commands.put("PRIORITY",PriorityCmd.class);
		commands.put("SECTION",SectionCmd.class);
		commands.put("ENDSECTION",EndCmd.class);
		commands.put("APPEND",AppendCmd.class);
		commands.put("ASSERT",AssertCmd.class);
		commands.put("PURGE",PurgeCmd.class);
		commands.put("VALIDATE",ValidateCmd.class);
		commands.put("QUERY",QueryCmd.class);
		commands.put("ALIAS",AliasCmd.class);
		commands.put("TRYALIAS",AliasCmd.class);
		commands.put("INDENT",IndentCmd.class);
		commands.put("INVOKE",InvokeCmd.class);
		commands.put("PDEFINE",PDefineCmd.class);
		commands.put("SERVICE",ServiceCmd.class);
		commands.put("UTILITY",UtilityCmd.class);
		commands.put("IMPORT",ImportCmd.class);
		commands.put("IMAGE",ImageCmd.class);
		commands.put("PRINT",PrintCmd.class);
		commands.put("TYPEMAP",ServiceCmd.class);
		commands.put("EXPORT",ExportCmd.class);
		commands.put("EMPTYEMBED",EmptyEmbedCmd.class);
	};
	
	private TemplateReader reader;

	public TemplateParser(TemplateLoaderSource path)
	{
		reader = new TemplateReader(path);
	}
	
	public TemplateReader getReader()
	{
		return reader;
	}
	
	public String getFamily()
	{
		return template.getFamily();
	}
	
	private TemplateItem last;
	
	public TemplateItem read() throws IOException
	{
		if (last!=null && !last.isConsumed()) {
			return last;
		}
		last=_read();
		return last;
	}
	
	
	public TemplateItem _read() throws IOException
	{
		AbstractLine ts = reader.read();
		if (ts==null) return null;
		if (ts instanceof SourceLine) {
			ts.consume();
			SourceItem si = new SourceItem((SourceLine)ts);
			si.noteTemplateSource(getReader());
			return si;
		}
		
		if (ts instanceof CommandLine) {
			
			CommandLine cl = (CommandLine)ts;
			
			Class<? extends CommandItem> x = commands.get(cl.getCommand());
			CommandItem ci=null;
			if (x!=null) {
				try {
					ci=x.newInstance();
				} catch (InstantiationException e) {
					reader.error(e.getMessage());
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					reader.error(e.getMessage());
					e.printStackTrace();
				}
			}
			if (ci==null) {
				reader.error("Unknown command");
			}
			ci.noteTemplateSource(getReader());
			ci.noteIndent(cl.getIndent());
			
			ts.consume();
			
			try {
				ci.init(this, cl);
			} catch (ParseException e) {
				e.printStackTrace();
				reader.error(e.getMessage());
			}
			return ci;
		}
		
		reader.error("Cannot handle:"+ts);
		return null;
	}
	
	private CodeSection 	codeSection;
	private TemplateCmd 	template;
	private TemplateChain 	chain;

	public CodeSection getCodeSection() {
		return codeSection;
	}

	public void setCodeSection(CodeSection codeSection) {
		template.register(codeSection);
		this.codeSection = codeSection;
	}

	/*
	public TemplateCmd getTemplate() {
		return template;
	}
	*/

	public void setTemplate(TemplateCmd template) {
		chain.register(template);
		this.template = template;
	}

	public TemplateChain getChain() {
		return chain;
	}

	public void setChain(TemplateChain chain) {
		this.chain = chain;
	}
	
	
}
