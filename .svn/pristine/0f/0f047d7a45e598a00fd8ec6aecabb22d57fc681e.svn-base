!ABCIncludeFile
OMIT('_EndOfInclude_',_vsaClipPresent_)
_vsaClipPresent_ EQUATE(1)

vsClipboardClass CLASS,TYPE,MODULE('VSA_CLIP.CLW'),LINK('VSA_CLIP.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Thread                  LONG
CopyControl             LONG
CutControl              LONG
PasteControl            LONG
LastContents            STRING(1024)
LastField               LONG
LastThread              LONG
LastClipboard           STRING(1024)
Init                    PROCEDURE(LONG pThread,LONG pCopyControl,LONG pCutControl,LONG pPasteControl)
Init                    PROCEDURE()
TakeEvent               PROCEDURE(),LONG
Kill                    PROCEDURE()
                  END

_EndOfInclude_
