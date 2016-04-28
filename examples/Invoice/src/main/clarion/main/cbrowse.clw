    member()
    map
      module('')
StrTok      procedure(long, long), cstring, raw, name('_strtok')
      end
    end

    include('cbrowse.inc'), once
    include('keycodes.clw'), once


cBrowse.Construct           procedure

    code
    SELF.ColQ &= new(TColumnQ)
    SELF.UpdateQ &= new(TUpdateQ)
    self.FieldPair &= new(cFieldPair)
    self.Filter &= null
?   assert(~self.FieldPair &= null)
    SELF.szResetAlltext = 'Reset all Columns to visible'
?   assert(~SELF.ColQ &= null)
?   assert(~SELF.UpdateQ &= null)
    self.Popup &= new(Popupclass)
    if ~(self.Popup &= null)
      self.Popup.Init()
    end


cBrowse.Destruct            procedure

ndx     long

    code
    loop ndx = 1 to records(SELF.ColQ)
      get(self.ColQ, ndx)
      if ~errorcode()
        if ~(self.ColQ.ColName_SQL)
          dispose(self.ColQ.ColName_SQL)
          self.ColQ.ColName_SQL &= null
        end
      end
    end
?   assert(~SELF.ColQ &= null)
    if ~(SELF.ColQ &= null)
      free(SELF.ColQ)
      dispose(SELF.ColQ)
    end
?   assert(~SELF.UpdateQ &= null)
    if ~(SELF.UpdateQ &= null)
      free(SELF.UpdateQ)
      dispose(SELF.UpdateQ)
    end

    if ~(self.popup &= null)
      self.Popup.Kill()
      dispose(self.Popup)
    end

cBrowse.ApplyColOrder       procedure(string pColOrder)

TokenQ      queue
Token         string(25)
            end

TmpStr      &string
NoFound     byte
ndx         long

Pos         long

TempColQ    &TColumnQ

retValue    long

    code

    if pColOrder

      TmpStr &= new(string(len(pColOrder)))
      TmpStr = pColOrder
      loop
        pos = instring(',', TmpStr[1 : len(clip(TmpStr))], 1, 1)
        if Pos
          TokenQ.Token = TmpStr[1 : Pos - 1]
          if TokenQ.Token
            add(TokenQ)
            if Pos = len(clip(TmpStr))
              break
            else
              TmpStr = TmpStr[Pos + 1 : len(clip(TmpStr))]
            end
          else
            break
          end
        else
          break
        end
      end

      ! After the pColOrder string has been parsed to ColName, check if the name or the number of column correspond to the listbox
      if records(TokenQ) <> records(self.ColQ)
        RetValue = false
      else
        ! Check to see if ColName corresponds to those in ColQ
        NoFound = false
        loop ndx = 1 to records(TokenQ)
          get(TokenQ, ndx)
          self.ColQ.ColName = TokenQ.Token
          get(self.ColQ, self.ColQ.ColName)
          if errorcode()   ! ColName is not found, maybe list layout modified by the programmer since last use of the application
            NoFound = true
            break
          end
        end
        if NoFound
          RetValue = false
        else

          if records(TOkenQ)
            RetValue = true
            ! Create a copy of the internal queue in the right order.
            ! The Col order is contained in TokenQ. So we loop to each or TokenQ record, grap the corresponding record
            ! in ColQ, copy the record in TmpQueue. At the end of that process, TmpQueue will be in the right order. Rebuild of ColQ
            ! will simply matter of free(ColQ) and loop through each TmpQueue record and copy back in ColQ.
            TempColQ &= new(TColumnQ)
            loop ndx = 1 to records(TokenQ)
              get(TokenQ, ndx)
              self.ColQ.ColName = TokenQ.Token
              get(self.ColQ, self.ColQ.ColName)
              if ~errorcode()
                TempColQ :=: self.ColQ
                add(TempColQ)
              else
                RetValue = false
              end
            end
            if records(TempColQ)
              free(self.ColQ)
              loop ndx = 1 to records(TempColQ)
                get(TempColQ, ndx)
                if ~errorcode()
                  self.ColQ :=: TempColQ
                  add(self.ColQ)
                  if errorcode()
                    RetValue = false
                  end
                else
                  RetValue = false
                end
              end
              ! At this point, ColQ is rebuild in the right order, we can generate the Format string of the listbox
              self.ReformatList()
            end
            free(TempColQ)    ! Free tempColQ records
            dispose(TempColQ) ! release reference
          end
        end
      end
      dispose(TmpStr) ! Release string copy of pColOrder
    end
    return(RetValue)



cbrowse.ApplyHide           procedure(string pHideStr)

TokenQ      queue
Token         string(25)
            end

TmpStr      &string
NoFound     byte
ndx         long

Pos         long

TempColQ    &TColumnQ

RetValue    long


    code
    if pHideStr
      TmpStr &= new(string(len(pHideStr)))
      TmpStr = pHideStr
      loop
        pos = instring(',', TmpStr[1 : len(clip(TmpStr))], 1, 1)
        if Pos
          TokenQ.Token = TmpStr[1 : Pos - 1]
          if TokenQ.Token
            add(TokenQ)
            if Pos = len(clip(TmpStr))
              break
            else
              TmpStr = TmpStr[Pos + 1 : len(clip(TmpStr))]
            end
          else
            break
          end
        else
          break
        end
      end

      loop ndx = 1 to records(TokenQ)
        get(TokenQ, ndx)
        self.ColQ.ColName = TokenQ.Token
        get(self.ColQ, self.ColQ.ColName)
        if ~errorcode()
          self.ListCtrl{proplist:Width, SELF.ColQ.ColNbr} = 0      !choose(SELF.ColQ.Visible = true, 0, SELF.ColQ.Width)
          self.ColQ.Visible = false
          put(SELF.ColQ)
        end
      end
    end
    return(RetValue)



cBrowse.ApplySort           procedure(string pSort)

NewTitle    string(128)
WidthNeeded long
ndx         long
FirstPart   long

TokenQ      queue
Token         string(20)
            end

szSortStr   &cstring

szDelim     cstring(',')
szToken     cstring(10)
Pos         long
Direction   string(1)

TempColQ    &TColumnQ
NoFound     byte
RetValue    long

    code

    RetValue = true

    szSortStr &= new(cstring(len(clip(pSort)) + 1))
?   assert(~(szSortStr &= null))
    szSortStr = pSort

    ! Second, extract each of the Sort token
    szToken = StrTok(address(szSortStr), address(szDelim))
    loop while szToken <> ''
      TokenQ.Token = szToken
      add(TokenQ)
      szToken = StrTok(0, address(szDelim))
    end

    if szSortStr &= null
      dispose(szSortStr)
    end

    if records(TokenQ)
      loop ndx = 1 to records(TokenQ)
        get(TokenQ, ndx)
        Pos = instring('+', TokenQ.Token, 1, 1)
        if ~Pos
          Pos = instring('-', TokenQ.Token, 1, 1)
          if ~Pos
            ! No direction defined (should not happen but we will default to ascending)
            Direction = '+'
          else
            Direction = '-'
          end
        else
          Direction = '+'
        end
        ! Now grab the col nbr
        if ~pos
          self.ColQ.ColNbr = TokenQ.Token
        else
          self.ColQ.ColNbr = TokenQ.Token[1 : Pos - 1]
        end
        get(self.ColQ, self.ColQ.ColNbr)
        if ~errorcode()
          self.ColQ.SortOrder = ndx
          self.ColQ.SortDirection = Direction
          Self.ColQ.SortHeader = '(' & SELF.ColQ.SortOrder & ',' & SELF.ColQ.SortDirection & ')'
          NewTitle = clip(SELF.ColQ.ColName) & ' ' & clip(SELF.ColQ.SortHeader)
          WidthNeeded = SELF.CheckWidth(NewTitle)
          if WidthNeeded > SELF.ListCtrl{proplist:Width, SELF.ColQ.ColNbr}
            SELF.ListCtrl{proplist:Width, SELF.ColQ.ColNbr} = WidthNeeded
            SELF.ColQ.Width = WidthNeeded
          end
          SELF.ListCtrl{proplist:header, SELF.ColQ.ColNbr} = clip(SELF.ColQ.ColName) & ' ' & clip(SELF.ColQ.SortHeader)
          SELF.ColQ.ColListFormat = SELF.ListCtrl{proplist:Format, SELF.ColQ.ColNbr}
          put(self.ColQ)
        else
          ! Sort position refer to a non existing col, set RetValue to false and break
          RetValue = false
          break
        end
      end
    end

    free(TokenQ)

    self.GenerateOrderBy()

    return(RetValue)


cBrowse.CheckWidth          procedure(string pText)

StrCtl      long
Width       long

    code
    ! Create a static string control using the same font used in the listbox and apply the text to it and check the width of that string control
    ! 10 is added to that width in order to have enough clearance
    StrCtl = create(0, CREATE:STRING)
    StrCtl{prop:FontSize} = SELF.ListCtrl{PROP:FontSize}
    StrCtl{PROP:FontStyle} = SELF.ListCtrl{PROP:FontStyle}
    StrCtl{prop:text} = clip(pText)
    Width = StrCtl{prop:Width} + 10
    destroy(StrCtl)
    return Width


cBrowse.EIPAlertKey             procedure()

RetValue    byte

    code
    RetValue = 0
    if keycode() = Tabkey
      update(field())
    end
    if keycode() = SELF.EIPCompletionKey
      update(field())
      if SELF.OnEIPModeEnd().
    end
    if keycode() = SELF.EIPAbortKey
      if SELF.OnEIPModeEnd().
      RetValue = 5
    end
    return(RetValue)



cBrowse.EIPAccepted         procedure()

ndx     long

    code
    if SELF.EIPMode and field() <> SELF.ListCtrl
      ! Check if the field accepted is one of the "eip control"
      self.ColQ.EIPFeq = field()
      get(self.ColQ, self.ColQ.EIPFeq)
      if errorcode() ! Control not found, user clicked somewhere else on ther window
        if ~self.FieldPair.Equal()
          if message('Want save change(s)?','',,BUTTON:Yes + button:no) = button:Yes
            if SELF.DB.UpdateRow(SELF.UpdateQ)
              SELF.FieldPair.AssignRightToLeft()
              self.SetQueueRecord()
              put(SELF.DataQueue)
            else
              ! add error support here!
            end
          end
        end
        if self.OnEIPModeEnd().
      else
      end
    end
    return(0)


cbrowse.GenerateorderBy     procedure

ndx     long

    code
    self.SortQueueStr = ''
    self.szSortStr = ''
    SELF.szOrderByStr = 'ORDER BY'
    ndx = 1
    loop
      SELF.ColQ.SortOrder = ndx
      get(SELF.ColQ, SELF.ColQ.SortOrder)
      if ~errorcode()
        SELF.szOrderByStr = clip(SELF.szOrderByStr) & ' ' &|
                            clip(SELF.ColQ.ColName_SQL) & ' ' &|
                            choose(SELF.ColQ.SortDirection = '+', '', 'DESC') & ','
        self.SortQueueStr = clip(self.SortQueueStr) &|
                            SELF.ColQ.SortDirection &|
                            who(self.DataQueue, Self.ColQ.PosInQueue) &|
                            ','
        self.szSortStr = clip(self.szSortStr) & ' ' &|
                         clip(SELF.ColQ.ColName_SQL) & ' ' &|
                         choose(SELF.ColQ.SortDirection = '+', '', 'DESC') & ','

      else
        if self.szOrderByStr <> 'ORDER BY'
          SELF.szOrderByStr[len(Clip(SELF.szOrderByStr))] = ''  ! Remove the last comma
        end
        if self.SortQueueStr
          SELF.SortQueueStr[len(Clip(SELF.SortQueueStr))] = ''  ! Remove the last comma in the SortQueueStr
        end
        if self.szSortStr
          self.szSortStr[len(Clip(SELF.szSortStr))] = ''
        end
        break
      end
      ndx += 1
    end


cBrowse.GenPopupStr         procedure

ndx     long

    code
    ndx = 1
    SELF.szColsPopup = ''
    loop ndx = 1 to records(SELF.ColQ)
      get(SELF.ColQ, ndx)
      SELF.szColsPopup = clip(SELF.szColsPopup) & choose(SELF.ColQ.AlwaysVisible = true, '~','') &|
                         choose(SELF.ColQ.Visible = true, '+', '') & clip(SELF.ColQ.ColName) & '|'
    end
    if SELF.szResetAlltext
      SELF.szColsPopup = clip(SELF.szColsPopup) & '-|' & SELF.szResetAlltext
    end

cBrowse.GetColOrderSettings procedure(*string pColOrderStr)

ndx     long

    code

    pColOrderStr = ''
    ndx = 1
    loop ndx = 1 to records(self.ColQ)
      get(self.ColQ, ndx)
      pColOrderStr = clip(pColOrderStr) & clip(self.ColQ.ColName) & ','
    end

cBrowse.GetHideSettings     procedure(*string pHideStr)

ndx     long

    code
    pHideStr = ''
    ndx = 1
    loop ndx = 1 to records(self.ColQ)
      get(self.ColQ, ndx)
      if ~self.ColQ.Visible
        pHideStr = clip(pHideStr) & clip(self.ColQ.ColName) & ','
      end
    end



cBrowse.GetPage             procedure

    code
    loop self.ListCtrl{prop:Items} times
      if ~self.DB.Next()                                                                      ! No more rows?
        break                                                                                 ! then break
      else
        SELF.FieldPair.AssignRightToLeft()
        self.SetQueueRecord()
        add(SELF.DataQueue)                                                                   ! and add to the queue
      end
    end

cBrowse.GetSortSettings     procedure(*string pSortStr)

ndx         long
RetValue    byte

    code
    pSortStr = ''
    ndx = 1
    loop
      self.ColQ.SortOrder = ndx
      get(self.ColQ, self.ColQ.Sortorder)
      if ~errorcode()
        pSortStr = clip(pSortStr) & self.ColQ.ColNbr & self.ColQ.SortDirection & ','
        ndx += 1
      else
        break
      end
    end

cBrowse.init                procedure(long pListCtl, queue pDataQueue, window pW)

    code
    ! Give some defaults values
    SELF.MainSortStyle = 0
    SELF.EIPCompletionKey = EnterKey
    SELF.EIPAbortKey = ESCKey
    SELF.ListCtrl = pListCtl
    SELF.DataQueue &= pDataQueue
    SELF.W &= pW
    SELF.Filter &= null
    self.ListCtrl{prop:dragid, 255} = 'cBrowse'
    self.ListCtrl{prop:dropid, 255} = 'cBrowse'
    self.SetAlertKeys()
    SELF.InitColQ()
    SELF.RegisterEvents()


cBrowse.InitColQ            procedure

ndx         long
QField      any

    code
    ndx = 1
    loop
      clear(SELF.ColQ)
      if SELF.ListCtrl{proplist:exists, ndx}
        SELF.ColQ.ColNbr = ndx
        SELF.ColQ.ColName = SELF.ListCtrl{proplist:Header, ndx}
        SELF.ColQ.Width = SELF.ListCtrl{proplist:width, ndx}
        SELF.ColQ.OriginalWidth = SELF.ListCtrl{proplist:width, ndx}
        SELF.ColQ.PosInQueue = SELF.ListCtrl{proplist:FieldNo, ndx}
        SELF.ListCtrl{proplist:FieldNo, ndx} = SELF.ColQ.PosInQueue         ! Force the queue field no to appear in the format string
        SELF.ColQ.ColName_SQL = who(SELF.DataQueue, SELF.ColQ.PosInQueue)

        ! Try to find out what is the datatype of the column.
        ! The datatype must be known in order to have the code put quotes around value in the SQL statement when it is needed
        QField &= what(SELF.DataQueue, SELF.ColQ.PosInQueue)
        if isstring(QField)                             ! Check if it is a string
          SELF.ColQ.ColDatatype = datatype:string       ! yes, set it to string
        else
          ! Col is not a string, look at the col picture in the list and see if there is '@d' in it, if so, it's a date
          if instring('@d', SELF.ListCtrl{proplist:picture, ndx}, 1, 1)  !
            SELF.ColQ.ColDataType = datatype:date
          else
            if instring('@t', SELF.ListCtrl{proplist:picture, ndx}, 1, 1)
              SELF.ColQ.ColDataType = datatype:time
            else
            ! type is numeric, we use long for all. That will tell us to not generate quotes around values
              SELF.ColQ.ColDataType = datatype:long
            end
          end
        end

        SELF.ColQ.ColListFormat = SELF.ListCtrl{proplist:format, ndx}
        SELF.ColQ.Visible = true
        self.ColQ.CanBeMoved = true
        self.ColQ.CanBeSorted = true
        self.ColQ.ColName_SQL &= null
        add(SELF.ColQ, SELF.ColQ.ColNbr)
        ndx += 1
      else
        break
      end
    end

cBrowse.SetSQLColQ              procedure(long pColNbr, string pSQLColName)

    code

    self.ColQ.ColNbr = pColNbr
    get(self.ColQ, self.ColQ.ColNbr)
    if ~errorcode()
      self.ColQ.ColName_SQL &= new(string(len(pSQLColName) + 1))
      if ~(self.ColQ.ColName_SQL &= null)
        self.ColQ.ColName_SQL = pSQLColName
        put(self.ColQ)
      end
    end


CBrowse.InitListStyle           procedure()

    code


cBrowse.InitLocator         procedure(*string pLOcatorVar)

    code
    self.LocatorVar &= pLocatorVar


cBrowse.LoadSettings        procedure()

    code


cBrowse.SaveSettings        procedure()

    code

cBrowse.SetIFilter          procedure(IFilter pIFilter)

    code
    SELF.Filter &= pIFilter

cBrowse.SetDb               procedure(ADO_SQL pIDB)

    code
    SELF.DB &= pIDB

cBrowse.InitCopyQ           procedure(*queue pQueue)

    code
    self.CopyQ &= pQueue


cBrowse.RegisterEvents      procedure

    code

    register(EVENT:Drop, address(SELF.OnDrop), address(SELF),,SELF.ListCtrl)
    register(EVENT:Drag, address(SELF.OnDrag), address(SELF), SELF.W)
    register(EVENT:AlertKey, address(SELF.OnAlertKey), address(SELF),,SELF.ListCtrl)
    register(EVENT:PreAlertKey, address(SELF.OnPreAlertKey), address(SELF),,SELF.ListCtrl)
    register(EVENT:ScrollUp, address(self.OnScrollUpDown), address(self),, self.ListCtrl)
    register(EVENT:ScrollDown, address(self.OnScrollUpDown), address(self),, self.ListCtrl)
    register(EVENT:ScrollTop, address(self.OnScrollUpDown), address(self),, self.ListCtrl)
    register(EVENT:ScrollBottom, address(self.OnScrollUpDown), address(self),, self.ListCtrl)
    register(EVENT:SCrollDrag, address(self.OnScrollUpDown), address(self),, self.ListCtrl)
    register(EVENT:PageDown, address(self.OnScrollUpDown), address(self),, self.ListCtrl)
    register(EVENT:PageUp, address(self.OnScrollUpDown), address(self),, self.ListCtrl)
    register(EVENT:ColumnResize, address(self.OnColResize), address(self),, self.ListCtrl)


cBrowse.ReformatList        procedure

! because the ColQ structure contains the Format string for each column of the list
! reformat the list is simply matter of looping and concatening each individual format string into one string

ndx         long
FormatStr   &string
StrLen      long

    code

    ! First,check the len of the string needed to hold the complete format

    StrLen = 0
    loop ndx = 1 to records(SELF.ColQ)
      get(self.ColQ, ndx)
      StrLen += len(clip(SELF.ColQ.ColListFormat))
    end

    ! Create the string
    FormatStr &= new(string(StrLen + 1))

    if ~(FormatStr &= null)                                           ! String allocated ok?

      loop ndx = 1 to records(SELF.ColQ)                              ! Loop through all records in ColQ
        get(SELF.ColQ, ndx)                                           ! get the ColQ record
        SELF.ColQ.ColNbr = ndx                                        ! Set the ColNbr position
        FormatStr = clip(FormatStr) & clip(SELF.ColQ.ColListFormat)   ! Build the format string
        put(SELF.ColQ)                                                ! Update the ColQ record
      end

      SELF.ListCtrl{prop:Format} = clip(FormatStr)                    ! Apply the format string to the list

      dispose(FormatStr)                                              ! dispose the string

    end



cBrowse.ResetAllVisible     procedure

ndx         long

    code

    loop ndx = 1 to records(SELF.ColQ)
      get(SELF.ColQ, ndx)
      if SELF.ColQ.Visible = false
        SELF.ColQ.Visible = true
        SELF.ListCtrl{proplist:width, SELF.ColQ.ColNbr} = SELF.ColQ.Width
        put(SELF.ColQ)
      end
    end

cBrowse.RestoreOrigHdr      procedure

ndx         long

    code

    loop ndx = 1 to records(SELF.ColQ)
      get(SELF.ColQ, ndx)
      SELF.ListCtrl{proplist:Header, ndx} = clip(SELF.ColQ.ColName)
      SELF.ColQ.SortOrder = 0
      SELF.ColQ.Sortheader = ''
      self.ColQ.SortDirection = ''
      SELF.ListCtrl{proplist:ColStyle, ndx} = 0    ! Clear the sort color
      SELF.ListCtrl{proplist:width, SELF.ColQ.ColNbr} = SELF.ColQ.OriginalWidth
      SELF.ColQ.ColListFormat = SELF.ListCtrl{proplist:Format, ndx}
      put(SELF.ColQ)
    end



cBrowse.InitMarkRef         procedure(*byte pMark)

    code
    self.TaggingMark &= pMark

cBrowse.UpdateColFormat     procedure(long pColNbr)

    code
    SELF.ColQ.ColNbr = pColNbr
    get(SELF.ColQ, SELF.ColQ.ColNbr)
    if ~errorcode()
      SELF.ColQ.ColListFormat = SELF.ListCtrl{proplist:format, pColNbr}
      put(SELF.ColQ)
    end


cBrowse.SetEIPInfo          procedure(long pColNbr, long pControltype, *? pControlUse)

retValue           long

    code
    retValue = 0
    SELF.ColQ.ColNbr = pColNbr
    get(SELF.ColQ, SELF.ColQ.ColNbr)
    if ~errorcode()
      SELF.ColQ.EIPFeq = create(0, pControltype)
      if SELF.ColQ.EIPFeq
        RetValue = SELF.ColQ.EIPFeq
        SELF.ColQ.EIPEnable = true
        SELF.ColQ.EIPFeq{prop:use} = pControlUse
        !SELF.ColQ.EIPFeq{prop:alrt,1} = TabKey
        !SELF.ColQ.EIPFeq{PROP:Alrt,2} = ShiftTab
        SELF.ColQ.EIPFeq{PROP:Alrt,255} = SELF.EIPCompletionKey
        SELF.ColQ.EIPFeq{PROP:Alrt,255} = SELF.EIPAbortKey
        !SELF.ColQ.EIPFeq{PROP:Alrt,5} = DownKey
        !SELF.ColQ.EIPFeq{PROP:Alrt,6} = UpKey
        register(EVENT:AlertKey, address(SELF.EIPAlertKey), address(SELF),, SELF.ColQ.EIPFeq)
        register(EVENT:Accepted, address(SELF.EIPAccepted), address(SELF))
        clear(SELF.UpdateQ)
        SELF.UpdateQ.ColValue &= null
        SELF.UpdateQ.ColName_SQL = SELF.ColQ.ColName_SQL
        SELF.UpdateQ.ColValue &= pControluse
        add(SELF.UpdateQ)
        put(SELF.ColQ)
      end
    end
    return(RetValue)


cbrowse.OnDrop              procedure

TmpCol          like(TColumnGrp)
TargetCol       long

    code

    ! Columns moving processing
    if field() = SELF.ListCtrl
      SELF.ColQ.ColNbr = SELF.ListCtrl{proplist:MouseDownField}
      get(SELF.ColQ, SELF.ColQ.ColNbr)                              ! Get the col selected by the user
      TmpCol :=: SELF.ColQ                                          ! Save information
      delete(SELF.ColQ)                                             ! Detete it from the queue
      TargetCol = SELF.ListCtrl{proplist:MouseupField}              ! Get the column where user dropped
      SELF.ColQ :=: TmpCol                                          ! Reassign the ColQ structure
      if TargetCol <= records(SELF.ColQ)
        add(SELF.ColQ, TargetCol)                                   ! Add it to the postion corresponding to the drop
      else
        add(SELF.ColQ)
      end
      assert(~errorcode())                                          ! Just in case
      SELF.ReformatList()                                           ! Reformat the list
    end
    return(0)

cBrowse.OnDrag              procedure

QueueField      any

    code
    if field() = SELF.ListCtrl
      get(SELF.DataQueue, choice(SELF.ListCtrl))
      SELF.ColQ.Colnbr = SELF.ListCtrl{proplist:MouseDownField}
      get(SELF.ColQ, SELF.ColQ.ColNbr)
      if ~errorcode()
        QueueField &= what(SELF.DataQueue, SELF.ColQ.PosInQueue)
        if SELF.ColQ.ColDataType = DataType:Date 
          setdropid(clip(self.ColQ.ColName) & ';' & format(QueueField, @d17))
        else
          if SELF.ColQ.ColDataType = DataType:Time
            setdropid(clip(self.ColQ.ColName) & ';' & format(QueueField, @t4))
          else
            setdropid(clip(self.ColQ.ColName) & ';' & clip(QueueField))
          end
        end
      end
    end
    return(0)

cBrowse.OnScrollUpDown       procedure

vscrollpos  long
PageCount   long
ComputedPge long
RowCount    long
ComputedPos long

    code
    if event() = EVENT:ScrollDrag
      if not self.TableLoad
        free(self.DataQueue)
        vscrollpos = self.ListCtrl{PROP:VScrollPos}
        RowCount = self.DB.GetRowCount()
        if RowCount <> -1
          ComputedPos = vscrollpos * RowCount / 100
          if ComputedPos = 0
            ComputedPos = 1
          end
          if self.DB.GotoPos(ComputedPos)
            SELF.FieldPair.AssignRightToLeft()
            self.SetQueueRecord()
            add(SELF.DataQueue)
            loop self.ListCtrl{prop:Items} - 1 times
              if ~self.DB.Next()                                                                      ! No more rows?
                break                                                                                 ! then break
              else
                SELF.FieldPair.AssignRightToLeft()
                self.SetQueueRecord()
                add(SELF.DataQueue)                                                                   ! and add to the queue
              end
            end
          end
        else
          PageCount = self.DB.GetPageCount()
          if PageCount > 0
            ComputedPge = vscrollpos * PageCount / 100
            if ComputedPge = 0
              ComputedPge = 1
            end
            if self.DB.GotoPage(ComputedPge)
              SELF.FieldPair.AssignRightToLeft()
              self.SetQueueRecord()
              add(SELF.DataQueue)
              loop self.ListCtrl{prop:Items} - 1 times
                if ~self.DB.Next()                                                                      ! No more rows?
                  break                                                                                 ! then break
                else
                  SELF.FieldPair.AssignRightToLeft()
                  self.SetQueueRecord()
                  add(SELF.DataQueue)                                                                   ! and add to the queue
                end
              end
            end
          end
        end
      else
        self.ListCtrl{prop:selected} = self.ListCtrl{PROP:VScrollPos} * records(self.DataQueue) / 100
      end
    end

    if event() = EVENT:ScrollUp
      if choice(self.ListCtrl) <> 1
        self.ListCtrl{prop:selected} = choice(self.ListCtrl) - 1
      else
        if not self.TableLoad
          get(self.DataQueue, 1)
          if self.DB.SetCursorAtRow().
          if self.DB.Previous()
            SELF.FieldPair.AssignRightToLeft()
            self.SetQueueRecord()
            add(SELF.DataQueue, 1)
            if records(self.dataQueue) > self.ListCtrl{prop:items}
              get(self.DataQueue, records(self.DataQueue))
              delete(self.DataQueue)
            end
            get(self.dataqueue, 1)
            self.ListCtrl{prop:selected} = 1
          end
        end
      end
    end

    if event() = EVENT:ScrollDown
      if self.ListCtrl{prop:selected} = records(self.DataQueue)
        if not self.TableLoad
          get(self.DataQueue, records(self.DataQueue))
          if self.DB.SetCursorAtRow().
          if self.Db.next()
            SELF.FieldPair.AssignRightToLeft()
            self.SetQueueRecord()
            add(SELF.DataQueue)
            if records(self.DataQueue) > self.ListCtrl{prop:items}
              get(self.DataQueue, 1)
              delete(self.DataQueue)
            end
            get(self.DataQueue, records(self.DataQueue))
            self.ListCtrl{prop:selected} = records(self.DataQueue)
          end
        end
      else
        self.ListCtrl{prop:selected} = self.ListCtrl{prop:selected} + 1
      end
    end

    if event() = EVENT:PageDown
      if not self.TableLoad
        get(self.DataQueue, records(self.DataQueue))
        if self.DB.SetCursorAtRow()
          if ~self.DB.Next()   ! Check if MoveNext will give EOF.
            self.ListCtrl{prop:selected} = records(self.DataQueue)
            self.ListCtrl{PROP:VScrollPos} = 100
          else
            SELF.FieldPair.AssignRightToLeft()
            self.SetQueueRecord()
            add(SELF.DataQueue)
            get(self.DataQueue, 1)
            delete(self.DataQueue)
            loop self.ListCtrl{prop:Items} - 1 times
              if ~self.DB.Next()
                break
              else
                SELF.FieldPair.AssignRightToLeft()
                self.SetQueueRecord()
                add(SELF.DataQueue)
                if records(self.DataQueue) >  self.ListCtrl{prop:Items}
                  get(self.DataQueue, 1)
                  delete(self.DataQueue)
                end
              end
            end
          end
        end
      else
        if choice(self.ListCtrl) < records(self.DataQueue) - self.ListCtrl{prop:items}
          self.ListCtrl{prop:selected} = self.ListCtrl{prop:Selected} + self.ListCtrl{prop:items}
        else
          self.ListCtrl{prop:selected} = records(self.DataQueue)
        end
      end
    end

    if event() = EVENT:PageUp
      if not self.TableLoad
        get(self.DataQueue, 1)
        if self.DB.SetCursorAtRow()
          if ~self.DB.Previous()   ! Check if MoveNext will give BOF
            self.ListCtrl{prop:selected} = 1       ! yes, postion the selection bar on first row in the list
            self.ListCtrl{PROP:VScrollPos} = 0     ! Move the thumb in vertical scroll bar to top
          else
            SELF.FieldPair.AssignRightToLeft()
            self.SetQueueRecord()
            add(SELF.DataQueue, 1)
            get(self.DataQueue, records(self.DataQueue))
            delete(self.DataQueue)
            loop self.ListCtrl{prop:Items} - 1 times
              if ~self.DB.Previous()
                break
              else
                SELF.FieldPair.AssignRightToLeft()
                self.SetQueueRecord()
                add(SELF.DataQueue, 1)
                if records(self.DataQueue) >  self.ListCtrl{prop:Items}
                  get(self.DataQueue, records(self.DataQueue))
                  delete(self.DataQueue)
                end
              end
            end
          end
        end
      else
        if choice(self.ListCtrl) > self.ListCtrl{prop:items}
          self.ListCtrl{prop:selected} = self.ListCtrl{prop:Selected} - self.ListCtrl{prop:items}
        else
          self.ListCtrl{prop:selected} = 1
        end
      end
    end

    if event() = EVENT:ScrollTop
      if not self.TableLoad
        free(self.DataQueue)
        if self.DB.GetFirstPage()
          SELF.FieldPair.AssignRightToLeft()
          self.SetQueueRecord()
          add(SELF.DataQueue)
          loop self.ListCtrl{prop:Items} - 1 times
            if ~self.DB.Next()                                                                      ! No more rows?
              break                                                                                 ! then break
            else
              SELF.FieldPair.AssignRightToLeft()
              self.SetQueueRecord()
              add(SELF.DataQueue)                                                                   ! and add to the queue
            end
          end
        end
      else
        self.ListCtrl{prop:selected} = 1
      end
    end


    if event() = EVENT:ScrollBottom
      if not self.TableLoad
        free(self.DataQueue)
        if self.DB.GetLastPage()

          SELF.FieldPair.AssignRightToLeft()
          self.SetQueueRecord()
          add(SELF.DataQueue)
          loop self.ListCtrl{prop:Items} - 1 times
            if ~self.DB.Next()                                                                      ! No more rows?
              break                                                                                 ! then break
            else
              SELF.FieldPair.AssignRightToLeft()
              self.SetQueueRecord()
              add(SELF.DataQueue)                                                                   ! and add to the queue
            end
          end
        end
      else
        self.ListCtrl{prop:selected} = records(SELF.DataQueue)
      end
    end


    get(self.DataQueue, choice(self.ListCtrl))
    self.FieldPair.AssignLeftToRight()
    display()
    return(0)


cBrowse.OnColResize         procedure

ndx         long

    code
    if event() = EVENT:ColumnResize
      loop ndx = 1 to records(SELF.ColQ)
        get(SELF.ColQ, ndx)
        if SELF.ColQ.SortOrder = 0
          SELF.ColQ.OriginalWidth = SELF.ListCtrl{proplist:width, ndx}
          put(SELF.ColQ)
        end
      end
    end
    return(0)


cBrowse.SetQueueRecord      procedure

    code

cBrowse.SetTagging          procedure(byte pFlag)

    code
    self.TaggingFlag = pFlag
    if ~self.TagKeyAlerted
      !self.ListCtrl{prop:alrt, 255} = DownKey
      !self.ListCtrl{prop:alrt, 255} = UpKey
      self.ListCtrl{prop:alrt, 255} = CtrlA
      self.ListCtrl{prop:alrt, 255} = CtrlU
      self.ListCtrl{prop:alrt, 255} = DownKey
    end

cBrowse.Locate              procedure()

szCriteria  cstring(128)
FieldQ      any
RecNbr      long

    code




      if self.LOcatorVar
        self.ColQ.SortOrder = 1
        get(self.ColQ, self.ColQ.SortOrder)
        if ~errorcode()
          self.szLocatorWhere = clip(self.ColQ.ColName_SQL) & ' ' &|
                                choose(self.ColQ.ColDatatype = datatype:long, '>=', 'LIKE ') &|
                                choose(self.ColQ.ColDataType = datatype:long, '', '''') &|
                                clip(self.LocatorVar) &|
                                choose(self.ColQ.ColDataType = datatype:long, '', '%'' ')
        end
      else
        self.szLocatorWhere = ''
      end
      self.Refresh()


cBrowse.Refresh             procedure()

szQuery     cstring(2048)
AndConn     cstring(6)
Pos         long
RecCount    long
AbsPage     long
LastPage    long
CurPos      long

    code

    if ~(SELF.Filter &= null)
      SELF.szUserWhereStr = SELF.Filter.GetFilter()
    end

    if ~SELF.szWhereStr and (SELF.szUserWhereStr or self.szLocatorWhere)

      szQuery = SELF.szSelectStr & ' ' &|
                SELF.szFromStr &|
                ' WHERE '
      if self.szUserWhereStr
        szQuery = clip(szQuery) & ' ' & clip(self.szUserWhereStr)
      end
      if self.szUserWhereStr and self.szLocatorWhere
        szQuery = clip(szQuery) & ' AND ' & clip(self.szLocatorWhere)
      else
        if self.szLocatorWhere
          szQuery = clip(szQuery) &  ' ' & clip(self.szLocatorWhere)
        end
      end
      szQuery = clip(szQuery) & ' ' & clip(self.szOrderByStr)

    else

      szQuery = SELF.szSelectStr & ' ' & SELF.szFromStr & ' ' & SELF.szWhereStr
      if self.szUserWhereStr
        szQuery = clip(szQuery) & ' AND ' & clip(self.szUserWhereStr)
      end
      if self.szLocatorWhere
        szQuery = clip(szQuery) & ' AND ' & clip(self.szLocatorWhere)
      end
      szQuery = clip(szQuery) & ' ' & clip(self.szOrderByStr)

    end

    free(SELF.DataQueue)
    if ~(self.TaggingMark &= null)
      self.TaggingMark = 0
    end

    if self.CopyToCB = true
      setclipboard(szQuery)
    end


    if SELF.DB.ExecuteQuery(szQuery)                                                          ! Execute the query and check if there is a row returned
      SELF.SetQueueRecord()
      SELF.FieldPair.AssignRightToLeft()
      add(SELF.DataQueue)
      if self.TableLoad
        loop                                                                         
          if ~self.DB.Next()                                                                  ! No more rows?
            break                                                                             ! then break
          else
            self.SetQueueRecord()
            SELF.FieldPair.AssignRightToLeft()
            add(SELF.DataQueue)                                                               ! and add to the queue
          end
        end
      else
        loop self.DB.GetPageSize() - 1 times
          if ~self.DB.Next()                                                                  ! No more rows?
            break                                                                             ! then break
          else
            self.SetQueueRecord()
            SELF.FieldPair.AssignRightToLeft()
            add(SELF.DataQueue)                                                               ! and add to the queue
          end
        end
      end

    else

    end
    SELF.ListCtrl{prop:Selected} = 1


cBrowse.RefreshPage         procedure

StartPos        long

    code

    if not self.tableLoad
      get(self.DataQueue, 1)
      if self.DB.SetToPos()
        free(Self.DataQueue)
        self.SetQueueRecord()
        SELF.FieldPair.AssignRightToLeft()
        add(SELF.DataQueue)
        loop self.ListCtrl{prop:Items} - 1 times
          if ~self.DB.Next()                                                                      ! No more rows?
            break                                                                                 ! then break
          else
            SELF.FieldPair.AssignRightToLeft()
            self.SetQueueRecord()
            add(SELF.DataQueue)                                                                   ! and add to the queue
          end
        end
      end
    end
    


cBrowse.onAlertKey          procedure

MenuChoice      long
NewTitle        string(128)
WidthNeeded     long
Ndx             long
qPointer        long     ! To keep actual DataQueue pointer


    code

    if keycode() = MouseRight
      if ~(SELF.Popup &= null)
        SELF.Popup.Ask()
      end
    end

    if keycode() = CtrlMouseRight ! PopMenu for column hide/unhide
      if field() = SELF.ListCtrl
        SELF.GenPopupStr()
        MenuChoice = popup(SELF.szColsPopup)
        if MenuChoice > records(SELF.ColQ)
          SELF.ResetAllVisible()
        else
          SELF.ColQ.ColNbr = MenuChoice
          get(SELF.ColQ, SELF.ColQ.ColNbr)
          if ~errorcode()
            SELF.ListCtrl{proplist:Width, SELF.ColQ.ColNbr} = choose(SELF.ColQ.Visible = true, 0, SELF.ColQ.Width)
            SELF.ColQ.Visible = choose(SELF.ColQ.Visible = true, false, true)
            put(SELF.ColQ)
          end
        end
      end
    end

    if keycode() = MouseLeft                                             ! Maybe user wants a sort action
      if field() = SELF.ListCtrl                                         ! Additionnal check
        if SELF.ListCtrl{proplist:MouseDownRow} = 0                      ! USer did click in the list header
          if SELF.ListCtrl{proplist:MouseDownField} = SELF.CurSortCol  !
            SELF.ColQ.ColNbr = SELF.CurSortCol
            get(SELF.ColQ, SELF.ColQ.ColNbr)
            if ~errorcode() and self.ColQ.CanBeSorted
              self.szLocatorWhere = ''                                    ! Clear the locator criteria
              SELF.ColQ.SortDirection = choose(SELF.ColQ.SortDirection = '+', '-', '+')
              SELF.ColQ.SortHeader = '(' & SELF.ColQ.SortOrder & ',' & SELF.ColQ.SortDirection & ')'
              NewTitle = clip(SELF.ColQ.ColName) & ' ' & clip(SELF.ColQ.SortHeader)
              WidthNeeded = SELF.CheckWidth(NewTitle)
              if WidthNeeded > SELF.ListCtrl{proplist:Width, SELF.ColQ.ColNbr}
                SELF.ListCtrl{proplist:Width, SELF.ColQ.ColNbr} = WidthNeeded
                SELF.ColQ.Width = WidthNeeded
              end
              SELF.ListCtrl{proplist:header, SELF.ColQ.ColNbr} = clip(SELF.ColQ.ColName) & ' ' & clip(SELF.ColQ.SortHeader)
              SELF.ColQ.ColListFormat = SELF.ListCtrl{proplist:Format, SELF.ColQ.ColNbr}
              put(SELF.ColQ)

              SELF.GenerateOrderBy()
              if ~self.QueueSort
                !if self.DB._Sort(self.szSortStr)
                self.Refresh()
              else
                sort(self.DataQueue, self.SortQueueStr)
              end
            end

          else

            ! User did click with MouseLeft on a different header.
            ! First, check if the user clicked on a sortable column, if so, restore Original header
            SELF.ColQ.ColNbr = SELF.ListCtrl{proplist:MouseDownField}
            get(SELF.ColQ, SELF.ColQ.ColNbr)
            if ~errorcode() and self.ColQ.CanBeSorted
              self.szLocatorWhere = ''
              SELF.RestoreOrigHdr()

              SELF.NextSortNbr = 2    ! Next sort order nbr for a shift click process

              ! Get the corresponding columns
              SELF.ColQ.ColNbr = SELF.ListCtrl{proplist:MouseDownField}
              get(SELF.ColQ, SELF.ColQ.ColNbr)
              if ~errorcode() and self.ColQ.CanBeSorted
                SELF.ColQ.SortOrder = 1
                SELF.ColQ.SortDirection = choose(self.ColQ.SortDirection = '+', '-', '+')
                SELF.ColQ.SortHeader = '(' & SELF.ColQ.SortOrder & ',' & SELF.ColQ.SortDirection & ')'

                SELF.CurSortCol = SELF.ColQ.ColNbr    ! set what col is the current col sorted

                ! Apply new header
                ! First, get what will be the new header string and check if current width of the col is large enough. Update if needed.
                NewTitle = clip(SELF.ColQ.ColName) & ' ' & clip(SELF.ColQ.SortHeader)
                WidthNeeded = SELF.CheckWidth(NewTitle)
                if WidthNeeded > SELF.ListCtrl{proplist:Width, SELF.ColQ.ColNbr}
                  SELF.ListCtrl{proplist:Width, SELF.ColQ.ColNbr} = WidthNeeded
                  SELF.ColQ.Width = WidthNeeded
                end
                SELF.ListCtrl{proplist:header, SELF.ColQ.ColNbr} = clip(NewTitle)
                SELF.ListCtrl{proplist:ColStyle, SELF.ColQ.ColNbr} = SELF.MainSortStyle
                SELF.ColQ.ColListFormat = SELF.ListCtrl{proplist:Format, SELF.ColQ.ColNbr}
                put(SELF.ColQ)

                SELF.GenerateOrderBy()
                if ~self.QueueSort
                  self.Refresh()
                else
                  sort(self.DataQueue, self.SortQueueStr)
                end
              end
            end
          end
        else
          if records(self.DataQueue)
            get(self.DataQueue, choice(self.ListCtrl))
            self.FieldPair.AssignLeftToRight()
          end
        end
      end
    end

    if keycode() = ShiftMouseLeft
      if field() = SELF.ListCtrl
        if SELF.ListCtrl{proplist:MouseDownRow} = 0                                                     ! Shift click in the header, add additionnal sort to the ORDER BY
          SELF.ColQ.ColNbr = SELF.ListCtrl{proplist:MouseDownField}                                     ! Get col nbr
          get(SELF.ColQ, SELF.ColQ.ColNbr)                                                              ! lookup in the column queue
          if ~errorcode() and self.ColQ.CanBeSorted

            if ~SELF.ColQ.SortOrder                                                                     ! if Col.Sortorder = 0, we add that col to the ORDER BY

              SELF.ColQ.SortOrder = SELF.NextSortNbr                                                    ! assign the SortOrder nbr
              SELF.NextSortNbr += 1                                                                     ! Increment for the next one
              SELF.ColQ.SortDirection = '+'                                                             ! Default new sort direction
              SELF.ColQ.SortHeader = '(' & SELF.ColQ.SortOrder & ',' & SELF.ColQ.SortDirection & ')'    ! Update sort header
              NewTitle = clip(SELF.ColQ.ColName) & ' ' & clip(SELF.ColQ.SortHeader)                     ! Generate a new title
              WidthNeeded = SELF.CheckWidth(NewTitle)                                                   ! Look for width
              if WidthNeeded > SELF.ColQ.Width                                                          ! If needed width > current width
                SELF.ColQ.Width = WidthNeeded                                                           ! Update it
                SELF.ListCtrl{proplist:Width, SELF.ColQ.ColNbr} = WidthNeeded                           ! and apply it to the list
              end

              SELF.ListCtrl{proplist:header, SELF.ColQ.ColNbr} = clip(SELF.ColQ.ColName) & ' ' &|       ! apply new header
                                                                 clip(SELF.ColQ.SortHeader)

              SELF.ColQ.ColListFormat = SELF.ListCtrl{proplist:Format, SELF.ColQ.ColNbr}                ! Save the new format str for that col

            else   ! The col has alaready a sortOrder assigned to it, this means the user wants to "reverse" it

              SELF.ColQ.SortDirection = choose(SELF.ColQ.SortDirection = '+', '-', '+')                 ! Reverse direction
              SELF.ColQ.SortHeader = '(' & SELF.ColQ.SortOrder & ',' & SELF.ColQ.SortDirection & ')'    ! Compute new SortHeader
              SELF.ListCtrl{proplist:header, SELF.ColQ.ColNbr} = clip(SELF.ColQ.ColName) & ' ' &|       ! Apply new header
                                                                 clip(SELF.ColQ.SortHeader)
              SELF.ColQ.ColListFormat = SELF.ListCtrl{proplist:Format, SELF.ColQ.ColNbr}                ! Save new ColListFormat
              
            end

            put(SELF.ColQ)

          end
          if self.ColQ.CanBeSorted
            SELF.GenerateOrderBy()
            if ~self.QueueSort
              self.Refresh()
            else
              sort(self.DataQueue, self.SortQueueStr)
            end
          end
        end
      end
    end

    if keycode() = MouseLeft2
      if SELF.DefaultEquate
        post(EVENT:Accepted, self.DefaultEquate)
      end
    end

    if keycode() = SELF.EIPCompletionKey or keycode() = SELF.EIPAbortKey
      if SELF.EIPMode = true
        POST(event:EIPModeEnd)
        return(5)
      end
    end

    if keycode() = CtrlA
      if self.TaggingFlag
        if self.TableLoad
          qPointer = pointer(self.DataQueue)
          loop ndx = 1 to records(self.DataQueue)
            get(self.DataQueue, ndx)
            if ~errorcode()
              self.TaggingMark = true
              put(self.DataQueue)
            else
              break
            end
          end
          get(self.DataQueue, qPointer)
        end
      end
    end

    if keycode() = CtrlU
      if self.TaggingFlag
        if self.TableLoad
          self.UnSelectAll()
        end
      end
    end

    if keycode() = DownKey
      self.UnSelectAll()
    end

    return(0)



cBrowse.OnPreAlertKey       procedure

    code
    return(5)    ! 5 equals Level:Notify, which will act like a cycle in the accept loop


cBrowse.SetAlertKeys        procedure

    code
    self.ListCtrl{prop:Alrt, 255} = MouseLeft
    self.ListCtrl{prop:Alrt, 255} = EscKey
    self.ListCtrl{prop:Alrt, 255} = MouseLeft2
    self.ListCtrl{prop:Alrt, 255} = CtrlMouseRight
    self.ListCtrl{prop:Alrt, 255} = ShiftMouseLeft



cBrowse.SetAlwaysVisible        procedure(string pColName)

RetValue        long

    code
    RetValue = false
    SELF.ColQ.ColName = pColName
    get(SELF.ColQ, SELF.ColQ.ColName)
    if ~errorcode()
      SELF.ColQ.AlwaysVisible = true
      put(SELF.ColQ)
      if ~errorcode()
        RetValue = true
      end
    end
    return(RetValue)


cBrowse.SetQuery                procedure(string pQuery)

! This procedure is used to store the query set by the programmer at design time in the browse object
! The query is splitted in its different basic clauses (SELECT, FROM, WHERE and ORDER BY)

! Later on, if user wants to apply additionnal filtering on the list, the query will be rebuild with more ease
! by doing something like: Query = szSelect & szFrom & szWhere & szUserWhere & szOrderBy

szQuery     cstring(2048)
szDelim     cstring(4)
szToken     cstring(25)

TokenQ      queue
Token         string(25)
            end

StrPos      long

SelectQ     queue
Token         string(10)
Pos           long
FromPos       long
WherePos      long
OrderByPos    long
            end

FromQ       queue
Token         string(5)
Pos           long
            end

WhereQ      queue
Token         string(6)
Pos           long
            end

OrBYQ       queue
Pos           long
            end

LastCol     string(25)

ndx         long
ix          long
szRef       &cstring

PosWHere    long
PosOrder    long
PosFrom     long
PosSelect   long

    code

    szQuery = pQuery
    StrPos = 1
    loop
      StrPos = instring('SELECT ', upper(szQuery), 1, StrPos)
      if StrPos
        SelectQ.Token = 'SELECT'
        SelectQ.Pos = StrPos
        add(SelectQ)
        StrPos += 7
      else
        break
      end
    end

    if records(SelectQ) > 1   ! Query has subquery

      ! Collect the "FROM " position in the string
      szQuery = pQuery
      StrPos = 1
      loop
        StrPos = instring(' FROM ', upper(szQuery), 1, StrPos)
        if StrPos
          FromQ.Token = 'FROM'
          FromQ.Pos = StrPos
          add(FromQ)
          StrPos += 6
        else
          break
        end
      end

      ! Collect the "WHERE " position in the string
      szQuery = pQuery
      StrPos = 1
      loop
        StrPos = instring(' WHERE ', upper(szQuery), 1, StrPos)
        if StrPos
          WhereQ.Token = 'WHERE'
          WhereQ.Pos = StrPos
          add(WhereQ)
          StrPos += 7
        else
          break
        end
      end

      szQuery = pQuery
      StrPos = 1
      loop
        StrPos = instring(' ORDER BY ', upper(szQuery), 1, StrPos)
        if StrPos
          OrBYQ.Pos = StrPos
          add(OrBYQ)
          Strpos += 10
        else
          break
        end
      end

      ! Update the SelectQ with the corresponding element
      ! We process the SelectQ with the last inserted record in it. The corresponding FROM, WHERE and ORDER BY will be the first one
      ! in other queue where pos in string is higher then the SELECT under process.

      sort(SelectQ, SelectQ.Pos)
      sort(FromQ, FromQ.Pos)
      sort(WhereQ, WhereQ.Pos)
      sort(orBYQ, orByQ.Pos)

      loop ndx = records(SelectQ) to 1 by -1
        get(SelectQ, ndx)
        if ~errorcode()
          ! Get associated FROM
          loop ix = 1 to records(FromQ)
            get(FromQ, ix)
            if FromQ.Pos > SelectQ.Pos
              SelectQ.FromPos = FromQ.Pos
              put(SelectQ)
              delete(FromQ)
              break
            end
          end

          ! Get associated WHERE
          loop ix = 1 to records(WhereQ)
            get(WhereQ, ix)
            if WhereQ.Pos > SelectQ.Pos
              SelectQ.WherePos = WhereQ.Pos
              put(SelectQ)
              delete(WhereQ)
              break
            end
          end

          loop ix = 1 to records(orBYQ)
            get(orBYQ, ix)
            if orBYQ.Pos > SelectQ.Pos
              SelectQ.OrderByPos =  orBYQ.Pos
              put(SelectQ)
              delete(orBYQ)
              break
            end
          end
        end
      end

      szQuery = pQuery

      get(SelectQ, 1)

      self.szSelectStr = szQuery[1 : SelectQ.FromPos - 1]

      if ~SelectQ.WherePos and ~SelectQ.OrderByPos
        self.szFromStr = szQuery[SelectQ.FromPos + 1 : len(clip(szQuery))]
      end

      if ~SelectQ.WherePos and SelectQ.OrderByPos
        self.szFromStr = szQuery[SelectQ.FromPos + 1 : SelectQ.orderByPos - 1]
      end

      if SelectQ.WherePos
        self.szFromStr = szQuery[SelectQ.FromPos + 1 : SelectQ.WHerePos - 1]
      end

      if SelectQ.WherePos
        if SelectQ.OrderByPos
          self.szWhereStr = szQuery[SelectQ.WherePos + 1 : SelectQ.OrderByPos - 1]
        else
          self.szWhereStr = szQuery[SelectQ.WherePos + 1 : len(clip(szQuery))]
        end
      end

    else


      PosSelect = instring('SELECT ', upper(pQuery), 1, 1)
      PosFrom = instring(' FROM ', upper(pQuery), 1, 1)

      self.szSelectStr = pQuery[PosSelect : PosFrom - 1]

      PosWhere = instring(' WHERE ', upper(pQuery), 1, 1)
      PosOrder = instring(' ORDER BY ', upper(pQuery), 1, 1)

      if ~posWhere and ~PosOrder
        self.szFromStr = pQuery[PosFrom + 1 : len(clip(pQuery))]
      end

      if ~PosWhere and PosOrder
        self.szFromStr =  pQuery[PosFrom + 1 : posOrder - 1]
      end

      if PosWhere
        self.szFromStr =  pQuery[PosFrom + 1 : PosWhere - 1]
      end

      if PosWhere
        if PosOrder
          self.szWhereStr = pQuery[PosWhere + 1 : Posorder]
        else
          self.szWhereStr = pQuery[PosWhere + 1 : len(clip(pQuery))]
        end
      end

      if PosOrder
        self.szOrderByStr = pQuery[PosOrder + 1 : len(clip(pQuery))]
      end

    end

cBrowse.SetTableLoad            procedure(byte pFlag)

    code
    SELF.TableLoad = pFlag
    self.ListCtrl{prop:imm} = false

cBrowse.SetQueueSort            procedure(byte pFlag)

    code
    SELF.QueueSort = pFlag


cBrowse.SetNoSortOn             procedure(string pColName)

RetValue        long

    code
    RetValue = false
    SELF.ColQ.ColName = pColName
    get(SELF.ColQ, SELF.ColQ.ColName)
    if ~errorcode()
      SELF.ColQ.CanBeSorted = false
      put(SELF.ColQ)
      if ~errorcode()
        RetValue = true
      end
    end
    return(RetValue)



CBrowse.OnEIPModeEnd            procedure()

ndx     byte

    code
    loop ndx = 1 to records(SELF.ColQ)
      get(SELF.ColQ, ndx)
      if SELF.ColQ.EIPEnable
        SELF.ListCtrl{prop:edit, SELF.ColQ.ColNbr} = 0
      end
    end
    if keycode() = SELF.EIPCompletionKey
      ! Call to the code that will update the backend will go here. If return value is ok, then update the queue
      if SELF.DB.UpdateRow(SELF.UpdateQ)
        SELF.FieldPair.AssignRightToLeft()
        self.SetQueueRecord()
        put(SELF.DataQueue)
        select(SELF.ListCtrl)
      end
    end
    display()
    SELF.EIPMode = false
    return(0)


cBrowse.OnEIPModeBegin          procedure()

ndx     long

    code
    SELF.EIPMode = false
    ! Locate the first column with EIP FEQ control
    loop ndx = 1 to records(SELF.ColQ)
      get(SELF.ColQ, ndx)
      if SELF.ColQ.EIPEnable
        if SELF.ColQ.EIPFeq
          if self.ColQ.ColNbr = self.ListCtrl{proplist:MouseDownField}
            select(SELF.COlQ.EIPFeq)
            SELF.EIPMode = true
            break
          end
        end
      end
    end

cBrowse.SetEIPCompleteKey       procedure(long pKeycode)

    code
    SELF.EIPCompletionKey = pKeycode


cBrowse.SetEIPAbortKey          procedure(long pKeycode)

    code
    SELF.EIPAbortKey = pKeycode


cBrowse.SetListStyle            procedure()

    code

cBrowse.SetCopyToCB             procedure(byte pFlag)

    code
    self.CopyToCB = pFlag


cBrowse.UnSelectAll             procedure

qPointer        long
ndx             long

    code
    qPointer = pointer(self.DataQueue)
    loop ndx = 1 to records(self.DataQueue)
      get(self.DataQueue, ndx)
      if ~errorcode()
        self.TaggingMark = false
        put(self.DataQueue)
      else
        break
      end
    end
    get(self.DataQueue, qPointer)
