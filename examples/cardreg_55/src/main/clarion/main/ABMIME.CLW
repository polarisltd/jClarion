  MEMBER

  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('ABFILE.INC'),ONCE
  INCLUDE('ABMIME.INC'),ONCE


  MAP
    MODULE('C runtime')
FNSplit   PROCEDURE(*CSTRING Path, *CSTRING Drv, *CSTRING Dir, *CSTRING Nme, *CSTRING Ext),SIGNED,PROC,RAW,NAME('_fnsplit')
FNMerge   PROCEDURE(*CSTRING Path, *CSTRING Drv, *CSTRING Dir, *CSTRING Nme, *CSTRING Ext),RAW,NAME('_fnmerge')
    END
  END

!**Base64 Data

Encode STRING('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=')

szBase64FN       CSTRING(FILE:MaxFilePath+1)
Base64File          FILE,DRIVER('DOS'),CREATE,NAME(szBase64FN)
Record                RECORD
strEntry                STRING(57)
                      END
                    END

!** Quoted Printable Data

LineEnd CSTRING(3)
HexDig  STRING('0123456789ABCDEF')

szQPFn       CSTRING(FILE:MaxFilePath+1)
QPFile              FILE,DRIVER('DOS'),CREATE,NAME(szQPFn)
Record                RECORD
strEntry                STRING(300)
                      END
                    END

szPlainFile     CSTRING(FILE:MaxFilePath+1)
PlainFile           FILE,DRIVER('ASCII'),CREATE,NAME(szPlainFile)
Record                RECORD
strEntry                STRING(300)
                      END
                    END


MIMEDoc.AddAttachment       PROCEDURE(STRING FilePath, <STRING FileName>, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>, BYTE Embedded=0)
CT      CSTRING(50)
Src     CSTRING(File:MaxFilePath+1),AUTO
Drv     CSTRING(5)
Dir     CSTRING(File:MaxFilePath+1)
Nme     CSTRING(File:MaxFilePath+1)
Ext     CSTRING(File:MaxFilePath+1)
FN      STRING(File:MaxFilePath)
  CODE
? ASSERT(~(SELF.Attachments &= NULL),'No attachment queue available, init?')
 IF OMITTED(4)
    CT = Content:Application
 ELSE
    CT = ContentType
 END
 IF ~OMITTED(3) AND FileName
   FN = FileName
 ELSE
   Src = FilePath
   FNSplit(Src, Drv, Dir, Nme, Ext)
   FN = Nme & Ext
 END
 CLEAR(SELF.Attachments)
 SELF.Attachments.Encoder &= Encoder
 SELF.Attachments.ContentType = CT
 SELF.Attachments.ContentSubType = SubType
 SELF.Attachments.FilePath = FilePath
 SELF.Attachments.FileName = FN
 SELF.Attachments.Embedded = Embedded
 ADD(SELF.Attachments)

MIMEDoc.AddBodyFromFile           PROCEDURE(STRING FilePath, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>)
CT      CSTRING(50)
 CODE
 IF OMITTED(3)
    CT = Content:Text
 ELSE
    CT = ContentType
 END
 CLEAR(SELF.Attachments)
 SELF.Attachments.Encoder &= Encoder
 SELF.Attachments.ContentType = CT
 SELF.Attachments.ContentSubType = SubType
 SELF.Attachments.FilePath = FilePath
 SELF.Attachments.InBody = True
 SELF.Attachments.Embedded = True
 ADD(SELF.Attachments)

MIMEDoc.AddAttachmentFromText     PROCEDURE(STRING Text, <STRING FileName>, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>, BYTE Embedded=0)
CT     CSTRING(50)
 CODE
 IF OMITTED(4)
    CT = Content:Text
 ELSE
    CT = ContentType
 END
 CLEAR(SELF.Attachments)
 SELF.Attachments.Encoder &= Encoder
 SELF.Attachments.ContentType = CT
 SELF.Attachments.ContentSubType = SubType
 SELF.Attachments.FileName = FileName
 SELF.Attachments.Text = Text
 SELF.Attachments.InBody = False
 SELF.Attachments.Embedded = Embedded
 ADD(SELF.Attachments)

MIMEDoc.AddBody                   PROCEDURE(STRING Text, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>)
CT     CSTRING(50)
 CODE
 IF OMITTED(3)
    CT = Content:Text
 ELSE
    CT = ContentType
 END
 CLEAR(SELF.Attachments)
 SELF.Attachments.Encoder &= Encoder
 SELF.Attachments.ContentType = CT
 SELF.Attachments.ContentSubType = SubType
 SELF.Attachments.Text = Text
 SELF.Attachments.InBody = True
 SELF.Attachments.Embedded = True
 ADD(SELF.Attachments)

MIMEDoc.AppendBody          PROCEDURE(STRING Text)
 CODE
   SELF.Attachments.InBody = True
   GET(SELF.Attachments,+SELF.Attachments)
   ASSERT(ERRORCODE(),'Initial Body Text has not yet been added, first .AddBody')
   SELF.Attachments.Text = CLIP(SELF.Attachments.Text) & Text
   PUT(SELF.Attachments)

MIMEDoc.Ask                 PROCEDURE
 CODE
 SELF.AttachmentWM.Ask(SELF.Attachments)

MIMEDoc.FreeAttachments     PROCEDURE
 CODE
 CLEAR(SELF.Text)
 FREE(SELF.Attachments)

MIMEDoc.SetContents         PROCEDURE(<STRING ContentType>, <STRING SubType>, <IEncoder Encoder>)
 CODE
 ASSERT(~(OMITTED(2) AND ~OMITTED(3)),'Cannot specify a SubType without a Content:Type.')
 IF ~OMITTED(2) AND ContentType
    SELF.ContentType = ContentType
 ELSE
    SELF.ContentType = Content:Text
 END
 IF ~OMITTED(3)
    SELF.ContentSubtype = SubType
 END
 IF ~OMITTED(4)
    SELF.Encoder &= Encoder
 END

MIMEDoc.SetFile                   PROCEDURE(STRING FilePath, <STRING FileName>, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>, BYTE Embedded=0)
 CODE
 SELF.FilePath = FilePath
 IF ~OMITTED(3) AND FileName
    SELF.FileName = FileName
 END
 SELF.Embedded = Embedded
 SELF.SetContents(ContentType, SubType, Encoder)

MIMEDoc.SetText                   PROCEDURE(STRING Text, STRING FileName, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>, BYTE Embedded=0)
 CODE
 SELF.Text = Text
 SELF.FileName = FileName
 SELF.Embedded = Embedded
 SELF.SetContents(ContentType, SubType, Encoder)

MIMEDoc.Init                      PROCEDURE(ErrorClass ErrorHandler)

 CODE
 SELF.Errors &= ErrorHandler
 SELF.Attachments   &= NEW(AttachmentQueue)

MIMEDoc.Kill                      PROCEDURE
 CODE
 FREE(SELF.Attachments)
 DISPOSE(SELF.Attachments)


MIMEDoc.CheckContentType                 PROCEDURE(*CSTRING ContentType, *CSTRING ContentSubType)
ASub   USHORT,AUTO
CT     CSTRING(50)
CST    CSTRING(50)
 CODE
  IF ~(SELF.ContentType=Content:Multipart) ! Double check for Multipart.
    SORT(SELF.Attachments,-SELF.Attachments.InBody)
    LOOP ASub = 1 TO RECORDS(SELF.Attachments)
     GET(SELF.Attachments,ASub)
     ContentType = Content:Multipart
     IF SELF.Attachments.InBody = True
        IF NOT CT
           CT = SELF.Attachments.ContentType
           CST = SELF.Attachments.ContentSubType
           CYCLE
        END
        IF CT = SELF.Attachments.ContentType AND ~SELF.MPBodyType
           SELF.MPBodyType = SubType:mixed
        END
        IF  CT = Content:Text |
        AND ((CST = SubType:Plain AND SELF.Attachments.ContentSubType = SubType:Html) OR (CST = SubType:Html AND SELF.Attachments.ContentSubType = SubType:Plain))
           SELF.MPBodyType = SubType:alternative
        END
     ELSE
        IF SELF.Attachments.Embedded = True
           ContentSubtype = SubType:Related
        ELSE
           ContentSubtype = SubType:mixed
        END
        BREAK
     END
    END
    IF NOT ContentType
       ContentType = SELF.ContentType
       ContentSubtype = SELF.ContentSubtype
    END
 ELSE
  ContentType = SELF.ContentType
  ContentSubtype = SELF.ContentSubtype
 END
 IF NOT ContentType
    ContentType = Content:Text
 END
 IF NOT ContentSubType
  CASE ContentType
  OF Content:Text
     ContentSubType = SubType:Plain
  OF Content:Multipart
     ContentSubType = SubType:mixed
  OF Content:Message
     ContentSubType = SubType:RFC822
  OF Content:Application
     ContentSubType = SubType:octetstream
  END
 END
 IF NOT SELF.ContentSubType
  CASE SELF.ContentType
  OF Content:Text
     SELF.ContentSubType = SubType:Plain
  OF Content:Multipart
     SELF.ContentSubType = SubType:mixed
  OF Content:Message
     SELF.ContentSubType = SubType:RFC822
  OF Content:Application
     SELF.ContentSubType = SubType:octetstream
  END
 END

MIMEDoc.PutData                   PROCEDURE(IMIMETarget MIMETarget)
BQ  &MIMEBQueue
 CODE
 IF NOT SELF.Version
    SELF.Version = 'MIME-Version: 1.0'
 END
 SELF.PutMIMEHeader(MIMETarget,SELF.Version & CRLF)
 IF SELF.TextOnly
    MIMETarget.PutText(CRLF) ! Separate the headers from the message body.
 END
 BQ &= NEW(MIMEBQueue)
 SELF.PutData(MIMETarget, BQ)
 FREE(BQ)
 DISPOSE(BQ)

MIMEDoc.PutMIMEHeader         PROCEDURE(IMIMETarget MIMETarget, STRING Text)

 CODE
 IF ~SELF.TextOnly
    MIMETarget.PutText(Text)
 END

MIMEDoc.PutData             PROCEDURE(IMIMETarget MIMETarget, MIMEBQueue MBQ)
ASub            USHORT,AUTO
ContentType     CSTRING(50)
ContentSubtype  CSTRING(50)
 CODE
 CLEAR(ContentType)
 CLEAR(ContentSubType)
 CLEAR(SELF.Boundary)
 SELF.CheckContentType(ContentType, ContentSubType)
 IF ContentType = Content:Multipart
    GET(MBQ,RECORDS(MBQ))
    IF ERROR() ! No Boundaries
       MBQ.ID = 1
       ADD(MBQ)
    ELSE
       MBQ.ID += 1
       ADD(MBQ)
    END
    SELF.Boundary = MBQ.ID
 END
 CASE ContentType
 OF Content:Multipart
    IF ContentSubType = SubType:Related
       SELF.PutMIMEHeader(MIMETarget,'Content-type: ' & ContentType & SubType:related & '; boundary="----=_NextPart_' & SELF.Boundary & '"' & CRLF)
    ELSE
       SELF.PutMIMEHeader(MIMETarget,'Content-type: ' & ContentType & ContentSubType & '; boundary="----=_NextPart_' & SELF.Boundary & '"' & CRLF)
    END
 OF Content:Application
    SELF.PutMIMEHeader(MIMETarget,'Content-type: ' & SELF.ContentType & SELF.ContentSubType & '; ' & CHOOSE(SELF.FileName<>'','name="' & CLIP(SELF.FileName) & '"','') & CRLF)
 OF Content:Image
    SELF.PutMIMEHeader(MIMETarget,'Content-type: ' & SELF.ContentType & SELF.ContentSubType & CRLF)
 ELSE
    SELF.PutMIMEHeader(MIMETarget,'Content-type: ' & SELF.ContentType & SELF.ContentSubType & CRLF)
 END
 IF ContentType = Content:Multipart
    SELF.PutMIMEHeader(MIMETarget,CRLF &'This is a multi-part message in MIME format.' & CRLF)
    IF ~(SELF.Attachments &= NULL)
      IF SELF.MPBodyType ! Means that it's a MIME doc within a MIME doc so it needs extra boundaries.
         GET(MBQ,RECORDS(MBQ))
         IF ERROR() ! No Boundaries
            MBQ.ID = 1
            ADD(MBQ)
         ELSE
            MBQ.ID += 1
            ADD(MBQ)
         END
         SELF.PutMIMEHeader(MIMETarget,CRLF & '--' & '----=_NextPart_' & SELF.Boundary & CRLF)
         SELF.PutMIMEHeader(MIMETarget,'Content-type: ' & Content:Multipart & SELF.MPBodyType & '; ' & ' boundary="----=_NextPart_' & MBQ.ID & '"' & CRLF)
      END
      LOOP ASub = 1 TO RECORDS(SELF.Attachments)
       GET(SELF.Attachments,ASub)
       IF SELF.Attachments.InBody
          SELF.PutMIMEHeader(MIMETarget,CRLF & '--' & '----=_NextPart_' & MBQ.ID & CRLF)
       ELSE
          IF SELF.MPBodyType
             CLEAR(SELF.MPBodyType)
             SELF.PutMIMEHeader(MIMETarget,CRLF & '--' & '----=_NextPart_' & MBQ.ID & '--' & CRLF)
          END
          SELF.PutMIMEHeader(MIMETarget,CRLF & '--' & '----=_NextPart_' & SELF.Boundary & CRLF)
       END
       IF ~(SELF.Attachments.MD &= NULL)
          SELF.Attachments.MD.PutData(MIMETarget, MBQ)
       ELSE
          SELF.Attachments.MD &= NEW(MIMEDoc)
          SELF.Attachments.MD.Init(SELF.Errors)
          SELF.Attachments.MD.TextOnly = SELF.TextOnly ! Carry MIME Header inclusion recursively.
          IF SELF.Attachments.Text
             SELF.Attachments.MD.SetText(SELF.Attachments.Text,SELF.Attachments.FileName, SELF.Attachments.ContentType,SELF.Attachments.ContentSubType,SELF.Attachments.Encoder, SELF.Attachments.Embedded)
          ELSE
             SELF.Attachments.MD.SetFile(SELF.Attachments.FilePath,SELF.Attachments.FileName,SELF.Attachments.ContentType,SELF.Attachments.ContentSubType,SELF.Attachments.Encoder, SELF.Attachments.Embedded)
          END
          SELF.Attachments.MD.PutData(MIMETarget, MBQ)
          SELF.Attachments.MD.Kill()
          DISPOSE(SELF.Attachments.MD)
          SELF.Attachments.MD &= NULL
       END
      END
    END
    SELF.PutMIMEHeader(MIMETarget,CRLF & '--' & '----=_NextPart_' & SELF.Boundary & '--' & CRLF)
    ! End boundary
 ELSE
    IF SELF.TEXT
       IF ~(SELF.Encoder &= NULL)
          IF NOT SELF.TextOnly OR (SELF.TextOnly AND SELF.ContentType = Content:Text AND SELF.ContentSubtype = SubType:Plain AND UPPER(SELF.Encoder.GetName())='NO-ENCODING')
             SELF.Encoder.Encode(MIMETarget, SELF.Text, SELF.FileName, SELF.Embedded)
          END
       ELSE
          MIMETarget.PutText(CRLF & SELF.Text)
       END
    END
    IF ~(SELF.Encoder &= NULL) AND SELF.FilePath
       IF NOT SELF.TextOnly OR (SELF.TextOnly AND SELF.ContentType = Content:Text AND SELF.ContentSubtype = SubType:Plain AND UPPER(SELF.Encoder.GetName())='NO-ENCODING')
          SELF.Encoder.Encode(MIMETarget, SELF.FilePath, SELF.FileName, SELF.Embedded)
       END
    END
 END

MIMEDoc.SetAttachmentWin          PROCEDURE(*MIMEVisual MV)
 CODE
 SELF.AttachmentWM &= MV

!*** Base64 Encoding and Decoding.

Base64FileMgr.Init                PROCEDURE(ErrorClass ErrorHandler)
  CODE
  SELF.Init(Base64File, ErrorHandler)
  SELF.FileName &= szBase64FN
  SELF.FileNameValue = szBase64FN
  SELF.Buffer &= Base64File:Record
  SELF.LazyOpen = False
  SELF.Create = 1
  SELF.LockRecover = 10


Base64FileMgr.Next                              PROCEDURE
RVal BYTE,AUTO
SrcS STRING(57)
sl   SHORT
  CODE
  RVal = PARENT.Next()
  SELF.EncodedString = ''
  IF NOT RVal
     IF SELF.Size - SELF.BytesEncoded > LEN(SELF.Buffer)
        SrcS = SELF.Buffer
        sl = SELF.ToBase64(SrcS,SELF.EncodedString)
        SELF.BytesEncoded += LEN(SELF.Buffer)
     ELSE
        sl = SELF.ToBase64(SUB(SELF.Buffer,1,SELF.Size - SELF.BytesEncoded),SELF.EncodedString)
        SELF.BytesEncoded += SELF.Size - SELF.BytesEncoded
     END
     SELF.MIMETarget.PutText(SELF.EncodedString & CRLF)
     YIELD()
  END
  RETURN RVal

Base64FileMgr.IEncoder.Encode     PROCEDURE(IMIMETarget MIMETarget, *CSTRING FilePath, *CSTRING FileName, BYTE Embedded=0)
L SHORT
FilQ QUEUE(FILE:Queue),PRE(FilQ)
     .

  CODE
  SELF.MIMETarget &= MIMETarget
  IF FileName AND NOT Embedded
     SELF.MIMETarget.PutText('Content-Disposition: attachment; filename="' & CLIP(FileName) & '"' & CRLF)
  END
  IF Embedded AND FileName
     SELF.MIMETarget.PutText('Content-ID: <<' & CLIP(FileName) & '>' & CRLF)
     SELF.MIMETarget.PutText('Content-Disposition: inline; filename="' & CLIP(FileName) & '"' & CRLF)
  END
  SELF.MIMETarget.PutText('Content-Transfer-Encoding: ' & SELF.Name & CRLF)
  SELF.MIMETarget.PutText( CRLF )

  DIRECTORY(FilQ,FilePath,ff_:NORMAL)
  GET(FilQ,1)
  IF ~ERRORCODE()
     SELF.Size = FilQ.Size
  END
  FREE(FilQ)
  SELF.BytesEncoded = 0

  SELF.SetName(FilePath)
  IF SELF.TryOpen()
     RETURN
  END
  SET(SELF.File)
  LOOP
   IF SELF.Next() Then BREAK.
  END
  L = Len(Clip(SELF.EncodedString))
  IF L < 76
     SELF.EncodedString = SELF.EncodedString[1:L] & All('=',76-L) ! Pad the last encoded line.
  END
  SELF.Close()

Base64FileMgr.IEncoder.Encode     PROCEDURE(IMIMETarget MIMETarget, STRING Text, *CSTRING FileName, BYTE Embedded=0)
S ULONG,AUTO
L ULONG,AUTO
SrcS STRING(57)
sl   SHORT
  CODE
  SELF.MIMETarget &= MIMETarget
  IF FileName AND NOT Embedded
     SELF.MIMETarget.PutText('Content-Disposition: attachment; filename="' & CLIP(FileName) & '"' & CRLF)
  END
  IF Embedded AND FileName
     SELF.MIMETarget.PutText('Content-ID: <<' & CLIP(FileName) & '>' & CRLF)
     SELF.MIMETarget.PutText('Content-Disposition: inline; filename="' & CLIP(FileName) & '"' & CRLF)
  END
  SELF.MIMETarget.PutText('Content-Transfer-Encoding: ' & SELF.Name & CRLF)
  SELF.MIMETarget.PutText( CRLF )
  L = LEN(Text)
  S = 1
  LOOP UNTIL S > L
   SELF.EncodedString = ''
   IF L - S >= 57
      sl = SELF.ToBase64(Text[S :S+56],SELF.EncodedString)
   ELSE
      sl = SELF.ToBase64(Text[S :L],SELF.EncodedString)
      SELF.EncodedString = CLIP(SELF.EncodedString) & '='
   END
   SELF.MIMETarget.PutText(SELF.EncodedString & CRLF)
   S += 57
  END



Base64FileMgr.IEncoder.GetName    PROCEDURE()
  CODE
    RETURN SELF.Name

! Im assuming we need quick, so this isn't pretty
Base64FileMgr.Take24 PROCEDURE(byte h, byte m, byte l, *STRING Into)
B6 BYTE,AUTO
   CODE
   ! First 6 bits? What does the 'high bit is counted first' expression mean?
   ! I'm assuming top 6 bits of h
   B6 = BSHIFT(h,-2)    
   Into[1] = Encode[B6+1]
   ! Second 6 bits become bottom 2 of h (up 4) and top 4 of m (down 4)
   B6 = BOR(BAND(BSHIFT(h,4),030H),BSHIFT(m,-4))
   Into[2] = Encode[B6+1]
   ! Third 6 bits are bottom 4 of m (up two) and top 2 of l (down 6)
   B6 = BOR(BAND(BSHIFT(m,2),03CH),BSHIFT(l,-6))
   Into[3] = Encode[B6+1]
   ! Last 6 come from bottom 6 of l
   Into[4] = Encode[BAND(l,03FH)+1]
 
Base64FileMgr.Take32 PROCEDURE(*byte h, *byte m, *byte l, *STRING SFrom)
Buff BYTE,DIM(4),AUTO
I BYTE,AUTO
  CODE
  LOOP I = 1 TO 4
    Buff[I] = INSTRING(SFrom[I],Encode)
?   ASSERT(Buff[I])
    Buff[I] -= 1
  END
? ASSERT(Buff[1]<>64)
? ASSERT(Buff[2]<>64)
  ! Whole of first 6 bits up two and first two of second (down 4)
  h = BOR(BSHIFT(Buff[1],2),BSHIFT(Buff[2],-4))
  IF Buff[3] = 64 THEN RETURN 1 .
  ! Middle is bottom 4 bits of second (up 4) and top 4 bits of third (down 2)
  m = BOR(BSHIFT(Buff[2],4),BSHIFT(Buff[3],-2))
  IF Buff[4] = 64 THEN RETURN 2 .
  ! Bottom is bottom two bits of third (up 6) and whole of fourth
  l = BOR(BSHIFT(Buff[3],6),Buff[4])
  RETURN 3
 
Base64FileMgr.ToBase64 PROCEDURE(STRING Inv, *STRING Outv)
I SIGNED,AUTO
Blk SIGNED,AUTO
  CODE
? ASSERT(SIZE(Outv) >= SIZE(Inv)*3/4)
  Blk = LEN(Inv)/3
  LOOP I = 1 TO Blk
    SELF.Take24(VAL(Inv[I*3-2]),VAL(Inv[I*3-1]),VAL(Inv[I*3]),Outv[I*4-3:I*4])
  END
  IF Blk * 3 < LEN(Inv)
    IF Blk *3 + 1 = LEN(Inv)
      SELF.Take24(VAL(Inv[LEN(Inv)]),0,0,Outv[Blk*4+1:Blk*4+4])
      Outv[Blk*4+3] = '='
      Outv[Blk*4+4] = '='
    ELSE
      SELF.Take24(VAL(Inv[LEN(Inv)-1]),VAL(Inv[LEN(Inv)]),0,Outv[Blk*4+1:Blk*4+4])
      Outv[Blk*4+4] = '='
    END
    RETURN Blk*4+4
  ELSE
    RETURN Blk * 4
  END
 
Base64FileMgr.FromBase64 PROCEDURE(STRING Inv, *STRING Outv)
F SIGNED(1)
Store STRING(4)
SH BYTE(0)
OutF SIGNED(1)
B  BYTE,DIM(3)
N  BYTE,AUTO
  CODE
? ASSERT(SIZE(Outv) >= SIZE(Inv)*3/4)
  LOOP WHILE F <= LEN(Inv)
    IF INSTRING(Inv[F],Encode)
      SH += 1
      Store[SH] = Inv[F]
      IF Sh = 4
        N = SELF.Take32(B[1],B[2],B[3],Store)
        Outv[OutF] = CHR(B[1])
        OutF += 1
        IF N = 1 THEN BREAK .
        Outv[OutF] = CHR(B[2])
        OutF += 1
        IF N = 2 THEN BREAK .
        Outv[OutF] = CHR(B[3])
        OutF += 1
        Sh = 0
      END
    END
    F += 1
  END
  RETURN OutF - 1

!*** Quoted Printable Encoding

QuotedPrintFM.Init                PROCEDURE(ErrorClass ErrorHandler)
  CODE
  SELF.Init(QPFile, ErrorHandler)
  SELF.FileName &= szQPFn
  SELF.FileNameValue = szQPFn
  SELF.Buffer &= QPFile:Record
  SELF.LazyOpen = False
  SELF.Create = 1
  SELF.LockRecover = 10


! Note - I do -not- support the encoding of binary data
QuotedPrintFM.EncodeText PROCEDURE(*STRING In, *STRING Out, *USHORT LastCRLF)
IFinger SIGNED(1)
OFinger SIGNED(1)
LLine   SIGNED(1)
  CODE
  LineEnd = CRLF
  LOOP WHILE IFinger <= SIZE(In)
    CASE VAL(In[IFinger])   ! Side step internationalization
    OF 33 TO 60 OROF 62 TO 126
      DO CopyOne   ! Rule 2
    OF 9 OROF 32
      IF IFinger < SIZE(In) AND In[IFinger+1] <> LineEnd[1]
        DO CopyOne  ! Rule 3
      ELSE
        DO HexOne
      END
    OF VAL(LineEnd[1])           ! Rule 4
      IF LEN(In)=1
        DO NewLine
        LastCRLF = 1
        RETURN IFinger - 1
      ELSIF IFinger < SIZE(In) AND In[IFinger+1] = LineEnd[2]
        IFinger += 2
        DO EndLine
        LastCRLF = 1
        RETURN IFinger - 1
      ELSE
        DO HexOne
      END
    ELSE
      DO HexOne ! Rule 1
    END
    IFinger += 1
    IF OFinger + LastCRLF > 75     ! Rule 5
      Out[OFinger] = '='
      OFinger += 1
      DO NewLine
      LastCRLF = 1
      RETURN IFinger - 1
    END
  END
  LastCRLF += OFinger - 1
  RETURN IFinger - 1
 
 
NewLine ROUTINE
  Out[OFinger] = LineEnd[1]
  OFinger += 1
  IF LEN(LineEnd) > 1
    Out[OFinger] = LineEnd[2]
    OFinger += 1
  END
  LLine = OFinger

EndLine ROUTINE
  Out[OFinger] = LineEnd[1]
  Out[OFinger+1] = LineEnd[2]
  OFinger += 2
  LLine = OFinger


CopyOne ROUTINE
  Out[OFinger] = In[IFinger]
  OFinger += 1
 
HexOne ROUTINE
  Out[OFinger] = '='
  OFinger += 1
  Out[OFinger] = HexDig[VAL(In[IFinger]) / 16 + 1]
  OFinger += 1
  Out[OFinger] = HexDig[VAL(In[IFinger]) % 16 + 1]
  OFinger += 1
 
QuotedPrintFM.DecodeText PROCEDURE(*STRING In, *String OUT)
IFinger SIGNED(1)
OFinger SIGNED(1)
  CODE
  LineEnd = CRLF
  LOOP WHILE IFinger <= SIZE(In)
    CASE In[IFinger]
    OF '='
?     ASSERT(IFinger <= SIZE(In)- LEN(LineEnd))
      IF In[IFinger+1] = LineEnd[1]
?       ASSERT(LEN(LineEnd)=1 OR In[IFinger+2]=LineEnd[2])
        IFinger += LEN(LineEnd)
      ELSE
        Out[OFinger] = CHR(SELF.Hex(In[IFinger+1]) * 16 + SELF.Hex(In[IFinger+2]))
        OFinger += 1
        IFinger += 2
      END
    ELSE
      Out[OFinger] = In[IFinger]
      OFinger += 1
    END
    IFinger += 1
  END
  RETURN OFinger - 1
 

 
QuotedPrintFM.Hex PROCEDURE(*STRING Dig)
  CODE
  IF VAL(Dig[1]) <= VAL('9') THEN
    RETURN VAL(Dig[1])-VAL('0')
  END
  IF VAL(Dig[1]) > VAL('Z') THEN
    RETURN VAL(Dig[1])-VAL('a')
  ELSE
    RETURN VAL(Dig[1])-VAL('A')
  END

QuotedPrintFM.Next                              PROCEDURE
RVal BYTE,AUTO
InS &STRING
OutS &STRING
L SHORT,AUTO
S SHORT,AUTO
LastCRLF USHORT(1)
  CODE
  RVal = PARENT.Next()
  IF NOT RVal
     InS  &= NEW( STRING(LEN(SELF.Buffer)))
     OutS &= NEW( STRING(LEN(SELF.Buffer)*3))
     InS = SELF.Buffer
     S = 1
     LOOP UNTIL S >= Len(Clip(InS))
       CLEAR(OutS)
       L = SELF.EncodeText(InS[S : Len(Clip(InS))],OutS, LastCRLF)
       SELF.MIMETarget.PutText( OutS )
       S += L
     END
     DISPOSE(InS)
     DISPOSE(OutS)
  END
  RETURN RVal

QuotedPrintFM.IEncoder.Encode     PROCEDURE(IMIMETarget MIMETarget, *CSTRING FilePath, *CSTRING FileName, BYTE Embedded=0)
  CODE
  SELF.MIMETarget &= MIMETarget
  SELF.MIMETarget.PutText('Content-Transfer-Encoding: ' & SELF.Name & CRLF)
  IF FileName AND NOT Embedded
     SELF.MIMETarget.PutText('Content-Disposition: attachment; filename="' & CLIP(FileName) & '"' & CRLF)
  END
  IF Embedded AND FileName
     SELF.MIMETarget.PutText('Content-ID: <<' & CLIP(FileName) & '>' & CRLF)
  END
  SELF.MIMETarget.PutText( CRLF )
  SELF.SetName(FilePath)
  SELF.Open()
  SET(SELF.File)
  LOOP
   IF SELF.Next() Then BREAK.
  END
  SELF.Close()

QuotedPrintFM.IEncoder.Encode     PROCEDURE(IMIMETarget MIMETarget, STRING Text, *CSTRING FileName, BYTE Embedded)
S USHORT,AUTO
L USHORT,AUTO
OutS &STRING
InS &STRING
LastCRLF USHORT(1)
  CODE
  SELF.MIMETarget &= MIMETarget
  SELF.MIMETarget.PutText('Content-Transfer-Encoding: ' & SELF.Name & CRLF)
  IF FileName AND NOT Embedded
     SELF.MIMETarget.PutText('Content-Disposition: attachment; filename="' & CLIP(FileName) & '"' & CRLF)
  END
  IF Embedded AND FileName
     SELF.MIMETarget.PutText('Content-ID: <<' & CLIP(FileName) & '>' & CRLF)
  END
  SELF.MIMETarget.PutText(CRLF)
  InS &= NEW(STRING(LEN(Text)))
  OutS &= NEW(STRING(LEN(Text)*3))
  InS = Text
  S = 1
  LOOP UNTIL S >= Len(Clip(InS))
    CLEAR(OutS)
    L = SELF.EncodeText(InS[S : Len(Clip(InS))],OutS, LastCRLF)
    SELF.MIMETarget.PutText( OutS )
    S += L
  END
  DISPOSE(InS)
  DISPOSE(OutS)

QuotedPrintFM.IEncoder.GetName    PROCEDURE()
  CODE
    RETURN SELF.Name

MIMEVisual.Ask                 PROCEDURE(*AttachmentQueue AttachmentList)
Window WINDOW('Attachments'),AT(,,260,116),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),SYSTEM, |
         GRAY,DOUBLE
       LIST,AT(3,4,254,90),USE(?List1,FEQ:MimeList),HVSCROLL,FORMAT('68L(1)|M~File~L(2)#6#100L(1)|M~Description~L(2)#7#')
       PANEL,AT(0,97,261,1),USE(?Panel1),BEVEL(0,0,01B9H)
       BUTTON('&Insert'),AT(1,100,45,14),USE(?Button:Insert,FEQ:MimeInsert)
       BUTTON('&Properties'),AT(48,100,45,14),USE(?Button:Properties, FEQ:MimeProperties)
       BUTTON('&Delete'),AT(95,100,45,14),USE(?Button:Delete,FEQ:MimeDelete)
       BUTTON('&Close'),AT(212,100,45,14),USE(?Close:Button,FEQ:MimeClose)
     END
  CODE
  SELF.AttachmentList &= AttachmentList
  OPEN(Window)
  RETURN CHOOSE(SELF.Run()=RequestCancelled,Level:Benign,Level:Notify)


MIMEVisual.Init                PROCEDURE
RVAL BYTE
  CODE
  SELF.Dead = False
  RVal = PARENT.Init()
  FEQ:MimeList{Prop:From} = SELF.AttachmentList
  SELF.AddItem(FEQ:MimeClose,RequestCompleted)
  RETURN RVal


MIMEVisual.Kill                PROCEDURE
  CODE
  RETURN Parent.Kill()

NoneFM.Init                PROCEDURE(ErrorClass ErrorHandler)
  CODE
  SELF.Init(PlainFile, ErrorHandler)
  SELF.FileName &= szPlainFile
  SELF.FileNameValue = szPlainFile
  SELF.Buffer &= PlainFile:Record
  SELF.LazyOpen = False
  SELF.Create = 1
  SELF.LockRecover = 10

NoneFM.Next                              PROCEDURE
RVal BYTE,AUTO
SrcS STRING(57)
sl   SHORT
  CODE
  RVal = PARENT.Next()
  IF NOT RVal
     SELF.MIMETarget.PutText(CLIP(Plainfile.Record) & CRLF)
     YIELD()
  END
  RETURN RVal

NoneFM.IEncoder.Encode     PROCEDURE(IMIMETarget MIMETarget, *CSTRING FilePath, *CSTRING FileName, BYTE Embedded=0)
  CODE
  SELF.MIMETarget &= MIMETarget
  SELF.MIMETarget.PutText( CRLF )
  SELF.SetName(FilePath)
  SELF.Open()
  SET(SELF.File)
  LOOP
   IF SELF.Next() Then BREAK.
  END
  SELF.Close()

NoneFM.IEncoder.Encode     PROCEDURE(IMIMETarget MIMETarget, STRING Text, *CSTRING FileName, BYTE Embedded)
  CODE
  SELF.MIMETarget &= MIMETarget
  SELF.MIMETarget.PutText( CRLF ) ! Blank line after part headers.
  SELF.MIMETarget.PutText( Text )

NoneFM.IEncoder.GetName    PROCEDURE()
  CODE
    RETURN SELF.Name

