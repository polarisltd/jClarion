                     MEMBER('winlats.clw')        ! This is a MEMBER module
R_NOM_XLS            PROCEDURE                    ! Declare Procedure
XlsFEQ LONG

DataQueue Queue
kods                cstring(30)
nosaukums           cstring(100)
cena_lvl_ar_pvn     string(20)
Iep_cena            string(20)
Nom                 cstring(30)
EAN                 cstring(13)
END

NewQnt              decimal(6)
UpdQnt              decimal(6)
darbiba             string(100)
darbiba1            string(100)
kods                cstring(30)
nosaukums           cstring(100)
Nom                 cstring(30)
Lines               decimal(6)


ReadScreen WINDOW('Lasu apmaiòas failu'),AT(,,296,55),GRAY
       STRING(@s100),AT(24,32,259,10),USE(darbiba1)
       STRING(@s100),AT(24,20,259,10),USE(darbiba)
     END


QWindow window
 END

!XLS faila struktûra
!1. Nosaukums
!2. Nomenklatura
!3. Svitru kods
!4. Artikuls
!5. Iepirkuma cena (bez PVN)
!6. 1.realizâcijas cena (ar PVN)
  CODE                                            ! Begin processed code
    open(QWindow)!
    XlsFEQ = CREATE(0, CREATE:OLE)
    XlsFEQ{PROP:Create} = 'Excel.Application'
    !XlsFEQ{'Application.Workbooks.Open("C:\temp.xlsx")'} !""     LONGPATH()&'\IMPEXP\skoda_cenas.xml'
    XlsFEQ{'Application.Workbooks.Open("'&CLIP(LONGPATH())&'\IMPEXP\nom.xlsx")'} !""
    XlsFEQ{'Application.Visible'} = FALSE
    free(DataQueue)
    NPK#+=0
    Lines = XlsFEQ{'Application.ActiveSheet.UsedRange.Rows.Count'}
    !Stop(Lines)

    loop row#=2 to Lines
       DataQueue.nosaukums=XlsFEQ{'Application.Cells(' & row# & ',1).Value'}
       DataQueue.Nom=XlsFEQ{'Application.Cells(' & row# & ',2).Value'}
       DataQueue.EAN=XlsFEQ{'Application.Cells(' & row# & ',3).Value'}
       DataQueue.kods=XlsFEQ{'Application.Cells(' & row# & ',4).Value'}
       DataQueue.Iep_cena=XlsFEQ{'Application.Cells(' & row# & ',5).Value'}
       DataQueue.cena_lvl_ar_pvn=XlsFEQ{'Application.Cells(' & row# & ',6).Value'}
       add(DataQueue)
    end
    checkopen(NOM_K,1)
    NOM_K::USED+=1
    NewQnt = 0
    UpdQnt = 0
    OPEN(ReadScreen)
    LOOP I#= 1 TO RECORDS(DataQueue)
       GET(DataQueue,I#)
       IF CLIP(DataQueue.Nom) = ''
          CYCLE
       END
       !stop(DataQueue.Nom&''&DataQueue.nosaukums&''&DataQueue.KODS&''&DataQueue.EAN&''&DataQueue.Iep_cena&''&DataQueue.cena_lvl_ar_pvn&'')
       NOM:NOMENKLAT=Right(CLIP(DataQueue.Nom))
       !stop(NOM:NOMENKLAT)
       GET(NOM_K,NOM:NOM_KEY)
       IF ERROR()
           CLEAR(NOM:RECORD)
           NOM:NOMENKLAT=Right(CLIP(DataQueue.Nom))
           !stop('jAUNS KATALOGA NUMURS  '&KODS)
           NewQnt +=1
           NOM:KATALOGA_NR     = CLIP(DataQueue.KODS)
           NOM:KODS     = DataQueue.EAN
           IF ~DataQueue.EAN = ''
              NOM:EAN      = '1'
           ELSE
              NOM:EAN      = '0'
           END
           NOM:NOS_P    = LEFT(CLIP(DataQueue.nosaukums), 50) !50
           NOM:NOS_S    = LEFT(CLIP(DataQueue.nosaukums), 16) !16
           NOM:NOS_A    = LEFT(CLIP(DataQueue.nosaukums), 16) !16
           NPK#+=1
           DARBIBA='Lasu '&CLIP(LONGPATH())&'\IMPEXP\temp.xlsx'&' rinda '&NPK#
           DARBIBA1='Jauns kods '&NOM:NOMENKLAT
           DISPLAY
           !        STOP(NOM:NOMENKLAT)
           NOM:PVN_PROC = 21
           NOM:TIPS='P'
           NOM:VAL[1]='Ls'
           NOM:STATUSS = 1
           NOM:REALIZ[1]=1*DataQueue.cena_lvl_ar_pvn
           NOM:ARPVNBYTE=31 !VISAS AR PVN
           NOM:PIC = DataQueue.Iep_cena/1
           NOM:PIC_DATUMS = TODAY()
           NOM:MERVIEN = 'gab.'
           NOM:ETIKETES = 1
           ADD(NOM_K)
           IF ERROR()
              KLUDA(24,'NOM_K (ADD) '&NOM:NOMENKLAT)
              !ZUR:RECORD=CLIP(ZUR:RECORD)&' KÏÛDA RAKSTOT NOM_K (ADD) '&NOM:NOMENKLAT
           .
        ELSE !TÂDS KODS IR
            KLUDA(27,'- jau ir nomenklatura '&NOM:NOMENKLAT)
!           !ZUR:RECORD='L:'&FORMAT(TODAY(),@D6)&' KODS= '&KODS&' '&nosaukums
!           NOM:REALIZ[1]=100*cena_lvl_ar_pvn/121
!           stop('IZMAINITA CENA KATALOGA NUMURAM  '&KODS)
!           UpdQnt +=1
!           NPK#+=1
!           DARBIBA='Lasu '&CLIP(USERFOLDER&'\micro_skoda_cenas.xml')&' rinda '&NPK#
!           DARBIBA1='Izmainîts kods '&NOM:NOMENKLAT
!           DISPLAY
!           PUT(NOM_K)
       .
    END
     NOM_K::USED-=1
     IF NOM_K::USED=0
        CLOSE(NOM_K)
     .
     !MESSAGE('Iznainîta cena '&Updqnt&' gab., ielâdeta jauna nomenklatura '&NewQnt&' gab.')
     MESSAGE('Failâ ir '&Lines-1&' rindas, ielâdeta jauna nomenklatura '&NewQnt&' gab.')
     CLOSE(ReadScreen)

    XlsFEQ{'ActiveWindow.Close(1)'}
    XlsFEQ{'QUIT'}
    XlsFEQ{'PROP:Deactivate'}=True
    loop 3 times
    destroy(XlsFEQ)
    end

