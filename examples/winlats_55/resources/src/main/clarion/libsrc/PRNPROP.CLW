!----------------------------------------------------------
! Built-in property constants for CW
!----------------------------------------------------------*/

PROPPRINT:devmode         EQUATE(07B00H)  ! Entire devmode structure - see WINDOWS SDK
PROPPRINT:paper           EQUATE(07B01H)  ! standard paper size (PAPER:xxx)
PROPPRINT:paperheight     EQUATE(07B02H)  ! paper height (in 10th mm)
PROPPRINT:paperwidth      EQUATE(07B03H)  ! paper width (in 10th mm)
PROPPRINT:percent         EQUATE(07B04H)  ! scaling factor
PROPPRINT:copies          EQUATE(07B05H)  ! number of copies
PROPPRINT:paperbin        EQUATE(07B06H)  ! paper source (PAPERBIN:xxx)
PROPPRINT:resolution      EQUATE(07B07H)  ! in DPI or RESOLUTION:xxx)
PROPPRINT:color           EQUATE(07B08H)  ! 1=mono, 2=color
PROPPRINT:duplex          EQUATE(07B09H)  ! duplex mode (DUPLEX::xxx)
PROPPRINT:yresolution     EQUATE(07B0AH)  ! in DPI
PROPPRINT:fontmode        EQUATE(07B0BH)  ! TrueType font mode (FONTMODE:xxx)

PROPPRINT:printtofile     EQUATE(07B20H)  ! 0 or 1
PROPPRINT:printtoname     EQUATE(07B21H)  ! output filename
PROPPRINT:frompage        EQUATE(07B22H)  ! specify -1 to print from start
PROPPRINT:topage          EQUATE(07B23H)  ! specify -1 to print to end
PROPPRINT:frommax         EQUATE(07B24H)  ! for compatibility with 1002!
PROPPRINT:frommin         EQUATE(07B24H)  ! specify -1 to disable ranges
PROPPRINT:tomax           EQUATE(07B25H)  ! specify -1 to disable ranges
PROPPRINT:collate         EQUATE(07B26H)  ! 0 or 1
PROPPRINT:driver          EQUATE(07B27H)  ! driver DLL filename (no extension)
PROPPRINT:device          EQUATE(07B28H)  ! driver description
PROPPRINT:port            EQUATE(07B29H)  ! output port name
PROPPRINT:context         EQUATE(07B2AH)  ! handle to printer device context or
PROPPRINT:generateall     EQUATE(07B2BH)  ! generate all pages for preview if a range
                                          ! of page numbers is set in PRINTERDIALOG

PAPERBIN:UPPER            EQUATE(1)
PAPERBIN:ONLYONE          EQUATE(1)
PAPERBIN:LOWER            EQUATE(2)
PAPERBIN:MIDDLE           EQUATE(3)
PAPERBIN:MANUAL           EQUATE(4)
PAPERBIN:ENVELOPE         EQUATE(5)
PAPERBIN:ENVMANUAL        EQUATE(6)
PAPERBIN:AUTO             EQUATE(7)
PAPERBIN:TRACTOR          EQUATE(8)
PAPERBIN:SMALLFMT         EQUATE(9)
PAPERBIN:LARGEFMT         EQUATE(10)
PAPERBIN:LARGECAPACITY    EQUATE(11)
PAPERBIN:CASSETTE         EQUATE(14)

RESOLUTION:DRAFT          EQUATE(-1)
RESOLUTION:LOW            EQUATE(-2)
RESOLUTION:MEDIUM         EQUATE(-3)
RESOLUTION:HIGH           EQUATE(-4)

DUPLEX:SIMPLEX            EQUATE(1)
DUPLEX:VERTICAL           EQUATE(2)
DUPLEX:HORIZONTAL         EQUATE(3)

FONTMODE:BITMAP           EQUATE(1)       ! print TT fonts as graphics
FONTMODE:DOWNLOAD         EQUATE(2)       ! download TT fonts as soft fonts
FONTMODE:SUBDEV           EQUATE(3)       ! substitute device fonts for TT fonts
