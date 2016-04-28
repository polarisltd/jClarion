                     MEMBER('winlats.clw')        ! This is a MEMBER module
BrowsePAVAD PROCEDURE


sak_gil              LONG
bei_gil              LONG
LOCAL_PATH           CSTRING(80)
CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
DOK_NR               STRING(10)
ATLIKUMS             DECIMAL(11,3)
NOL_TIPS             STRING(20)
AVAK                 STRING(3)
SAV_PAR_NR           ULONG
SUMMA_PVN            DECIMAL(11,2)
SUMMA_B0             DECIMAL(11,2)
SUMMA_B5             DECIMAL(11,2)
SUMMA_B9             DECIMAL(11,2)
SUMMA_B12            DECIMAL(11,2)
SUMMA_B18            DECIMAL(11,2)
SUMMA_PVN0           DECIMAL(11,2)
SUMMA_PVN5           DECIMAL(11,2)
SUMMA_PVN9           DECIMAL(11,2)
SUMMA_PVN12          DECIMAL(11,2)
SUMMA_PVN18          DECIMAL(11,2)
SUMMA_0              DECIMAL(11,2)
SUMMA_5              DECIMAL(11,2)
SUMMA_9              DECIMAL(11,2)
SUMMA_12             DECIMAL(11,2)
SUMMA_18             DECIMAL(11,2)
R_CENA               LIKE(NOM:PIC)
PAR_EMAIL            STRING(61) !VAR B�T 2*30
PAR_NOS_P            LIKE(PAR:NOS_P)
PAV_DOK_SENR         LIKE(PAV:DOK_SENR)

InfoScreen WINDOW('Inform�cija par P/Z'),AT(,,306,82),IMM,SYSTEM,GRAY,RESIZE
       STRING('bez PVN '),AT(129,3),USE(?String1)
       STRING('P/Z summa  ( 0% grupa)'),AT(33,14),USE(?String11)
       STRING(@N_11.2),AT(121,14),USE(SUMMA_B0)
       STRING(@N_11.2),AT(168,14),USE(SUMMA_PVN0)
       STRING(@N_11.2),AT(215,14),USE(SUMMA_0)
       STRING('P/Z summa  (sam.likme)'),AT(33,23),USE(?String511)
       STRING(@N_11.2),AT(121,23),USE(SUMMA_B5)
       STRING(@N_11.2),AT(168,23),USE(SUMMA_PVN5)
       STRING(@N_11.2),AT(215,23),USE(SUMMA_5)
       STRING('P/Z summa (standartlikme)'),AT(33,33),USE(?String3)
       STRING(@N_11.2),AT(121,33),USE(SUMMA_B18)
       STRING(@N_11.2),AT(121,53,46,10),USE(PAV:SUMMA_B)
       STRING(@N_11.2),AT(168,33),USE(SUMMA_PVN18)
       STRING(@N_11.2),AT(215,33),USE(SUMMA_18)
       STRING('PVN '),AT(183,3),USE(?String5)
       STRING('Kop�'),AT(230,3),USE(?String20)
       STRING(@N_11.2),AT(168,53,46,10),USE(SUMMA_PVN)
       LINE,AT(16,47,268,0),USE(?Line1),COLOR(COLOR:Black)
       STRING('P/Z summa  kop�'),AT(48,53),USE(?String6)
       STRING(@N_11.2),AT(215,53,46,10),USE(PAV:SUMMA)
       STRING(@s3),AT(263,53,16,10),USE(PAV:VAL)
       BUTTON('&OK'),AT(257,67,39,14),USE(?BEIGT)
     END
X                    BYTE
Process              STRING(35)
Process1             STRING(35)
Process2             STRING(35)

Askscreen WINDOW('Datu dz��ana'),AT(,,159,128),CENTER,GRAY
       STRING('Dz�st visus dokumentus'),AT(21,23),USE(?String91)
       SPIN(@d6),AT(24,40,48,12),USE(s_dat)
       SPIN(@d6),AT(94,40,48,12),USE(B_DAT)
       STRING('kam X='),AT(20,58),USE(?String4)
       ENTRY(@n1B),AT(47,57),USE(X),CENTER
       STRING('un Y='),AT(70,58),USE(?string:RS),HIDE
       ENTRY(@S1),AT(91,57),USE(RS),HIDE,CENTER
       STRING(@s35),AT(11,74),USE(process)
       STRING(@s35),AT(11,82),USE(process1)
       STRING(@s35),AT(11,90),USE(process2)
       STRING('l�dz'),AT(78,41),USE(?String93)
       STRING('no'),AT(11,42),USE(?String92)
       BUTTON('&OK'),AT(74,104,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(116,104,36,14),USE(?CancelButton)
     END

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
PercentProgress      BYTE
Progress:Thermometer BYTE

ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
     END

R_TABLE     QUEUE,PRE(R)
NOMENKLAT      STRING(21)
DAUDZUMS       LIKE(NOL:DAUDZUMS)
CENA           LIKE(NOM:PIC)
PVN_PROC       BYTE
ARBYTE         BYTE
BAITS          BYTE
            .
S_TABLE     QUEUE,PRE(S)
NOMENKLAT      STRING(21)
DAUDZUMS       LIKE(NOL:DAUDZUMS)
CENA           LIKE(NOM:PIC)
            .

!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)

BRW1::View:Browse    VIEW(PAVAD)
                       PROJECT(PAV:KEKSIS)
                       PROJECT(PAV:RS)
                       PROJECT(PAV:BAITS1)
                       PROJECT(PAV:EXP)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:DOK_SENR)
                       PROJECT(PAV:NOKA)
                       PROJECT(PAV:PAMAT)
                       PROJECT(PAV:SUMMA)
                       PROJECT(PAV:val)
                       PROJECT(PAV:NODALA)
                       PROJECT(PAV:OBJ_NR)
                       PROJECT(PAV:REK_NR)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:C_SUMMA)
                       PROJECT(PAV:PAR_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::PAV:KEKSIS       LIKE(PAV:KEKSIS)           ! Queue Display field
BRW1::PAV:KEKSIS:NormalFG LONG                    ! Normal Foreground
BRW1::PAV:KEKSIS:NormalBG LONG                    ! Normal Background
BRW1::PAV:KEKSIS:SelectedFG LONG                  ! Selected Foreground
BRW1::PAV:KEKSIS:SelectedBG LONG                  ! Selected Background
BRW1::PAV:RS           LIKE(PAV:RS)               ! Queue Display field
BRW1::PAV:RS:NormalFG LONG                        ! Normal Foreground
BRW1::PAV:RS:NormalBG LONG                        ! Normal Background
BRW1::PAV:RS:SelectedFG LONG                      ! Selected Foreground
BRW1::PAV:RS:SelectedBG LONG                      ! Selected Background
BRW1::PAV:BAITS1       LIKE(PAV:BAITS1)           ! Queue Display field
BRW1::PAV:BAITS1:NormalFG LONG                    ! Normal Foreground
BRW1::PAV:BAITS1:NormalBG LONG                    ! Normal Background
BRW1::PAV:BAITS1:SelectedFG LONG                  ! Selected Foreground
BRW1::PAV:BAITS1:SelectedBG LONG                  ! Selected Background
BRW1::PAV:EXP          LIKE(PAV:EXP)              ! Queue Display field
BRW1::PAV:EXP:NormalFG LONG                       ! Normal Foreground
BRW1::PAV:EXP:NormalBG LONG                       ! Normal Background
BRW1::PAV:EXP:SelectedFG LONG                     ! Selected Foreground
BRW1::PAV:EXP:SelectedBG LONG                     ! Selected Background
BRW1::PAV:DATUMS       LIKE(PAV:DATUMS)           ! Queue Display field
BRW1::PAV:DATUMS:NormalFG LONG                    ! Normal Foreground
BRW1::PAV:DATUMS:NormalBG LONG                    ! Normal Background
BRW1::PAV:DATUMS:SelectedFG LONG                  ! Selected Foreground
BRW1::PAV:DATUMS:SelectedBG LONG                  ! Selected Background
BRW1::PAV:D_K          LIKE(PAV:D_K)              ! Queue Display field
BRW1::PAV:D_K:NormalFG LONG                       ! Normal Foreground
BRW1::PAV:D_K:NormalBG LONG                       ! Normal Background
BRW1::PAV:D_K:SelectedFG LONG                     ! Selected Foreground
BRW1::PAV:D_K:SelectedBG LONG                     ! Selected Background
BRW1::PAV:DOK_SENR     LIKE(PAV:DOK_SENR)         ! Queue Display field
BRW1::PAV:DOK_SENR:NormalFG LONG                  ! Normal Foreground
BRW1::PAV:DOK_SENR:NormalBG LONG                  ! Normal Background
BRW1::PAV:DOK_SENR:SelectedFG LONG                ! Selected Foreground
BRW1::PAV:DOK_SENR:SelectedBG LONG                ! Selected Background
BRW1::PAV:NOKA         LIKE(PAV:NOKA)             ! Queue Display field
BRW1::PAV:NOKA:NormalFG LONG                      ! Normal Foreground
BRW1::PAV:NOKA:NormalBG LONG                      ! Normal Background
BRW1::PAV:NOKA:SelectedFG LONG                    ! Selected Foreground
BRW1::PAV:NOKA:SelectedBG LONG                    ! Selected Background
BRW1::PAV:PAMAT        LIKE(PAV:PAMAT)            ! Queue Display field
BRW1::PAV:PAMAT:NormalFG LONG                     ! Normal Foreground
BRW1::PAV:PAMAT:NormalBG LONG                     ! Normal Background
BRW1::PAV:PAMAT:SelectedFG LONG                   ! Selected Foreground
BRW1::PAV:PAMAT:SelectedBG LONG                   ! Selected Background
BRW1::PAV:SUMMA        LIKE(PAV:SUMMA)            ! Queue Display field
BRW1::PAV:SUMMA:NormalFG LONG                     ! Normal Foreground
BRW1::PAV:SUMMA:NormalBG LONG                     ! Normal Background
BRW1::PAV:SUMMA:SelectedFG LONG                   ! Selected Foreground
BRW1::PAV:SUMMA:SelectedBG LONG                   ! Selected Background
BRW1::PAV:val          LIKE(PAV:val)              ! Queue Display field
BRW1::PAV:val:NormalFG LONG                       ! Normal Foreground
BRW1::PAV:val:NormalBG LONG                       ! Normal Background
BRW1::PAV:val:SelectedFG LONG                     ! Selected Foreground
BRW1::PAV:val:SelectedBG LONG                     ! Selected Background
BRW1::AVAK             LIKE(AVAK)                 ! Queue Display field
BRW1::AVAK:NormalFG LONG                          ! Normal Foreground
BRW1::AVAK:NormalBG LONG                          ! Normal Background
BRW1::AVAK:SelectedFG LONG                        ! Selected Foreground
BRW1::AVAK:SelectedBG LONG                        ! Selected Background
BRW1::PAV:NODALA       LIKE(PAV:NODALA)           ! Queue Display field
BRW1::PAV:NODALA:NormalFG LONG                    ! Normal Foreground
BRW1::PAV:NODALA:NormalBG LONG                    ! Normal Background
BRW1::PAV:NODALA:SelectedFG LONG                  ! Selected Foreground
BRW1::PAV:NODALA:SelectedBG LONG                  ! Selected Background
BRW1::PAV:OBJ_NR       LIKE(PAV:OBJ_NR)           ! Queue Display field
BRW1::PAV:OBJ_NR:NormalFG LONG                    ! Normal Foreground
BRW1::PAV:OBJ_NR:NormalBG LONG                    ! Normal Background
BRW1::PAV:OBJ_NR:SelectedFG LONG                  ! Selected Foreground
BRW1::PAV:OBJ_NR:SelectedBG LONG                  ! Selected Background
BRW1::PAV:REK_NR       LIKE(PAV:REK_NR)           ! Queue Display field
BRW1::PAV:REK_NR:NormalFG LONG                    ! Normal Foreground
BRW1::PAV:REK_NR:NormalBG LONG                    ! Normal Background
BRW1::PAV:REK_NR:SelectedFG LONG                  ! Selected Foreground
BRW1::PAV:REK_NR:SelectedBG LONG                  ! Selected Background
BRW1::PAV:U_NR         LIKE(PAV:U_NR)             ! Queue Display field
BRW1::PAV:U_NR:NormalFG LONG                      ! Normal Foreground
BRW1::PAV:U_NR:NormalBG LONG                      ! Normal Background
BRW1::PAV:U_NR:SelectedFG LONG                    ! Selected Foreground
BRW1::PAV:U_NR:SelectedBG LONG                    ! Selected Background
BRW1::PAV:C_SUMMA      LIKE(PAV:C_SUMMA)          ! Queue Display field
BRW1::PAV:C_SUMMA:NormalFG LONG                   ! Normal Foreground
BRW1::PAV:C_SUMMA:NormalBG LONG                   ! Normal Background
BRW1::PAV:C_SUMMA:SelectedFG LONG                 ! Selected Foreground
BRW1::PAV:C_SUMMA:SelectedBG LONG                 ! Selected Background
BRW1::NOL:DATUMS       LIKE(NOL:DATUMS)           ! Queue Display field
BRW1::JOB_NR           LIKE(JOB_NR)               ! Queue Display field
BRW1::ATLAUTS          LIKE(ATLAUTS)              ! Queue Display field
BRW1::SAV_PAR_NR       LIKE(SAV_PAR_NR)           ! Queue Display field
BRW1::PAV:PAR_NR       LIKE(PAV:PAR_NR)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(PAV:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(PAV:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(PAV:DATUMS)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:SAV_PAR_NR LIKE(SAV_PAR_NR)
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort3:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort3:KeyDistribution LIKE(PAV:DATUMS),DIM(100)
BRW1::Sort3:LowValue LIKE(PAV:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort3:HighValue LIKE(PAV:DATUMS)            ! Queue position of scroll thumb
BRW1::QuickScan      BYTE                         ! Flag for Range/Filter test
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
WinResize            WindowResizeType
QuickWindow          WINDOW('Browse the PAVAD File'),AT(-1,-1,452,295),FONT('MS Sans Serif',9,,FONT:bold),IMM,VSCROLL,HLP('BrowsePAVAD'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&1-Seanss'),USE(?Seanss)
                           ITEM,SEPARATOR
                           ITEM('&4-Darba �urn�ls'),USE(?SeanssDarbaZurnalsNol)
                         END
                         MENU('&3-Sist�mas dati'),USE(?System)
                           ITEM,SEPARATOR
                           ITEM('&3-Lok�lie dati'),USE(?SystemLok�liedati)
                           ITEM('&4-Autokont�juma u Bilances r��ina algoritmi'),USE(?SystemKAutokont�jumaalgoritms)
                         END
                         MENU('&4-Faili'),USE(?Faili)
                           ITEM('&1-Partneru saraksts'),USE(?4Faili1Partnerusaraksts),FIRST
                           ITEM('&9-Nomenklat�ru saraksts'),USE(?BrowseNOM_K),MSG('Browse NOM_K')
                           ITEM('&A-M�rvien�bas'),USE(?BrowseMER_K),MSG('Browse MER_K')
                           ITEM('&B-Atlaides'),USE(?BrowseATLAIDES),MSG('Browse ATLAIDES')
                           ITEM('&C-Grupas'),USE(?FailiGrupas)
                           ITEM('&D-Auto'),USE(?FailiAuto)
                           ITEM('&E-Automarkas'),USE(?4FailiAutomarkas)
                           ITEM('&F-Mekl�jumu statistika'),USE(?FailiMekl�jumustatistika)
                           ITEM,SEPARATOR
                           ITEM('&G-Pas�t�jumi'),USE(?FailiPasut)
                           ITEM('&H-Inventariz�cijas'),USE(?4FailiGInventariz�cija)
                           ITEM('&I-Eirokodi'),USE(?4FailiIEirokodi)
                           ITEM('&J-Servisa pl�not�js'),USE(?4FailiJSEPL)
                           ITEM,SEPARATOR
                           MENU('&Z-Izzi�as no failiem'),USE(?4FailiIzzi�asnofailiem)
                             ITEM('&7-Grupas un apak�grupas '),USE(?4FailiZIzzi�asnofailiem7GA)
                             ITEM('&8-Cenu lapa'),USE(?4Faili9Izzi�asnofailiem8Cenulapa)
                             ITEM('&9-Mekl�jumu statistika'),USE(?4Faili9Izzi�asnofailiem9Mekl�jumustatistika)
                             ITEM('&A-Der�guma termi�a atskaite '),USE(?4Faili9Izzi�asnofailiemADer�gumatermi�aatskaite)
                             ITEM('&B-Sast�vda�u atskaite'),USE(?4Faili9Izzi�asnofailiemBSast�vda�uatskaite)
                           END
                         END
                         MENU('&5-Izzi�as no DB'),USE(?DBizzinas)
                           MENU('&1-Ien�ku��s preces'),USE(?VienasnoliktavasatskaitesIenPreces)
                             ITEM('&1-Ien�ku��s preces (NOM)'),USE(?VienasnoliktavasatskaitesIen�ko��sprecesItem34)
                             ITEM('&2-Ien�ku��s preces (S-NOM)'),USE(?VienasnoliktavasatskaitesIen�ku��sprecesIen�ku��spreces2SNOM)
                             ITEM('&3-Ien�ku��s preces (PAV)'),USE(?VienasnoliktavasatskaitesIen�ku��sprecesIen�ku��spreces3PAV)
                             ITEM('&4-Pre�u / Taras (PAV)'),USE(?VienasnoliktavasatskaitesIen�ku��sprecesPre�uTaras4PAV)
                             ITEM('&5-Ien�ku��s preces/X cenu (S-NOM)'),USE(?VienasnoliktavasatskaitesIen�ku��sprecesIen�ku�aspreces5RC)
                             ITEM('&6-P�capmaksa / Realiz. (PAV)'),USE(?VienasnoliktavasatskaitesIen�ku��sprecesP�capmaksakons6PAV)
                             ITEM('&7-Pieg�d�t�ju atskaite (S-PAR)'),USE(?VienasnoliktavasatskaitesIen�ku��sprecesPieg�d�t�juatskaite8PA)
                             ITEM('&8-Degvielas P/Z re�. �urn�ls'),USE(?Izzi�asIen�ku��sprecesDegvielasPZre��urn�ls)
                             ITEM('&9-Ien�ku��s preces (S-OBJ)'),USE(?5Izzi�asnoDB1Ien�ku��spreces9Ien�ku��sprecesOBJ)
                             ITEM('&A-Sa�emto PPR re�istrs'),USE(?5Izzi�asnoDB1Ien�ku��sprecesAa�emtoPPRre�istrs)
                             ITEM('&B-Ien�ku��s p�c izv�l�t�s P/Z'),USE(?5Izzi�asnoDB1Ien�ku��sprecesBIen�ku��sp�cizv�l�)
                           END
                           MENU('&2-Izg�ju�as preces'),USE(?VienasnoliktavasatskaitesIzg�j��aspreces)
                             ITEM('&1-Izg�ju��s preces (NOM)'),USE(?VienasnoliktavasatskaitesIzg�j��asprecesItem41)
                             ITEM('&2-Izg�ju��s preces (S - NOM)'),USE(?VienasnoliktavasatskaitesIzg�j��asprecesIzg�j���spreces2SNOM)
                             ITEM('&3-Izg�ju��s preces (S - NOM_grup�m)'),USE(?5Izzi�asnoDBIzg�ju�asprecesIzg�ju��spreces6SG)
                             ITEM('&4-Izg�ju��s preces (S - NOM_gr.,apak�grup�m)'),USE(?5Izzi�asnoDB2Izg�ju�aspreces4Izg�ju��sprecesSNO)
                             ITEM('&5-Izg�ju�as preces (S - NOM_ra�ot�jiem)'),USE(?Izzi�asnoDBIzg�ju�asprecesIzg�ju�aspreces10SRA�)
                             ITEM('&6-Izg�ju��s preces (PAV)'),USE(?VienasnoliktavasatskaitesIzg�j��asprecesIzg�j���spreces3PAV)
                             ITEM('&7-Pre�u / Taras /x-cenu (PAV)'),USE(?VienasnoliktavasatskaitesIzg�j��asprecesPre�uTaras4PAV)
                             ITEM('&8-P�capmaksa /Realiz. (PAV)'),USE(?VienasnoliktavasatskaitesIzg�j��asprecesP�capmaksakons5PAV)
                             ITEM('&9-Izg�ju��s / X cenu (S-NOM)'),USE(?VienasnoliktavasatskaitesIzg�j��asprecesIzg�ju��sXcenu7NOM)
                             ITEM('&A-Pirc�ju atskaite (PAR)'),USE(?VienasnoliktavasatskaitesIzg�j��asprecesPirc�juatskaite8PAR)
                             ITEM('&B-Izg�ju��s preces (S - PAR)'),USE(?VienasnoliktavasatskaitesIzg�j��asprecesPirc�judinamika9PAR)
                             ITEM('&C-Izg�ju��s preces (S - OBJ)'),USE(?5Izzi�asnoDB2Izg�ju�asprecesCIzg�ju��sprecesOBJ)
                             ITEM('&D-Degvielas P/Z re�. �urn�ls'),USE(?Izzi�asIzg�j��asprecesDegvielasPZre��urn�ls)
                             ITEM('&E-Izrakst�to PPR Re�istrs'),USE(?5Izzi�asnoDB2Izg�ju�asprecesDIzrakst�toPPRRe�istrs)
                           END
                           MENU('&3-Preces noliktav�'),USE(?VienasnoliktavasatskaitesGadaatskaitesDinamika)
                             ITEM('&1-Pre�u atlikumi'),USE(?VienasnoliktavasatskaitesGadaatskaitesDinamikaPre�uatlikumi)
                             ITEM('&2-Pre�u apgroz�juma re�istr�cijas �urn�ls'),USE(?VienasnoliktavasatskaitesGadaatskaitesDinamikaApgroz�jums)
                             ITEM('&3-Inventariz�cijas akts'),USE(?VienasnoliktavasatskaitesGadaatskaitesDinamikaInventariz�cijas),KEY(29556)
                             ITEM('&4-Izzi�a SALDO rakstam'),USE(?VienasnoliktavasatskaitesGadaatskaitesDinamikaIzzi�aSALDOrakst)
                             ITEM('&5-Ien�ku�o/Izg�ju�o P/Z kopsavilkums'),USE(?5Izzi�asnoDB3Precesnoliktav�6Ien�ku�oIzg�ju�oPZkopsavilkums)
                             ITEM('&6-Pre�u uzskaites karti�a-P�RCELTA UZ NOMENKLAT�R�M'),USE(?5Izzi�asnoDB3Precesnol6PrUK),DISABLE
                           END
                           MENU('&4-Gada atskaites (Dinamika)'),USE(?VienasnoliktavasatskaitesGadaatskaitesDinamika2)
                             ITEM('&1-Nomenklat�ru atskaite'),USE(?VienasnoliktavasatskaitesGadaatskaitesDinamikaNomenklat�ruatsk),KEY(25972)
                             ITEM('&2-Pirc�ju atskaite'),USE(?VienasnoliktavasatskaitesGadaatskaitesDinamikaPirc�juatskaite)
                           END
                           MENU('&5-Anal�ze'),USE(?VienasnoliktavasatskaitesAnal�ze)
                             ITEM('&1-Pas�t�jumu -(NOM) Datumu sec�b�'),USE(?VienasnoliktavasatskaitesAnal�zePas�t�jumuien�k�anassec�b�)
                             ITEM('&2-Pas�t�jumu (NOM) Kopsavilkums'),USE(?VienasnoliktavasatskaitesAnal�zePas�t�jumuNomenklat�rassec�b�)
                             ITEM('&3-Realiz�cijas - Nomenklat�ru sec�b�'),USE(?VienasnoliktavasatskaitesAnal�zeRealiz�cijasNomenklat�rusec�b�),DISABLE
                             ITEM('&4-Ieguld�jumu anal�ze'),USE(?Izzi�asAnal�zeIeguld�jumuanal�ze),DISABLE
                             ITEM('&5-Uzcenojumu anal�ze p�c X-cenas'),USE(?Izzi�asnoDBAnal�zeUzcenojumuanal�ze)
                             ITEM('&6-Uzcenojuma anal�ze p�c realiz�cijas'),USE(?5Izzi�asnoDB5Anal�ze6Uzcenojumaanal�zeR)
                             ITEM('&7-Projektu(Obj.) kopsavilkums (PAV)'),USE(?5Izzi�asnoDB5Anal�ze7ProjektuObjkopsavilkums)
                           END
                           MENU('&6-Servisa atskaites'),USE(?Izzi�asnoDBServisaatskaites)
                             ITEM('&1-Meh�ni�u darba laika kopsavilkums'),USE(?ServisaatskaiteMehnostrstundaS)
                             ITEM('&2-Meh�ni�a darba laika atskaite'),USE(?ServisaatskaiteMehdarbastundaS)
                             ITEM('&3-Automa��nas karti�a'),USE(?Izzi�asnoDBServisaatskaitesAutoma��naskarti�a)
                             ITEM('&4-Nomain�t�s da�as un veiktie darbi '),USE(?5Izzi�asnoDB6Servisaatskaites4Nomain�t�sda�asunveiktiedarbi)
                             ITEM('&5-Servisa darbu uzskaite'),USE(?5Izzi�asnoDB6Servisaatskaites5Servisadarbuuzskaite)
                             ITEM('&6-Transportl�dzek�a tehnisk� st�vok�a nov�rt�jums'),USE(?5Izzi�asnoDB6Servisaatskaites6Transportl�dzek�atehnisk�st�vok�),KEY(30319)
                             ITEM('&7-TTS nov�rt�juma anal�ze'),USE(?5Izzi�asnoDB6Servisaatskaites7TTSnov�rt�jumaanal�ze)
                             ITEM('&8-Servisa Lapas'),USE(?5Izzi�asnoDB6Servisaatskaites8ServisaLapas)
                           END
                           ITEM('&7-Pre�u pieteikums (&Dinamiskais)'),USE(?VienasnoliktavasatskaitesPre�upieteikumsDinamiskais)
                           ITEM('&8-309 r�kojums'),USE(?Izzi�as309r�kojums),DISABLE
                           ITEM('&9-Kritiskie atlikumi'),USE(?Izzi�asKritiskieatlikumi)
                           ITEM('1&0-Dinamiskie atlikumi'),USE(?Izzi�asDin),DISABLE
                         END
                         MENU('&A-Mulitnoliktavu atskaites'),USE(?5Izzi�asnoDBMulitnoliktavuatskaites)
                           ITEM('&1-Realiz�cijas kopsavilkums'),USE(?5Izzi�asnoDBMulitnoliktavuatskaitesrealiz�cijas)
                           ITEM('&2-Pirc�ju atskaite'),USE(?AMulitnoliktavuatskaites2Pirc�juatskaite)
                           ITEM('&3-Pre�u atlikumi noliktav�s'),USE(?AMulitnoliktavuatskaitesItem119)
                           ITEM('&4-Pre�u atlikumi  (S - NOM_grup�m)'),USE(?AMulitnoliktavuatskaites4SNOMgrup�m)
                           ITEM('&5-Preces bez kust�bas'),USE(?AMulitnoliktavuatskaites4Precesbezkust�bas)
                         END
                         MENU('&6-Speci�l�s funkcijas'),USE(?Speci�l�sfunkcijas)
                           ITEM('&1-Atv�rt (aizv�rt) datu bloku'),USE(?AtAizDatubloku),DISABLE
                           ITEM('&2-Apvienot K(P) pavadz�mes'),USE(?SpecFAPVKPZ)
                           ITEM('&3-Sadal�t gabalos izv�l�to P/Z'),USE(?SpecFSADPZ)
                           ITEM('&4-Saspiest izv�l�to P/Z'),USE(?6Speci�l�sfunkcijas4Saspiestizv�l�tiPZ)
                           ITEM('&5-Nodz�st atlikumu failu'),USE(?NodzestNomA),DISABLE
                           ITEM('&6-Nodz�st lielu datu bloku'),USE(?Nodzestlieludatubloku),DISABLE
                           ITEM('&7-Atrast Summu uz leju no teko��s P/Z'),USE(?AtrastSummu)
                           ITEM('&8-Atrast Dok Nr fragmentu uz leju no teko��s P/Z'),USE(?AtrastNr)
                           ITEM('&9-Atrast R��. Nr uz leju no teko��s P/Z'),USE(?Speci�l�sfunkcijasAtrastRekNr)
                           ITEM('1&0-Uzb�v�t Komplekt�cijas dokumentus'),USE(?SpecFjasUzbtKomplekt)
                           ITEM('&A-Uzb�v�t D/K P/Z p�c pre�u atlikumiem'),USE(?6Speci�l�sfunkcijasAUzb�v�tDPZnegat�viempre�uatlikumiem)
                           ITEM('&B-Druk�t sv�tru kodu uzl�mes p�c izv�l�t�s P/Z'),USE(?6Speci�l�sfunkcijasBDruk�tsv�trukoduuzl�mesp�cizv�l�t�sPZ)
                           ITEM('&C-Druk�t Marsruta lapu p�c izv�l�t�s P/Z'),USE(?6Speci�l�sfunkcijasCDruk�tMarsrutalapup�cizv�l�t�sPZ)
                           ITEM('&D-Sar��in�t P/Z par�dus p�c gr�matved�bas datiem'),USE(?6Speci�l�sfunkcijasDSar��in�tPZpar�dusp�cgr�mat),DISABLE
                         END
                         MENU('&2-Serviss'),USE(?Serviss)
                           ITEM,SEPARATOR
                           ITEM('&2-Selftests'),USE(?ServissSelftests)
                           ITEM('&3-Importa interfeiss'),USE(?ServissImportainterfeiss)
                         END
                         MENU('&7-Datu apmai�a'),USE(?Datuapmai�a)
                           ITEM('&1-Rakst�t kases apar�tu'),USE(?RakstitKA)
                           ITEM('&2-Las�t kases apar�tu'),USE(?LasitKA)
                           ITEM('&3-KA Darba �urn�ls'),USE(?Datuapmai�aKADarba�urn�ls)
                           ITEM('&4-Rakst�t el. svarus'),USE(?7Datuapmai�a4Rakst�telsvarus)
                           ITEM('&5-Las�t uzkr�jo�o skaneri'),USE(?7Datuapmai�a5Las�tuzkr�jo�oskaneri)
                           ITEM('&6-Rakst�t uzkr�jo�o skaneri'),USE(?7DatuapmainaRakstituzkrajososkaneri),DISABLE
                           ITEM,SEPARATOR
                           ITEM('&7-Uzb�v�t dbf-u p�c izv�l�t�s P/Z'),USE(?Datuapmai�aUzb�v�tdbfup�cizv�l�t�sPZ)
                           ITEM('&8-Las�t apmai�as dbf-u'),USE(?Datuapmai�aLas�tapmai�asdbfu)
                           ITEM('&9-Uzb�v�t apmai�as tps failus'),USE(?Datuapmai�aUzb�v�tapmai�astpsfailusp�cizv�l�t�sPZ)
                           ITEM('&0-Las�t apmai�as tps failus'),USE(?Datuapmai�aLas�tapmai�astpsfailus)
                           ITEM,SEPARATOR
                           ITEM('&A-Datu imports no citas DB (WinLats)'),USE(?Datuapmai�aDatuimportsnocitasDBWinLats)
                           ITEM('&B-Uzb�v�t D un K iek��j�s p�rvieto�anas P/Z-es'),USE(?Datuapmai�aUzb�v�tDunKiek��j�sp�rvieto�anasPZes)
                           ITEM('&C-Uzb�v�t D un K IP Projektus p�c Krit.atl. un Priorit�tes'),USE(?7Datuapmai�aCUzb�v�tDunKIPPZesp�cKritatlunPrior)
                           ITEM('&D-Nolas�t i-NET apmai�as failu'),USE(?Datuapmai�aNolas�tinetaapmai�asfailu)
                           ITEM('&E-Uzb�v�t D un K Projektus no Pas�t�jumiem'),USE(?Datuapmai�aUzb�v�tDKP)
                           ITEM('&F-Nolas�t TAMRO'),USE(?7Datuapmai�aENolas�tTAMRO)
                           ITEM('&G-Nolas�t VP failus'),USE(?7Datuapmai�aFNolas�tVP)
                           ITEM('&H-Uzb�v�t servisa apmai�as.txt'),USE(?7Datuapmai�aHUzb�v�tservisaapmai�astxt)
                           ITEM('&I-Nolas�t \IMPEXP\vedlegg.txt'),USE(?7DatuapmainaINolVEDLEGG)
                           ITEM('&J-Nolas�t \IMPEXP\VW_Cenas.txt'),USE(?7DatuapmainaJNolVW_Cenastxt)
                           ITEM('&K-Nolas�t\IMPEXP\Invoice.txt'),USE(?7Datuapmai�aKNolas�tIMPEXPInvoicetxt)
                           ITEM('&L-Nolas�t \IMPEXP\Subaru_Cenas.rtf'),USE(?7Datuapmai�a7LNolas�tIMPEXPSubaru)
                           ITEM('&M-Nolas�t Skodas_Nom.xml'),USE(?7Datuapmai�aMNolas�tSkodasNomxml)
                           ITEM('&O-Nomenklat�ru imports no XLS (nom.xls)'),USE(?7Datuapmai�aO)
                           ITEM,SEPARATOR
                           ITEM('&P-Telema(eksports)'),USE(?7Datuapmai�aPTelemaeksports)
                           ITEM('&Q-Telema(imports)'),USE(?7Datuapmai�aQTelemaimports)
                         END
                       END
                       LIST,AT(2,17,442,252),USE(?Browse:1),IMM,VSCROLL,FONT('MS Sans Serif',10,,FONT:bold),MSG('Browsing Records'),FORMAT('10C|M*~X~@n1b@10C|M*~Y~@s1@10C|M*~S~@n1B@10C|M*~E~@n1B@45R(1)|M*~Datums~C(0)@d06' &|
   '.B@10C|M*@s1@55R(1)|M*~S�rija-Nr~C(0)@s14@71L(1)|M*~Partneris~C(0)@s15@101L(1)|M' &|
   '*~Pamatojums~C(0)@s25@51R(1)M*~Summa~R(4)@n-15.2@17L|M*@s3@10C|M*~A~@s2@11C|M*~N' &|
   '~@s2@23L|M*~P~C@n_6B@38R(1)|M*~R��.Nr~C(0)@s10@25R(1)|M*~U_NR~C(0)@n_8@40R(1)|M*' &|
   '~Par�ds~R(4)@n-12.2@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievad�t'),AT(276,276,41,14),USE(?Insert:3)
                       BUTTON('&Main�t'),AT(318,276,42,14),USE(?Change:3),DEFAULT
                       BUTTON('&Dz�st'),AT(362,276,45,14),USE(?Delete:3)
                       BUTTON('&Beigt'),AT(409,276,41,14),USE(?Cancel)
                       BUTTON('&S'),AT(21,276,16,14),USE(?ButtonS),TIP('Sl�gt/Atv�rt rakstu')
                       BUTTON('&C-kop�t'),AT(129,276,35,14),USE(?ButtonCopy)
                       BUTTON('&X'),AT(3,276,16,14),USE(?ButtonX)
                       BUTTON('I&nfo'),AT(248,276,26,14),USE(?ButtonInfo)
                       BUTTON('&Pavadz�mes'),AT(165,276,48,14),USE(?selpz)
                       BUTTON('&e-mail'),AT(214,276,33,14),USE(?Buttonemail)
                       SHEET,AT(-1,0,450,273),USE(?CurrentTab)
                         TAB('D&atumu sec�ba'),USE(?Tab1)
                           ENTRY(@d6),AT(41,278),USE(PAV:DATUMS),CENTER
                           STRING('-(DDMM)'),AT(95,281),USE(?String122)
                         END
                         TAB('Par&tneris (augo�� datumu sec�b�)'),USE(?Tab2)
                           BUTTON('Partneris'),AT(39,276,45,14),USE(?ButtonPartneris)
                         END
                         TAB('SE-NR (augo�� dok. sec�b�)'),USE(?Tab3)
                           ENTRY(@s7),AT(43,276,26,14),USE(PAV:DOK_SENR),UPR
                           STRING('-(SE)'),AT(72,279),USE(?StringSE)
                         END
                       END
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
   !PIRMS CLARIS RAUJ VA�� FAILUS
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  !*******DATI VISAM NOLIKTAVU SEANSAM********
  ?BROWSE:1{PROP:FORMAT}=GETINI('BrowsePAVAD','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  gads=GL:DB_GADS
  VAL_nos='Ls'
!  S_DAT=DATE(1,1,DB_GADS)
!  IF GL:DB_GADS=YEAR(TODAY())
!     B_DAT=TODAY()
!     SAV_DATUMS=TODAY()
!  ELSE
!     B_DAT=DATE(12,31,GL:DB_GADS)
!     SAV_DATUMS=DATE(12,31,GL:DB_GADS)
!  .
  SAV_DATUMS=B_DAT  !???
  NOKL_CP=SYS:NOKL_CP !NOKLUS�T� CENA PRECEI
  IF ~NOKL_CP THEN NOKL_CP=1.
  NOKL_CA=SYS:NOKL_CA !NOKLIUS�T� CENA PAKALPOJUMIEM
  IF ~NOKL_CA THEN NOKL_CA=1.
  IF BAND(SYS:BAITS1,00000100B) !Vairumtirdzniec�ba
     NOL_TIPS='Vairumtirdzniec�bas'
  ELSE
     NOL_TIPS='Mazumtirdzniec�bas'
  .
  
  !*******PASSWORD LEVEL ACCESS CONTROL********
  IF ATLAUTS[1]='1' !SUPERACC
     ENABLE(?AtAizDatubloku)
     ENABLE(?NodzestNomA)
     ENABLE(?Nodzestlieludatubloku)
  .
  IF ATLAUTS[10]='1' !AIZLIEGTA DATU APMAI�A UN IMP_INT
     DISABLE(?ServissImportaInterfeiss)
     DISABLE(?Datuapmai�aLas�tapmai�asdbfu)
     DISABLE(?Datuapmai�aDatuimportsnocitasDBWinLats)
     DISABLE(?Datuapmai�aUzb�v�tDunKiek��j�sp�rvieto�anasPZes)
     DISABLE(?Datuapmai�aNolas�tinetaapmai�asfailu)
     DISABLE(?Datuapmai�aUzb�v�tDKP)
  .
  IF ATLAUTS[17]='1' !AIZLIEGTS SELFTESTS (9+8)
     DISABLE(?ServissSelftests)
  .
  IF ATLAUTS[11]='1' !AIZLIEGTS APSKAT�T D P/Z UN JEBKURU PIEEJU IEP CEN�M
     DISABLE(?VienasnoliktavasatskaitesIenPreces)
     DISABLE(?5Izzi�asnoDB5Anal�ze6Uzcenojumaanal�zeR)
     DISABLE(?Izzi�asnoDBAnal�zeUzcenojumuanal�ze)
  .
  IF ATLAUTS[14]='1' !AIZLIEGTS APVIENOT/SADAL�T P/Z
     DISABLE(?SpecFAPVKPZ)
     DISABLE(?SpecFSADPZ)
  .
  IF ATLAUTS[15]='1' !AIZLIEGTA PIEEJA PAS�T�JUMIEM
     DISABLE(?FailiPasut)
  .
  IF ATLAUTS[19]='1' !AIZLIEGTS ATV�RT/SL�GT P/Z
     DISABLE(?ButtonS)
  .

  IF SEC:SPEC_ACC[11]='3' AND ~(ACC_KODS_N=0) !AIZLIEGTA PIEEJA MEISTARU ATSKAIT�M
     disable(?ServisaatskaiteMehnostrstundaS)
     disable(?ServisaatskaiteMehdarbastundaS)
  .

  MAINIT231531=FALSE  ! AIZLIEDZAM MAIN�T GG-RAKSTUS CAUR BRPAR_K-REFERGG
  DO PERFORM_OPEN
  CASE SYS:U_SKANERIS
     OF '4'           !DATALOGIC
     OROF '6'         !FORMULA WIZARD
     ENABLE(?7DatuapmainaRakstituzkrajososkaneri)
  .
  CASE SYS:KASES_AP
     OF '9'           ! FP-600
     OROF '19'        ! FP-600PLUS
     OROF '20'        ! CHD-3010T FISCAL
     OROF '21'        ! CHD-5010T FISCAL
     OROF '22'        ! EPOS-3L
     OROF '24'        ! OMRON-2810 F
     OROF '28'        ! CHD-3510T FISCAL
     OROF '29'        ! CHD-5510T FISCAL
     DISABLE(?RakstitKA)
  .
  
  !*******USER LEVEL ACCESS CONTROL********
  IF ~BAND(REG_NOL_ACC,00000001b) ! KA
     DISABLE(?RakstitKA)
     DISABLE(?LasitKA)
     DISABLE(?Datuapmai�aKADarba�urn�ls)
     DISABLE(?7Datuapmai�a4Rakst�telsvarus)
  .
  IF ~BAND(REG_NOL_ACC,00000010b) ! LASERSCAN
     DISABLE(?7Datuapmai�a5Las�tuzkr�jo�oskaneri)
     DISABLE(?7DatuapmainaRakstituzkrajososkaneri)
  .
  IF ~BAND(REG_NOL_ACC,00000100b) ! AUTOSERVISS
     DISABLE(?Izzi�asnoDBServisaatskaites)
     DISABLE(?4FailiJSEPL)
  .
  IF ~BAND(REG_NOL_ACC,00001000b) ! PAS�T�JUMI
     DISABLE(?FailiPasut)
  .
  IF ~BAND(REG_NOL_ACC,00010000b) ! KOMPLEKT�CIJA
     DISABLE(?SpecFjasUzbtKomplekt)
  .
  ACCEPT
     QUICKWINDOW{PROP:TEXT}=CLIP(LOC_NR)&'.'&CLIP(NOL_TIPS)&' Noliktava  '&CLIP(RECORDS(pavad))&'('&CLIP(RECORDS(NOLIK))&') raksti '&CLIP(LONGpath())&' Adrese: '&clip(SYS:ADRESE)&' Atv�rts no '&FORMAT(SYS:GIL_SHOW,@D06.B)
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE ACCEPTED()
    OF ?SeanssDarbaZurnalsNol
      DO SyncWindow
      DarbaZurnals 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?SystemLok�liedati
      DO SyncWindow
      GlobalRequest = ChangeRecord
      UpdateSystem 
      LocalRequest = OriginalRequest
      DO RefreshWindow
  CASE SYS:KASES_AP
     OF '9'           ! FP-600
     OROF '19'        ! FP-600PLUS
     OROF '20'        ! CHD-3010T FISCAL
     OROF '21'        ! CHD-5010T FISCAL
     OROF '22'        ! EPOS-3L
     OROF '24'        ! OMRON-2810 F
     OROF '28'        ! CHD-3510T FISCAL
     OROF '29'        ! CHD-5510T FISCAL
     DISABLE(?RakstitKA)
  ELSE
     ENABLE(?RakstitKA)
  .
  DISPLAY
    OF ?SystemKAutokont�jumaalgoritms
      DO SyncWindow
      UpdateSystem_AutoKont 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4Faili1Partnerusaraksts
      DO SyncWindow
      BrowsePAR_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BrowseNOM_K
      DO SyncWindow
      BrowseNOM_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BrowseMER_K
      DO SyncWindow
      BrowseMER_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BrowseATLAIDES
      DO SyncWindow
      BrowseAtl_k 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?FailiGrupas
      DO SyncWindow
      BrowseGrupas 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?FailiAuto
      DO SyncWindow
      BrowseAuto 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiAutomarkas
      DO SyncWindow
      BrowseAutoMarkas 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?FailiMekl�jumustatistika
      DO SyncWindow
      BrowseNOM_N 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?FailiPasut
      DO SyncWindow
      BrowsePavPas 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiGInventariz�cija
      DO SyncWindow
      BrowseInvent 
      LocalRequest = OriginalRequest
      DO RefreshWindow
            BRW1::LocateMode = LocateOnEdit
            DO BRW1::LocateRecord
            DO BRW1::RefreshPage
            DO BRW1::InitializeBrowse
            DO BRW1::PostNewSelection
            SELECT(?Browse:1)
            LocalRequest = OriginalRequest
            LocalResponse = RequestCancelled
            DO RefreshWindow
    OF ?4FailiIEirokodi
      DO SyncWindow
      BrowseEirokodi 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiJSEPL
      DO SyncWindow
      BrowseAU_BILDE 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiZIzzi�asnofailiem7GA
      DO SyncWindow
       OPCIJA='0'
       IZZFILTF
       IF GLOBALRESPONSE=REQUESTCOMPLETED
          START(F_PrintGrupas,50000)
       .
    OF ?4Faili9Izzi�asnofailiem8Cenulapa
      DO SyncWindow
      OPCIJA='0000010300001011000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(F_PriceList,50000)
      END
    OF ?4Faili9Izzi�asnofailiem9Mekl�jumustatistika
      DO SyncWindow
       OPCIJA='0011000300000000000000'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
             START(F_MEKLEJUMI,50000)
       .
    OF ?4Faili9Izzi�asnofailiemADer�gumatermi�aatskaite
      DO SyncWindow
      OPCIJA='0002010300000010001001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(F_DERTER,50000)
      END
    OF ?4Faili9Izzi�asnofailiemBSast�vda�uatskaite
      DO SyncWindow
      OPCIJA='0000000300000000000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(F_Sastavdalas,50000)
      END
    OF ?VienasnoliktavasatskaitesIen�ko��sprecesItem34
      DO SyncWindow
       OPCIJA='1011110300000020001001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
         IF PAR_NR=999999999
            START(N_IENMAT,50000)            ! Visas ien�ku��s preces
         ELSE
            START(N_IENMATP,50000)           ! Ien�ku��s no konkr�ta partnera
         END
       END
    OF ?VienasnoliktavasatskaitesIen�ku��sprecesIen�ku��spreces2SNOM
      DO SyncWindow
       OPCIJA='1011110300000000000001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
             START(N_IENNOM,50000)                 ! Visas ien�ku��s preces
      !    ELSE
      !       START(N_IENNOMP,50000)                ! Ien�ku��s no konkr�ta partnera
      !    END
       END
    OF ?VienasnoliktavasatskaitesIen�ku��sprecesIen�ku��spreces3PAV
      DO SyncWindow
       OPCIJA='1011100310000000100001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          IF PAR_NR = 999999999
             START(N_IENPAV,50000)               !Sa�emt�s PZ visi
          ELSE
             START(N_IENPAVP,50000)              !Sa�emt�s PZ no konkr�ta
          END
       END
    OF ?VienasnoliktavasatskaitesIen�ku��sprecesPre�uTaras4PAV
      DO SyncWindow
       OPCIJA='0011100300000000100001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
             START(N_IENPT,50000)               !Pre�u/Taras PZ no V/konkr�ta
      !    ELSE
      !       START(N_IENPTP,50000)              !Pre�u/Taras PZ no konkr�ta
      !    END
       .
    OF ?VienasnoliktavasatskaitesIen�ku��sprecesIen�ku�aspreces5RC
      DO SyncWindow
       OPCIJA='1011110310200001089001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
             START(N_IENNOMR,50000)               !Ien�ku��s preces RC
      !    ELSE
      !       START(N_IENNOMRP,50000)              !Ien�ku��s preces RC no konkr�ta
      !    END
       .
    OF ?VienasnoliktavasatskaitesIen�ku��sprecesP�capmaksakons6PAV
      DO SyncWindow
       OPCIJA='0011100302000000100001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
      !       START(N_IEKO,50000)               !Konsign�cijas preces
      !    ELSE
             START(N_IEKOP,50000)              !Konsign�cijas preces no konkr�ta
      !    END
       .
    OF ?VienasnoliktavasatskaitesIen�ku��sprecesPieg�d�t�juatskaite8PA
      DO SyncWindow
        OPCIJA='0011110300000000100001'
      !         1234567890123456789012
        IZZFILTN
        IF GlobalResponse=RequestCompleted
           IZZFILTMINMAX
           IF GlobalResponse=RequestCompleted
              D_K='D'
              START(N_LielPPAtsk,50000)
           END
        END
    OF ?Izzi�asIen�ku��sprecesDegvielasPZre��urn�ls
      DO SyncWindow
      D_K = 'D'
      OPCIJA='0011000000000000000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse = RequestCompleted
         START(N_REGZUR,50000)
      END
    OF ?5Izzi�asnoDB1Ien�ku��spreces9Ien�ku��sprecesOBJ
      DO SyncWindow
       OPCIJA='1011000300000000000001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          START(N_IEN_SOBJ,50000)               !Ien�ku��s preces (S_OBJ)
       END
    OF ?5Izzi�asnoDB1Ien�ku��sprecesAa�emtoPPRre�istrs
      DO SyncWindow
       OPCIJA='0011010340000000000001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          D_K='D'
          START(N_IENIZGPAVREG,50000)
       END
    OF ?5Izzi�asnoDB1Ien�ku��sprecesBIen�ku��sp�cizv�l�
      DO SyncWindow
       IF ~INSTRING(PAV:D_K,'D1',1)
          KLUDA(0,'Izv�l�ta '&PAV:D_K&' pavadz�me')
       ELSE
          OPCIJA='0000010300000030001001'
         !        1234567890123456789012
          IZZFILTN
          IF GlobalResponse = RequestCompleted
             F:DTK='1'
             PAV::U_NR=PAV:U_NR
             PAR_NR=PAV:PAR_NR
             S_DAT=PAV:DATUMS
             B_DAT=PAV:DATUMS
             D_K=PAV:D_K
             START(N_IENMATP,50000)           ! Ien�ku��s no konkr�tas PPR
          .
       .
    OF ?VienasnoliktavasatskaitesIzg�j��asprecesItem41
      DO SyncWindow
       OPCIJA='0111110300000020111111'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
             START(N_IZGMAT,50000)               !Izg�ju��s preces (NOM) V/K
      !    ELSE
      !       START(N_IZGMATP,50000)              !Izg�ju��s preces (NOM) konkr�tam
      !    END
       .
    OF ?VienasnoliktavasatskaitesIzg�j��asprecesIzg�j���spreces2SNOM
      DO SyncWindow
       OPCIJA='0111110350000000110111'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          OPCIJA_NR=1
          START(N_IZG_SNom,50000)               !Izg�ju��s preces (S-NOM)
       END
    OF ?5Izzi�asnoDBIzg�ju�asprecesIzg�ju��spreces6SG
      DO SyncWindow
       OPCIJA='0111110350000000110001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          OPCIJA_NR=2
          START(N_IZG_SNom,50000)               !Izg�ju��s preces (S-NOM-G)
       END
    OF ?5Izzi�asnoDB2Izg�ju�aspreces4Izg�ju��sprecesSNO
      DO SyncWindow
       OPCIJA='0111110350000000110001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          OPCIJA_NR=3
          START(N_IZG_SNom,50000)               !Izg�ju��s preces (S-NOM-AG)
       END
    OF ?Izzi�asnoDBIzg�ju�asprecesIzg�ju�aspreces10SRA�
      DO SyncWindow
       OPCIJA='0111110350000000110001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          OPCIJA_NR=4
          START(N_IZG_SNom,50000)               !Izg�ju��s preces (S-NOM-RAZ)
       END
    OF ?VienasnoliktavasatskaitesIzg�j��asprecesIzg�j���spreces3PAV
      DO SyncWindow
       OPCIJA='0111100310000000100111'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
             START(N_IZGPAV,50000)               !Izg�ju��s PZ V/K
      !    ELSE
      !       START(N_IZGPAVP,50000)              !Izg�ju��s PZ no konkr�ta
      !    END
       END
    OF ?VienasnoliktavasatskaitesIzg�j��asprecesPre�uTaras4PAV
      DO SyncWindow
       OPCIJA='0011100300000001100001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
             START(N_IZGPT,50000)               !Izg�ju��s pre�u/taras PZ  V/K
      !    ELSE
      !       START(N_IZGPTP,50000)              !Izg�ju��s pre�u/taras PZ no konkr�ta
      !    END
       .
    OF ?VienasnoliktavasatskaitesIzg�j��asprecesP�capmaksakons5PAV
      DO SyncWindow
       OPCIJA='0011100302000000100001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
      !       START(N_IZGKONS,50000)               !Atdots uz konsign�ciju visiem PAV
      !    ELSE
             START(N_IZGKONSP,50000)              !Atdots uz konsign�ciju konkr�tam PAV
      !    END
       .
    OF ?VienasnoliktavasatskaitesIzg�j��asprecesIzg�ju��sXcenu7NOM
      DO SyncWindow
       OPCIJA='0111110300000001101011'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          START(N_IZGMAT5,50000)               !Izg�ju��s/PIC (NOM)
       END
      
       
    OF ?VienasnoliktavasatskaitesIzg�j��asprecesPirc�juatskaite8PAR
      DO SyncWindow
      OPCIJA='0011110300000000100001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
         IZZFILTMINMAX
         IF GlobalResponse=RequestCompleted
             D_K='K'
             START(N_LielPPAtsk,50000)
         END
      .
    OF ?VienasnoliktavasatskaitesIzg�j��asprecesPirc�judinamika9PAR
      DO SyncWindow
      IF ~INSTRING(D_K,'K3') THEN D_K='K'.
      OPCIJA='0111110300000000100001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_IZG_SPar,50000)
      END
    OF ?5Izzi�asnoDB2Izg�ju�asprecesCIzg�ju��sprecesOBJ
      DO SyncWindow
       OPCIJA='0111000300000000000001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
             START(N_IZG_SObj,50000)       !Izg�ju��s preces (OBJ)
      !    ELSE
      !       START(,50000)              !Izg�ju��s preces (OBJ) no konkr�ta
      !    END
       END
    OF ?Izzi�asIzg�j��asprecesDegvielasPZre��urn�ls
      DO SyncWindow
      D_K = 'K'
      OPCIJA='0011000000000000000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse = RequestCompleted
         START(N_REGZUR,50000)
      END
    OF ?5Izzi�asnoDB2Izg�ju�asprecesDIzrakst�toPPRRe�istrs
      DO SyncWindow
       OPCIJA='0011010340000000000001'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          D_K='K'
          START(N_IENIZGPAVREG,50000)
       END
    OF ?VienasnoliktavasatskaitesGadaatskaitesDinamikaPre�uatlikumi
      DO SyncWindow
      OPCIJA='0002010314000001001001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          F:NOA=''  !TIKAI �� NOLIKTAVA
          START(N_MATNOL,50000)
      END
    OF ?VienasnoliktavasatskaitesGadaatskaitesDinamikaApgroz�jums
      DO SyncWindow
      OPCIJA='0011010300002001000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_IENIZGNOL,50000)
      END
    OF ?VienasnoliktavasatskaitesGadaatskaitesDinamikaInventariz�cijas
      DO SyncWindow
      OPCIJA='0002010300001511000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_INVAKTS,50000)
      END
    OF ?VienasnoliktavasatskaitesGadaatskaitesDinamikaIzzi�aSALDOrakst
      DO SyncWindow
      OPCIJA='0000000300000000001001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_IZZSAL,50000)
      END
    OF ?5Izzi�asnoDB3Precesnoliktav�6Ien�ku�oIzg�ju�oPZkopsavilkums
      DO SyncWindow
      OPCIJA='0011000300000002000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_IenIzgPZKOPS,50000)
      END
    OF ?5Izzi�asnoDB3Precesnol6PrUK
      DO SyncWindow
    OF ?VienasnoliktavasatskaitesGadaatskaitesDinamikaNomenklat�ruatsk
      DO SyncWindow
      OPCIJA='0000110300000000000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_RealDinG,50000)
      END
    OF ?VienasnoliktavasatskaitesGadaatskaitesDinamikaPirc�juatskaite
      DO SyncWindow
      OPCIJA='0000110300000000000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
         IZZFILTMINMAX
         IF GlobalResponse=RequestCompleted
            START(N_RealDinPG,50000)
         .
      END
    OF ?VienasnoliktavasatskaitesAnal�zePas�t�jumuien�k�anassec�b�
      DO SyncWindow
      OPCIJA='00110103000000000000'
      !       12345678901234567890
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_PASAN,50000)
      END
    OF ?VienasnoliktavasatskaitesAnal�zePas�t�jumuNomenklat�rassec�b�
      DO SyncWindow
      OPCIJA='00110103000000000000'
      !       12345678901234567890
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_PASAN1,50000)
      END
    OF ?VienasnoliktavasatskaitesAnal�zeRealiz�cijasNomenklat�rusec�b�
      DO SyncWindow
      OPCIJA='00110101000000000000'
      !       12345678901234567890
      IZZFILTN
      IF GlobalResponse=RequestCompleted
         IZZFILTMINMAX
         IF GlobalResponse=RequestCompleted
            START(N_REALAN,50000)
         .
      END
    OF ?Izzi�asAnal�zeIeguld�jumuanal�ze
      DO SyncWindow
      STOP('Dr�z b�s :-)')
      !IZZFILTN('00021100000000000000')
      !          12345678901234567890
      !IF GlobalResponse=RequestCompleted
      !    START(IEGAN,50000)
      !END
    OF ?Izzi�asnoDBAnal�zeUzcenojumuanal�ze
      DO SyncWindow
      OPCIJA='00000103001111140000'
      !       12345678901234567890
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          F:DTK=''
          START(N_uzcenojums,50000)
      END
    OF ?5Izzi�asnoDB5Anal�ze6Uzcenojumaanal�zeR
      DO SyncWindow
      OPCIJA='00111103001111130000'
      !       12345678901234567890
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          F:DTK='1' !P�C REALIZ�CIJAS FAKTA/PIC
          START(N_uzcenojums,50000)
      END
    OF ?5Izzi�asnoDB5Anal�ze7ProjektuObjkopsavilkums
       OPCIJA='00111003800000000000'
      !        12345678901234567890
       IZZFILTN
       IF GlobalResponse = RequestCompleted
      !    IF PAR_NR = 999999999
             START(N_ObjKops,50000)
      !    ELSE
      !       START(N_IZGPAVP,50000)              ! no konkr�ta
      !    END
       END
      DO SyncWindow
    OF ?ServisaatskaiteMehnostrstundaS
      DO SyncWindow
      OPCIJA='2100001100' !1-periods,2-Kadri visi,sekt,konkr,3-grupa,4-XML,5-F:IDP,6-2WE3WE4WAE,7-SB_DAT,8-D/N,9-AL/AVA
      !       1234567890
      IZZFILTA
      IF GlobalResponse=RequestCompleted
          START(S_MEHVISI,50000)
      .
    OF ?ServisaatskaiteMehdarbastundaS
      DO SyncWindow
      GlobalRequest = SelectRecord               ! Set Action for Lookup
      BrowseKADRI                                ! Call the Lookup Procedure
      IF GlobalResponse=RequestCompleted
         ID=KAD:ID
         LocalResponse = GlobalResponse             ! Save Action for evaluation
         GlobalResponse = RequestCancelled          ! Clear Action
         LocalResponse = RequestCancelled
         OPCIJA='00110003000000000100'
      !          12345678901234567890
         IZZFILTN
         IF GlobalResponse=RequestCompleted
            START(S_MEH1,50000)
         END
      END
    OF ?Izzi�asnoDBServisaatskaitesAutoma��naskarti�a
      DO SyncWindow
      GlobalRequest = SelectRecord
      BrowseAUTO
      IF GlobalResponse=REQUESTCOMPLETED
         AUT_NR=AUT:U_NR
         OPCIJA='1120010'
      !          1234567
         IZZFILTS
         IF GlobalResponse=RequestCompleted
            START(S_AUTOKARTE,50000)
         .
      END
    OF ?5Izzi�asnoDB6Servisaatskaites4Nomain�t�sda�asunveiktiedarbi
      DO SyncWindow
       GLOBALREQUEST=SELECTRECORD
       BROWSEAUTO
       IF GlobalResponse = RequestCompleted
          AUT_NR=AUT:U_NR
          OPCIJA='00110100000000000000'
      !           12345678901234567890
          IZZFILTN
          IF GlobalResponse = RequestCompleted
             START(S_DARBI,50000)
          END
       END
    OF ?5Izzi�asnoDB6Servisaatskaites5Servisadarbuuzskaite
      DO SyncWindow
       OPCIJA='00110000000000000000'
      !        12345678901234567890
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          START(S_UZSKAITE,50000)
       END
    OF ?5Izzi�asnoDB6Servisaatskaites6Transportl�dzek�atehnisk�st�vok�
      DO SyncWindow
      START(S_TTSN,50000)
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?5Izzi�asnoDB6Servisaatskaites7TTSnov�rt�jumaanal�ze
      DO SyncWindow
         OPCIJA='00110000000000000000'
      !          12345678901234567890
         IZZFILTN
         IF GlobalResponse=RequestCompleted
            START(S_NOVERT,50000)
         .
    OF ?5Izzi�asnoDB6Servisaatskaites8ServisaLapas
      DO SyncWindow
         OPCIJA='00110000000000000000'
      !          12345678901234567890
         IZZFILTN
         IF GlobalResponse=RequestCompleted
            START(S_LAPAS,50000)
         .
    OF ?VienasnoliktavasatskaitesPre�upieteikumsDinamiskais
      DO SyncWindow
      OPCIJA='00000100200000000000'
      !       12345678901234567890
      IZZFILTN
      IF GlobalResponse=RequestCompleted
         IZZFILTKRIT
         IF GlobalResponse=RequestCompleted
            START(N_DPIETEIK,50000)
         .
      END
    OF ?Izzi�as309r�kojums
      DO SyncWindow
      OPCIJA='00000101001111000000'
      !       12345678901234567890
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(N_R309,50000)
      END
    OF ?Izzi�asKritiskieatlikumi
      DO SyncWindow
      OPCIJA='0000010360023405000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
         START(N_KRIATL,50000)
      END
    OF ?Izzi�asDin
      DO SyncWindow
      OPCIJA='00000100000000000000'
      !       12345678901234567890
      IZZFILTN
      IF GlobalResponse=RequestCompleted
         IZZFILTKRIT
         IF GlobalResponse=RequestCompleted
            START(N_DINATL,50000)
         .
      END
    OF ?5Izzi�asnoDBMulitnoliktavuatskaitesrealiz�cijas
      DO SyncWindow
       OPCIJA='0111100300000000100010'
      !        1234567890123456789012
       IZZFILTN
       IF GlobalResponse = RequestCompleted
          START(M_REALIZKOPS,50000)               !Realiz�cijas kosavilkums
       END
    OF ?AMulitnoliktavuatskaites2Pirc�juatskaite
      DO SyncWindow
      OPCIJA='0011110390000000100011'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
         IZZFILTMINMAX
         IF GlobalResponse=RequestCompleted
             D_K='K'
             START(M_LielPPAtsk,50000)
         END
      .
    OF ?AMulitnoliktavuatskaitesItem119
      DO SyncWindow
      OPCIJA='0000010314000001000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          F:NOA='1' !VISAS NOL NO NOM_ATLIKUMIEM
          START(N_MATNOL,50000)
      END
    OF ?AMulitnoliktavuatskaites4SNOMgrup�m
      DO SyncWindow
      OPCIJA='0002020304300001000001'
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          F:NOA='1' !VISAS NOL 
          START(N_MAT_SNom,50000)
      END
    OF ?AMulitnoliktavuatskaites4Precesbezkust�bas
      DO SyncWindow
      !OPCIJA='0011010300000001001001'
      OPCIJA='0000010300000001001001' !BEZ 34
      !       1234567890123456789012
      IZZFILTN
      IF GlobalResponse=RequestCompleted
          START(M_MATNOLBK,50000)
      END
    OF ?AtAizDatubloku
      DO SyncWindow
      EnterGIL_Show 
      LocalRequest = OriginalRequest
      DO RefreshWindow
      if GLOBALRESPONSE=requestcompleted
         checkopen(system,1)
         DO BRW1::InitializeBrowse
         DO BRW1::RefreshPage
         QUICKWINDOW{PROP:TEXT}=CLIP(LOC_NR)&'.Noliktava  '&CLIP(RECORDS(pavad))&' raksti '&CLIP(LONGpath())&' Adrese: '&clip(SYS:ADRESE)&' Atv�rts no '&FORMAT(SYS:GIL_SHOW,@D06.B)
         DISPLAY
      .
    OF ?SpecFAPVKPZ
      DO SyncWindow
      BrowsePavadApv(1)
      !IF GLOBALRESPONSE=REQUESTCOMPLETED
        DO BRW1::InitializeBrowse
        DO BRW1::RefreshPage
        DISPLAY
      !ELSE
      !  STOP('Q')
      !.
    OF ?SpecFSADPZ
      DO SyncWindow
      SplitPZ(1)
      IF GLOBALRESPONSE=REQUESTCOMPLETED
        DO BRW1::InitializeBrowse
        DO BRW1::RefreshPage
      .
    OF ?6Speci�l�sfunkcijas4Saspiestizv�l�tiPZ
      DO SyncWindow
      SplitPZ(2)
    OF ?NodzestNomA
      DO SyncWindow
       CLOSE(NOM_A)
       OPEN(NOM_A,12h)
       IF ERROR()
          KLUDA(1,'NOM_ATLIKUMI')
       ELSE
          EMPTY(NOM_A)
          KLUDA(0,'FAILS nodz�sts, tagad j�palai� Selftests vis�s noliktav�s, lai atjaunotu atlikumus')
       .
    OF ?Nodzestlieludatubloku
      DO SyncWindow
      OPEN(ASKSCREEN)
      IF ATLAUTS[1]='1' OR ~(ATLAUTS[18]='1')
         UNHIDE(?String:RS)
         UNHIDE(?RS)
      END
      RS=''
      DOK_SK#=0
      IER_SK#=0
      PROCESS=''
      PROCESS1=''
      PROCESS2=''
      DISPLAY
      ACCEPT
         CASE FIELD()
         OF ?OkButton
            CASE EVENT()
            OF EVENT:Accepted
               DO SyncWindow
               CLOSE(PAVAD)
               OPEN(PAVAD,12h)
               IF ERROR()
                  KLUDA(1,'PAVAD')
                  CHECKOPEN(PAVAD,1)
                  CYCLE
               .
               CLOSE(NOLIK)
               OPEN(NOLIK,12h)
               IF ERROR()
                  KLUDA(1,'NOLIK')
                  CHECKOPEN(NOLIK,1)
                  CYCLE
               .
               CLEAR(PAV:RECORD)
               PAV:DATUMS=B_DAT
               PAV:D_K='W'
               PAV:DOK_SENR='zzzzzzzzzzzzzz' !visaugst�kais ASCII kods norm�lam burtam
               SET(PAV:DAT_KEY,PAV:DAT_KEY)
               LOOP
                  NEXT(PAVAD)
                  IF ERROR() OR PAV:DATUMS < S_DAT THEN BREAK.
                  IF PAV:U_NR=1 THEN CYCLE.     !SALDO IGNOR�JAM ANYWAY
                  IF ~(X=PAV:KEKSIS) THEN CYCLE.
                  IF ~(RS=PAV:RS) THEN CYCLE.
                  IF RIDELETE:PAVAD()  !P�R�K L�NI
                     KLUDA(26,'PAVAD U_NR='&PAV:U_NR)
                  .
      !            CLEAR(NOL:RECORD)
      !            NOL:U_NR=PAV:U_NR
      !            SET(NOL:NR_KEY,NOL:NR_KEY)
      !            LOOP
      !               NEXT(NOLIK)
      !               IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
      !               DELETE(NOLIK)
      !               IER_SK#+=1
      !            .
      !            DELETE(PAVAD)
                  DOK_SK#+=1
      !            PROCESS='Kop�: '&CLIP(DOK_SK#)&' Dokumenti '&CLIP(IER_SK#)&' raksti'
                  PROCESS='Kop�: '&CLIP(DOK_SK#)&' Dokumenti '
                  display(?process)
               .
               ?CancelButton{prop:text}='Beigt'
               HIDE(?OKBUTTON)
               DISPLAY
            .
         OF ?CancelButton
            CASE EVENT()
            OF EVENT:Accepted
               break
            END
         END
      .
      CLOSE(ASKSCREEN)
      IF DOK_SK#
         WriteZurnals(1,3,'PAVAD DATU BLOKS '&CHR(9)&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&CHR(9)&CLIP(DOK_SK#)&|
         CHR(9)&' Dokumenti')
      !           PRESSKEY(CTRLPGDN)
         BRW1::RefreshMode = RefreshOnQueue
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
      
    OF ?AtrastSummu
      DO SyncWindow
      DO SyncWindow
      S_DAT=PAV:DATUMS-60
      SUMMA_W(6)
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         SearchRequest#=1
         DO FOUNDIT
      .
    OF ?AtrastNr
      DO SyncWindow
      DO SyncWindow
      S_DAT=PAV:DATUMS-60
      SUMMA_W(7)
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         SearchRequest#=2
         DO FOUNDIT
      .
    OF ?Speci�l�sfunkcijasAtrastRekNr
      DO SyncWindow
      DO SyncWindow
      S_DAT=PAV:DATUMS-60
      SUMMA_W(7)
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         SearchRequest#=3
         DO FOUNDIT
      .
    OF ?SpecFjasUzbtKomplekt
      DO SyncWindow
         OPCIJA='111'
         IZZFILTGMC
         IF GlobalResponse = RequestCompleted
            OPEN(ProgressWindow)
            HIDE(?Progress:Thermometer)
            P#=0
            CHECKOPEN(KOMPLEKT,1)
            CLEAR(nol:record)
            NOL:DATUMS=S_DAT
            SET(NOL:DAT_KEY,NOL:DAT_KEY)
            LOOP
               NEXT(NOLIK)
               P#+=1
               ?Progress:UserString{PROP:TEXT}=P#
               DISPLAY
               IF ERROR() OR NOL:DATUMS>B_DAT THEN BREAK.
               IF ~INSTRING(NOL:D_K,'DK') THEN CYCLE.
               IF BAND(NOL:BAITS,00001000B)         !VECS IERAKSTS
                  IF GETPAVADZ(NOL:U_NR)
                     IF NOL:D_K='K'
                        KLUDA(0,'D���u veco sast�vda�u norakst��anas dokumentu no '&FORMAT(PAV:DATUMS,@D6))
                     ELSE
                        KLUDA(0,'D���u veco komplektu b�v��anas dokumentu no '&FORMAT(PAV:DATUMS,@D6))
                     .
                     DELETE(PAVAD) !RIDELETE NEDR�KST
                  .
                  AtlikumiN('','',0,NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS)
                  KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
                  DELETE(NOLIK)
               ELSIF NOL:D_K='K' AND GETNOM_K(NOL:NOMENKLAT,0,16)='R'  ! P�RDOTS RA�OJUMS
                  GET(R_TABLE,0)
                  R:NOMENKLAT=NOL:NOMENKLAT
                  GET(R_TABLE,R:NOMENKLAT)
                  IF ERROR()
                     R:NOMENKLAT=NOL:NOMENKLAT
                     R:DAUDZUMS=NOL:DAUDZUMS
                     R:CENA=NOM:PIC   !PAGAID�M
                     ADD(R_TABLE)
      !               SORT(R_TABLE,R:NOMENKLAT) SORT�JAM V�L�K
                  ELSE
                     R:DAUDZUMS+=NOL:DAUDZUMS
                     PUT(R_TABLE)
                  .
                  R_CENA=0
                  CLEAR(KOM:RECORD)
                  KOM:NOMENKLAT=NOL:NOMENKLAT
                  SET(KOM:NOM_KEY,KOM:NOM_KEY)
                  LOOP
                     NEXT(KOMPLEKT)
                     IF ERROR() OR ~(KOM:NOMENKLAT=NOL:NOMENKLAT) THEN BREAK.
                     GET(S_TABLE,0)
                     S:NOMENKLAT=KOM:NOM_SOURCE
                     GET(S_TABLE,S:NOMENKLAT)
                     IF ERROR()
                        S:NOMENKLAT=KOM:NOM_SOURCE
                        S:DAUDZUMS=NOL:DAUDZUMS*KOM:DAUDZUMS
                        IF GETNOM_K(KOM:NOM_SOURCE,0,1)
                           S:CENA=NOM:PIC
                        ELSE
                           S:CENA=0
                        .
                        ADD(S_TABLE)
                        SORT(S_TABLE,S:NOMENKLAT)
                     ELSE
                        S:DAUDZUMS+=NOL:DAUDZUMS*KOM:DAUDZUMS
                        PUT(S_TABLE)
                     .
                     R_CENA+=S:CENA*KOM:DAUDZUMS
                  .
                  R:CENA=R_CENA  !POZICION�TS
                  PUT(R_TABLE)
                  SORT(R_TABLE,R:NOMENKLAT)
                  I#= GETNOM_K(NOL:NOMENKLAT,0,1)  !POZICION�JAM
                  IF ~(NOM:PIC=R_CENA)
                     NOM:PIC=R_CENA
                     NOM:PIC_DATUMS=TODAY()
                     PUT(NOM_K)
                     IF ERROR()
                        STOP('Rakstot NOM_k:'&NOM:NOMENKLAT&ERROR())
                     .
                  .
               .
            .
            IF RECORDS(R_TABLE)
               DO AUTONUMBER
               IF B_DAT<TODAY()
                  PAV:DATUMS=B_DAT
               ELSE
                  PAV:DATUMS=TODAY()
               .
               PAV:DOKDAT=PAV:DATUMS
               PAV:D_K='D'
               PAV:PAR_NR=26 !RA�O�ANA
               PAV:NOKA='Ra�o�ana'
               PAV:PAMAT='Komplektu uz�em�ana no ra�o�anas '&FORMAT(S_DAT,@D6)&'-'&FORMAT(B_DAT,@D6)
               PAV:SUMMA=0
               PAV:ACC_KODS=ACC_KODS
               PAV:DATUMS=TODAY()
               LOOP I#=1 TO RECORDS(R_TABLE)
                  P#+=1
                  ?Progress:UserString{PROP:TEXT}=P#
                  DISPLAY
                  GET(R_TABLE,I#)
                  CLEAR(NOL:RECORD)
                  NOL:U_NR=PAV:U_NR
                  NOL:DATUMS=PAV:DATUMS
                  NOL:NOMENKLAT=R:NOMENKLAT
                  NOL:PAR_NR=PAV:PAR_NR
                  NOL:D_K=PAV:D_K
                  NOL:RS=PAV:RS
                  NOL:DAUDZUMS=R:DAUDZUMS
                  NOL:SUMMA=R:DAUDZUMS*R:CENA
                  NOL:SUMMAV=NOL:SUMMA
                  PAV:SUMMA+=NOL:SUMMA
                  !01/03/2015 NOL:VAL='Ls'
                  !01/03/2015 <
                  IF GL:DB_GADS > 2013   
                    NOL:VAL='EUR'        
                  ELSE                   
                    NOL:VAL='Ls'         
                  .
                  !01/03/2015 >                    
                  NOL:BAITS=8
                  ADD(NOLIK)
                  IF ERROR()
                     STOP('Rakstot nolik:'&ERROR())
                  ELSE
                     AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
                     KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
                  .
               .
               PUT(PAVAD)
            .
            IF RECORDS(S_TABLE)
               DO AUTONUMBER
               IF B_DAT<TODAY()
                  PAV:DATUMS=B_DAT
               ELSE
                  PAV:DATUMS=TODAY()
               .
               PAV:DOKDAT=PAV:DATUMS
               PAV:D_K='K'
               PAV:PAR_NR=26 !RA�O�ANA
               PAV:NODALA=SYS:NODALA
               PAV:NOKA='Ra�o�ana'
               PAV:PAMAT='Sast�vda�u norakst��ana '&FORMAT(S_DAT,@D6)&'-'&FORMAT(B_DAT,@D6)
               PAV:SUMMA=0
               PAV:ACC_KODS=ACC_KODS
               PAV:DATUMS=TODAY()
               LOOP I#=1 TO RECORDS(S_TABLE)
                  P#+=1
                  ?Progress:UserString{PROP:TEXT}=P#
                  DISPLAY
                  GET(S_TABLE,I#)
                  CLEAR(NOL:RECORD)
                  NOL:U_NR=PAV:U_NR
                  NOL:DATUMS=PAV:DATUMS
                  NOL:NOMENKLAT=S:NOMENKLAT
                  NOL:PAR_NR=PAV:PAR_NR
                  NOL:D_K=PAV:D_K
                  NOL:RS=PAV:RS
                  NOL:DAUDZUMS=S:DAUDZUMS
                  NOL:SUMMA=S:DAUDZUMS*S:CENA
                  NOL:SUMMAV=NOL:SUMMA
                  PAV:SUMMA+=NOL:SUMMA
                  !01/03/2015 NOL:VAL='Ls'
                  !01/03/2015 <
                  IF GL:DB_GADS > 2013   
                     NOL:VAL='EUR'
                  ELSE                   
                     NOL:VAL='Ls'
                  .
                  !01/03/2015 >
                  NOL:BAITS+=8
                  ADD(NOLIK)
                  IF ERROR()
                     STOP('Rakstot nolik :'&ERROR())
                  ELSE
                     AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
                     KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
                  .
               .
               PUT(PAVAD)
            .
            CLOSE(ProgressWindow)
            FREE(R_TABLE)
            FREE(S_TABLE)
            CLOSE(KOMPLEKT)
         END
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
    OF ?6Speci�l�sfunkcijasAUzb�v�tDPZnegat�viempre�uatlikumiem
      DO SyncWindow
      !   OPCIJA='20030100340000010000'
         OPCIJA='2003010034000001001000'
      !          1234567890123456789012
         IZZFILTN
         IF GlobalResponse = RequestCompleted
            OPEN(PROGRESSWINDOW)
            RecordsProcessed = 0
            RecordsToProcess = RECORDS(NOM_K)
            CLEAR(NOM:record)
            NOM:NOMENKLAT=NOMENKLAT
            SET(NOM:NOM_KEY,NOM:NOM_KEY)
            LOOP
               NEXT(NOM_K)
               IF ERROR() THEN BREAK.
               RecordsProcessed += 1
               DISPLAY
               IF PercentProgress < 100
                  PercentProgress = (RecordsProcessed / RecordsToProcess)*100
                  IF PercentProgress > 100
                     PercentProgress = 100
                  END
                  IF PercentProgress <> Progress:Thermometer THEN
                     Progress:Thermometer = PercentProgress
                     ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
                     ?Progress:USERSTRING{Prop:Text} = FORMAT(RecordsProcessed,@N6)
                     DISPLAY
                  END
               END
      !         IF NOM:TIPS='A' THEN CYCLE.
               IF ~INSTRING(NOM:TIPS,NOM_TIPS7) THEN CYCLE.
               IF CYCLENOM(NOM:NOMENKLAT) THEN CYCLE.
               ATLIKUMS=LOOKATL(3) !K� F-JA NO RST
               IF (ATLIKUMS>0 AND F:ATL[1]='1') OR (ATLIKUMS=0 AND F:ATL[2]='1') OR (ATLIKUMS<0 AND F:ATL[3]='1')
      !         IF ATLIKUMS < 0
                  R:NOMENKLAT=NOM:NOMENKLAT
                  R:DAUDZUMS=ABS(ATLIKUMS)
                  R:CENA=GETNOM_K('POZICION�TS',0,7)   !1-5C,PIC
                  IF F:DTK
                     R:PVN_PROC=0
                  ELSE
                     R:PVN_PROC=NOM:PVN_PROC
                  .
                  IF GETNOM_K('POZICION�TS',0,10)      !AR/BEZ PVN
                     R:ARBYTE=1
                  .
                  IF BAND(NOM:BAITS1,00000010b)        !PIEFIKS�JAM NEAPLIEKAM�S
                     R:BAITS=2
                  .
                  ADD(R_TABLE)
               .
            .
            IF RECORDS(R_TABLE)
               DO AUTONUMBER
               IF B_DAT<TODAY()
                  PAV:DATUMS=B_DAT
               ELSE
                  PAV:DATUMS=TODAY()
               .
               PAV:DOKDAT=PAV:DATUMS
               PAV:D_K=D_K
               IF D_K='D' AND F:ATL='001'
                  PAV:PAR_NR=27 !RA�O�ANA
                  PAV:NOKA='Ra�o�ana'
                  PAV:PAMAT='K��d.nor.pre�u atjauno�.'
               ELSE
                  PAV:PAR_NR=0
                  PAV:NOKA=''
                  PAV:PAMAT='P�c atlikumiem F:'&F:ATL
               .
               PAV:SUMMA=0
               LOOP I#=1 TO RECORDS(R_TABLE)
                  GET(R_TABLE,I#)
                  CLEAR(NOL:RECORD)
                  NOL:U_NR=PAV:U_NR
                  NOL:DATUMS=PAV:DATUMS
                  NOL:NOMENKLAT=R:NOMENKLAT
                  NOL:PAR_NR=PAV:PAR_NR
                  NOL:D_K=PAV:D_K
                  NOL:RS=PAV:RS
                  NOL:DAUDZUMS=R:DAUDZUMS
                  NOL:SUMMA=R:DAUDZUMS*R:CENA
                  NOL:SUMMAV=NOL:SUMMA
                  NOL:PVN_PROC=R:PVN_PROC
                  NOL:ARBYTE=R:ARBYTE
                  NOL:BAITS=R:BAITS
                  PAV:SUMMA+=NOL:SUMMA
                  !01/03/2015 NOL:VAL='Ls'
                  !01/03/2015 <
                  IF GL:DB_GADS > 2013   
                     NOL:VAL='EUR'
                  ELSE                   
                     NOL:VAL='Ls'
                  .
                  !01/03/2015 >
                        !            NOL:BAITS+=8
                  ADD(NOLIK)
                  IF ERROR()
                     STOP('ADD NOLIK'&ERROR())
                  ELSE
                     AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
                     KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
                  .
               .
               PUT(PAVAD)
            ELSE
               KLUDA(0,'Nav pre�u p�c piepras�t� filtra')
            .
            FREE(R_TABLE)
         END
         CLOSE(PROGRESSWINDOW)
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
    OF ?6Speci�l�sfunkcijasBDruk�tsv�trukoduuzl�mesp�cizv�l�t�sPZ
      DO SyncWindow
      DO SyncWindow
      CASE SYS:SK_DRUKA
      OF '3'     !BZB-2
         AI_SK_WRITE(0)
      ELSE
         CLEAR(NOL:RECORD)
         NOL:U_NR=PAV:U_NR
         SET(NOL:NR_KEY,NOL:NR_KEY)
         LOOP
            NEXT(NOLIK)
            IF ~(NOL:U_NR=PAV:U_NR) OR ERROR() THEN BREAK.
            IF GETNOM_K(NOL:NOMENKLAT,0,4) !IR SV�TRU KODS
               AI_SK_WRITE(ROUND(NOL:DAUDZUMS,1))
            .
         .
      .
    OF ?6Speci�l�sfunkcijasCDruk�tMarsrutalapup�cizv�l�t�sPZ
      DO SyncWindow
      S_MARSRUTI 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?6Speci�l�sfunkcijasDSar��in�tPZpar�dusp�cgr�mat
      DO SyncWindow
    OF ?ServissSelftests
      DO SyncWindow
      OPCIJA='1111'
      IZZFILTSF
      IF GlobalResponse=RequestCompleted
          START(SELFTESTNOL,50000)
      END
    OF ?ServissImportainterfeiss
      DO SyncWindow
      BROWSEGG1 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?RakstitKA
      DO SyncWindow
      AI_KA_WRITE 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?LasitKA
      DO SyncWindow
      AI_KA_READ 
      LocalRequest = OriginalRequest
      DO RefreshWindow
      !  IF GlobalResponse = RequestCompleted
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
    OF ?Datuapmai�aKADarba�urn�ls
        CLOSE(ZURNALS)
        DZNAME='DZKA'&FORMAT(JOB_NR,@N02) !DARBA �URN�LS
        CheckOpen(ZURNALS,1)
      DO SyncWindow
      DarbaZurnals 
      LocalRequest = OriginalRequest
      DO RefreshWindow
        CLOSE(ZURNALS)
        DZNAME='DZ'&FORMAT(JOB_NR,@N02) !DARBA �URN�LS
        CheckOpen(ZURNALS,1)
    OF ?7Datuapmai�a4Rakst�telsvarus
      DO SyncWindow
      AI_SVARI_WRITE 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?7Datuapmai�a5Las�tuzkr�jo�oskaneri
      F:KRI=''
      DO SyncWindow
      AI_R_BARMAN 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?7DatuapmainaRakstituzkrajososkaneri
      F:KRI='1'
      DO SyncWindow
      AI_R_BARMAN 
      LocalRequest = OriginalRequest
      DO RefreshWindow
      F:KRI=''
    OF ?Datuapmai�aUzb�v�tdbfup�cizv�l�t�sPZ
      DO SyncWindow
      RW_PAV_DBF(1)
    OF ?Datuapmai�aLas�tapmai�asdbfu
      DO SyncWindow
         RW_PAV_DBF(2)
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
    OF ?Datuapmai�aUzb�v�tapmai�astpsfailusp�cizv�l�t�sPZ
      DO SyncWindow
         RW_APM_TPS(1)
         DO BRW1::InitializeBrowse
         DO BRW1::RefreshPage
         DISPLAY
    OF ?Datuapmai�aLas�tapmai�astpsfailus
      DO SyncWindow
      RW_APM_TPS(2)
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::RefreshPage
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      SELECT(?Browse:1)
      LocalRequest = OriginalRequest
      LocalResponse = RequestCancelled
      DO RefreshWindow
    OF ?Datuapmai�aDatuimportsnocitasDBWinLats
      DO SyncWindow
      BrowsePava1 
      LocalRequest = OriginalRequest
      DO RefreshWindow
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
    OF ?Datuapmai�aUzb�v�tDunKiek��j�sp�rvieto�anasPZes
      DO SyncWindow
        IntMaker
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
    OF ?7Datuapmai�aCUzb�v�tDunKIPPZesp�cKritatlunPrior
      DO SyncWindow
        IntMaker2
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
    OF ?Datuapmai�aNolas�tinetaapmai�asfailu
      DO SyncWindow
        R_TXTAB(3)
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
      
      !BRW1::LocateMode = LocateOnEdit
      !DO BRW1::LocateRecord
      !SELECT(?Browse:1)
      !POST(Event:NewSelection)
    OF ?Datuapmai�aUzb�v�tDKP
      DO SyncWindow
      Globalrequest=Selectrecord
      Browsepar_k
      IF GLOBALRESPONSE=REQUESTCOMPLETED
        PAR_NR=PAR:U_NR
        BROWSENolPas
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
      .
    OF ?7Datuapmai�aENolas�tTAMRO
      DO SyncWindow
        R_TXTAB(1)
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
      
    OF ?7Datuapmai�aFNolas�tVP
      DO SyncWindow
        R_TXTAB(2)
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
      
    OF ?7Datuapmai�aHUzb�v�tservisaapmai�astxt
      DO SyncWindow
         RW_SER_TXT(1)
    OF ?7DatuapmainaINolVEDLEGG
      DO SyncWindow
        R_TXTAB(4) !AGB P/Z
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
      
    OF ?7DatuapmainaJNolVW_Cenastxt
      DO SyncWindow
        R_TXTAB(5) !VW
      !  LocalRequest = OriginalRequest
      !  BRW1::LocateMode = LocateOnEdit
      !  DO BRW1::LocateRecord
      !  DO BRW1::InitializeBrowse
      !  DO BRW1::PostNewSelection
      !  DO BRW1::RefreshPage
      
    OF ?7Datuapmai�aKNolas�tIMPEXPInvoicetxt
      DO SyncWindow
        R_TXTAB(6) !�le-Sildas invoiss
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
    OF ?7Datuapmai�a7LNolas�tIMPEXPSubaru
      DO SyncWindow
        R_TXTAB(7) !Subaru cenas
    OF ?7Datuapmai�aMNolas�tSkodasNomxml
        R_Skoda_xml
      DO SyncWindow
    OF ?7Datuapmai�aO
        R_NOM_XLS
      DO SyncWindow
    OF ?7Datuapmai�aPTelemaeksports
      DO SyncWindow
      W_Telema 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?7Datuapmai�aQTelemaimports
      DO SyncWindow
      R_TELEMA 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    END
    CASE FIELD()
    OF ?Browse:1
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           EXECUTE PAV:BAITS1+1
              PAV:BAITS1=1
              BEGIN
                 IF CL_NR=1102 OR| !ADREM
                    CL_NR=1464     !AUTO �LE
                    IF ~(ATLAUTS[1]='1') THEN CYCLE. !~SUPERACC
                 .
                 PAV:BAITS1=0
              .
           .
           IF RIUPDATE:PAVAD()
              KLUDA(24,'PAVAD')
           .
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
      END
    OF ?ButtonCopy
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         COPYREQUEST=1
         DO BRW1::ButtonInsert
      END
    OF ?ButtonX
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           EXECUTE PAV:KEKSIS+1
              PAV:keksis=1
              PAV:KEKSIS=2
              PAV:keksis=3
              PAV:KEKSIS=4
              PAV:KEKSIS=0
           .
           IF RIUPDATE:PAVAD()
              KLUDA(24,'PAVAD')
           .
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
      END
    OF ?ButtonInfo
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        CHECKOPEN(NOLIK,1)
        NOLIK::USED+=1
        CLEAR(NOL:RECORD)
        NOL:U_NR=PAV:U_NR
        SET(NOL:NR_KEY,NOL:NR_KEY)
        FILLPVN(0)
        LOOP
           NEXT(NOLIK)
           IF ~(NOL:U_NR=PAV:U_NR) OR ERROR() THEN BREAK.
           FILLPVN(1)
        .
        OPEN(INFOSCREEN)
        SUMMA_B18 =GETPVN(14)
        SUMMA_B12 =GETPVN(13)
        SUMMA_B9  =GETPVN(16)
        SUMMA_B5  =GETPVN(19)
        SUMMA_B0  =GETPVN(12)
        SUMMA_PVN18 =GETPVN(11)
        SUMMA_PVN12 =GETPVN(10)
        SUMMA_PVN9  =GETPVN(15)
        SUMMA_PVN5  =GETPVN(18)
        SUMMA_PVN0  =0
        SUMMA_18 =SUMMA_B18+SUMMA_PVN18
        SUMMA_12 =SUMMA_B12+SUMMA_PVN12
        SUMMA_9  =SUMMA_B9 +SUMMA_PVN9
        SUMMA_5  =SUMMA_B5 +SUMMA_PVN5
        SUMMA_0  =SUMMA_B0 +SUMMA_PVN0
        SUMMA_PVN =PAV:SUMMA-PAV:SUMMA_B
        DISPLAY
        ACCEPT
          CASE FIELD()
          OF ?BEIGT
             CASE EVENT()
             OF EVENT:ACCEPTED
                BREAK
             .
          .
        .
        CLOSE(INFOSCREEN)
        NOLIK::USED-=1
        IF NOLIK::USED=0
           CLOSE(NOLIK)
        .
        SELECT(?Browse:1)
      END
    OF ?selpz
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        selpz 
        LocalRequest = OriginalRequest
        DO RefreshWindow
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
      END
    OF ?Buttonemail
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAV:PAR_NR AND INSTRING(PAV:D_K,'KPR')
        !STOP(PAV:PAR_NR)
           PAR:U_NR=PAV:PAR_NR
           GET(PAR_K,PAR:NR_KEY)
           IF ~ERROR()
              IF PAR:EMAIL
                 IF OUTLOOK
                    PAR_EMAIL=GETPAR_eMAIL(PAR:U_NR,0,1,0) !Ja nav citu,atgrie� PAR:EMAIL,JA IR IZSAUC BROWSI
                    PAR_NOS_P=INIGEN(PAR:NOS_P,45,8)
                    IF PAV:REK_NR
                       PAV_DOK_SENR=PAV:REK_NR
                    ELSE
                       PAV_DOK_SENR=PAV:DOK_SENR
                    .
                    IF INSTRING('OOK.',UPPER(OUTLOOK),1)
                       RUN(OUTLOOK&' /c ipm.note /m '&CLIP(PAR_EMAIL),1)  !�itam vair�k par 1 parametru iedot nevar...
                       !Creates an item with the specified file as an attachment.
                       !Outlook /a "C:\My Documents\labels.doc"
                    ELSIF INSTRING('IMN.',UPPER(OUTLOOK),1) !Outlook Express
                       RUN(OUTLOOK&' /mailurl:mailto:'&CLIP(PAR_EMAIL)&'?Subject='&CLIP(PAR_NOS_P)&|
                       '&Body=Labdien!'&CHR(0DH)&CHR(0AH)&'Nos�tam Jums r��inu '&CLIP(PAV_DOK_SENR)&CHR(0DH)&CHR(0AH)&|
                       '________________________________________________________________'&|
                       CHR(0DH)&CHR(0AH)&'Dokuments sagatavots un nos�t�ts, izmantojot programmat�ru WinLats',1)
                    ELSIF INSTRING('AIL.',UPPER(OUTLOOK),1) !WINMAIL
                       RUN(OUTLOOK&' /mailurl:mailto:'&CLIP(PAR_EMAIL)&'?Subject='&CLIP(PAR_NOS_P)&|
                       '&Body=Labdien!'&CHR(0DH)&CHR(0AH)&'Nos�tam Jums r��inu '&CLIP(PAV_DOK_SENR)&CHR(0DH)&CHR(0AH)&|
                       '________________________________________________________________'&|
                       CHR(0DH)&CHR(0AH)&'Dokuments sagatavots un nos�t�ts, izmantojot programmat�ru WinLats',1)
                    ELSE
                       KLUDA(0,'Defin�ta neat�auta e-pasta programma '&OUTLOOK)
                    .
                    IF RUNCODE()=-4
                       KLUDA(88,'prog-a '&OUTLOOK)
                    ELSE
                       IF VESTURE::USED=0
                          CHECKOPEN(VESTURE,1)
                       .
                       VESTURE::USED+=1
                       CLEAR(VES:RECORD)
                       VES:DOK_SENR=PAV:DOK_SENR
                       VES:RS=PAV:RS
                       VES:APMDAT=PAV:C_DATUMS
                       VES:DOKDAT=PAV:DOKDAT
                       VES:DATUMS=TODAY()
                       VES:SECIBA=CLOCK()
                       VES:PAR_NR=PAR:U_NR
                       VES:CRM   =0
                       TEKSTS='e R��ins- '&CLIP(SYS:AVOTS)&' '&CLIP(PAV:PAMAT)
        !            STOP(TEKSTS[1:47])
                       FORMAT_TEKSTS(47,'WINDOW',8,'')
                       VES:SATURS  = F_TEKSTS[1]
        !            STOP(VES:SATURS&' '&LEN(F_TEKSTS[1]))
                       VES:SATURS2 = F_TEKSTS[2]
                       VES:SATURS3 = F_TEKSTS[3]
                       VES:SUMMA=PAV:SUMMA
                       VES:ATLAIDE=PAV:SUMMA_A*100/(PAV:SUMMA+PAV:SUMMA_A) !%
                       VES:VAL=PAV:VAL
                       VES:D_K_KONTS=SYS:K_DK_PEC
                       VES:ACC_DATUMS=today()
                       VES:ACC_KODS=ACC_kods
                       ADD(vesture)
                       VESTURE::USED-=1
                       IF VESTURE::USED=0
                          CLOSE(VESTURE)
                       .
                    .
                 ELSE
                    KLUDA(0,'Nav defin�ta Outlook izsauk�ana C:\WINLATS\WinLatsC.ini')
                 .
              ELSE
                 KLUDA(0,CLIP(PAR:NOS_P)&' nav defin�ta e-pasta adrese')
              .
           ELSE
              KLUDA(0,'PARTNERIS NAV ATRASTS')
           .
        .
        SELECT(?Browse:1)
        
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
      sav_par_nr=PAV:par_nr  !TIKAI KONKR�TO TAB_U NEVAR P�R�ERT
    OF ?PAV:DATUMS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAV:DATUMS)
        IF PAV:DATUMS
          CLEAR(PAV:D_K,1)
          CLEAR(PAV:DOK_SENR,1)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?ButtonPartneris
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           CLEAR(PAV:RECORD)
           PAV:PAR_NR=PAR:U_NR
           SAV_par_nr=PAV:par_nr
           SET(PAV:PAR_KEY,PAV:PAR_KEY)
           NEXT(PAVAD)
           BRW1::LocateMode = LocateOnEdit
           DO BRW1::LocateRecord
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
        .
      END
    OF ?PAV:DOK_SENR
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PAV:DOK_SENR)
        IF PAV:DOK_SENR
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowsePAVAD','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('JOB_NR',JOB_NR)
  BIND('ATLAUTS',ATLAUTS)
  BIND('SAV_PAR_NR',SAV_PAR_NR)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,255} = InsertKey
  ?Browse:1{Prop:Alrt,254} = DeleteKey
  ?Browse:1{Prop:Alrt,253} = CtrlEnter
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  PUTINI('BrowsePAVAD','?BROWSE:1 Format',?BROWSE:1{PROP:FORMAT},'WinLats.ini')
  IF WindowOpened
    INISaveWindow('BrowsePAVAD','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:LocatorValue = PAV:DOK_SENR
    CLEAR(PAV:DOK_SENR)
  OF 3
    BRW1::Sort3:LocatorValue = PAV:DATUMS
    CLEAR(PAV:DATUMS)
  END
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------
PERFORM_OPEN   ROUTINE
FOUNDIT        ROUTINE
   SET(PAVAD:DAT_KEY,PAVAD:DAT_KEY)
   FOUND#=0
   LOOP
      NEXT(PAVAD)
      IF ERROR() OR PAV:DATUMS<S_DAT THEN BREAK.
      IF (SEARCHREQUEST#=1 AND PAV:SUMMA=SUMMA AND PAV:VAL=VAL_NOS) OR|
         (SEARCHREQUEST#=2 AND INSTRING(CLIP(SUMMA),PAV:DOK_SENR,1)) OR|
         (SEARCHREQUEST#=3 AND PAV:REK_NR=SUMMA)
         IF ~(PAV:D_K='D' AND ATLAUTS[11]='1') !NAV AIZLIEGTS ATV�RT D_PZ
            GLOBALREQUEST=0
            UPDATEpavad
         .
         FOUND#=1
         BREAK
      .
   .
   IF ~FOUND#
      EXECUTE SEARCHREQUEST#
         KLUDA(34,VAL_NOS&' '&LEFT(SUMMA))
         KLUDA(88,'P/Z ar Nr: '&LEFT(SUMMA))
         KLUDA(88,'P/Z ar R��ina Nr: '&LEFT(SUMMA))
      .
   ELSE
      LocalRequest = OriginalRequest
      BRW1::LocateMode = LocateOnEdit
      DO BRW1::LocateRecord
      DO BRW1::InitializeBrowse
      DO BRW1::PostNewSelection
      DO BRW1::RefreshPage
   .
!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! B�V�JAM P/Z
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    clear(PAV:Record)
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVAD)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END


!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF CHOICE(?CurrentTab) = 2
    BRW1::SortOrder = 1
  ELSIF CHOICE(?CurrentTab) = 3
    BRW1::SortOrder = 2
  ELSE
    BRW1::SortOrder = 3
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    OF 1
      IF BRW1::Sort1:Reset:SAV_PAR_NR <> SAV_PAR_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:SAV_PAR_NR = SAV_PAR_NR
    END
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
  IF SEND(PAVAD,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = PAV:DATUMS
  OF 3
    BRW1::Sort3:HighValue = PAV:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = PAV:DATUMS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 3
    BRW1::Sort3:LowValue = PAV:DATUMS
    SetupRealStops(BRW1::Sort3:LowValue,BRW1::Sort3:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort3:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
  IF SEND(PAVAD,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  PAV:KEKSIS = BRW1::PAV:KEKSIS
  PAV:RS = BRW1::PAV:RS
  PAV:BAITS1 = BRW1::PAV:BAITS1
  PAV:EXP = BRW1::PAV:EXP
  PAV:DATUMS = BRW1::PAV:DATUMS
  PAV:D_K = BRW1::PAV:D_K
  PAV:DOK_SENR = BRW1::PAV:DOK_SENR
  PAV:NOKA = BRW1::PAV:NOKA
  PAV:PAMAT = BRW1::PAV:PAMAT
  PAV:SUMMA = BRW1::PAV:SUMMA
  PAV:val = BRW1::PAV:val
  AVAK = BRW1::AVAK
  PAV:NODALA = BRW1::PAV:NODALA
  PAV:OBJ_NR = BRW1::PAV:OBJ_NR
  PAV:REK_NR = BRW1::PAV:REK_NR
  PAV:U_NR = BRW1::PAV:U_NR
  PAV:C_SUMMA = BRW1::PAV:C_SUMMA
  NOL:DATUMS = BRW1::NOL:DATUMS
  JOB_NR = BRW1::JOB_NR
  ATLAUTS = BRW1::ATLAUTS
  SAV_PAR_NR = BRW1::SAV_PAR_NR
  PAV:PAR_NR = BRW1::PAV:PAR_NR
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!|    If the field is colorized, the colors are computed and applied.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  AVAK=PAV:APM_V&PAV:APM_K
  BRW1::PAV:KEKSIS = PAV:KEKSIS
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:KEKSIS:NormalFG = 8421504
    BRW1::PAV:KEKSIS:NormalBG = -1
    BRW1::PAV:KEKSIS:SelectedFG = -1
    BRW1::PAV:KEKSIS:SelectedBG = -1
  ELSE
    BRW1::PAV:KEKSIS:NormalFG = -1
    BRW1::PAV:KEKSIS:NormalBG = -1
    BRW1::PAV:KEKSIS:SelectedFG = -1
    BRW1::PAV:KEKSIS:SelectedBG = -1
  END
  BRW1::PAV:RS = PAV:RS
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:RS:NormalFG = 8421504
    BRW1::PAV:RS:NormalBG = -1
    BRW1::PAV:RS:SelectedFG = -1
    BRW1::PAV:RS:SelectedBG = -1
  ELSE
    BRW1::PAV:RS:NormalFG = -1
    BRW1::PAV:RS:NormalBG = -1
    BRW1::PAV:RS:SelectedFG = -1
    BRW1::PAV:RS:SelectedBG = -1
  END
  BRW1::PAV:BAITS1 = PAV:BAITS1
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:BAITS1:NormalFG = 8421504
    BRW1::PAV:BAITS1:NormalBG = -1
    BRW1::PAV:BAITS1:SelectedFG = -1
    BRW1::PAV:BAITS1:SelectedBG = -1
  ELSE
    BRW1::PAV:BAITS1:NormalFG = -1
    BRW1::PAV:BAITS1:NormalBG = -1
    BRW1::PAV:BAITS1:SelectedFG = -1
    BRW1::PAV:BAITS1:SelectedBG = -1
  END
  BRW1::PAV:EXP = PAV:EXP
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:EXP:NormalFG = 8421504
    BRW1::PAV:EXP:NormalBG = -1
    BRW1::PAV:EXP:SelectedFG = -1
    BRW1::PAV:EXP:SelectedBG = -1
  ELSE
    BRW1::PAV:EXP:NormalFG = -1
    BRW1::PAV:EXP:NormalBG = -1
    BRW1::PAV:EXP:SelectedFG = -1
    BRW1::PAV:EXP:SelectedBG = -1
  END
  BRW1::PAV:DATUMS = PAV:DATUMS
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:DATUMS:NormalFG = 8421504
    BRW1::PAV:DATUMS:NormalBG = -1
    BRW1::PAV:DATUMS:SelectedFG = -1
    BRW1::PAV:DATUMS:SelectedBG = -1
  ELSE
    BRW1::PAV:DATUMS:NormalFG = -1
    BRW1::PAV:DATUMS:NormalBG = -1
    BRW1::PAV:DATUMS:SelectedFG = -1
    BRW1::PAV:DATUMS:SelectedBG = -1
  END
  BRW1::PAV:D_K = PAV:D_K
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:D_K:NormalFG = 8421504
    BRW1::PAV:D_K:NormalBG = -1
    BRW1::PAV:D_K:SelectedFG = -1
    BRW1::PAV:D_K:SelectedBG = -1
  ELSE
    BRW1::PAV:D_K:NormalFG = -1
    BRW1::PAV:D_K:NormalBG = -1
    BRW1::PAV:D_K:SelectedFG = -1
    BRW1::PAV:D_K:SelectedBG = -1
  END
  BRW1::PAV:DOK_SENR = PAV:DOK_SENR
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:DOK_SENR:NormalFG = 8421504
    BRW1::PAV:DOK_SENR:NormalBG = -1
    BRW1::PAV:DOK_SENR:SelectedFG = -1
    BRW1::PAV:DOK_SENR:SelectedBG = -1
  ELSE
    BRW1::PAV:DOK_SENR:NormalFG = -1
    BRW1::PAV:DOK_SENR:NormalBG = -1
    BRW1::PAV:DOK_SENR:SelectedFG = -1
    BRW1::PAV:DOK_SENR:SelectedBG = -1
  END
  BRW1::PAV:NOKA = PAV:NOKA
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:NOKA:NormalFG = 8421504
    BRW1::PAV:NOKA:NormalBG = -1
    BRW1::PAV:NOKA:SelectedFG = -1
    BRW1::PAV:NOKA:SelectedBG = -1
  ELSE
    BRW1::PAV:NOKA:NormalFG = -1
    BRW1::PAV:NOKA:NormalBG = -1
    BRW1::PAV:NOKA:SelectedFG = -1
    BRW1::PAV:NOKA:SelectedBG = -1
  END
  BRW1::PAV:PAMAT = PAV:PAMAT
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:PAMAT:NormalFG = 8421504
    BRW1::PAV:PAMAT:NormalBG = -1
    BRW1::PAV:PAMAT:SelectedFG = -1
    BRW1::PAV:PAMAT:SelectedBG = -1
  ELSE
    BRW1::PAV:PAMAT:NormalFG = -1
    BRW1::PAV:PAMAT:NormalBG = -1
    BRW1::PAV:PAMAT:SelectedFG = -1
    BRW1::PAV:PAMAT:SelectedBG = -1
  END
  BRW1::PAV:SUMMA = PAV:SUMMA
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:SUMMA:NormalFG = 8421504
    BRW1::PAV:SUMMA:NormalBG = -1
    BRW1::PAV:SUMMA:SelectedFG = -1
    BRW1::PAV:SUMMA:SelectedBG = -1
  ELSE
    BRW1::PAV:SUMMA:NormalFG = -1
    BRW1::PAV:SUMMA:NormalBG = -1
    BRW1::PAV:SUMMA:SelectedFG = -1
    BRW1::PAV:SUMMA:SelectedBG = -1
  END
  BRW1::PAV:val = PAV:val
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:val:NormalFG = 8421504
    BRW1::PAV:val:NormalBG = -1
    BRW1::PAV:val:SelectedFG = -1
    BRW1::PAV:val:SelectedBG = -1
  ELSE
    BRW1::PAV:val:NormalFG = -1
    BRW1::PAV:val:NormalBG = -1
    BRW1::PAV:val:SelectedFG = -1
    BRW1::PAV:val:SelectedBG = -1
  END
  BRW1::AVAK = AVAK
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::AVAK:NormalFG = 8421504
    BRW1::AVAK:NormalBG = -1
    BRW1::AVAK:SelectedFG = -1
    BRW1::AVAK:SelectedBG = -1
  ELSE
    BRW1::AVAK:NormalFG = -1
    BRW1::AVAK:NormalBG = -1
    BRW1::AVAK:SelectedFG = -1
    BRW1::AVAK:SelectedBG = -1
  END
  BRW1::PAV:NODALA = PAV:NODALA
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:NODALA:NormalFG = 8421504
    BRW1::PAV:NODALA:NormalBG = -1
    BRW1::PAV:NODALA:SelectedFG = -1
    BRW1::PAV:NODALA:SelectedBG = -1
  ELSE
    BRW1::PAV:NODALA:NormalFG = -1
    BRW1::PAV:NODALA:NormalBG = -1
    BRW1::PAV:NODALA:SelectedFG = -1
    BRW1::PAV:NODALA:SelectedBG = -1
  END
  BRW1::PAV:OBJ_NR = PAV:OBJ_NR
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:OBJ_NR:NormalFG = 8421504
    BRW1::PAV:OBJ_NR:NormalBG = -1
    BRW1::PAV:OBJ_NR:SelectedFG = -1
    BRW1::PAV:OBJ_NR:SelectedBG = -1
  ELSE
    BRW1::PAV:OBJ_NR:NormalFG = -1
    BRW1::PAV:OBJ_NR:NormalBG = -1
    BRW1::PAV:OBJ_NR:SelectedFG = -1
    BRW1::PAV:OBJ_NR:SelectedBG = -1
  END
  BRW1::PAV:REK_NR = PAV:REK_NR
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:REK_NR:NormalFG = 8421504
    BRW1::PAV:REK_NR:NormalBG = -1
    BRW1::PAV:REK_NR:SelectedFG = -1
    BRW1::PAV:REK_NR:SelectedBG = -1
  ELSE
    BRW1::PAV:REK_NR:NormalFG = -1
    BRW1::PAV:REK_NR:NormalBG = -1
    BRW1::PAV:REK_NR:SelectedFG = -1
    BRW1::PAV:REK_NR:SelectedBG = -1
  END
  BRW1::PAV:U_NR = PAV:U_NR
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:U_NR:NormalFG = 8421504
    BRW1::PAV:U_NR:NormalBG = -1
    BRW1::PAV:U_NR:SelectedFG = -1
    BRW1::PAV:U_NR:SelectedBG = -1
  ELSE
    BRW1::PAV:U_NR:NormalFG = -1
    BRW1::PAV:U_NR:NormalBG = -1
    BRW1::PAV:U_NR:SelectedFG = -1
    BRW1::PAV:U_NR:SelectedBG = -1
  END
  BRW1::PAV:C_SUMMA = PAV:C_SUMMA
  IF (PAV:DATUMS<SYS:GIL_SHOW OR PAV:BAITS1=1)
    BRW1::PAV:C_SUMMA:NormalFG = 8421504
    BRW1::PAV:C_SUMMA:NormalBG = -1
    BRW1::PAV:C_SUMMA:SelectedFG = -1
    BRW1::PAV:C_SUMMA:SelectedBG = -1
  ELSE
    BRW1::PAV:C_SUMMA:NormalFG = -1
    BRW1::PAV:C_SUMMA:NormalBG = -1
    BRW1::PAV:C_SUMMA:SelectedFG = -1
    BRW1::PAV:C_SUMMA:SelectedBG = -1
  END
  BRW1::NOL:DATUMS = NOL:DATUMS
  BRW1::JOB_NR = JOB_NR
  BRW1::ATLAUTS = ATLAUTS
  BRW1::SAV_PAR_NR = SAV_PAR_NR
  BRW1::PAV:PAR_NR = PAV:PAR_NR
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:1)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
    ELSE
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert:3)
      POST(Event:Accepted,?Change:3)
      POST(Event:Accepted,?Delete:3)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => PAV:DATUMS
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 2
      OF 3
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort3:KeyDistribution[BRW1::CurrentScroll] => PAV:DATUMS
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
  CASE BRW1::SortOrder
  OF 2
    BRW1::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF BRW1::ItemsToFill
        IF BRW1::CurrentEvent = Event:ScrollUp
          BRW1::CurrentScroll = 0
        ELSE
          BRW1::CurrentScroll = 100
        END
      END
    ELSE
      BRW1::CurrentScroll = 0
    END
  END
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change:3)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change:3)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
      OF 2
        IF CHR(KEYCHAR())
          SELECT(?PAV:DOK_SENR)
          PRESS(CHR(KEYCHAR()))
        END
      OF 3
        IF CHR(KEYCHAR())
          SELECT(?PAV:DATUMS)
          PRESS(CHR(KEYCHAR()))
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 1
      PAV:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 3
      PAV:DATUMS = BRW1::Sort3:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::ItemsToFill > 1
    IF SEND(PAVAD,'QUICKSCAN=on').
    BRW1::QuickScan = True
  END
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'PAVAD')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  IF BRW1::QuickScan
    IF SEND(PAVAD,'QUICKSCAN=off').
    BRW1::QuickScan = False
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAV:PAR_KEY)
      RESET(PAV:PAR_KEY,BRW1::HighlightedPosition)
    ELSE
      PAV:PAR_NR = SAV_PAR_NR
      SET(PAV:PAR_KEY,PAV:PAR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'PAV:PAR_NR = SAV_PAR_NR AND (~(PAV:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAV:SENR_KEY)
      RESET(PAV:SENR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAV:SENR_KEY,PAV:SENR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~(PAV:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAV:DAT_KEY)
      RESET(PAV:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PAV:DAT_KEY,PAV:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~(PAV:RS=''1''  AND  ATLAUTS[18]=''1''))'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    CASE BRW1::SortOrder
    OF 2; ?PAV:DOK_SENR{Prop:Disable} = 0
    OF 3; ?PAV:DATUMS{Prop:Disable} = 0
    END
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Change:3{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(PAV:Record)
    CASE BRW1::SortOrder
    OF 2; ?PAV:DOK_SENR{Prop:Disable} = 1
    OF 3; ?PAV:DATUMS{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    IF RECORDS(PAVAD)=0
       CLEAR(PAV:Record,0)
       PAV:U_NR   =1
       PAV:DATUMS =DATE(1,1,gads)
       PAV:DOKDAT =DATE(1,1,gads)
       PAV:D_K ='D'
       !01/03/2015 PAV:VAL='Ls'
       !01/03/2015 <
       IF GL:DB_GADS > 2013   
          PAV:VAL='EUR'
       ELSE                   
          PAV:VAL='Ls'
       .
       !01/03/2015 >
       PAV:PAMAT='Atlikums uz '&format(pav:datums,@D06.)
       add(pavad)
       if error() then stop('ADD Pavad, u_nr='&pav:u_nr&' '&error()).
       DO BRW1::REFRESHPAGE
    ELSE
    !   KLUDA(110,FORMAT(SAK_GIL,@D6)&'-'&FORMAT(BEI_GIL,@D6))
    .
    ?Change:3{Prop:Disable} = 1
    ?Delete:3{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    PAV:PAR_NR = SAV_PAR_NR
    SET(PAV:PAR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'PAV:PAR_NR = SAV_PAR_NR AND (~(PAV:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 2
    SET(PAV:SENR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~(PAV:RS=''1''  AND  ATLAUTS[18]=''1''))'
  OF 3
    SET(PAV:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~(PAV:RS=''1''  AND  ATLAUTS[18]=''1''))'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW1::SortOrder
  OF 1
    SAV_PAR_NR = BRW1::Sort1:Reset:SAV_PAR_NR
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change:3
  BrowseButtons.DeleteButton=?Delete:3
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  IF BrowseButtons.InsertButton THEN
    TBarBrwInsert{PROP:DISABLE}=BrowseButtons.InsertButton{PROP:DISABLE}
  END
  IF BrowseButtons.ChangeButton THEN
    TBarBrwChange{PROP:DISABLE}=BrowseButtons.ChangeButton{PROP:DISABLE}
  END
  IF BrowseButtons.DeleteButton THEN
    TBarBrwDelete{PROP:DISABLE}=BrowseButtons.DeleteButton{PROP:DISABLE}
  END
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

UpdateDispatch ROUTINE
  DISABLE(TBarBrwDelete)
  DISABLE(TBarBrwChange)
  IF BrowseButtons.DeleteButton AND BrowseButtons.DeleteButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwDelete)
  END
  IF BrowseButtons.ChangeButton AND BrowseButtons.ChangeButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwChange)
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW1::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(PAVAD,0)
  CLEAR(PAV:Record,0)
  CASE BRW1::SortOrder
  OF 1
    PAV:PAR_NR = BRW1::Sort1:Reset:SAV_PAR_NR
  END
  LocalRequest = InsertRecord
  IF COPYREQUEST=1
       DO SYNCWINDOW
       PAV::U_NR=PAV:U_NR
       PAV:U_NR=0
   .
  
  DO BRW1::CallUpdate
  COPYREQUEST=0
  IF GlobalResponse = RequestCompleted
    WriteZurnals(1,1,'PAVAD (D/K-U_NR-DOK_NR-SUMMA-PAR)'&CHR(9)&PAV:U_NR&CHR(9)&PAV:D_K&CHR(9)&CLIP(PAV:DOK_SENR)&CHR(9)&|
    CLIP(PAV:SUMMA)&CHR(9)&CLIP(PAV:NOKA))
  .
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the change is successful (GlobalRequest = RequestCompleted) then the newly changed
!| record is displayed in the BrowseBox.
!|
!| If the change is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = ChangeRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    WriteZurnals(1,2,'PAVAD (D/K-U_NR-DOK_NR-SUMMA-PAR)'&CHR(9)&PAV:U_NR&CHR(9)&PAV:D_K&CHR(9)&CLIP(PAV:DOK_SENR)&CHR(9)&|
    CLIP(PAV:SUMMA)&CHR(9)&CLIP(PAV:NOKA))
    IF BRW1::PAV:DATUMS=PAV:DATUMS AND BRW1::PAV:D_K=PAV:D_K AND BRW1::PAV:DOK_SENR=PAV:DOK_SENR !LAI NEP�RB�V� TABULU
       GlobalResponse = RequestCancelled
    .
  .
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the delete is successful (GlobalRequest = RequestCompleted) then the deleted record is
!| removed from the queue.
!|
!| Next, the BrowseBox is refreshed, redisplaying the current page.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = DeleteRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
     WriteZurnals(1,3,'PAVAD (D/K-U_NR-DOK_NR-SUMMA-PAR)'&CHR(9)&PAV:U_NR&CHR(9)&PAV:D_K&CHR(9)&CLIP(PAV:DOK_SENR)&CHR(9)&|
     CLIP(PAV:SUMMA)&CHR(9)&CLIP(PAV:NOKA))
     IF CL_NR=1102 OR| !ADREM
     CL_NR=1464 OR| !AUTO �LE !   CL_NR=1211 AUTOSTATUSS
     CL_NR=1454 OR|       !SD AUTOCENTRS
     ACC_KODS_N=0   !ES
        CHECKOPEN(AU_BILDE,1)
        CLEAR(AUB:RECORD)
        AUB:DATUMS=PAV:DATUMS
        SET(AUB:DAT_KEY,AUB:DAT_KEY)
        LOOP
           NEXT(AU_BILDE)
           IF ERROR() OR AUB:DATUMS>PAV:DATUMS THEN BREAK.
           LOOP I#=1 TO 20
!           STOP(FORMAT(AUB:DATUMS,@D06.)&FORMAT(PAV:DATUMS,@D06.)&AUB:PAV_NR[I#]&'='&PAV:U_NR)
              IF AUB:PAV_NR[I#]=PAV:U_NR
                 AUB:PAV_NR[I#]=0
                 AUB:STATUSS[I#]=3 !NEATBRAUCA
                 IF RIUPDATE:AU_BILDE()
                    KLUDA(24,'AU_BILDE')
                 .
              .
           .
        .
        CLOSE(AU_BILDE)
     .
  .
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:1)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdatePAVAD) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  IF (PAV:DATUMS < SYS:GIL_SHOW OR PAV:BAITS1=1) and (LOCALREQUEST=3 OR LOCALREQUEST=2) ! SL�GTS APGABALS VAI RAKSTS
     LOCALREQUEST=0
  .
  IF PAV:D_K='D' AND ATLAUTS[11]='1' !aizliegts apskat�t D P/Z
     KLUDA(45,'Aizliegts atv�rt D P/Z')
     EXIT
  .
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[JOB_NR+39])
     BEGIN
        GlobalResponse = RequestCancelled
        EXIT
     .
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  IF PAV:U_NR=1 AND LOCALREQUEST=3    !SALDO DZ��ANA
     KLUDA(98,'',9)            !9-ATLIKT/OK
     IF KLU_DARBIBA THEN EXIT. !OTR�DI
     CHECKOPEN(NOLIK,1)
     CLEAR(NOL:RECORD)
     NOL:U_NR=1
     SET(NOL:NR_KEY,NOL:NR_KEY)
     LOOP
        NEXT(NOLIK)
        IF ERROR() OR ~(NOL:U_NR=1) THEN BREAK.
        DELETE(NOLIK)
        IF ERROR() THEN STOP('Dz��ot Nolik '&ERROR()).
     .
     PAV:SUMMA=0
     PAV:SUMMA_A=0
     PAV:SUMMA_B=0
     I#=RIUPDATE:PAVAD()
     EXIT
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdatePAVAD
    LocalResponse = GlobalResponse
    CASE VCRRequest
    OF VCRNone
      BREAK
    OF VCRInsert
      IF LocalRequest=ChangeRecord THEN
        LocalRequest=InsertRecord
      END
    OROF VCRForward
      IF LocalRequest=InsertRecord THEN
        GET(PAVAD,0)
        CLEAR(PAV:Record,0)
      ELSE
        DO BRW1::PostVCREdit1
        BRW1::CurrentEvent=Event:ScrollDown
        DO BRW1::ScrollOne
        DO BRW1::PostVCREdit2
      END
    OF VCRBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollUp
      DO BRW1::ScrollOne
      DO BRW1::PostVCREdit2
    OF VCRPageForward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageDown
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRPageBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageUp
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRFirst
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollTop
      DO BRW1::ScrollEnd
      DO BRW1::PostVCREdit2
    OF VCRLast
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollBottom
      DO BRW1::ScrollEND
      DO BRW1::PostVCREdit2
    END
  END
  DO BRW1::Reset

BRW1::PostVCREdit1 ROUTINE
  DO BRW1::Reset
  BRW1::LocateMode=LocateOnEdit
  DO BRW1::LocateRecord
  DO RefreshWindow

BRW1::PostVCREdit2 ROUTINE
  ?Browse:1{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


UpdateInvent PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
Update::Reloop  BYTE
Update::Error   BYTE
History::INV:Record LIKE(INV:Record),STATIC
SAV::INV:Record      LIKE(INV:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the INVENT File'),AT(,,369,60),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateInvent'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(2,2,358,34),USE(?CurrentTab)
                         TAB('�trai labo�anai lietojiet VCR > pogu'),USE(?Tab:1)
                           STRING(@S17),AT(10,20),USE(INV:KATALOGA_NR)
                           STRING(@S50),AT(82,20),USE(INV:NOSAUKUMS)
                           STRING(@N-_11.3),AT(246,20),USE(INV:ATLIKUMS),RIGHT
                           PROMPT('&Faktiskais atlikums'),AT(294,4,66,10),USE(?INV:ATLIKUMS_F:Prompt)
                           PROMPT('&Atlikums'),AT(258,4),USE(?INV:ATLIKUMS:Prompt)
                           ENTRY(@N-_11.3),AT(303,20,49,10),USE(INV:ATLIKUMS_F),DECIMAL(16)
                         END
                       END
                       STRING(@S8),AT(11,41),USE(INV:ACC_KODS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       BUTTON('&OK'),AT(263,39,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(311,39,45,14),USE(?Cancel)
                       STRING(@D06.),AT(51,42),USE(INV:ACC_DATUMS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
   IF ~INV:X
     INV:ATLIKUMS_F=INV:ATLIKUMS
     INV:X=1
     INV:ACC_KODS=ACC_KODS
     INV:ACC_DATUMS=TODAY()
   .
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks main�ts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  CASE LocalRequest
  OF ChangeRecord OROF DeleteRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (' & CLIP(INV:NOMENKLAT) & ')'
  OF InsertRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (New)'
  END
  ENABLE(TBarBrwHistory)
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = 734 THEN
        DO HistoryField
      END
    OF EVENT:CloseWindow
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
    OF EVENT:CloseDown
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?INV:KATALOGA_NR)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::INV:Record = INV:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(INVENT)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(INV:NOM_KEY)
              IF StandardWarning(Warn:DuplicateKey,'INV:NOM_KEY')
                SELECT(?INV:KATALOGA_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(INV:KOD_KEY)
              IF StandardWarning(Warn:DuplicateKey,'INV:KOD_KEY')
                SELECT(?INV:KATALOGA_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?INV:KATALOGA_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::INV:Record <> INV:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:INVENT(1)
            ELSE
              Update::Error = 0
            END
            SETCURSOR()
            IF Update::Error THEN
              IF Update::Error = 1 THEN
                CASE StandardWarning(Warn:UpdateError)
                OF Button:Yes
                  CYCLE
                OF Button:No
                  POST(Event:CloseWindow)
                  BREAK
                END
              END
              DISPLAY
              SELECT(?INV:KATALOGA_NR)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
        END
      END
      IF ToolbarMode = FormMode THEN
        CASE ACCEPTED()
        OF TBarBrwBottom TO TBarBrwUp
        OROF TBarBrwInsert
          VCRRequest=ACCEPTED()
          POST(EVENT:Completed)
        OF TBarBrwHelp
          PRESSKEY(F1Key)
        END
      END
    END
    CASE FIELD()
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
          !Code to assign button control based upon current tab selection
          CASE CHOICE(?CurrentTab)
          OF 1
            DO FORM::AssignButtons
          OF 2
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF INVENT::Used = 0
    CheckOpen(INVENT,1)
  END
  INVENT::Used += 1
  BIND(INV:RECORD)
  FilesOpened = True
  RISnap:INVENT
  SAV::INV:Record = INV:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:INVENT()
          SETCURSOR()
          CASE StandardWarning(Warn:DeleteError)
          OF Button:Yes
            CYCLE
          OF Button:No OROF Button:Cancel
            BREAK
          END
        ELSE
          SETCURSOR()
          LocalResponse = RequestCompleted
        END
        BREAK
      END
    END
    DO ProcedureReturn
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdateInvent','winlats.INI')
  WinResize.Resize
  ?INV:KATALOGA_NR{PROP:Alrt,255} = 734
  ?INV:NOSAUKUMS{PROP:Alrt,255} = 734
  ?INV:ATLIKUMS{PROP:Alrt,255} = 734
  ?INV:ATLIKUMS_F{PROP:Alrt,255} = 734
  ?INV:ACC_KODS{PROP:Alrt,255} = 734
  ?INV:ACC_DATUMS{PROP:Alrt,255} = 734
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  IF FilesOpened
     INV:ACC_KODS=ACC_KODS
     INV:ACC_DATUMS=TODAY()
    INVENT::Used -= 1
    IF INVENT::Used = 0 THEN CLOSE(INVENT).
  END
  IF WindowOpened
    INISaveWindow('UpdateInvent','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
!---------------------------------------------------------------------------
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?INV:KATALOGA_NR
      INV:KATALOGA_NR = History::INV:Record.KATALOGA_NR
    OF ?INV:NOSAUKUMS
      INV:NOSAUKUMS = History::INV:Record.NOSAUKUMS
    OF ?INV:ATLIKUMS
      INV:ATLIKUMS = History::INV:Record.ATLIKUMS
    OF ?INV:ATLIKUMS_F
      INV:ATLIKUMS_F = History::INV:Record.ATLIKUMS_F
    OF ?INV:ACC_KODS
      INV:ACC_KODS = History::INV:Record.ACC_KODS
    OF ?INV:ACC_DATUMS
      INV:ACC_DATUMS = History::INV:Record.ACC_DATUMS
  END
  DISPLAY()
!---------------------------------------------------------------
PrimeFields ROUTINE
!|
!| This routine is called whenever the procedure is called to insert a record.
!|
!| This procedure performs three functions. These functions are..
!|
!|   1. Prime the new record with initial values specified in the dictionary
!|      and under the Field priming on Insert button.
!|   2. Generates any Auto-Increment values needed.
!|   3. Saves a copy of the new record, as primed, for use in batch-adds.
!|
!| If an auto-increment value is generated, this routine will add the new record
!| at this point, keeping its place in the file.
!|
  INV:Record = SAV::INV:Record
  SAV::INV:Record = INV:Record
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
  END
FORM::AssignButtons ROUTINE
  ToolBarMode=FormMode
  DISABLE(TBarBrwFirst,TBarBrwLast)
  ENABLE(TBarBrwHistory)
  CASE OriginalRequest
  OF InsertRecord
    ENABLE(TBarBrwDown)
    ENABLE(TBarBrwInsert)
    TBarBrwDown{PROP:ToolTip}='Save record and add another'
    TBarBrwInsert{PROP:ToolTip}=TBarBrwDown{PROP:ToolTip}
  OF ChangeRecord
    ENABLE(TBarBrwBottom,TBarBrwUp)
    ENABLE(TBarBrwInsert)
    TBarBrwBottom{PROP:ToolTip}='Save changes and go to last record'
    TBarBrwTop{PROP:ToolTip}='Save changes and go to first record'
    TBarBrwPageDown{PROP:ToolTip}='Save changes and page down to record'
    TBarBrwPageUp{PROP:ToolTip}='Save changes and page up to record'
    TBarBrwDown{PROP:ToolTip}='Save changes and go to next record'
    TBarBrwUP{PROP:ToolTip}='Save changes and go to previous record'
    TBarBrwInsert{PROP:ToolTip}='Save this record and add a new one'
  END
  DISPLAY(TBarBrwFirst,TBarBrwLast)

BrowseInvent PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
ATLIKUMS_F           DECIMAL(11,3)
OPC                  BYTE
A_FA                 DECIMAL(11,3)
AIZVERTS             BYTE
EXTENSION             STRING(17)
InfoString            STRING(40)
InfoString1           STRING(45)
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
DELTA                 DECIMAL(12,2)
NOL                   STRING(1)

I_FILE           FILE,PRE(I),DRIVER('ASCII'),NAME('INV0.TXT'),CREATE
RECORD             RECORD
LINE                 STRING(80)
                 . .

Invwind WINDOW('Inventariz�cijas dokumenta b�v��ana'),AT(,,185,98),GRAY
       STRING(@s40),AT(16,27,149,10),USE(Infostring),CENTER
       STRING(@s45),AT(14,40,155,10),USE(Infostring1),CENTER
       BUTTON('&Ignor�t neanaliz�t�s ar 0-es atlikumu'),AT(3,69,127,14),USE(?ButtonIGN)
       IMAGE('CHECK3.ICO'),AT(131,69,13,14),USE(?ImageIGN),HIDE
       BUTTON('&OK'),AT(147,69,35,14),USE(?OkButton:1),DEFAULT
     END

CenaWindow WINDOW('Caption'),AT(,,138,78),GRAY
       STRING(@N7),AT(55,16),USE(NPK#)
       STRING('Main�t cenu uz (1-6) :'),AT(23,33),USE(?String1)
       ENTRY(@n1),AT(96,32,16,12),USE(nokl_cp)
       BUTTON('&OK'),AT(56,59,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(96,59,36,14),USE(?CancelButton)
     END

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
PercentProgress      BYTE
Progress:Thermometer BYTE

ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
     END

BRW1::View:Browse    VIEW(INVENT)
                       PROJECT(INV:NOMENKLAT)
                       PROJECT(INV:KATALOGA_NR)
                       PROJECT(INV:CENA)
                       PROJECT(INV:ATLIKUMS)
                       PROJECT(INV:ATLIKUMS_F)
                       PROJECT(INV:X)
                       PROJECT(INV:NOSAUKUMS)
                       PROJECT(INV:KODS)
                       PROJECT(INV:NOS_A)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::INV:NOMENKLAT    LIKE(INV:NOMENKLAT)        ! Queue Display field
BRW1::INV:NOMENKLAT:NormalFG LONG                 ! Normal Foreground
BRW1::INV:NOMENKLAT:NormalBG LONG                 ! Normal Background
BRW1::INV:NOMENKLAT:SelectedFG LONG               ! Selected Foreground
BRW1::INV:NOMENKLAT:SelectedBG LONG               ! Selected Background
BRW1::INV:KATALOGA_NR  LIKE(INV:KATALOGA_NR)      ! Queue Display field
BRW1::INV:KATALOGA_NR:NormalFG LONG               ! Normal Foreground
BRW1::INV:KATALOGA_NR:NormalBG LONG               ! Normal Background
BRW1::INV:KATALOGA_NR:SelectedFG LONG             ! Selected Foreground
BRW1::INV:KATALOGA_NR:SelectedBG LONG             ! Selected Background
BRW1::INV:CENA         LIKE(INV:CENA)             ! Queue Display field
BRW1::INV:CENA:NormalFG LONG                      ! Normal Foreground
BRW1::INV:CENA:NormalBG LONG                      ! Normal Background
BRW1::INV:CENA:SelectedFG LONG                    ! Selected Foreground
BRW1::INV:CENA:SelectedBG LONG                    ! Selected Background
BRW1::INV:ATLIKUMS     LIKE(INV:ATLIKUMS)         ! Queue Display field
BRW1::INV:ATLIKUMS:NormalFG LONG                  ! Normal Foreground
BRW1::INV:ATLIKUMS:NormalBG LONG                  ! Normal Background
BRW1::INV:ATLIKUMS:SelectedFG LONG                ! Selected Foreground
BRW1::INV:ATLIKUMS:SelectedBG LONG                ! Selected Background
BRW1::INV:ATLIKUMS_F   LIKE(INV:ATLIKUMS_F)       ! Queue Display field
BRW1::INV:ATLIKUMS_F:NormalFG LONG                ! Normal Foreground
BRW1::INV:ATLIKUMS_F:NormalBG LONG                ! Normal Background
BRW1::INV:ATLIKUMS_F:SelectedFG LONG              ! Selected Foreground
BRW1::INV:ATLIKUMS_F:SelectedBG LONG              ! Selected Background
BRW1::A_FA             LIKE(A_FA)                 ! Queue Display field
BRW1::A_FA:NormalFG LONG                          ! Normal Foreground
BRW1::A_FA:NormalBG LONG                          ! Normal Background
BRW1::A_FA:SelectedFG LONG                        ! Selected Foreground
BRW1::A_FA:SelectedBG LONG                        ! Selected Background
BRW1::INV:X            LIKE(INV:X)                ! Queue Display field
BRW1::INV:X:NormalFG LONG                         ! Normal Foreground
BRW1::INV:X:NormalBG LONG                         ! Normal Background
BRW1::INV:X:SelectedFG LONG                       ! Selected Foreground
BRW1::INV:X:SelectedBG LONG                       ! Selected Background
BRW1::INV:NOSAUKUMS    LIKE(INV:NOSAUKUMS)        ! Queue Display field
BRW1::INV:NOSAUKUMS:NormalFG LONG                 ! Normal Foreground
BRW1::INV:NOSAUKUMS:NormalBG LONG                 ! Normal Background
BRW1::INV:NOSAUKUMS:SelectedFG LONG               ! Selected Foreground
BRW1::INV:NOSAUKUMS:SelectedBG LONG               ! Selected Background
BRW1::INV:KODS         LIKE(INV:KODS)             ! Queue Display field
BRW1::INV:KODS:NormalFG LONG                      ! Normal Foreground
BRW1::INV:KODS:NormalBG LONG                      ! Normal Background
BRW1::INV:KODS:SelectedFG LONG                    ! Selected Foreground
BRW1::INV:KODS:SelectedBG LONG                    ! Selected Background
BRW1::INV:NOS_A        LIKE(INV:NOS_A)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(INV:KODS),DIM(100)
BRW1::Sort1:LowValue LIKE(INV:KODS)               ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(INV:KODS)              ! Queue position of scroll thumb
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(INV:KATALOGA_NR),DIM(100)
BRW1::Sort2:LowValue LIKE(INV:KATALOGA_NR)        ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(INV:KATALOGA_NR)       ! Queue position of scroll thumb
BRW1::Sort3:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort3:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort3:KeyDistribution LIKE(INV:NOS_A),DIM(100)
BRW1::Sort3:LowValue LIKE(INV:NOS_A)              ! Queue position of scroll thumb
BRW1::Sort3:HighValue LIKE(INV:NOS_A)             ! Queue position of scroll thumb
BRW1::Sort4:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort4:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort4:KeyDistribution LIKE(INV:NOMENKLAT),DIM(100)
BRW1::Sort4:LowValue LIKE(INV:NOMENKLAT)          ! Queue position of scroll thumb
BRW1::Sort4:HighValue LIKE(INV:NOMENKLAT)         ! Queue position of scroll thumb
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
WinResize            WindowResizeType
QuickWindow          WINDOW('Inventariz�cija'),AT(,,455,327),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseInvent'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&6-Speci�l�s funkcijas'),USE(?Speci�l�sfunkcijas)
                           ITEM('&1-Izn�cin�t Fakt.atlikumu un piel�dzin�t to Atlikumiem.,kur X=0'),USE(?4Faili6Speci�l�sfunkcijas1Piel�dzin�tFatlikumuAtlp�cfindkurX0)
                           ITEM('&2-Main�t cenu'),USE(?6Speci�l�sfunkcijas2Main�tcenu)
                           ITEM('&3-Apstiprin�t visus neapstiprin�tos'),USE(?6Speci�l�sfunkcijas3Apstiprin�tvisusneapstiprin)
                           ITEM('&4-Atv�rt(aizv�rt) datu bloku'),USE(?AtAizDatubloku),DISABLE
                         END
                       END
                       LIST,AT(8,20,434,243),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('85L|M*~Nomenklat�ra~C(2)@S21@69L|M*~Kataloga Nr~C(2)@S17@43R|M*~Cena~C@N_11.3@44' &|
   'R|M*~Atlikums~C@N-_11.3@41R|M*~Fakt. Atlik.~C@N-_11.3@40R|M*~Atl.-F.Atlik.~C@N-_' &|
   '11.3B@8C|M*~X~@N1B@109L|M*~Nosaukums~C(2)@S50@54R|M*~Kods~C@N_13@'),FROM(Queue:Browse:1)
                       BUTTON('&Uzb�v�t K P/Z saska�� ar Inv. rezult�tu'),AT(1,289,140,14),USE(?ButtonKPPR)
                       BUTTON('&Ievad�t'),AT(312,288,45,14),USE(?Insert),HIDE
                       BUTTON('&Main�t'),AT(357,288,45,14),USE(?Change)
                       BUTTON('&Dz�st'),AT(403,288,45,14),USE(?Delete)
                       SHEET,AT(3,4,446,281),USE(?CurrentTab)
                         TAB('&Nomenklat�ru sec�b�'),USE(?Tab:2)
                           ENTRY(@S21),AT(9,269),USE(INV:NOMENKLAT)
                           STRING('-p�c nomenklat�ras'),AT(109,271),USE(?StringNOMENKLAT)
                         END
                         TAB('&Kodu sec�b�'),USE(?Tab:3)
                           ENTRY(@N_13),AT(97,269),USE(INV:KODS)
                           STRING('- p�c sv�tru koda'),AT(161,271),USE(?StringEAN)
                         END
                         TAB('Kat. n&umuru sec�b�'),USE(?Tab:4)
                           ENTRY(@S17),AT(23,269),USE(INV:KATALOGA_NR)
                           STRING('- p�c kataloga Nr'),AT(110,271),USE(?StringKATNR)
                         END
                         TAB('No&saukumu sec�b�'),USE(?Tab:5)
                           ENTRY(@S6),AT(9,268),USE(INV:NOS_A)
                           STRING('- p�c nosaukuma'),AT(44,269),USE(?StringNOSAUKUMS)
                         END
                       END
                       BUTTON('&Beigt'),AT(405,304,45,14),USE(?Close)
                       BUTTON('&Pieb�v�t SALDO tikai, kur Atlikums << Faktisko'),AT(142,305,159,14),USE(?ButtonSALDO)
                       BUTTON('Inventariz�cijas &Akts'),AT(309,304,95,14),USE(?ButtonAkts)
                       BUTTON('Uzb�v�t K P/Z tikai, kur Atlikums > &Faktisko'),AT(142,289,159,14),USE(?ButtonKPPR:2)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
     TTAKA"=LONGPATH()
     INVNAME=''
     IF LOC_NR < 9
        NOL=LOC_NR
     ELSE
        NOL=CHR(LOC_NR+55)
     .
     EXTENSION='TOPSPEED|I'&NOL&'*.TPS'
     IF ~FILEDIALOG('...TIKAI I(NOL_NR)YYMMDD.TPS FAILI [A=NOL10 utt.]',INVNAME,EXTENSION,2) !2-NEDR�KST MAIN�T FOLDERI
        SETPATH(TTAKA")
        DO PROCEDURERETURN
     .
     SETPATH(TTAKA")
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
     CLEAR(INV:RECORD)
     INV:NOMENKLAT='AIZVERTS'
     GET(INVENT,INV:NOM_KEY)
     IF ~ERROR()
        AIZVERTS=TRUE
        HIDE(?Delete)
        HIDE(?Change)
     .
     IF ATLAUTS[1]='1' !SUPERACC
       ENABLE(?AtAizDatubloku)
     .
  ACCEPT
     QUICKWINDOW{PROP:TEXT}='Inventariz�cijas saraksts.'&CLIP(invname)&' '&CLIP(RECORDS(invent))&' raksti.'&loc_nr&' noliktava'
    ! ?Browse:1{PROPLIST:HEADER,3}=invname[4]&'.Cena'
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      QUICKWINDOW{PROP:TEXT}='Inventariz�cija  '&CLIP(RECORDS(INVENT))&' raksti '&CLIP(LONGpath())
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE ACCEPTED()
    OF ?4Faili6Speci�l�sfunkcijas1Piel�dzin�tFatlikumuAtlp�cfindkurX0
      DO SyncWindow
      OPEN(ProgressWindow)
      RecordsProcessed = 0
      RecordsToProcess = RECORDS(INVENT)
      SET(INV:NOM_KEY)
      LOOP
         NEXT(INVENT)
         RecordsProcessed += 1
         DISPLAY
         IF PercentProgress < 100
            PercentProgress = (RecordsProcessed / RecordsToProcess)*100
            IF PercentProgress > 100
               PercentProgress = 100
            END
            IF PercentProgress <> Progress:Thermometer THEN
               Progress:Thermometer = PercentProgress
               ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
               ?Progress:USERSTRING{Prop:Text} = FORMAT(RecordsProcessed,@N6)
               DISPLAY
            END
         END
         IF ERROR() THEN BREAK.
         IF INV:X THEN CYCLE.
         INV:ATLIKUMS_F=INV:ATLIKUMS
         INV:X=1
         IF RIUPDATE:INVENT()
            KLUDA(24,'INVENT')
         .
      .
      CLOSE(ProgressWindow)
      DO BRW1::InitializeBrowse
      DO BRW1::RefreshPage
      DISPLAY
    OF ?6Speci�l�sfunkcijas2Main�tcenu
      DO SyncWindow
      OPEN(CenaWindow)
      NPK#=0
      ACCEPT
         CASE FIELD()
         OF ?OKBUTTON
            CASE EVENT()
            OF EVENT:ACCEPTED
               HIDE(?OKBUTTON)
               HIDE(?CANCELBUTTON)
               HIDE(?nokl_cp)
               HIDE(?STRING1)
               SET(INV:NOM_KEY)
               LOOP
                  NEXT(INVENT)
                  NPK#+=1
                  DISPLAY
                  IF ERROR() THEN BREAK.
                  INV:CENA=GETNOM_K(INV:NOMENKLAT,0,7)
                  IF RIUPDATE:INVENT()
                     KLUDA(24,'INVENT')
                  .
               .
               BREAK
            .
         OF ?CANCELBUTTON
            BREAK
         .
      .
      CLOSE(CenaWindow)
      DO BRW1::InitializeBrowse
      DO BRW1::RefreshPage
      DISPLAY
    OF ?6Speci�l�sfunkcijas3Apstiprin�tvisusneapstiprin
      DO SyncWindow
      OPEN(ProgressWindow)
      RecordsProcessed = 0
      RecordsToProcess = RECORDS(INVENT)
      SET(INV:NOM_KEY)
      LOOP
         NEXT(INVENT)
         RecordsProcessed += 1
         DISPLAY
         IF PercentProgress < 100
            PercentProgress = (RecordsProcessed / RecordsToProcess)*100
            IF PercentProgress > 100
               PercentProgress = 100
            END
            IF PercentProgress <> Progress:Thermometer THEN
               Progress:Thermometer = PercentProgress
               ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
               ?Progress:USERSTRING{Prop:Text} = FORMAT(RecordsProcessed,@N6)
               DISPLAY
            END
         END
         IF ERROR() THEN BREAK.
         IF INV:X THEN CYCLE.
         INV:X=1
         IF RIUPDATE:INVENT()
            KLUDA(24,'INVENT')
         .
      .
      CLOSE(ProgressWindow)
      DO BRW1::InitializeBrowse
      DO BRW1::RefreshPage
      DISPLAY
    OF ?AtAizDatubloku
      DO SyncWindow
      IF ~AIZVERTS
         CLEAR(INV:RECORD)
         INV:NOMENKLAT='AIZVERTS'
         ADD(INVENT)
         AIZVERTS=TRUE
         HIDE(?Delete)
         HIDE(?Change)
      ELSE
         CLEAR(INV:RECORD)
         INV:NOMENKLAT='AIZVERTS'
         GET(INVENT,INV:NOM_KEY)
         IF ~ERROR()
            DELETE(INVENT)
            AIZVERTS=FALSE
            UNHIDE(?Delete)
            UNHIDE(?Change)
         .
      .
      DO BRW1::InitializeBrowse
      DO BRW1::RefreshPage
      DISPLAY
    END
    CASE FIELD()
    OF ?Browse:1
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?ButtonKPPR
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPC=1
        DO BUILDDOKS
      END
    OF ?Insert
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?INV:NOMENKLAT
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?INV:NOMENKLAT)
        IF INV:NOMENKLAT
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort4:LocatorValue = INV:NOMENKLAT
          BRW1::Sort4:LocatorLength = LEN(CLIP(INV:NOMENKLAT))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?INV:KODS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?INV:KODS)
        IF INV:KODS
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?INV:KATALOGA_NR
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?INV:KATALOGA_NR)
        IF INV:KATALOGA_NR
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = INV:KATALOGA_NR
          BRW1::Sort2:LocatorLength = LEN(CLIP(INV:KATALOGA_NR))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?INV:NOS_A
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?INV:NOS_A)
        IF INV:NOS_A
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort3:LocatorValue = INV:NOS_A
          BRW1::Sort3:LocatorLength = LEN(CLIP(INV:NOS_A))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonSALDO
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPC=2
        DO BUILDDOKS
      END
    OF ?ButtonAkts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPCIJA='00000103000010000000'
        !       12345678901234567890
        IZZFILTN
        IF GlobalResponse=RequestCompleted
            START(N_INVAKTSREZ,50000)
        END
      END
    OF ?ButtonKPPR:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPC=3
        DO BUILDDOKS
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF INVENT::Used = 0
    CheckOpen(INVENT,1)
  END
  INVENT::Used += 1
  BIND(INV:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseInvent','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,250} = BSKey
  ?Browse:1{Prop:Alrt,250} = SpaceKey
  ?Browse:1{Prop:Alrt,255} = InsertKey
  ?Browse:1{Prop:Alrt,254} = DeleteKey
  ?Browse:1{Prop:Alrt,253} = CtrlEnter
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  IF FilesOpened
    INVENT::Used -= 1
    IF INVENT::Used = 0 THEN CLOSE(INVENT).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF WindowOpened
    INISaveWindow('BrowseInvent','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LocatorValue = INV:KODS
    CLEAR(INV:KODS)
  OF 2
    INV:KATALOGA_NR = BRW1::Sort2:LocatorValue
  OF 3
    INV:NOS_A = BRW1::Sort3:LocatorValue
  OF 4
    INV:NOMENKLAT = BRW1::Sort4:LocatorValue
  END
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------
!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ RE�LO PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    clear(PAV:Record)
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVAD)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          DO PROCEDURERETURN
        END
      END
      CYCLE
    END
    BREAK
  END

!-----------------------------------------------------------------------------------------------------
BUILDDOKS ROUTINE    ! RAKSTOT RE�LO PAVAD
 CASE OPC
 OF 1 ! K PPR ar + un - daudzumiem
    KLUDA(0,'tiks uzb�v�ta K P/Z(Akts) vis�m poz�cij�m, kur Atlikums ~= ar Faktisko ar + vai - daudzumu',2,1)
 OF 2 ! SALDO
    KLUDA(0,'tiks pierakst�ts SALDO vis�m poz�cij�m, kur Atlikumu maz�ks par Faktisko p�c PIC',2,1)
    IF ~KLU_DARBIBA THEN EXIT.
    KLUDA(0,'ja SALDO raksts Jums ir pareizs, tad ar �o tas tiks saboj�ts',2,1)
 OF 3 ! K PPR
    KLUDA(0,'tiks uzb�v�ta K P/Z(Akts) vis�m poz�cij�m, kur Atlikums liel�ks par Faktisko',2,1)
 .
 IF ~KLU_DARBIBA THEN EXIT.
 InfoString = 'Rakstu p�rbaudes l�me�a(X) anal�ze'
 InfoString1= 'nor�diet, ko neanaliz�t'
 F:ATL=''
 REMOVE(I_FILE) !�itaj� fail� saraksta visas, kas nav p�rbaud�tas 
 CHECKOPEN(I_FILE,1)
 OPEN(INVWIND)
 DISPLAY
 unhide(?OKBUTTON:1)
 DISPLAY()
 ACCEPT
    CASE FIELD()
    OF ?OKBUTTON:1
       CASE EVENT()
       OF EVENT:Accepted
          HIDE(?IMAGEIGN)
          HIDE(?BUTTONIGN)
          HIDE(?OKBUTTON:1)
          BREAK
       END
    OF ?BUTTONIGN
       CASE EVENT()
       OF EVENT:Accepted
          IF F:ATL='2'
             F:ATL=''
             HIDE(?IMAGEIGN)
          ELSIF F:ATL='1'
             F:ATL='2'
             UNHIDE(?IMAGEIGN)
             ?BUTTONIGN{PROP:TEXT}='&Ignor�t visas neanaliz�t�s'
          ELSE
             F:ATL='1'
             UNHIDE(?IMAGEIGN)
             ?BUTTONIGN{PROP:TEXT}='&Ignor�t neanaliz�t�s ar 0-es atlikumu'
          .
          DISPLAY
       END
    END
 END
 CLEAR(INV:RECORD)
 SET(INVENT)
 NOTX#=0
 X#=0
 IF ~(F:ATL='2') !~Ignoret visas neanaliz�t�s
    LOOP
       NEXT(INVENT)
       IF ERROR() THEN BREAK.
       x#+=1
       InfoString = 'Analiz�ti '&x#&' ieraksti'
       DISPLAY
       IF ~(INV:X OR (INV:ATLIKUMS=0 AND INV:ATLIKUMS_F=0 AND F:ATL)) !.. vai ignoret neanalizetas ar 0-es atlikumu
          NOTX#+=1
          I:LINE='Kods='&INV:KODS&' Nomenklat�ra='&INV:NOMENKLAT&' '&INV:NOSAUKUMS
          ADD(I_FILE)
       .
    .
 .
 CLOSE(I_FILE)
 IF NOTX#
    InfoString = 'Nav p�rbaud�ti (X=0) '&notx#&' ieraksti'
    InfoString1= 'Saraksta b�v��ana p�rtraukta,skat�t INV0.TXT'
    ?OKBUTTON:1{PROP:TEXT}='Beigt'
    UNHIDE(?OKBUTTON:1)
    DISPLAY()
    ACCEPT
       CASE FIELD()
       OF ?OKBUTTON:1
          CASE EVENT()
          OF EVENT:Accepted
             LocalResponse = RequestCancelled
             POST(Event:CloseWindow)
          END
       END
    END
 ELSE
    InfoString = 'Rakstu DB...'
    DISPLAY()
    CASE OPC
    OF 1   ! K PPR
    OROF 3 ! K PPR tikai +
       DO AUTONUMBER
!       PAV:U_NR=Auto::Save:PAV:U_NR
!       PAV:DATUMS=TODAY()
       PAV:DOKDAT=PAV:DATUMS
       PAV:NOKA='Inventariz�cija'
       pav:PAMAT='Inventariz�cija '&format(today(),@d06.)
       IF ~GETPAR_K(50,0,1)   !ra�o�ana
          PAR:U_NR=50
          PAR:TIPS='R'
          PAR:NOS_P='Inventariz�cijas rezult�ts'
          PAR:NOS_S='Inventariz�cija'
          PAR:NOS_A='Inventarizacija'
          ADD(PAR_K)
       .
       PAV:PAR_NR=50
       PAV:D_K='K'
    OF 2 ! SALDO JAU IR J�B�T
       IF ~GETPAVADZ(1)
          KLUDA(0,'Nav atrasts SALDO ???')
       .
    .
    PAV:SUMMA=0
    PAV:VAL='Ls'
    IF RIUPDATE:PAVAD()
       KLUDA(24,'PAVAD')
    ELSE
       CLEAR(INV:RECORD)
       raksti#=0
       SET(INVENT)
       LOOP
          NEXT(INVENT)
          IF ERROR() THEN BREAK.
          IF INV:X  AND|  ! RAKSTS IR P�RBAUD�TS          
          ((INV:ATLIKUMS<>INV:ATLIKUMS_F AND OPC=1) OR| ! NESAKR�T FAKTISKI AR J�B�T, B�V�JAM K PPR AR +,- DAUDZUMIEM
           (INV:ATLIKUMS>INV:ATLIKUMS_F  AND OPC=3) OR| ! FAKTISKI IR MAZ�K NEK� J�B�T, B�V�JAM K PPR
           (INV:ATLIKUMS<INV:ATLIKUMS_F  AND OPC=2))    ! FAKTISKI IR VAIR�K NEK� J�B�T, PIEB�V�JAM SALDO
             raksti#+=1
             InfoString = 'Rakstu : '&INV:NOMENKLAT
             InfoString1= 'kop� : '&raksti#&' raksti'
             DISPLAY
             DELTA=INV:ATLIKUMS-INV:ATLIKUMS_F
             CLEAR(NOL:RECORD)
             NOL:U_NR=PAV:U_NR
             NOL:DATUMS=PAV:DATUMS
             NOL:NOMENKLAT=INV:NOMENKLAT
             NOL:PAR_NR=PAV:PAR_NR
             NOL:D_K=PAV:D_K
             NOL:RS=PAV:RS
             IF OPC=1 OR OPC=3  !K PPR
                NOL:DAUDZUMS=DELTA
                NOL:SUMMA=INV:CENA*DELTA
             ELSE !SALDO
                NOL:DAUDZUMS=-DELTA
                NOL:SUMMA=GETNOM_K(INV:NOMENKLAT,0,7,6)*(-DELTA)
             .
             NOL:SUMMAV=NOL:SUMMA
             NOL:VAL='Ls'
             ADD(NOLIK)
             AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
             KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
             PAV:SUMMA+=NOL:SUMMA
          .
       .
       IF RIUPDATE:PAVAD()
          KLUDA(24,'PAVAD')
       .
       InfoString = 'Beidzu darbu...'
       InfoString1= 'kop� : '&raksti#&' raksti'
       UNHIDE(?OKBUTTON:1)
       HIDE(?IMAGEIGN)
       DISPLAY
       ACCEPT
          CASE FIELD()
          OF ?OKBUTTON:1
             CASE EVENT()
             OF EVENT:Accepted
               LocalResponse = RequestCancelled
               POST(Event:CloseWindow)
             END
          END
       END
    .
 .
 CLOSE(INVWIND)

!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF CHOICE(?CurrentTab) = 2
    BRW1::SortOrder = 1
  ELSIF CHOICE(?CurrentTab) = 3
    BRW1::SortOrder = 2
  ELSIF CHOICE(?CurrentTab) = 4
    BRW1::SortOrder = 3
  ELSE
    BRW1::SortOrder = 4
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    END
  ELSE
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      INV:KATALOGA_NR = BRW1::Sort2:LocatorValue
    OF 3
      BRW1::Sort3:LocatorValue = ''
      BRW1::Sort3:LocatorLength = 0
      INV:NOS_A = BRW1::Sort3:LocatorValue
    OF 4
      BRW1::Sort4:LocatorValue = ''
      BRW1::Sort4:LocatorLength = 0
      INV:NOMENKLAT = BRW1::Sort4:LocatorValue
    END
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'INVENT')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = INV:KODS
  OF 2
    BRW1::Sort2:HighValue = INV:KATALOGA_NR
  OF 3
    BRW1::Sort3:HighValue = INV:NOS_A
  OF 4
    BRW1::Sort4:HighValue = INV:NOMENKLAT
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'INVENT')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = INV:KODS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 2
    BRW1::Sort2:LowValue = INV:KATALOGA_NR
    SetupStringStops(BRW1::Sort2:LowValue,BRW1::Sort2:HighValue,SIZE(BRW1::Sort2:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort2:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  OF 3
    BRW1::Sort3:LowValue = INV:NOS_A
    SetupStringStops(BRW1::Sort3:LowValue,BRW1::Sort3:HighValue,SIZE(BRW1::Sort3:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort3:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  OF 4
    BRW1::Sort4:LowValue = INV:NOMENKLAT
    SetupStringStops(BRW1::Sort4:LowValue,BRW1::Sort4:HighValue,SIZE(BRW1::Sort4:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort4:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  INV:NOMENKLAT = BRW1::INV:NOMENKLAT
  INV:KATALOGA_NR = BRW1::INV:KATALOGA_NR
  INV:CENA = BRW1::INV:CENA
  INV:ATLIKUMS = BRW1::INV:ATLIKUMS
  INV:ATLIKUMS_F = BRW1::INV:ATLIKUMS_F
  A_FA = BRW1::A_FA
  INV:X = BRW1::INV:X
  INV:NOSAUKUMS = BRW1::INV:NOSAUKUMS
  INV:KODS = BRW1::INV:KODS
  INV:NOS_A = BRW1::INV:NOS_A
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!|    If the field is colorized, the colors are computed and applied.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  A_FA=INV:ATLIKUMS-INV:ATLIKUMS_F
  BRW1::INV:NOMENKLAT = INV:NOMENKLAT
  IF (AIZVERTS)
    BRW1::INV:NOMENKLAT:NormalFG = 8421504
    BRW1::INV:NOMENKLAT:NormalBG = -1
    BRW1::INV:NOMENKLAT:SelectedFG = -1
    BRW1::INV:NOMENKLAT:SelectedBG = 12632256
  ELSE
    BRW1::INV:NOMENKLAT:NormalFG = -1
    BRW1::INV:NOMENKLAT:NormalBG = -1
    BRW1::INV:NOMENKLAT:SelectedFG = -1
    BRW1::INV:NOMENKLAT:SelectedBG = -1
  END
  BRW1::INV:KATALOGA_NR = INV:KATALOGA_NR
  IF (AIZVERTS)
    BRW1::INV:KATALOGA_NR:NormalFG = 8421504
    BRW1::INV:KATALOGA_NR:NormalBG = -1
    BRW1::INV:KATALOGA_NR:SelectedFG = -1
    BRW1::INV:KATALOGA_NR:SelectedBG = 12632256
  ELSE
    BRW1::INV:KATALOGA_NR:NormalFG = -1
    BRW1::INV:KATALOGA_NR:NormalBG = -1
    BRW1::INV:KATALOGA_NR:SelectedFG = -1
    BRW1::INV:KATALOGA_NR:SelectedBG = -1
  END
  BRW1::INV:CENA = INV:CENA
  IF (AIZVERTS)
    BRW1::INV:CENA:NormalFG = 8421504
    BRW1::INV:CENA:NormalBG = -1
    BRW1::INV:CENA:SelectedFG = -1
    BRW1::INV:CENA:SelectedBG = 12632256
  ELSE
    BRW1::INV:CENA:NormalFG = -1
    BRW1::INV:CENA:NormalBG = -1
    BRW1::INV:CENA:SelectedFG = -1
    BRW1::INV:CENA:SelectedBG = -1
  END
  BRW1::INV:ATLIKUMS = INV:ATLIKUMS
  IF (AIZVERTS)
    BRW1::INV:ATLIKUMS:NormalFG = 8421504
    BRW1::INV:ATLIKUMS:NormalBG = -1
    BRW1::INV:ATLIKUMS:SelectedFG = -1
    BRW1::INV:ATLIKUMS:SelectedBG = 12632256
  ELSE
    BRW1::INV:ATLIKUMS:NormalFG = -1
    BRW1::INV:ATLIKUMS:NormalBG = -1
    BRW1::INV:ATLIKUMS:SelectedFG = -1
    BRW1::INV:ATLIKUMS:SelectedBG = -1
  END
  BRW1::INV:ATLIKUMS_F = INV:ATLIKUMS_F
  IF (AIZVERTS)
    BRW1::INV:ATLIKUMS_F:NormalFG = 8421504
    BRW1::INV:ATLIKUMS_F:NormalBG = -1
    BRW1::INV:ATLIKUMS_F:SelectedFG = -1
    BRW1::INV:ATLIKUMS_F:SelectedBG = 12632256
  ELSE
    BRW1::INV:ATLIKUMS_F:NormalFG = -1
    BRW1::INV:ATLIKUMS_F:NormalBG = -1
    BRW1::INV:ATLIKUMS_F:SelectedFG = -1
    BRW1::INV:ATLIKUMS_F:SelectedBG = -1
  END
  BRW1::A_FA = A_FA
  IF (AIZVERTS)
    BRW1::A_FA:NormalFG = 8421504
    BRW1::A_FA:NormalBG = -1
    BRW1::A_FA:SelectedFG = -1
    BRW1::A_FA:SelectedBG = 12632256
  ELSE
    BRW1::A_FA:NormalFG = -1
    BRW1::A_FA:NormalBG = -1
    BRW1::A_FA:SelectedFG = -1
    BRW1::A_FA:SelectedBG = -1
  END
  BRW1::INV:X = INV:X
  IF (AIZVERTS)
    BRW1::INV:X:NormalFG = 8421504
    BRW1::INV:X:NormalBG = -1
    BRW1::INV:X:SelectedFG = -1
    BRW1::INV:X:SelectedBG = 12632256
  ELSE
    BRW1::INV:X:NormalFG = -1
    BRW1::INV:X:NormalBG = -1
    BRW1::INV:X:SelectedFG = -1
    BRW1::INV:X:SelectedBG = -1
  END
  BRW1::INV:NOSAUKUMS = INV:NOSAUKUMS
  IF (AIZVERTS)
    BRW1::INV:NOSAUKUMS:NormalFG = 8421504
    BRW1::INV:NOSAUKUMS:NormalBG = -1
    BRW1::INV:NOSAUKUMS:SelectedFG = -1
    BRW1::INV:NOSAUKUMS:SelectedBG = 12632256
  ELSE
    BRW1::INV:NOSAUKUMS:NormalFG = -1
    BRW1::INV:NOSAUKUMS:NormalBG = -1
    BRW1::INV:NOSAUKUMS:SelectedFG = -1
    BRW1::INV:NOSAUKUMS:SelectedBG = -1
  END
  BRW1::INV:KODS = INV:KODS
  IF (AIZVERTS)
    BRW1::INV:KODS:NormalFG = 8421504
    BRW1::INV:KODS:NormalBG = -1
    BRW1::INV:KODS:SelectedFG = -1
    BRW1::INV:KODS:SelectedBG = 12632256
  ELSE
    BRW1::INV:KODS:NormalFG = -1
    BRW1::INV:KODS:NormalBG = -1
    BRW1::INV:KODS:SelectedFG = -1
    BRW1::INV:KODS:SelectedBG = -1
  END
  BRW1::INV:NOS_A = INV:NOS_A
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:1)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
    ELSE
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert)
      POST(Event:Accepted,?Change)
      POST(Event:Accepted,?Delete)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => INV:KODS
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 2
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(INV:KATALOGA_NR)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 3
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort3:KeyDistribution[BRW1::CurrentScroll] => UPPER(INV:NOS_A)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 4
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort4:KeyDistribution[BRW1::CurrentScroll] => UPPER(INV:NOMENKLAT)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      INV:KATALOGA_NR = BRW1::Sort2:LocatorValue
    OF 3
      BRW1::Sort3:LocatorValue = ''
      BRW1::Sort3:LocatorLength = 0
      INV:NOS_A = BRW1::Sort3:LocatorValue
    OF 4
      BRW1::Sort4:LocatorValue = ''
      BRW1::Sort4:LocatorLength = 0
      INV:NOMENKLAT = BRW1::Sort4:LocatorValue
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert)
    OF DeleteKey
      POST(Event:Accepted,?Delete)
    OF CtrlEnter
      POST(Event:Accepted,?Change)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          SELECT(?INV:KODS)
          PRESS(CHR(KEYCHAR()))
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            INV:KATALOGA_NR = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          INV:KATALOGA_NR = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          INV:KATALOGA_NR = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 3
        IF KEYCODE() = BSKey
          IF BRW1::Sort3:LocatorLength
            BRW1::Sort3:LocatorLength -= 1
            BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength)
            INV:NOS_A = BRW1::Sort3:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength) & ' '
          BRW1::Sort3:LocatorLength += 1
          INV:NOS_A = BRW1::Sort3:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort3:LocatorValue = SUB(BRW1::Sort3:LocatorValue,1,BRW1::Sort3:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort3:LocatorLength += 1
          INV:NOS_A = BRW1::Sort3:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 4
        IF KEYCODE() = BSKey
          IF BRW1::Sort4:LocatorLength
            BRW1::Sort4:LocatorLength -= 1
            BRW1::Sort4:LocatorValue = SUB(BRW1::Sort4:LocatorValue,1,BRW1::Sort4:LocatorLength)
            INV:NOMENKLAT = BRW1::Sort4:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort4:LocatorValue = SUB(BRW1::Sort4:LocatorValue,1,BRW1::Sort4:LocatorLength) & ' '
          BRW1::Sort4:LocatorLength += 1
          INV:NOMENKLAT = BRW1::Sort4:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort4:LocatorValue = SUB(BRW1::Sort4:LocatorValue,1,BRW1::Sort4:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort4:LocatorLength += 1
          INV:NOMENKLAT = BRW1::Sort4:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert)
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 1
      INV:KODS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 2
      INV:KATALOGA_NR = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 3
      INV:NOS_A = BRW1::Sort3:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 4
      INV:NOMENKLAT = BRW1::Sort4:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'INVENT')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(INV:KOD_KEY)
      RESET(INV:KOD_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(INV:KOD_KEY,INV:KOD_KEY)
    END
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(INV:KAT_KEY)
      RESET(INV:KAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(INV:KAT_KEY,INV:KAT_KEY)
    END
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(INV:NOS_KEY)
      RESET(INV:NOS_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(INV:NOS_KEY,INV:NOS_KEY)
    END
  OF 4
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(INV:NOM_KEY)
      RESET(INV:NOM_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(INV:NOM_KEY,INV:NOM_KEY)
    END
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    CASE BRW1::SortOrder
    OF 1; ?INV:KODS{Prop:Disable} = 0
    OF 2; ?INV:KATALOGA_NR{Prop:Disable} = 0
    OF 3; ?INV:NOS_A{Prop:Disable} = 0
    OF 4; ?INV:NOMENKLAT{Prop:Disable} = 0
    END
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Change{Prop:Disable} = 0
    ?Delete{Prop:Disable} = 0
  ELSE
    CLEAR(INV:Record)
    CASE BRW1::SortOrder
    OF 1; ?INV:KODS{Prop:Disable} = 1
    OF 2; ?INV:KATALOGA_NR{Prop:Disable} = 1
    OF 3; ?INV:NOS_A{Prop:Disable} = 1
    OF 4; ?INV:NOMENKLAT{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change{Prop:Disable} = 1
    ?Delete{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    SET(INV:KOD_KEY)
  OF 2
    SET(INV:KAT_KEY)
  OF 3
    SET(INV:NOS_KEY)
  OF 4
    SET(INV:NOM_KEY)
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.InsertButton=?Insert
  BrowseButtons.ChangeButton=?Change
  BrowseButtons.DeleteButton=?Delete
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  IF BrowseButtons.InsertButton THEN
    TBarBrwInsert{PROP:DISABLE}=BrowseButtons.InsertButton{PROP:DISABLE}
  END
  IF BrowseButtons.ChangeButton THEN
    TBarBrwChange{PROP:DISABLE}=BrowseButtons.ChangeButton{PROP:DISABLE}
  END
  IF BrowseButtons.DeleteButton THEN
    TBarBrwDelete{PROP:DISABLE}=BrowseButtons.DeleteButton{PROP:DISABLE}
  END
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

UpdateDispatch ROUTINE
  DISABLE(TBarBrwDelete)
  DISABLE(TBarBrwChange)
  IF BrowseButtons.DeleteButton AND BrowseButtons.DeleteButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwDelete)
  END
  IF BrowseButtons.ChangeButton AND BrowseButtons.ChangeButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwChange)
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW1::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(INVENT,0)
  CLEAR(INV:Record,0)
  LocalRequest = InsertRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the change is successful (GlobalRequest = RequestCompleted) then the newly changed
!| record is displayed in the BrowseBox.
!|
!| If the change is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = ChangeRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the delete is successful (GlobalRequest = RequestCompleted) then the deleted record is
!| removed from the queue.
!|
!| Next, the BrowseBox is refreshed, redisplaying the current page.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = DeleteRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:1)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateInvent) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  IF AIZVERTS
     LOCALREQUEST=0
     GLOBALREQUEST=0
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateInvent
    LocalResponse = GlobalResponse
    CASE VCRRequest
    OF VCRNone
      BREAK
    OF VCRInsert
      IF LocalRequest=ChangeRecord THEN
        LocalRequest=InsertRecord
      END
    OROF VCRForward
      IF LocalRequest=InsertRecord THEN
        GET(INVENT,0)
        CLEAR(INV:Record,0)
      ELSE
        DO BRW1::PostVCREdit1
        BRW1::CurrentEvent=Event:ScrollDown
        DO BRW1::ScrollOne
        DO BRW1::PostVCREdit2
      END
    OF VCRBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollUp
      DO BRW1::ScrollOne
      DO BRW1::PostVCREdit2
    OF VCRPageForward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageDown
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRPageBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageUp
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRFirst
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollTop
      DO BRW1::ScrollEnd
      DO BRW1::PostVCREdit2
    OF VCRLast
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollBottom
      DO BRW1::ScrollEND
      DO BRW1::PostVCREdit2
    END
  END
  DO BRW1::Reset

BRW1::PostVCREdit1 ROUTINE
  DO BRW1::Reset
  BRW1::LocateMode=LocateOnEdit
  DO BRW1::LocateRecord
  DO RefreshWindow

BRW1::PostVCREdit2 ROUTINE
  ?Browse:1{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


