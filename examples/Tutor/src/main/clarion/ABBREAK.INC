!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_BreakManagerClassPresente_)
_BreakManagerClassPresente_ EQUATE(1)

!Totaling EQUATES
eBreakTotalCnt       EQUATE(1)
eBreakTotalAve       EQUATE(2)
eBreakTotalSum       EQUATE(3)

ResetFieldsQueue QUEUE,TYPE
FieldValue          ANY
LastValue           ANY
SavedValue          ANY
                 END
TotalingFieldsQueue QUEUE,TYPE
Source              ANY
Target              ANY
AuxTarget           ANY
Type                BYTE
ResetOnLevel        BYTE
Condition           STRING(200)
                END
FieldsQueue     QUEUE,TYPE
FieldValue          ANY
SavedValue          ANY
                END
LevelsQueue     QUEUE,TYPE
Fields              &ResetFieldsQueue
Totals              &TotalingFieldsQueue
Records             LONG
                END
BreaksQueue     QUEUE,TYPE
Id              LONG
ThisBreak       &LevelManagerClass
                END

BreakManagerClass    CLASS,MODULE('ABBreak.CLW'),TYPE,LINK('ABBreak.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
QB                      &BreaksQueue,PRIVATE
BreakId                 SHORT,PRIVATE
GetBreak                FUNCTION(),SHORT !Return nested Break number where the Level is
GetLevel                FUNCTION(SHORT BreakId),SHORT !Return nested level number where the Level is
GetRecords              FUNCTION(SHORT BreakId),LONG  !Return records readed
GetRecords              FUNCTION(SHORT BreakId,SHORT LevelId),LONG !Return numbers of records readed on each level, it's reset to cero on each Level
GetLevel                FUNCTION(),SHORT!Return nested level number where the Level is
GetRecords              FUNCTION(),LONG  !Return records readed
GetRecordsOnLevel       FUNCTION(SHORT LevelId),LONG !Return numbers of records readed on each level, it's reset to cero on each Level
Init                    PROCEDURE() !Init the object
Kill                    PROCEDURE() !Kill the object
Reset                   PROCEDURE() !Reset the Level's fields value and the total fields values
Reset                   PROCEDURE(SHORT BreakId) !Reset the Level's fields value and the total fields values
AddBreak                PROCEDURE() !add a Break
AddLevel                PROCEDURE() !add a Level
AddLevel                PROCEDURE(SHORT BreakId) !add a Level to the BreakId Break
AddResetField           PROCEDURE(*? LevelField)!Add a reset field to the last Level added
AddHotField             PROCEDURE(*? LevelField)!Add a field to be restored to All Level added
AddField                PROCEDURE(*? LevelField)!Add a field to be restored to the last Level added
AddField                PROCEDURE(SHORT BreakId,*? LevelField)!Add a field to be restored to the break Level
AddTotal                PROCEDURE(*? Target,*? Source,Byte Type,BYTE ResetOnLevel) !Add a total field to the last Level added
AddTotal                PROCEDURE(*? Target,*? Source,Byte Type,BYTE ResetOnLevel,STRING Condition) !Add a conditional total field to the last Level added
AddTotal                PROCEDURE(*? Target,BYTE ResetOnLevel)!Add a counter field to the last Level added
AddTotal                PROCEDURE(*? Target,BYTE ResetOnLevel,STRING Condition)!Add a conditional counter field to the last Level added
AddResetField           PROCEDURE(SHORT BreakId,*? LevelField)!Add a reset field to the last Level added
AddTotalToBreak         PROCEDURE(SHORT BreakId,*? Target,*? Source,Byte Type,BYTE ResetOnLevel) !Add a total field to the last Level added
AddTotalToBreak         PROCEDURE(SHORT BreakId,*? Target,*? Source,Byte Type,BYTE ResetOnLevel,STRING Condition) !Add a conditional total field to the last Level added
AddTotalToBreak         PROCEDURE(SHORT BreakId,*? Target,BYTE ResetOnLevel)!Add a counter field to the last Level added
AddTotalToBreak         PROCEDURE(SHORT BreakId,*? Target,BYTE ResetOnLevel,STRING Condition)!Add a conditional counter field to the last Level added
AskBreak                PROCEDURE(BYTE Force=0) !Execute the Break if some Break field change, at the end of the loop it need to be called with Force = True to close all the open Break and execute and close the last Break
TakeStart               PROCEDURE(SHORT BreakId,SHORT LevelId),VIRTUAL!Virtual method than is called when a new Break is open
TakeEnd                 PROCEDURE(SHORT BreakId,SHORT LevelId),VIRTUAL!Virtual method than is called when a Break is closed
UpdateTotal             PROCEDURE(SHORT BreakId,SHORT LevelId),VIRTUAL!Calculate the Break's totaling
CONSTRUCT               PROCEDURE()!,FINAL
DESTRUCT                PROCEDURE()!,FINAL
                     END
LevelManagerClass    CLASS,MODULE('ABBreak.CLW'),TYPE,LINK('ABBreak.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
BkId                    SHORT,PRIVATE
BkManager               &BreakManagerClass,PRIVATE
Q                       &LevelsQueue,PRIVATE
OQ                      &ResetFieldsQueue,PRIVATE
Level                   SHORT,PRIVATE
Force                   BYTE,PRIVATE
IsOpen                  BYTE,PRIVATE
IsSaved                 BYTE,PRIVATE
Records                 LONG,PRIVATE
GetLevel                FUNCTION(),SHORT !Return nested level number where the Level is
GetRecords              FUNCTION(),LONG  !Return records readed
GetRecords              FUNCTION(SHORT LevelId),LONG !Return numbers of records readed on each level, it's reset to cero on each Level
Init                    PROCEDURE(BreakManagerClass pParent,SHORT BreakId) !Init the object
Init                    PROCEDURE() !Init the object
Kill                    PROCEDURE() !Kill the object
Reset                   PROCEDURE() !Reset the Level's fields value and the total fields values
AddLevel                PROCEDURE() !add a Level
AddResetField           PROCEDURE(*? LevelField)!Add a reset field to the last Level added
AddField                PROCEDURE(*? LevelField)!Add a field to be restored to the last Level added
AddTotal                PROCEDURE(*? Target,*? Source,Byte Type,BYTE ResetOnLevel) !Add a total field to the last Level added
AddTotal                PROCEDURE(*? Target,*? Source,Byte Type,BYTE ResetOnLevel,STRING Condition) !Add a conditional total field to the last Level added
AddTotal                PROCEDURE(*? Target,BYTE ResetOnLevel)!Add a counter field to the last Level added
AddTotal                PROCEDURE(*? Target,BYTE ResetOnLevel,STRING Condition)!Add a conditional counter field to the last Level added
AskLevel                PROCEDURE(BYTE Force=0) !Execute the Level if some Level field change, at the end of the loop it need to be called with Force = True to close all the open level and execute and close the last Level
AskLevelOn              PROCEDURE(SHORT LevelId),PRIVATE!Open a new nested level
AskLevelOff             PROCEDURE(SHORT LevelId),PRIVATE!Close an open level
ResetTotals             PROCEDURE(SHORT LevelId),PRIVATE!Reset level's totaling
RefreshFields           PROCEDURE(SHORT LevelId),PRIVATE!Refresh Level's fields values
SaveBuffer              PROCEDURE(),PRIVATE!Save hot fields values
RestoreBufferOn         PROCEDURE(),PRIVATE!Restore hot fields values
RestoreBufferOff        PROCEDURE(),PRIVATE!Restore hot fields values
SaveResetBuffer         PROCEDURE(SHORT LevelId),PRIVATE!Save Level's fields values
RestoreResetBuffer      PROCEDURE(SHORT LevelId),PRIVATE!Restore Level's fields values
EvaluateLevel           PROCEDURE(SHORT LevelId),BYTE,PRIVATE!Return true if the Level need to be executed
TakeStart               PROCEDURE(SHORT LevelId),VIRTUAL!Virtual method than is called when a new level is open
TakeEnd                 PROCEDURE(SHORT LevelId),VIRTUAL!Virtual method than is called when a level is closed
UpdateTotal             PROCEDURE(SHORT LevelId),VIRTUAL!Calculate the level's totaling
CONSTRUCT               PROCEDURE()!,FINAL
DESTRUCT                PROCEDURE()!,FINAL
                   END

 _EndOfInclude_
