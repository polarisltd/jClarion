  MEMBER
  MAP
   AddDollar(STRING Src),STRING
   RemoveDollar(STRING Src),STRING
  END

  INCLUDE('ABUTIL.INC'),ONCE
  INCLUDE('ABUTIL.TRN'),ONCE
  INCLUDE('ABFILE.INC'),ONCE


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
  ASSERT(~ERRORCODE())


ConstantClass.Next PROCEDURE

  CODE
  ASSERT(SELF.Termination<>Term:FieldValue OR SELF.TerminatorValue)
  CASE SELF.Termination
  OF Term:Byte
  OROF Term:UShort
    IF SELF.RecordPnt>SELF.Items THEN RETURN Level:Notify.
  OF Term:EndGroup
    IF SELF.CharPnt>SELF.SourceSize THEN RETURN Level:Notify.
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
      ASSERT(False)
    END
    IF POINTER(SELF.Descriptor)=1 AND SELF.Termination=Term:FieldValue AND SELF.Descriptor.Destination=SELF.TerminatorValue
      RETURN Level:Notify
    END
    GET(SELF.Descriptor,POINTER(SELF.Descriptor)+1)
  END
  SELF.RecordPnt+=1
  RETURN Level:Benign


ConstantClass.Next PROCEDURE(QUEUE Q)

  CODE
  SELF.Reset
  LOOP WHILE SELF.Next()=Level:Benign
    ADD(Q)
    ASSERT(~ERRORCODE())
  END


ConstantClass.Next PROCEDURE(FILE F)

  CODE
  SELF.Reset
  LOOP WHILE SELF.Next()=Level:Benign
    ADD(F)
    ASSERT(~ERRORCODE())
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

INIClass.Init PROCEDURE(STRING S)
  CODE
    SELF.FileName = S
    SELF.Sectors &= NEW SectorQueue !***
    SELF.Fetch
    SELF.FetchQueue('__Dont_Touch_Me__','Sectors',SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type) !***

INIClass.Kill PROCEDURE
  CODE
  SELF.Update('__Dont_Touch_Me__','Sectors',SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type) !***
  IF  NOT SELF.Sectors &= NULL
    DISPOSE(SELF.Sectors) !***
    SELF.Sectors &= NULL
  END

INIClass.GetSector PROCEDURE(STRING Family, STRING Item, STRING Type)
  CODE
  RETURN Family & '$' & AddDollar(Item) & '$$' & Type   ! *** Primary to make getfamily easy

INIClass.GetFamily PROCEDURE(STRING Sector, *CSTRING Family, *CSTRING Item, *CSTRING Type)
FP UNSIGNED,AUTO
SP UNSIGNED,AUTO
  CODE
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
  CODE
  SELF.GetFamily(Sector,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  GET(SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  IF ERRORCODE()
    ADD(SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  END

INIClass.DeleteSector        PROCEDURE(STRING Sector)
  CODE
  SELF.GetFamily(Sector,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  GET(SELF.Sectors,SELF.Sectors.Family,SELF.Sectors.Item,SELF.Sectors.Type)
  IF ~ERRORCODE()
    DELETE(SELF.Sectors)
  END

INIClass.GetSectors PROCEDURE(<STRING Family>, <STRING Item>, <STRING Type>, SectorQueue SQ)
I USHORT,AUTO
  CODE
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

  CODE
    RETURN GETINI(Sector, Name, Default, Filename)

INIClass.Update PROCEDURE(STRING Sector, STRING Name, STRING Value, STRING Filename)

  CODE
    PUTINI(Sector, Name, Value, Filename)

INIClass.Update PROCEDURE
  CODE

INIClass.Fetch PROCEDURE
  CODE

INIClass.Update PROCEDURE(STRING Sec,STRING Name,STRING Value)
  CODE
    SELF.Update(Sec, Name, Value, SELF.FileName)

INIClass.Fetch PROCEDURE(STRING Sec,STRING Name,*? Value)
  CODE
    Value = SELF.Fetch(Sec, Name, Value, SELF.FileName)


INIClass.TryFetch PROCEDURE(STRING Sec,STRING Name)
  CODE
    RETURN SELF.Fetch(Sec, Name, '', SELF.FileName)


INIClass.Fetch PROCEDURE(STRING Sec,STRING Name)
Res CSTRING(1000),AUTO
  CODE
    Res = SELF.Fetch(Sec, Name, INIUnknown, SELF.Filename)
    ASSERT(Res <> INIUnknown, 'INI Assert: Could not find ' & Name & ' in sector ' & Sec & ' of ' & SELF.Filename)
    RETURN Res

INIClass.FetchField PROCEDURE(STRING Sec,STRING Name,BYTE Field)
Res CSTRING(1000),AUTO
I USHORT,AUTO
Finger USHORT(1)
  CODE
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
Res CSTRING(1000),AUTO
I USHORT,AUTO
Finger USHORT(1)
  CODE
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
INIClass.FetchQueue PROCEDURE(STRING Sector,STRING Name,QUEUE Q,*? F1,<*? F2>,<*? F3>)
NItems USHORT,AUTO
I ushort,auto
  CODE
    NItems = SELF.TryFetch(Sector,Name)
    LOOP I = 1 TO NItems
      F1 = SELF.FetchField(Sector,Name&'_'&I,1)
      IF ~OMITTED(6)
        F2 = SELF.FetchField(Sector,Name&'_'&I,2)
      END
      IF ~OMITTED(7)
        F3 = SELF.FetchField(Sector,Name&'_'&I,3)
      END
      ADD(Q)
    END

INIClass.Update PROCEDURE(STRING Sector,STRING Name,QUEUE Q,*? F1,<*? F2>,<*? F3>)
I USHORT,AUTO
st CSTRING(5000),AUTO
  CODE
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
    SELF.Update(Sector,Name&'_'&I,St)
  END

INIClass.Update PROCEDURE(STRING ProcedureName,WINDOW W)
M  SIGNED,AUTO
   CODE
   IF ~W{PROP:Iconize}
     M = W{PROP:Maximize}
     SELF.Update(ProcedureName,'Maximize',CHOOSE(M=True,'Yes','No'))
     IF ~M
       SELF.Update(ProcedureName,'XPos',W{PROP:XPos})
       SELF.Update(ProcedureName,'YPos',W{PROP:YPos})
       IF W{PROP:resize}
         SELF.Update(ProcedureName,'Height',W{PROP:Height})
         SELF.Update(ProcedureName,'Width',W{PROP:Width})
       END
     END
   END


INIClass.Fetch PROCEDURE(STRING ProcedureName,WINDOW W)
Maximize BYTE,AUTO
  CODE
  Maximize = INLIST(SELF.TryFetch(ProcedureName,'Maximize'),'No','Yes')
  IF Maximize
    Maximize -= 1
    IF ~Maximize AND W{PROP:Maximize}
      W{PROP:Maximize} = Maximize
    END
    IF SELF.TryFetch(ProcedureName,'XPos')
      W{PROP:XPos} = SELF.Fetch(ProcedureName,'XPos')
      W{PROP:YPos} = SELF.Fetch(ProcedureName,'YPos')
      IF W{PROP:resize}
        W{PROP:Width} = SELF.Fetch(ProcedureName,'Width')
        W{PROP:Height} = SELF.Fetch(ProcedureName,'Height')
      END
    END
    IF Maximize <> W{PROP:Maximize}
      W{PROP:Maximize} = Maximize
    END
  END

AddDollar PROCEDURE(STRING Src)
Hold  STRING(255)
SP    UNSIGNED,AUTO
TP    UNSIGNED(1)
  CODE
  LOOP SP = 1 TO LEN(SRC)
   IF Src[SP] = '$' THEN
      Hold[TP : TP+2] = '$$$'
      TP += 2
   END
   Hold[TP] = Src[SP]
   TP += 1
  END
  RETURN SUB(Hold,1,TP-1)


RemoveDollar PROCEDURE(STRING Src)
Hold  STRING(255)
SP    UNSIGNED,AUTO
TP    UNSIGNED(1)
  CODE
  LOOP SP = 1 TO LEN(SRC)
     IF Src[SP : SP+2] = '$$$'
        Hold[TP] = '$'
        SP += 2
     ELSE
        Hold[TP] = Src[SP]
     END
     TP += 1
  END
  RETURN SUB(Hold,1,TP-1)



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
     LOOP WHILE CtlId{PROPList:Exists,ColCnt}=True
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


TranslatorClass.TranslateString PROCEDURE(STRING LookFor)

RVal     CSTRING(MaxTLen),AUTO
Recurse  SHORT(MaxRecursion),STATIC

   CODE
   Recurse-=1
   ASSERT(Recurse)                !Assertion failure if called too many times recursively
   RVal=LEFT(LookFor)
   IF RVal
     SELF.Queue.TextProp=RVal
     GET(SELF.Queue,SELF.Queue.TextProp)
     IF ERRORCODE()
       IF SELF.ExtractText
         SELF.Queue.TextProp=LookFor
         SELF.Queue.Replacement=''
         ADD(SELF.Queue,SELF.Queue.TextProp)
         ASSERT(~ERRORCODE())
       END
     ELSIF SELF.Queue.Replacement
      RVal=SELF.Queue.Replacement
     END
     SELF.ResolveMacros(RVal)
   END
   Recurse+=1
   RETURN RVal


TranslatorClass.ResolveMacros PROCEDURE(*CSTRING Str)

p1  USHORT(1)
p2  USHORT,AUTO

  CODE
  LOOP
    p1=INSTRING('%',Str,1,p1)
    p2=INSTRING('%',Str,1,p1+1)
    IF ~(p1 AND p2) THEN BREAK.
    IF p2>p1+1                    !don't treat %% as macro terminator
      Str=Str[1: p1-1]&SELF.TranslateString(Str[p1+1 : p2-1])&Str[p2+1 : LEN(Str)]
      p1=p2+1
    END
  END

