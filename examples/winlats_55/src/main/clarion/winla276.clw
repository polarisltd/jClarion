                     MEMBER('winlats.clw')        ! This is a MEMBER module
R_Skoda_xml          PROCEDURE                    ! Declare Procedure
!INCLUDE('CPXML.INC'),ONCE
!INCLUDE('XMLCLASS.INC'),ONCE

!Include('iQxml.inc','Modules')
! map
!  module('IQxml.dll')
!       XML:LoadFromString(*CSTRING,<BYTE>,<BYTE>),SHORT,DLL(DLL_MODE)
!       XML:LoadFromFile(STRING,<BYTE>,<BYTE>),SHORT,DLL(DLL_MODE)
!       XML:Free(),DLL(DLL_MODE)
!       XML:DebugQueue(<STRING>),DLL(DLL_MODE)
!       XML:LoadQueue(*QUEUE,<BYTE>,<BYTE>,<BYTE>),BYTE,DLL(DLL_MODE)
!       XML:FindNextNode(STRING,<STRING>,<STRING>,<STRING>,<STRING>),SHORT,DLL(DLL_MODE)
!       XML:FindNextContent(STRING,BYTE,BYTE),SHORT,DLL(DLL_MODE)
!       XML:ReadNextRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)
!       XML:ReadPreviousRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)
!       XML:ReadCurrentRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)
!
!       XML:GotoSibling(),SHORT,DLL(DLL_MODE)
!       XML:GotoParent(),SHORT,DLL(DLL_MODE)
!       XML:GotoChild(),SHORT,DLL(DLL_MODE)
!
!       XML:GotoTop(),DLL(DLL_MODE)
!       XML:GetPointer(),LONG,DLL(DLL_MODE)
!       XML:SetPointer(LONG),SHORT,DLL(DLL_MODE)
!       XML:SaveState(),SHORT,DLL(DLL_MODE)
!       XML:RestoreState(SHORT),SHORT,DLL(DLL_MODE)
!       XML:FreeState(SHORT),DLL(DLL_MODE)
!       XML:PrimaryKeyCascade(STRING,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>),DLL(DLL_MODE)
!       XML:PrimaryKeyClear(),DLL(DLL_MODE)
!       XML:PrimaryFieldCascade(STRING,STRING),DLL(DLL_MODE)
!       XML:PrimaryFieldClear(),DLL(DLL_MODE)    
!       XML:QualifyFieldSet(STRING,<BYTE>),DLL(DLL_MODE)
!       XML:QualifyFieldClear(<STRING>),DLL(DLL_MODE)
!       XML:AttributeFieldSet(STRING,<BYTE>,<STRING>),DLL(DLL_MODE)
!       XML:AttributeFieldClear(<STRING>),DLL(DLL_MODE)
!       XML:AutoRootSet(),DLL(DLL_MODE)
!       XML:AutoRootClear(),DLL(DLL_MODE)
!       XML:GetError(<SHORT>),STRING,DLL(DLL_MODE)
!       XML:ViewFile(STRING),DLL(DLL_MODE)
!       XML:DebugMyQueue(*QUEUE,<STRING>),DLL(DLL_MODE)
!       XML:SkipDebug(BYTE),DLL(DLL_MODE)
!       XML:PickFileToDebug(),DLL(DLL_MODE)  
!       XML:SetProgressWindow(ULONG,<STRING>),DLL(DLL_MODE)
!  end
! end



!MAP
! INCLUDE('OCX.CLW')
!end
!KOMENT               STRING(90)
!CC      BYTE
!!xmlExch XMLExchange
!!xmlNav  CLASS(XMLNavigator)
!!Parse   PROCEDURE !
!Customer QUEUE !queue to storing imported data
!kods STRING(30)
!nosaukums STRING(30)
!grupa STRING(30)
!END
!
!xmlDoc &Document,Auto 
!Nl &Nodelist,Auto 
!nnm &NamedNodeMap,auto 
!ANode &Node,Auto 
!AttrIndex Long 
!ListXML queue(DOMQueue) ! rinda parametru lasisanai
!end 
!
ListXMLCount Long
feqOLE long
Str STRING(30)


InvoicesQueue     QUEUE
kods        string(20)
nosaukums          string(100)
grupa           string(20)
apaksgrupa         string(20)
hom_grupa          string(20)
atlikums_kl_iela        string(20)
rezervets_kl_iela          string(20)
end

Irecs   SHORT



TNAME_B    STRING(70),STATIC
TFILE_B      FILE,NAME(TNAME_B),PRE(B),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR           STRING(200)
             . .
NEWKODW    BYTE
NEXTCODE   BYTE
FIRSTGOOD  BYTE

TegaNos             cstring(20)
kods                string(20)
nosaukums           string(100)
grupa               string(20)
apaksgrupa          string(20)
cena_lvl_ar_pvn     string(20)
kodaDala            string(1)
Nom                 string(21)
NewQnt              decimal(6)
UpdQnt              decimal(6)
darbiba             string(100)
darbiba1            string(100)

ReadScreen WINDOW('Lasu apmaiтas failu'),AT(,,296,55),GRAY
       STRING(@s100),AT(24,32,259,10),USE(darbiba1)
       STRING(@s100),AT(24,20,259,10),USE(darbiba)
     END


!MainWin window('Ole'),AT(,,350,200),status(-1,-1),system,gray,resize,max,timer(1)
! OLE,AT(5,10,160,100),color(0808000H),use(?OLE)
!  Menubar
!    menu('&clarion App')
!    item('&deactivate xml'),use(?deactXML)
!    end
!  end
! end
! end
  CODE                                            ! Begin processed code
     NEXTCODE = 0
     FIRSTGOOD = 1
     checkopen(NOM_K,1)
     NOM_K::USED+=1
     TNAME_B = LONGPATH()&'\IMPEXP\skoda_cenas.xml'
     MESSAGE('Ielвde no '&LONGPATH()&'\IMPEXP\skoda_cenas.xml')
     NewQnt = 0
     UpdQnt = 0
     CHECKOPEN(TFILE_B,1)
     close(TFILE_B)
     OPEN(TFILE_B,18)
     IF ERROR()
       kluda(1,USERFOLDER&'\micro_skoda_cenas.xml')
       Return
     .
     kods                = ''
     nosaukums           = ''
     grupa               = ''
     apaksgrupa          = ''
     cena_lvl_ar_pvn     = ''
     Nom                 = ''
     SET(TFILE_B)
     OPEN(ReadScreen)
     NPK#+=0
     LOOP UNTIL EOF (TFILE_B)
           
           NEXT (TFILE_B)
           IF ERRORCODE() THEN

              kluda(1,'TFILE_B')
              CLOSE(ReadScreen)
              return
           .
           IF INSTRING('/kods', CLIP(B:STR), 1, 1) then

              IF ~FIRSTGOOD then !ierakstim
                 !NOM:KATALOGA_NR=KODS
                 !GET(NOM_K,NOM:KAT_KEY)
                 IF CLIP(grupa)='PT'
                     kodaDala = RIGHT(apaksgrupa,1)
                 ELSIF CLIP(grupa)='ET'
                     kodaDala = 'E'
                 ELSIF CLIP(grupa)='BT'
                     kodaDala = 'B'
                 ELSE
                     kodaDala = '0'
                 .
                 !15/11/2012 NOM:NOMENKLAT='sk_'&kodaDala&CLIP(KODS)
                 NOM:NOMENKLAT='SK_'&kodaDala&CLIP(KODS)
                 GET(NOM_K,NOM:NOM_KEY)

                 IF ERROR() 
                    CLEAR(NOM:RECORD)
                    !ZUR:RECORD   ='L:'&FORMAT(TODAY(),@D06.)&' Jauns KODS= '&KODS
                    
                    !stop('jAUNS KATALOGA NUMURS  '&KODS)
                    NewQnt +=1
                    NOM:KATALOGA_NR     = KODS
                    NOM:NOS_P    = LEFT(nosaukums, 50) !50
                    NOM:NOS_S    = LEFT(nosaukums, 16) !16
                    NOM:NOS_A    = LEFT(nosaukums, 16) !16
                    !NOM:NOMENKLAT='sk_'&kodaDala&CLIP(KODS)
                    NOM:NOMENKLAT='SK_'&kodaDala&CLIP(KODS)
                    NPK#+=1
                    DARBIBA='Lasu '&CLIP(USERFOLDER&'\micro_skoda_cenas.xml')&' rinda '&NPK#
                    DARBIBA1='Jauns kods '&NOM:NOMENKLAT
                    DISPLAY
                    !        STOP(NOM:NOMENKLAT)
                    NOM:PVN_PROC = 21
                    NOM:TIPS='P'
                    NOM:VAL[1]='Ls'
                    NOM:STATUSS = 1
                    !NOM:REALIZ[1]=100*cena_lvl_ar_pvn/121
                    NOM:REALIZ[1]=cena_lvl_ar_pvn
                    NOM:ARPVNBYTE=31 !VISAS AR PVN
                    !15/11/2012 NOM:MERVIEN = 'gab.'
                    NOM:MERVIEN = 'GAB'
                    NOM:ETIKETES = 1
                    ADD(NOM_K)
                    IF ERROR()
                       KLUDA(24,'NOM_K (ADD) '&NOM:NOMENKLAT)
                       !ZUR:RECORD=CLIP(ZUR:RECORD)&' KѕџDA RAKSTOT NOM_K (ADD) '&NOM:NOMENKLAT
                    .
                 ELSE !T¬DS KODS IR
                    !ZUR:RECORD='L:'&FORMAT(TODAY(),@D6)&' KODS= '&KODS&' '&nosaukums
                    !NOM:REALIZ[1]=100*cena_lvl_ar_pvn/121
                    NOM:REALIZ[1]=cena_lvl_ar_pvn
                    NOM:NOMENKLAT=UPPER(NOM:NOMENKLAT) !15/11/2012
                    NOM:MERVIEN = 'GAB' !15/11/2012
                    NOM:ARPVNBYTE=31 !VISAS AR PVN
                   !stop('IZMAINITA CENA KATALOGA NUMURAM  '&KODS)
                    UpdQnt +=1
                    NPK#+=1
                    DARBIBA='Lasu '&CLIP(USERFOLDER&'\micro_skoda_cenas.xml')&' rinda '&NPK#
                    DARBIBA1='Izmainоts kods '&NOM:NOMENKLAT
                    DISPLAY
                    PUT(NOM_K)
                .
                 kods                = ''
                 nosaukums           = ''
                 grupa               = ''
                 apaksgrupa          = ''
                 cena_lvl_ar_pvn     = ''

              .
              TegaNos = 'kods'
              Beg# = INSTRING(TegaNos, CLIP(B:STR), 1,1) + LEN(TegaNos) + 1  !>  - 1
              Len# = INSTRING('/'&TegaNos, CLIP(B:STR), 1,1)-2 - Beg# + 1    !</ - 2
              kods = CLIP(SUB(B:STR, Beg#, Len#))
              !stop(kods)
              NEXTCODE = 1
              FIRSTGOOD = 0

           .
           IF INSTRING('/nosaukums', B:STR, 1, 1) then
              TegaNos = 'nosaukums'
              Beg# = INSTRING(TegaNos, CLIP(B:STR), 1,1) + LEN(TegaNos) + 1  !>  - 1
              Len# = INSTRING('/'&TegaNos, CLIP(B:STR), 1,1)-2 - Beg# + 1    !</ - 2
              nosaukums = CLIP(SUB(B:STR, Beg#, Len#))
              !stop(nosaukums)
           .
           IF INSTRING('/grupa', B:STR, 1, 1) then
              TegaNos = 'grupa'
              Beg# = INSTRING(TegaNos, CLIP(B:STR), 1,1) + LEN(TegaNos) + 1  !>  - 1
              Len# = INSTRING('/'&TegaNos, CLIP(B:STR), 1,1)-2 - Beg# + 1    !</ - 2
              grupa = CLIP(SUB(B:STR, Beg#, Len#))
              !stop(grupa)
           .
           IF INSTRING('/apaksgrupa', B:STR, 1, 1) then
              TegaNos = 'apaksgrupa'
              Beg# = INSTRING(TegaNos, CLIP(B:STR), 1,1) + LEN(TegaNos) + 1  !>  - 1
              Len# = INSTRING('/'&TegaNos, CLIP(B:STR), 1,1)-2 - Beg# + 1    !</ - 2
              apaksgrupa = CLIP(SUB(B:STR, Beg#, Len#))
           .
           IF INSTRING('/cena_lvl_ar_pvn', B:STR, 1, 1) then
              TegaNos = 'cena_lvl_ar_pvn'
              Beg# = INSTRING(TegaNos, CLIP(B:STR), 1,1) + LEN(TegaNos) + 1  !>  - 1
              Len# = INSTRING('/'&TegaNos, CLIP(B:STR), 1,1)-2 - Beg# + 1    !</ - 2
              cena_lvl_ar_pvn = CLIP(SUB(B:STR, Beg#, Len#))
              !stop(cena_lvl_ar_pvn)
           .

     .
      CLOSE(TFILE_B)
      IF ~FIRSTGOOD And NEXTCODE then !ierakstim
         !NOM:KATALOGA_NR=KODS
         !GET(NOM_K,NOM:KAT_KEY)
         IF CLIP(grupa)='PT'
             kodaDala = RIGHT(apaksgrupa,1)
         ELSIF CLIP(grupa)='ET'
             kodaDala = 'E'
         ELSIF CLIP(grupa)='BT'
             kodaDala = 'B'
         ELSE
             kodaDala = '0'
         .
         !NOM:NOMENKLAT='sk_'&kodaDala&CLIP(KODS)
         NOM:NOMENKLAT='SK_'&kodaDala&CLIP(KODS)
         GET(NOM_K,NOM:NOM_KEY)

         IF ERROR() 
            CLEAR(NOM:RECORD)
            !ZUR:RECORD   ='L:'&FORMAT(TODAY(),@D06.)&' Jauns KODS= '&KODS
            !stop('jAUNS KATALOGA NUMURS  '&KODS)
            NewQnt +=1
            NOM:KATALOGA_NR     =KODS
            NOM:NOS_P    =nosaukums !50
            NOM:NOS_S    =nosaukums !16
            NOM:NOS_A    =nosaukums !16
            !15/11/2012 NOM:NOMENKLAT='sk_'&kodaDala&CLIP(KODS)
            NOM:NOMENKLAT='SK_'&kodaDala&CLIP(KODS)
            NPK#+=1
            DARBIBA='Lasu '&CLIP(USERFOLDER&'\micro_skoda_cenas.xml')&' rinda '&NPK#
            DARBIBA1='Jauns kods '&NOM:NOMENKLAT
            DISPLAY
    !        STOP(NOM:NOMENKLAT)
            NOM:PVN_PROC = 21
            NOM:TIPS='P'
            NOM:VAL[1]='Ls'
            NOM:STATUSS = 1
            !NOM:REALIZ[1]=100*cena_lvl_ar_pvn/121
            NOM:REALIZ[1]=cena_lvl_ar_pvn
            NOM:ARPVNBYTE=31 !VISAS AR PVN
            !15/11/2012 NOM:MERVIEN = 'gab.'
            NOM:MERVIEN = 'GAB'
            NOM:ETIKETES = 1
            ADD(NOM_K)
            IF ERROR()
               KLUDA(24,'NOM_K (ADD) '&NOM:NOMENKLAT)
               !ZUR:RECORD=CLIP(ZUR:RECORD)&' KѕџDA RAKSTOT NOM_K (ADD) '&NOM:NOMENKLAT
            .
         ELSE !T¬DS KODS IR
            !ZUR:RECORD='L:'&FORMAT(TODAY(),@D6)&' KODS= '&KODS&' '&nosaukums
            !NOM:REALIZ[1]=100*cena_lvl_ar_pvn/121
            NOM:REALIZ[1]=cena_lvl_ar_pvn
            NOM:NOMENKLAT= UPPER(NOM:NOMENKLAT) !15/11/2012
            NOM:MERVIEN = 'GAB' !15/11/2012
            NOM:ARPVNBYTE=31 !VISAS AR PVN
            !stop('IZMAINоTA CENA KATALOGA NUMURAM  '&KODS)
            UpdQnt +=1
            NPK#+=1
            DARBIBA='Lasu '&CLIP(USERFOLDER&'\micro_skoda_cenas.xml')&' rinda '&NPK#
            DARBIBA1='Izmainоts kods '&NOM:NOMENKLAT
            DISPLAY
            PUT(NOM_K)
         .
      .

     NOM_K::USED-=1
     IF NOM_K::USED=0
        CLOSE(NOM_K)
     .
     MESSAGE('Iznainоta cena '&Updqnt&' gab., ielвdeta jauna nomenklatura '&NewQnt&' gab.')
     CLOSE(ReadScreen)
     REMOVE(TFILE_B)

! Start of "Data Section"
! [Priority 4000]
    ! Load the XML file to process it
    ! -------------------------------
!    XML:ViewFile(USERFOLDER&'\micro_skoda_cenas.xml')
!    stop('1')
!    If ~Xml:LoadFromFile(USERFOLDER&'\micro_skoda_cenas.xml')
!        stop ('ura!')
!        If ~xml:FindNextNode('Root','Item')
!            Xml:PrimaryKeyCascade('kods','nosaukums')
!            IRecs = XML:LoadQueue(InvoicesQueue,True,True)
!            stop ('uraaaaaa')
!        End
!        XML:Free()
!        XML:DebugMyQueue(InvoicesQueue,'The Invoice Queue')
!    End

 !feqOLE=create(0,CREATE:Ole)
!
!   feqOLE=create(0,CREATE:Ole) ! создали OLE-контрол
!   feqOLE{Prop:Create}='Msxml2.DOMDocument.3.0' ! сказали, что этот контрол использует Word
!   feqOLE{Prop:ReportException}=TRUE      ! дл€ отладки - показываем все сообщени€ об ошибках OLE
!   feqOLE{'Visible'}=1                    ! показали Word
!   feqOLE{'Load("'&USERFOLDER&'\1micro_skoda_cenas.xml")'} ! открыли шаблонный документа
!    ListXMLCount = feqOLE{'documentElement.selectNodes("root/item").lenght'}
! !stop ('ListXMLCount'&ListXMLCount)
! Str = feqOLE{'documentElement.selectNodes("root/item").item(0).text'}
! stop (Str)
!
! ?OLE{PROP:Create} = 'Msxml2.DOMDocument.3.0'
! ?OLE{'async'} = FALSE
! ?OLE{'validateOnParse'} = TRUE
!!   OPEN(MainWin)
!!  !OCXREGISTEREVENTPROC(?OLE, EventFunc)
!!  ACCEPT
!!    CASE EVENT()
!!    OF Event:OpenWindow
!!      ?OLE{Prop:ReportException} = true
!!     if ?OLE{PROP:OLE} = FALSE
!!     stop('FALSE')
!!     .
!!     IF?OLE{PROP:Object} = ''
!!      stop('___')
!!     .
!!
! ?OLE{'Load("'&USERFOLDER&'\1micro_skoda_cenas.xml")'}
!
!!
!! !xmlDoc.load("hello.xsl");
!!
! if ~?OLE{'parseError.errorCode'} = 0
!  stop ('error '&?OLE{'parseError.reason'})
!! if (xmlDoc.parseError.errorCode != 0) {
!!   var myErr = xmlDoc.parseError;
!!   WScript.Echo("You have error " + myErr.reason);
!! } else {
! else
!
!!   xmlDoc.setProperty("SelectionNamespaces",    "xmlns:xsl='http://www.w3.org/1999/XSL/Transform'");
!!   xmlDoc.setProperty("SelectionLanguage", "XPath");
!!   objNodeList = xmlDoc.documentElement.selectNodes("   WScript.Echo(objNodeList.length);
!!root/item/xsl:template");
!!   objNodeList = xmlDoc.documentElement.selectNodes("//xsl:template");
!!}
!!
! ListXMLCount = ?OLE{'documentElement.selectNodes("root/item").lenght'}
! stop ('ListXMLCount'&ListXMLCount)
! Str = ?OLE{'documentElement.selectNodes("root/item").item(0).text'}
! stop (Str)
! .
! .
! .
!
!!!For Each elemPerson in xdoc.SelectNodes("/root/person")
!!!For Each elem in elemPerson.SelectNodes("*")
!!!Response.Write elem.tagName & ": " elem.Text & "<br />"
!!!Next
!!!Next
!!
!!
!!!        XML=  new COMObject("MSXML2.DOMDocument");
!!!        XML.Load(»м€¬ход€щего‘айла);  
!!!        root=xml.documentElement;
!!!        ƒл€ каждого —трока—п¬алют из —писок¬алют ÷икл 
!!!            ¬алюта = TrimAll(—трока—п¬алют.¬алюта);
!!!            value = root.SelectNodes("Currencies/Currency[./ID="""+¬алюта+"""]");
!!!            if value.length > 0 then
!!!                «апись урсов¬алют.¬алюта = —трока—п¬алют.¬алюта;
!!!                «апись урсов¬алют.ѕериод = i;
!!!                «апись урсов¬алют.ѕрочитать();
!!!                «апись урсов¬алют.¬алюта    = —трока—п¬алют.¬алюта;
!!!                «апись урсов¬алют.ѕериод    = i;
!!!                «апись урсов¬алют. урс      = Number(value.item(0).SelectSingleNode("Rate").text);
!!!                «апись урсов¬алют. ратность = Number(value.item(0).SelectSingleNode("Units").text);
!!!                «апись урсов¬алют.«аписать();
!!!            endif;
!!!         онец÷икла;
!!!        ”далить‘айлы(¬рем аталог,"*.*");
!!!        //Elya 06.12.2005 i = i + 86400;
!!
!!
!!!message(?OLE{'parseError.errorCode'})
!!!message(?OLE{'parseError.reason'})
!!
!!
!!             !STOP(USERFOLDER&'\micro_skoda_cenas.xml')
!!
!!                CHECKOPEN(NOM_K,1)
!!             CLEAR(NOM:RECORD)
!!             !xmlDoc &= XMLFileToDOM('micro_skoda_cenas.xml')
!!!             If xmlDoc &= Null
!!!               STOP('Reading Error ')
!!!               ! ????????, ??????? ????????? ? ??????????? ? ???????? ? ????????? 
!!!
!!!             End
!!
!!     !!CC = xmlExch.OPEN('micro_skoda_cenas.xml')
!!     !cc = FromXMLFile(Customer,'micro_skoda_cenas.xml')
!!     !IF (CC)
!!          STOP('Reading Error ' & CC)
!!     !ELSE
!!          STOP('Reading OK')
!!!          xmlNav.Init(xmlExch)
!!!          xmlNav.getXMLExchangeNo de
!!!          MESSAGE('Node name: ' & xmlNav.getNodeName())
!!!          ! Parsing XML
!!!          xmlNav.Parse
!!     !END
!!
!!
!!
!!                      NOM:NOMENKLAT='111'
!!                      GET(NOM_K,NOM:NOM_KEY)
!!                      IF ~ERROR()
!!! atjaunot cenu
!!!            NOM:NOMENKLAT =
!!                        KOMENT='Nomenklatыra '&NOM:NOMENKLAT&' mainоta  ' 
!!                        DISPLAY
!!                        IF RIUPDATE:NOM_K()
!!                         .
!!                      ELSE
!!                   NOM:NOS_P='??????????'
!!!                   NOM:TIPS='P'
!!!        NOM:PROC5=999
!!!                      NOM:PIC=P:PIC
!!!                      NOM:PIC_DATUMS=P:DATUMS                     
!!!                      NOM:REALIZ[5]=PIEKTA
!!!                      NOM:REALIZ[4]=CETURTA
!!!                      NOM:VAL[5]   =VAL5
!!!                      NOM:REDZAMIBA=0 !AKTќVA
!!                         ADD(NOM_K)
!!                      .
!!             CLOSE(nom_K)
!!
