    MEMBER
 INCLUDE('ABPRTARG.INC'),ONCE
    MAP
    END
 PRAGMA('link(C%V%DOS%X%%L%.LIB)')
ReportTarget_InFile     FILE,DRIVER('DOS'),PRE(RT_IN),THREAD
                          RECORD
Buffer                     STRING(5000),NAME('|BINARY')
                          END
                        END
ReportTarget_OutFile    FILE,DRIVER('DOS'),CREATE,PRE(RT_OUT),THREAD
                          RECORD
Buffer                     STRING(5000),NAME('|BINARY')
                          END
                        END
!********************************************
TargetGenerator.Init        PROCEDURE(<STRING TargetFileName>)
 CODE
   IF NOT OMITTED(2) THEN
      SELF.TargetFileName=TargetFileName
   END
   SELF.FPos=0

TargetGenerator.SetFileNameFromOriginal PROCEDURE(SHORT pOrdinal,SHORT pTotal=0)
 CODE
    ASSERT(CLIP(SELF.OriginalTargetFileName)<>'','SetFileNameFromOriginal: The original file name is empty')
    SELF.TargetFileName=SELF.GetOriginalFileName(pOrdinal,pTotal)

TargetGenerator.SetFileNameFromOriginal PROCEDURE()
 CODE
    ASSERT(CLIP(SELF.OriginalTargetFileName)<>'','SetFileNameFromOriginal: The original file name is empty')
    SELF.TargetFileName=SELF.GetOriginalFileName()

TargetGenerator.SetOriginalFileName  PROCEDURE(STRING TargetFileName)
 CODE
   SELF.OriginalTargetFileName = TargetFileName
   SELF.SetFileName(TargetFileName)

TargetGenerator.GetExtension         PROCEDURE(STRING FileName)
lPos      BYTE
lLastPos  BYTE
lIndex    SHORT
 CODE
    ASSERT(CLIP(FileName)<>'','GetPath: The file name is empty')
    lPos=1
    lLastPos=0
    LOOP
       IF lPos>LEN(CLIP(FileName)) THEN BREAK.
       lPos=INSTRING('.',CLIP(FileName),1,lPos)
       IF lPos=0 THEN BREAK.
       lLastPos=lPos
       lPos+=1
    END
    IF lLastPos THEN
       RETURN (FileName[(lLastPos+1):(LEN(CLIP(FileName)))])
    ELSE
       RETURN ''
    END

TargetGenerator.GetPath              PROCEDURE(STRING FileName)
lPos      BYTE
lLastPos  BYTE
lIndex    SHORT
 CODE
    ASSERT(CLIP(FileName)<>'','GetPath: The file name is empty')
    lPos=1
    lLastPos=0
    LOOP
       IF lPos>LEN(CLIP(FileName)) THEN BREAK.
       lPos=INSTRING('\',CLIP(FileName),1,lPos)
       IF lPos=0 THEN BREAK.
       lLastPos=lPos
       lPos+=1
    END
    IF lLastPos THEN
       RETURN (FileName[1:(lLastPos)])
    ELSE
       RETURN ''
    END

TargetGenerator.GetFileNameNoExt  PROCEDURE(STRING FileName)
lPeriodPos  BYTE
 CODE
    ASSERT(CLIP(FileName)<>'','GetFileNameNoExt: The file name is empty')
       lPeriodPos = INSTRING('.',CLIP(FileName))
       IF lPeriodPos THEN
          RETURN (FileName[1:(lPeriodPos-1)])
       ELSE
          RETURN (CLIP(FileName))
       END

TargetGenerator.GetNameNoExt         PROCEDURE(STRING FileName)
lPos      BYTE
lLastPos  BYTE
lIndex    SHORT
 CODE
    ASSERT(CLIP(FileName)<>'','GetNameNoExt: The file name is empty')
    lPos=1
    lLastPos=0
    LOOP
       IF lPos>LEN(CLIP(FileName)) THEN BREAK.
       lPos=INSTRING('\',CLIP(FileName),1,lPos)
       IF lPos=0 THEN BREAK.
       lLastPos=lPos
       lPos+=1
    END
    IF lLastPos THEN
       RETURN SELF.GetFileNameNoExt(FileName[(lLastPos+1):(LEN(FileName))])
    ELSE
       RETURN SELF.GetFileNameNoExt(FileName)
    END

TargetGenerator.GetOriginalFileName  PROCEDURE()
 CODE
    RETURN SELF.OriginalTargetFileName

TargetGenerator.GetOriginalFileName  PROCEDURE(SHORT pOrdinal,SHORT pTotal=0)
lFileName   CSTRING(144)
lFileExt    CSTRING(144)
lPeriodPos  BYTE
 CODE
    ASSERT(CLIP(SELF.OriginalTargetFileName)<>'','GetOriginalFileName: The original file name is empty')
    IF pOrdinal=0 THEN
       RETURN SELF.GetOriginalFileName()
    ELSE
       lPeriodPos = INSTRING('.',CLIP(SELF.OriginalTargetFileName))
       IF lPeriodPos THEN
          lFileName = SELF.OriginalTargetFileName[1:(lPeriodPos-1)]
          lFileExt  = SELF.OriginalTargetFileName[(lPeriodPos):LEN(CLIP(SELF.OriginalTargetFileName))]
       ELSE
          lFileName = CLIP(SELF.OriginalTargetFileName)
          lFileExt  = '.TXT' !If the file has not an extension by default it take the TXT
       END
       IF pTotal=0 THEN
          RETURN CLIP(lFileName)&'_'&pOrdinal&CLIP(lFileExt)
       ELSE
          RETURN CLIP(lFileName)&'_'&|
          ALL('0',LEN(LEFT(CLIP(pTotal)))-LEN(LEFT(CLIP(pOrdinal))))&LEFT(CLIP(pOrdinal))&|
          CLIP(lFileExt)
       END
    END

TargetGenerator.SetFileName          PROCEDURE(STRING TargetFileName)
 CODE
   SELF.TargetFileName=TargetFileName

TargetGenerator.GetFileName          PROCEDURE()
 CODE
   RETURN SELF.TargetFileName

TargetGenerator.OpenFile   PROCEDURE(BYTE pCreate=1)
 CODE
   SELF.TargetFileHandle = 0
   ReportTarget_OutFile{PROP:NAME}=CLIP(SELF.TargetFileName)
   IF pCreate THEN
      CLOSE(ReportTarget_OutFile)
      CREATE(ReportTarget_OutFile)
      IF ERRORCODE() THEN
         MESSAGE('ERROR:('&ERRORCODE()&') '&ERROR()&'|Can''t create target file '&CLIP(SELF.TargetFileName),'Target OpenFile')
         RETURN False
      END
   END
   OPEN(ReportTarget_OutFile,1)
   IF ERRORCODE() THEN
      MESSAGE('ERROR:('&ERRORCODE()&') '&ERROR()&'|Can''t open target file '&CLIP(SELF.TargetFileName),'Target OpenFile')
      RETURN False
   ELSE
      SELF.TargetFileHandle = 1
      RETURN True
   END

TargetGenerator.CloseFile   PROCEDURE()
ReturnValue BYTE
 CODE
    ReturnValue = True
    IF SELF.TargetFileHandle THEN
       CLOSE(ReportTarget_OutFile)
       IF ERRORCODE() THEN
          MESSAGE('ERROR:('&ERRORCODE()&') '&ERROR()&'|Can''t close target file '&CLIP(SELF.TargetFileName),'Target CloseFile')
          ReturnValue = False
       ELSE
          SELF.TargetFileHandle = 0
       END
    END
    RETURN(ReturnValue)

TargetGenerator.WriteLine PROCEDURE(STRING str,BYTE pClipStr=0)
 CODE
    RETURN SELF.WriteStr(str&CHR(13)&CHR(10),pClipStr)

TargetGenerator.WriteLong            PROCEDURE(LONG str)
 CODE
  RETURN(SELF.WriteULong(str))
TargetGenerator.WriteShort           PROCEDURE(SHORT str)
 CODE
  RETURN(SELF.WriteUShort(str))
TargetGenerator.WriteULong           PROCEDURE(ULONG str)
LOC:ULong   ULONG
LOC:UShort  GROUP,OVER(LOC:ULong)
L              USHORT
H              USHORT
            END
 CODE
     LOC:ULong = str
     IF SELF.WriteUShort(LOC:UShort.L)=True THEN
        RETURN(SELF.WriteUShort(LOC:UShort.H))
     ELSE
        RETURN False
     END
TargetGenerator.WriteUShort          PROCEDURE(USHORT str)
LOC:UShort  USHORT
LOC:Byte    GROUP,OVER(LOC:UShort)
L              BYTE
H              BYTE
            END
 CODE
     LOC:UShort = str
     IF SELF.WriteByte(LOC:Byte.L)=True THEN
        RETURN(SELF.WriteByte(LOC:Byte.H))
     ELSE
        RETURN(False)
     END
TargetGenerator.WriteByte PROCEDURE(BYTE str)
LOC:Buffer           STRING(5000),NAME('|BINARY')                                                        ! String To Write
LOC:BufferLen        SIGNED                                                              ! Characters to Write
LOC:BytesWritten     SIGNED                                                              ! Characters Written
 CODE
   SELF.FPos += 1
   LOC:Buffer    = CHR(str)
   LOC:BufferLen = 1
   IF SELF.TargetFileHandle THEN
      ReportTarget_OutFile.Buffer = LOC:Buffer
      APPEND(ReportTarget_OutFile,LOC:BufferLen)
      IF ERRORCODE() THEN
         RETURN False
      ELSE
         RETURN True
      END
   ELSE
      RETURN False !File is not open
   END
TargetGenerator.WriteStr PROCEDURE(STRING str,BYTE pClipStr=0)
LOC:Buffer           STRING(5000),NAME('|BINARY')                                                        ! String To Write
LOC:BufferLen        SIGNED                                                              ! Characters to Write
LOC:BytesWritten     SIGNED                                                              ! Characters Written
 CODE
   SELF.FPos += len(str)
   IF pClipStr THEN
      LOC:Buffer    = str
      LOC:BufferLen = LEN(str)                                                     ! Check Length of the Data to be Printed
   ELSE
      LOC:Buffer    = CLIP(str)
      LOC:BufferLen = LEN(CLIP(LOC:Buffer))                                                     ! Check Length of the Data to be Printed
   END
   IF SELF.TargetFileHandle THEN
      ReportTarget_OutFile.Buffer = LOC:Buffer
      APPEND(ReportTarget_OutFile,LOC:BufferLen)
      IF ERRORCODE() THEN
         RETURN False
      ELSE
         RETURN True
      END
   ELSE
      RETURN False !File is not open
   END



TargetGenerator.WriteFileStream  PROCEDURE(STRING pFileName,LONG pStart=1,LONG pLen=0,BYTE pAllowedCharOnly=0)
LOC:FileName    CSTRING(144)
LOC:FileHandle  LONG
LOC:Buffer      STRING(5000),NAME('|BINARY')                                                        ! String To Write
LOC:Buffer2     STRING(2),NAME('|BINARY')                                                        ! String To Write
LOC:BufferLen   SIGNED                                                              ! Characters to Write
LOC:BytesRead   SIGNED
LOC:BytesWritten SIGNED
LOC:TotalBytesRead   LONG
LOC:I           SHORT
ReturnValue     LONG
LOC:SFPos       LONG
LOC:FilePos       LONG
LOC:PrevFileName    CSTRING(144)
LOC:LocalOpen   BYTE
 CODE
   LOC:SFPos=0
   LOC:LocalOpen=False

   IF SELF.SourceFileHandle THEN
      LOC:SFPos=SELF.GetSourceFPos()
      IF UPPER(CLIP(pFileName))<>UPPER(CLIP(SELF.SourceFileName)) THEN
         LOC:PrevFileName=SELF.SourceFileName
         SELF.CloseSourceFile()
         IF NOT SELF.OpenSourceFile(pFileName) THEN
            SELF.OpenSourceFile(LOC:PrevFileName)
            SELF.SetSourceFPos(LOC:SFPos)
            RETURN(0)
         ELSE
            LOC:LocalOpen=true
         END
      END
   ELSE
      IF NOT SELF.OpenSourceFile(pFileName) THEN
         RETURN(0)
      ELSE
         LOC:LocalOpen=true
      END
   END


   LOC:BufferLen = 5000
   IF pLen AND pLen<LOC:BufferLen THEN LOC:BufferLen=pLen.
   LOC:BytesRead = 0
   LOC:TotalBytesRead = 0
   LOC:FilePos=pStart
   SET(ReportTarget_InFile)
   LOOP
      GET(ReportTarget_InFile,LOC:FilePos,LOC:BufferLen)
      IF NOT ERRORCODE() THEN
         LOC:BytesRead = BYTES(ReportTarget_InFile)
         LOC:Buffer[1:(LOC:BytesRead)]=ReportTarget_InFile.Buffer[1:(LOC:BytesRead)]
         LOC:FilePos+=LOC:BytesRead
      ELSE
         LOC:BytesRead = 0
      END
      IF LOC:BytesRead>0 THEN
         LOC:TotalBytesRead += LOC:BytesRead
         IF pLen THEN
            IF LOC:TotalBytesRead>pLen THEN
               LOC:BytesRead = LOC:BytesRead - (LOC:TotalBytesRead-pLen)
            END
         END
         IF pAllowedCharOnly THEN
            LOOP LOC:I=1 TO LOC:BytesRead
                 IF LOC:Buffer[LOC:I]='\' OR LOC:Buffer[LOC:I]='(' OR LOC:Buffer[LOC:I]=')' THEN
                    SELF.WriteStr('\')
                 END
                 LOC:Buffer2[1:1]=LOC:Buffer[LOC:I]
                 ReportTarget_OutFile.Buffer[1:1]=LOC:Buffer[LOC:I]
                 APPEND(ReportTarget_OutFile,1)
                 LOC:BytesWritten += BYTES(ReportTarget_OutFile)
            END
         ELSE
            ReportTarget_OutFile.Buffer[1:(LOC:BytesRead)]=LOC:Buffer[1:(LOC:BytesRead)]
            APPEND(ReportTarget_OutFile,LOC:BytesRead)
            LOC:BytesWritten += BYTES(ReportTarget_OutFile)
         END
         IF pLen THEN
            IF LOC:TotalBytesRead>pLen THEN
               LOC:TotalBytesRead = pLen
               BREAK
            END
         END
      ELSE
         BREAK
      END
      IF LOC:BytesRead < LOC:BufferLen THEN BREAK.
   END
   IF LOC:TotalBytesRead > 0 THEN
      SELF.SetSourceFPos(LOC:SFPos+LOC:TotalBytesRead)
   END

   IF SELF.SourceFileHandle THEN
      IF LOC:LocalOpen=true THEN
         SELF.CloseSourceFile()
         IF LOC:SFPos THEN
            IF SELF.OpenSourceFile(LOC:PrevFileName) THEN
               SELF.SetSourceFPos(LOC:SFPos)
            END
         END
      END
   END

   RETURN LOC:TotalBytesRead
TargetGenerator.OpenSourceFile   PROCEDURE(STRING SourceFileName)
 CODE
   IF SELF.SourceFileHandle THEN
      SELF.CloseSourceFile()
   END
   SELF.SFPos = 0
   SELF.SourceFileName=SourceFileName
   SELF.SourceFileHandle = 0
   ReportTarget_InFile{PROP:NAME}=CLIP(SELF.SourceFileName)
   OPEN(ReportTarget_InFile,0+32) !Read Only - Deny Write
   IF ERRORCODE() THEN
      MESSAGE('ERROR:('&ERRORCODE()&') '&ERROR()&'|Can''t open source file '&CLIP(SELF.SourceFileName),'Target OpenSourceFile')
      SELF.SourceFileName   = ''
      RETURN False
   ELSE
      SELF.SourceFileHandle = 1
      RETURN True
   END

TargetGenerator.CloseSourceFile   PROCEDURE()
ReturnValue BYTE
 CODE
    SELF.SFPos = 0
    ReturnValue = True
    IF SELF.SourceFileHandle THEN
       CLOSE(ReportTarget_InFile)
       IF ERRORCODE() THEN
          RETURN False
       ELSE
          SELF.SourceFileHandle = 0
       END
    END
    RETURN(ReturnValue)

TargetGenerator.GetSourceFPos        PROCEDURE()
 CODE
   RETURN SELF.SFPos
TargetGenerator.SetSourceFPos        PROCEDURE(LONG pFPos)
 CODE
   SELF.SFPos = pFPos
TargetGenerator.GetSourceSAutoAdvance PROCEDURE()
 CODE
   RETURN SELF.SAutoAdvance
TargetGenerator.SetSourceSAutoAdvance PROCEDURE(BYTE pParam)
 CODE
   IF pParam THEN
      SELF.SAutoAdvance=1
   ELSE
      SELF.SAutoAdvance=0
   END
TargetGenerator.ReadStr              PROCEDURE(LONG pLength,*STRING pBuffer)
LOC:Buffer      &STRING,NAME('|BINARY')
LOC:BytesRead   LONG
 CODE
   IF SELF.SourceFileHandle=0 THEN
      pBuffer=''
      RETURN 0
   END
   LOC:Buffer &=NEW(STRING(pLength))
   LOC:Buffer = CLIP(LOC:Buffer)

   SET(ReportTarget_InFile,SELF.SFPos)
   IF ERRORCODE() THEN
      pBuffer=''
      RETURN 0
   END
   GET(ReportTarget_InFile,SELF.SFPos,pLength)
   IF NOT ERRORCODE() THEN
      LOC:Buffer = ReportTarget_InFile.Buffer[1:pLength]
      LOC:BytesRead = pLength
      IF SELF.SAutoAdvance THEN SELF.SFPos+=LOC:BytesRead.
      pBuffer[1:LOC:BytesRead] = LOC:Buffer[1:LOC:BytesRead]
      RETURN LOC:BytesRead
   ELSE
      pBuffer=''
      RETURN 0
   END
TargetGenerator.ReadULong            PROCEDURE(*ULONG pBuffer)
LOC:Buffer  STRING(4),NAME('|BINARY')
LOC:BytesRead   LONG
GG              GROUP,OVER(LOC:Buffer)
A                 BYTE
B                 BYTE
C                 BYTE
D                 BYTE
               END
G              GROUP,OVER(LOC:Buffer)
A                 BYTE
B                 BYTE
C                 BYTE
D                 BYTE
               END
LOC:NBuffer    ULONG,OVER(G)
BAUX  BYTE
 CODE
 LOC:BytesRead = SELF.ReadStr(4,LOC:Buffer)
 IF LOC:BytesRead=LEN(LOC:Buffer) THEN
    BAUX=G.A
    G.A=G.D
    G.D=BAUX
    BAUX=G.C
    G.C=G.B
    G.B=BAUX
    pBuffer=LOC:NBuffer
    RETURN True
 ELSE
    RETURN False
 END

TargetGenerator.GetStr               PROCEDURE(LONG pLength)
LOC:Buffer      STRING(65000),NAME('|BINARY')
LOC:BytesRead   LONG
 CODE
   IF SELF.SourceFileHandle=0 THEN
      RETURN ''
   END
   LOC:BytesRead = 0
   LOC:BytesRead = SELF.ReadStr(pLength,LOC:Buffer)
   IF LOC:BytesRead>0 THEN
      RETURN SUB(LOC:Buffer,1,LOC:BytesRead)
   ELSE
      RETURN ''
   END


TargetGenerator.ReadLong             PROCEDURE(*LONG pBuffer)
LOC:Buffer     STRING(4),NAME('|BINARY')
LOC:BytesRead  LONG
G              GROUP,OVER(LOC:Buffer)
A                 BYTE
B                 BYTE
C                 BYTE
D                 BYTE
               END
LOC:NBuffer    LONG,OVER(G)
BAUX  BYTE
 CODE
 LOC:BytesRead = SELF.ReadStr(4,LOC:Buffer)
 IF LOC:BytesRead=LEN(LOC:Buffer) THEN
    BAUX=G.A
    G.A=G.D
    G.D=BAUX
    BAUX=G.C
    G.C=G.B
    G.B=BAUX
    pBuffer=LOC:NBuffer
    RETURN True
 ELSE
    RETURN False
 END
TargetGenerator.ReadUShort           PROCEDURE(*USHORT pBuffer)
LOC:Buffer     STRING(2),NAME('|BINARY')
LOC:BytesRead  LONG
G              GROUP,OVER(LOC:Buffer)
A                 BYTE
B                 BYTE
               END
LOC:NBuffer    USHORT,OVER(G)
BAUX  BYTE
 CODE
 LOC:BytesRead = SELF.ReadStr(2,LOC:Buffer)
 IF LOC:BytesRead=LEN(LOC:Buffer) THEN
    BAUX=G.A
    G.A=G.B
    G.B=BAUX
    pBuffer=LOC:NBuffer
    RETURN True
 ELSE
    RETURN False
 END
TargetGenerator.ReadShort            PROCEDURE(*SHORT pBuffer)
LOC:Buffer     STRING(2),NAME('|BINARY')
LOC:BytesRead  LONG
G              GROUP,OVER(LOC:Buffer)
A                 BYTE
B                 BYTE
               END
LOC:NBuffer    SHORT,OVER(G)
BAUX  BYTE
 CODE
 LOC:BytesRead = SELF.ReadStr(2,LOC:Buffer)
 IF LOC:BytesRead=LEN(LOC:Buffer) THEN
    BAUX=G.A
    G.A=G.B
    G.B=BAUX
    pBuffer=LOC:NBuffer
    RETURN True
 ELSE
    RETURN False
 END
TargetGenerator.ReadByte             PROCEDURE(*BYTE pBuffer)
LOC:Buffer  STRING(1),NAME('|BINARY')
LOC:NBuffer BYTE,OVER(LOC:Buffer)
LOC:BytesRead   LONG
 CODE
 LOC:BytesRead = SELF.ReadStr(1,LOC:Buffer)
 IF LOC:BytesRead=LEN(LOC:Buffer) THEN
    pBuffer=LOC:NBuffer
    RETURN True
 ELSE
    RETURN False
 END
!********************************************
