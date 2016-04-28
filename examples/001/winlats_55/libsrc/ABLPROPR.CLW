
   MEMBER
COMPILE('__Test__',_WebRunDllMode_)
ERROR: WebRunDllMode set incorrectly
__Test__

   INCLUDE('WBSTD.INC'),ONCE
   MAP
     MODULE('WSL')
WSLFIELDNAME     PROCEDURE(SIGNED Feq),*CSTRING,NAME('Cla$FIELDNAME')
     END
   .

_DefineEmbedNames_      EQUATE(1)

   INCLUDE('ABLPROPR.INC')
   INCLUDE('WBFILES.INC')
   INCLUDE('WSLPROP.INT')
   INCLUDE('LAYVALUE.INT')
   INCLUDE('LAYLIST.INT')

PropertyQueue           QUEUE,TYPE
Name                      ASTRING
NameAsAtom                LONG,OVER(Name)
Value                     &IValue
                        END

A:AccessKey             ASTRING('AccessKey')
A:Cell                  ASTRING('Cell')
A:CellBackColor         ASTRING('CellBackColor')
A:CellForeColor         ASTRING('CellForeColor')
A:CellText              ASTRING('CellText')
A:Choice                ASTRING('Choice')
A:Color                 ASTRING('Color')
A:ColumnHeader          ASTRING('ColumnHeader')
A:ColumnWidth           ASTRING('ColumnWidth')
A:Contents              ASTRING('Contents')
A:Disable               ASTRING('Disable')
A:Disabled              ASTRING('Disabled')
A:DisplayText           ASTRING('DisplayText')
A:EmbedAfterControl     ASTRING('EmbedAfterControl')
A:EmbedAfterWindow      ASTRING('EmbedAfterWindow')
A:EmbedBeforeControl    ASTRING('EmbedBeforeControl')
A:EmbedBeforeWindow     ASTRING('EmbedBeforeWindow')
A:EmbedInsideTitle      ASTRING('EmbedInsideTitle')
A:EmbedMetaTags         ASTRING('EmbedMetaTags')
A:EmbedBeforeHeadClose  ASTRING('EmbedBeforeHeadClose')
A:EmbedBeforeBodyOpen   ASTRING('EmbedBeforeBodyOpen')
A:EmbedTopOfForm        ASTRING('EmbedTopOfForm')
A:EmbedBottomOfForm     ASTRING('EmbedBottomOfForm')
A:EmbedBeforeHtmlClose  ASTRING('EmbedBeforeHtmlClose')
A:FontColor             ASTRING('FontColor')
A:FontFace              ASTRING('FontFace')
A:FontName              ASTRING('FontName')
A:FontNeeded            ASTRING('FontNeeded')
A:FontSize              ASTRING('FontSize')
A:FormEncoding          ASTRING('FormEncoding')
A:FormMethod            ASTRING('FormMethod')
A:FromCell              ASTRING('FromCell')
A:FromColumns           ASTRING('FromColumns')
A:FromRows              ASTRING('FromRows')
A:Height                ASTRING('Height')
A:Hide                  ASTRING('Hide')
A:Hidden                ASTRING('Hidden')
A:Icon                  ASTRING('Icon')
A:Image                 ASTRING('Image')
A:IsDrop                ASTRING('IsDrop')
A:Name                  ASTRING('Name')
A:NavigationControls    ASTRING('NavigationControls')
A:ProgramReference      ASTRING('ProgramReference')
A:Public                ASTRING('Public')
A:SelectOnFocus         ASTRING('SelectOnFocus')
A:Separator             ASTRING('Separator')
A:SubmitOnChange        ASTRING('SubmitOnChange')
A:TimeOut               ASTRING('TimeOut')
A:Title                 ASTRING('Title')
A:Type                  ASTRING('Type')
A:Width                 ASTRING('Width')
A:PixelHeight           ASTRING('PixelHeight')
A:PixelWidth            ASTRING('PixelWidth')
A:Window                ASTRING('Window')
A:Wizard                ASTRING('Wizard')
A:XPos                  ASTRING('XPos')
A:XPosition             ASTRING('XPosition')
A:YPos                  ASTRING('YPos')
A:YPosition             ASTRING('YPosition')

DefaultTheme            CSTRING(255)

!!=======================================================================

WbCoreRunHtmlProperties.GetName PROCEDURE
  CODE
  IF SELF.Feq >= 0
    RETURN 'Feq' & SELF.Feq
  END
  RETURN 'GFeq' & -SELF.Feq

WbCoreRunHtmlProperties.GetPosition  PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>)
  CODE
  GetPosition(SELF.Feq, x, y, w, h)
  IF (~OMITTED(6)) THEN noWidth = SELF.Feq{PROP:nowidth} .
  IF (~OMITTED(7)) THEN noHeight = SELF.Feq{PROP:noheight} .

WbCoreRunHtmlProperties.Init   PROCEDURE(SIGNED Feq, SIGNED Container)
  CODE
  PARENT.Init(Feq)
  SELF.Feq = Feq
  SELF.Type = Feq{PROP:type}
  IF (Container = FEQ:Unknown)
    SELF.Container = Feq{PROP:parent}
  ELSE
    SELF.Container = Container
  END

!!-----------------------------------------------------------------------

WbControlHtmlProperties.Destruct PROCEDURE
Index                   SIGNED,AUTO
  CODE
  IF (NOT SELF.Properties &= NULL)
    LOOP Index = 1 TO RECORDS(SELF.Properties)
      GET(SELF.Properties, Index)
      SELF.Properties.Value.Release()
    END
    DISPOSE(SELF.Properties)
  END
  IF (NOT SELF.From &= NULL)
    SELF.From.Release()
  END

WbControlHtmlProperties.CanContain                PROCEDURE
  CODE
    CASE (SELF.TYPE)
    OF CREATE:sheet
    OROF CREATE:tab
    OROF CREATE:group
    OROF CREATE:box
    OROF CREATE:panel
    OROF CREATE:region
    OROF CREATE:istoolbar
      RETURN true
    END
    RETURN false

WbControlHtmlProperties.IsDefaultButton      PROCEDURE
  CODE
    !NB: First test is only an optimization
    RETURN CHOOSE((SELF.Type = CREATE:Button) AND SELF.Feq{PROP:default})


WbControlHtmlProperties.IsFontNeeded   PROCEDURE
  CODE
    !MORE: What should this code say?
    IF SELF.Feq{PROP:color} <> COLOR:black OR |
       SELF.Feq{PROP:fontname} <> 'System' OR |
       SELF.Feq{PROP:fontsize} <> 0
      RETURN true
    END
    RETURN false

WbControlHtmlProperties.GetDefaultContainerIndex  PROCEDURE
  CODE
  RETURN SELF.Feq{PROP:childindex}

WbControlHtmlProperties.GetEmbedText    PROCEDURE(ASTRING embed)
  CODE
  RETURN ''

WbControlHtmlProperties.GetInstanceName PROCEDURE
  CODE

  RETURN SELF.GetName()

WbControlHtmlProperties.GetName PROCEDURE
  CODE
    IF (SELF.FieldName)
      RETURN SELF.FieldName
    END
    RETURN PARENT.GetName()

WbControlHtmlProperties.GetPosition  PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>)
  CODE
    PARENT.GetPosition(x, y, w, h, nowidth, noheight)
    CASE (SELF.Type)
    OF CREATE:tab
      GetPosition(SELF.Container,x,y,w,h)
    OF CREATE:menubar
      w = self.Container{PROP:Width}
      h = 10
      IF ~OMITTED(6) THEN nowidth = FALSE .
    OF CREATE:menu
    OROF CREATE:item
      IF (SELF.Container{PROP:type} = CREATE:menubar)
        x = SELF.Feq{PROP:childindex} * 40
        y = 0
      ELSE
        x = 0
        y = SELF.Feq{PROP:childindex} * 40
      END
      w = 10
      h = 10
      IF ~OMITTED(6) THEN nowidth = true .
      IF ~OMITTED(7) THEN noHeight = true .
    END


WbControlHtmlProperties.GetExtraProperty  PROCEDURE(ASTRING name)
  CODE
    IF (NOT SELF.Properties &= NULL)
      SELF.Properties.Name = name
      GET(SELF.Properties, SELF.Properties.NameAsAtom)
      IF (~ERRORCODE())
         SELF.Properties.Value.Link()
         RETURN SELF.Properties.Value
      END
    END
    RETURN NULL


WbControlHtmlProperties.GetHotKey         PROCEDURE()
Feq                     SIGNED(0)
Prev                    SIGNED,AUTO
PrevType                SIGNED,AUTO
  CODE
    CASE (SELF.Type)
    OF CREATE:Prompt
    OROF CREATE:Button
    OROF CREATE:Check
    OROF CREATE:Item
    OROF CREATE:Menu
    OROF CREATE:Option
    OROF CREATE:Radio
    OROF CREATE:Tab
      Feq = SELF.Feq
    ELSE
      !MORE: Check KEY() attribute...

      !Hotkey for an entry ect. - look at the preceeding control...
      Prev = SELF.Feq{PROP:follows}
      PrevType = Prev{PROP:type}
      IF (PrevType = CREATE:prompt) OR (PrevType = CREATE:group)
         Feq = Prev
      END
    END

    IF (Feq)
      RETURN IC:GetHotKey(Feq{PROP:screentext})
    END
    RETURN ''

WbControlHtmlProperties.GetPixelHeight PROCEDURE()

PreVMode unsigned, auto
RetVal signed, auto

  CODE
  PrevMode = 0{PROP:Pixels}
  0{PROP:Pixels} = TRUE
  Retval = SELF:Feq{PROP:Height}
  0{PROP:Pixels} = PrevMode
  return RetVal

WbControlHtmlProperties.GetPixelWidth PROCEDURE()

PreVMode unsigned, auto
RetVal signed, auto

  CODE
  PrevMode = 0{PROP:Pixels}
  0{PROP:Pixels} = TRUE
  Retval = SELF:Feq{PROP:Width}
  0{PROP:Pixels} = PrevMode
  return RetVal

WbControlHtmlProperties.GetProperty  PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)
WhichProp               ASTRING
GlobalFiles             &WbFilesClass,AUTO
retValue                CSTRING(9999)
Result                  &IValue,AUTO
Type                    SIGNED(WslPropType:String)
  CODE
    Result &= SELF.GetExtraProperty(name)
    IF (NOT Result &= NULL)
      RETURN Result
    END

       IF (A:AccessKey = name)
                        RETURN CreateStringValue(SELF.GetHotKey())
    ELSIF (A:Choice = name)
                        RETURN CreateIntegerValue(CHOICE(SELF.Feq))
    ELSIF (A:Cell = name) OR (A:CellText = name)
                        RETURN CreateStringValue(SELF.From.GetCellText(idx2, idx1))
    ELSIF (A:CellBackColor = name)
                        RETURN CreateIntegerValue(SELF.From.GetCellBackColor(idx2, idx1))
    ELSIF (A:CellForeColor = name)
                        RETURN CreateIntegerValue(SELF.From.GetCellColor(idx2, idx1))
    ELSIF (A:ColumnHeader = name)
                        RETURN CreateStringValue(SELF.Feq{PROPLIST:Header, idx1+1})
    ELSIF (A:ColumnWidth = name)
                        RETURN CreateIntegerValue(SELF.Feq{PROPLIST:width, idx1+1})
    ELSIF (A:Contents = name)
                        RETURN CreateStringValue(CONTENTS(SELF.Feq))
    ELSIF (A:Disabled = name)
                        WhichProp = A:Disable
    ELSIF (A:DisplayText = name)
                        RETURN CreateStringValue(IC:StripHotkey(SELF.Feq{PROP:screenText}))
    ELSIF (A:EmbedAfterControl = name)
                        RETURN CreateStringValue(SELF.GetEmbedText(name))
    ELSIF (A:EmbedBeforeControl = name)
                        RETURN CreateStringValue(SELF.GetEmbedText(name))
    ELSIF (A:FontColor = name)
                        WhichProp = A:Color
    ELSIF (A:FontFace = name)
                        WhichProp = A:FontName
    ELSIF (A:FontNeeded = name)
                        RETURN CreateBoolValue(SELF.IsFontNeeded())
    ELSIF (A:FontSize = name)
                        WhichProp = A:FontSize
    ELSIF (A:FromColumns = name)
                        IF (NOT SELF.From &= NULL)
                          RETURN CreateIntegerValue(SELF.From.GetNumColumns())
                        END
    ELSIF (A:FromRows = name)
                        IF (NOT SELF.From &= NULL)
                          RETURN CreateIntegerValue(SELF.From.GetNumRows())
                        END
    ELSIF (A:Hidden = name)
                        RETURN CreateBoolValue(CHOOSE(SELF.SuppressInsertion OR SELF.Feq{PROP:hide}))
    ELSIF (A:Icon = name) OR (A:Image = name)
                        GlobalFiles &= WbFilesClass::Get()
                        IF (GlobalFiles &= NULL)
                          retValue = SELF.Feq{PROP:tempimage}
                        ELSE
                          retValue = GlobalFiles.GetAlias(SELF.Feq{PROP:tempimage})
                        END
                        !SELF.SetExtraProperty(A:Image, retValue)                ! Cache the result to avoid recalculation
    ELSIF (A:IsDrop = name)
                        RETURN CreateBoolValue(CHOOSE(SELF.Feq{PROP:drop} > 0))
    ELSIF (A:Name = name)
                        RETURN CreateStringValue(SELF.GetInstanceName())
    ELSIF (A:NavigationControls = name)
                        RETURN CreateBoolValue(true)
    ELSIF (A:PixelHeight = name)
                        RETURN CreateIntegerValue(SELF.GetPixelHeight())
    ELSIF (A:PixelWidth = name)
                        RETURN CreateIntegerValue(SELF.GetPixelWidth())
    ELSIF (A:Public = name)
                        GlobalFiles &= WbFilesClass::Get()
                        IF (NOT GlobalFiles &= NULL)
                          RETURN CreateStringValue(GlobalFiles.GetAliasPrefix())
                        END
    ELSIF (A:ProgramReference = name)
                        GlobalFiles &= WbFilesClass::Get()
                        IF (NOT GlobalFiles &= NULL)
                          RETURN CreateStringValue(GlobalFiles.GetProgramRef())
                        END
    ELSIF (A:SelectOnFocus = name)
                        RETURN CreateBoolValue(TRUE)
    ELSIF (A:Separator = name)
                        RETURN CreateBoolValue(SELF.Feq{PROP:separate})
    ELSIF (A:SubmitOnChange = name)
                        RETURN CreateBoolValue(SELF.SubmitOnChange)
    ELSIF (A:Type = name)
                        RETURN CreateStringValue(SELF.GetSkeletonAttr(SkeletonAttr:Control))
    ELSIF (A:Wizard = name)
                        WhichProp = name
    ELSE
      Result &= PARENT.GetProperty(name, idx1, idx2)
      IF (NOT Result &= NULL)
        RETURN Result
      END
      WhichProp = name
    END

    IF WhichProp
      Type = BAND(GetPropertyType(WhichProp), WslPropType:mask)
      retValue = SELF.Feq{WhichProp, idx1}
      IF Type = -1
        Type = WslPropType:String
      END
    END

    RETURN CreateValue(Type, retValue)


WbControlHtmlProperties.GetSkeletonAttr           PROCEDURE(SIGNED whichAttr)
result                  any
  CODE
    result = PARENT.GetSkeletonAttr(whichAttr)
    CASE whichAttr
    OF SkeletonAttr:Capabilities
      IF (NOT SELF.From &= NULL) AND (SELF.From.GetNumColumns() > 1)
        result = result & ',multicolumn'
      END
      IF (SELF.Type = CREATE:list) OR (SELF.Type = CREATE:combo)
        IF SELF.Feq{PROP:drop} > 0
          result = result & ',drop'
        END
        IF (SELF.Feq{PROP:imm})
          result = result & ',pageloaded'
        END
      END
    OF SkeletonAttr:Control
      CASE (SELF.Type)
      OF CREATE:sstring;        RETURN 'sstring'
      OF CREATE:string;         RETURN 'string'
      OF CREATE:image;          RETURN 'image'
      OF CREATE:region;         RETURN 'region'
      OF CREATE:line;           RETURN 'line'
      OF CREATE:box;            RETURN 'box'
      OF CREATE:ellipse;        RETURN 'ellipse'
      OF CREATE:entry;          RETURN 'entry'
      OF CREATE:button;         RETURN 'button'
      OF CREATE:prompt;         RETURN 'prompt'
      OF CREATE:option;         RETURN 'option'
      OF CREATE:check;          RETURN 'check'
      OF CREATE:group;          RETURN 'group'
      OF CREATE:list;           RETURN 'list'
      OF CREATE:combo;          RETURN 'combo'
      OF CREATE:spin;           RETURN 'spin'
      OF CREATE:text;           RETURN 'text'
      OF CREATE:custom;         RETURN 'custom'
      OF CREATE:menu;           RETURN 'menu'
      OF CREATE:item;           RETURN 'item'
      OF CREATE:radio;          RETURN 'radio'
      OF CREATE:menubar;        RETURN 'menubar'
      OF CREATE:application;    RETURN 'application'
      OF CREATE:window;         RETURN 'window'
      OF CREATE:report;         RETURN 'report'
      OF CREATE:header;         RETURN 'header'
      OF CREATE:footer;         RETURN 'footer'
      OF CREATE:break;          RETURN 'break'
      OF CREATE:form;           RETURN 'form'
      OF CREATE:detail;         RETURN 'detail'
      OF CREATE:ole;            RETURN 'ole'
      OF CREATE:progress;       RETURN 'progress'
      OF CREATE:sheet;          RETURN 'sheet'
      OF CREATE:tab;            RETURN 'tab'
      OF CREATE:panel;          RETURN 'panel'
      OF CREATE:toolbar;        RETURN 'toolbar'
      END
    END
    RETURN result


WbControlHtmlProperties.GetTargetZone             PROCEDURE()
  CODE
  IF (SELF.SuppressInsertion)
    RETURN ''
  END
  case SELF.Type
  of CREATE:toolbar
    RETURN 'Toolbar'
  of CREATE:menubar
    RETURN 'Menubar'
  END
  RETURN 'Default'

WbControlHtmlProperties.GetVisible    PROCEDURE
  CODE
    CASE (SELF.Type)
    OF CREATE:tab
       RETURN CHOOSE(NOT SELF.Feq{PROP:disable} AND NOT SELF.Feq{PROP:hide} |
                     AND (SELF.Feq{PROP:parent}){PROP:visible})
    OF CREATE:button
    OROF CREATE:item
      CASE SELF.Feq{PROP:std}
      OF STD:Close
      OROF 0
        !OK => defaultprocessing
      OF STD:Help
!        IF (NOT SELF.OwnerWindow.HelpEnabled)
!          RETURN FALSE
!        END
      ELSE
        RETURN FALSE
      END
    OF CREATE:menu
      IF NOT SELF.Feq{PROP:child,1}
        RETURN FALSE
      END
    END
    RETURN SELF.Feq{PROP:visible}

WbControlHtmlProperties.HasChildOfType    PROCEDURE(SIGNED type, BOOL Invert)
Index                   SIGNED,AUTO
ThisType                SIGNED,AUTO
  CODE
    LOOP Index = 1 TO RECORDS(SELF.Contents)
      GET(SELF.Contents, Index)
      ThisType = SELF.Contents.cid{PROP:Type}
      IF (NOT SELF.Contents.cid{PROP:hide})
        IF (ThisType = Type) XOR Invert THEN RETURN true.
      END
    END
    RETURN FALSE

WbControlHtmlProperties.Init      PROCEDURE(SIGNED Feq, SIGNED Container)
FieldName               CSTRING(1023),AUTO
Index                   SIGNED,AUTO
  CODE
    PARENT.Init(Feq, Container)
    IF (SELF.Feq{PROP:fromptr} <> 0)
      SELF.From &= CreateListboxContents(SELF.Feq)
    END
    IF (SELF.Feq{PROP:useaddress})
      SELF.HasUseVar = true
    END
    FieldName = WSLFIELDNAME(SELF.Feq)
    IF (LEN(FieldName)>1)
      LOOP Index = 1 TO LEN(FieldName)
        IF FieldName[Index]=':' THEN FieldName[Index]='_' .
      END
      SELF.FieldName = SUB(FieldName, 2, -1)
    END

WbControlHtmlProperties.IsHidden   PROCEDURE
  CODE
    IF (SELF.SuppressInsertion)
      RETURN true
    END
    IF (SELF.Feq)                       ! Any control, not the window
      IF SELF.Feq{PROP:hide} THEN RETURN TRUE.
      IF SELF.Feq{PROP:intoolbar} AND SELF.Feq{PROP:disable} THEN RETURN TRUE.
    END
    IF (SELF.Type = CREATE:button) OR (SELF.Type = CREATE:item)
      CASE SELF.Feq{PROP:std}
      OF STD:Close
      OROF 0                    !OK => defaultprocessing
      OF STD:Help
!        IF (NOT SELF.OwnerWindow.HelpEnabled)
!          RETURN TRUE
!        END
      ELSE
        RETURN TRUE
      END
    END
    RETURN FALSE


WbControlHtmlProperties.SetExtraProperty  PROCEDURE(ASTRING name, IValue value)
  CODE
    IF (SELF.Properties &= NULL)
      SELF.Properties &= NEW PropertyQueue
    END
    SELF.Properties.Name = Name
    GET(SELF.Properties, SELF.Properties.NameAsAtom)
    SELF.Properties.Name = Name
    SELF.Properties.Value &= value
    IF (ERRORCODE())
      SELF.Properties.Name = Name
      ADD(SELF.Properties)
    ELSE
      PUT(SELF.Properties)
    END


WbControlHtmlProperties.SetExtraProperty  PROCEDURE(ASTRING name, STRING value, SIGNED type)
NewValue                &IValue,AUTO
  CODE
    NewValue &= CreateValue(type, value)
    SELF.SetExtraProperty(name, NewValue)

WbControlHtmlProperties.SetProperty  PROCEDURE(ASTRING name, STRING value)
  CODE
    SELF.SetProperty(name, value)

WbControlHtmlProperties.BeforeResponse    PROCEDURE()
  CODE
  SELF.HadResponse = false
  SELF.DelayPost = false
  SELF.WasVisible = SELF.GetVisible()

WbControlHtmlProperties.ChangeContents   PROCEDURE(STRING newValue, bool PostEvent)
PrevValue               ANY
EventNo                 SIGNED(0)
  CODE
    CASE (SELF.Type)
    OF CREATE:entry
    OROF CREATE:combo
    OROF CREATE:spin
      SELF.Feq{PROP:screentext} = newValue
      PrevValue = CONTENTS(SELF.Feq)
      UPDATE(SELF.Feq)
      IF (PostEvent)
        IF (SELF.Feq{PROP:rejectcode}<>0)
          EventNo = EVENT:Rejected
        ELSE
          IF (PrevValue <> CONTENTS(SELF.Feq))
            EventNo = EVENT:Accepted
          END
        END
      END
    OF CREATE:button
    OROF CREATE:item
    OROF CREATE:image
      EventNo = EVENT:Accepted
    ELSE
      PrevValue = CONTENTS(SELF.Feq)
      CHANGE(SELF.Feq, newValue)
      IF PrevValue <> CONTENTS(SELF.feq)
        EventNo = EVENT:Accepted
      END
    END

    IF (PostEvent AND EventNo)
      SELF.PostEvent(EventNo)
    END

WbControlHtmlProperties.Post  PROCEDURE(SIGNED EventNo)
  CODE
  IF (SELF.DelayPost)
    SELF.EventProcessor.DelayedPost(EventNo, SELF.Feq)
  ELSE
    POST(EventNo, SELF.Feq)
  END

WbControlHtmlProperties.PostEvent   PROCEDURE(SIGNED EventNo)
  CODE
  CASE (SELF.Type)
  OF CREATE:button
  OROF CREATE:item
    IF (EventNo=EVENT:Accepted)
      IF (SELF.Feq{PROP:std} = STD:Close)
        EventNo = EVENT:CloseWindow
      END
    END
  OF CREATE:sheet
  OROF CREATE:list
  OROF CREATE:option
    IF (EventNo = EVENT:Accepted)
      SELF.Post(EVENT:NewSelection)
      IF NOT SELF.HasUseVar
        EventNo = 0
      END
    END
  END

  IF (EventNo)
    SELF.Post(EventNo)
  END

WbControlHtmlProperties.TakeResponse      PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor)
  CODE
    SELF.HadResponse = TRUE
    CASE (SELF.Type)
    OF CREATE:button
    OROF CREATE:item
    OROF CREATE:sheet
    OROF CREATE:image
    OROF CREATE:tab
    OROF CREATE:window
    OROF CREATE:application
      ! Handle any accepted events for these controls last.  Otherwise all
      ! the accepted events for entries etc. on the window will not have
      ! been processed yet.
      SELF.DelayPost = true
      SELF.EventProcessor &= EventProcessor
    END

    CASE (type)
    OF RESET:Choice
      IF (CHOICE(SELF.Feq) <> Value)
        SELF.Feq{PROP:selstart} = Value
        SELF.PostEvent(EVENT:Accepted)
      END
    OF RESET:Bool
      IF (Value= '0') OR (Value= 'OFF') OR (Value= 'FALSE')
        SELF.ChangeContents('')
      ELSE
        SELF.ChangeContents('1')
      END
    OF RESET:Value
      SELF.ChangeContents(Value)
    ELSE
      IF (type < EVENT:Last)
        SELF.PostEvent(type)
      END
    END
    SELF.DelayPost = false

WbControlHtmlProperties.AfterResponse     PROCEDURE()
  CODE
  CASE (SELF.Type)
  OF CREATE:check
    IF (NOT SELF.HadResponse) AND SELF.WasVisible
      IF (SELF.Feq{PROP:checked})
        CHANGE(SELF.Feq, '')
        POST(EVENT:Accepted, SELF.Feq, 0, true)     ! post at front so preceed button events
      END
    END
  END

!!=======================================================================

WbQueryButtonHtmlProperties.GetProperty  PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)
temp                    cstring(5),auto
index                   signed,auto
  CODE
  IF (name = A:Choice)
    temp = SELF.Feq{PROP:text}
    CASE (temp)
    OF '';    index = 0
    OF '=';   index = 1
    OF '>=';  index = 2
    OF '<<='; index = 3
    OF '<<>'; index = 4
    END
    RETURN CreateIntegerValue(index);
  ELSIF (name = A:DisplayText)
    temp = SELF.Feq{PROP:text}
    CASE (temp)
    OF '';    temp = '    '
    OF '=';   temp = ' = '
    END
    RETURN CreateStringValue(temp)
  END
  RETURN PARENT.GetProperty(name, idx1, idx2)

WbQueryButtonHtmlProperties.GetSkeletonAttr           PROCEDURE(SIGNED whichAttr)
  CODE
    CASE whichAttr
    OF SkeletonAttr:Capabilities
      return PARENT.GetSkeletonAttr(whichAttr) & ',query'
    END
    RETURN PARENT.GetSkeletonAttr(whichAttr)


WbQueryButtonHtmlProperties.TakeResponse      PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor)
text                    cstring(4),auto
  CODE
    CASE (value)
    OF 0;   text = ''
    OF 1;   text = '='
    OF 2;   text = '>='
    OF 3;   text = '<<='
    OF 4;   text = '<<>'
    ELSE
      ASSERT(FALSE)
    END
    SELF.Feq{PROP:Text} = text

!!=======================================================================



WbWindowHtmlProperties.GetContainer         PROCEDURE
  CODE
  RETURN Feq:None

WbWindowHtmlProperties.GetName PROCEDURE
  CODE
    RETURN 'TheWindow'

WbWindowHtmlProperties.GetPosition  PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>)
  CODE
    PARENT.GetPosition(x, y, w, h, nowidth, noheight)
    x = 0
    y = 0

WbWindowHtmlProperties.GetProperty  PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)
  CODE
  IF (A:TimeOut = name)
    RETURN CreateValue(WslPropType:integer, SELF.TimeOutDelay)
  ELSIF (A:EmbedBeforeWindow = name) OR (A:EmbedInsideTitle = name) OR (A:EmbedAfterWindow = name) OR |
        (A:EmbedMetaTags = name) OR (A:EmbedBeforeHeadClose = name) OR |
        (A:EmbedBeforeBodyOpen = name) OR (A:EmbedTopOfForm = name) OR |
        (A:EmbedBottomOfForm = name) OR (A:EmbedBeforeHtmlClose = name)
    RETURN CreateValue(WslPropType:string, SELF.GetEmbedText(name))
  ELSIF (A:FormEncoding = name)
    RETURN CreateValue(WslPropType:string, '')
  ELSIF (A:FormMethod = name)
    RETURN CreateStringValue('GET')
  ELSIF (A:Title = name)
    RETURN CreateStringValue(0{PROP:text})
  ELSIF (A:Window = name)
    RETURN CreateReferenceValue(SELF.IHtmlElementProperties)
  ELSE
    RETURN PARENT.GetProperty(name, idx1, idx2)
  END


WbWindowHtmlProperties.GetSkeletonAttr           PROCEDURE(SIGNED whichAttr)
  CODE
    CASE whichAttr
    OF SkeletonAttr:Control
      RETURN 'window'
    OF SkeletonAttr:Theme
      RETURN DefaultTheme
    END
    RETURN PARENT.GetSkeletonAttr(whichAttr)


WbWindowHtmlProperties.Init               PROCEDURE
  CODE
    PARENT.Init(0, FEQ:None)


WbWindowHtmlProperties.SetTimeOut         PROCEDURE(SIGNED Delay)
  CODE
    SELF.TimeOutDelay = Delay

!!=======================================================================

SetSkeletonTheme      PROCEDURE(STRING theme)
  CODE
  DefaultTheme = theme
