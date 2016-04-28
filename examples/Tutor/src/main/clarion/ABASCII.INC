!Ascii File Viewer - Class definitions

!ABCIncludeFile

OMIT('_EndOfInclude_',_ASCIIPRESENT_)
_ASCIIPRESENT_   EQUATE(1)

   INCLUDE('ABPOPUP.INC'),ONCE

! ----------------------------------------------------------------------------
! The AsciiFileClass is used to retrieve data from an ascii file, for display
! by the AsciiViewerClass
! ----------------------------------------------------------------------------

AsciiFileClass      CLASS,TYPE,MODULE('ABASCII.CLW'),LINK('ABASCII.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
AsciiFile             &FILE
Line                  &STRING,PRIVATE
ErrorMgr              &ErrorClass,PROTECTED
IndexQueue            &IndexQueue,PRIVATE
FileSize              UNSIGNED,AUTO,PRIVATE
NumberBuffers         UNSIGNED,AUTO,PRIVATE
OpenMode              UNSIGNED

FormatLine            PROCEDURE(*STRING TextLine),PROTECTED,VIRTUAL              !Allows line formating at run-time
FormatLine            PROCEDURE(*STRING TextLine,LONG LineNo),PROTECTED,VIRTUAL  !ditto and supplies line number
GetDOSFilename        PROCEDURE(*STRING Dest),BYTE,VIRTUAL                       !Requests filename from user
GetFilename           PROCEDURE(),STRING
GetLastLineNo         PROCEDURE(),LONG,PROC                                      !returns no of last line in file - forces index of whole file
GetLine               PROCEDURE(LONG Number),STRING,PROC                         !retuns line/ force index to LineNo
GetPercentile         PROCEDURE(LONG Number),USHORT                              !return 0 - 100 (%age through file)
Init                  PROCEDURE(FILE AsciiFile,*STRING TextLine,*STRING Filename,ErrorClass ErrorHandler),BYTE   !,EXTENDS
Kill                  PROCEDURE
Reset                 PROCEDURE(*STRING Filename),BYTE
SetLine               PROCEDURE(LONG Number),PROTECTED,VIRTUAL
SetPercentile         PROCEDURE(USHORT Percentage)                               !sets to line %age of way through file
ValidateLine          PROCEDURE(STRING TextLine),BYTE,PROTECTED,VIRTUAL          !Allows line filtering, return true to include line or false to exclude line
                    END



! ----------------------------------------------------------------------------
! The AsciiPrintClass is use to preview and print data displayed in the
! ascii viewer
! ----------------------------------------------------------------------------

AsciiPrintClass     CLASS,TYPE,MODULE('ABASCII.CLW'),DLL(_ABCDllMode_)
FileMgr               &AsciiFileClass,PROTECTED
Translator            &TranslatorClass,PROTECTED
PrintPreview          BYTE

Init                  PROCEDURE(AsciiFileClass FileManager),VIRTUAL
Ask                   PROCEDURE,VIRTUAL
PrintLines            PROCEDURE(LONG FirstLine,LONG LastLine),VIRTUAL
                    END



! ----------------------------------------------------------------------------
! The AsciiSearchClass is used to 'step through' the occurances of a search
! string in an ascii file. It is used by the AsciiViewerClass
! ----------------------------------------------------------------------------

FindGroup           GROUP,TYPE
What                  PSTRING(64)               !text to look for
MatchCase             BYTE                      !case sensitive?
Direction             STRING(4)                 !either 'Up  ' or 'Down'
                    END

AsciiSearchClass    CLASS,TYPE,MODULE('ABASCII.CLW'),DLL(_ABCDllMode_)
FileMgr               &AsciiFileClass,PROTECTED
Find                  LIKE(FindGroup),PROTECTED
LineCounter           LONG,PROTECTED
Translator            &TranslatorClass,PROTECTED

Ask                   PROCEDURE(LONG StartLine = 1),VIRTUAL
Init                  PROCEDURE(AsciiFileClass FileManager),VIRTUAL
Next                  PROCEDURE(),LONG,VIRTUAL
Setup                 PROCEDURE(*FindGroup Attributes,LONG StartLine=1)
                    END



! ----------------------------------------------------------------------------
! The AsciiViewerClass displays an ascii text file in a viewer window. The file
! is read 'as needed', it is not all read when the window opens
! ----------------------------------------------------------------------------

EnableSearch        BYTE(001b)
EnablePrint         BYTE(010b)

PreserveListBoxGroup GROUP,TYPE
IMMState              BYTE             !attribute states
HScrollState          BYTE
HScrollPos            UNSIGNED
VScrollState          BYTE
VScrollPos            UNSIGNED
Alrt                  LONG,DIM(3)
Format                STRING(255)      !list box format string
                    END

AsciiViewerClass    CLASS(AsciiFileClass),TYPE,MODULE('ABASCII.CLW'),DLL(_ABCDllMode_)    !ascii Viewer base class
DisplayQueue          &DisplayQueue,PRIVATE
LBPreserve            LIKE(PreserveListBoxGroup),PRIVATE
ListBox               UNSIGNED,PRIVATE
ListBoxItems          UNSIGNED,PRIVATE
TopLine               UNSIGNED
Popup                 &PopupClass
Searcher              &AsciiSearchClass
Translator            &TranslatorClass,PRIVATE
Printer               &AsciiPrintClass
SearcherSelfCreated   BYTE,PRIVATE
PrinterSelfCreated    BYTE,PRIVATE
AddItem               PROCEDURE(AsciiPrintClass Printer)
AddItem               PROCEDURE(AsciiSearchClass Searcher)
AskGotoLine           PROCEDURE
DisplayPage           PROCEDURE                                        !displays page from current top line
DisplayPage           PROCEDURE(LONG LineNumber)                           !Displays a new page with LineNo on it
DisplayPage           PROCEDURE(LONG StartLine,LONG EndLine,USHORT SelectLine),PRIVATE
Init                  PROCEDURE(FILE AsciiFile,*STRING FileLine,UNSIGNED ListBox,ErrorClass ErrHandler,BYTE Enables=0),BYTE  !,EXTENDS, !Use wil files with constant NAME() attribute
Init                  PROCEDURE(FILE AsciiFile,*STRING FileLine,*STRING Filename,UNSIGNED ListBox,ErrorClass ErrHandler,BYTE Enables=0),BYTE   !,EXTENDS
Kill                  PROCEDURE
PageDown              PROCEDURE,PROTECTED                              !Moves down one page
PageUp                PROCEDURE,PROTECTED                              !Moves up one page
Reset                 PROCEDURE(*STRING Filename),BYTE,PROC
SetLine               PROCEDURE(LONG Number),VIRTUAL,PROTECTED
SetLineRelative       PROCEDURE(LONG Number),PROTECTED              !scrolls LineCount Lines -ve up +ve down
SetListboxSelection   PROCEDURE(LONG SelectLine),PRIVATE
SetThumb              PROCEDURE,PRIVATE
SetTranslator         PROCEDURE(TranslatorClass Translator)
TakeEvent             PROCEDURE(UNSIGNED Event),BYTE,PROC         !Returns Level:Notify to indicate a cycle required
                    END

  _EndOfInclude_

