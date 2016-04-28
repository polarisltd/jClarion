    MEMBER
 INCLUDE('QProcess.INC'),ONCE
 INCLUDE('ABERROR.INC'),ONCE
    MAP
    END
QProcessManagerClass.Init                PROCEDURE()
 CODE
    SELF.ProgressPaused    = False
    SELF.ProgressCancelled = False
QProcessManagerClass.Open                PROCEDURE()
 CODE
    IF SELF.ControlProgress THEN
       (SELF.ControlProgress){PROP:RangeLow}=1
       (SELF.ControlProgress){PROP:RangeHigh}=100
    END
    IF NOT SELF.ProgressCancelled AND NOT SELF.ProgressPaused THEN
       0{PROP:TIMER}=SELF.Timer
    END
QProcessManagerClass.SetDefault          PROCEDURE()
 CODE
    IF NOT SELF.RecordsPerCycle THEN
       SELF.RecordsPerCycle = 1
    END
    IF NOT SELF.Low THEN
       SELF.Low = 1
    END
    IF NOT SELF.High THEN
       SELF.High = 100
    END
    IF NOT SELF.Timer THEN
       SELF.Timer = 10
    END
    SELF.ProgressCancelled = False
    SELF.RecordsProcessed  = 0
    SELF.RecordsToProcess  = 0
    SELF.CloseWindowAtEnd  = True
QProcessManagerClass.Reset          PROCEDURE()
 CODE
    IF NOT SELF.RecordsPerCycle THEN
       SELF.RecordsPerCycle = 1
    END
    IF NOT SELF.Low THEN
       SELF.Low = 1
    END
    IF NOT SELF.High THEN
       SELF.High = 100
    END
    IF NOT SELF.Timer THEN
       SELF.Timer = 10
    END
    SELF.ProgressCancelled = False
    SELF.RecordsProcessed  = 0
    SELF.UpdateDisplay()

QProcessManagerClass.IsPaused            PROCEDURE()
 CODE
    RETURN SELF.ProgressPaused
QProcessManagerClass.SetPause            PROCEDURE()
 CODE
    IF SELF.IsPaused() THEN
       SELF.SetPause(False)
    ELSE
       SELF.SetPause(True)
    END
QProcessManagerClass.SetPause            PROCEDURE(BYTE pPause)
 CODE
    SELF.ProgressPaused = pPause
QProcessManagerClass.SetCloseWindow      PROCEDURE(BYTE pClose)
 CODE
    SELF.CloseWindowAtEnd = pClose
QProcessManagerClass.SetTimer            PROCEDURE(SIGNED pTimer=10)
 CODE
    SELF.Timer = pTimer
QProcessManagerClass.SetControls         PROCEDURE(STRING pText,SIGNED pControlProgress=0,SIGNED pControlCancel = 0,SIGNED pControlText = 0,SIGNED pControlPause = 0)
 CODE
    SELF.SetControlProgress(pControlProgress)
    SELF.SetControlCancel(pControlCancel)
    SELF.SetControlText(pControlText)
    SELF.SetControlPause(pControlPause)
    SELF.SetCompletedText(pText)

QProcessManagerClass.SetCompletedText PROCEDURE(STRING pText)
 CODE
    SELF.CompletedText   = pText

QProcessManagerClass.SetControlProgress  PROCEDURE(SIGNED pControl=0)
 CODE
    SELF.ControlProgress = pControl

QProcessManagerClass.SetControlCancel    PROCEDURE(SIGNED pControl=0)
 CODE
    SELF.ControlCancel   = pControl
QProcessManagerClass.SetControlText      PROCEDURE(SIGNED pControl=0)
 CODE
    SELF.ControlPText    = pControl
QProcessManagerClass.SetControlPause     PROCEDURE(SIGNED pControl=0)
 CODE
    SELF.ControlPause    = pControl
QProcessManagerClass.Run                 PROCEDURE()
 CODE
   SELF.SetDefault()
   SELF.RecordsToProcess=SELF.GetRecordsToProcess()
   SELF.UpdateDisplay()


QProcessManagerClass.Ask                 PROCEDURE()

LOCIndex    LONG

 CODE
    IF NOT SELF.ProgressCancelled AND NOT SELF.ProgressPaused THEN
       LOOP LOCIndex=1 TO SELF.RecordsPerCycle
            IF NOT SELF.Next() THEN
               IF SELF.GetEOF() THEN
                  IF SELF.RecordsProcessed>0 THEN
                     SELF.TakeCompleted()
                     SELF.Close()
                     SELF.ProgressCancelled=True
                     break
                  ELSE
                     SELF.TakeNoRecords()
                     SELF.Close()
                     SELF.ProgressCancelled=True
                     break
                  END
               ELSE
                  SELF.ProgressCancelled=True
                  SELF.TakeCancelled()
                  SELF.Close()
                  break
               END
            ELSE
               SELF.RecordsProcessed+=1
               IF SELF.ValidateRecord()=Record:OK THEN
                  SELF.TakeRecord()
               END
            END
            SELF.UpdateDisplay()
       END
    END

QProcessManagerClass.SetProgressLimits   PROCEDURE(LONG pTimer=0,LONG RecordsPerCycle=1)
 CODE
   SELF.RecordsPerCycle = RecordsPerCycle
   SELF.Timer = pTimer
   SELF.Low  = 1
   SELF.High = 100

QProcessManagerClass.TakeEvent           PROCEDURE()
 CODE
    CASE EVENT()
    OF EVENT:Accepted
        CASE ACCEPTED()
        OF SELF.ControlCancel
           IF SELF.ControlCancel AND NOT SELF.ProgressCancelled THEN
              SELF.ProgressCancelled=True
              SELF.TakeCancelled()
              SELF.Close()
           END
        OF SELF.ControlPause
           IF SELF.ControlPause AND NOT SELF.ProgressPaused THEN
              SELF.SetPause(True)
              SELF.TakePaused()
           END
        END
    OF EVENT:Timer
       IF NOT SELF.ProgressCancelled AND NOT SELF.ProgressPaused THEN
          SELF.Ask()
       END
    END
    IF 0{PROP:TIMER}=0 THEN
       IF NOT SELF.ProgressCancelled AND NOT SELF.ProgressPaused THEN
          0{PROP:TIMER}=SELF.Timer
       END
    END
    RETURN Level:Benign
QProcessManagerClass.UpdateDisplay       PROCEDURE()
 CODE
    IF SELF.ControlPText<>0 THEN
       (SELF.ControlPText){PROP:TEXT} = SELF.GetPorcentile()&'% '&CLIP(SELF.CompletedText)
       DISPLAY(SELF.ControlPText)
    END
    IF SELF.ControlProgress<>0 THEN
       (SELF.ControlProgress){PROP:progress}=SELF.GetPorcentile()
       DISPLAY(SELF.ControlProgress)
    END
QProcessManagerClass.Kill                PROCEDURE()
 CODE

QProcessManagerClass.GetPorcentile       PROCEDURE()
 CODE
    RETURN INT(SELF.RecordsProcessed * 100/SELF.RecordsToProcess)
QProcessManagerClass.Next                PROCEDURE()
 CODE
   RETURN False
QProcessManagerClass.GetRecordsToProcess PROCEDURE()
 CODE
   RETURN 0
QProcessManagerClass.GetEOF              PROCEDURE()
 CODE
   IF SELF.RecordsToProcess=SELF.RecordsProcessed THEN
      RETURN True
   ELSE
      RETURN False
   END
QProcessManagerClass.TakeRecord          PROCEDURE()
 CODE
QProcessManagerClass.TakeNoRecords       PROCEDURE()
 CODE
    IF SELF.CloseWindowAtEnd THEN
       POST(EVENT:CloseWindow)
    END
QProcessManagerClass.TakeCancelled       PROCEDURE()
 CODE
    IF SELF.CloseWindowAtEnd THEN
       POST(EVENT:CloseWindow)
    END
QProcessManagerClass.TakePaused          PROCEDURE()
 CODE
QProcessManagerClass.TakeCompleted       PROCEDURE()
 CODE
    IF SELF.CloseWindowAtEnd THEN
       POST(EVENT:CloseWindow)
    END
QProcessManagerClass.ValidateRecord      PROCEDURE()
  CODE
    RETURN Record:OK  ! Cannot validate primary record because of project implications
QProcessManagerClass.Close                PROCEDURE()
 CODE
!***************************************************************************
QueueProcessManagerClass.Init                PROCEDURE(QUEUE pQ)
 CODE
   SELF.Q &= pQ
   PARENT.Init()
QueueProcessManagerClass.Next                PROCEDURE()
 CODE
   ASSERT(NOT SELF.Q &= NULL)
   GET(SELF.Q,SELF.RecordsProcessed+1)
   IF ERRORCODE() THEN
      RETURN False
   ELSE
      RETURN True
   END
QueueProcessManagerClass.GetRecordsToProcess PROCEDURE()
 CODE
   ASSERT(NOT SELF.Q &= NULL)
   RETURN RECORDS(SELF.Q)
!***************************************************************************
