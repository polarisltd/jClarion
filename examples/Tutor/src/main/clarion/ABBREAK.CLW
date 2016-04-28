    MEMBER
 INCLUDE('ABBreak.INC'),ONCE
    MAP
    END
BreakManagerClass.CONSTRUCT               PROCEDURE()
 CODE
   SELF.QB &=NEW(BreaksQueue)
   SELF.BreakId = 0
BreakManagerClass.DESTRUCT               PROCEDURE()
LOC:Index   SHORT
 CODE
   LOOP LOC:Index=1 to RECORDS(SELF.QB)
        GET(SELF.QB,LOC:Index)
        IF NOT ERRORCODE() THEN
           SELF.QB.ThisBreak.Kill
           SELF.QB.ThisBreak.DESTRUCT()
        END
   END
   FREE(SELF.QB)
   DESTROY(SELF.QB)
BreakManagerClass.GetLevel                FUNCTION()!Return nested level number where the Level is
 CODE
   GET(SELF.QB,SELF.BreakId)
   IF NOT ERRORCODE() THEN
      RETURN SELF.QB.ThisBreak.GetLevel()
   END
   RETURN 0
BreakManagerClass.GetLevel                FUNCTION(SHORT BreakId)!Return nested level number where the Level is
 CODE
   GET(SELF.QB,BreakId)
   IF NOT ERRORCODE() THEN
      RETURN SELF.QB.ThisBreak.GetLevel()
   END
   RETURN 0
BreakManagerClass.GetRecords              FUNCTION()  !Return records readed
 CODE
   GET(SELF.QB,SELF.BreakId)
   IF NOT ERRORCODE() THEN
      RETURN SELF.QB.ThisBreak.GetRecords()
   END
   RETURN 0
BreakManagerClass.GetRecords              FUNCTION(SHORT BreakId)  !Return records readed
 CODE
   GET(SELF.QB,BreakId)
   IF NOT ERRORCODE() THEN
      RETURN SELF.QB.ThisBreak.GetRecords()
   END
   RETURN 0
BreakManagerClass.GetRecordsOnLevel       FUNCTION(SHORT LevelId) !Return numbers of records readed on each level, it's reset to cero on each Level
 CODE
   GET(SELF.QB,SELF.BreakId)
   IF NOT ERRORCODE() THEN
      RETURN SELF.QB.ThisBreak.GetRecords(LevelId)
   END
   RETURN 0
BreakManagerClass.GetRecords              FUNCTION(SHORT BreakId,SHORT LevelId) !Return numbers of records readed on each level, it's reset to cero on each Level
 CODE
   GET(SELF.QB,BreakId)
   IF NOT ERRORCODE() THEN
      RETURN SELF.QB.ThisBreak.GetRecords(LevelId)
   END
   RETURN 0
BreakManagerClass.GetBreak                FUNCTION() !Return nested Break number where the Level is
 CODE
   RETURN SELF.BreakId
BreakManagerClass.Init                    PROCEDURE() !Init the object
LOC:Index   SHORT
 CODE
   SELF.BreakId = 0
   LOOP LOC:Index=1 to RECORDS(SELF.QB)
        GET(SELF.QB,LOC:Index)
        IF NOT ERRORCODE() THEN
           SELF.QB.ThisBreak.Kill
           SELF.QB.ThisBreak.DESTRUCT()
        END
   END
   FREE(SELF.QB)
BreakManagerClass.Kill                    PROCEDURE() !Kill the object
LOC:Index   SHORT
 CODE
   LOOP LOC:Index=1 to RECORDS(SELF.QB)
        GET(SELF.QB,LOC:Index)
        IF NOT ERRORCODE() THEN
           SELF.QB.ThisBreak.Kill
           SELF.QB.ThisBreak.DESTRUCT()
        END
   END
   FREE(SELF.QB)
   SELF.BreakId = 0
BreakManagerClass.Reset                   PROCEDURE() !Reset the Level's fields value and the total fields values
LOC:Index   SHORT
 CODE
   LOOP LOC:Index=1 to RECORDS(SELF.QB)
        GET(SELF.QB,LOC:Index)
        IF NOT ERRORCODE() THEN
           SELF.BreakId = SELF.QB.Id
           SELF.QB.ThisBreak.Reset
        END
   END
BreakManagerClass.Reset                   PROCEDURE(SHORT BreakId) !Reset the Level's fields value and the total fields values
 CODE
   GET(SELF.QB,BreakId)
   IF NOT ERRORCODE() THEN
      SELF.BreakId = SELF.QB.Id
      SELF.QB.ThisBreak.Reset
   END
BreakManagerClass.AddBreak                PROCEDURE() !add a Break
 CODE
   CLEAR(SELF.QB)
   SELF.QB.ThisBreak &= NEW(LevelManagerClass)
   SELF.QB.Id     = RECORDS(SELF.QB)+1
   ADD(SELF.QB)
   SELF.BreakId = SELF.QB.Id
   SELF.QB.ThisBreak.Init(SELF,SELF.BreakId)
BreakManagerClass.AddLevel                PROCEDURE(SHORT BreakId) !add a Level
 CODE
    GET(SELF.QB,BreakId)
    IF NOT ERRORCODE() THEN
       SELF.BreakId = SELF.QB.Id
       SELF.QB.ThisBreak.AddLevel()
    END
BreakManagerClass.AddLevel                PROCEDURE() !add a Level
 CODE
    IF SELF.BreakId>0 THEN
       SELF.AddLevel(SELF.BreakId)
    ELSE
       IF RECORDS(SELF.QB) THEN
          SELF.AddLevel(1)
       END
    END
BreakManagerClass.AddResetField           PROCEDURE(SHORT BreakId,*? LevelField)!Add a reset field to the last Level added
 CODE
    GET(SELF.QB,BreakId)
    IF NOT ERRORCODE() THEN
       SELF.QB.ThisBreak.AddResetField(LevelField)
    END
BreakManagerClass.AddField                PROCEDURE(SHORT BreakId,*? LevelField)!Add a field to be restored to the last Level added
 CODE
    GET(SELF.QB,BreakId)
    IF NOT ERRORCODE() THEN
       SELF.BreakId = SELF.QB.Id
       SELF.QB.ThisBreak.AddField(LevelField)
    END
BreakManagerClass.AddResetField           PROCEDURE(*? LevelField)!Add a reset field to the last Level added
 CODE
    IF SELF.BreakId>0 THEN
       SELF.AddResetField(SELF.BreakId,LevelField)
    ELSE
       IF RECORDS(SELF.QB) THEN
          SELF.AddResetField(1,LevelField)
       END
    END

BreakManagerClass.AddHotField                PROCEDURE(*? LevelField)!Add a field to be restored to the last Level added
LOC:Index   SHORT
LOC:ActualId LONG
 CODE
   IF RECORDS(SELF.QB) THEN
      LOC:ActualId=SELF.BreakId
   ELSE
      LOC:ActualId=0
   END
   LOOP LOC:Index=1 to RECORDS(SELF.QB)
        GET(SELF.QB,LOC:Index)
        IF NOT ERRORCODE() THEN
           SELF.BreakId = SELF.QB.Id
           SELF.QB.ThisBreak.AddField(LevelField)
        END
   END
   IF LOC:ActualId THEN
      SELF.BreakId=LOC:ActualId
      GET(SELF.QB,SELF.BreakId)
      IF ERRORCODE() THEN
         SELF.BreakId=0
      END
   END
BreakManagerClass.AddField                PROCEDURE(*? LevelField)!Add a field to be restored to the last Level added
 CODE
    IF SELF.BreakId>0 THEN
       SELF.AddField(SELF.BreakId,LevelField)
    ELSE
       IF RECORDS(SELF.QB) THEN
          SELF.AddField(1,LevelField)
       END
    END
BreakManagerClass.AskBreak                PROCEDURE(BYTE Force=0) !Execute the Break if some Break field change, at the end of the loop it need to be called with Force = True to close all the open Break and execute and close the last Break
LOC:Index   SHORT
 CODE
   LOOP LOC:Index=1 to RECORDS(SELF.QB)
        GET(SELF.QB,LOC:Index)
        IF NOT ERRORCODE() THEN
           SELF.BreakId = SELF.QB.Id
           SELF.QB.ThisBreak.AskLevel(Force)
        END
   END
BreakManagerClass.TakeStart               PROCEDURE(SHORT BreakId,SHORT LevelId)!Virtual method than is called when a new Break is open
 CODE
BreakManagerClass.TakeEnd                 PROCEDURE(SHORT BreakId,SHORT LevelId)!Virtual method than is called when a Break is closed
 CODE
BreakManagerClass.UpdateTotal             PROCEDURE(SHORT BreakId,SHORT LevelId)!Calculate the Break's totaling
 CODE
    GET(SELF.QB,BreakId)
    IF NOT ERRORCODE() THEN
       SELF.BreakId = SELF.QB.Id
       SELF.QB.ThisBreak.UpdateTotal(LevelId)
    END
BreakManagerClass.AddTotalToBreak                PROCEDURE(SHORT BreakId,*? Target,*? Source,Byte Type,BYTE ResetOnLevel) !Add a total field to the last Level added
 CODE
    GET(SELF.QB,BreakId)
    IF NOT ERRORCODE() THEN
       SELF.BreakId = SELF.QB.Id
       SELF.QB.ThisBreak.AddTotal(Target,Source,Type,ResetOnLevel)
    END
BreakManagerClass.AddTotalToBreak                PROCEDURE(SHORT BreakId,*? Target,*? Source,Byte Type,BYTE ResetOnLevel,STRING Condition) !Add a conditional total field to the last Level added
 CODE
    GET(SELF.QB,BreakId)
    IF NOT ERRORCODE() THEN
       SELF.BreakId = SELF.QB.Id
       SELF.QB.ThisBreak.AddTotal(Target,Source,Type,ResetOnLevel,Condition)
    END
BreakManagerClass.AddTotalToBreak                PROCEDURE(SHORT BreakId,*? Target,BYTE ResetOnLevel)!Add a counter field to the last Level added
 CODE
    GET(SELF.QB,BreakId)
    IF NOT ERRORCODE() THEN
       SELF.BreakId = SELF.QB.Id
       SELF.QB.ThisBreak.AddTotal(Target,ResetOnLevel)
    END
BreakManagerClass.AddTotalToBreak                PROCEDURE(SHORT BreakId,*? Target,BYTE ResetOnLevel,STRING Condition)!Add a conditional counter field to the last Level added
 CODE
    GET(SELF.QB,BreakId)
    IF NOT ERRORCODE() THEN
       SELF.BreakId = SELF.QB.Id
       SELF.QB.ThisBreak.AddTotal(Target,ResetOnLevel,Condition)
    END
BreakManagerClass.AddTotal                PROCEDURE(*? Target,*? Source,Byte Type,BYTE ResetOnLevel) !Add a total field to the last Level added
 CODE
    IF SELF.BreakId>0 THEN
       SELF.AddTotalToBreak(SELF.BreakId,Target,Source,Type,ResetOnLevel)
    ELSE
       IF RECORDS(SELF.QB) THEN
          SELF.AddTotalToBreak(1,Target,Source,Type,ResetOnLevel)
       END
    END
BreakManagerClass.AddTotal                PROCEDURE(*? Target,*? Source,Byte Type,BYTE ResetOnLevel,STRING Condition) !Add a conditional total field to the last Level added
 CODE
    IF SELF.BreakId>0 THEN
       SELF.AddTotalToBreak(SELF.BreakId,Target,Source,Type,ResetOnLevel,Condition)
    ELSE
       IF RECORDS(SELF.QB) THEN
          SELF.AddTotalToBreak(1,Target,Source,Type,ResetOnLevel,Condition)
       END
    END
BreakManagerClass.AddTotal                PROCEDURE(*? Target,BYTE ResetOnLevel)!Add a counter field to the last Level added
 CODE
    IF SELF.BreakId>0 THEN
       SELF.AddTotalToBreak(SELF.BreakId,Target,ResetOnLevel)
    ELSE
       IF RECORDS(SELF.QB) THEN
          SELF.AddTotalToBreak(1,Target,ResetOnLevel)
       END
    END
BreakManagerClass.AddTotal                PROCEDURE(*? Target,BYTE ResetOnLevel,STRING Condition)!Add a conditional counter field to the last Level added
 CODE
    IF SELF.BreakId>0 THEN
       SELF.AddTotalToBreak(SELF.BreakId,Target,ResetOnLevel,Condition)
    ELSE
       IF RECORDS(SELF.QB) THEN
          SELF.AddTotalToBreak(1,Target,ResetOnLevel,Condition)
       END
    END
LevelManagerClass.CONSTRUCT PROCEDURE()
 CODE
  SELF.Q     &= NEW(LevelsQueue)
  SELF.OQ    &= NEW(ResetFieldsQueue)
  SELF.BkId   = 0
LevelManagerClass.DESTRUCT  PROCEDURE()
LOC:Index   SHORT
 CODE
  LOOP LOC:Index=1 TO RECORDS(SELF.Q)
       GET(SELF.Q,LOC:Index)
       FREE(SELF.Q.Fields)
       DESTROY(SELF.Q.Fields)
       FREE(SELF.Q.Totals)
       DESTROY(SELF.Q.Totals)
  END
  FREE(SELF.Q)
  FREE(SELF.OQ)
  DESTROY(SELF.Q)
  DESTROY(SELF.OQ)
LevelManagerClass.Init       PROCEDURE(BreakManagerClass pParent,SHORT BreakId) !Init the object
 CODE
   SELF.BkId      = BreakId
   SELF.BkManager &= pParent
   SELF.Init()

LevelManagerClass.Init            PROCEDURE()
 CODE
  IF SELF.IsOpen = True THEN RETURN.
  SELF.Level   = 0
  SELF.Force   = False
  SELF.IsOpen  = False
  SELF.IsSaved = False
  SELF.Records = 0
!***********************************************************

LevelManagerClass.Kill            PROCEDURE()
LOC:Index   SHORT
 CODE
  LOOP LOC:Index=1 TO RECORDS(SELF.Q)
       GET(SELF.Q,LOC:Index)
       FREE(SELF.Q.Fields)
       DESTROY(SELF.Q.Fields)
       FREE(SELF.Q.Totals)
       DESTROY(SELF.Q.Totals)
  END
  FREE(SELF.Q)
  FREE(SELF.OQ)
  SELF.Level  = 0
  SELF.Force  = False
  SELF.IsOpen = False
  SELF.IsSaved=False
!***********************************************************

LevelManagerClass.Reset           PROCEDURE()
LOC:Index   SHORT
LOC:Index2   SHORT
 CODE
  LOOP LOC:Index=1 TO RECORDS(SELF.Q)
       GET(SELF.Q,LOC:Index)
       SELF.Q.Records = 0
       LOOP LOC:Index2=1 TO RECORDS(SELF.Q.Fields)
            GET(SELF.Q.Fields,LOC:Index2)
            SELF.Q.Fields.LastValue=''
            SELF.Q.Fields.SavedValue=''
            PUT(SELF.Q.Fields)
       END
       LOOP LOC:Index2=1 TO RECORDS(SELF.Q.Totals)
          GET(SELF.Q.Totals,LOC:Index2)
          SELF.Q.Totals.Target    = 0
          SELF.Q.Totals.AuxTarget = 0
          PUT(SELF.Q.Totals)
       END
       PUT(SELF.Q)
  END
  SELF.Level  = 0
  SELF.Force  = False
  SELF.IsOpen = False
  SELF.IsSaved= False
  SELF.Records= 0
!***********************************************************

LevelManagerClass.GetLevel           FUNCTION()
 CODE
 RETURN SELF.Level
!***********************************************************

LevelManagerClass.GetRecords           FUNCTION()
 CODE
 RETURN SELF.Records
!***********************************************************

LevelManagerClass.GetRecords      FUNCTION(SHORT LevelId)
 CODE
  GET(SELF.Q,LevelId)
  RETURN SELF.Q.Records
!***********************************************************

LevelManagerClass.AddLevel        PROCEDURE()
 CODE
  CLEAR(SELF.Q)
  SELF.Q.Fields &= NEW(ResetFieldsQueue)
  SELF.Q.Totals &= NEW(TotalingFieldsQueue)
  SELF.Q.Records = 0
  ADD(SELF.Q)
!***********************************************************

LevelManagerClass.AddResetField   PROCEDURE(*? LevelField)
LocalField  ANY
LOC:Index   SHORT
 CODE
  LocalField &= LevelField
  LOOP LOC:Index=1 TO RECORDS(SELF.OQ)
       GET(SELF.OQ,LOC:Index)
       IF LocalField &= SELF.OQ.FieldValue THEN
          DELETE(SELF.OQ)
       END
  END
  GET(SELF.Q,RECORDS(SELF.Q))
  CLEAR(SELF.Q.Fields)
  SELF.Q.Fields.FieldValue &= LevelField
  SELF.Q.Fields.LastValue=''
  SELF.Q.Fields.SavedValue=''
  ADD(SELF.Q.Fields)
!***********************************************************

LevelManagerClass.AddField        PROCEDURE(*? SavedField)
LocalField  ANY
Exist       BYTE
LOC:Index   SHORT
LOC:Index2  SHORT
 CODE
  Exist       = False
  LocalField &= SavedField
  LOOP LOC:Index=1 TO RECORDS(SELF.Q)
       GET(SELF.Q,LOC:Index)
       LOOP LOC:Index2=1 TO RECORDS(SELF.Q.Fields)
            GET(SELF.Q.Fields,LOC:Index2)
            IF LocalField &= SELF.Q.Fields.FieldValue THEN
               Exist=True
               Break
            END
       END
       IF Exist=True THEN BREAK.
  END
  IF Exist=False THEN
     LOOP LOC:Index=1 TO RECORDS(SELF.OQ)
          GET(SELF.OQ,LOC:Index)
          IF LocalField &= SELF.OQ.FieldValue THEN
             Exist=True
             Break
          END
     END
  END
  IF Exist=False THEN
     CLEAR(SELF.OQ)
     SELF.OQ.FieldValue &= SavedField
     SELF.OQ.SavedValue  = ''
     SELF.OQ.LastValue  = ''
     ADD(SELF.OQ)
  END
!***********************************************************

LevelManagerClass.AddTotal    PROCEDURE(*? Target,BYTE ResetOnLevel)
  CODE
     GET(SELF.Q,RECORDS(SELF.Q))
     CLEAR(SELF.Q.Totals)
     SELF.Q.Totals.Source = ''
     SELF.Q.Totals.AuxTarget=0
     SELF.Q.Totals.Target &= Target
     SELF.Q.Totals.Type    = 1
     SELF.Q.Totals.ResetOnLevel = ResetOnLevel
     SELF.Q.Totals.Condition = ''
     ADD(SELF.Q.Totals)
!***********************************************************

LevelManagerClass.AddTotal    PROCEDURE(*? Target,BYTE ResetOnLevel,STRING Condition)
  CODE
     GET(SELF.Q,RECORDS(SELF.Q))
     CLEAR(SELF.Q.Totals)
     SELF.Q.Totals.Source = ''
     SELF.Q.Totals.AuxTarget=0
     SELF.Q.Totals.Target &= Target
     SELF.Q.Totals.Type    = 1
     SELF.Q.Totals.ResetOnLevel = ResetOnLevel
     SELF.Q.Totals.Condition = Condition
     ADD(SELF.Q.Totals)
!***********************************************************

LevelManagerClass.AddTotal    PROCEDURE(*? Target,*? Source,Byte Type,BYTE ResetOnLevel)
  CODE
     GET(SELF.Q,RECORDS(SELF.Q))
     CLEAR(SELF.Q.Totals)
     SELF.Q.Totals.Source &= Source
     SELF.Q.Totals.Target &= Target
     SELF.Q.Totals.AuxTarget=0
     SELF.Q.Totals.Type    = Type
     SELF.Q.Totals.ResetOnLevel = ResetOnLevel
     SELF.Q.Totals.Condition = ''
     ADD(SELF.Q.Totals)
!***********************************************************

LevelManagerClass.AddTotal    PROCEDURE(*? Target,*? Source,Byte Type,BYTE ResetOnLevel,STRING Condition)
  CODE
     GET(SELF.Q,RECORDS(SELF.Q))
     CLEAR(SELF.Q.Totals)
     SELF.Q.Totals.Source &= Source
     SELF.Q.Totals.Target &= Target
     SELF.Q.Totals.AuxTarget=0
     SELF.Q.Totals.Type    = Type
     SELF.Q.Totals.ResetOnLevel = ResetOnLevel
     SELF.Q.Totals.Condition = Condition
     ADD(SELF.Q.Totals)
!***********************************************************

LevelManagerClass.AskLevel        PROCEDURE(BYTE Force=0)
LOC:Index   SHORT
 CODE
  SELF.Force = Force
  SELF.Records +=1
  LOOP LOC:Index=1 TO RECORDS(SELF.Q)
       GET(SELF.Q,LOC:Index)
       IF SELF.EvaluateLevel(LOC:Index) OR SELF.IsOpen=False OR (SELF.Force=True AND LOC:Index=1) THEN
          SELF.AskLevelOff(LOC:Index)
          SELF.AskLevelOn(LOC:Index)
          BREAK
       END
  END
  LOOP LOC:Index=1 TO RECORDS(SELF.Q)
       IF SELF.BkId>0 THEN
          SELF.BkManager.UpdateTotal(SELF.BkId,LOC:Index)
       ELSE
          SELF.UpdateTotal(LOC:Index)
       END
  END
  SELF.SaveBuffer()
!***********************************************************

LevelManagerClass.AskLevelOn      PROCEDURE(SHORT LevelId)
 CODE
  IF SELF.Force = True THEN RETURN.
  SELF.RefreshFields(LevelId)
  SELF.Level = LevelId
  IF SELF.BkId>0 THEN
     SELF.BkManager.TakeStart(SELF.BkId,LevelId)
  ELSE
     SELF.TakeStart(LevelId)
  END
  IF LevelId<RECORDS(SELF.Q) THEN
     SELF.AskLevelOn(LevelId+1)
  ELSE
     SELF.IsOpen = True
  END
!***********************************************************

LevelManagerClass.AskLevelOff     PROCEDURE(SHORT LevelId)
LOC:Index   SHORT
 CODE
  IF SELF.IsOpen = False THEN RETURN.
  SELF.SaveResetBuffer(LevelId)
  IF LevelId<RECORDS(SELF.Q) THEN
     SELF.AskLevelOff(LevelId+1)
     LOOP LOC:Index=LevelId+1 TO RECORDS(SELF.Q)
          SELF.SaveResetBuffer(LOC:Index)
     END
  END
  SELF.Level = LevelId
  SELF.RestoreBufferOn()
  IF SELF.BkId>0 THEN
     SELF.BkManager.TakeEnd(SELF.BkId,LevelId)
  ELSE
     SELF.TakeEnd(LevelId)
  END
  SELF.RestoreBufferOff()
  LOOP LOC:Index=RECORDS(SELF.Q) TO LevelId BY -1
       SELF.RestoreResetBuffer(LOC:Index)
  END
  SELF.ResetTotals(LevelId)
!***********************************************************

LevelManagerClass.TakeStart       PROCEDURE(SHORT LevelId)
 CODE
  RETURN
!***********************************************************

LevelManagerClass.TakeEnd         PROCEDURE(SHORT LevelId)
 CODE
  RETURN
!***********************************************************

LevelManagerClass.RefreshFields   PROCEDURE(SHORT LevelId)
LOC:Index   SHORT
 CODE
  GET(SELF.Q,LevelId)
  IF NOT ERRORCODE() THEN
     SELF.Q.Records +=1
     LOOP LOC:Index=1 TO RECORDS(SELF.Q.Fields)
          GET(SELF.Q.Fields,LOC:Index)
          SELF.Q.Fields.LastValue = SELF.Q.Fields.FieldValue
          PUT(SELF.Q.Fields)
     END
  ELSE
     MESSAGE('Error Trying to Fetch the LevelId='&LevelId&'|This LevelId does not exist on the this Level manager.|Error:'&ERROR()&'|Errorcode='&Errorcode())
  END
!***********************************************************

LevelManagerClass.SaveResetBuffer      PROCEDURE(SHORT LevelId)
LOC:Index   SHORT
 CODE
  GET(SELF.Q,LevelId)
  IF NOT ERRORCODE() THEN
     LOOP LOC:Index=1 TO RECORDS(SELF.Q.Fields)
          GET(SELF.Q.Fields,LOC:Index)
          SELF.Q.Fields.SavedValue = SELF.Q.Fields.FieldValue
          SELF.Q.Fields.FieldValue = SELF.Q.Fields.LastValue
          PUT(SELF.Q.Fields)
     END
  END
!***********************************************************

LevelManagerClass.RestoreResetBuffer   PROCEDURE(SHORT LevelId)
LOC:Index   SHORT
 CODE
  GET(SELF.Q,LevelId)
  IF NOT ERRORCODE() THEN
     LOOP LOC:Index=1 TO RECORDS(SELF.Q.Fields)
          GET(SELF.Q.Fields,LOC:Index)
          SELF.Q.Fields.FieldValue = SELF.Q.Fields.SavedValue
          PUT(SELF.Q.Fields)
     END
  END
!***********************************************************

LevelManagerClass.SaveBuffer      PROCEDURE()
LOC:Index   SHORT
 CODE
  LOOP LOC:Index=1 TO RECORDS(SELF.OQ)
       GET(SELF.OQ,LOC:Index)
       SELF.OQ.LastValue = SELF.OQ.FieldValue
       PUT(SELF.OQ)
  END
  SELF.IsSaved = True
!***********************************************************

LevelManagerClass.RestoreBufferOn   PROCEDURE()
LOC:Index   SHORT
 CODE
  IF SELF.IsSaved = False THEN RETURN.
     LOOP LOC:Index=1 TO RECORDS(SELF.OQ)
          GET(SELF.OQ,LOC:Index)
          SELF.OQ.SavedValue = SELF.OQ.FieldValue
          SELF.OQ.FieldValue = SELF.OQ.LastValue
          PUT(SELF.OQ)
     END
!***********************************************************
LevelManagerClass.RestoreBufferOff   PROCEDURE()
LOC:Index   SHORT
 CODE
  IF SELF.IsSaved = False THEN RETURN.
     LOOP LOC:Index=1 TO RECORDS(SELF.OQ)
          GET(SELF.OQ,LOC:Index)
          SELF.OQ.FieldValue = SELF.OQ.SavedValue
          PUT(SELF.OQ)
     END
!***********************************************************

LevelManagerClass.EvaluateLevel   PROCEDURE(SHORT LevelId)
LOC:Index   SHORT
ReturnValue BYTE
 CODE
  ReturnValue = False
  GET(SELF.Q,LevelId)
  IF NOT ERRORCODE() THEN
     ReturnValue = True
     LOOP LOC:Index=1 TO RECORDS(SELF.Q.Fields)
          GET(SELF.Q.Fields,LOC:Index)
          IF ReturnValue AND NOT (SELF.Q.Fields.LastValue=SELF.Q.Fields.FieldValue) THEN
             ReturnValue = True
          ELSE
             ReturnValue = False
             Break
          END
     END
  END
 RETURN ReturnValue
!***********************************************************

LevelManagerClass.UpdateTotal        PROCEDURE(SHORT LevelId)
LOC:Index   SHORT
LOC:OK      BYTE
 CODE
  GET(SELF.Q,LevelId)
  IF NOT ERRORCODE() THEN
     SELF.Q.Records += 1
     LOOP LOC:Index=1 TO RECORDS(SELF.Q.Totals)
          GET(SELF.Q.Totals,LOC:Index)
          IF SELF.Q.Totals.Condition THEN
              LOC:OK = EVALUATE(CLIP(SELF.Q.Totals.Condition))
              IF ERRORCODE() THEN
                 MESSAGE('Error in expresion:|',CLIP(SELF.Q.Totals.Condition)&'|Result='&LOC:OK,'Error in Expresion')
              END
              IF LOC:OK THEN
                 CASE SELF.Q.Totals.Type
                 OF eBreakTotalCnt!Contador
                    SELF.Q.Totals.Target    += 1
                 OF eBreakTotalAve!Promedio
                    SELF.Q.Totals.AuxTarget += SELF.Q.Totals.Source
                    SELF.Q.Totals.Target     = SELF.Q.Totals.AuxTarget/SELF.Q.Records
                 OF eBreakTotalSum!Total
                    SELF.Q.Totals.Target    += SELF.Q.Totals.Source
                 END
                 PUT(SELF.Q.Totals)
              END
          ELSE
              CASE SELF.Q.Totals.Type
              OF eBreakTotalCnt!Contador
                 SELF.Q.Totals.Target    += 1
              OF eBreakTotalAve!Promedio
                 SELF.Q.Totals.AuxTarget += SELF.Q.Totals.Source
                 SELF.Q.Totals.Target     = SELF.Q.Totals.AuxTarget/SELF.Q.Records
              OF eBreakTotalSum!Total
                 SELF.Q.Totals.Target    += SELF.Q.Totals.Source
              END
              PUT(SELF.Q.Totals)
          END
     END
     PUT(SELF.Q)
  END
  RETURN
!***********************************************************

LevelManagerClass.ResetTotals      PROCEDURE(SHORT LevelId)
LOC:Index   SHORT
 CODE
  GET(SELF.Q,LevelId)
  IF NOT ERRORCODE() THEN
     SELF.Q.Records = 0
     PUT(SELF.Q)
     LOOP LOC:Index=1 TO RECORDS(SELF.Q.Totals)
          GET(SELF.Q.Totals,LOC:Index)
          IF SELF.Q.Totals.ResetOnLevel THEN
             SELF.Q.Totals.AuxTarget = 0
             SELF.Q.Totals.Target = 0
             PUT(SELF.Q.Totals)
          END
     END
  END
!***********************************************************
