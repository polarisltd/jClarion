  MEMBER

  INCLUDE('ABPRHTML.INC'),ONCE
  MAP
    INCLUDE('CWUTIL.INC'),ONCE
  END
  
TOP_STYLE EQUATE(1)
LEFT_STYLE EQUATE(2)
  
  ITEMIZE,PRE(Type)
Text  EQUATE
Rect  EQUATE
  END
  
  PRAGMA ('link (EXP_HTM.ICO)')

HTMLGenerator.CONSTRUCT      PROCEDURE
  CODE
    SELF.PosQ &= NEW(PosQueue)
    SELF.TextStyleQ &= NEW(TextStyleQueue)
    SELF.RectStyleQ &= NEW(RectStyleQueue)
    SELF.Attribute &= NEW(ReportAttributeManager)
    SELF.Output &= NEW(TargetGenerator)
    SELF.CSSOutput &= NEW(TargetGenerator)
    SELF.OutNameG &= NEW(NameGenerator)
    SELF.ImageNameG &= NEW(NameGenerator)

HTMLGenerator.DESTRUCT       PROCEDURE
  CODE
   FREE(SELF.PosQ)
   DISPOSE(SELF.PosQ)
   FREE(SELF.TextStyleQ)
   DISPOSE(SELF.TextStyleQ)
   FREE(SELF.RectStyleQ)
   DISPOSE(SELF.RectStyleQ)
   DISPOSE(SELF.Attribute)
   DISPOSE(SELF.Output)
   DISPOSE(SELF.CSSOutput)
   DISPOSE(SELF.OutNameG)
   DISPOSE(SELF.ImageNameG)

HTMLGenerator.Init           PROCEDURE(<STRING FileName>)
  CODE
    FREE(SELF.PosQ)
    FREE(SELF.TextStyleQ)
    FREE(SELF.RectStyleQ)
    SELF.SetDocumentName('Clarion Report')
    SELF.SetNavigationText('First','Last','Next','Prior','Select Page','Page_','Load Page')
    SELF.SetSubDirectory(True,'_Files','_Images')
    SELF.SetUp()

HTMLGenerator.SetUp                   PROCEDURE()
 CODE

HTMLGenerator.SetDocumentName         PROCEDURE(STRING pDocName)
 CODE
 SELF.DocumentName=pDocName

HTMLGenerator.SetNavigationText       PROCEDURE(STRING pNavFirst,STRING pNavLast,STRING pNavNext,STRING pNavPrior,STRING pNavPage0,STRING pNavPageText,STRING pNavGoPage)
 CODE
 SELF.NavFirst=pNavFirst
 SELF.NavLast=pNavLast
 SELF.NavNext=pNavNext
 SELF.NavPrior=pNavPrior
 SELF.NavPage0=pNavPage0
 SELF.NavPageText=pNavPageText
 SELF.NavGoPage=pNavGoPage

HTMLGenerator.SetSubDirectory         PROCEDURE(BYTE pCreateSubDirectory,<STRING pFilesSubDirectory>,<STRING pImagesSubDirectory>)
 CODE
 SELF.CreateSubDirectory = pCreateSubDirectory
 IF OMITTED(3) AND OMITTED(4)
    IF SELF.CreateSubDirectory
       SELF.ImagesSubDirectory = '_Images'
       SELF.FilesSubDirectory  = '_Files'
    END
 ELSE
    IF NOT OMITTED(3)
       SELF.FilesSubDirectory = pFilesSubDirectory
       IF OMITTED(4)
          SELF.ImagesSubDirectory = pFilesSubDirectory
       END
    END
    IF NOT OMITTED(4)
       SELF.ImagesSubDirectory = pImagesSubDirectory
       IF OMITTED(3)
          SELF.FilesSubDirectory = pImagesSubDirectory
       END
    END
 END
 IF SUB(SELF.ImagesSubDirectory,LEN(CLIP(SELF.ImagesSubDirectory)),1)='\'
    SELF.ImagesSubDirectory = SUB(SELF.ImagesSubDirectory,1,LEN(CLIP(SELF.ImagesSubDirectory))-1)
 END
 IF SUB(SELF.FilesSubDirectory,LEN(CLIP(SELF.FilesSubDirectory)),1)='\'
    SELF.FilesSubDirectory = SUB(SELF.FilesSubDirectory,1,LEN(CLIP(SELF.FilesSubDirectory))-1)
 END

HTMLGenerator.FlushNavigation PROCEDURE()
lPos            BYTE
lLastPos        BYTE
lIndex          SHORT
lFirstPageName  STRING(255)
lBasePageName   STRING(255)
lJSBasePageName CSTRING(6001)
lNameExtension  STRING(10)
 CODE
    !Writing the Index file
    IF SELF.CreateSubDirectory
       lBasePageName ='.\'&SELF.OutNameG.GetName(Name:Name) &SELF.FilesSubDirectory&'\'&SELF.OutNameG.GetName(Name:Name)&'_'
    ELSE
       lBasePageName ='.\'&SELF.OutNameG.GetName(Name:Name)&'_'
    END
    lNameExtension=SELF.OutNameG.GetExtension()
    IF SELF.CreateSubDirectory
       lFirstPageName='.\'&SELF.OutNameG.GetName(Name:Name) &SELF.FilesSubDirectory&'\'&SELF.OutNameG.GetName(Name:NoPath,1)
    ELSE
       lFirstPageName='.\'&SELF.OutNameG.GetName(Name:NoPath,1)
    END

    lJSBasePageName=SELF.OutNameG.GetName(Name:Name)&'_'

    SELF.CSSOutput.SetFileName(SELF.OutNameG.GetName(Name:Full))
    SELF.CSSOutput.OpenFile()
    SELF.CSSOutput.WriteLine('<<html>')
    SELF.CSSOutput.WriteLine('<<head>')
    SELF.CSSOutput.WriteLine('<<title>'&CLIP(SELF.DocumentName)&'<</title>')
    SELF.CSSOutput.WriteLine('<<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">')
    SELF.CSSOutput.WriteLine('<<meta name="generator" content="Clarion Report Output Manager">')
    SELF.CSSOutput.WriteLine('<</head>')
    SELF.CSSOutput.WriteLine('<<frameset rows="30,*" frameborder="NO" border="0" framespacing="0" cols="*">')
    SELF.CSSOutput.WriteLine('  <<frame name="NavFrame" scrolling="NO" noresize src="'&CLIP(lBasePageName)&'pgNav'&CLIP(lNameExtension)&'" marginheight="0">')
    SELF.CSSOutput.WriteLine('  <<frame name="RptFrame" src="'&CLIP(lFirstPageName)&'" marginheight="0">')
    SELF.CSSOutput.WriteLine('<</frameset>')
    SELF.CSSOutput.WriteLine('<<noframes>')
    SELF.CSSOutput.WriteLine('<<body bgcolor="#FFFFFF"topmargin=0 bottommargin=0 leftmargin=0 rightmargin=0>')
    SELF.CSSOutput.WriteLine('<</body>')
    SELF.CSSOutput.WriteLine('<</noframes>')
    SELF.CSSOutput.WriteLine('<</html>')

    SELF.CSSOutput.CloseFile()


    IF SELF.CreateSubDirectory
       SELF.CSSOutput.SetFileName(SELF.OutNameG.GetName(Name:Path) & SELF.OutNameG.GetName(Name:Name) &SELF.FilesSubDirectory&'\'&SELF.OutNameG.GetName(Name:Name)&'_pgNav'&SELF.OutNameG.GetExtension())
    ELSE
       SELF.CSSOutput.SetFileName(SELF.OutNameG.GetName(Name:Path) & SELF.OutNameG.GetName(Name:Name)&'_pgNav'&SELF.OutNameG.GetExtension())
    END
    SELF.CSSOutput.OpenFile()
    SELF.CSSOutput.WriteLine('<<html>')
    SELF.CSSOutput.WriteLine('<<head>')
    SELF.CSSOutput.WriteLine('<<title>'&CLIP(SELF.DocumentName)&'<</title>')
    SELF.CSSOutput.WriteLine('<<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">')
    SELF.CSSOutput.WriteLine('<<meta name="generator" content="Clarion Report Output Manager">')
    SELF.CSSOutput.WriteLine('<<script>')
    SELF.CSSOutput.WriteLine('<<!--')
    SELF.CSSOutput.WriteLine('var basename        = "'&CLIP(lJSBasePageName)&'";')
    SELF.CSSOutput.WriteLine('var pages           = '&SELF.TotalPageNo&';')
    SELF.CSSOutput.WriteLine('var pagenumpad      = '&LEN(CLIP(LEFT(SELF.TotalPageNo)))&';')
    SELF.CSSOutput.WriteLine('var extension       = '''&CLIP(lNameExtension)&''';')
    SELF.CSSOutput.WriteLine('var extensionwidth  = '&LEN(CLIP(lNameExtension))&';')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('var firstpage   = basename + '''' + pad(1,pagenumpad) +  extension;')
    SELF.CSSOutput.WriteLine('var lastpage    = basename + '''' + pad(pages,pagenumpad) +  extension;')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('function loadRptPage() {{')
    SELF.CSSOutput.WriteLine('   if (frmNav.selPage.options[frmNav.selPage.selectedIndex].value != "") {{')
    SELF.CSSOutput.WriteLine('     parent.RptFrame.location.href=frmNav.selPage.options[frmNav.selPage.selectedIndex].value;')
    SELF.CSSOutput.WriteLine('   }')
    SELF.CSSOutput.WriteLine('}')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('function pad(number,length) {{')
    SELF.CSSOutput.WriteLine('    var str = '''' + number;')
    SELF.CSSOutput.WriteLine('    while (str.length << length)')
    SELF.CSSOutput.WriteLine('    str = ''0'' + str;')
    SELF.CSSOutput.WriteLine('    return str;')
    SELF.CSSOutput.WriteLine('}')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('function loadOptions() {{')
    SELF.CSSOutput.WriteLine('    var pgName = '''';')
    SELF.CSSOutput.WriteLine('    var i = 0;')
    SELF.CSSOutput.WriteLine('    with (document.frmNav) {{')
    SELF.CSSOutput.WriteLine('        selPage.options.length = 0;')
    SELF.CSSOutput.WriteLine('        selPage.options[0] = new Option('''&CLIP(SELF.NavPage0)&''','''');')
    SELF.CSSOutput.WriteLine('        for (i = 1; i <<= pages; i++) {{')
    SELF.CSSOutput.WriteLine('            pgName = '''&CLIP(SELF.NavPageText)&''' + pad(i,pagenumpad) ;')
    SELF.CSSOutput.WriteLine('            selPage.options[i] = new Option(pgName, basename + pad(i,pagenumpad) + extension);')
    SELF.CSSOutput.WriteLine('        }')
    SELF.CSSOutput.WriteLine('    }')
    SELF.CSSOutput.WriteLine('}')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('function quickNav(page) {{')
    SELF.CSSOutput.WriteLine(' var thisPage = currentPage();')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('    switch (page) {{')
    SELF.CSSOutput.WriteLine('    case ''First'':')
    SELF.CSSOutput.WriteLine('        parent.RptFrame.location.href = firstpage;')
    SELF.CSSOutput.WriteLine('        break')
    SELF.CSSOutput.WriteLine('    case ''Prior'':')
    SELF.CSSOutput.WriteLine('        if (thisPage > 1) {{')
    SELF.CSSOutput.WriteLine('            parent.RptFrame.location.href = basename + '''' + pad((thisPage-1),pagenumpad) + extension;')
    SELF.CSSOutput.WriteLine('            }')
    SELF.CSSOutput.WriteLine('        break')
    SELF.CSSOutput.WriteLine('    case ''Next'':')
    SELF.CSSOutput.WriteLine('        if (thisPage << pages) {{')
    SELF.CSSOutput.WriteLine('            parent.RptFrame.location.href = basename + '''' + pad((thisPage+1),pagenumpad) + extension;')
    SELF.CSSOutput.WriteLine('            }')
    SELF.CSSOutput.WriteLine('        break')
    SELF.CSSOutput.WriteLine('    case ''Last'':')
    SELF.CSSOutput.WriteLine('        parent.RptFrame.location.href = lastpage;')
    SELF.CSSOutput.WriteLine('        break')
    SELF.CSSOutput.WriteLine('    default:')
    SELF.CSSOutput.WriteLine('    }')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('}')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('function currentPage() {{')
    SELF.CSSOutput.WriteLine(' var strURL     = parent.RptFrame.location.href + '''';')
    SELF.CSSOutput.WriteLine(' var startpos   = pagenumpad + extensionwidth;')
    SELF.CSSOutput.WriteLine(' var endpos     = extensionwidth;')
    SELF.CSSOutput.WriteLine(' return( Math.abs(strURL.slice(strURL.length-startpos,strURL.length-endpos)) );')
    SELF.CSSOutput.WriteLine('}')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('// -->')
    SELF.CSSOutput.WriteLine('<</script>')
    SELF.CSSOutput.WriteLine('<</head>')
    SELF.CSSOutput.WriteLine('<<body bgcolor="#C0C0C0" topmargin=0 bottommargin=0 leftmargin=0 rightmargin=0 onload="JAVASCRIPT:loadOptions();">')
    SELF.CSSOutput.WriteLine('')
    SELF.CSSOutput.WriteLine('<<table align="center">')
    SELF.CSSOutput.WriteLine('<<tr>')
    SELF.CSSOutput.WriteLine('    <<td valign="middle"><<a href="JAVASCRIPT:quickNav(''First'');">['&CLIP(SELF.NavFirst)&']<</a><</td>')
    SELF.CSSOutput.WriteLine('    <<td valign="middle"><<a href="JAVASCRIPT:quickNav(''Prior'');">['&CLIP(SELF.NavPrior)&']<</a><</td>')
    SELF.CSSOutput.WriteLine('    <<td valign="middle"><<a href="JAVASCRIPT:quickNav(''Next'');">['&CLIP(SELF.NavNext)&']<</a><</td>')
    SELF.CSSOutput.WriteLine('    <<td valign="middle"><<a href="JAVASCRIPT:quickNav(''Last'');">['&CLIP(SELF.NavLast)&']<</a><</td>')
    SELF.CSSOutput.WriteLine('    <<td>&nbsp;<</td>')
    SELF.CSSOutput.WriteLine('    <<form id="frmNav" name="frmNav" method="POST">')
    SELF.CSSOutput.WriteLine('    <<td><<select id="selPage" name="selPage" width="10"><</select><</td>')
    SELF.CSSOutput.WriteLine('    <</form>')
    SELF.CSSOutput.WriteLine('    <<td><<a href="JAVASCRIPT:loadRptPage();">'&CLIP(SELF.NavGoPage)&'<</a><</td>')
    SELF.CSSOutput.WriteLine('<</tr>')
    SELF.CSSOutput.WriteLine('<</table>')
    SELF.CSSOutput.WriteLine('<</body>')
    SELF.CSSOutput.WriteLine('<</html>')

    SELF.CSSOutput.CloseFile()

HTMLGenerator.FlushStyleSheet PROCEDURE()
idx  UNSIGNED,AUTO
HexCol CSTRING(10)
  CODE
    IF SELF.CreateSubDirectory
       SELF.CSSOutput.SetFileName(SELF.OutNameG.GetName(Name:Path) & SELF.OutNameG.GetName(Name:Name) &SELF.FilesSubDirectory&'\'&SELF.OutNameG.GetName(Name:Name)&'.css')
    ELSE
       SELF.CSSOutput.SetFileName(SELF.OutNameG.GetName(Name:Path) & SELF.OutNameG.GetName(Name:Name)&'.css')
    END
    SELF.CSSOutput.OpenFile()
    LOOP idx = 1 TO RECORDS(SELF.TextStyleQ)
      GET(SELF.TextStyleQ, idx)
      SELF.CSSOutput.WriteLine('.' & SELF.TextStyleQ.Name)
      SELF.CSSOutput.WriteLine('{{')
      SELF.CSSOutput.WriteLine('  font-family: ' & CLIP(SELF.TextStyleQ.Face) & ';')
      SELF.CSSOutput.WriteLine('  font-size: ' & SELF.TextStyleQ.Size & 'px;')
      HexCol = LongToHex(SELF.TextStyleQ.Color)
      SELF.CSSOutput.WriteLine('  color: #' & HexCol[7:8]&HexCol[5:6]&HexCol[3:4] & ';')
      IF SELF.TextStyleQ.Style
        SELF.CSSOutput.WriteLine('  font-weight: ' & SELF.TextStyleQ.Style & ';')
      ELSE
        SELF.CSSOutput.WriteLine('  font-weight: normal;')
      END
      SELF.CSSOutput.WriteLine('}')
    END 
    LOOP idx = 1 TO RECORDS(SELF.RectStyleQ)
      GET(SELF.RectStyleQ, idx)
      SELF.CSSOutput.WriteLine('.' & SELF.RectStyleQ.Name)
      SELF.CSSOutput.WriteLine('{{')
      IF NOT SELF.RectStyleQ.IsLine
         IF SELF.RectStyleQ.Color=-1 THEN
            SELF.CSSOutput.WriteLine('  background-color: # transparent'& ';')
         ELSE
            HexCol = LongToHex(SELF.RectStyleQ.Color)
            SELF.CSSOutput.WriteLine('  background-color: #' & HexCol[7:8]&HexCol[5:6]&HexCol[3:4] & ';')
         END
      END  
      IF SELF.RectStyleQ.BorderWidth
        HexCol = LongToHex(SELF.RectStyleQ.BorderColor)
        SELF.CSSOutput.WriteLine('  border-color: #' & HexCol[7:8]&HexCol[5:6]&HexCol[3:4] & ';')
        SELF.CSSOutput.WriteLine('  border-width: ' & SELF.RectStyleQ.BorderWidth & 'mm;')
        IF SELF.RectStyleQ.IsLine = TOP_STYLE
          SELF.CSSOutput.WriteLine('  border-top-style: solid;')
        ELSIF SELF.RectStyleQ.IsLine = LEFT_STYLE
          SELF.CSSOutput.WriteLine('  border-left-style: solid;')
        ELSE  
          SELF.CSSOutput.WriteLine('  border-style: solid;')
        END  
      END  
      SELF.CSSOutput.WriteLine('}')
    END 
    LOOP idx = 1 TO RECORDS(SELF.PosQ)
      GET(SELF.PosQ, idx)
      SELF.CSSOutput.WriteLine('#' & SELF.PosQ.Name)
      SELF.CSSOutput.WriteLine('{{')
      SELF.CSSOutput.WriteLine('  position: absolute;')
      SELF.CSSOutput.WriteLine('  left: ' & SELF.PosQ.XPos & ' mm;')
      SELF.CSSOutput.WriteLine('  top: ' & SELF.PosQ.YPos & ' mm;')
      SELF.CSSOutput.WriteLine('  width: ' & SELF.PosQ.Width & ' mm;')
      SELF.CSSOutput.WriteLine('  height: ' & SELF.PosQ.Height & ' mm;')
      SELF.CSSOutput.WriteLine('}')
    END 
    SELF.CSSOutput.CloseFile()

HTMLGenerator.ProcessCheck   PROCEDURE(*CheckFormatGrp cf, STRING Text)
size SIGNED
box  CSTRING(2)
  CODE
    IF cf.prompt.Size THEN
       size = cf.prompt.Size + 5
    ELSE
       size = 14
    END
    SELF.ProcessString(cf.prompt, Text)
    SELF.ProcessLocation(cf.Pos)
    CLEAR(SELF.TextStyleQ)
    SELF.TextStyleQ.Size = size
    SELF.TextStyleQ.Face = 'Wingdings'
    SELF.TextStyleQ.Style = CHOOSE(cf.Style.BorderWidth > 1, FONT:Bold, 0)
    SELF.TextStyleQ.Color = cf.Style.BorderColor
    GET(SELF.TextStyleQ, SELF.TextStyleQ.Size,SELF.TextStyleQ.Style,SELF.TextStyleQ.Color,SELF.TextStyleQ.Face)
    IF ERRORCODE()
      SELF.TextStyleQ.Name = 'TextStyle' & SELF.TextStyleCnt
      SELF.TextStyleCnt += 1    
      ADD(SELF.TextStyleQ)
    END
    IF cf.Checked
      box = 'x'
    ELSE
      box = 'o'
    END
    SELF.Output.WriteLine('<<SPAN class="' & SELF.TextStyleQ.Name & '" id="' & SELF.PosQ.Name & '">' & box & '<</SPAN>')

HTMLGenerator.ProcessImage      PROCEDURE(*ImageFormatGrp imgf, STRING iName)
  CODE
    IF iName THEN
       SELF.ProcessLocation(imgf.Pos)
       SELF.ImageNameG.Init('','')
       SELF.ImageNameG.ExtractFileName(iName)
       IF SELF.CreateSubDirectory
          COPY(iName,SELF.OutNameG.GetName(Name:Path) & SELF.OutNameG.GetName(Name:Name) &SELF.ImagesSubDirectory&'\'&SELF.ImageNameG.GetName(Name:NoPath))
       ELSE
          COPY(iName,SELF.OutNameG.GetName(Name:Path) & SELF.ImageNameG.GetName(Name:NoPath))
       END
       IF SELF.IsHyperLink THEN
          SELF.IsHyperLink = False
          IF SELF.CreateSubDirectory
             SELF.Output.WriteLine('<<SPAN id="' & SELF.PosQ.Name & '">' & '<<a'&CLIP(SELF.HyperLinkTarget)&' href="'&CLIP(SELF.HyperLink)&'"><<IMG src="' & CLIP('..\'&SELF.OutNameG.GetName(Name:Name) &SELF.ImagesSubDirectory&'\'&SELF.ImageNameG.GetName(Name:NoPath)) & '"  WIDTH="100%" HEIGHT="100%" ><</a>' & '<</SPAN>')
          ELSE
             SELF.Output.WriteLine('<<SPAN id="' & SELF.PosQ.Name & '">' & '<<a'&CLIP(SELF.HyperLinkTarget)&' href="'&CLIP(SELF.HyperLink)&'"><<IMG src="' & CLIP('..\'&SELF.ImageNameG.GetName(Name:NoPath)) & '"  WIDTH="100%" HEIGHT="100%" ><</a>' & '<</SPAN>')
          END
       ELSE
          IF SELF.CreateSubDirectory
             SELF.Output.WriteLine('<<SPAN id="' & SELF.PosQ.Name & '">' & '<<IMG src="' & CLIP('..\'&SELF.OutNameG.GetName(Name:Name) &SELF.ImagesSubDirectory&'\'&SELF.ImageNameG.GetName(Name:NoPath)) & '" WIDTH="100%" HEIGHT="100%" >' & '<</SPAN>')
          ELSE
             SELF.Output.WriteLine('<<SPAN id="' & SELF.PosQ.Name & '">' & '<<IMG src="' & CLIP('..\'&SELF.ImageNameG.GetName(Name:NoPath)) & '" WIDTH="100%" HEIGHT="100%" >' & '<</SPAN>')
          END
       END
    END
    

HTMLGenerator.ProcessLine    PROCEDURE(*LineFormatGrp lf)
rect    GROUP(RectFormatGrp).
IsLine  BYTE
  CODE
    IF lf.Pos.Left = lf.Pos.Right 
      IsLine = LEFT_STYLE
    ELSIF lf.Pos.Top = lf.Pos.Bottom
      IsLine = TOP_STYLE
    END
    IF IsLine  
      IF lf.Pos.Left > lf.Pos.Right OR lf.Pos.Top > lf.Pos.Bottom
        ! needs swapping
        rect.Pos.Left = lf.Pos.Right
        rect.Pos.Right = lf.Pos.Left
        rect.Pos.Top = lf.Pos.Bottom
        rect.Pos.Bottom = lf.Pos.Top
      ELSE  
        rect.Pos = lf.Pos
      END  
      rect.Style.BorderColor = lf.Color
      rect.Style.BorderWidth = lf.Width
      SELF.ProcessRect(rect, IsLine)
    ELSE
      ! not possible to display in HTML ?
    END        

HTMLGenerator.ProcessLocation PROCEDURE(*PosGrp pPos,USHORT BorderWidth=0)
  CODE
    IF BorderWidth THEN
       SELF.PosQ.XPos   = (pPos.Left/39.35185)-((BorderWidth / 23.78121284185)/2)
       SELF.PosQ.YPos   = (pPos.Top/39.42652)-((BorderWidth / 23.78121284185)/2)
       SELF.PosQ.Width  = ((pPos.Right - pPos.Left)/39.35185)+(BorderWidth / 23.78121284185)
       SELF.PosQ.Height = (pPos.Bottom - pPos.Top)/39.42652+(BorderWidth / 23.78121284185)
    ELSE
       SELF.PosQ.XPos   = pPos.Left/39.35185
       SELF.PosQ.YPos   = pPos.Top/39.42652
       SELF.PosQ.Width  = (pPos.Right - pPos.Left)/39.35185
       SELF.PosQ.Height = (pPos.Bottom - pPos.Top)/39.42652
    END
    GET(SELF.PosQ, SELF.PosQ.XPos, SELF.PosQ.YPos, SELF.PosQ.Width, SELF.PosQ.Height)
    IF ERRORCODE()
      SELF.PosQ.Name = 'Position' & SELF.PosCnt
      SELF.PosCnt += 1
      ADD(SELF.PosQ)
    END  

HTMLGenerator.ProcessGroup      PROCEDURE(*GroupFormatGrp gfg, STRING Text)
lf    GROUP(LineFormatGrp).
  CODE
    SELF.ProcessString(gfg.header, Text)
    lf.Width    = gfg.LineWidth
    lf.Color    = gfg.LineColor
    lf.Pos.Left = gfg.Pos.Left
    lf.Pos.Top  = gfg.Pos.Top
    IF gfg.Pos.Left <> gfg.X1
      lf.Pos.Right = gfg.X1
      lf.Pos.Bottom = gfg.Pos.Top
      SELF.ProcessLine(lf)
    END  
    lf.Pos.Right  = gfg.Pos.Left
    lf.Pos.Bottom = gfg.Pos.Bottom
    SELF.ProcessLine(lf)
    lf.Pos.Left   = gfg.Pos.Left
    lf.Pos.Top    = gfg.Pos.Bottom
    lf.Pos.Right  = gfg.Pos.Right
    lf.Pos.Bottom = gfg.Pos.Bottom
    SELF.ProcessLine(lf)
    lf.Pos.Left   = gfg.Pos.Right
    lf.Pos.Top    = gfg.Pos.Top
    SELF.ProcessLine(lf)
    lf.Pos.Left   = gfg.X2
    lf.Pos.Bottom = gfg.Pos.Top
    SELF.ProcessLine(lf)

HTMLGenerator.ProcessRadio      PROCEDURE(*RadioFormatGrp rf, STRING Text)
size SIGNED
box  CSTRING(2)
  CODE
    SELF.ProcessString(rf.prompt, Text)
    SELF.ProcessLocation(rf.Outer.Pos)
    size = SELF.TextStyleQ.Size + 12
    CLEAR(SELF.TextStyleQ)
    SELF.TextStyleQ.Size  = size
    SELF.TextStyleQ.Face  = 'Wingdings'
    SELF.TextStyleQ.Style = CHOOSE(rf.Outer.Style.BorderWidth > 1, FONT:Bold, 0)
    SELF.TextStyleQ.Color = rf.Outer.Style.BorderColor
    GET(SELF.TextStyleQ, SELF.TextStyleQ.Size,SELF.TextStyleQ.Style,SELF.TextStyleQ.Color,SELF.TextStyleQ.Face)
    IF ERRORCODE()
      SELF.TextStyleQ.Name = 'TextStyle' & SELF.TextStyleCnt
      SELF.TextStyleCnt += 1    
      ADD(SELF.TextStyleQ)
    END
    IF rf.Checked
      box = CHR(164)
    ELSE
      box = CHR(161)
    END
    SELF.Output.WriteLine('<<SPAN class="' & SELF.TextStyleQ.Name & '" id="' & SELF.PosQ.Name & '">' & box & '<</SPAN>')

HTMLGenerator.ProcessRect           PROCEDURE(*RectFormatGrp rf, BYTE IsLine)
  CODE
    SELF.ProcessLocation(rf.Pos,rf.Style.BorderWidth)
    CLEAR(SELF.RectStyleQ)
    SELF.RectStyleQ.IsLine = IsLine
    SELF.RectStyleQ.Color = rf.Style.BackgroundColor
    SELF.RectStyleQ.BorderColor = rf.Style.BorderColor
    SELF.RectStyleQ.BorderWidth = rf.Style.BorderWidth / 23.78121284185
    GET(SELF.RectStyleQ, SELF.RectStyleQ.Color, SELF.RectStyleQ.BorderColor, SELF.RectStyleQ.BorderWidth, SELF.RectStyleQ.IsLine)
    IF ERRORCODE()
      SELF.RectStyleQ.Name = 'RectStyle' & SELF.RectStyleCnt
      SELF.RectStyleCnt += 1
      ADD(SELF.RectStyleQ)
    END  
    SELF.Output.WriteLine('<<SPAN class="' & SELF.RectStyleQ.Name & '" id="' & SELF.PosQ.Name & '">' & '<</SPAN>')

HTMLGenerator.ProcessString    PROCEDURE(*StringFormatGrp tf, STRING text)
rf  GROUP(RectFormatGrp).
pos GROUP(PosGrp).
  CODE
    IF tf.BackgroundColor
      CLEAR(rf)
      rf.Pos = tf.Pos
      rf.Style.BackgroundColor = tf.BackgroundColor
      SELF.ProcessRect(rf, FALSE)
    END
    pos.Top = tf.topText
    pos.Left = tf.leftText
    pos.Bottom = tf.Pos.Bottom
    pos.Right = tf.Pos.Right
    SELF.ProcessLocation(pos)
    CLEAR(SELF.TextStyleQ)
    SELF.TextStyleQ.Size = tf.Size
    SELF.TextStyleQ.Face = tf.Face
    SELF.TextStyleQ.Style = tf.Style
    SELF.TextStyleQ.Color = tf.Color
    GET(SELF.TextStyleQ, SELF.TextStyleQ.Size,SELF.TextStyleQ.Style,SELF.TextStyleQ.Color,SELF.TextStyleQ.Face)
    IF ERRORCODE()
      SELF.TextStyleQ.Name = 'TextStyle' & SELF.TextStyleCnt
      SELF.TextStyleCnt += 1    
      ADD(SELF.TextStyleQ)
    END
    IF SELF.IsHyperLink THEN
       SELF.IsHyperLink = False
       SELF.Output.WriteLine('<<SPAN class="' & SELF.TextStyleQ.Name & '" id="' & SELF.PosQ.Name & '"><<a'&CLIP(SELF.HyperLinkTarget)&' href="'&CLIP(SELF.HyperLink)&'">'& text & '<</a><</SPAN>')
    ELSE
       SELF.Output.WriteLine('<<SPAN class="' & SELF.TextStyleQ.Name & '" id="' & SELF.PosQ.Name & '">' & text & '<</SPAN>')
    END

HTMLGenerator.ProcessText     PROCEDURE(TextFormatQueue TextFormatQ)
idx USHORT,AUTO
  CODE
    LOOP idx = 1 TO RECORDS(TextFormatQ)
      GET(TextFormatQ, idx)
      SELF.ProcessString(TextFormatQ.Format, TextFormatQ.Text)
    END  
                                 
HTMLGenerator.ProcessComment    PROCEDURE(STRING Text,STRING pExtendControlAttr)
lHyperPrefix     CSTRING(MAXAttributeSize+1)
  CODE
    SELF.SkipControl = False
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       SELF.SkipControl = True
    END
    IF SELF.Attribute.Extract(RepGen:HTML,TargetAttr:SKIP,pExtendControlAttr) THEN
       SELF.SkipControl = True
    END
    SELF.IsHyperLink = False
    SELF.HyperLinkTarget = ''
    SELF.HyperLink = SELF.Attribute.Extract(RepGen:HTML,TargetAttr:Hyperlink,pExtendControlAttr)
    IF SELF.HyperLink THEN
       IF CLIP(SELF.HyperLink)=TargetAttr:Hyperlink THEN
          SELF.HyperLink = Text
       END
       IF CLIP(SELF.HyperLink) THEN
          lHyperPrefix     = SELF.Attribute.Extract(RepGen:HTML,TargetAttr:HyperlinkType,pExtendControlAttr)
          SELF.HyperLinkTarget = SELF.Attribute.Extract(RepGen:HTML,TargetAttr:HyperlinkTarget,pExtendControlAttr)
          IF CLIP(SELF.HyperLinkTarget) THEN
             SELF.HyperLinkTarget = ' target="'&CLIP(SELF.HyperLinkTarget)&'"'
          END
          SELF.HyperLink   = lHyperPrefix & SELF.HyperLink
          SELF.IsHyperLink = True
       END
    END

HTMLGenerator.SetFileName              PROCEDURE(STRING pFileName)
 CODE
    SELF.Output.SetOriginalFileName(pFileName)


HTMLReportGenerator.CONSTRUCT            PROCEDURE()
 CODE
    SELF.Attribute  &=NEW ReportAttributeManager
    SELF.ImageFileQueue &= NEW(OutputFileQueue)


HTMLReportGenerator.DESTRUCT                             PROCEDURE()
 CODE
    DISPOSE(SELF.Attribute)
    FREE(SELF.ImageFileQueue)
    DISPOSE(SELF.ImageFileQueue)

HTMLReportGenerator.IReportGenerator.Init           PROCEDURE(<ErrorClass EC>)
  CODE


HTMLReportGenerator.IReportGenerator.AskProperties       PROCEDURE(BYTE Force=0)
ReturnValue BYTE
LOC:FileName    STRING(143)
rt byte
 CODE
     ReturnValue = Level:Benign
     SELF.Init()
     IF NOT CLIP(SELF.Output.GetFileName()) OR Force THEN
        LOC:FileName = ''
        IF NOT FILEDIALOG('Save as HTML File',LOC:FileName,'HTM|*.HTM|HTML|*.HTML|All|*.*',FILE:LongName+FILE:Save+FILE:KeepDir) THEN
           ReturnValue = Level:Notify
        ELSE
           IF NOT INSTRING('.',LOC:FileName) THEN
              LOC:FileName=CLIP(LOC:FileName)&'.HTM'
           END
           SELF.OutNameG.Init('ClarionReport','HTM')
           SELF.OutNameG.ExtractFileName(LOC:FileName)
           SELF.Output.SetOriginalFileName(LOC:FileName)
           IF SELF.CreateSubDirectory
              rt=CreateDirectory(SELF.OutNameG.GetName(Name:Path) & SELF.OutNameG.GetName(Name:Name) &SELF.FilesSubDirectory&'\')
              rt=CreateDirectory(SELF.OutNameG.GetName(Name:Path) & SELF.OutNameG.GetName(Name:Name) &SELF.ImagesSubDirectory&'\')
           END
        END
     ELSE
           SELF.OutNameG.ExtractFileName(SELF.Output.GetFileName())
           IF SELF.CreateSubDirectory
              rt=CreateDirectory(SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:Name) &SELF.FilesSubDirectory&'\')
              rt=CreateDirectory(SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:Name) &SELF.ImagesSubDirectory&'\')
           END
     END
     RETURN ReturnValue

HTMLReportGenerator.IReportGenerator.OpenDocument        PROCEDURE(UNSIGNED TotalPages)
  CODE
    SELF.PageNo = 0
    SELF.PosCnt = 1
    SELF.TextStyleCnt = 1
    SELF.RectStyleCnt = 1
    SELF.DocumentOpen = TRUE
    SELF.TotalPageNo  = TotalPages
    SELF.OutNameG.SetTotalPages(TotalPages)
    IF NOT SELF.OutputFileQueue &= NULL THEN
       FREE(SELF.OutputFileQueue)
       IF NOT SELF.OutputFileQueue &= NULL THEN
          SELF.OutputFileQueue.FileName = SELF.OutNameG.GetName(Name:Full)
          ADD(SELF.OutputFileQueue)
       END
    END
    RETURN Level:Benign
    
HTMLReportGenerator.IReportGenerator.CloseDocument  PROCEDURE
  CODE
    IF NOT SELF.DocumentOpen
      RETURN Level:Notify
    END
    SELF.DocumentOpen = FALSE
    SELF.FlushStyleSheet()
    IF SELF.TotalPageNo THEN
       SELF.FlushNavigation()
       IF NOT SELF.OutputFileQueue &= NULL THEN
          SELF.OutputFileQueue.FileName = SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:NoPath)
          ADD(SELF.OutputFileQueue)
          IF SELF.CreateSubDirectory
             SELF.OutputFileQueue.FileName = SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:Name)&SELF.FilesSubDirectory&'\'& SELF.OutNameG.GetName(Name:Name)&'.CSS'
          ELSE
             SELF.OutputFileQueue.FileName = SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:Name)&'.CSS'
          END
          ADD(SELF.OutputFileQueue)
       END
    END
    SELF.Output.SetFileName('')
    RETURN Level:Benign        

HTMLReportGenerator.IReportGenerator.OpenPage            PROCEDURE(SHORT pBoxLeft,SHORT pBoxTop,SHORT pBoxRight,SHORT pBoxBottom)
  CODE
    SELF.PageNo += 1
    IF SELF.CreateSubDirectory
       SELF.Output.SetFileName(SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:Name) &SELF.FilesSubDirectory&'\'& SELF.OutNameG.GetName(Name:NoPath,SELF.PageNo))
    ELSE
       SELF.Output.SetFileName(SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:NoPath,SELF.PageNo))
    END
    IF NOT SELF.OutputFileQueue &= NULL THEN
       IF SELF.CreateSubDirectory
          SELF.OutputFileQueue.FileName = SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:Name) &SELF.FilesSubDirectory&'\'& SELF.OutNameG.GetName(Name:NoPath,SELF.PageNo)
       ELSE
          SELF.OutputFileQueue.FileName = SELF.OutNameG.GetName(Name:Path,0) & SELF.OutNameG.GetName(Name:NoPath,SELF.PageNo)
       END
       ADD(SELF.OutputFileQueue)
    END
    SELF.Output.OpenFile()
    SELF.PageOpen = TRUE
    SELF.Output.WriteLine('<<HTML>')
    SELF.Output.WriteLine('<<HEAD>')
    SELF.Output.WriteLine('<<LINK rel="stylesheet" type="text/css" href="' & |
    SELF.OutNameG.GetName(Name:Name)&'.css'&|
                                 '">')
    SELF.Output.WriteLine('<</HEAD>')
    SELF.Output.WriteLine('<<BODY>')
    RETURN Level:Benign        

HTMLReportGenerator.IReportGenerator.ClosePage      PROCEDURE
  CODE
    IF NOT SELF.PageOpen
      RETURN Level:Notify
    END
    SELF.Output.WriteLine('<</BODY>')
    SELF.Output.WriteLine('<</HTML>')
    SELF.Output.CloseFile()
    IF ERRORCODE() THEN RETURN Level:Notify.
    SELF.PageOpen = FALSE
    RETURN Level:Benign

HTMLReportGenerator.IReportGenerator.WhoAmI         PROCEDURE
  CODE
    RETURN RepGen:HTML  

HTMLReportGenerator.IReportGenerator.DisplayIcon         PROCEDURE()
 CODE
     RETURN '~EXP_HTM.ICO'

HTMLReportGenerator.IReportGenerator.DisplayName         PROCEDURE()
 CODE
     RETURN 'HTML'

HTMLReportGenerator.IReportGenerator.ProcessLine    PROCEDURE(*LineFormatGrp lf, STRING pExtendControlAttr)
  CODE
    SELF.ProcessComment('',pExtendControlAttr)
    IF NOT SELF.SkipControl
      SELF.ProcessLine(lf)
    END  

HTMLReportGenerator.IReportGenerator.ProcessCheck   PROCEDURE(*CheckFormatGrp cf, STRING Text, STRING pExtendControlAttr)
  CODE
    SELF.ProcessComment(Text,pExtendControlAttr)
    IF NOT SELF.SkipControl
      SELF.ProcessCheck(cf, Text)
    END  

HTMLReportGenerator.IReportGenerator.ProcessEllipse    PROCEDURE(*EllipseFormatGrp ef, STRING pExtendControlAttr)
  CODE
  !NOT SUPPORTED
  ! can't implement in HTML + CSS

HTMLReportGenerator.IReportGenerator.ProcessArc      PROCEDURE(*ArcFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED

HTMLReportGenerator.IReportGenerator.ProcessChord      PROCEDURE(*ChordFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED

HTMLReportGenerator.IReportGenerator.ProcessImage      PROCEDURE(*ImageFormatGrp imgf, STRING iName, STRING pExtendControlAttr)
  CODE
    SELF.ProcessComment('',pExtendControlAttr)
    IF NOT SELF.SkipControl
      SELF.ProcessImage(imgf, iName)
    END  

HTMLReportGenerator.IReportGenerator.ProcessGroup      PROCEDURE(*GroupFormatGrp gfg, STRING Text, STRING pExtendControlAttr)
  CODE
    SELF.ProcessComment(Text,pExtendControlAttr)
    IF NOT SELF.SkipControl
      SELF.ProcessGroup(gfg, Text)
    END  

HTMLReportGenerator.IReportGenerator.ProcessPie        PROCEDURE(SliceFormatQueue sfq, *PosGrp Pos, STRING pExtendControlAttr)
  CODE
  !NOT SUPPORTED

HTMLReportGenerator.IReportGenerator.ProcessRadio      PROCEDURE(*RadioFormatGrp rf, STRING Text, STRING pExtendControlAttr)
  CODE
    SELF.ProcessComment(Text,pExtendControlAttr)
    IF NOT SELF.SkipControl
      SELF.ProcessRadio(rf, Text)
    END  

HTMLReportGenerator.IReportGenerator.ProcessRectangle    PROCEDURE(*RectFormatGrp rf, STRING pExtendControlAttr)
  CODE
    SELF.ProcessComment('',pExtendControlAttr)
    IF NOT SELF.SkipControl
    ! Can't display rounded edges in HTML 
      SELF.ProcessRect(rf, FALSE)
    END  
  
HTMLReportGenerator.IReportGenerator.ProcessString    PROCEDURE(*StringFormatGrp tf, STRING text, STRING pExtendControlAttr)
  CODE
    SELF.ProcessComment(Text,pExtendControlAttr)
    IF NOT SELF.SkipControl
      SELF.ProcessString(tf, text)
    END  

HTMLReportGenerator.IReportGenerator.ProcessText     PROCEDURE(TextFormatQueue TextFormatQ, STRING pExtendControlAttr)
  CODE
    SELF.ProcessComment('',pExtendControlAttr)
    IF NOT SELF.SkipControl
      SELF.ProcessText(TextFormatQ)
    END

HTMLReportGenerator.IReportGenerator.ProcessBand     PROCEDURE(STRING type, BYTE start)
  CODE
  !NOT SUPPORTED

HTMLReportGenerator.IReportGenerator.ProcessPolygon  PROCEDURE(PointQueue pPointQueue, *StyleGrp pStyleGrp, STRING pExtendControlAttr)
  CODE
  !NOT SUPPORTED

HTMLReportGenerator.IReportGenerator.SetResultQueue      PROCEDURE(OutputFileQueue pOutputFile)
 CODE
    SELF.OutputFileQueue &= pOutputFile
    FREE(SELF.OutputFileQueue)

HTMLReportGenerator.IReportGenerator.SupportResultQueue  PROCEDURE()
 CODE
 RETURN True

