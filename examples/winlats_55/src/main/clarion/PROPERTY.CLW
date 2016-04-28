!----------------------------------------------------------
! Built-in property constants for CW
!----------------------------------------------------------*/

! Control properties

PROP:Text           EQUATE(7C00H)  ! string (parameter to control itself)
PROP:Type           EQUATE(7C01H)  ! integer (CREATE:Xxxx)
PROP:At             EQUATE(7C02H)  ! array[integer] (4 values)
PROP:Xpos           EQUATE(7C02H)  ! integer, equivalent to PROP:At[1]
PROP:Ypos           EQUATE(7C03H)  ! integer, equivalent to PROP:At[2]
PROP:Width          EQUATE(7C04H)  ! integer, equivalent to PROP:At[3]
PROP:Height         EQUATE(7C05H)  ! integer, equivalent to PROP:At[4]

PROP:Center         EQUATE(7C06H)  ! boolean
PROP:CenterOffSet   EQUATE(7C07H)  ! integer, equivalent to PROP:Center[2]
PROP:Left           EQUATE(7C08H)  ! boolean
PROP:LeftOffSet     EQUATE(7C09H)  ! integer, equivalent to PROP:Left[2]
PROP:Decimal        EQUATE(7C0AH)  ! boolean
PROP:DecimalOffSet  EQUATE(7C0BH)  ! integer, equivalent to PROP:Decimal[2]
PROP:Right          EQUATE(7C0CH)  ! boolean
PROP:RightOffSet    EQUATE(7C0DH)  ! integer, equivalent to PROP:Right[2]

PROP:Above          EQUATE(7C0AH)  ! boolean
PROP:AboveSize      EQUATE(7C0BH)  ! integer, equivalent to PROP:Above, 2
PROP:Below          EQUATE(7C06H)  ! boolean
PROP:BelowSize      EQUATE(7C07H)  ! integer, equivalent to PROP:Below, 2

PROP:Class          EQUATE(7C0EH)  ! array[string] (2 values)
PROP:VBXFile        EQUATE(7C0EH)  ! string, equivalent to PROP:Class[1]
PROP:VBXName        EQUATE(7C0FH)  ! string, equivalent to PROP:Class[2]

PROP:Font           EQUATE(7C10H)  ! array (4 values)
PROP:FontName       EQUATE(7C10H)  ! string, equivalent to PROP:Font[1]
PROP:FontSize       EQUATE(7C11H)  ! integer, equivalent to PROP:Font[2]
PROP:FontColor      EQUATE(7C12H)  ! integer, equivalent to PROP:Font[3]
PROP:FontStyle      EQUATE(7C13H)  ! integer, equivalent to PROP:Font[4]

PROP:TipsFont       EQUATE(0010H)  ! should be added to PROP:Font*
PROP:StatusFont     EQUATE(0014H)  ! should be added to PROP:Font*

PROP:Range          EQUATE(7C14H)  ! array[integer] (2 values)
PROP:RangeLow       EQUATE(7C14H)  ! integer, equivalent to PROP:Range[1]
PROP:RangeHigh      EQUATE(7C15H)  ! integer, equivalent to PROP:Range[2]

PROP:VCR            EQUATE(7C16H)  ! boolean
PROP:VCRFeq         EQUATE(7C17H)  ! string: blank, feq, or picture, = PROP:Vcr[2]

PROP:Double         EQUATE(7C19H)  ! boolean
PROP:Resize         EQUATE(7C1AH)  ! boolean
PROP:NoFrame        EQUATE(7C1BH)  ! boolean

PROP:MM             EQUATE(7C1CH)  ! boolean
PROP:Thous          EQUATE(7C1DH)  ! boolean
PROP:Points         EQUATE(7C1EH)  ! boolean  (reports only)
PROP:Pixels         EQUATE(7C1EH)  ! boolean  (windows only)

! Range 7C20H-7C3FH is reserved for fonts

PROP:Sum            EQUATE(7C40H)  ! boolean
PROP:Ave            EQUATE(7C41H)  ! boolean
PROP:Max            EQUATE(7C42H)  ! boolean
PROP:Min            EQUATE(7C43H)  ! boolean
PROP:Cnt            EQUATE(7C44H)  ! boolean
PROP:PageNo         EQUATE(7C45H)  ! boolean
PROP:Page           EQUATE(7C50H)  ! boolean


PROP:Absolute       EQUATE(7C51H)  ! boolean
PROP:Alone          EQUATE(7C52H)  ! boolean
PROP:Preview        EQUATE(7C53H)  ! queue or queuefield (write-only)
PROP:FlushPreview   EQUATE(7C54H)  ! boolean (always 0 at open)
PROP:First          EQUATE(7C55H)  ! boolean
PROP:Last           EQUATE(7C56H)  ! boolean
PROP:Ins            EQUATE(7C57H)  ! boolean
PROP:Ovr            EQUATE(7C58H)  ! boolean
PROP:Boxed          EQUATE(7C59H)  ! boolean
PROP:Cap            EQUATE(7C5AH)  ! boolean
PROP:Column         EQUATE(7C5CH)  ! integer: 0 = off, else column number
PROP:Cursor         EQUATE(7C5DH)  ! string, empty if not specifed
PROP:Default        EQUATE(7C5EH)  ! boolean
PROP:Disable        EQUATE(7C5FH)  ! boolean
PROP:Drop           EQUATE(7C60H)  ! integer, 0 if none (can't change to or from 0)
PROP:Fill           EQUATE(7C61H)  ! integer, COLORnone if none
PROP:From           EQUATE(7C62H)  ! string, queue, or queuefield (write-only)
PROP:Full           EQUATE(7C63H)  ! boolean
PROP:Gray           EQUATE(7C64H)  ! boolean
PROP:Hide           EQUATE(7C65H)  ! boolean
PROP:Hlp            EQUATE(7C66H)  ! string
PROP:HScroll        EQUATE(7C67H)  ! boolean
PROP:Icon           EQUATE(7C68H)  ! string, empty if not specified
PROP:Iconize        EQUATE(7C69H)  ! boolean
PROP:Imm            EQUATE(7C6AH)  ! boolean
PROP:Key            EQUATE(7C6BH)  ! integer
PROP:Landscape      EQUATE(7C6CH)  ! boolean
PROP:Mark           EQUATE(7C6DH)  ! queue, queuefield or array (write-only)
PROP:Mask           EQUATE(7C6EH)  ! boolean
PROP:Maximize       EQUATE(7C6FH)  ! boolean
PROP:Mdi            EQUATE(7C70H)  ! boolean (read-only)
PROP:Meta           EQUATE(7C71H)  ! boolean
PROP:Modal          EQUATE(7C72H)  ! boolean (read-only)
PROP:Msg            EQUATE(7C73H)  ! string
PROP:NoBar          EQUATE(7C74H)  ! boolean
PROP:NoMerge        EQUATE(7C75H)  ! boolean
PROP:PageAfter      EQUATE(7C77H)  ! boolean
PROP:PageAfterNum   EQUATE(7C77H)  ! integer, 0 if absent == pageafter[2]
PROP:PageBefore     EQUATE(7C78H)  ! boolean
PROP:PageBeforeNum  EQUATE(7C79H)  ! integer, 0 if absent == pagebefore[2]
PROP:Password       EQUATE(7C7AH)  ! boolean
PROP:ReadOnly       EQUATE(7C7BH)  ! boolean
PROP:Req            EQUATE(7C7CH)  ! boolean
PROP:Reset          EQUATE(7C7DH)  ! integer (nesting depth, or 0)
PROP:Round          EQUATE(7C7EH)  ! boolean
PROP:Scroll         EQUATE(7C7FH)  ! boolean
PROP:Separate       EQUATE(7C80H)  ! boolean
PROP:Skip           EQUATE(7C81H)  ! boolean
PROP:Std            EQUATE(7C82H)  ! integer
PROP:Step           EQUATE(7C83H)  ! integer
PROP:System         EQUATE(7C84H)  ! boolean
PROP:Format         EQUATE(7C85H)  ! string
PROP:Timer          EQUATE(7C86H)  ! integer, 0 if none
PROP:Check          EQUATE(7C87H)  ! boolean
PROP:Trn            EQUATE(7C88H)  ! boolean
PROP:Upr            EQUATE(7C89H)  ! boolean

PROP:VScroll        EQUATE(7C8BH)  ! boolean
PROP:WithNext       EQUATE(7C8CH)  ! integer, 0 if absent
PROP:WithPrior      EQUATE(7C8DH)  ! integer, 0 if absent
PROP:Items          EQUATE(7C8EH)  ! integer (read only, runtime only)
PROP:Selected       EQUATE(7C8FH)  ! integer (runtime only)
PROP:SelStart       EQUATE(7C8FH)  ! integer (runtime only)
PROP:SelEnd         EQUATE(7C90H)  ! integer (runtime only)
PROP:Auto           EQUATE(7C91H)  ! boolean
PROP:ToolBox        EQUATE(7C92H)  ! boolean
PROP:Palette        EQUATE(7C93H)  ! integer
PROP:ImageBits      EQUATE(7C94H)  ! string variable (runtime only)
PROP:Thread         EQUATE(7C95H)  ! integer read-only, runtime only
PROP:Handle         EQUATE(7C96H)  ! integer read-only, runtime only
PROP:Active         EQUATE(7C97H)  ! boolean, runtime only
PROP:VBXEvent       EQUATE(7C98H)  ! string, read-only, runtime only
PROP:Follows        EQUATE(7C99H)  ! integer, write-only, runtime only
PROP:AcceptAll      EQUATE(7C9AH)  ! boolean (runtime only, also set by SELECT() and cleared by SELECT(n))
PROP:Touched        EQUATE(7C9BH)  ! boolean (runtime only)
PROP:VScrollPos     EQUATE(7C9EH)  ! integer: Scroll thumb position (0-100)
PROP:ClipBits       EQUATE(7C9FH)  ! boolean, write-only (Clip image control to clipboard)
PROP:Tip            EQUATE(7CA0H)  ! string, Tool tip text
PROP:ToolTip        EQUATE(PROP:Tip)  ! deprecated: string, Old name

PROP:LFNSupport     EQUATE(7CA5H)  ! boolean (system-only): use long filenames where allowed (16-bit runtime only)
PROP:Progress       EQUATE(7CA6H)  ! integer: progress bar position (runtime only)
PROP:Visible        EQUATE(7CA7H)  ! boolean: is control visible (read-only, runtime-only)
PROP:Enabled        EQUATE(7CA8H)  ! boolean: is control enabled (read-only, runtime-only)
PROP:Wizard         EQUATE(7CA9H)  ! boolean: wizard style sheets
PROP:ChoiceFEQ      EQUATE(7CAAH)  ! integer: current field equate value of a choice in sheet, option
PROP:ClientHandle   EQUATE(7CABH)  ! integer: client window handle (read-only, runtime only)
PROP:LineCount      EQUATE(7CACH)  ! integer: lines of text in a TEXT control (read-only, runtime only)
PROP:MinWidth       EQUATE(7CADH)  ! integer: window's minimum width (runtime only)
PROP:MinHeight      EQUATE(7CAEH)  ! integer: window's minimum height (runtime only)
PROP:MaxWidth       EQUATE(7CAFH)  ! integer: window's maximum width (runtime only)
PROP:MaxHeight      EQUATE(7CB0H)  ! integer: window's maximum height (runtime only)
PROP:NoTips         EQUATE(7CB1H)  ! boolean: Disable tooltips on system/window/control (runtime only)
PROP:TipDelay       EQUATE(7CB2H)  ! integer: Delay before tips appear (16-bit runtime only, system only)
PROP:TipDisplay     EQUATE(7CB3H)  ! integer: Time for which tips are displayed (16-bit runtime only, system only)
PROP:WNDProc        EQUATE(7CB4H)  ! integer: Window procedure set/get (for PROP:Handle)
PROP:ClientWNDProc  EQUATE(7CB5H)  ! integer: window procedure set/get (for PROP:Clienthandle)
PROP:ImageBlob      EQUATE(7CB6H)  ! integer: BLOB handle (runtime only)
PROP:Spread         EQUATE(7CB7H)  ! boolean: SPREAD attribute
PROP:Size           EQUATE(7CB9H)  ! integer: For a BLOB
PROP:ScreenText     EQUATE(7CBAH)  ! string: May differ from PROP:Text for eg ENTRY
PROP:HScrollPos     EQUATE(7CBBH)  ! integer: Horizontal scroll position
PROP:LazyDisplay    EQUATE(7CBCH)  ! boolean: Don't force update immediately
PROP:DeferMove      EQUATE(7CBDH)  ! integer: Delay window positioning
PROP:AppInstance    EQUATE(7CBEH)  ! integer (system-only): HINSTANCE of exe file (read-only)
PROP:Value          EQUATE(7CBFH)  ! string: value for a radio or tab to assign to use.

PROP:TrueValue      EQUATE(7CBFH)  ! string: value for check radio to assign to use.
PROP:FalseValue     EQUATE(7CC0H)  ! string: value for a check to assign to use.
PROP:DDETimeOut     EQUATE(7CC1H)  ! integer (system-only): DDE timeout, in sec/100
PROP:TabRows        EQUATE(7CC2H)  ! integer: Num rows in a tab (read-only)
PROP:NumTabs        EQUATE(7CC3H)  ! integer: Num tabs owned by a sheet (read-only)
PROP:LibVersion     EQUATE(7CC4H)  ! integer: runtime library version
PROP:ExeVersion     EQUATE(7CC5H)  ! integer: executable file version

PROP:Create          EQUATE(7CC6H) ! string: create new ole object
PROP:SaveAs          EQUATE(7CC7H) ! string
PROP:Open            EQUATE(7CC8H) ! string
PROP:Blob            EQUATE(7CC9H) ! integer
PROP:DoVerb          EQUATE(7CCAH) ! integer: activate Ole Object
PROP:SizeMode        EQUATE(7CCBH) ! integer: controls the way not running object is displayed
PROP:SelectInterface EQUATE(7CCCH) ! string: Select current ole interface
PROP:AddRef          EQUATE(7CCDH) ! string: Increment reference count
PROP:Release         EQUATE(7CCEH) ! string: Decrement reference count
PROP:Deactivate      EQUATE(7CCFH) ! boolean action: deactivate object
PROP:Update          EQUATE(7CD0H) ! boolean action: update object
PROP:Paste           EQUATE(7CD1H) ! boolean action: embed object from clipboard
PROP:ReportException EQUATE(7CD2H) ! boolean: pop up ole exceptions
PROP:PasteLink       EQUATE(7CD3H) ! boolean action: create link from clipboard
PROP:Copy            EQUATE(7CD4H) ! boolean action: copy object to clipboard
PROP:CanPaste        EQUATE(7CD5H) ! boolean
PROP:CanPasteLink    EQUATE(7CD6H) ! boolean
PROP:WindowUI        EQUATE(7CD7H) ! boolean
PROP:DesignMode      EQUATE(7CD8H) ! boolean
PROP:Ctrl            EQUATE(7CD9H) ! boolean, read-only
PROP:GrabHandles     EQUATE(7CDAH) ! boolean
PROP:OLE             EQUATE(7CDBH) ! boolean, read-only
PROP:IsRadio         EQUATE(7CDCH) ! boolean, read-only
PROP:LastEventName   EQUATE(7CDDH) ! string, read-only
PROP:CLSID           EQUATE(7CDEH) ! string, read-only
PROP:ProgID          EQUATE(7CDFH) ! string, read-only

PROP:BevelStyle     EQUATE(7CE0H)  ! integer: kind of bevel for boxes

PROP:Join           EQUATE(7CE2H)  ! boolean: Join < > buttons
PROP:NoSheet        EQUATE(7CE3H)  ! boolean: Just display the tabs - no sheet
PROP:Bevel          EQUATE(7CE4h)  ! array[integer]
PROP:BevelOuter     EQUATE(7CE4H)  ! integer: Size, direction of outer bevel == PROP:Bevel[1]
PROP:BevelInner     EQUATE(7CE5H)  ! integer: Size, direction of inner bevel == PROP:Bevel[2]
PROP:LineWidth      EQUATE(7CE7H)  ! integer: Pen width for a BOX or LINE
PROP:Angle          EQUATE(7CE9H)  ! integer: Angle of text for a string control

PROP:AutoSize       EQUATE(7CEAH)
PROP:Clip           EQUATE(7CEBH)
PROP:Stretch        EQUATE(7CECH)
PROP:Zoom           EQUATE(7CEDH)
PROP:Compatibility  EQUATE(7CEEH)
PROP:Design         EQUATE(7CEFH)
PROP:Document       EQUATE(7CF0H)  ! create ole object from file (like x.doc i.e. a word document)
PROP:Link           EQUATE(7CF1H) ! as above but link
PROP:CreateFromFile   EQUATE(PROP:Document)  ! Compatability
PROP:CreateLinkToFile EQUATE(PROP:Link)      !
PROP:Align          EQUATE(7CF2H) ! vb ocx align
PROP:Cancel         EQUATE(7CF3H) ! vb ocx cancel
PROP:TextAlign      EQUATE(7CF4H) ! vb ocx ambient property 0-number right text left, 1-left, 2-center, 3-right 4-sustify
PROP:Object         EQUATE(7CF5H)
PROP:License        EQUATE(7CF6H)
PROP:Language       EQUATE(7CF8H)

PROP:Color          EQUATE(7CFAH)  ! array[integer]: up to three components (see below)
PROP:Background     EQUATE(7CFAH)  ! integer: For compatibility
PROP:FillColor      EQUATE(7CFAH)  ! integer: = PROP:Color[1]  single value, COLORnone if none
PROP:SelectedColor  EQUATE(7CFBH)  ! integer: = PROP:Color[2]  single value, COLORnone if none
PROP:SelectedFillColor EQUATE(7CFCH)  ! integer: = PROP:Color[3] single value, COLORnone if none
PROP:LineHeight     EQUATE(7CFDH)  ! integer: Height of a line in a list box
PROP:DropWidth      EQUATE(7CFEH)  ! integer: Width of a drop box
PROP:AlwaysDrop     EQUATE(7CFFH)  ! boolean: Drop control always displays the list on selection change

PROP:Up             EQUATE(7A00H)  ! boolean: orientations of text in a sheet
PROP:Down           EQUATE(7A01H)  ! boolean
PROP:UpsideDown     EQUATE(7A02H)  ! boolean
PROP:HeaderHeight   EQUATE(7A03H)  ! integer: (Read-only) Height of the header on a list box
PROP:Checked        EQUATE(7A04H)  ! boolean: (Read-only) Is a check box set?
PROP:AutoPaper      EQUATE(7A05H)  ! boolean: Report engine automatically picks best paper size
PROP:Single         EQUATE(7A06H)  ! boolean: Single line text box (for Hebrew/Arabic support)
PROP:Parent         EQUATE(7A07H)  ! integer: Field equate of parent control
PROP:Repeat         EQUATE(7A08H)  ! integer: Repeat rate of IMM button
PROP:EventsWaiting  EQUATE(7A09H)  ! boolean: Does this window have any further events pending?
PROP:DDEmode        EQUATE(7A0AH)  ! integer: 0 = normal, 1 = events to top window of thread, other values reserved
PROP:Threading      EQUATE(7A0BH)  ! boolean: Set to 0 to disable all threading in APP (forces SDI behavior)
PROP:TempNameFunc   EQUATE(7A0CH)  ! integer: Set to address of a function(signed),STRING
PROP:Delay          EQUATE(7A0FH)  ! integer: Delay before IMM button repeats

PROP:BreakVar       EQUATE(7A10H)  ! variable: Used to set break variable for BREAK structure in report
PROP:Use            EQUATE(7A10H)  ! variable: PROP:Use or PROP:Use,1 sets use variable
PROP:FEQ            EQUATE(7A11H)  ! integer: PROP:Feq or PROP:Use,2 sets feq number
PROP:ListFEQ        EQUATE(7A12H)  ! integer: PROP:Listfeq or PROP:Use,3 sets feq of list part of combo/drop
PROP:ButtonFEQ      EQUATE(7A13H)  ! integer: PROP:Buttonfeq or PROP:Use,4 sets feq of button part of combo/drop
PROP:Flat           EQUATE(7A14H)  ! boolean: Explorer 3.0 style buttons

PROP:WallPaper      EQUATE(7A15H)  ! string: Background image of a window
PROP:Tiled          EQUATE(7A16H)  ! boolean: Should we tile background image?
PROP:Centered       EQUATE(7A17H)  ! boolean: Should we center background image?
PROP:TileImage      EQUATE(PROP:Tiled)    ! deprecated: For C4B1 compatibility only
PROP:CenterImage    EQUATE(PROP:Centered) ! deprecated: For C4B1 compatibility only

PROP:ChildIndex     EQUATE(7A18H)  ! integer: Reverse of PROPchild,nn
PROP:InToolBar      EQUATE(7A19H)  ! boolean: Is this control on the toolbar?
PROP:PrintMode      EQUATE(7A1AH)  ! integer: How do images print?
PROP:RejectCode     EQUATE(7A1BH)  ! integer: If/why entry control was invalid
PROP:VLBProc        EQUATE(7A1CH)  ! integer: "Virtual list box" proc address
PROP:VLBVal         EQUATE(7A1DH)  ! integer: "Virtual list box" proc user id
PROP:TempImage      EQUATE(7A1EH)  ! string: Dumps image into temp file, returns name (read only)

PROP:TempPath       EQUATE(7A20H)  ! array[string]
PROP:TempPagePath   EQUATE(7A20H)  ! string: Equivalent to {PROP:Temppath, 1}
PROP:TempImagePath  EQUATE(7A21H)  ! string: Equivalent to {PROP:Temppath, 2}

PROP:LibHook        EQUATE(7A30H)  ! array[integer] (system-only)
PROP:ColorDialogHook EQUATE(7A30H)  ! integer (system-only): Equivalent to {PROP:Libhook, 1}
PROP:FileDialogHook EQUATE(7A31H)   ! integer (system-only): Equivalent to {PROP:Libhook, 2}
PROP:FontDialogHook EQUATE(7A32H)   ! integer (system-only): Equivalent to {PROP:Libhook, 3}
PROP:PrinterDialogHook EQUATE(7A33H)  ! integer (system-only): Equivalent to {PROP:Libhook, 4}
PROP:HaltHook       EQUATE(7A34H)  ! integer (system-only): Equivalent to {PROP:Libhook, 5}
PROP:MessageHook    EQUATE(7A35H)  ! integer (system-only): Equivalent to {PROP:Libhook, 6}
PROP:StopHook       EQUATE(7A36H)  ! integer (system-only): Equivalent to {PROP:Libhook, 7}
PROP:AssertHook     EQUATE(7A37H)  ! integer (system-only): Equivalent to {PROP:Libhook, 8}
PROP:FatalErrorHook EQUATE(7A38H)  ! integer (system-only): Equivalent to {PROP:Libhook, 9}

PROP:CharSet        EQUATE(7A39H)  ! integer (system-only): default charset - SYSTEM property
PROP:FontCharSet    EQUATE(7A3AH)  ! integer: font charset - FONT subattribute

PROP:SystemPropHook EQUATE(7A3BH)  ! integer (system-only): Equivalent to {PROP:libhook, 12}
PROP:AssertHook2    EQUATE(7A3CH)  ! integer (system-only): Equivalent to {PROP:libhook, 13}
PROP:InitAStringHook EQUATE(7A3DH)  ! integer (system-only): Equivalent to {PROP:libhook, 14}


PROP:NoWidth        EQUATE(7A40H)  ! boolean: was a width specified?
PROP:NoHeight       EQUATE(7A41H)  ! boolean: was a height specified?
PROP:NextPageNo     EQUATE(7A42H)  ! integer: next page number in report
PROP:XOrigin        EQUATE(7A43H)  ! integer: how much is screen/image scrolled by?
PROP:YOrigin        EQUATE(7A44H)  ! integer: how much is screen/image scrolled by?
PROP:Target         EQUATE(7A45H)  ! integer: reference to current target window
PROP:Together       EQUATE(7A46H)  ! boolean: don't split this detail

PROP:Dock           EQUATE(7A47H)  ! integer: permitted dock sites
PROP:Docked         EQUATE(7A48H)  ! integer: current dock site
PROP:BrokenTabs     EQUATE(7A49H)  ! boolean: draw tabs broken?
PROP:ImageInstance  EQUATE(7A4AH)  ! integer (system-only): HINSTANCE of exe/dll for linked-in image files
PROP:GlobalHelp     EQUATE(7A4BH)  ! boolean (system-only): Help stays open when windows close
PROP:Buffer         EQUATE(7A4CH)  ! integer: Buffer window repaints (less flicker, but more memory)
PROP:clientx        EQUATE(7A4DH)  ! integer: position of client area
PROP:clienty        EQUATE(7A4EH)  ! integer: position of client area
PROP:clientwidth    EQUATE(7A4FH)  ! integer: size of client area
PROP:clientheight   EQUATE(7A50H)  ! integer: size of client area
PROP:UseAddress     EQUATE(7A52H)  ! integer: Address of ANY describing use variable.
PROP:FlushPageNumFunc EQUATE(7A54H)! integer: callback function returning number of the next page to flush

PROP:Status         EQUATE(7D00H)  ! array[integer]
PROP:StatusText     EQUATE(7D01H)  ! array[string]
PROP:DragID         EQUATE(7D02H)  ! array[string]
PROP:DropID         EQUATE(7D03H)  ! array[string]
PROP:VBXEventArg    EQUATE(7D04H)  ! array[string]
PROP:Edit           EQUATE(7D05H)  ! array[integer]
PROP:Alrt           EQUATE(7D06H)  ! array[integer]
PROP:IconList       EQUATE(7D07H)  ! array[integer]
PROP:Line           EQUATE(7D08H)  ! array[string], TEXT control line contents (read-only, runtime only)
PROP:Tally          EQUATE(7D09H)  ! array[integer], tally attribute on report string control
PROP:Child          EQUATE(7D0AH)  ! array[integer], iterate through immediate children
PROP:NextField      EQUATE(7D0BH)  ! array[integer], iterate through all children of a window
                                   ! NB order is NOT defined.
PROP:SnapWidth      EQUATE(7D0CH)  ! array[integer]
PROP:SnapHeight     EQUATE(7D0DH)  ! array[integer]

PROPSTYLE:First     EQUATE(7D10H)
PROPSTYLE:FontName  EQUATE(7D10H)  ! array[string]
PROPSTYLE:FontSize  EQUATE(7D11H)  ! array[integer]
PROPSTYLE:FontColor EQUATE(7D12H)  ! array[integer]
PROPSTYLE:FontStyle EQUATE(7D13H)  ! array[integer]
PROPSTYLE:TextColor    EQUATE (7D14H) ! array[integer] (same as fontcolor)
PROPSTYLE:BackColor    EQUATE (7D15H) ! array[integer]
PROPSTYLE:TextSelected EQUATE (7D16H) ! array[integer]
PROPSTYLE:BackSelected EQUATE (7D17H) ! array[integer]
PROPSTYLE:Picture   EQUATE(7D18H)  ! array[string]
PROPSTYLE:CharSet   EQUATE(7D19H)  ! array[integer]
PROPSTYLE:Last      EQUATE(7D3FH)

PROPLIST:Underline      EQUATE (7E00H) ! boolean
PROPLIST:Resize         EQUATE (7E01H) ! boolean
PROPLIST:RightBorder    EQUATE (7E02H) ! boolean
PROPLIST:Header         EQUATE (7E03H) ! string
PROPLIST:width          EQUATE (7E04H) ! integer
PROPLIST:Picture        EQUATE (7E05H) ! string
PROPLIST:Fixed          EQUATE (7E06H) ! boolean
PROPLIST:Scroll         EQUATE (7E07H) ! integer
PROPLIST:LastOnLine     EQUATE (7E08H) ! boolean
PROPLIST:Locator        EQUATE (7E09H) ! integer
PROPLIST:Exists         EQUATE (7E0AH) ! boolean
PROPLIST:Resvd2         EQUATE (7E0BH)
PROPLIST:Resvd3         EQUATE (7E0CH)
PROPLIST:GroupNo        EQUATE (7E0DH) ! integer
PROPLIST:FieldNo        EQUATE (7E0EH) ! integer
PROPLIST:Format         EQUATE (7E0FH) ! string

PROPLIST:Left           EQUATE (7E10H) ! boolean
PROPLIST:LeftOffset     EQUATE (7E11H) ! integer
PROPLIST:Right          EQUATE (7E12H) ! boolean
PROPLIST:RightOffset    EQUATE (7E13H) ! integer
PROPLIST:Center         EQUATE (7E14H) ! boolean
PROPLIST:CenterOffset   EQUATE (7E15H) ! integer
PROPLIST:Decimal        EQUATE (7E16H) ! boolean
PROPLIST:DecimalOffset  EQUATE (7E17H) ! integer

PROPLIST:HeaderLeft           EQUATE (7E18H) ! boolean
PROPLIST:HeaderLeftOffset     EQUATE (7E19H) ! integer
PROPLIST:HeaderRight          EQUATE (7E1AH) ! boolean
PROPLIST:HeaderRightOffset    EQUATE (7E1BH) ! integer
PROPLIST:HeaderCenter         EQUATE (7E1CH) ! boolean
PROPLIST:HeaderCenterOffset   EQUATE (7E1DH) ! integer
PROPLIST:HeaderDecimal        EQUATE (7E1EH) ! boolean
PROPLIST:HeaderDecimalOffset  EQUATE (7E1FH) ! integer

PROPLIST:Icon           EQUATE (7E20H) ! boolean Corresponds to 'I' in the format string
PROPLIST:Color          EQUATE (7E21H) ! integer
PROPLIST:Tree           EQUATE (7E22H) ! boolean
PROPLIST:TreeLines      EQUATE (7E23H) ! boolean
PROPLIST:TreeBoxes      EQUATE (7E24H) ! boolean
PROPLIST:TreeIndent     EQUATE (7E25H) ! boolean
PROPLIST:TreeOffset     EQUATE (7E26H) ! boolean
PROPLIST:TreeRoot       EQUATE (7E27H) ! boolean
PROPLIST:DefColors      EQUATE (7E28H) ! array[integer]: up to four components (see below)
PROPLIST:TextColor      EQUATE (7E28H) ! integer: Column text color
PROPLIST:BackColor      EQUATE (7E29H) ! integer: Column background color
PROPLIST:TextSelected   EQUATE (7E2AH) ! integer: Column text color when highlighted
PROPLIST:BackSelected   EQUATE (7E2BH) ! integer: Column background color when highlighted
PROPLIST:CellStyle      EQUATE (7E2CH) ! boolean: Per-cell style attribute
PROPLIST:ColStyle       EQUATE (7E2DH) ! boolean: Per-column style value
PROPLIST:IconTrn        EQUATE (7E2EH) ! boolean: Transparent Icon Corresponds to 'J' in the format string (mutually exclusive with PROPLIST:Icon)


PROPLIST:Group          EQUATE (0040H)  ! add to PROPLIST property above
PROPLIST:Style          EQUATE (0080H)  ! add to PROPLIST property above

PROPLIST:MouseDownRow   EQUATE (7C20H) ! integer
PROPLIST:MouseMoveRow   EQUATE (7C21H) ! integer
PROPLIST:MouseUpRow     EQUATE (7C22H) ! integer
PROPLIST:MouseDownField EQUATE (7C23H) ! integer
PROPLIST:MouseMoveField EQUATE (7C24H) ! integer
PROPLIST:MouseUpField   EQUATE (7C25H) ! integer
PROPLIST:MouseDownZone  EQUATE (7C26H) ! integer
PROPLIST:MouseMoveZone  EQUATE (7C27H) ! integer
PROPLIST:MouseUpZone    EQUATE (7C28H) ! integer
PROPLIST:Grid           EQUATE (7C29H) ! boolean
PROPLIST:BarColor       EQUATE (7C29H) ! deprecated: integer for compatibility with 1.5 apps

! End of control/window/system properties

! File Properties

PROP:CurrentKey         EQUATE (7300H)  ! Get current sequential or build key
PROP:Logout             EQUATE (7301H)  ! Get/Set files logout status
PROP:Log                EQUATE (7302H)  ! Add a line to the file profile
PROP:Profile            EQUATE (7303H)  ! Set file profiling
PROP:Details            EQUATE (7329H)  ! Set tracing of record buffer
PROP:Watched            EQUATE (7304H)  ! Get record watch status
PROP:Held               EQUATE (7305H)  ! Get record hold status
PROP:ProgressEvents     EQUATE (7306H)  ! Set amount of events for BUILD
PROP:Completed          EQUATE (7307H)  ! Get BUILD completed status
PROP:Driver             EQUATE (730DH)  ! Get name of file driver
PROP:DriverLogsoutAlias EQUATE (730EH)  ! Get the capacity of LOGOUT
PROP:Keys               EQUATE (730FH)  ! Get number of keys in file
PROP:Blobs              EQUATE (7310H)  ! Get number of blobs in file
PROP:Memos              EQUATE (7311H)  ! Get number of memos in file
PROP:Fields             EQUATE (7312H)  ! Get number of fields in file (group)
PROP:Encrypt            EQUATE (7313H)  ! Get encrypt status
PROP:DriverString       EQUATE (7314H)  ! Get driver string
PROP:Owner              EQUATE (7315H)  ! Get Owner
PROP:Name               EQUATE (7316H)  ! Get file/key/memo/blob/field's name
PROP:Label              EQUATE (7317H)  ! Get file/key/memo/blob/field's label
PROP:OEM                EQUATE (7318H)  ! Get OEM attribute
PROP:Reclaim            EQUATE (7319H)  ! Get Reclaim attribute
PROP:SQLDriver          EQUATE (7344H)  ! '1' = Driver is SQL aware
PROP:FileSize           EQUATE (7347H)  ! Get the size of the file
PROP:SupportsOp         EQUATE (7348H)  ! Get which functions are supported
PROP:SupportsType       EQUATE (7349H)  ! Get which data types are supported
PROP:Record             EQUATE (734Bh)  ! Get the file's record buffer

! Key Properies
PROP:Components         EQUATE (731AH)  ! Get number of key components
PROP:Dup                EQUATE (731BH)  ! Get DUP attribute
PROP:Opt                EQUATE (731CH)  ! Get OPT attribute
PROP:NoCase             EQUATE (731DH)  ! Get NOCASE attribute
PROP:Primary            EQUATE (731EH)  ! Get PRIMARY attribute

! Key Component Properies
PROP:Field              EQUATE (731FH)  ! Get Field number of key component n
PROP:Ascending          EQUATE (7320H)  ! Get order of key component n

! Memo Properties
PROP:Binary             EQUATE (7321H)  ! Get BINARY attribute of memo -n or blob

! Field Properties
PROP:Places             EQUATE (7322H)  ! Get Number of decimal places for field n
PROP:Dim                EQUATE (7323H)  ! Get Number of dimensions
PROP:Over               EQUATE (7324H)  ! Get the field number of the field
                                        ! this field is over
! View Properties
PROP:Order              EQUATE (7CE6H)  ! Set the order of a VIEW
PROP:Filter             EQUATE (7CB8H)  ! Set the filter of a VIEW
PROP:JoinExpression     EQUATE (7212H)  ! Set the join expression
PROP:Files              EQUATE (7325H)  ! Get number of files in view
PROP:File               EQUATE (7326H)  ! Get reference to n'th File
PROP:ProfileIntoFiles   EQUATE (7327H)  ! Set profiling of file calls from view engine
PROP:Inner              EQUATE (7328H)  ! Get/Set inner attribute of n'th join
!PROP:Field             EQUATE (731FH)  ! Get Field number of n'th field.  -ve for memos
PROP:FieldsFile         EQUATE (734AH)  ! Get reference to the File that the n'th field is in

! SQL Drivers Properties
PROP:SQL                EQUATE (7200H)
PROP:OrderAllTables     EQUATE (7211H)
PROP:SQLFilter          EQUATE (7221H)
PROP:LogFile            EQUATE (7222H)
PROP:Where              EQUATE (7223H)
PROP:FetchSize          EQUATE (7341H)
PROP:Alias              EQUATE (7244H)
PROP:Disconnect         EQUATE (7245H)
PROP:SQLOrder           EQUATE (7248H)
PROP:SQLJoinExpression  EQUATE (7249H)

! Oracle and MS SQL Driver Properties
PROP:Hint               EQUATE (7241H)

! Btrieve, AS/400, MS SQL, ODBC, SQLAnyWhere and Pervasive.SQL Driver Properties
PROP:AppendBuffer       EQUATE (7342H)

! ODBC Driver Properties
PROP:ConnectString      EQUATE (7201H)
PROP:LoginTimeOut       EQUATE (7202H)
PROP:HENV               EQUATE (7203H)
PROP:HDBC               EQUATE (7204H)
PROP:HSTMT              EQUATE (7205H)
PROP:OrderInSelect      EQUATE (7206H)
PROP:QuoteString        EQUATE (7243H)
PROP:LogonScreen        EQUATE (7246H)
PROP:AlwaysRebind       EQUATE (7247H)

! AS/400, MS SQL, ODBC, SQLAnyWhere and Pervasive.SQL Driver Properties
PROP:DBMSver            EQUATE (724AH)
PROP:IsolationLevel     EQUATE (724BH)
PROP:MaxStatements      EQUATE (724CH)
PROP:StmtAttr           EQUATE (724DH)
PROP:LogoutIsolationLevel EQUATE(724EH)

! TopSpeed Driver Properties
PROP:FullBuild          EQUATE (7230H)

! Btrieve Driver Properties
PROP:PositionBlock      EQUATE (7343H)
PROP:PageLevelLocking   EQUATE (734DH)  !Get/Set the locking type used by LOGOUT. '' = Lock entire file, '1' = Lock pages
