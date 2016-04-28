                     MEMBER('winlats.clw')        ! This is a MEMBER module
performtek_k         PROCEDURE                    ! Declare Procedure
SAV_PAR_NR    ULONG
GGK_SUMMAV    REAL
SVARS         SREAL
DK_KKKS       STRING(12)
DK_KKK        STRING(3),DIM(4),OVER(DK_KKKS)
  CODE                                            ! Begin processed code
   CASE tek:tips
   of 'A'
   orof 'D'
      CLEAR(DK_KKK)
      FOUND#=FALSE
      CONTROL$=0
      IF TEK:REF_OBJ = 1                   !DEFINÇTS REF-OBJ BÂZEI
         IF ~GG:PAR_NR THEN GG:PAR_NR=TEK:PAR_NR.
         par_nr=gg:par_nr
         DK_KKK[1]='231'    !Saòemts no pircçjiem (pçcapmaksa)
         DK_KKK[2]='531'    !Samaksâts PIEGÂDÂTÂJIEM (pçcapmaksa)
         J#=0
         LOOP I#=1 TO 2
            J#=INSTRING(DK_KKK[I#],TEK:BKK_1[1:3]&TEK:BKK_2[1:3]&TEK:BKK_3[1:3]&TEK:BKK_4[1:3]&TEK:BKK_5[1:3]&TEK:BKK_6[1:3],3,1)
            IF J# THEN BREAK.
         .
         IF J#
            kkk=dk_kkk[I#]
            EXECUTE J#
               D_K=TEK:D_K1
               D_K=TEK:D_K2
               D_K=TEK:D_K3
               D_K=TEK:D_K4
               D_K=TEK:D_K5
               D_K=TEK:D_K6
            .
            IF D_K='K' AND I#=1 OR|        !BÛS VIÒU APMAKSA
               D_K='D' AND I#=2            !BÛS MÛSU APMAKSA
               ReferFixGG                  !REFERENCES UZ PREÈU(PAKALPOJUMU) DOKUMENTIEM
               IF GLOBALRESPONSE=REQUESTCOMPLETED
                  TEKSTS=CLIP(TEK:TEKSTS)&' Nr'
                  SUMMA=0
                  LOOP I#= 1 TO RECORDS(A_TABLE)
                     GET(A_TABLE,I#)
                     IF A:SUMMAV_T
                        SUMMA+=A:SUMMAV_T
!                        VAL_NOS=A:VAL
!                        STOP(VAL_NOS)
                        TEKSTS=CLIP(TEKSTS)&' '&A:REFERENCE
                     .
                  .
                  IF SUMMA
                     FOUND#=TRUE
                     TEKSTS=CLIP(TEKSTS)&' '&tek:TEKSTS2
                     FORMAT_TEKSTS(47,'WINDOW',0,'',)
                     gg:saturs =F_TEKSTS[1]
                     gg:saturs2=F_TEKSTS[2]
                     gg:saturs3=F_TEKSTS[3]
                     GG:ATT_DOK=TEK:ATT_DOK
                  ELSE
                     STOP('NULLES SUMMA ...')
                  .
               .
            ELSE
               STOP('Neatïauta reference kontam :'&d_k&kkk)
            .
         ELSE
            STOP('Nav atrasts 231/531 kontçjums...')
         .
!     ELSIF  TEK:REF_OBJ=2      !DEFINÇTS REF-OBJ NOLIKTAVAI
!        TEKSTS=CLIP(TEK:TEKSTS)&' Nr '
      .
      IF ~FOUND#                             !Nav references VAI IR KÏUDA
         SUMMA_W(1)
         gg:saturs=tek:teksts
         gg:saturs2=tek:teksts2
         gg:saturs3=tek:teksts3
         GG:ATT_DOK=TEK:ATT_DOK
      .
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         CHECKOPEN(GGK,1)
         CHECKOPEN(KON_K,1)
         IF ~GG:PAR_NR AND TEK:PAR_NR
            GG:PAR_NR=TEK:PAR_NR
            GG:NOKA=GETPAR_K(GG:PAR_NR,2,1)
            SAV_PAR_NR=GG:PAR_NR
         .
         GGK:u_NR=GG:u_NR
         GGK:DATUMS=GG:DATUMS
         GGK:NODALA=TEK:NODALA
         GGK:OBJ_NR=TEK:OBJ_NR
         GGK:BAITS=TEK:BAITS
         IF val_nos=''
            GGK:val='Ls'
            GG:val='Ls'
         ELSE
            GGK:val=val_nos
            GG:val=val_nos
         .
         case tek:tips
         of 'A'
            SVARS=(TEK:K_1+TEK:K_2+TEK:K_3+TEK:K_4+TEK:K_5+TEK:K_6)/2
         of 'D'
            IF TEK:D_K1='D' AND SVARS<TEK:K_1 THEN SVARS=TEK:K_1.
            IF TEK:D_K2='D' AND SVARS<TEK:K_2 THEN SVARS=TEK:K_2.
            IF TEK:D_K3='D' AND SVARS<TEK:K_3 THEN SVARS=TEK:K_3.
            IF TEK:D_K4='D' AND SVARS<TEK:K_4 THEN SVARS=TEK:K_4.
            IF TEK:D_K5='D' AND SVARS<TEK:K_5 THEN SVARS=TEK:K_5.
            IF TEK:D_K6='D' AND SVARS<TEK:K_6 THEN SVARS=TEK:K_6.
         .
         IF TEK:BKK_1
            IF TEK:AVA_NR AND TEK:BKK_1[1:3]='238'
               GGK:PAR_NR=TEK:AVA_NR
            ELSE
               GGK:PAR_NR=GG:PAR_NR
            .
            GGK_SUMMAV=SUMMA*TEK:K_1/SVARS
            GGK:SUMMAV=GGK_SUMMAV
            GGK:BKK=TEK:BKK_1
            GGK:D_K=TEK:D_K1
            GGK:Pvn_proc=TEK:PVN_1
            GGK:PVN_TIPS=TEK:PVN_TIPS
            KKK=TEK:BKK_1
            DO PERFORMADD
         .
         IF TEK:BKK_2
            IF TEK:AVA_NR AND TEK:BKK_2[1:3]='238'
               GGK:PAR_NR=TEK:AVA_NR
            ELSE
               GGK:PAR_NR=GG:PAR_NR
            .
            GGK_SUMMAV=SUMMA*TEK:K_2/SVARS
            GGK:SUMMAV=GGK_SUMMAV
            GGK:BKK=TEK:BKK_2
            GGK:D_K=TEK:D_K2
            GGK:Pvn_proc=TEK:PVN_2
            GGK:PVN_TIPS=TEK:PVN_TIPS
            KKK=TEK:BKK_2
            DO PERFORMADD
         .
         IF TEK:BKK_3
            IF TEK:AVA_NR AND TEK:BKK_3[1:3]='238'
               GGK:PAR_NR=TEK:AVA_NR
            ELSE
               GGK:PAR_NR=GG:PAR_NR
            .
            GGK_SUMMAV=SUMMA*TEK:K_3/SVARS
            GGK:SUMMAV=GGK_SUMMAV
            GGK:BKK=TEK:BKK_3
            GGK:D_K=TEK:D_K3
            GGK:Pvn_proc=TEK:PVN_3
            GGK:PVN_TIPS=TEK:PVN_TIPS
            KKK=TEK:BKK_3
            DO PERFORMADD
         .
         IF TEK:BKK_4
            IF TEK:AVA_NR AND TEK:BKK_4[1:3]='238'
               GGK:PAR_NR=TEK:AVA_NR
            ELSE
               GGK:PAR_NR=GG:PAR_NR
            .
            GGK_SUMMAV=SUMMA*TEK:K_4/SVARS
            GGK:SUMMAV=GGK_SUMMAV
            GGK:BKK=TEK:BKK_4
            GGK:D_K=TEK:D_K4
            GGK:Pvn_proc=TEK:PVN_4
            GGK:PVN_TIPS=TEK:PVN_TIPS
            KKK=TEK:BKK_4
            DO PERFORMADD
         .
         IF TEK:BKK_5
            IF TEK:AVA_NR AND TEK:BKK_5[1:3]='238'
               GGK:PAR_NR=TEK:AVA_NR
            ELSE
               GGK:PAR_NR=GG:PAR_NR
            .
            GGK_SUMMAV=SUMMA*TEK:K_5/SVARS
            GGK:SUMMAV=GGK_SUMMAV
            GGK:BKK=TEK:BKK_5
            GGK:D_K=TEK:D_K5
            GGK:Pvn_proc=TEK:PVN_5
            GGK:PVN_TIPS=TEK:PVN_TIPS
            KKK=TEK:BKK_5
            DO PERFORMADD
         .
         IF TEK:BKK_6
            IF TEK:AVA_NR AND TEK:BKK_6[1:3]='238'
               GGK:PAR_NR=TEK:AVA_NR
            ELSE
               GGK:PAR_NR=GG:PAR_NR
            .
            GGK_SUMMAV=SUMMA*TEK:K_6/SVARS
            GGK:SUMMAV=GGK_SUMMAV
            GGK:BKK=TEK:BKK_6
            GGK:D_K=TEK:D_K6
            GGK:Pvn_proc=TEK:PVN_6
            GGK:PVN_TIPS=TEK:PVN_TIPS
            KKK=TEK:BKK_6
            DO PERFORMADD
         .
         IF ~INRANGE(CONTROL$,-0.009,0.009)
            KLUDA(0,'D/K KÏÛDA: '&CONTROL$)
         .
      .
   ELSE
      gg:saturs=tek:teksts
      gg:saturs2=tek:teksts2
      gg:saturs3=tek:teksts3
      GG:ATT_DOK=TEK:ATT_DOK
   .
   FREE(A_TABLE)

PERFORMADD   ROUTINE

   IF INSTRING(GGK:BKK[1:3],DK_KKKS,3,1) AND FOUND#  !JÂMEKLÇ SADALÎJUMS TABULÂ
      LOOP J#= 1 TO RECORDS(A_TABLE)
         GET(A_TABLE,J#)
         IF A:SUMMAV_T
            GGK:BKK=A:BKK
            GGK:SUMMAV=A:SUMMAV_T
            ggk:REFERENCE=A:REFERENCE
            DO ADDGGK
         .
      .
      FOUND#=FALSE                     !Viss, kas bija jau ir sameklçts
   ELSE
      ggk:REFERENCE=0
      DO ADDGGK
   .


ADDGGK    ROUTINE

        GGK:SUMMA=GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
!        STOP(GGK:U_NR&' '&GGK:BKK&' '&GGK:SUMMA)
        ADD(GGK)
        IF ~ERROR()
           CASE GGK:D_K
           OF 'D'
              CONTROL$+=GGK:SUMMA
           OF 'K'
              CONTROL$-=GGK:SUMMA
           .
           ATLIKUMIB(GGK:D_K,GGK:BKK,GGK:SUMMA,'','',0)
        ELSE
           STOP('Rakstot ggk:'&ERROR())
        .
AtlikumiB            PROCEDURE (d_k_NEW,bkk_NEW,summa_NEW,d_k_old,bkk_old,summa_old) ! Declare Procedure
  CODE                                            ! Begin processed code
  IF ~(D_K_OLD=D_K_NEW AND bkk_NEW=bkk_old AND SUMMA_OLD=SUMMA_OLD)
     CHECKOPEN(KON_K,1)
     KON_K::USED+=1
     CASE D_K_NEW
     OF 'K'
        summa_NEW=-SUMMA_NEW
     .
     CASE D_K_OLD
     OF 'K'
        summa_OLD=-SUMMA_OLD
     .
     IF bkk_NEW=bkk_old OR BKK_OLD=''   ! NAV MAINÎTS KONTS
        IF getkon_k(bkk_new,2,1)
           KON:ATLIKUMS[LOC_NR]+=(Summa_NEW-summa_old)
           IF RIUPDATE:KON_K()
              KLUDA(24,'KON_K:ATLIKUMI'&BKK_NEW)
           .
        .
     ELSE
        IF getkon_k(bkk_new,2,1)
           KON:ATLIKUMS[LOC_NR]+=SUMMA_NEW
           IF RIUPDATE:KON_K()
              KLUDA(24,'KON_K:ATLIKUMI'&BKK_NEW)
           .
        .
        IF getkon_k(bkk_OLD,2,1)
           KON:ATLIKUMS[LOC_NR]-=SUMMA_OLD
           IF RIUPDATE:KON_K()
              KLUDA(24,'KON_K:ATLIKUMI'&BKK_NEW)
           .
        .
     .
     KON_K::USED-=1
     IF KON_K::USED=0
        CLOSE(KON_K)
     .
  .

RP                   PROCEDURE                    ! Declare Procedure
CurrentPage                    LONG
PagesAcross                    LONG
PagesDown                      LONG
DisplayedPagesAcross           LONG
DisplayedPagesDown             LONG

ZoomNoZoom                     BYTE
ZoomPageWidth                  BYTE
Zoom50                         BYTE
Zoom75                         BYTE
Zoom100                        BYTE
Zoom200                        BYTE
Zoom300                        BYTE
ZoomModifier                   REAL

PopupSelection                 BYTE
PopupText                      STRING(50)

ThumbnailsPresent              LONG
ZoomPresent                    BYTE

TemporaryImage                   EQUATE(100)
ZoomImage                        EQUATE(102)
LowestBorderEquate               EQUATE(104)
LowestImageEquate                EQUATE(204)
HighestControlEquate             EQUATE(404)
MinimumXSeparation               EQUATE(3)
MinimumYSeparation               EQUATE(3)
ReturnValue                      BYTE

ImageCount                       LONG
ImageWidth                       LONG
ImageHeight                      LONG
ImageAspectRatio                 REAL

ThumbnailsRequired               LONG
CurrentThumbnail                 LONG
ThumbnailXPosition               LONG
ThumbnailYPosition               LONG
ThumbnailHeight                  LONG
ThumbnailWidth                   LONG
ThumbnailAspectRatio             REAL
ThumbnailRow                     LONG
ThumbnailColumn                  LONG

ProcessedPage                    LONG

PageZoom                         REAL

CurrentImageBox                  LONG
CurrentBorderBox                 LONG

TotalXSeparation                 LONG
TotalYSeparation                 LONG

PreviewWindowX                   STRING(20)
PreviewWindowY                   STRING(20)
PreviewWindowWidth               STRING(20)
PreviewWindowHeight              STRING(20)

Zoomed                           BYTE
ZoomRatio                        STRING(20)

ClickedControl                   LONG

SVITRA                           BYTE
FILENAME_S                       LIKE(FILENAME1)
FILENAME_D                       LIKE(FILENAME1)

Preview:Window WINDOW('Izdrukas aplûkoðana'),FONT('MS Sans Serif',10,,),COLOR(COLOR:Gray),IMM,HVSCROLL, |
         ICON(Icon:Print),ALRT(PgUpKey),ALRT(PgDnKey),ALRT(DownKey),ALRT(UpKey),ALRT(AltD),STATUS(-1,90,70), |
         SYSTEM,GRAY,MAX,MAXIMIZE,RESIZE
       TOOLBAR,AT(0,0,402,18)
         BUTTON('&Drukât'),AT(2,3,42,14),USE(?Print),LEFT,FONT('MS Sans Serif',,,,CHARSET:BALTIC),TIP('Drukât'), |
             ICON(ICON:Print)
         BUTTON('&Atlikt'),AT(45,3,38,14),USE(?Exit),LEFT,FONT('MS Sans Serif',,,,CHARSET:BALTIC),TIP('Beigt bez drukâðanas'), |
             ICON(ICON:NoPrint)
         BUTTON,AT(92,2,14,14),USE(?ZoomButton),TIP('Lapas mçrogoðana'),ICON(ICON:Zoom)
         PROMPT('&Lapa:'),AT(300,4)
         SPIN(@n4),AT(325,3,33,12),USE(CurrentPage),RANGE(1,10),STEP(1)
         BUTTON('Uzlikt svîtru'),AT(221,2,44,14),USE(?svitra),HIDE
         BUTTON('Labot'),AT(269,2,26,14),USE(?labot),HIDE
         BUTTON('&Nâkoðâ lapa'),AT(168,2,50,14),USE(?Next)
         BUTTON('&Iepriekðçjâ lapa'),AT(109,2,56,14),USE(?Previous)
       END
       REGION,AT(1,123,507,2),USE(?Re),HIDE,SCROLL,COLOR(COLOR:ACTIVEBORDER),FILL(COLOR:Silver),BEVEL(1)
     END

  CODE                                            ! Begin processed code
   ReturnValue       = False
   OPEN(Preview:Window)
   IF ANSIFILENAME
      Preview:Window{Prop:TEXT} = 'Izdrukas aplûkoðana. TXT fails:'&ANSIFILENAME
   .
   TARGET{Prop:MinWidth} = 315
   ! Retrieve first image to get image aspect ratio, then destroy the image
   GET(PrintPreviewQueue,1)
   CREATE(TemporaryImage,CREATE:Image)
   TemporaryImage{Prop:Text} = PrintPreviewQueue
   ImageWidth = TemporaryImage{Prop:MaxWidth}
   ImageHeight = TemporaryImage{Prop:MaxHeight}
   ImageAspectRatio = ImageHeight / ImageWidth
   DESTROY(TemporaryImage)
   ImageCount           = RECORDS(PrintPreviewQueue)
   CurrentPage          = 1
   PagesAcross          = 1
   PagesDown            = 1
   PagesDown            = 1
   DisplayedPagesAcross = 0
   DisplayedPagesDown   = 0
   ThumbnailsPresent    = 0
   ZoomPresent          = False
   IF ImageCount = 1
!     DISABLE(?CurrentPage,?PagesDown)
!     DISABLE(?ViewMenu)
   ELSE
     ?CurrentPage{Prop:RangeHigh} = ImageCount
     ?CurrentPage{Prop:Msg} = 'Ievadiet lapas Nr no 1 lîdz ' & ImageCount
   END
!   ZoomNoZoom          = True
   ZoomPageWidth = True
   DO ChangeDisplay
   SELECT(ZoomImage) !24.08.06
   ACCEPT
     CASE EVENT()
     OF Event:Sized
       DO ChangeDisplay
     OF Event:NewSelection
       CASE FIELD()
!       OF ?PagesAcross
!       OROF ?PagesDown
!         DO ClearZoomValues
!         ZoomNoZoom = True
!         DO ChangeDisplay
       OF ?CurrentPage
         DO ChangeDisplay
       END
     OF Event:Rejected
       CASE REJECTCODE()
       OF Reject:RangeHigh
         CHANGE(FIELD(),FIELD(){Prop:RangeHigh})
       OF Reject:RangeLow
         CHANGE(FIELD(),FIELD(){Prop:RangeLow})
       END
       DO ChangeDisplay
     OF Event:AlertKey
       CASE KEYCODE()
       OF AltD
         POST(Event:Accepted,?Print)
       OF PgUpKey
         POST(Event:Accepted,?Previous)
       OF PgDnKey
         POST(Event:Accepted,?Next)
       OF DownKey
         GETPOSITION(?RE,X#,Y#,W#,H#)
         IF Y# > ImageHeight !255
            beep
         ELSE
           HIDE(?RE)
           Y#+=10
           ?RE{PROP:YPOS}=Y#
           UNHIDE(?RE)
           DISPLAY
         .
       OF UpKey
         GETPOSITION(?RE,X#,Y#,W#,H#)
         IF Y# < 10
            beep
         ELSE
            HIDE(?RE)
            Y#-=10
            ?RE{PROP:YPOS}=Y#
            UNHIDE(?RE)
            DISPLAY
         .
       ELSE
         CASE FIELD()
         OF ZoomImage
           DO ClearZoomValues
           ZoomNoZoom = True
           DO ChangeDisplay
         ELSE
           CurrentPage = (FIELD() - LowestImageEquate) + CurrentPage
           ZoomNoZoom = False
           ZoomPageWidth = True
           DO ChangeDisplay
         END
       END
     OF Event:Accepted
       CASE FIELD()
       OF ?LABOT
!         RUN('\WINLATS\BIN\METACOMP.EXE '& PrintPreviewImage)
              FILENAME_S=PrintPreviewImage
              FILENAME_D='test.wmf'
              IF ~CopyFileA(FILENAME_S,FILENAME_D,0)
                 KLUDA(3,FILENAME_S&' uz '&FILENAME_D)
              .
         RUN('C:\Program Files\Image2pdf\img2pdf.exe -o test.pdf '&FILENAME_D,1)
         IF RUNCODE()=-4
            KLUDA(0,PrintPreviewImage&' '&error())
!            KLUDA(88,'\WINLATS\BIN\METACOMP.EXE ')
         .
         RUN('C:\Program Files\Adobe\Reader 8.0\Reader\AcroRd32.exe test.pdf',1)
!         RUN('C:\Program Files\Adobe\Reader 8.0\Reader\AcroRd32.exe '& PrintPreviewImage)
         IF RUNCODE()=-4
            KLUDA(0,error())
!            KLUDA(88,'\WINLATS\BIN\METACOMP.EXE ')
         .
         DISPLAY
       OF ?Print
         PR:LAPA:NO=1
         IF ~PR:LAPA:LIDZ THEN PR:LAPA:LIDZ=ImageCount.
         RP:DRUKAT
         IF GLOBALRESPONSE=REQUESTCOMPLETED
            POST(Event:CloseWindow)
            ReturnValue = True
            FREE(PrintPreviewQueue1)
            loop i#= pr:lapa:no to pr:lapa:lidz
               GET(PrintPreviewQueue,I#)
               PrintPreviewImage1=PrintPreviewImage
               add(PrintPreviewQueue1)
            .
            IF ~(RECORDS(PrintPreviewQueue)=RECORDS(PrintPreviewQueue1))
               FREE(PrintPreviewQueue)
               loop i#= 1 to RECORDS(PrintPreviewQueue1)
                  GET(PrintPreviewQueue1,I#)
                  PrintPreviewImage=PrintPreviewImage1
                  add(PrintPreviewQueue)
               .
            .
         .
       OF ?Exit
         pr:skaits=0
         POST(Event:CloseWindow)
       OF ?ZoomButton
         PopupText = '-No Zoom|-|-Page Width|-50%|-75%|-100%|-200%|-300%'
         IF ZoomNoZoom
           PopupText[1] = '+'
         ELSIF ZoomPageWidth
           PopupText[12] = '+'
         ELSIF Zoom50
           PopupText[24] = '+'
         ELSIF Zoom75
           PopupText[29] = '+'
         ELSIF Zoom100
           PopupText[34] = '+'
         ELSIF Zoom200
           PopupText[40] = '+'
         ELSIF Zoom300
           PopupText[46] = '+'
         END
         PopupSelection = POPUP(PopupText)
         IF PopupSelection
           DO ClearZoomValues
           EXECUTE(PopupSelection)
             ZoomNoZoom = True
             ZoomPageWidth = True
             Zoom50 = True
             Zoom75 = True
             Zoom100 = True
             Zoom200 = True
             Zoom300 = True
           END
           DO ChangeDisplay
         END
       OF ?CurrentPage
         DO ChangeDisplay
       OF ?Next
         DO GetNextPage
         DO ChangeDisplay
       OF ?Previous
         DO GetPrevPage
         DO ChangeDisplay
       OF ?SVITRA
          IF SVITRA
             SVITRA=0
             ?SVITRA{PROP:TEXT}='Uzlikt svîtru'
             HIDE(?RE)
          ELSE
             SVITRA=1
             ?SVITRA{PROP:TEXT}='Noòemt svîtru'
             UNHIDE(?RE)
             DISPLAY
          .

!       OF ?Jump
!         CurrentPage = RP:JumpToPage(CurrentPage,ImageCount)
!         DO ChangeDisplay
!       OF ?ChangeDisplay
!         Preview:SelectDisplay(PagesAcross,PagesDown)
!         DO ChangeDisplay
!       OF ?ZoomNoZoom TO ?Zoom300
!         DO ClearZoomValues
!         EXECUTE((FIELD() - ?ZoomNoZoom) + 1)
!           ZoomNoZoom = True
!           ZoomPageWidth = True
!           Zoom50 = True
!           Zoom75 = True
!           Zoom100 = True
!           Zoom200 = True
!           Zoom300 = True
!         END
!         DO ChangeDisplay
       END
     END
   END
   IF ReturnValue
     GlobalResponse = RequestCompleted
   ELSE
     GlobalResponse = RequestCancelled
   END
   SETKEYCODE(0)
   PR:LAPA:LIDZ=0
   RETURN

!------------------------------------------------------
ChangeDisplay ROUTINE
!|
!| This routine is called to select the current display mode of the ReportPreview
!| window.
!|
!| If any zooming is being done (ZoomNoZoom = False) then any thumbnails present
!| are destroyed. If the Zoom control is not present, it is created. Finally, the
!| Zoom control is filled with the current page and zoomed.
!|
!| If no zooming is being done, then the Zoom control, if present, is destroyed.
!| Next, if the number of pages to be displayed has changed, then any existing
!| thumbnails are destroyed, and the new thumbnails are created. Finally, the
!| thumbnails are positioned and filled.
!|
  IF ZoomNoZoom
    IF ZoomPresent
      DO DestroyZoomControl
    END
    IF PagesDown <> DisplayedPagesDown OR PagesAcross <> DisplayedPagesAcross
      IF ThumbnailsPresent
        DO DestroyThumbnails
      END
      DO CreateThumbnails
      DisplayedPagesDown = PagesDown
      DisplayedPagesAcross = PagesAcross
    END
    DO PositionThumbnails
    DO FillThumbnails
    TARGET{Prop:StatusText,3} = 'No Zoom'
  ELSE
    IF ThumbnailsPresent
      DO DestroyThumbnails
    END
    IF NOT ZoomPresent
      DO CreateZoomControl
    END
    DO FillZoomControl
    DisplayedPagesAcross = 0
    DisplayedPagesDown   = 0
  END

!MARIS
  IF ImageCount > 1
     IF CurrentPage = 1
       DISABLE(?Previous)
     ELSE
       ENABLE(?Previous)
     END
!     STOP(CurrentPage&' + '&ThumbnailsPresent&' > '&ImageCount)
     IF CurrentPage = ImageCount   !MARIS
       DISABLE(?Next)
     ELSE
       ENABLE(?Next)
     END
  ELSE
     DISABLE(?Previous)
     DISABLE(?Next)
  END
!MARIS
!  DISPLAY(?ZoomNoZoom,?Zoom300)
!  DISPLAY(?CurrentPage,?PagesDown)
  DISPLAY(?CurrentPage,?CurrentPage)
!
!
  IF ZoomPageWidth = True
     UNHIDE(?svitra)
     IF SVITRA
        UNHIDE(?RE)
     .
  ELSE
     HIDE(?svitra)
     HIDE(?RE)
  .
!
!------------------------------------------------------
CreateZoomControl ROUTINE
!|
!| This routine is used to create the Zoom control and its background.
!|
  CREATE(ZoomImage,CREATE:Image)
  SETPOSITION(ZoomImage,0,0)
  ZoomImage{Prop:VScroll} = True
  ZoomImage{Prop:HScroll} = True
  ZoomImage{Prop:Full} = True
  ZoomImage{Prop:FillColor} = 0FFFFFFh
  ZoomImage{Prop:Alrt} = MouseLeft
  ZoomImage{Prop:Cursor} = Cursor:Zoom
  UNHIDE(ZoomImage)
  ZoomPresent = True

!------------------------------------------------------
DestroyZoomControl ROUTINE
!|
!| This routine is used to destroy the zoom control and its background.
!|
  HIDE(ZoomImage)
  DESTROY(ZoomImage)
  ZoomPresent = False

!------------------------------------------------------
FillZoomControl ROUTINE
!|
!| This routine is used to fill the Zoom control with an image, and to set the
!| image's zoom ration to the correct value.
!|
  DO ConfigureZoomRatio
  GET(PrintPreviewQueue,CurrentPage)
  ZoomImage{Prop:Text} = PrintPreviewQueue
  TARGET{Prop:StatusText,2} = CurrentPage & '. lapa no ' & ImageCount
  ZoomImage{Prop:MaxWidth} = ImageWidth * ZoomModifier
  ZoomImage{Prop:MaxHeight} = ImageHeight * ZoomModifier

!------------------------------------------------------
GetNextPage ROUTINE
!|
!| This routine increments the CurrentPage variable so that the next
!| "page" of images are displayed.
!|
   IF ZoomNoZoom
     IF CurrentPage + ThumbnailsPresent <= ImageCount
       CurrentPage += ThumbnailsPresent
     END
   ELSE
     IF CurrentPage <> ImageCount
       CurrentPage += 1
     END
   END

!------------------------------------------------------
GetPrevPage ROUTINE
!|
!| This routine decrements the CurrentPage variable so that the previous
!| "page" of images are displayed.
!|
   IF ZoomNoZoom
     CurrentPage -= ThumbnailsPresent
     IF CurrentPage < 1
       CurrentPage = 1
     END
   ELSE
     IF CurrentPage <> 1
       CurrentPage -= 1
     END
   END

!------------------------------------------------------
CreateThumbnails ROUTINE
!|
!| This routine is used to create all thumbnail images and their backgrounds
!|
   ZoomRatio = 'No Zoom'
   CurrentBorderBox = LowestBorderEquate
   CurrentImageBox = LowestImageEquate
   ThumbnailsRequired = (PagesAcross * PagesDown)
   LOOP CurrentThumbnail = 1 TO ThumbnailsRequired
     CREATE(CurrentBorderBox,CREATE:Box)
     CREATE(CurrentImageBox,CREATE:Image)
     CurrentBorderBox += 1
     CurrentImageBox += 1
   END
   ThumbnailsPresent = ThumbnailsRequired

!------------------------------------------------------
DestroyThumbnails ROUTINE
!|
!| This routine is used to destroy all thumbnail images and their backgrounds
!|
   HIDE(LowestBorderEquate,HighestControlEquate)
   DESTROY(LowestBorderEquate,HighestControlEquate)
   ThumbnailsPresent = 0

!------------------------------------------------------
PositionThumbnails ROUTINE
!|
!| This routine is used to position all of the thumbnails and their backgrounds.
!|
   TotalXSeparation = 2 + ((PagesAcross - 1) * MinimumXSeparation)
   TotalYSeparation = 2 + ((PagesDown - 1) * MinimumYSeparation)
   ThumbnailWidth = (TARGET{Prop:Width} - TotalXSeparation) / PagesAcross
   ThumbnailHeight = ((TARGET{Prop:Height} -18) - TotalYSeparation) / PagesDown
   ThumbnailAspectRatio = ThumbnailHeight / ThumbnailWidth
   IF ThumbnailAspectRatio < ImageAspectRatio
     ThumbnailWidth = ThumbnailHeight / ImageAspectRatio
   ELSE
     ThumbnailHeight = ThumbnailWidth * ImageAspectRatio
   END
   CurrentBorderBox = LowestBorderEquate
   CurrentImageBox = LowestImageEquate
   ThumbnailYPosition = 1
   LOOP ThumbnailRow = 1 TO PagesDown
     ThumbnailXPosition = 1
     LOOP ThumbnailColumn = 1 TO PagesAcross
       SETPOSITION(CurrentBorderBox,ThumbnailXPosition,ThumbnailYPosition,ThumbnailWidth,ThumbnailHeight)
       SETPOSITION(CurrentImageBox,ThumbnailXPosition,ThumbnailYPosition,ThumbnailWidth,ThumbnailHeight)
       CurrentBorderBox{Prop:Color} = 0
       CurrentBorderBox{Prop:Fill} = 0FFFFFFh
       CurrentImageBox{Prop:Cursor} = Cursor:Zoom
       CurrentImageBox{Prop:Alrt} = MouseLeft
       ThumbnailXPosition += MinimumXSeparation + ThumbnailWidth
       CurrentBorderBox += 1
       CurrentImageBox += 1
     END
     ThumbnailYPosition += MinimumYSeparation + ThumbnailHeight
   END

!------------------------------------------------------
FillThumbnails ROUTINE
!|
!| This routine is used to fill all of the thumbnails.
!|
   CurrentBorderBox = LowestBorderEquate
   CurrentImageBox = LowestImageEquate
   LOOP CurrentThumbnail = 1 TO ThumbnailsPresent
     ProcessedPage = (CurrentPage + CurrentThumbnail) - 1
     IF ProcessedPage > ImageCount
       IF CurrentImageBox{Prop:Hide} = False
         HIDE(CurrentBorderBox)
         HIDE(CurrentImageBox)
       END
     ELSE
       GET(PrintPreviewQueue,ProcessedPage)
       CurrentImageBox{Prop:Text} = PrintPreviewQueue
       IF CurrentImageBox{Prop:Hide} = True
         UNHIDE(CurrentBorderBox)
         UNHIDE(CurrentImageBox)
       END
     END
     CurrentBorderBox += 1
     CurrentImageBox += 1
   END
   IF ImageCount > 1
     IF CurrentPage = 1
       DISABLE(?Previous)
     ELSE
       ENABLE(?Previous)
     END
     IF CurrentPage + ThumbnailsPresent > ImageCount
       DISABLE(?Next)
     ELSE
       ENABLE(?Next)
     END
   END
   IF ThumbnailsPresent > 1
     ProcessedPage = CurrentPage + ThumbnailsPresent - 1
     IF ProcessedPage > ImageCount
       ProcessedPage = ImageCount
     END
     IF CurrentPage = ImageCount
       TARGET{Prop:StatusText,2} = 'Page ' & CurrentPage & ' of ' & ImageCount
     ELSE
       TARGET{Prop:StatusText,2} = 'Pages ' & CurrentPage & '-' & ProcessedPage & ' of ' & ImageCount
     END
   ELSE
     TARGET{Prop:StatusText,2} = 'Page ' & CurrentPage & ' of ' & ImageCount
   END
!------------------------------------------------------
ConfigureZoomRatio        ROUTINE
!|
!| This routine is used to set the Zoom modifier, and to set the status bar
!| text which displays the current zoom mode.
!|
  IF ZoomPageWidth
    ZoomModifier = TARGET{Prop:Width} / ImageWidth
    ZoomImage{Prop:HScroll} = False
    TARGET{Prop:StatusText,3} = 'Zoom (Lapas platums)'
  ELSIF Zoom50
    ZoomModifier = .5
    ZoomImage{Prop:HScroll} = True
    TARGET{Prop:StatusText,3} = 'Zoom (50%)'
  ELSIF Zoom75
    ZoomModifier = .75
    ZoomImage{Prop:HScroll} = True
    TARGET{Prop:StatusText,3} = 'Zoom (75%)'
  ELSIF Zoom100
    ZoomModifier = 1
    ZoomImage{Prop:HScroll} = True
    TARGET{Prop:StatusText,3} = 'Zoom (100%)'
  ELSIF Zoom200
    ZoomModifier = 2
    ZoomImage{Prop:HScroll} = True
    TARGET{Prop:StatusText,3} = 'Zoom (200%)'
  ELSIF Zoom300
    ZoomModifier = 3
    ZoomImage{Prop:HScroll} = True
    TARGET{Prop:StatusText,3} = 'Zoom (300%)'
  END

!---------------------------------------------------------
ClearZoomValues ROUTINE
!|
!| Since the zoom status is kept in seven different flags, this routine
!| is used to clear all of the flags during any zoom mode change.
!|
  ZoomNoZoom    = False
  ZoomPageWidth = False
  Zoom50        = False
  Zoom75        = False
  Zoom100       = False
  Zoom200       = False
  Zoom300       = False

