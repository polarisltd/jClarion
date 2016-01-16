!ABCIncludeFile

  OMIT('_EndOfInclude_',_vsEntryCompletionPresent_)
_vsEntryCompletionPresent_ EQUATE(1)

  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('ABFILE.INC'),ONCE

eQueueBased EQUATE(0)
eFileBased  EQUATE(1)

EntryCompletionClass CLASS,MODULE('VSA_ENTC.CLW'),TYPE,LINK('VSA_ENTC.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Mode                  BYTE,PRIVATE
UseField              ANY,PROTECTED                                                         !Reference to combos use variable
FromField             ANY,PROTECTED                                                         !Reference to combos use variable
EntryField            SIGNED,PRIVATE
Q                     &QUEUE,PRIVATE                                                        !Reference to list box queue
ECOn                  BYTE,PRIVATE
MustValidate          BYTE,PRIVATE
WindowAutoDisplay     BYTE,PRIVATE
FileMgr               &FileManager
FileKey               &Key

Init                  PROCEDURE(*? UseField,LONG EntryField,QUEUE Q,BYTE MustValidate)
Init                  PROCEDURE(*? UseField,LONG EntryField,*? FromField,BYTE MustValidate,FileManager FileMgr,KEY MyKey)
Kill                  PROCEDURE
TakeEvent             PROCEDURE(),VIRTUAL
TakeAccepted          PROCEDURE(),VIRTUAL
TakeNewSelection      PROCEDURE(),VIRTUAL
TakeNewSelection      PROCEDURE(SIGNED Field),VIRTUAL
GetQueueMatch         PROCEDURE(STRING LookFor),LONG,PROTECTED
KeyValid              PROCEDURE(),BYTE,VIRTUAL
                    END

  _EndOfInclude_
