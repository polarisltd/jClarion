  MEMBER

  MAP
AddDollar     PROCEDURE(STRING Src),STRING
RemoveDollar  PROCEDURE(STRING Src),STRING
  END

  INCLUDE('CWSYNCHM.INC'),ONCE
  INCLUDE('CWSYNCHC.INC'),ONCE
  INCLUDE('ABUTIL.INC'),ONCE
  INCLUDE('ABUTIL.TRN'),ONCE
  INCLUDE('ABFILE.INC'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE


ConstDescriptorList QUEUE,TYPE
ItemType              BYTE
Destination           ANY
                    END

MaxTLen EQUATE(1024)

TranslatorQueue     QUEUE,TYPE
TextProp              CSTRING(MaxTLen)
Replacement           CSTRING(MaxTLen)
                    END


TypeMappingQueue    QUEUE,TYPE
ControlType           USHORT
Property              USHORT
                    END

INIUnknown          EQUATE('---Unknown---')


ConstantClass.ConstantClass PROCEDURE

  CODE
  SELF.Complete = False
  SELF.TerminatorField = 1                  ! C5 default
  SELF.TerminatorInclude = False            ! C5 default


ConstantClass.Init PROCEDURE(BYTE Termination)

  CODE
  SELF.Str &= NULL
  SELF.Descriptor &= NEW ConstDescriptorList
  SELF.Termination=Termination
  CLEAR(SELF.TerminatorValue)
  SELF.Reset


ConstantClass.Kill PROCEDURE

  CODE
  GET(SELF.Descriptor,1)
  LOOP WHILE ~ERRORCODE()
    SELF.Descriptor.Destination &= NULL
    GET(SELF.Descriptor,POINTER(SELF.Descriptor)+1)
  END
  DISPOSE(SELF.Descriptor)
  DISPOSE(SELF.Str)


ConstantClass.Reset PROCEDURE

  CODE
  SELF.RecordPnt=1
  SELF.CharPnt=1
  IF ~SELF.Str&=NULL
    CASE SELF.Termination
    OF Term:Byte
      SELF.Items=SELF.GetByte()
    OF Term:UShort
      SELF.Items=SELF.GetUShort()
    END
  ELSE
    SELF.Items=0
  END


ConstantClass.Set PROCEDURE(*STRING Src)

  CODE
  DISPOSE(SELF.Str)
  SELF.Str &= NEW STRING(LEN(Src))
  SELF.Str = Src
  SELF.SourceSize=LEN(SELF.Str)
  SELF.Reset


ConstantClass.AddItem PROCEDURE(BYTE ItemType,*? Dest)

  CODE
  CLEAR(SELF.Descriptor)
  SELF.Descriptor.ItemType=ItemType
  SELF.Descriptor.Destination &= Dest
  ADD(SELF.Descriptor)
? ASSERT(~ERRORCODE())


ConstantClass.Next PROCEDURE

  CODE
  IF SELF.complete THEN RETURN Level:Notify.
  CASE SELF.Termination
  OF Term:Byte
  OROF Term:UShort
    IF SELF.RecordPnt>SELF.Items
      SELF.complete = True
      RETURN Level:Notify
    end
  OF Term:EndGroup
    IF SELF.CharPnt>SELF.SourceSize
      SELF.complete = True
      RETURN Level:Notify
    end
  END
  GET(SELF.Descriptor,1)
  LOOP WHILE ~ERRORCODE()
    CASE SELF.Descriptor.ItemType
    OF ConstType:CString
      SELF.Descriptor.Destination=SELF.GetCString()
    OF ConstType:PString
      SELF.Descriptor.Destination=SELF.GetPString()
    OF ConstType:Byte
      SELF.Descriptor.Destination=SELF.GetByte()
    OF ConstType:Short
      SELF.Descriptor.Destination=SELF.GetShort()
    OF ConstType:UShort
      SELF.Descriptor.Destination=SELF.GetUShort()
    OF ConstType:Long
      SELF.Descriptor.Destination=SELF.GetLong()
    ELSE
?     ASSERT(False)
    END
    IF POINTER(SELF.Descriptor) = SELF.TerminatorField AND SELF.Termination = Term:FieldValue AND SELF.Descriptor.Destination = SELF.TerminatorValue
      SELF.complete = true
      IF ~SELF.TerminatorInclude THEN RETURN Level:Notify.
    END
    GET(SELF.Descriptor,POINTER(SELF.Descriptor)+1)
  END
  IF SELF.Termination = Term:FieldValue AND SELF.complete AND ~SELF.TerminatorInclude THEN RETURN Level:Notify.
  SELF.RecordPnt+=1
  RETURN Level:Benign


ConstantClass.Next PROCEDURE(QUEUE Q)

  CODE
  SELF.Reset
  LOOP WHILE SELF.Next()=Level:Benign
    ADD(Q)
?   ASSERT(~ERRORCODE())
  END


ConstantClass.Next PROCEDURE(FILE F)

  CODE
  SELF.Reset
  LOOP WHILE SELF.Next()=Level:Benign
    ADD(F)
?   ASSERT(~ERRORCODE())
  END


ConstantClass.GetByte PROCEDURE()

RVal  BYTE,AUTO

  CODE
? ASSERT(SELF.CharPnt<=LEN(SELF.Str))     !Exceeded limit of source string, probable descriptor/group structure layout mismatch
  RVal=VAL(SELF.Str[SELF.CharPnt])
  SELF.CharPnt+=1
  RETURN RVal


ConstantClass.GetUShort PROCEDURE()

RVal USHORT,AUTO

  CODE
  RVal=SELF.GetByte()
  RETURN RVal+BSHIFT(SELF.GetByte(),8)


ConstantClass.GetShort PROCEDURE()

RVal  SHORT,AUTO

  CODE
  RVal=SELF.GetUShort()            !Req'd for type conversion
  RETURN RVal


ConstantClass.GetLong PROCEDURE()

RVal  LONG,AUTO

  CODE
  RVal=SELF.GetUShort()
  RETURN RVal+BSHIFT(SELF.GetShort(),16)


ConstantClass.GetPString PROCEDURE()

i     BYTE,AUTO
RVal  STRING(256),AUTO

  CODE
  LOOP i=1 TO SELF.GetByte()
    RVal[i]=CHR(SELF.GetByte())
  END
  RETURN SUB(RVal,1,i-1)


ConstantClass.GetCString PROCEDURE()

b     BYTE,AUTO
Cnt   USHORT(0)
RVal  CSTRING(1024),AUTO

  CODE
  LOOP
    b=SELF.GetByte()
    IF ~b
      BREAK
    ELSE
      Cnt+=1
      RVal[Cnt]=CHR(b)
    END
  END
  RETURN SUB(RVal,1,Cnt)



! FieldPairs class. Manages a queue with two pairs of fields
FieldPairsClass.AddItem PROCEDURE(*? Left)
  CODE
    ASSERT(~(SELF.List &= NULL))
    CLEAR(SELF.List)
    SELF.List.Left &= Left
    SELF.List.Right = Left
    ADD(SELF.List)

FieldPairsClass.AddPair PROCEDURE(*? Left,*? Right)
  CODE
    ASSERT(~(SELF.List &= NULL))
    CLEAR(SELF.List)
    SELF.List.Left &= Left
    SELF.List.Right &= Right
    ADD(SELF.List)

FieldPairsClass.AssignLeftToRight PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      SELF.List.Right = SELF.List.Left
      PUT(SELF.List)
    END

FieldPairsClass.AssignRightToLeft PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      SELF.List.Left = SELF.List.Right
      PUT(SELF.List)
    END

FieldPairsClass.ClearLeft PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      CLEAR(SELF.List.Left)
    END

FieldPairsClass.ClearRight PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      CLEAR(SELF.List.Right)
    END

FieldPairsClass.EqualLeftRight PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      IF SELF.List.Left <> SELF.List.Right
        RETURN 0
      END
    END
    RETURN 1

FieldPairsClass.Equal PROCEDURE
  CODE
    RETURN SELF.EqualLeftRight()

FieldPairsClass.Kill PROCEDURE
  CODE
  IF ~SELF.List &= NULL
    GET(SELF.List,1)
    LOOP WHILE ~ERRORCODE()
      SELF.List.Left &= NULL
      SELF.List.Right &= NULL
      GET(SELF.List,POINTER(SELF.List)+1)
    END
    DISPOSE(SELF.List)
  END

FieldPairsClass.Init PROCEDURE
  CODE
    SELF.Kill
    SELF.List &= NEW FieldPairsQueue

! BufferedPairs class. Manages a queue with two pairs of fields
BufferedPairsClass.AddPair PROCEDURE(*? Left,*? Right)
Temp ANY
  CODE
    ASSERT(~(SELF.List &= NULL))
    CLEAR(SELF.List)
    SELF.List.Left &= Left
    SELF.List.Right &= Right
    Temp = Right                   ! Make sure Buffer has correct type
    CLEAR(Right)
    SELF.RealList.Buffer = Right
    Right = Temp
    ADD(SELF.List)

BufferedPairsClass.AssignLeftToBuffer PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      SELF.RealList.Buffer = SELF.List.Left
      PUT(SELF.RealList)
    END

BufferedPairsClass.AssignRightToBuffer PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      SELF.RealList.Buffer = SELF.List.Right
      PUT(SELF.RealList)
    END

BufferedPairsClass.AssignBufferToLeft PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      SELF.List.Left = SELF.RealList.Buffer
      PUT(SELF.RealList)
    END

BufferedPairsClass.AssignBufferToRight PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      SELF.List.Right = SELF.RealList.Buffer
      PUT(SELF.RealList)
    END

BufferedPairsClass.EqualLeftBuffer PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      IF SELF.RealList.Left <> SELF.RealList.Buffer
        RETURN 0
      END
    END
    RETURN 1

BufferedPairsClass.EqualRightBuffer PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.List)
      GET(SELF.List,I)
      IF SELF.RealList.Right <> SELF.RealList.Buffer
        RETURN 0
      END
    END
    RETURN 1

BufferedPairsClass.Kill PROCEDURE
  CODE
  IF ~SELF.RealList&=NULL
    GET(SELF.RealList,1)
    LOOP WHILE ~ERRORCODE()
      SELF.RealList.Left &= NULL
      SELF.RealList.Right &= NULL
      SELF.RealList.Buffer &= NULL
      GET(SELF.RealList,POINTER(SELF.RealList)+1)
    END
    DISPOSE(SELF.RealList)
  END
  SELF.List &= SELF.RealList

BufferedPairsClass.Init PROCEDURE
  CODE
    SELF.Kill
    SELF.RealList &= NEW BufferedPairsQueue
    SELF.List &= SELF.RealList
















INIClass.Construct procedure

  CODE
  SELF.critSect &= NewCriticalSection()


INIClass.Destruct procedure

  CODE
  SELF.critSect.kill()


INIClass.Init PROCEDURE(STRING S)
  CODE
  SELF.Init(S, NVD_INI)


INIClass.Init PROCEDURE(STRING s, UNSIGNED nvType, LONG extraData)

  CODE
  SELF.extraData = extraData
  SELF.nvType = nvType
  SELF.FileName = S
  SELF.Sectors &= NEW SectorQueue 
  SELF.Fetch
  SELF.FetchQueue('__Dont_Touch_Me__','Sectors',SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type) !***


INIClass.Kill PROCEDURE

critProc  CriticalProcedure

  CODE
  critProc.init(SELF.critSect)
  SELF.UpdateQueue('__Dont_Touch_Me__','Sectors',SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type) !***
  IF  NOT SELF.Sectors &= NULL
    DISPOSE(SELF.Sectors)
    SELF.Sectors &= NULL
  END



INIClass.GetSector PROCEDURE(STRING Family, STRING Item, STRING Type)

critProc  CriticalProcedure

  CODE
  critProc.init(SELF.critSect)
  RETURN Family & '$' & AddDollar(Item) & '$$' & Type   ! *** Primary to make getfamily easy


INIClass.GetFamily PROCEDURE(STRING Sector, *CSTRING Family, *CSTRING Item, *CSTRING Type)

critProc  CriticalProcedure
FP        UNSIGNED,AUTO
SP        UNSIGNED,AUTO

  CODE
  critProc.init(SELF.critSect)
  FP = INSTRING('$',Sector,1,1)
  SP = INSTRING('$$',Sector,1,1)
  LOOP
   IF Sector[SP+2] = '$' ! Used $ in Item Text
      SP = INSTRING('$$',Sector,1,SP+3)
      CYCLE
   END
   BREAK
  END
? ASSERT(FP > 1 AND SP < LEN(Sector) AND SP > FP+1)
  Family = Sector[1:FP-1]
  Item = Sector[FP+1:SP-1]       !*** More - maybe, consider null items
  Type = Sector[SP+2:LEN(Sector)]


INIClass.AddSector PROCEDURE(STRING Sector)

critProc  CriticalProcedure

  CODE
  critProc.init(SELF.critSect)
  SELF.GetFamily(Sector,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  GET(SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  IF ERRORCODE()
    ADD(SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  END


INIClass.DeleteSector PROCEDURE(STRING Sector)

critProc  CriticalProcedure

  CODE
  critProc.init(SELF.critSect)
  SELF.GetFamily(Sector,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  GET(SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  IF ~ERRORCODE()
    DELETE(SELF.Sectors)
  END


INIClass.GetSectors PROCEDURE(<STRING Family>, <STRING Item>, <STRING Type>, SectorQueue SQ)

critProc  CriticalProcedure
I         USHORT,AUTO

  CODE
  critProc.init(SELF.critSect)
  FREE(SQ)     !**** Could be dodgy, maybe we should append? !** Possibly, need to keep an eye on it.
  LOOP I = 1 TO RECORDS(SELF.Sectors)
    GET(SELF.Sectors,I)
    IF Family AND Family<>SELF.Sectors.Family THEN CYCLE .  !*** We could optimise this using the sorted queue get syntax (Get(,SELF.Sectors.Family etc)
    IF Item AND Item<>SELF.Sectors.Item THEN CYCLE .        !*** If we can be bothered
    IF Type AND Type<>SELF.Sectors.Type THEN CYCLE .        !*** Nope, me neither
    SQ = SELF.Sectors
    SQ.Item = RemoveDollar(SELF.Sectors.Item)
    ADD(SQ)
  END


INIClass.Fetch PROCEDURE(STRING Sector, STRING Name, STRING Default, STRING Filename)

critProc  CriticalProcedure
RVal      CSTRING(1024),AUTO

  CODE
  critProc.init(SELF.critSect)
  CASE(SELF.nvType)
  OF NVD_INI
    RVal = GETINI(Sector, Name, Default, Filename)
  OF NVD_Registry
    RVal = GETREG(CHOOSE(SELF.extraData = 0, REG_CLASSES_ROOT, SELF.extraData), CHOOSE(SELF.Filename = '', Sector, SELF.Filename & '\' & Sector), Name)
    IF RVal = '' THEN RVal = Default.
  OF NVD_Table
    ASSERT(FALSE, 'NV_Table: Not Supported Yet')
    RVal = ''
  END
  RETURN RVal


INIClass.Update PROCEDURE(STRING Sector, STRING Name, STRING Value, STRING Filename)

critProc  CriticalProcedure

  CODE
  critProc.init(SELF.critSect)
  CASE(SELF.nvType)
  OF NVD_INI
    PUTINI(Sector, Name, Value, Filename)
  OF NVD_Registry
    IF Value = ''            ! Setting a 'null' value may as well be a delete
      SELF.Remove (Sector, Name)
    ELSE
      PUTREG(CHOOSE(SELF.extraData = 0, REG_CLASSES_ROOT, SELF.extraData), CHOOSE(SELF.Filename = '', Sector, SELF.Filename & '\' & Sector), Name, Value)
    END
  OF NVD_Table
    ASSERT(FALSE, 'NV_Table: Not Supported Yet')
  END

INIClass.Remove PROCEDURE (STRING Sector, STRING Name)

critProc  CriticalProcedure

  CODE
  critProc.init(SELF.critSect)

  CASE(SELF.nvType)
  OF NVD_INI
    PUTINI(Sector, Name,, SELF.Filename)
  OF NVD_Registry
    DELETEREG(CHOOSE(SELF.extraData = 0, REG_CLASSES_ROOT, SELF.extraData), CHOOSE(SELF.Filename = '', Sector, SELF.Filename & '\' & Sector), Name)
  OF NVD_Table
    ASSERT(FALSE, 'NV_Table: Not Supported Yet')
  END

INIClass.Update PROCEDURE

  CODE


INIClass.Fetch PROCEDURE

  CODE


INIClass.Update PROCEDURE(STRING Sec,STRING Name,STRING Value)

critProc  CriticalProcedure

  CODE
  critProc.init(SELF.critSect)
  SELF.Update(Sec, Name, Value, SELF.FileName)


INIClass.Fetch PROCEDURE(STRING Sec,STRING Name,*? Value)

critProc  CriticalProcedure

  CODE
  critProc.init(SELF.critSect)
  Value = SELF.Fetch(Sec, Name, Value, SELF.FileName)


INIClass.TryFetch PROCEDURE(STRING Sec,STRING Name)

  CODE
  RETURN SELF.Fetch(Sec, Name, '', SELF.FileName)


INIClass.Fetch PROCEDURE(STRING Sec,STRING Name)

critProc  CriticalProcedure
Res       CSTRING(1000),AUTO

  CODE
  critProc.init(SELF.critSect)
  Res = SELF.Fetch(Sec, Name, INIUnknown, SELF.Filename)
  ASSERT(Res <> INIUnknown, 'INI Assert: Could not find ' & Name & ' in sector ' & Sec & ' of ' & SELF.Filename)
  RETURN Res


INIClass.FetchField PROCEDURE(STRING Sec,STRING Name,BYTE Field)

critProc  CriticalProcedure
Res       CSTRING(1000),AUTO
I         USHORT,AUTO
Finger    USHORT(1)

  CODE
  critProc.init(SELF.critSect)
  Res = SELF.Fetch(Sec,Name)
  LOOP WHILE Field > 1
    Finger = INSTRING(',',Res,1,Finger)
    ASSERT(Finger)
    Finger += 1
    Field -= 1
  END
  I = INSTRING(',',Res,1,Finger)
  RETURN Res[Finger : CHOOSE(I = 0,LEN(Res),I-1) ]


INIClass.TryFetchField PROCEDURE(STRING Sec,STRING Name,BYTE Field)

critProc  CriticalProcedure
Res       CSTRING(1000),AUTO
I         USHORT,AUTO
Finger    USHORT(1)

  CODE
  critProc.init(SELF.critSect)
  Res = SELF.TryFetch(Sec,Name)
  IF ~Res THEN RETURN '' .
  LOOP WHILE Field > 1
    Finger = INSTRING(',',Res,1,Finger)
    IF ~Finger THEN RETURN '' .
    Finger += 1
    Field -= 1
  END
  I = INSTRING(',',Res,1,Finger)
  RETURN Res[Finger : CHOOSE(I = 0,LEN(Res),I-1) ]


! Queue Layout :
! [Sector]
! Name = ItemsInQueue
! Name_1 = F1,F2,F3 etc
INIClass.FetchQueue PROCEDURE(STRING Sector,STRING Name,QUEUE Q,*? F1,<*? F2>,<*? F3>,<*? F4>)

critProc  CriticalProcedure
NItems    USHORT,AUTO
I         USHORT,AUTO

  CODE
  critProc.init(SELF.critSect)
  NItems = SELF.TryFetch(Sector,Name)
  LOOP I = 1 TO NItems
    F1 = SELF.FetchField(Sector,Name&'_'&I,1)
    IF ~OMITTED(6)
      F2 = SELF.FetchField(Sector,Name&'_'&I,2)
    END
    IF ~OMITTED(7)
      F3 = SELF.FetchField(Sector,Name&'_'&I,3)
    END
    IF ~OMITTED(8)
      F4 = SELF.FetchField(Sector,Name&'_'&I,4)
    END
    ADD(Q)
  END


INIClass.UpdateQ PROCEDURE(string pSection, *queue pQ)

critProc  CriticalProcedure
NbrOfRec  long
EntryStr  string('ENTRY_')
ValueStr  cstring(1000)
QField    any
ndx       long
FldNdx    long

    CODE
    critProc.init(SELF.critSect)
    NbrOfRec = records(pQ)
    SELF.Update(pSection, 'Entries', NbrOfRec)
    ndx = 1
    loop
      get(pQ, ndx)
      if ~errorcode()

        ValueStr = ''
        FldNdx = 1

        loop
          QField &= null
          QField &= what(pQ, FldNdx)
          if ~QField &= null
            if ValueStr
              if instring(',', QField, 1, 1)
                ValueStr = clip(ValueStr) & ',[' & clip(QField) & ']'
              else
                ValueStr = clip(ValueStr) & ',' & QField
              end
            else
              if instring(',', QField, 1, 1)
                ValueStr = '[' & clip(QField) & ']'
              else
                ValueStr = QField
              end
            end
            FldNdx += 1
          else
            break
          end
        end

        self.Update(pSection, EntryStr & ndx, ValueStr)
        ndx += 1

      else
        break
      end
    end


INIClass.FetchQ procedure(string pSection, *queue pQ)

critProc  CriticalProcedure
NbrOfRec  long
EntryStr  string('ENTRY_')
ValueStr  cstring(1000)
FldNdx    long
ndx       long

    code
    critProc.init(SELF.critSect)
    free(pQ)
    NbrOfRec = self.Fetch(pSection, 'Entries')
    if NbrOfRec
      loop ndx = 1 to NbrOfRec
        ValueStr = self.Fetch(pSection, EntryStr & ndx)
        if ValueStr
          FldNdx = 1
          self.ParseStr(ValueStr, pQ, FldNdx)
          add(pQ)
        end
      end
    end


INIClass.ParseStr procedure(string szValue, *queue pQ, FldNbr)

Pos       long
AField    any

    code
    AField &= null
    AField &= what(pq, FldNbr)
    if ~(AField &= null)
      if szValue[1] = '['
        Pos = instring(']', szValue, 1, 1)
        if pos
          AField = szValue[2 : pos - 1]
          Pos = instring(',', szValue, 1, Pos +  1)  ! Make sure that pos will point to next comma after the ]
        end
      else
        Pos = instring(',', szValue, 1, 1)
        if Pos
          AField = szValue[1 : pos - 1]
        else
          AField = szValue
        end
      end
      if Pos
        if szValue[Pos + 1 : len(szValue)]
          self.ParseStr(szValue[Pos + 1 : len(szValue)], pQ, FldNbr + 1)
        end
      end
    end


INIClass.UpdateQueue PROCEDURE(STRING Sector,STRING Name,QUEUE Q,*? F1,<*? F2>,<*? F3>,<*? F4>)

critProc  CriticalProcedure
I         USHORT,AUTO
st        CSTRING(5000),AUTO

  CODE
  critProc.init(SELF.critSect)
  SELF.Update(Sector,Name,RECORDS(Q))
  LOOP I = 1 TO RECORDS(Q)
    GET(Q,I)
    St = F1
    IF ~OMITTED(6)
      St = St & ',' & F2
    END
    IF ~OMITTED(7)
      St = St & ',' & F3
    END
    IF ~OMITTED(8)
      St = St & ',' & F4
    END
    SELF.Update(Sector,Name&'_'&I,St)
  END


INIClass.Update PROCEDURE (STRING ProcedureName, WINDOW W)

Info      LIKE(WindowInfo),AUTO

  CODE
  Info.Maximized = CHOOSE (W {PROP:Maximize} <> 0)
  Info.Minimized = CHOOSE (W {PROP:Iconize} <> 0)

  Info.X = _nopos
  Info.Y = _nopos
  Info.W = _nopos
  Info.H = _nopos

  IF NOT Info.Minimized AND NOT Info.Maximized
    Info.X = W {PROP:XPos}
    Info.Y = W {PROP:YPos}
  
    IF W {PROP:Resize}
      Info.W = W {PROP:Width}
      Info.H = W {PROP:Height}
    END
  END

  SELF.UpdateWindowInfo (ProcedureName, Info)
  RETURN

INIClass.UpdateWindowInfo PROCEDURE (STRING ProcedureName, *WindowInfo Info)

critProc  CriticalProcedure,AUTO

   CODE
   critProc.Init (SELF.critSect)

   SELF.Update (ProcedureName, 'Maximize', CHOOSE (NOT Info.Maximized, 'No', 'Yes'))
   SELF.Update (ProcedureName, 'Minimize', CHOOSE (NOT Info.Minimized, 'No', 'Yes'))

   IF Info.X = _nopos
     SELF.Remove (ProcedureName, 'XPos')
   ELSE
     SELF.Update (ProcedureName, 'XPos', Info.X)
   END
   IF Info.Y = _nopos
     SELF.Remove (ProcedureName, 'YPos')
   ELSE
     SELF.Update (ProcedureName, 'YPos', Info.Y)
   END
   IF Info.W = _nopos
     SELF.Remove (ProcedureName, 'Width')
   ELSE
     SELF.Update (ProcedureName, 'Width', Info.W)
   END
   IF Info.H = _nopos
     SELF.Remove (ProcedureName, 'Height')
   ELSE
     SELF.Update (ProcedureName, 'Height', Info.H)
   END
   RETURN

INIClass.Fetch PROCEDURE (STRING ProcedureName, WINDOW W)

Info      LIKE(WindowInfo),AUTO
IsMax     BYTE,AUTO

  CODE
  SELF.FetchWindowInfo (ProcedureName, Info)

  IF Info.Got
    IsMax = W {PROP:Maximize}

    IF NOT Info.Maximized AND IsMax
      W {PROP:Maximize} = FALSE
    END

    W {PROP:XPos} = Info.X
    W {PROP:YPos} = Info.Y

    IF W {PROP:Resize}
      IF Info.W <> _nopos
        W {PROP:Width} = Info.W
      END
      IF Info.H <> _nopos
        W {PROP:Height} = Info.H
      END
    END

    IF Info.Maximized AND NOT IsMax
      W {PROP:Maximize} = TRUE
    END

    W {PROP:Iconize} = Info.Minimized
  END

INIClass.FetchWindowInfo PROCEDURE (STRING ProcedureName, *WindowInfo Info)

critProc  CriticalProcedure,AUTO

  CODE
  critProc.Init (SELF.critSect)

  CASE SELF.TryFetch (ProcedureName, 'Maximize')
  OF 'No'
    Info.Maximized = FALSE
  OF 'Yes'
    Info.Maximized = TRUE
  ELSE
    Info.Got = FALSE
    RETURN
  END

  Info.Minimized = FALSE
  SELF.Fetch (ProcedureName, 'Minimize', Info.Minimized)

  Info.X = _nopos
  Info.Y = _nopos
  Info.W = _nopos
  Info.H = _nopos

  SELF.Fetch (ProcedureName, 'XPos', Info.X)
  SELF.Fetch (ProcedureName, 'YPos', Info.Y)
  SELF.Fetch (ProcedureName, 'Width', Info.W)
  SELF.Fetch (ProcedureName, 'Height', Info.H)

  Info.Got = TRUE
  RETURN


AddDollar PROCEDURE(STRING Src)

Hold  STRING(1024),AUTO
SP    UNSIGNED,AUTO
TP    UNSIGNED(0)

  CODE
  LOOP SP = 1 TO LEN(SRC)
    IF Src[SP] = '$' 
      TP += 2
      Hold[TP-1] = '$'
      Hold[TP] = '$'
    END
    TP += 1
    Hold[TP] = Src[SP]
  END
  RETURN Hold [1 : TP]


RemoveDollar PROCEDURE(STRING Src)

Hold  STRING(1024),AUTO
SP    UNSIGNED,AUTO
TP    UNSIGNED,AUTO
L     UNSIGNED,AUTO

  CODE
  TP = 0
  SP = 0
  L  = LEN (Src)

  LOOP WHILE SP < L
     TP += 1
     SP += 1
     IF Src[SP] = '$'
       IF SP + 2 <= L
         IF Src[SP+1] = '$' AND Src[SP+2] = '$'
           SP += 2
         END
       END
     END
     Hold[TP] = Src[SP]
  END
  IF TP = 0
    RETURN ''
  END
  RETURN Hold [1 : TP]



SelectFileClass.Init PROCEDURE

   CODE
   SELF.WindowTitle=Dfl:DefaultWindowTitle
   SELF.Flags=Dfl:DefaultFlags


SelectFileClass.AddMask PROCEDURE(STRING FileMasks)

  CODE
  IF FileMasks
    IF SELF.MaskString
      SELF.MaskString=CLIP(SELF.MaskString)&'|'&CLIP(FileMasks)
    ELSE
      SELF.MaskString=FileMasks
    END
  END


SelectFileClass.AddMask PROCEDURE(STRING Description,STRING Pattern)

  CODE
? ASSERT(~INSTRING('|',Description,1,1) AND ~INSTRING('|',Pattern,1,1))
  SELF.AddMask(CLIP(Description)&'|'&Pattern)


SelectFileClass.SetMask PROCEDURE(STRING Description,STRING Pattern)

  CODE
? ASSERT(~INSTRING('|',Description,1,1) AND ~INSTRING('|',Pattern,1,1))
  SELF.SetMask(CLIP(Description)&'|'&Pattern)


SelectFileClass.SetMask PROCEDURE(STRING FileMask)

  CODE
  CLEAR(SELF.MaskString)
  SELF.AddMask(FileMask)


SelectFileClass.Ask PROCEDURE(BYTE KeepDir=0)

Result    CSTRING(File:MaxFilePath)

  CODE
  IF KeepDir THEN SELF.SavePath=PATH().
  IF LEN(SELF.DefaultDirectory) THEN SETPATH(SELF.DefaultDirectory).
  Result=SELF.DefaultFile
  IF ~FILEDIALOG(SELF.WindowTitle,Result,CHOOSE(SELF.MaskString='',Dfl:DefaultFileMask,SELF.MaskString),SELF.Flags) THEN CLEAR(Result).
  IF KeepDir THEN SETPATH(SELF.SavePath).
  RETURN Result


SelectFileClass.Ask   PROCEDURE(SelectFileQueue DFQ,BYTE KeepDir=0)

ActualFlags BYTE,AUTO
Found       CSTRING(10000),AUTO
Path        CSTRING(File:MaxFilePath),AUTO
Separator   STRING(1),AUTO
Pos         UNSIGNED,AUTO
NameStart   UNSIGNED,AUTO

  CODE
  FREE(DFQ)
  IF KeepDir THEN SELF.SavePath=PATH().
  IF LEN(SELF.DefaultDirectory) THEN SETPATH(SELF.DefaultDirectory).
  Found=SELF.DefaultFile
  ActualFlags=BOR(SELF.Flags,FILE:Multi)
  ActualFlags=BAND(ActualFlags,255-FILE:Save)                 !Save dialog not allowed with mutli select
  IF FILEDIALOG(SELF.WindowTitle,Found,CHOOSE(SELF.MaskString='',Dfl:DefaultFileMask,SELF.MaskString),ActualFlags)
    Separator=CHOOSE(BAND(ActualFlags,FILE:LongName)=0,' ','|')
    Pos=INSTRING(Separator,Found,1,1)
    IF Pos                                 !Multi-Selected files
      ASSERT(Pos > 1)
      Path = CHOOSE(Found[Pos-1] <> '\', Found[1 : Pos-1]&'\', Found[1 : Pos-1])
      LOOP
        NameStart = Pos+1
        Pos = INSTRING(Separator,Found,1,NameStart)
        IF ~Pos THEN Pos=LEN(Found)+1.
        DFQ.Name = Path&Found[NameStart : Pos-1]
        DO GetShortName
        ADD(DFQ)
?       ASSERT(~ERRORCODE())
      WHILE Pos<=LEN(Found)
    ELSE
      DFQ.Name=Found                                  !Single file only selected
      DO GetShortName
      ADD(DFQ)
?     ASSERT(~ERRORCODE())
    END
  END
  IF KeepDir THEN SETPATH(SELF.SavePath).

GetShortName ROUTINE
  DFQ.ShortName = CHOOSE(BAND(ActualFlags,FILE:LongName)=0,'',SHORTPATH(DFQ.Name))



TranslatorClass.Init PROCEDURE

Cnst ConstantClass

   CODE
   SELF.Queue &= NEW TranslatorQueue
   SELF.TypeMapping &= NEW TypeMappingQueue
   SELF.AddTranslation(Translation)
   Cnst.Init(Term:EndGroup)
   Cnst.AddItem(ConstType:Ushort,SELF.TypeMapping.ControlType)
   Cnst.AddItem(ConstType:Ushort,SELF.TypeMapping.Property)
   Cnst.Set(TranslatorTypeMappings)
   Cnst.Next(SELF.TypeMapping)
   Cnst.Kill
   SORT(SELF.TypeMapping,SELF.TypeMapping.Controltype)


TranslatorClass.AddTranslation PROCEDURE(TranslatorGroup TG)

Cnst    ConstantClass
Text     CSTRING(MaxTLen),AUTO
Repl     CSTRING(MAXTlen),AUTO

  CODE
  Cnst.Init
  Cnst.AddItem(ConstType:PString,Text)
  Cnst.AddItem(ConstType:PString,Repl)
  Cnst.Set(TG)
  LOOP WHILE Cnst.Next()=Level:Benign
    SELF.AddTranslation(Text,Repl)
  END
  Cnst.Kill


TranslatorClass.Kill PROCEDURE

ExtractFilename CSTRING(FILE:MaxFilePath),AUTO,STATIC
ExtractFile     FILE,DRIVER('ASCII'),NAME(ExtractFilename),CREATE
                  RECORD
Line                STRING(MaxTLen)
                  END
                END
c               LONG,AUTO
d               USHORT,AUTO
Items           LONG

  CODE
  IF SELF.ExtractText
    ExtractFilename=SELF.ExtractText
    CREATE(ExtractFile)
    ASSERT(~ERRORCODE())
    OPEN(ExtractFile)
    ASSERT(~ERRORCODE())
    SELF.ExtractText=NAME(ExtractFile)                            !Fully qualifies file name
    GET(SELF.Queue,1)
    LOOP WHILE ~ERRORCODE()
      IF ~SELF.Queue.Replacement THEN Items+=1.
      GET(SELF.Queue,POINTER(SELF.Queue)+1)
    END
    d=INSTRING('.',SELF.ExtractText,1,1)
    IF ~d THEN d=LEN(SELF.ExtractText)+1.
    LOOP c=CHOOSE(d<=LEN(SELF.ExtractText),d,d-1) TO 0 BY -1
      IF c AND SELF.ExtractText[c]='\' THEN BREAK.
    END
    ExtractFile.Line=SUB(SELF.ExtractText[c+1 : d-1],1,8)&' GROUP'
    DO AddLine
    ExtractFile.Line='Items      USHORT('&Items&')'
    DO AddLine
    GET(SELF.Queue,1)
    LOOP WHILE ~ERRORCODE()
      IF ~SELF.Queue.Replacement
        ExtractFile.Line=ALL(' ',11)&'PSTRING('''&CLIP(SELF.Queue.TextProp)&''')'
        DO AddLine
        ExtractFile.Line=ALL(' ',11)&'PSTRING('''')'
        DO AddLine
      END
      GET(SELF.Queue,POINTER(SELF.Queue)+1)
    END
    ExtractFile.Line='   END'
    DO AddLine
    CLOSE(ExtractFile)
    ASSERT(~ERRORCODE())
  END
  DISPOSE(SELF.Queue)
  DISPOSE(SELF.TypeMapping)

AddLine ROUTINE
  ADD(ExtractFile)
  ASSERT(~ERRORCODE())


TranslatorClass.AddTranslation PROCEDURE(STRING Source,STRING Replacement)

  CODE
  ASSERT(~SELF.Queue&=NULL)
  IF LEN(Source)
    SELF.Queue.TextProp=Source
    GET(SELF.Queue,SELF.Queue.TextProp)
    IF ERRORCODE()
      SELF.Queue.TextProp=Source
      SELF.Queue.Replacement=Replacement
      ADD(SELF.Queue,SELF.Queue.TextProp)
      ASSERT(~ERRORCODE())
    ELSE
      SELF.Queue.Replacement=Replacement
      PUT(SELF.Queue,SELF.Queue.TextProp)
      ASSERT(~ERRORCODE())
    END
  END


TranslatorClass.TranslateWindow PROCEDURE(<WINDOW Win>)

ThisField SIGNED(0)

  CODE
  Win{PROP:Text}=SELF.TranslateString(Win{PROP:Text})
  LOOP
    ThisField=Win{PROP:NextField,ThisField}
    IF ThisField
      SELF.TranslateControl(ThisField,Win)
    ELSE
      BREAK
    END
  END


TranslatorClass.TranslateControls PROCEDURE(SHORT LowCtlID,SHORT HighCtlID,<WINDOW Win>)

ThisField SIGNED(0)

  CODE
  LOOP
    ThisField=Win{PROP:NextField,ThisField}
    IF ThisField AND INRANGE(ThisField,LowCtlID,HighCtlID)
      SELF.TranslateControl(ThisField,Win)
    ELSE
      BREAK
    END
  END


TranslatorClass.TranslateControl PROCEDURE(SHORT CtlID,<WINDOW Win>)

ColCnt    USHORT(1)
CtrlType  USHORT,AUTO
BeforeText ANY

   CODE
   ASSERT(~SELF.TypeMapping&=NULL)
   CtrlType=Win$CtlId{PROP:Type}
   SELF.TypeMapping.ControlType=CtrlType
   GET(SELF.TypeMapping,SELF.TypeMapping.ControlType)
   LOOP WHILE ~ERRORCODE() AND SELF.TypeMapping.ControlType=CtrlType
     SELF.TranslateProperty(SELF.TypeMapping.Property,CtlId,Win)
     GET(SELF.TypeMapping,POINTER(SELF.TypeMapping)+1)
   END
   IF INLIST(CtrlType,CREATE:List,CREATE:Combo,CREATE:DropList,CREATE:DropCombo)
     LOOP WHILE Win$CtlId{PROPList:Exists,ColCnt}=True
       BeforeText = Win$CtlID{PROPList:Header,ColCnt}
       IF (BeforeText <> '')
         Win$CtlId{PROPList:Header,ColCnt}=SELF.TranslateString(BeforeText)
       END
       BeforeText = Win$CtlID{PROPList:Header+PROPList:Group,ColCnt}
       IF (BeforeText <> '')
         Win$CtlId{PROPList:Header+PROPList:Group,ColCnt}=SELF.TranslateString(BeforeText)
       END
       ColCnt+=1
     END
   END


TranslatorClass.TranslateProperty PROCEDURE(USHORT Property,SHORT CtrlId,<WINDOW Win>)

  CODE
  Win$CtrlId{Property}=SELF.TranslateString(Win$CtrlId{Property})


TranslatorClass.TranslateString PROCEDURE (STRING LookFor)

Str      &STRING,AUTO
RVal     STRING(MaxTLen),AUTO
L        UNSIGNED,AUTO

  CODE
  Str &= LookFor
  L = SELF.Translate (Str, RVal, 0)
  RETURN CHOOSE (L = 0, '', RVal [1 : L])


TranslatorClass.Translate PROCEDURE (*STRING Str, *STRING RVal, UNSIGNED Level)

S        &STRING,AUTO
i1       UNSIGNED,AUTO
i2       UNSIGNED,AUTO
finger   UNSIGNED,AUTO

  CODE
  IF  NOT Str
    i2 = CHOOSE (SIZE(RVal) < SIZE(Str), SIZE(RVal), SIZE(Str))
    LOOP i1 = 1 TO i2
      RVal [i1] = ' '
    END
    RETURN i2
  END

  IF  Level > MaxRecursion
?   ASSERT (FALSE, 'Too deep recursion')
    RETURN 0
  END

  S &= Str

  SELF.Queue.TextProp = Str
  GET (SELF.Queue, SELF.Queue.TextProp)
  IF  ERRORCODE()
    IF  SELF.ExtractText
      SELF.Queue.TextProp = Str
      SELF.Queue.Replacement = ''
      ADD (SELF.Queue, SELF.Queue.TextProp)
?     ASSERT (ERRORCODE() = 0)
    END
  ELSIF SELF.Queue.Replacement
    S &= SELF.Queue.Replacement [1 : LEN (SELF.Queue.Replacement)]
  END

  !!! Resolve macros

  IF  SIZE(RVal) = 0
    RETURN 0
  END

  finger = 0
  i1 = 0

  LOOP WHILE i1 < SIZE(S)
    i1 += 1

    IF  S[i1] = '%'
      IF  i1 < SIZE(S)
        i2 = i1
        LOOP WHILE i2 < SIZE(S)
          i2 += 1
        UNTIL S[i2] = '%'

        IF  S[i2] = '%'
          IF  i2 = i1 + 1             ! don't treat %% as a macro
            i1 = i2                   !   => replace %% with %
          ELSE
            finger += SELF.Translate (S [i1 + 1 : i2 - 1],            |
                                      RVal [finger + 1 : SIZE(RVal)], |
                                      Level + 1)
            IF  finger = SIZE(RVal)
              BREAK
            END

            i1 = i2
            CYCLE
          END
        END
      END
    END

    finger += 1
    RVal [finger] = S[i1]
  UNTIL finger = SIZE(RVal)

  RETURN finger
!-------------------------------------
CalendarClass.Ask                   PROCEDURE(STRING pTitle,LONG pDate=0)
 INCLUDE('ABUTILUI.INC', 'CalendarClassWindow')
 CODE
   OPEN(Screen)
   SELF.CtrlSun       = ?Sun
   SELF.CtrlExit      = ?Exit
   SELF.CtrlToday     = ?Today
   SELF.CtrlDay1      = ?Day1
   SELF.CtrlDay42     = ?Day42
   SELF.CtrlPrevMonth = ?PrevMonth
   SELF.CtrlNextMonth = ?NextMonth
   SELF.CtrlPrevYear  = ?PrevYear
   SELF.CtrlNextYear  = ?NextYear
   SELF.CtrlMore7     = ?More7
   SELF.CtrlLess7     = ?Less7
   SELF.CtrlMore15    = 0
   SELF.CtrlLess15    = 0
   SELF.CtrlCurrTime  = 0
   SELF.CtrlMonthYear = ?MonthYear
   SELF.CtrlTheDate   = 0
   SELF.CtrlTitleBG   = ?BoxTitleBackground
   SELF.CtrlBodyBG    = ?BoxBodyBackground
   RETURN PARENT.Ask(pTitle,pDate)

CalendarClass.SetUp                 PROCEDURE()
 CODE
!-------------------------------------
CalendarSmallClass.Ask                   PROCEDURE(STRING pTitle,LONG pDate=0)
 INCLUDE('ABUTILUI.INC', 'CalendarSmallClassWindow')
 CODE
   OPEN(Screen)
   SELF.CtrlSun         = ?Sun
   SELF.CtrlExit        = ?Exit
   SELF.CtrlToday       = ?Today
   SELF.CtrlDay1        = ?Day1
   SELF.CtrlDay42       = ?Day42
   SELF.CtrlPrevMonth   = ?PrevMonth
   SELF.CtrlNextMonth   = ?NextMonth
   SELF.CtrlPrevYear    = ?PrevYear
   SELF.CtrlNextYear    = ?NextYear
   SELF.CtrlMore7       = ?More7
   SELF.CtrlLess7       = ?Less7
   SELF.CtrlMore15      = ?More15
   SELF.CtrlLess15      = ?Less15
   SELF.CtrlCurrTime    = ?CurrTime
   SELF.CtrlMonthYear   = ?MonthYear
   SELF.CtrlTheDate     = ?TheDate
   SELF.CtrlTitleBG     = 0
   SELF.CtrlBodyBG      = ?BoxBodyBackground
   RETURN PARENT.Ask(pTitle,pDate)

CalendarSmallClass.SetUp                 PROCEDURE()
 CODE
!-------------------------------------
CalendarBaseClass.SetColor              PROCEDURE(LONG pColorSaturday,LONG pColorSunday,LONG pColorOther,LONG pColorHoliday)
 CODE
    SELF.ColorSaturday = pColorSaturday
    SELF.ColorSunday   = pColorSunday
    SELF.ColorOther    = pColorOther
    SELF.ColorHoliday  = pColorHoliday

CalendarBaseClass.IsHoliday             PROCEDURE(BYTE pDay,BYTE pMonth,SHORT pYear,BYTE pWeekDay)
 CODE
    RETURN False
CalendarBaseClass.Ask                   PROCEDURE(LONG pDate=0)
 CODE
    RETURN SELF.Ask('',pDate)
!-------------------------------------
CalendarBaseClass.Ask                   PROCEDURE(STRING pTitle,LONG pDate=0)
WindowInitialized    BYTE
DayStr               STRING(3)
CurrTime             LONG
MonthYear            STRING(15)
The_date             LONG
the_last_date        LONG
the_month            SHORT
the_day              SHORT
the_year             SHORT
base_col             SHORT
last_day             SHORT
base_date            LONG
cur_mo               LONG
cur_yr               LONG
mo_and_yr            LONG
start_date           LONG
sunday_date          LONG
butnum               SHORT
FirstButNum          SHORT
daynum               SHORT
 INCLUDE('ABUTILUI.INC', 'CalendarDayGroup')
SatCol               BYTE
SunCol               BYTE
Day_array            STRING(3),DIM(7),OVER(day_group)
 INCLUDE('ABUTILUI.INC', 'CalendarMonthGroup')
month_array          STRING(10),DIM(12),OVER(month_group)
loc:fecha            LONG
lHIni                LONG
lHEnd                LONG
  CODE
  PUSHBIND

  IF SELF.CtrlCurrTime THEN
     SELF.CtrlCurrTime{PROP:USE}=CurrTime
  END
  IF SELF.CtrlMonthYear THEN
     SELF.CtrlMonthYear{PROP:USE}=MonthYear
  END
  IF SELF.CtrlTheDate THEN
     SELF.CtrlTheDate{PROP:USE}=The_Date
  END
  SELF.FirstWeekDay = 7
  SELF.SetUp()
  IF NOT(SELF.FirstWeekDay>=1 AND SELF.FirstWeekDay<=7) THEN
     SELF.FirstWeekDay = 7
  END
  Do DoReorderDays
  FirstButNum = SELF.CtrlDay1 + (7-SELF.FirstWeekDay)
  SELF.SelectedDate=0
  SELF.Response = RequestCancelled
  IF pDate=0 THEN
     start_date =  TODAY()
  ELSE
     start_date = pDate
  END
  IF ~INRANGE(start_date,DATE(1,1,1801),DATE(12,31,2099))
     start_date = Today()
  END
  the_date = start_date
  mo_and_yr = 0
  cur_mo    = 0
  cur_yr    = 0
  sunday_date = DATE(1,3,1993) ! A known Sunday
  loc:fecha = the_date
  the_last_date= the_date
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  IF SELF.XPos THEN
     IF SELF.RightAlignment THEN
        0{PROP:XPOS}=SELF.XPos-0{PROP:Width}
     ELSE
        0{PROP:XPOS}=SELF.XPos
     END
  END
  IF SELF.YPos THEN
     0{PROP:YPOS}=SELF.YPos
  END
  DO PrepareProcedure
  lHIni=0{PROP:HEIGHT}
  IF CLIP(pTitle) THEN
     0{prop:text}=pTitle
  ELSE
     0{prop:text}=''
  END
  DISPLAY()
  lHEnd=0{PROP:HEIGHT}
  IF lHIni<>lHEnd THEN
     0{PROP:HEIGHT}=0{PROP:HEIGHT}+(lHIni-lHEnd)
  END
  SELF.Response = RequestCancelled
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
       CASE KEYCODE()
         OF UpKey
               Do PrevWeek
               SELECT(SELF.CtrlExit)
         OF DownKey
               Do NextWeek
               SELECT(SELF.CtrlExit)
         OF LeftKey
               Do PrevDay
               SELECT(SELF.CtrlExit)
         OF RightKey
               Do NextDay
               SELECT(SELF.CtrlExit)
         OF EnterKey
                 IF FOCUS()<> SELF.CtrlExit
                    PRESSKEY(TabKey)
                    CYCLE
                 ELSE
                    ! Select the OK button
                    POST(Event:Accepted,SELF.CtrlExit)
                    CYCLE
                 END!IF
       END!CASE
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
         DISPLAY()
         WindowInitialized = True
      END
      SELECT(SELF.CtrlExit)
    OF EVENT:GainFocus
      IF NOT WindowInitialized
         WindowInitialized = True
      END
      DISPLAY()
    OF EVENT:Timer
      Do ShowTime
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    IF FIELD()>0 THEN
       CASE FIELD()
       OF SELF.CtrlDay1 TO SELF.CtrlDay42
         CASE EVENT()
         OF EVENT:Accepted
         ! Set numeric date:
         !   Month and year are known
         !   Day is current button minus button for first day of month
         !     minus the first day of month plus one
         the_date = DATE(the_month,?-SELF.CtrlDay1-base_col+1,the_year)
         DO DoSelect
         DO DoUpdateScreen
         the_last_date= the_date
         SELF.Response = RequestCompleted
         POST(Event:Accepted,SELF.CtrlExit)
         CYCLE
         OF EVENT:Selected
         the_date = DATE(the_month,?-SELF.CtrlDay1-base_col+1,the_year)
         DO DoSelect
         DO DoUpdateScreen
         the_last_date= the_date
         END
       OF SELF.CtrlToday
          CASE EVENT()
          OF EVENT:Accepted
             DO DoToday
             DO DoSelect
             DO DoUpdateScreen
          END
       OF SELF.CtrlPrevMonth
         CASE EVENT()
         OF EVENT:Accepted
           Do DoPrevMonth
         END
       OF SELF.CtrlNextMonth
         CASE EVENT()
         OF EVENT:Accepted
           Do DoNextMonth
         END
       OF SELF.CtrlPrevYear
         CASE EVENT()
         OF EVENT:Accepted
           Do DoPrevYear           
         END
       OF SELF.CtrlNextYear
         CASE EVENT()
         OF EVENT:Accepted
           Do DoNextYear
         END
       OF SELF.CtrlLess7
         CASE EVENT()
         OF EVENT:Accepted
           Do PrevWeek
         END
       OF SELF.CtrlMore7
         CASE EVENT()
         OF EVENT:Accepted
           Do NextWeek
         END
       OF SELF.CtrlLess15
         CASE EVENT()
         OF EVENT:Accepted
           Do Prev2Week
         END
       OF SELF.CtrlMore15
         CASE EVENT()
         OF EVENT:Accepted
           Do Next2Week
         END
       OF SELF.CtrlExit
         CASE EVENT()
         OF EVENT:Accepted
            IF SELF.SelectOnClose THEN
               SELF.Response = RequestCompleted
            END
            POST(Event:CloseWindow)
         END
       END
    END
  END
  IF SELF.Response = RequestCancelled THEN
     loc:fecha = start_date
  END
  SELF.SelectedDate = loc:fecha
  SELF.XPos=0
  SELF.YPos=0
  POPBIND
  RETURN(loc:fecha)
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  ALERT(EnterKey)
  ALERT(DownKey)
  ALERT(RightKey)
  ALERT(UpKey)
  ALERT(LeftKey)
  DO ShowTime
  DO DoUpdateScreen
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!---------------------------------------------------------------------------
DoReorderDays   ROUTINE
  base_col=SELF.FirstWeekDay
  LOOP butnum=0 TO 6
     (SELF.CtrlSun+butnum){PROP:TEXT}=Day_array[base_col]
     IF base_col=6 THEN SatCol=butnum+1.
     IF base_col=7 THEN SunCol=butnum+1.
     base_col+=1
     IF base_col>7 THEN base_col=1.
  END
  
DoUpdateScreen          ROUTINE
  the_month = MONTH(the_date)
  the_day = DAY(the_date)
  the_year = YEAR(the_date)
  ! Need to show new month?
  IF (cur_mo=the_month AND cur_yr=the_year) THEN
     IF the_last_date= the_date THEN EXIT.
     daynum=DAY(the_last_date)
     butnum=daynum-1+base_col+SELF.CtrlDay1
        butnum{PROP:TEXT}=clip(FORMAT(daynum,@P##P))
          butnum{PROP:FontStyle}=FONT:regular
       daynum=DAY(the_date)
       butnum=daynum-1+base_col+SELF.CtrlDay1
       butnum{PROP:FontStyle}=FONT:bold+FONT:underline !today's date
     EXIT
  END
  MonthYear = CLIP(month_array[the_month]) & ' ' & the_year
  base_date = DATE(the_month, 1, the_year)
  base_col = ABS((base_date - (sunday_date-(7-SELF.FirstWeekDay) )) % 7)  ! Column for first day
  last_day = DAY(DATE(the_month + 1, 1, the_year) -1) ! Last day of month
  LOOP butnum = SELF.CtrlDay1 TO SELF.CtrlDay42 ! Label buttons
    daynum = butnum - SELF.CtrlDay1 - base_col + 1
    DO DayToStr
    IF LEN(CLIP(daystr)) > 0
      UNHIDE(butnum)
      butnum{PROP:TEXT}=clip(FORMAT(daynum,@P##P))
      IF butnum=SELF.CtrlDay1+(SunCol-1) or butnum=SELF.CtrlDay1+7+(SunCol-1) or butnum=SELF.CtrlDay1+14+(SunCol-1) or butnum=SELF.CtrlDay1+21+(SunCol-1) or butnum=SELF.CtrlDay1+28+(SunCol-1) or butnum=SELF.CtrlDay1+35+(SunCol-1) THEN
        butnum{PROP:FontColor}=SELF.ColorSunday
        butnum{PROP:FontStyle}=FONT:regular
      ELSE
        IF butnum=SELF.CtrlDay1+(SatCol-1) or butnum=SELF.CtrlDay1+7+(SatCol-1) or butnum=SELF.CtrlDay1+14+(SatCol-1) or butnum=SELF.CtrlDay1+21+(SatCol-1) or butnum=SELF.CtrlDay1+28+(SatCol-1) or butnum=SELF.CtrlDay1+35+(SatCol-1) THEN
          butnum{PROP:FontColor}=SELF.ColorSaturday
          butnum{PROP:FontStyle}=FONT:regular
        ELSE
          butnum{PROP:FontColor}=SELF.ColorOther
          butnum{PROP:FontStyle}=FONT:regular
        END
      END
      IF SELF.IsHoliday(daystr,the_month,the_year,daynum) THEN
         butnum{PROP:FontColor}=SELF.ColorHoliday
         butnum{PROP:FontStyle}=FONT:regular
      END
      IF DATE(the_month, daystr, the_year) = the_date
        butnum{PROP:FontStyle}=FONT:bold+FONT:underline !today's date
      END
     ELSE
      HIDE(butnum)
    END
  END
  cur_mo = the_month
  cur_yr = the_year
  mo_and_yr = the_month + the_year ! Currently showing this month/year
!---------------------------------------------------------------------------
! Show the current time
ShowTime        ROUTINE
  CurrTime = CLOCK()
!---------------------------------------------------------------------------
NextDay         ROUTINE
  the_date = the_date + 1
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
PrevDay         ROUTINE
  the_date = the_date - 1
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
PrevWeek        ROUTINE
  the_date = the_date - 7
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
NextWeek        ROUTINE
  the_date = the_date + 7
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
Prev2Week        ROUTINE
  the_date = the_date - 15
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
Next2Week        ROUTINE
  the_date = the_date + 15
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
! Show next month
DoNextMonth     ROUTINE
  the_month += 1
  DO FixupMonth
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
! Show last month
DoPrevMonth     ROUTINE
  the_month -= 1
  DO FixupMonth
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
! Show same month, next year
DoNextYear      ROUTINE
  the_year += 1
  DO FixupMonth
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
! Show same month, last year
DoPrevYear      ROUTINE
  the_year -= 1
  DO FixupMonth
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
! Pressed a button to select a date
DoSelect        ROUTINE
  IF the_date > 0 
    loc:fecha = the_date
  END
!---------------------------------------------------------------------------
! Show current month/year
DoToday         ROUTINE
  the_date = Today()
  DO DoSelect
  Do DoUpdateScreen
  the_last_date= the_date
!---------------------------------------------------------------------------
! Fix month number up
FixupMonth      ROUTINE
  IF the_month < 1
     the_year -= 1
     the_month = 12
  ELSIF the_month > 12
     the_year += 1
     the_month = 1
  END
  the_date = DATE(the_month, the_day, the_year)
  the_last_date= the_date
!---------------------------------------------------------------------------
! Exit calendar
DayToStr        ROUTINE
  IF daynum > last_day THEN daynum = 0. ! Blank button
  IF daynum <= 0 
    daystr = ''
  ELSE
    daystr = FORMAT(daynum,@n2)
  END
CalendarBaseClass.SetUp                 PROCEDURE()
 CODE
CalendarBaseClass.SetPosition           PROCEDURE(LONG pXPos,LONG pYPos)
 CODE
   SELF.XPos=pXPos
   SELF.YPos=pYPos
