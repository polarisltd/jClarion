                     MEMBER('winlats.clw')        ! This is a MEMBER module
CONVERTFILE          PROCEDURE (OPC)              ! Declare Procedure
RejectRecord         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE

ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
     END

OWNERFILE              QUEUE,PRE(TMP)
RECORD                  LIKE(PAR:RECORD)    
                       .

  CODE                                            ! Begin processed code
         CASE OPC
         OF 1 !OPC=1 KONVERTÇJAM PAR_K
            !OWNERNAME='OWNERPAR_K'
            OPEN(PAR_K)
            IF ERRORCODE()=36 !INVALID FILE
               stop('1')
               !OWNERNAME=''
               FREE(OWNERFILE)  !QUEUE
               OPEN(PAR_K)
               IF ~ERROR()
                  RecordsToProcess = RECORDS(PAR_K)
                  RecordsProcessed = 0
                  PercentProgress = 0
                  OPEN(ProgressWindow)
                  Progress:Thermometer = 0
                  ?Progress:PctText{Prop:Text} = '0%'
                  ProgressWindow{Prop:Text} = 'Konvertçjam WinLats v.3.04'
                  ?Progress:UserString{Prop:Text}=''
                  DISPLAY
                  CLEAR(PAR:RECORD)
                  SET(PAR_K)
                  LOOP
                     NEXT(PAR_K)
                     IF ERROR() THEN BREAK.
                     TMP:RECORD=PAR:RECORD
                     ADD(OWNERFILE)  !QUEUE
                     IF ERROR() THEN STOP(ERROR()).
                     II#+=1
                  .
                  CLOSE(PAR_K)
                  REMOVE(PAR_K)
                  !OWNERNAME='OWNERPAR_K'
                  CREATE(PAR_K)
                  OPEN(PAR_K,12h)
                  LOOP I#=1 TO RECORDS(OWNERFILE)
                     GET(OWNERFILE,I#)
                     PAR:RECORD=TMP:RECORD
                     APPEND(PAR_K)
                     JJ#+=1
                     ?Progress:UserString{PROP:TEXT}=JJ#
                                    DO Thermometer
                     DISPLAY()
                  .
                  BUILD(PAR_K)
                  CLOSE(ProgressWindow)
               ELSE
                  STOP('???'&ERROR())
               .
            ELSE
!                  STOP('??1'&ERRORCODE()&ERROR())
            .
            CLOSE(PAR_K)
         OF 2 !OPC=2 KONVERTÇJAM PAR_K1
            !OWNERNAME='OWNERPAR_K'
            OPEN(PAR_K1)
            IF ERRORCODE()=36 !INVALID FILE
               !OWNERNAME=''
               FREE(OWNERFILE)  !QUEUE
               OPEN(PAR_K1)
               IF ~ERROR()
  
                                 RecordsToProcess = RECORDS(PAR_K1)
                                 RecordsProcessed = 0
                                 PercentProgress = 0
                                 OPEN(ProgressWindow)
                                 Progress:Thermometer = 0
                                 ?Progress:PctText{Prop:Text} = '0%'
                                 ProgressWindow{Prop:Text} = 'Konvertçjam WinLats v.3.03'
                                 ?Progress:UserString{Prop:Text}=''
                                 DISPLAY
                                 CLEAR(PAR:RECORD)
  
                  SET(PAR_K1)
                  LOOP
                     NEXT(PAR_K1)
                     IF ERROR() THEN BREAK.
                     TMP:RECORD=PAR1:RECORD
                     ADD(OWNERFILE)  !QUEUE
                     IF ERROR() THEN STOP(ERROR()).
                     II#+=1
                  .
                  CLOSE(PAR_K1)
                  REMOVE(PAR_K1)
                  !OWNERNAME='OWNERPAR_K'
                  CREATE(PAR_K1)
                  OPEN(PAR_K1,12h)
                  LOOP I#=1 TO RECORDS(OWNERFILE)
                     GET(OWNERFILE,I#)
                     PAR:RECORD=TMP:RECORD
                     APPEND(PAR_K1)
                     JJ#+=1
                     ?Progress:UserString{PROP:TEXT}=JJ#
                     DO Thermometer
                     DISPLAY()
                  .
                  BUILD(PAR_K1)
                  CLOSE(ProgressWindow)
               ELSE
                  STOP('???'&ERROR())
               .
            ELSE
!                  STOP('??1'&ERRORCODE()&ERROR())
            .
            CLOSE(PAR_K1)
         ELSE
!  OPC>2
         .

!-----------------------------------------------------------------------------
Thermometer ROUTINE
  RecordsProcessed += 1
  IF PercentProgress < 100
    PercentProgress = (RecordsProcessed / RecordsToProcess)*100
    IF PercentProgress > 100
      PercentProgress = 100
    END
    IF PercentProgress <> Progress:Thermometer THEN
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END


