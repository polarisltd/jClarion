    MEMBER()
    MAP
    END

    INCLUDE('CFILTERLIST.INC'),ONCE
    INCLUDE('KEYCODES.CLW'),ONCE
    include('CFILTERLIST.TRN'), ONCE

cFilterList.Construct               procedure

    code

    SELF.ConnectOpeQ &= new(TConnectOpeQ)
    assert(~(SELF.ConnectOpeQ &= null))

    SELF.ColOpeQ &= new(TColOpeQ)
    assert(~(SELF.ColOpeQ &= null))
    SELF.ColOpeQRef &= SELF.ColOpeQ

    self.ColOpeExQ &= new(TColOpeExceptQ)
    self.ColOpeExQRef &= self.ColOpeExQ

    self.EQ &= new(EditQueue)
    assert(~(self.EQ &= null))

    self.IsNew = true

    self.EIP &= new(QEIPManager)
    assert(~(self.EIP &= null))

    self.ColQ &= new(TColQ)
    self.EIP.EQ &= self.EQ

    self.ColEditClass &= new(TColEditClass)
    assert(~(self.ColEditClass &= null))
    self.ColEditClass.ColQ &= self.ColQ

    self.ColOpeClass &= new(TColOpeClass)
    assert(~(self.ColOpeClass &= null))
    self.ColOpeClass.ColOpeQ &= SELF.ColOpeQ

    self.ColValueClass &= new(EditEntryClass)
    assert(~(self.ColValueClass &= null))

    self.ConEditClass &= new(TConnEditClass)
    assert(~(self.ConEditClass &= null))
    self.ConEditClass.ConnOpeQ &= self.ConnectOpeQ

    self.FPairs &= new(FieldPairsClass)


cFilterList.Destruct                procedure

ndx     long

    code

    assert(~(SELF.ConnectOpeQ &= null))
    loop
      ndx = records(self.ConnectOpeQ)
      if ndx
        get(self.ConnectOpeQ, ndx)
        delete(self.ConnectOpeQ)
      else
        break
      end
    end
    free(SELF.ConnectOpeQ)
    dispose(SELF.ConnectOpeQ)

    assert(~(SELF.ColOpeQ &= null))
    loop
      ndx = records(SELF.ColOpeQ)
      if ndx
        get(SELF.ColOpeQ, ndx)
        delete(SELF.ColOpeQ)
      else
        break
      end
    end
    free(SELF.ColOpeQ)
    dispose(SELF.ColOpeQ)

    free(self.ColOpeExQ)
    dispose(self.ColOpeExQ)

?    assert(~(self.EQ &= null))
    loop
      ndx = records(self.EQ)
      if ndx
        get(self.EQ, ndx)
        delete(self.EQ)
      else
        break
      end
    end
    free(self.EQ)
    dispose(self.EQ)

?    assert(~(self.EIP &= null))
    dispose(self.EIP)

?    assert(~(self.ColEditClass &= null))
    dispose(self.ColEditClass)

?    assert(~(self.ColOpeClass &= null))
    dispose(self.ColOpeClass)

?    assert(~(self.ColValueClass &= null))
    dispose(self.ColValueClass)

?    assert(~(self.ConEditClass &= null))
    dispose(self.ConEditClass)

?    assert(~(self.FPairs &= null))
    if ~(self.FPairs &= null)
      self.FPairs.Kill()
      dispose(self.FPairs)
    end

?    assert(~(self.ColQ &= null))
    loop
      ndx = records(self.ColQ)
      if ndx
        get(self.ColQ, ndx)
        delete(self.ColQ)
      else
        break
      end
    end
    free(self.ColQ)
    dispose(self.ColQ)

    if self.DisposeINI = true
?      assert(~(self.IniMgr &= null))
      if ~(self.IniMgr &= null)
        dispose(self.INIMgr)
      end
    end


cFilterList.Reset                   procedure

    code

    parent.Reset()
    self.ColEditVar = ''
    self.ColOpeVar = ''
    self.ColValueVar = ''
    self.ConEditVar = 'DONE'
    self.CurrentQuery = ''

cFilterList.Init                    procedure(long pListCtrl, window pW)

    code

    SELF.ListCtrl = pListCtrl
    SELF.W &= pW
    self.EIP.Q &= self.FilterQ
    self.FPairs.Init()
    self.EIP.Fields &= self.FPairs
    self.FPairs.AddPair(self.FilterQ.Column, self.ColEditVar)
    self.FPairs.AddPair(self.FilterQ.Operator, self.ColOpeVar)
    self.FPairs.AddPair(self.FilterQ.Value, self.ColValueVar)
    self.FPairs.AddPair(self.FilterQ.Connection, self.ConEditVar)

    self.EIP.AddControl(self.ColEditClass, 1)
    self.EIP.AddControl(self.ColOpeClass, 2)
    self.EIP.AddControl(self.ColValueClass, 3)
    self.EIP.AddControl(self.ConEditClass, 4)

    self.EIP.ListControl = self.ListCtrl

    SELF.FillConnectOpe()
    if SELF.UseSQL = true
      SELF.FillColOpe(DefaultOpeSQL)
      SELF.FillColOpeEx(ExceptionGrpSQL)
    else
      SELF.FillColOpe(DefaultOpe)
      SELF.FillColOpeEx(ExceptionGrp)
    end


    SELF.ListCtrl{prop:from} = SELF.FilterQ

    !SELF.RegisterEvents()

cFilterList.InitINI                 procedure(*INICLass pIniRef)

    code
    self.INIMgr &= pIniRef
    self.DisposeINI = false


cFilterList.InitINI                 procedure(string pFileName, long IniType = NVD_INI)

RetValue    byte

    code
    self.INIMgr &= new(INICLass)
    self.DisposeINI = true
    assert(~(self.INIMgr &= null))
    if ~(self.INIMgr &= null)
      self.INIMgr.Init(pFileName, IniType)
      RetValue = true
    else
      ! Creation of the INIClass object failed
      RetValue = false
    end

    return(RetValue)


cFilterList.RegisterEvents          procedure

    code

    register(EVENT:PreAlertKey, address(SELF.OnPreAlertKey), address(SELF), SELF.W)
    register(EVENT:AlertKey, address(SELF.OnAlertKey), address(SELF), ,SELF.ListCtrl)
    register(EVENT:Drop, address(SELF.OnDrop), address(SELF), , SELF.ListCtrl)
    register(EVENT:Accepted, address(SELF.OnAccepted), address(SELF), SELF.W)



cFilterList.FillConnectOpe          procedure()

    code
    SELF.ConnectOpeQ.Operator = 'AND'
    add(SELF.ConnectOpeQ)

    SELF.ConnectOpeQ.Operator = 'AND (...'
    add(SELF.ConnectOpeQ)

    SELF.ConnectOpeQ.Operator = '...) AND'
    add(SELF.ConnectOpeQ)

    SELF.ConnectOpeQ.Operator = 'OR'
    add(SELF.ConnectOpeQ)

    SELF.ConnectOpeQ.Operator = 'OR (...'
    add(SELF.ConnectOpeQ)

    SELF.ConnectOpeQ.Operator = '...) OR'
    add(SELF.ConnectOpeQ)

    SELF.ConnectOpeQ.Operator = 'DONE'
    add(SELF.ConnectOpeQ)

    SELF.ConnectOpeQ.Operator = '...) DONE'
    add(SELF.ConnectOpeQ)


cFilterList.FillColOpe              procedure(TDefaultOpe pOpeGrp)

Follow USHORT(3)
Slen   BYTE,AUTO
OpeStr &STRING

    code
    OpeStr &= pOpeGrp
    loop pOpeGrp.Number times
      SLEn = val(OpeStr[Follow])
      Follow += 1
      self.ColOpeQ.OperatorUser = OpeStr[Follow : Follow + Slen-1]
      Follow += SLen
      SLEn = val(OpeStr[Follow])
      Follow += 1
      self.ColOpeQ.Operator = OpeStr[Follow : Follow + Slen-1]
      Follow += SLen
      Follow += 4
      add(self.ColOpeQ, self.ColOpeQ.OperatorUser)
    end

cFilterList.FillColOpeEx     procedure(TDefaultOpe pOpeExGrp)

Follow USHORT(3)
Slen   BYTE,AUTO
OpeStr &STRING

ALongGrp    group
b1            byte
b2            byte
b3            byte
b4            byte
            end
ALong       ulong, over(ALongGrp)


    code
    OpeStr &= pOpeExGrp
    loop pOpeExGrp.Number times
      ALongGrp.b1 = val(OpeStr[Follow])
      Follow += 1
      ALongGrp.b2 = val(OpeStr[Follow])
      Follow += 1
      ALongGrp.b3 = val(OpeStr[Follow])
      Follow += 1
      ALongGrp.b4 = val(OpeStr[Follow])
      self.ColOpeExQ.ColDataType = ALong
      Follow += 1
      SLEn = val(OpeStr[Follow])
      Follow += 1
      self.ColOpeExQ.OperatorUser = OpeStr[Follow : Follow + Slen-1]
      Follow += SLen
      SLEn = val(OpeStr[Follow])
      Follow += 1
      self.ColOpeExQ.Operator = OpeStr[Follow : Follow + Slen-1]
      Follow += SLen
      add(self.ColOpeExQ, self.ColOpeExQ.OperatorUser)
    end





cFilterList.OnDrop                  procedure

sDropID         string(128)
sFieldName      string(25)
Pos             long
SizeNeeded      long
lDate           date

    code
    sDropID = dropid()
    if sDropID
      if records(SELF.FilterQ)
        get(SELF.FilterQ, records(SELF.FilterQ))
        if SELF.FilterQ.Connection = 'DONE'
          SELF.FilterQ.Connection = 'AND'
        else
          if SELF.FIlterQ.Connection = '...) DONE'
            SELF.FilterQ.Connection = '...) AND'
          end
        end
        put(SELF.FilterQ)
      end
      Pos = instring(';', sDropID, 1, 1)
      if Pos
        sFieldName = sDropID[1 : Pos - 1]

        self.ColFilterQ.ColName = sFieldName
        get(self.ColFilterQ, self.ColFilterQ.ColName)
        if ~errorcode()
          SizeNeeded = len(sDropID[Pos + 1 : len(clip(sDropID))])
          SELF.FilterQ.Column = sFieldName
          SELF.FilterQ.Operator = 'Equal'
          if (self.ColFilterQ.ColDatatype = datatype:date or self.ColFilterQ.ColDatatype = datatype:time) and not self.useSQL
            self.FilterQ.Value = format(sDropID[Pos + 1 : len(clip(sDropID))], self.ColFilterQ.ColPicture)
          else
            if (self.ColFilterQ.ColDatatype = datatype:date) 
              self.FilterQ.Value = format(deformat(sDropID[Pos + 1 : len(clip(sDropID))], @d17), self.ColFilterQ.ColPicture)
            elsif (self.ColFilterQ.ColDatatype = datatype:time)
              self.FilterQ.Value = format(deformat(sDropID[Pos + 1 : len(clip(sDropID))], @t4), self.ColFilterQ.ColPicture)
            else
              self.FilterQ.Value = sDropID[Pos + 1 : len(clip(sDropID))]
            end
          end
          SELF.FilterQ.Connection = 'DONE'
          add(SELF.FilterQ)
        end
      end
    end
    self.Saved = false
    return(0)


cFilterList.OnAlertKey              procedure

nPos       long
tmpConn    like(self.FilterQ.Connection)

    code

    if field() = SELF.ListCtrl
      if keycode() = MouseLeft2
        if ~records(SELF.FilterQ)

          do rInsert

        else

          get(SELF.FilterQ, choice(SELF.ListCtrl))
          self.FPairs.AssignLeftToRight()

          if self.EIP.Run(ChangeRecord).

          if pointer(self.FilterQ) = records(Self.FilterQ)
            ! Check if the user changed DONE or ...) DONE to something else. If so, insert a new row
            if ~instring('DONE', self.FilterQ.Connection, 1, 1)
              do rInsert
            end
          else
            if instring('DONE', self.FilterQ.Connection, 1, 1)  ! User did change the position of DONE or ...) DONE operator
              loop
                get(self.FilterQ, choice(self.ListCtrl) + 1)
                if ~errorcode()
                  delete(self.FilterQ)
                else
                  break
                end
              end
            end
          end

        end
        self.Saved = false
      end

      if keycode() = InsertKey
        do rInsert
      end

      if keycode() = DeleteKey
        get(self.FilterQ, choice(SELF.ListCtrl))
        nPos = instring('DONE', self.FilterQ.Connection, 1, 1)
        tmpConn = self.FilterQ.Connection
        delete(self.FilterQ)
        if nPos
          if records(self.FilterQ)
            get(self.FilterQ, records(self.FilterQ))
            self.FilterQ.Connection = tmpConn
            put(self.FilterQ)
          end
        end
        self.Saved = false
      end
    end

    return(0)

rInsert     routine

    data

    code
    loop
      if records(SELF.FilterQ)
        get(SELF.FilterQ, records(SELF.FilterQ))
        if ~errorcode()
          tmpConn = SELF.FilterQ.Connection
          if SELF.FilterQ.Connection = 'DONE'
            SELF.FilterQ.Connection = 'AND'
          else
            if SELF.FIlterQ.Connection = '...) DONE'
              SELF.FilterQ.Connection = '...) AND'
            end
          end
          put(SELF.FilterQ)
        end
      end
      clear(self.FilterQ)
      self.ColEditVar = ''
      self.ColOpeVar = ''
      self.ColValueVar = ''
      self.ConEditVar = 'DONE'
      SELF.FilterQ.Connection = 'DONE'
      presskey(TabKey)
      if self.EIP.Run(InsertRecord) = RequestCancelled
        get(SELF.FilterQ, records(SELF.FilterQ))
        if not instring('DONE', SELF.FilterQ.Connection, 1, 1)
          if instring(')', SELF.FilterQ.Connection, 1, 1)
            SELF.FilterQ.Connection = '...) DONE'
          else
            SELF.FilterQ.Connection = 'DONE'
          end
          put(SELF.FilterQ)
        end
        break
      else
        get(SELF.FilterQ, records(SELF.FilterQ))
        if instring('DONE', upper(SELF.FilterQ.Connection))
          break
        end
      end
    end


cFilterList.OnPreAlertKey           procedure

    code
    return(0)



cFilterList.OnAccepted              procedure


    code
    case field()
    of SELF.ColumnOpe
      put(SELF.FilterQ)
      SELF.ListCtrl{prop:Edit, 2} = 0
      select(SELF.ListCtrl)

    of SELF.ConnectOpe
      put(SELF.FilterQ)
      SELF.ListCtrl{prop:Edit, 4} = 0
      select(SELF.ListCtrl)

    of SELF.ValueEntry
      put(SELF.FilterQ)
      SELF.ListCtrl{prop:Edit, 3} = 0
      select(SELF.ListCtrl)
    end

    return(0)

cFilterList.AskQueryName            procedure()

sQuery  string(50)

PickQ       queue
Name          string(50)
            end

Entries     long
ndx         long


Window WINDOW('Query Name'),AT(,,345,62),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),CENTER,GRAY, |
         DOUBLE
       PROMPT('&Query Name:'),AT(15,14),USE(?Prompt1)
       ENTRY(@s50),AT(64,14,261,10),USE(sQuery)
       BUTTON('Ok'),AT(227,38,45,14),USE(?btnOk)
       BUTTON('Cancel'),AT(279,38,45,14),USE(?btnCancel)
     END


    code

    ! Load a queue of actual list of Query to check if the name will be already existant.

    Entries = self.INIMgr.TryFetch(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & 'QUERIES', 'ENTRIES')
    if Entries
      loop ndx = 1 to Entries
        PickQ.Name = self.INIMgr.FetchField(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & 'QUERIES', 'ENTRY_' & ndx, 1)
        if PickQ.Name
          add(PickQ)
        end
      end
    end


    open(window)
    accept
      case field()
      of ?btnOK
        if event() = EVENT:Accepted
          self.CurrentQuery = sQuery
          PickQ.Name = self.CurrentQuery
          get(PickQ, PickQ.Name)
          if ~errorcode()
            message('This Query name already exists!', 'Error!')
            select(?sQuery)
          else
            post(EVENT:CloseWindow)
          end
        end

      of ?btnCancel
        self.CurrentQuery = ''
        post(EVENT:CloseWindow)
      end
    end


cFilterList.Save                    procedure()

Entries     long
ndx         long

    code
    ! First, check if there some records in the Filter queue
    if ~(records(self.FilterQ))
      ! If there are no records, clear the CurrentQuery name
      self.CurrentQuery = ''
    else
      ! Check to see if the last row in FilterQ has DONE in it.
      get(self.FilterQ, records(self.FilterQ))
      if ~instring('DONE', upper(self.FilterQ.Connection), 1, 1)
        message('Query is not terminated by ''DONE'' or ''...) DONE''', 'Error!')
      else

        ! Now, check if there is a Current Query Name before saving

        if ~self.CurrentQuery
          self.AskQueryName()
        end

        if Self.CurrentQuery    ! Query has a name
          ! Delete the query in the registry or INI, if it is already existing
          Entries = 0   ! Give a default value for the INI Fetch
          Entries = self.INIMgr.TryFetch(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(self.CurrentQuery), 'ENTRIES')
          if Entries
            loop ndx = 1 to Entries
              self.INIMgr.Update(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(self.CurrentQuery), 'ENTRY_' & ndx, '')
            end
            self.INIMgr.Update(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(self.CurrentQuery), 'ENTRIES', 0)
          else
            ! Update the "Header"
            do AddToHeaderList
          end

          ! Save the query
          self.IniMgr.UpdateQ(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(self.CurrentQuery), self.FilterQ)
        end
      end
    end

AddToheaderList routine


    data

hEntries    long


    code
    hEntries = self.INIMgr.TryFetch(clip(self.AppName) & '_' & clip(self.ProcName) & '_QUERIES', 'ENTRIES')
    if hEntries
      hEntries += 1
    else
      hEntries = 1
    end
    self.INIMgr.Update(clip(self.AppName) & '_' & clip(self.ProcName) & '_QUERIES', 'ENTRIES', hEntries)
    self.INIMgr.Update(clip(self.AppName) & '_' & clip(self.ProcName) & '_QUERIES', 'ENTRY_' & hEntries, self.CurrentQuery)


cFilterList.SaveAS                  procedure()

TmpName     string(50)

    code

    if records(self.FilterQ)
      TmpName = self.CurrentQuery
      self.AskQueryName()
      if ~self.CurrentQuery
        self.CurrentQuery = TmpName
      else
        self.Save()
      end
    end

cFilterList.Load                    procedure()

PickQ       queue
Name          string(50)
EntryID       long
            end

Window WINDOW('Query List'),AT(,,283,135),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),CENTER,GRAY, |
         DOUBLE
       LIST,AT(8,8,266,95),USE(?List1),VSCROLL,ALRT(MouseLeft2),FORMAT('50L(2)|M~Query Name~@s50@'),FROM(PickQ)
       BUTTON('Select'),AT(130,108,45,14),USE(?btnSelect)
       BUTTON('Delete'),AT(180,108,45,14),USE(?btnDelete)
       BUTTON('Cancel'),AT(229,108,45,14),USE(?btnCancel)
     END


Entries     long
ndx         long

    code

    Entries = self.INIMgr.TryFetch(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & 'QUERIES', 'ENTRIES')
    if Entries
      loop ndx = 1 to Entries
        PickQ.Name = self.INIMgr.FetchField(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & 'QUERIES', 'ENTRY_' & ndx, 1)
        if PickQ.Name
          PickQ.EntryID = ndx
          add(PickQ)
        end
      end
    end

    if records(PickQ)
      open(window)
      accept
        case field()
        of ?btnDelete

          if event() = EVENT:Accepted
            if message('Please confirm!', 'Ok to delete this query?',, button:yes + button:no) = button:yes
              get(PickQ, choice(?List1))
              if ~errorcode()
                self.INIMgr.Update(clip(self.AppName) & '_' & clip(self.ProcName) & '_QUERIES', 'ENTRY_' & PickQ.EntryID, '')
                !delete(PickQ)
                display()

                Entries = self.INIMgr.TryFetch(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(PickQ.Name), 'ENTRIES')
                if Entries
                  loop ndx = 1 to Entries
                    self.INIMgr.Update(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(PickQ.Name), 'ENTRY_' & ndx, '')
                  end
                  self.INIMgr.Update(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(PickQ.Name), 'ENTRIES', '')
                end
              end
              delete(PickQ)
              if ~records(PickQ)
                disable(?btnDelete)
              else
                enable(?btnDelete)
              end
              display()
            end
          end

        of ?btnSelect
          if event() = EVENT:Accepted
            get(PickQ, choice(?List1))
            if ~errorcode()
              free(self.FilterQ)
              self.IniMgr.FetchQ(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(PickQ.Name), self.FilterQ)
              self.CurrentQuery = PickQ.Name
              post(EVENT:CloseWindow)
            end
          end

        of ?List1
          if event() = EVENT:PreAlertKey
            cycle
          end
          if event() = EVENT:Accepted
            if keycode() = MouseLeft2
              get(PickQ, choice(?List1))
              if ~errorcode()
                free(self.FilterQ)
                self.IniMgr.FetchQ(clip(self.AppName) & '_' & clip(self.ProcName) & '_' & clip(PickQ.Name), self.FilterQ)
                self.CurrentQuery = PickQ.Name
                post(EVENT:CloseWindow)
              end
            end
          end

        of ?btnCancel
          if event() = EVENT:Accepted
            post(EVENT:CloseWindow)
          end
        end
      end
    end

    return(0)



cFilterList.IFilter.Save            procedure(string pQueryName)

    code
    self.Save()



cFilterList.IFilter.SaveAs          procedure(string pQueryName)

    code
    self.SaveAS()


cFilterList.IFilter.Load            procedure(string pQueryName)

    code
    self.Load()

cFilterList.IFilter.GetFilter       procedure()

RetVal  byte

    code
!    if self.UseSQL
!      RetVal = SELF.GenerateSQL()
!    else
!      RetVal = self.GenerateFilter()
!    end
    RetVal = self.GenerateFilter()
    if RetVal = true
      return(self.SQLFilterStr)
    else
      return('')
    end


cFilterList.IFilter.AddCol          procedure(string pColName, string pColSQLName, long pDatatype, string pPicture, byte pCase)

    code

    clear(SELF.ColFilterQ)
    self.ColFilterQ.ColName_SQL &= null

    SELF.ColFilterQ.ColName = pColName
    SELF.ColFilterQ.ColName_SQL &= new(string(len(pColSQLName) + 1))
    SELF.ColFilterQ.ColName_SQL = pCOlSQLName
    SELF.ColFilterQ.ColDatatype = pDatatype
    SELF.ColFilterQ.ColPicture = pPicture
    SELF.ColFilterQ.CaseSensitive = pCase
    add(SELF.ColFilterQ)
    self.ColQ.ColName = pColName
    add(self.ColQ)


TColEditClass.CreateControl     procedure

    code
    self.Feq = create(0, CREATE:DropList)
    self.Feq{prop:from} = self.ColQ
    self.Feq{prop:VScroll} = true

TColEditClass.Destruct          procedure

    code
    self.ColQ &= null
    if self.Feq
      destroy(self.Feq)
    end

TColEditClass.SetAlerts         procedure

    code
    !SELF.Feq{PROP:Alrt,1} = TabKey
    SELF.Feq{PROP:Alrt,2} = ShiftTab
    SELF.Feq{PROP:Alrt,3} = EnterKey
    SELF.Feq{PROP:Alrt,4} = EscKey


TColOpeClass.CreateControl      procedure

    code
    self.Feq = create(0, CREATE:DropList)
    self.Feq{prop:from} = self.ColOpeQ
    self.Feq{prop:Format} = '100L(2)|M~Operator~@s25@'
    self.Feq{prop:VScroll} = true


TColOpeClass.SetAlerts PROCEDURE

    code

    !SELF.Feq{PROP:Alrt,1} = TabKey
    SELF.Feq{PROP:Alrt,2} = ShiftTab
    SELF.Feq{PROP:Alrt,3} = EnterKey
    SELF.Feq{PROP:Alrt,4} = EscKey


TColOpeClass.Destruct           procedure

    code
    self.ColOpeQ &= null
    if self.Feq
      destroy(self.Feq)
    end

TConnEditClass.CreateControl    procedure

    code
    self.Feq = create(0, CREATE:DropList)
    self.Feq{prop:from} = self.ConnOpeQ
    self.Feq{prop:VScroll} = true


TConnEditClass.SetAlerts        procedure

    code
    !SELF.Feq{PROP:Alrt,1} = TabKey
    SELF.Feq{PROP:Alrt,2} = ShiftTab
    SELF.Feq{PROP:Alrt,3} = EnterKey
    SELF.Feq{PROP:Alrt,4} = EscKey


TConnEditClass.Destruct         procedure

    code
    self.ConnOpeQ &= null
    if self.Feq
      destroy(self.Feq)
    end
