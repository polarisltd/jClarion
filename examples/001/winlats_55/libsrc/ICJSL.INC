OMIT('_EndOfInclude_',_ICJslPresent_)
_ICJslPresent_ EQUATE(1)

INCLUDE('ICFILES.INC')
INCLUDE('ICTXTOUT.INC')
INCLUDE('ICSINK.INC')
INCLUDE('ICCLIENT.INC')

                     ITEMIZE,PRE(JSL)
ListRecords            EQUATE(VAL('R'))
ListFields             EQUATE(VAL('F'))
ListSelection          EQUATE(VAL('S'))
ListThumb              EQUATE(VAL('M'))
ListHScroll            EQUATE(VAL('H'))
ListVScroll            EQUATE(VAL('V'))
ListFormat             EQUATE(VAL('A'))
ListIcon               EQUATE(VAL('I'))
Picture                EQUATE(VAL('P'))

Disable                EQUATE(VAL('D'))
Enable                 EQUATE(VAL('E'))

StringText             EQUATE(VAL('T'))
                     END

JslManagerClass      CLASS, TYPE,MODULE('ICJSL.CLW'),LINK('ICJSL',LinkBaseClasses),DLL(BaseClassDllMode)
AddQueueEntry          PROCEDURE(SIGNED CurFeq, SIGNED Index, LONG Format=0)
BeginUpdate            PROCEDURE(SIGNED Id)
CloseChannel           PROCEDURE
Init                   PROCEDURE(*WebClientManagerInterface)
Kill                   PROCEDURE
OpenChannel            PROCEDURE(SIGNED, *WebFilesClass)
RemoveAllQueueEntries  PROCEDURE
RemoveQueueEntries     PROCEDURE(SIGNED Index, SIGNED Number)
ScrollQueueDown        PROCEDURE(SIGNED CurFeq, SIGNED Index, LONG Format=0)
ScrollQueueUp          PROCEDURE(SIGNED CurFeq, SIGNED Index, LONG Format=0)
SelectControl          PROCEDURE(SIGNED)
SetAttribute           PROCEDURE(BYTE Which)
SetAttribute           PROCEDURE(BYTE Which, STRING Value)
SetAttributeFilename   PROCEDURE(BYTE Which, STRING Value)
SetAttributeLong       PROCEDURE(BYTE Which, LONG Value)
SetChecked             PROCEDURE(SIGNED Feq, BYTE IsChecked)
SetIconAttribute       PROCEDURE(SIGNED CurIndex, STRING Filename)
SetListChoice          PROCEDURE(SIGNED Feq, SIGNED Selected)
SetQueueEntry          PROCEDURE(SIGNED CurFeq, SIGNED Index, LONG Format=0)
SetValue               PROCEDURE(SIGNED Feq, ? NewValue)

Client                 &WebClientManagerInterface,PROTECTED
Security               SIGNED
Files                  &WebFilesClass,PROTECTED
LastId                 SIGNED,PRIVATE
NextId                 SIGNED,PRIVATE
Target                 &TextOutputClass,PROTECTED
                     END
_EndOfInclude_
