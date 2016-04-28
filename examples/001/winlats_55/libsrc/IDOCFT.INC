!**********************************
!        Format Identifiers
!**********************************

! Simple Format Types

FT_NewLine              ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_LineBreak            ASTRING,EXTERNAL,DLL(_ABCDllMode_)

! Containment Format Types

FT_GenericData          ASTRING,EXTERNAL,DLL(_ABCDllMode_)

FT_Bold                 ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_Italic               ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_StrikeThrough        ASTRING,EXTERNAL,DLL(_ABCDllMode_)

FT_DocStart             ASTRING,EXTERNAL,DLL(_ABCDllMode_)  !Only required for reader
FT_DocHeader            ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_DocBody              ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_DocFooter            ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_Table                ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_Comment              ASTRING,EXTERNAL,DLL(_ABCDllMode_)

! Sub Components

FT_TableRow             ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_TableCell            ASTRING,EXTERNAL,DLL(_ABCDllMode_)

! Containment Format Types

FT_Title                ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_Font                 ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_Link                 ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_Tag                  ASTRING,EXTERNAL,DLL(_ABCDllMode_)

! Containment Option Types

FT_TableBorderWidth     ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_TableBGColour        ASTRING,EXTERNAL,DLL(_ABCDllMode_)

FT_FontColour           ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_FontFace             ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_FontSize             ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_FontStyle            ASTRING,EXTERNAL,DLL(_ABCDllMode_)

FT_LinkName             ASTRING,EXTERNAL,DLL(_ABCDllMode_)
FT_LinkTarget           ASTRING,EXTERNAL,DLL(_ABCDllMode_)
