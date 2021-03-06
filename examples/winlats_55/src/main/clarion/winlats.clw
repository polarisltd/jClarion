   PROGRAM

   INCLUDE('Equates.CLW')
   INCLUDE('TplEqu.CLW')
   INCLUDE('Keycodes.CLW')
   INCLUDE('Errors.CLW')
LPCSTR                  EQUATE(CSTRING)
LPSSTR                  EQUATE(STRING)
WORD                    EQUATE(SIGNED)
DWORD                   EQUATE(ULONG)
LPCVOID                 EQUATE(ULONG)
LPVOID                  EQUATE(ULONG)
BOOL                    EQUATE(SIGNED)
HANDLE                  EQUATE(UNSIGNED)


SECURITY_ATTRIBUTES     GROUP,TYPE
nLength                  DWORD
lpSecurityDescriptor     LPVOID
bInheritHandle           BOOL
                        END

RESBUFFER               GROUP,TYPE
RB                       BYTE,DIM(256)
                        END
TRABUFFER               GROUP,TYPE
TB                       BYTE,DIM(256)
                        END


KOPS::A_DAUDZUMS           DECIMAL(11,3),DIM(25)
KOPS::A_SUMMA              DECIMAL(11,2),DIM(25)
KOPS::D_DAUDZUMS           DECIMAL(11,3),DIM(12,25)
KOPS::D_SUMMA              DECIMAL(11,2),DIM(12,25)
KOPS::DI_DAUDZUMS          DECIMAL(11,3),DIM(12,25)
KOPS::K_DAUDZUMS           DECIMAL(11,3),DIM(12,25)
KOPS::K_SUMMA              DECIMAL(11,2),DIM(12,25)
KOPS::KI_DAUDZUMS          DECIMAL(11,3),DIM(12,25)
KOPS::KR_DAUDZUMS          DECIMAL(11,3),DIM(12,25)
KOPS::KR_SUMMA             DECIMAL(11,2),DIM(12,25)

   INCLUDE('ResDef.Clw')
   MAP
     MODULE('winla001.clw')
       UpdateNodalas
       BrowseNodalas
       Main
     END
     MODULE('winla002.clw')
       F_BankasReport
       UpdateBANKAS_K
       BrowseBANKAS_K
     END
     MODULE('winla003.clw')
       UpdateKON_K
       BrowseKON_K
       UpdateKURSI_K
     END
     MODULE('winla004.clw')
       BrowseKURSI_K
       UpdateVAL_K
       BrowseVAL_K
     END
     MODULE('winla005.clw')
       UpdatePAR_Z
       BrowsePAR_Z
       UpdatePROJ_P
     END
     MODULE('winla006.clw')
       BrowsePROJ_P
       UpdatePROJEKTI
       BrowseProjekti
     END
     MODULE('winla007.clw')
       Parmani
       kalkis 
       UpdateParoles
     END
     MODULE('winla008.clw')
       Paroles
       UpdateGlobal
       SUMVAR(REAL,STRING,BYTE),STRING
     END
     MODULE('winla009.clw')
       B_VestuleKlientam
       MENVAR(LONG,BYTE,BYTE),STRING
       IZZFILTGMC 
     END
     MODULE('winla010.clw')
       BrowsePAR_K
       UpdateTex
       BrowseTex
     END
     MODULE('winla011.clw')
       UpdateVesture
       BrowseVesture
       UpdateGRUPA2
     END
     MODULE('winla012.clw')
       UpdateGrupa1
       UpdateATL_S
       BrowseGrupas
     END
     MODULE('winla013.clw')
       UpdateATL_K
       BrowseAtl_k
       UpdatePAR_K
     END
     MODULE('winla014.clw')
       UpdatePar_A
       BrowsePAR_A
       UpdatePAR_E
     END
     MODULE('winla015.clw')
       BrowsePAR_E
       BrowseGG
       UpdateVestureA
     END
     MODULE('winla016.clw')
       BrowseVestureA
       UpdateKon_R
       BrowseKON_R
     END
     MODULE('winla017.clw')
       UpdateARM_K
       BrowseARM_K
       R_Brio_dbf
     END
     MODULE('winla018.clw')
       IZZFILTN
       BuildRekini
       EnterGIL_Show
     END
     MODULE('winla019.clw')
       UpdateTEK_K
       BrowseTEK_K
       PerformShortcut
     END
     MODULE('winla020.clw')
       UpdateGG
       PerformASSAKO1
       UpdatePamat
     END
     MODULE('winla021.clw')
       UpdateKAT_K
       BrowseKAT_K
       UpdatePAM_P
     END
     MODULE('winla022.clw')
       BrowsePAM_P
       UpdatePAMAMORT
       UpdateGGK
     END
     MODULE('winla023.clw')
       SUMMA_W(byte)
       BrowseGGK
       B_KontDru
     END
     MODULE('winla024.clw')
       B_Pavad
       DarbaZurnals
       Browsegg2
     END
     MODULE('winla025.clw')
       BROWSEGG1
       BROWSEGGK1
       UpdateSystem
     END
     MODULE('winla026.clw')
       VestureBuilder
       gl_cont(BYTE)
       B_Ieskaits
     END
     MODULE('winla027.clw')
       bankurs(string,long,<string>,<byte>),real
       ELMAKS
       DropSaldo(LONG)
     END
     MODULE('winla028.clw')
       A_AtvalSar
       F_Meklejumi
       B_MAKRIK
     END
     MODULE('winla029.clw')
       F_PrintPar_K
       F_PrintKon_k
       F_AtlaidesReport
     END
     MODULE('winla030.clw')
       F_PrintGrupas
       F_AtlaidesKlientiem
       F_AtlaizuLapas
     END
     MODULE('winla031.clw')
       B_IeZak
       IZZFILTB 
       B_Izzkont
     END
     MODULE('winla032.clw')
       B_PRETVI
       B_Partner1
       B_NorDokLim
     END
     MODULE('winla033.clw')
       B_PUK
       B_PIK
       B_Avansieri
     END
     MODULE('winla034.clw')
       B_AvanSar
       B_Sahs
       B_Sahs2
     END
     MODULE('winla035.clw')
       B_KonATL
       B_APGR
       B_KaseLs
     END
     MODULE('winla036.clw')
       B_KaseVAL
       B_GG
       B_SnDekl
     END
     MODULE('winla037.clw')
       B_Bilform
       B_OpeForm
       IZZFILTPVN
     END
     MODULE('winla038.clw')
       B_PVN_PIE
       B_KOKU_R_REG
       B_KOKU_I_REG
     END
     MODULE('winla039.clw')
       B_PZA
       B_Bilance
       SelftestBase
     END
     MODULE('winla040.clw')
       B_PVN_DEK01
       B_SALAKTS
       BrowsePavadApv(BYTE)
     END
     MODULE('winla041.clw')
       B_ZurnalsVKVP
       VALNR(STRING,BYTE),STRING
       B_Zurnals1KVP
     END
     MODULE('winla042.clw')
       B_ZurnalsVK1P
       B_Zurnals1K1P
       B_DEKRVI
     END
     MODULE('winla043.clw')
       B_DEKR
       kluda(short,string,<BYTE>,<BYTE>)
       inigen(STRING,<LONG>,BYTE),STRING
     END
     MODULE('winla044.clw')
       getpar_k(ULONG,BYTE,BYTE,<LONG>,<STRING>),string
       GetMYBank(<STRING>)
       GETGG(LONG,<BYTE>),LONG
     END
     MODULE('winla045.clw')
       CYCLEGGK(STRING),LONG
       CYCLEBKK(STRING,STRING),long
       WRGG
     END
     MODULE('winla046.clw')
       GetKon_k(STRING,BYTE,BYTE,<STRING>),STRING
       B_IzdOrd(BYTE)
       B_Ienord(BYTE)
     END
     MODULE('winla047.clw')
       IZZFILTsf
       BuildKorMas(BYTE,BYTE,BYTE,BYTE,BYTE)
       CALCKK(STRING),STRING
     END
     MODULE('winla048.clw')
       GETVAL_K(STRING,BYTE),STRING
       DOS_CONT(STRING,BYTE,<USHORT>),LONG
       GetBankas_k(STRING,BYTE,BYTE),STRING
     END
     MODULE('winla049.clw')
       B_RekinsGG
       PerformGL(BYTE,<STRING>),STRING
       FORMAT_TEKSTS(BYTE,STRING,BYTE,STRING,<BYTE>,<BYTE>)
     END
     MODULE('winla050.clw')
       performtek_k
       AtlikumiB(string,string,real,string,string,real)
       RP 
     END
     MODULE('winla051.clw')
       RP:DRUKAT
       WriteZurnals(BYTE,byte,string)
       ReferGG 
     END
     MODULE('winla052.clw')
       PerfAtable(byte,string,string,string,ulong,string,ushort,ulong,string,BYTE,<LONG>),real
       ReferFixGG 
       browsepar_k1
     END
     MODULE('winla053.clw')
       GETPAR_ATZIME(BYTE,BYTE),string
       K_RENV
       NYcreator
     END
     MODULE('winla054.clw')
       UpdateNOL_KOPS
       BrowseNOL_KOPS
       SELECTJOB
     END
     MODULE('winla055.clw')
       UpdateCENUVEST
       BrowseCENUVEST
       BrowseNol_Stat
     END
     MODULE('winla149.clw')
       UpdateNOL_STAT
       TPSfix
       SelftestNoliekK
     END
     MODULE('winla150.clw')
       SelfNom_k
       PAS_Invoice
       K_STATISTIKA
     END
     MODULE('winla151.clw')
       BrowsePavPas
       UpdateNOM_N
       BrowseNOM_N
     END
     MODULE('winla152.clw')
       UpdatePavPas
       UpdateNolPas
       BrowseAuto
     END
     MODULE('winla153.clw')
       BrowseAutoVesture
       BrowseAutoApk
       UpdateAUTOAPK
     END
     MODULE('winla154.clw')
       BrowseNolikDarbi
       UpdateAUTODARBI
       UpdateKADRI
     END
     MODULE('winla155.clw')
       UpdateKAD_RIK
       BrowseKAD_RIK
       UpdateAmati
     END
     MODULE('winla156.clw')
       BrowseAmati
       BrowseKadri
       UpdateTEK_SER
     END
     MODULE('winla157.clw')
       BROWSETEK_SER
       UpdateAUTOTEX
       UpdateAuto
     END
     MODULE('winla158.clw')
       UpdateAutoKra
       BrowseAutoKra
       UpdateAutoMarkas
     END
     MODULE('winla159.clw')
       BrowseAutoMarkas
       UpdateNOM_K
       UpdateNOM_P
     END
     MODULE('winla160.clw')
       BrowseNom_P
       UpdateNOM_C
       UpdateCrossref
     END
     MODULE('winla161.clw')
       BrowseCrossref
       BrowseNOM_K
       UpdateKOMPLEKT
     END
     MODULE('winla162.clw')
       BrowseKomplekt
       UpdateNOLIK
       K_A_FIFO
     END
     MODULE('winla163.clw')
       K_REALIZ
       K_IENMAT
       K_PrIeKusA
     END
     MODULE('winla164.clw')
       K_B_FIFO
       P_AKTS
       BrowsePAMAT
     END
     MODULE('winla165.clw')
       UpdatePamKat
       P_KARGD
       P_NolAprM
     END
     MODULE('winla166.clw')
       P_KARLI_OBJ
       P_KARLI
       P_NolaprLIN
     END
     MODULE('winla167.clw')
       P_NolApr1
       P_NolAprG
       P_IIKP 
     END
     MODULE('winla168.clw')
       P_VIDBILVERT
       P_PNNIVAKK
       P_NOLAPRGD
     END
     MODULE('winla169.clw')
       P_IIVIV 
       P_INVLIN
       calcamort(BYTE)
     END
     MODULE('winla170.clw')
       GetKat_k(STRING,BYTE,BYTE,STRING),STRING
       ATRSUNR
       selpz
     END
     MODULE('winla171.clw')
       BrowsePAVAD
       UpdateInvent
       BrowseInvent
     END
     MODULE('winla172.clw')
       UpdateEIROKODI
       BrowseEirokodi
       UpdateAU_BILDE
     END
     MODULE('winla173.clw')
       BrowseAU_BILDE
       S_TTSN
       S_MARSRUTI
     END
     MODULE('winla174.clw')
       AI_R_BARMAN
       AI_SVARI_WRITE
       UpdateMER_K
     END
     MODULE('winla175.clw')
       BrowseMER_K
       BrowsePava1
       AI_KA_READ
     END
     MODULE('winla176.clw')
       AI_KA_WRITE
       UpdateSystem_AutoKont
       UpdatePAVAD
     END
     MODULE('winla177.clw')
       IntMaker
       R_TXTAB(BYTE)
       IZZFILTMINMAX
     END
     MODULE('winla178.clw')
       N_LielPPAtsk
       N_Izg_SPar
       N_MatNol
     END
     MODULE('winla179.clw')
       N_IENIZGNOL
       N_InvAkts
       N_KARTDRU
     END
     MODULE('winla180.clw')
       N_IZZSAL
       N_RealDinG
       N_RealDinPG
     END
     MODULE('winla181.clw')
       N_PasAN
       N_PasAN1
       N_RealAn
     END
     MODULE('winla182.clw')
       IZZFILTKRIT
       N_DPIETEIK
       F_PriceList
     END
     MODULE('winla183.clw')
       N_R309
       N_KriAtl
       N_DinAtl
     END
     MODULE('winla184.clw')
       SelftestNOL
       Sel_Nol_Nr25
       N_REGZUR
     END
     MODULE('winla185.clw')
       N_IENMAT
       N_IENMATP
       N_IenNom
     END
     MODULE('winla186.clw')
       N_IenNomP
       N_IenPav
       N_IenPavP
     END
     MODULE('winla187.clw')
       N_IenNomR
       N_IenNomRP
       N_IEKO
     END
     MODULE('winla188.clw')
       N_IEKOP
       N_IZGMAT
       N_IZGMATP
     END
     MODULE('winla189.clw')
       N_Izg_SNom
       N_IzgPav
       N_IzgPavP
     END
     MODULE('winla190.clw')
       N_IzgPT
       N_IzgPTP
       N_IzgKons
     END
     MODULE('winla191.clw')
       N_IzgKonsP
       N_Izgmat5
       Sel_Par_Tips5
     END
     MODULE('winla192.clw')
       CALCSUM(BYTE,BYTE),REAL
       GETNOM_K(STRING,BYTE,BYTE,<BYTE>),STRING
       CYCLENOM(string),long
     END
     MODULE('winla193.clw')
       SPZ_Pavad
       FILLPVN(BYTE,<BYTE>)
       GETPVN(SHORT),REAL
     END
     MODULE('winla194.clw')
       SPZ_KO
       SPZ_PavadA
       SPZ_Pilnvara
     END
     MODULE('winla195.clw')
       GETPAVADZ(LONG),LONG
       LOOKATL(Short),real
       SPZ_PavadD
     END
     MODULE('winla196.clw')
       BLUEGEN
       BARMANLAS
       BARMANLASER
     END
     MODULE('winla197.clw')
       FORMAT_NOLTEX25,STRING
       CYCLENOL(string),long
       LOOKINT(SHORT,SHORT),REAL
     END
     MODULE('winla198.clw')
       GetPar_Atlaide(SHORT,STRING),REAL
       CHECKEAN(REAL,BYTE),REAL
       CYCLEPAR_K(string),long
     END
     MODULE('winla199.clw')
       CUT0(*DECIMAL,BYTE,BYTE,<BYTE>,<BYTE>),STRING
       P_PamKarGD
       P_PamKar2P
     END
     MODULE('winla200.clw')
       Upali
       UpdateAlgas
       BrowseALGAS
     END
     MODULE('winla201.clw')
       UpPiesk
       BrowseDAIEV
       VIDALGA
     END
     MODULE('winla202.clw')
       UpdatePERNOS
       BrowsePERNOS
       A_MAKSPROT
     END
     MODULE('winla203.clw')
       IZZFILTA
       A_STAT
       BrowseALPA
     END
     MODULE('winla204.clw')
       UpdateGrafiks
       BrowseGrafiks
       CAL
     END
     MODULE('winla205.clw')
       A_IzzDAIEV
       UpdateALPA
       A_SarakstsM
     END
     MODULE('winla206.clw')
       A_SarakstsA
       F_KadruSar
       A_SarakstsL
     END
     MODULE('winla207.clw')
       A_SarakstsK
       A_AlguLapinas
       A_PERSKONT
     END
     MODULE('winla208.clw')
       A_PAZ_ALNOD
       A_DNKUS
       A_ParskNeIIN
     END
     MODULE('winla209.clw')
       A_PAZ_ALNODK
       A_DSAK98 
       A_NODPARS6
     END
     MODULE('winla210.clw')
       UpIet
       A_DAIEVPROT2D
       A_DAIEVPROT2
     END
     MODULE('winla211.clw')
       SUM(LONG),SREAL
       CALCNEA(BYTE,BYTE,BYTE),SREAL
       GETDAIEV(SHORT,BYTE,BYTE),STRING
     END
     MODULE('winla212.clw')
       UPAL1
       BROWSEALGAS_V
       CYCLEDAIEV(STRING),LONG
     END
     MODULE('winla213.clw')
       UPAL2
       CALCSTUNDAS(LONG,LONG,BYTE,BYTE,BYTE),USHORT
       CALCALGAS
     END
     MODULE('winla214.clw')
       UPAL3
       CHECKKODS(real)
       BuvetAlgas
     END
     MODULE('winla215.clw')
       GetKadri(USHORT,BYTE,BYTE,<USHORT>),string
       P_PamKar3P
       P_PamKar8P
     END
     MODULE('winla216.clw')
       GETPAR_Adrese(ULONG,BYTE,BYTE,BYTE),STRING
       B_PaskBilPos
       GetTex(ULONG,BYTE),string
     END
     MODULE('winla217.clw')
       GetAuto(ULONG,BYTE),string
       N_MAKRIK
       ANSIUZOEM(STRING),STRING
     END
     MODULE('winla218.clw')
       AtlikumiN(string,string,REAL,string,string,REAL,<BYTE>)
       SPZ_PackLists1
       ConvertDBF(string)
     END
     MODULE('winla219.clw')
       RW_Pav_dbf(BYTE)
       CALCKOPS(BYTE,BYTE,BYTE),REAL
       KopsN(String,long,string,<BYTE>)
     END
     MODULE('winla220.clw')
       IZZFILTNK
       GETGRUPA(STRING,BYTE,BYTE),STRING
       BuildGGKTable(BYTE)
     END
     MODULE('winla221.clw')
       GETCAL(long),string
       K_P_FIFO
       GetParoles(USHORT,BYTE),STRING
     END
     MODULE('winla222.clw')
       GetProjekti(ULONG,BYTE),STRING
       BrowseKOIVUNEN
       SPZ_Pavad_OEM
     END
     MODULE('winla223.clw')
       GETNOM_A(STRING,BYTE,BYTE,<BYTE>),REAL
       ShowNomA(STRING)
       BrowseNolPas
     END
     MODULE('winla224.clw')
       F_PrintVesture
       CYCLEAPMAKSA(STRING),long
       OPENANSI(string,<BYTE>),BYTE
     END
     MODULE('winla225.clw')
       K_PrIeKusN
       K_RentKraj
       SPZ_Pavadi_OEM
     END
     MODULE('winla226.clw')
       SPZ_ServApgLapa(STRING)
       GETPAMAT(LONG),LONG
       CHECKKOPS(STRING,BYTE,BYTE)
     END
     MODULE('winla227.clw')
       SplitPZ(BYTE)
       N_Uzcenojums
       AI_SK_WRITE(SHORT)
     END
     MODULE('winla228.clw')
       S_MEHVISI
       S_MEH1
       S_AUTOKARTE
     END
     MODULE('winla229.clw')
       GetAutoApk(ULONG,BYTE),string
       SelftestAlga
       CHECKACCESS(LONG,STRING),LONG
     END
     MODULE('winla230.clw')
       IZZFILTK
       A_DAIEVPROT
       RW_APM_tps(BYTE)
     END
     MODULE('winla231.clw')
       B_DAK231
       SPZ_DProjIzv
       K_Kartdru
     END
     MODULE('winla232.clw')
       N_IENPT
       N_IENPTP
       GETDOK_SENR(BYTE,STRING,<ULONG>,<STRING>),STRING
     END
     MODULE('winla233.clw')
       B_ParKops
       SPZ_Akts
       GETNOM_ADRESE(STRING,BYTE),STRING
     END
     MODULE('winla234.clw')
       GETBIL_FIFO(BYTE,*DECIMAL,*DECIMAL,*DECIMAL[]),BYTE
       IZZFILTbilform 
       SPZ_Invoice
     END
     MODULE('winla235.clw')
       GetNodalas(STRING,BYTE),STRING
       B_NodKops
       GetNom_Valoda(STRING,BYTE),STRING
     END
     MODULE('winla236.clw')
       B_PVN_DEK_NEW
       B_PVN_DEK03
       N_InvAktsRez
     END
     MODULE('winla237.clw')
       N_IenIzgPZKOPS
       ConvertREDZ(STRING),STRING
       RenameFile(string,string)
     END
     MODULE('winla238.clw')
       A_IemaksasPPF
       RemoveFile(string)
       K_PRECES
     END
     MODULE('winla239.clw')
       GetVesture(ULONG,STRING,BYTE),STRING
       N_IEN_SOBJ
       N_Izg_SOBJ
     END
     MODULE('winla240.clw')
       IZZFILTPAM
       S_DARBI
       IZZFILTS
     END
     MODULE('winla241.clw')
       S_UZSKAITE
       S_NOVERT
       CHECKServiss(ULONG,<ULONG>),BYTE
     END
     MODULE('winla242.clw')
       GRAPH(BYTE,STRING)
       G_PELNA
       PAS_Izzina
     END
     MODULE('winla243.clw')
       S_LAPAS
       PAS_IzzinaKlientam
       PAS_IzzinaAuto
     END
     MODULE('winla244.clw')
       PAS_IzzinaNomenklaturai
       CHECKIBAN(string,string)
       B_PVN_DEK_MKN29
     END
     MODULE('winla245.clw')
       B_NPP2
       K_INTRASTAT(BYTE)
       B_PVN_PIE_MKN29
     END
     MODULE('winla246.clw')
       B_PVN_PIE2_MKN29
       GetIniFile(STRING,BYTE),STRING
       CYCLEKAT(string),long
     END
     MODULE('winla247.clw')
       K_VESTURE_AUTO
       F_DerTer
       B_Lasotra
     END
     MODULE('winla248.clw')
       SPZ_AtbDekl
       B_PavReg
       N_IenIzgPavReg
     END
     MODULE('winla249.clw')
       B_ObjKops
       Sel_NOM_Tips
       F_GRAFIKS
     END
     MODULE('winla250.clw')
       CYCLENODALA(STRING),LONG
       M_RealizKops
       ViewASCIIFile
     END
     MODULE('winla251.clw')
       IntMaker2
       P_PLkustiba
       GETGRUPA2(STRING,BYTE,BYTE),STRING
     END
     MODULE('winla252.clw')
       F_Sastavdalas
       A_ZinSAunIIN_969
       B_PavIzlAtsk
     END
     MODULE('winla253.clw')
       P_PLsaraksts
       K(STRING,STRING),BYTE
       GetKon_R(STRING,USHORT,BYTE,BYTE),STRING
     END
     MODULE('winla254.clw')
       B_PKIP
       INVDK(STRING),STRING
       N_ObjKops
     END
     MODULE('winla255.clw')
       GetKad_Rik(USHORT,BYTE),STRING
       GetProj_P(ULONG,BYTE),STRING
       B_Men_PPI
     END
     MODULE('winla256.clw')
       A_PERSKART 
       SPZ_DefektacijasAkts(STRING)
       FILL_ZINA(BYTE,BYTE,<LONG>),STRING
     END
     MODULE('winla257.clw')
       RW_IMP_TXT(BYTE)
       A_IzzinaparDA
       ReferFixGGIESK 
     END
     MODULE('winla258.clw')
       PerformShortcutIesk
       ANSIJOB
       GetFiltrs_Text(STRING),STRING
     END
     MODULE('winla259.clw')
       B_PVN_PIEK
       B_PVN_PIEK_MKN1028 
       RW_SER_TXT(BYTE)
     END
     MODULE('winla260.clw')
       A_PersID
       GETPARAKSTI(BYTE,BYTE,<ULONG>),STRING
       BrowseTex1
     END
     MODULE('winla261.clw')
       GETDOKDATUMS(LONG),STRING
       M_LielPPAtsk
       BrowseAU_TEX
     END
     MODULE('winla262.clw')
       UpdateAU_TEX
       F_ParID
       IZZFILTF 
     END
     MODULE('winla263.clw')
       GetFinG(BYTE,<LONG>,<LONG>,<LONG>),STRING
       GetUDL(LONG)
       W_INET(BYTE,STRING),BYTE
     END
     MODULE('winla264.clw')
       A_VSAOIIN_2009
       A_DNKUS_2009
       A_PAZ_FP1
     END
     MODULE('winla265.clw')
       A_PAZ_FPK
       B_Bilance2008
       B_PZA2008
     END
     MODULE('winla266.clw')
       B_NPP22008
       B_PKIP2008
       F_KON_R
     END
     MODULE('winla267.clw')
       B_PVN_DEK_2009
       GetArm_k(STRING,BYTE,BYTE),STRING
       GETPAM_ADRESE(ULONG),STRING
     END
     MODULE('winla268.clw')
       B_NorDokLimA
       B_PVN_DEK_KOPS
       A_APR_A
     END
     MODULE('winla269.clw')
       GETPAR_eMAIL(ULONG,BYTE,BYTE,BYTE),STRING
       M_MatNolBK
       B_PVN_03_2009
     END
     MODULE('winla270.clw')
       B_PVN_DEK_2010
       B_PVN_PIE_2010
       B_PVN_PIE2_2010
     END
     MODULE('winla271.clw')
       F_ATZ_K
       N_Mat_SNom
       CALCWL(LONG,STRING,BYTE),STRING
     END
     MODULE('winla272.clw')
       BrowsePAR_L
       UpdatePAR_L
       GETPAR_LIGUMI(ULONG,BYTE,BYTE,BYTE),STRING
     END
     MODULE('winla273.clw')
       A_RIKOJUMI
       P_NORLIN
       SelftestKadri
     END
     MODULE('winla274.clw')
       B_DEKRKOPS
       B_PVN_DEK_2011
       A_VSAOIIN_2010
     END
     MODULE('winla275.clw')
       B_PVN_PIE_2011
     END
     MODULE('winla276.clw')
       R_Skoda_xml
     END
     MODULE('winla277.clw')
       R_NOM_XLS
     END
     MODULE('winla278.clw')
       B_PVN_DEK_2013
     END
     MODULE('winla279.clw')
       B_PVN_PIE_2013_XML
     END
     MODULE('winla280.clw')
       B_PVN_PIE2_2013_XML
     END
     MODULE('winla281.clw')
       W_Pav_EDI
     END
     MODULE('winla282.clw')
       A_DNKUS_2013
     END
     MODULE('winla283.clw')
       W_Telema
     END
     MODULE('winla284.clw')
       R_TELEMA
     END
     MODULE('winla285.clw')
       F_KadruSarArApg
     END
     MODULE('winla286.clw')
       B_KasesZurnals
     END
     MODULE('winla287.clw')
       CONVERTFILE(BYTE)
     END
     MODULE('winla288.clw')
       Gita_Rikojumi
     END
     MODULE('winla289.clw')
     END
     MODULE('winla290.clw')
       BROWSEGG1_MU
     END
     MODULE('winla291.clw')
       R_EMAKS_
     END
     MODULE('winla292.clw')
       PerformShortcutForRef
     END
     MODULE('winla293.clw')
       ReferFixGG_NoKont
     END
     MODULE('winla294.clw')
       PerfAtable_NoKont(byte,string,string,string,ulong,string,ushort,ulong,string,BYTE,<LONG>),real
     END
     MODULE('winla295.clw')
       CALCSTUNDAS_PEC_GRAF(LONG,LONG,BYTE,BYTE,BYTE),USHORT
     END
     MODULE('winla296.clw')
       GETGRA(LONG,LONG),LONG
     END
     MODULE('winla298.clw')
       A_Tabele
     END
     MODULE('winla_SF.CLW')
       CheckOpen(FILE File,<BYTE OverrideCreate>,<BYTE OverrideOpenMode>)
       ReportPreview(QUEUE PrintPreviewQueue)
       Preview:JumpToPage(LONG Input:CurrentPage, LONG Input:TotalPages),LONG
       Preview:SelectDisplay(*LONG Input:PagesAcross, *LONG Input:PagesDown)
       StandardWarning(LONG WarningID),LONG,PROC
       StandardWarning(LONG WarningID,STRING WarningText1),LONG,PROC
       StandardWarning(LONG WarningID,STRING WarningText1,STRING WarningText2),LONG,PROC
       SetupStringStops(STRING ProcessLowLimit,STRING ProcessHighLimit,LONG InputStringSize,<LONG ListType>)
       NextStringStop,STRING
       SetupRealStops(REAL InputLowLimit,REAL InputHighLimit)
       NextRealStop,REAL
       INIRestoreWindow(STRING ProcedureName,STRING INIFileName)
       INISaveWindow(STRING ProcedureName,STRING INIFileName)
       RISaveError
     END
     MODULE('winla_RU.CLW')
       RIUpdate:ALGAS(BYTE=0),LONG
       RISnap:ALGAS
       RIUpdate:ALGPA(BYTE=0),LONG
       RISnap:ALGPA
       RIUpdate:AMATI(BYTE=0),LONG
       RISnap:AMATI
       RIUpdate:ARM_K(BYTE=0),LONG
       RISnap:ARM_K
       RIUpdate:ATL_K(BYTE=0),LONG
       RISnap:ATL_K
       RIUpdate:ATL_S(BYTE=0),LONG
       RISnap:ATL_S
       RIUpdate:AUTO(BYTE=0),LONG
       RISnap:AUTO
       RIUpdate:AUTOAPK(BYTE=0),LONG
       RISnap:AUTOAPK
       RIUpdate:AUTOAPK1(BYTE=0),LONG
       RISnap:AUTOAPK1
       RIUpdate:AUTODARBI(BYTE=0),LONG
       RISnap:AUTODARBI
       RIUpdate:AUTODARBI1(BYTE=0),LONG
       RISnap:AUTODARBI1
       RIUpdate:AUTOKRA(BYTE=0),LONG
       RISnap:AUTOKRA
       RIUpdate:AUTOMARKAS(BYTE=0),LONG
       RISnap:AUTOMARKAS
       RIUpdate:AUTOTEX(BYTE=0),LONG
       RISnap:AUTOTEX
       RIUpdate:AU_BILDE(BYTE=0),LONG
       RISnap:AU_BILDE
       RIUpdate:AU_TEX(BYTE=0),LONG
       RISnap:AU_TEX
       RIUpdate:BANKAS_K(BYTE=0),LONG
       RISnap:BANKAS_K
       RIUpdate:B_PAVAD(BYTE=0),LONG
       RISnap:B_PAVAD
       RIUpdate:CAL(BYTE=0),LONG
       RISnap:CAL
       RIUpdate:CENUVEST(BYTE=0),LONG
       RISnap:CENUVEST
       RIUpdate:CONFIG(BYTE=0),LONG
       RISnap:CONFIG
       RIUpdate:CROSSREF(BYTE=0),LONG
       RISnap:CROSSREF
       RIUpdate:DAIEV(BYTE=0),LONG
       RISnap:DAIEV
       RIUpdate:EIROKODI(BYTE=0),LONG
       RISnap:EIROKODI
       RIUpdate:FPNOLIK(BYTE=0),LONG
       RISnap:FPNOLIK
       RIUpdate:FPPAVAD(BYTE=0),LONG
       RISnap:FPPAVAD
       RIUpdate:G1(BYTE=0),LONG
       RISnap:G1
       RIUpdate:G2(BYTE=0),LONG
       RISnap:G2
       RIUpdate:GG(BYTE=0),LONG
       RISnap:GG
       RIUpdate:GGK(BYTE=0),LONG
       RISnap:GGK
       RIUpdate:GK1(BYTE=0),LONG
       RISnap:GK1
       RIUpdate:GK2(BYTE=0),LONG
       RISnap:GK2
       RIUpdate:GLOBAL(BYTE=0),LONG
       RISnap:GLOBAL
       RIUpdate:GRAFIKS(BYTE=0),LONG
       RISnap:GRAFIKS
       RIUpdate:GRUPA1(BYTE=0),LONG
       RISnap:GRUPA1
       RIUpdate:GRUPA2(BYTE=0),LONG
       RISnap:GRUPA2
       RIUpdate:INVENT(BYTE=0),LONG
       RISnap:INVENT
       RIUpdate:KADRI(BYTE=0),LONG
       RISnap:KADRI
       RIUpdate:KAD_RIK(BYTE=0),LONG
       RISnap:KAD_RIK
       RIUpdate:KAT_K(BYTE=0),LONG
       RISnap:KAT_K
       RIUpdate:KLUDAS(BYTE=0),LONG
       RISnap:KLUDAS
       RIUpdate:KOIVUNEN(BYTE=0),LONG
       RISnap:KOIVUNEN
       RIUpdate:KOMPLEKT(BYTE=0),LONG
       RISnap:KOMPLEKT
       RIUpdate:KON_K(BYTE=0),LONG
       RISnap:KON_K
       RIUpdate:KON_R(BYTE=0),LONG
       RISnap:KON_R
       RIUpdate:KURSI_K(BYTE=0),LONG
       RISnap:KURSI_K
       RIUpdate:MER_K(BYTE=0),LONG
       RISnap:MER_K
       RIUpdate:NODALAS(BYTE=0),LONG
       RISnap:NODALAS
       RIUpdate:NOLI1(BYTE=0),LONG
       RISnap:NOLI1
       RIUpdate:NOLIK(BYTE=0),LONG
       RISnap:NOLIK
       RIUpdate:NOLPAS(BYTE=0),LONG
       RISnap:NOLPAS
       RIUpdate:NOL_FIFO(BYTE=0),LONG
       RISnap:NOL_FIFO
       RIUpdate:NOL_KOPS(BYTE=0),LONG
       RISnap:NOL_KOPS
       RIUpdate:NOL_STAT(BYTE=0),LONG
       RISnap:NOL_STAT
       RIUpdate:NOM_A(BYTE=0),LONG
       RISnap:NOM_A
       RIUpdate:NOM_C(BYTE=0),LONG
       RISnap:NOM_C
       RIUpdate:NOM_K(BYTE=0),LONG
       RISnap:NOM_K
       RIUpdate:NOM_K1(BYTE=0),LONG
       RISnap:NOM_K1
       RIUpdate:NOM_N(BYTE=0),LONG
       RISnap:NOM_N
       RIUpdate:NOM_P(BYTE=0),LONG
       RISnap:NOM_P
       RIUpdate:OUTFILE(BYTE=0),LONG
       RISnap:OUTFILE
       RIUpdate:OUTFILEANSI(BYTE=0),LONG
       RISnap:OUTFILEANSI
       RIUpdate:PAMAM(BYTE=0),LONG
       RISnap:PAMAM
       RIUpdate:PAMAT(BYTE=0),LONG
       RISnap:PAMAT
       RIUpdate:PAMKAT(BYTE=0),LONG
       RISnap:PAMKAT
       RIUpdate:PAM_P(BYTE=0),LONG
       RISnap:PAM_P
       RIUpdate:PAROLES(BYTE=0),LONG
       RISnap:PAROLES
       RIUpdate:PAR_A(BYTE=0),LONG
       RISnap:PAR_A
       RIUpdate:PAR_E(BYTE=0),LONG
       RISnap:PAR_E
       RIUpdate:PAR_K(BYTE=0),LONG
       RISnap:PAR_K
       RIUpdate:PAR_K1(BYTE=0),LONG
       RISnap:PAR_K1
       RIUpdate:PAR_L(BYTE=0),LONG
       RISnap:PAR_L
       RIUpdate:PAR_Z(BYTE=0),LONG
       RISnap:PAR_Z
       RIUpdate:PAVA1(BYTE=0),LONG
       RISnap:PAVA1
       RIUpdate:PAVAD(BYTE=0),LONG
       RISnap:PAVAD
       RIUpdate:PAVPAS(BYTE=0),LONG
       RISnap:PAVPAS
       RIUpdate:PERNOS(BYTE=0),LONG
       RISnap:PERNOS
       RIUpdate:PROJEKTI(BYTE=0),LONG
       RISnap:PROJEKTI
       RIUpdate:PROJ_P(BYTE=0),LONG
       RISnap:PROJ_P
       RIUpdate:SYSTEM(BYTE=0),LONG
       RISnap:SYSTEM
       RIUpdate:TEKSTI(BYTE=0),LONG
       RISnap:TEKSTI
       RIUpdate:TEKSTI1(BYTE=0),LONG
       RISnap:TEKSTI1
       RIUpdate:TEK_K(BYTE=0),LONG
       RISnap:TEK_K
       RIUpdate:TEK_SER(BYTE=0),LONG
       RISnap:TEK_SER
       RIUpdate:VAL_K(BYTE=0),LONG
       RISnap:VAL_K
       RIUpdate:VESTURE(BYTE=0),LONG
       RISnap:VESTURE
       RIUpdate:ZURFILE(BYTE=0),LONG
       RISnap:ZURFILE
       RIUpdate:ZURNALS(BYTE=0),LONG
       RISnap:ZURNALS
       RIUpdate:ATL_K:ATL_S,LONG
       RIUpdate:GRUPA1:GRUPA2,LONG
       RIUpdate:NOM_K:KOMPLEKT,LONG
       RIUpdate:PAMAT:PAMAM,LONG
     END
     MODULE('winla_RD.CLW')
       RIDelete:ALGAS,LONG
       RIDelete:ALGPA,LONG
       RIDelete:AMATI,LONG
       RIDelete:ARM_K,LONG
       RIDelete:ATL_K,LONG
       RIDelete:ATL_S,LONG
       RIDelete:AUTO,LONG
       RIDelete:AUTOAPK,LONG
       RIDelete:AUTOAPK1,LONG
       RIDelete:AUTODARBI,LONG
       RIDelete:AUTODARBI1,LONG
       RIDelete:AUTOKRA,LONG
       RIDelete:AUTOMARKAS,LONG
       RIDelete:AUTOTEX,LONG
       RIDelete:AU_BILDE,LONG
       RIDelete:AU_TEX,LONG
       RIDelete:BANKAS_K,LONG
       RIDelete:B_PAVAD,LONG
       RIDelete:CAL,LONG
       RIDelete:CENUVEST,LONG
       RIDelete:CONFIG,LONG
       RIDelete:CROSSREF,LONG
       RIDelete:DAIEV,LONG
       RIDelete:EIROKODI,LONG
       RIDelete:FPNOLIK,LONG
       RIDelete:FPPAVAD,LONG
       RIDelete:G1,LONG
       RIDelete:G2,LONG
       RIDelete:GG,LONG
       RIDelete:GGK,LONG
       RIDelete:GK1,LONG
       RIDelete:GK2,LONG
       RIDelete:GLOBAL,LONG
       RIDelete:GRAFIKS,LONG
       RIDelete:GRUPA1,LONG
       RIDelete:GRUPA2,LONG
       RIDelete:INVENT,LONG
       RIDelete:KADRI,LONG
       RIDelete:KAD_RIK,LONG
       RIDelete:KAT_K,LONG
       RIDelete:KLUDAS,LONG
       RIDelete:KOIVUNEN,LONG
       RIDelete:KOMPLEKT,LONG
       RIDelete:KON_K,LONG
       RIDelete:KON_R,LONG
       RIDelete:KURSI_K,LONG
       RIDelete:MER_K,LONG
       RIDelete:NODALAS,LONG
       RIDelete:NOLI1,LONG
       RIDelete:NOLIK,LONG
       RIDelete:NOLPAS,LONG
       RIDelete:NOL_FIFO,LONG
       RIDelete:NOL_KOPS,LONG
       RIDelete:NOL_STAT,LONG
       RIDelete:NOM_A,LONG
       RIDelete:NOM_C,LONG
       RIDelete:NOM_K,LONG
       RIDelete:NOM_K1,LONG
       RIDelete:NOM_N,LONG
       RIDelete:NOM_P,LONG
       RIDelete:OUTFILE,LONG
       RIDelete:OUTFILEANSI,LONG
       RIDelete:PAMAM,LONG
       RIDelete:PAMAT,LONG
       RIDelete:PAMKAT,LONG
       RIDelete:PAM_P,LONG
       RIDelete:PAROLES,LONG
       RIDelete:PAR_A,LONG
       RIDelete:PAR_E,LONG
       RIDelete:PAR_K,LONG
       RIDelete:PAR_K1,LONG
       RIDelete:PAR_L,LONG
       RIDelete:PAR_Z,LONG
       RIDelete:PAVA1,LONG
       RIDelete:PAVAD,LONG
       RIDelete:PAVPAS,LONG
       RIDelete:PERNOS,LONG
       RIDelete:PROJEKTI,LONG
       RIDelete:PROJ_P,LONG
       RIDelete:SYSTEM,LONG
       RIDelete:TEKSTI,LONG
       RIDelete:TEKSTI1,LONG
       RIDelete:TEK_K,LONG
       RIDelete:TEK_SER,LONG
       RIDelete:VAL_K,LONG
       RIDelete:VESTURE,LONG
       RIDelete:ZURFILE,LONG
       RIDelete:ZURNALS,LONG
       RIDelete:ALGPA:ALGAS,LONG,PRIVATE
       RIDelete:ATL_K:ATL_S,LONG,PRIVATE
       RIDelete:AUTOAPK:AUTODARBI,LONG,PRIVATE
       RIDelete:AUTOAPK:AUTOTEX,LONG,PRIVATE
       RIDelete:FPPAVAD:FPNOLIK,LONG,PRIVATE
       RIDelete:GG:GGK,LONG,PRIVATE
       RIDelete:GRUPA1:GRUPA2,LONG,PRIVATE
       RIDelete:NOL_KOPS:NOL_FIFO,LONG,PRIVATE
       RIDelete:NOM_K:KOMPLEKT,LONG,PRIVATE
       RIDelete:PAMAT:PAMAM,LONG,PRIVATE
       RIDelete:PAVAD:AUTOAPK,LONG,PRIVATE
       RIDelete:PAVAD:AUTOTEX,LONG,PRIVATE
       RIDelete:PAVAD:NOLIK,LONG,PRIVATE
       RIDelete:PAVPAS:NOLPAS,LONG,PRIVATE
     END
     
      MODULE('Kernel32.DLL')
         sndPlaySoundA(*LPCSTR,UNSIGNED),BOOL,PROC,pascal,raw
         CreateDirectoryA(*LPCSTR,*SECURITY_ATTRIBUTES),BOOL,PASCAL,RAW
         MemoryRead(WORD,DWORD,LPVOID,DWORD),DWORD,PASCAL
         CopyFileA(*LPCSTR,*LPCSTR,BOOL),BOOL,PASCAL,RAW
         MoveFileA(*LPCSTR,*LPCSTR),BOOL,PASCAL,RAW
         GetVersion(),DWORD,PASCAL
     !    GetCommConfig(HANDLE,*COMMCONFIG,*DWORD),BOOL,PASCAL
     !    SetCommConfig(HANDLE,*COMMCONFIG,DWORD),BOOL,PASCAL,RAW
     !    CreateFileA(*LPCSTR,DWORD,DWORD,*SECURITY_ATTRIBUTES,DWORD,DWORD,UNSIGNED),SIGNED,PASCAL,RAW
     !    GetLastError(),DWORD,PASCAL
     !    GetCommTimeouts(HANDLE,*COMMTIMEOUTS),BOOL,PASCAL,RAW
     !    SetCommTimeouts(HANDLE,*COMMTIMEOUTS),BOOL,PASCAL,RAW
     !    ReadFile(HANDLE,*RBUFFER,DWORD,*DWORD,*OVERLAPPED),BOOL,PASCAL,RAW
     !    WriteFile(HANDLE,*LPCSTR,DWORD,*DWORD,*OVERLAPPED),BOOL,PASCAL,RAW
     !    CloseHandle(HANDLE),BOOL,PASCAL
      END
     ! MODULE('GA1.DLL')                     !%%%% removed as ga1.dll is missing
     !      LabelConfig(),SHORT,C,RAW,DLL    !%%%% removed as ga1.dll is missing
     !      LabelNomenklatura(*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,SHORT,SHORT),SHORT,C,RAW,DLL   !%%%% removed as ga1.dll is missing
     !      LabelPartneris(*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,SHORT),SHORT,C,RAW,DLL         !%%%% removed as ga1.dll is missing
     ! END                                                                                !%%%% removed as ga1.dll is missing
     ! MODULE('TRACE.DLL')
     !      OpenPort(*LPCSTR),SHORT,C,RAW,DLL(1)
     !      BeginJob(SHORT,SHORT,SHORT,SHORT,SHORT,SHORT),SHORT,C,RAW,DLL(1)
     !      ecTextOut(SHORT,SHORT,*LPCSTR,*LPCSTR),SHORT,PASCAL,RAW,DLL(1)
     !      PrintBar(*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR),SHORT,PASCAL,RAW,DLL(1)
     !      EndJob(),SHORT,PASCAL,RAW,DLL
     !      ClosePort(),SHORT,PASCAL,RAW,DLL
     ! END
     !   GETFISCALDATA(SHORT,*LPCSTR),SHORT,PASCAL,RAW,DLL(1)
     
      module('IQxml.dll')
            XML:LoadFromString(*CSTRING,<BYTE>,<BYTE>),SHORT,DLL(DLL_MODE)
            XML:LoadFromFile(STRING,<BYTE>,<BYTE>),SHORT,DLL(DLL_MODE)
            XML:Free(),DLL(DLL_MODE)
            XML:DebugQueue(<STRING>),DLL(DLL_MODE)
            XML:LoadQueue(*QUEUE,<BYTE>,<BYTE>,<BYTE>),BYTE,DLL(DLL_MODE)
            XML:FindNextNode(STRING,<STRING>,<STRING>,<STRING>,<STRING>),SHORT,DLL(DLL_MODE)
            XML:FindNextContent(STRING,BYTE,BYTE),SHORT,DLL(DLL_MODE)
            XML:ReadNextRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)
            XML:ReadPreviousRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)
            XML:ReadCurrentRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)
     
            XML:GotoSibling(),SHORT,DLL(DLL_MODE)
            XML:GotoParent(),SHORT,DLL(DLL_MODE)
            XML:GotoChild(),SHORT,DLL(DLL_MODE)
     
            XML:GotoTop(),DLL(DLL_MODE)
            XML:GetPointer(),LONG,DLL(DLL_MODE)
            XML:SetPointer(LONG),SHORT,DLL(DLL_MODE)
            XML:SaveState(),SHORT,DLL(DLL_MODE)
            XML:RestoreState(SHORT),SHORT,DLL(DLL_MODE)
            XML:FreeState(SHORT),DLL(DLL_MODE)
            XML:PrimaryKeyCascade(STRING,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>),DLL(DLL_MODE)
            XML:PrimaryKeyClear(),DLL(DLL_MODE)
            XML:PrimaryFieldCascade(STRING,STRING),DLL(DLL_MODE)
            XML:PrimaryFieldClear(),DLL(DLL_MODE)    
            XML:QualifyFieldSet(STRING,<BYTE>),DLL(DLL_MODE)
            XML:QualifyFieldClear(<STRING>),DLL(DLL_MODE)
            XML:AttributeFieldSet(STRING,<BYTE>,<STRING>),DLL(DLL_MODE)
            XML:AttributeFieldClear(<STRING>),DLL(DLL_MODE)
            XML:AutoRootSet(),DLL(DLL_MODE)
            XML:AutoRootClear(),DLL(DLL_MODE)
            XML:GetError(<SHORT>),STRING,DLL(DLL_MODE)
            XML:ViewFile(STRING),DLL(DLL_MODE)
            XML:DebugMyQueue(*QUEUE,<STRING>),DLL(DLL_MODE)
            XML:SkipDebug(BYTE),DLL(DLL_MODE)
            XML:PickFileToDebug(),DLL(DLL_MODE)  
            XML:SetProgressWindow(ULONG,<STRING>),DLL(DLL_MODE)
      end
      
     
   END


CLIENT   STRING(45)
XMLFILENAME   CSTRING(200)
Val_uzsk   STRING(3)
CL_NR   USHORT
BASE_SK   BYTE
NOL_SK   BYTE
FP_SK   BYTE
ALGU_SK   BYTE
PAM_SK   BYTE
LM_SK   BYTE
REG_NOL_ACC   BYTE
REG_BASE_ACC   BYTE
GNET   BYTE
JOB_NR   BYTE
LOC_NR   BYTE
ACC_KODS   STRING(8)
ACC_KODS_N   USHORT
USERFOLDER   CSTRING(100)
DOCFOLDER   CSTRING(100)
DOCFOLDERK   CSTRING(100)
DOCFOLDERP   CSTRING(100)
GGNAME   CSTRING(60)
DZNAME   CSTRING(60)
DZFNAME   CSTRING(60)
GGKNAME   CSTRING(60)
PAVADNAME   CSTRING(60)
NOLIKNAME   CSTRING(60)
FPPAVADNAME   CSTRING(60)
FPNOLIKNAME   CSTRING(60)
PAMATNAME   CSTRING(60)
PAMKATNAME   CSTRING(60)
PAMAMNAME   CSTRING(60)
ALGASNAME   CSTRING(60)
ALPANAME   CSTRING(60)
TEXNAME   CSTRING(60)
INVNAME   CSTRING(60)
PARNAME   CSTRING(60)
NOMNAME   CSTRING(60)
KONRNAME   CSTRING(60)
FILENAME1   CSTRING(60)
FILENAME2   CSTRING(60)
DOSNAME   CSTRING(60)
ASCIIFileName   CSTRING(80)
ANSIFileName   CSTRING(60)
B_PAVADNAME   CSTRING(60)
AAPKNAME   CSTRING(60)
ADARBINAME   CSTRING(60)
AUBNAME   CSTRING(60)
AUBTEXNAME   CSTRING(60)
AUDNAME   CSTRING(60)
ATEXNAME   CSTRING(60)
ATLAUTS   STRING(159)
DUP_NOM_KODS   BYTE
PRINT_EAN   BYTE
F:PVN_T   STRING(1)
F:PVN_P   BYTE
F:IDP   STRING(1)
F:DTK   STRING(1)
F:NOA   STRING(1)
F:ATL   STRING(3)
F:SECIBA   STRING(1)
F:KRI   STRING(1)
F:CEN   STRING(1)
F:PAK   STRING(1)
F:IeklautPK   STRING(1)
F:LIELMAZ   STRING(1)
F:DBF   STRING(1)
F:XML   STRING(1)
F:ATBILDIGAIS   BYTE
F:NODALA   STRING(2)
F:OBJ_NR   ULONG
F:VALODA   STRING(1)
F:KAT_NR   STRING(3)
F:KONTI   STRING(1)
F:NOT_GRUPA   STRING(1)
F:DIENA   STRING(1)
F:X   BYTE
F:ATZIME   BYTE
OPCIJA   STRING(30)
RS   STRING(1)
GADS   ULONG
DB_GADS   LONG
DB_S_DAT   LONG
DB_B_DAT   LONG
DB_FGK   BYTE
MEN_NR   BYTE
NOL_NR25   BYTE,DIM(25)
MenesisunG   STRING(30)
menesu_skaits   BYTE
MINMAXSUMMA   DECIMAL(8,2)
NOMENKLAT   STRING(21)
ID   USHORT
DAIKODS   USHORT
DAIF   STRING(3)
PVNMAS   DECIMAL(13,2),DIM(14,6)
PVNMASMODE   BYTE
PAR_GRUPA   STRING(7)
DAV_GRUPA   STRING(4)
PAR_NR   ULONG
PAR_TIPS   STRING(6)
ADR_NR   ULONG
NOM_TIPS7   STRING(7)
AUT_NR   ULONG
TEK_INI   STRING(15)
NOKL_CP   BYTE
NOKL_CA   BYTE
NOKL_C1   BYTE
NOKL_C2   BYTE
NOKL_B   BYTE
val_nos   STRING(3)
val_LV   STRING(3)
summa   DECIMAL(11,2)
KKK   STRING(5)
KKK1   STRING(5)
KKK2   STRING(5)
d_k   STRING(1)
D_K1   STRING(1)
D_K2   STRING(1)
pvn_proc   BYTE
PVN_TIPS   STRING(1)
kor_konts   STRING(5),DIM(20)
KOR_NODALA   STRING(2),DIM(20)
kor_summa   DECIMAL(10,2),DIM(20)
KOR_VAL   STRING(3),DIM(20)
KOR_PVN_PROC   STRING(2),DIM(20)
S_DAT   LONG
B_DAT   LONG
SAV_DATUMS   LONG
REK   STRING(21)
KOR   STRING(15)
BVAL   STRING(3)
BANKA   STRING(31)
BKODS   STRING(11)
BSPEC   STRING(31)
BINDEX   STRING(7)
bilance   DECIMAL(11,2)
klu_darbiba   BYTE
TEKSTS   STRING(250)
F_TEKSTS   CSTRING(201),DIM(3)
pr:skaits   BYTE
pr:lapa:no   USHORT
pr:lapa:lidz   USHORT
copyrequest   BYTE
APSKATIT231531   BYTE
MAINIT231531   BYTE
BROWSEPAR_K::USED   BYTE
Browse::SelectRecord   BYTE
OPCIJA_NR   BYTE
DIENAS   LONG
DIENASIGN   LONG
PERIODS   LONG
REALMAS   DECIMAL(10,4),DIM(4)
WBUFFER   CSTRING(20)
A_TIME   LONG
Last_nom_tab   BYTE
Last_par_tab   BYTE
ECR_FOUND   BYTE
PAV::U_NR   ULONG
GG::U_NR   ULONG
CHILDCHANGED   BYTE
T_POSITION   STRING(255)
EXCEL   CSTRING(100)
WORD   CSTRING(100)
ARJ   CSTRING(100)
OUTLOOK   CSTRING(100)
PDF   CSTRING(100)
JPG   CSTRING(100)
VIETA_NR   BYTE
SYS_PARAKSTS_NR   BYTE
UDL_S   LONG
UDL_B   LONG
EUR_P   BYTE
RIK_TIPS   STRING(1)
Glo:iQErrorMessageText   STRING(128)

SaveErrorCode        LONG
SaveError            CSTRING(255)
SaveFileErrorCode    LONG
SaveFileError        CSTRING(255)
GlobalRequest        LONG(0),THREAD
GlobalResponse       LONG(0),THREAD
VCRRequest           LONG(0),THREAD
lCurrentFDSetting    LONG
lAdjFDSetting        LONG
KLUDAS                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('\winlats\bin\kludas'),PRE(KLU),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(KLU:NR),NOCASE
Record                   RECORD,PRE()
NR                          DECIMAL(3)
DARBIBA                     DECIMAL(1)
KARTIBA                     DECIMAL(1)
KOMENT                      STRING(70)
                         END
                       END
KLUDAS::Used         LONG,THREAD

PAR_E                   FILE,DRIVER('TOPSPEED'),RECLAIM,PRE(EMA),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(EMA:PAR_NR,EMA:EMA_NR),NOCASE,OPT
Record                   RECORD,PRE()
PAR_NR                      ULONG
EMA_NR                      BYTE
EMAIL                       STRING(30)
AMATS                       STRING(20)
KONTAKTS                    STRING(25)
                         END
                       END
PAR_E::Used          LONG,THREAD

AMATI                   FILE,DRIVER('TOPSPEED'),PRE(AMS),CREATE,BINDABLE,THREAD
AMS_KEY                  KEY(AMS:AMA_A),DUP,NOCASE,OPT
Record                   RECORD,PRE()
AMATS                       STRING(25)
AMA_A                       STRING(5)
NODALA                      STRING(2)
OBJ_NR                      ULONG
S_A                         STRING(1)
BAITS                       BYTE
                         END
                       END
AMATI::Used          LONG,THREAD

PAR_A                   FILE,DRIVER('TOPSPEED'),RECLAIM,PRE(ADR),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(ADR:PAR_NR,ADR:ADR_NR),NOCASE,OPT
Record                   RECORD,PRE()
PAR_NR                      ULONG
ADR_NR                      BYTE
TIPS                        STRING(1)
GRUPA                       STRING(6)
ADRESE                      STRING(60)
KONTAKTS                    STRING(25)
DARBALAIKS                  STRING(25)
TELEFAX                     STRING(25)
                         END
                       END
PAR_A::Used          LONG,THREAD

OUTFILE                 FILE,DRIVER('ASCII'),OEM,NAME(ASCIIFILENAME),PRE(OUT),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
LINE                        STRING(500)
                         END
                       END
OUTFILE::Used        LONG,THREAD

GRAFIKS                 FILE,DRIVER('TOPSPEED'),RECLAIM,PRE(GRA),CREATE,BINDABLE,THREAD
INI_KEY                  KEY(GRA:INI,GRA:YYYYMM),DUP,NOCASE,OPT
YYYYMM_KEY               KEY(GRA:YYYYMM,GRA:ID),DUP,NOCASE,OPT
ID_DAT                   KEY(GRA:ID,GRA:YYYYMM),DUP,NOCASE,OPT
Record                   RECORD,PRE()
YYYYMM                      LONG
ID                          USHORT
INI                         STRING(15)
G                           STRING(1),DIM(31,48)
DIENA                       DECIMAL(4,1)
NAKTS                       DECIMAL(4,1)
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
GRAFIKS::Used        LONG,THREAD

KON_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('KON_K'),PRE(KON),CREATE,BINDABLE,THREAD
BKK_KEY                  KEY(KON:BKK),NOCASE,OPT
GNET_KEY                 KEY(KON:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
BKK                         STRING(5)
ALT_BKK                     STRING(6)
NOSAUKUMS                   STRING(95)
NOSAUKUMSA                  STRING(95)
VAL                         STRING(3)
PVND                        USHORT,DIM(2)
PVNK                        USHORT,DIM(2)
PZB                         USHORT,DIM(4)
NPP2                        USHORT,DIM(4)
NPPF                        STRING(4)
PKIP                        USHORT,DIM(3)
PKIF                        STRING(3)
ATLIKUMS                    DECIMAL(11,2),DIM(15)
BAITS                       BYTE
GNET_FLAG                   STRING(2)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
KON_K::Used          LONG,THREAD

ATL_S                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('ATL_S'),PRE(ATS),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(ATS:U_NR,ATS:NOMENKLAT),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        USHORT
NOMENKLAT                   STRING(21)
ATL_PROC                    DECIMAL(4,1)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
ATL_S::Used          LONG,THREAD

BANKAS_K                FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('BANKAS_K'),PRE(BAN),CREATE,BINDABLE,THREAD
KOD_KEY                  KEY(BAN:KODS),NOCASE
NOS_KEY                  KEY(BAN:NOS_A),DUP,NOCASE
GNET_KEY                 KEY(BAN:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
NOS_P                       STRING(31)
NOS_S                       STRING(15)
NOS_A                       STRING(4)
INDEX                       STRING(7)
KODS                        STRING(15)
KOR_K                       STRING(11)
ADRESE1                     STRING(31)
ADRESE2                     STRING(31)
SPEC                        STRING(31)
MAKSAJUMA_TAKA              STRING(55)
GNET_FLAG                   STRING(2)
BAITS                       BYTE
                         END
                       END
BANKAS_K::Used       LONG,THREAD

GLOBAL                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('GLOBAL'),PRE(GL),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
REG_NR                      STRING(11)
VID_NR                      STRING(13)
SOC_NR                      STRING(7)
VID_NOS                     STRING(25)
VID_LNR                     STRING(6)
NACE                        USHORT
ADRESE                      STRING(60)
FMI_TIPS                    STRING(4)
MAU_NR                      ULONG
KIE_NR                      ULONG
KIZ_NR                      ULONG
IESK_NR                     ULONG
REK_NR                      ULONG
PIL_NR                      ULONG
INVOICE_NR                  ULONG
GARANT_NR                   ULONG
RIK_NR                      ULONG
FREE_N                      ULONG
EAN_NR                      DECIMAL(13)
BKODS                       STRING(15),DIM(10)
REK                         STRING(34),DIM(10)
KOR                         STRING(11),DIM(10)
BKK                         STRING(5),DIM(10)
D_DATUMS                    LONG
D_LAIKS                     LONG
DB_GADS                     DECIMAL(4)
DB_S_DAT                    LONG
DB_B_DAT                    LONG
CLIENT_U_NR                 ULONG
VIDPVN_U_NR                 ULONG
FREE_U_NR                   ULONG
BAITS                       BYTE
BAITS1                      BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
GLOBAL::Used         LONG,THREAD

AUTOTEX                 FILE,DRIVER('TOPSPEED'),NAME(ATEXNAME),PRE(APX),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(APX:PAV_NR),DUP,NOCASE,OPT
Record                   RECORD,PRE()
PAV_NR                      ULONG
PAZIME                      STRING(1)
TEKSTS                      STRING(110)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
AUTOTEX::Used        LONG,THREAD

AUTOAPK1                FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(FILENAME1),PRE(APK1),CREATE,BINDABLE,THREAD
PAV_KEY                  KEY(APK1:PAV_NR),DUP,NOCASE,OPT
DAT_KEY                  KEY(-APK1:DATUMS),DUP,NOCASE,OPT
PAR_KEY                  KEY(APK1:PAR_NR),DUP,NOCASE,OPT
AUT_KEY                  KEY(APK1:AUT_NR,-APK1:DATUMS),DUP,NOCASE,OPT
Record                   RECORD,PRE()
PAV_NR                      ULONG
PAR_NR                      ULONG
AUT_NR                      ULONG
DATUMS                      LONG
PIEN_DAT                    LONG
PLKST                       LONG
Nobraukums                  DECIMAL(7)
CTRL_DATUMS                 LONG
TEKSTS                      STRING(50)
SAVIRZE_P                   DECIMAL(4,2)
SAVIRZE_A                   DECIMAL(4,2)
AMORT_P                     DECIMAL(3),DIM(2)
AMORT_A                     DECIMAL(3),DIM(2)
BREMZES_P                   DECIMAL(3,1),DIM(2)
BREMZES_A                   DECIMAL(3,1),DIM(2)
KAROGI                      STRING(1),DIM(80)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
Diag_TEX                    STRING(50)
                         END
                       END
AUTOAPK1::Used       LONG,THREAD

KURSI_K                 FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('KURSI_K'),PRE(KUR),CREATE,BINDABLE,THREAD
NOS_KEY                  KEY(KUR:VAL,KUR:DATUMS),OPT
DAT_KEY                  KEY(KUR:DATUMS,KUR:VAL),DUP,OPT
GNET_KEY                 KEY(KUR:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
VAL                         STRING(3)
DATUMS                      LONG
KURSS                       DECIMAL(12,7)
TIPS                        STRING(1)
LB                          STRING(1)
GNET_FLAG                   STRING(2)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
KURSI_K::Used        LONG,THREAD

AUTODARBI1              FILE,DRIVER('TOPSPEED'),NAME(FILENAME1),PRE(APD1),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(APD1:PAV_NR),DUP,NOCASE,OPT
DAT_KEY                  KEY(APD1:DATUMS),DUP,NOCASE,OPT
ID_KEY                   KEY(APD1:ID,APD1:DATUMS),DUP,NOCASE,OPT
Record                   RECORD,PRE()
PAV_NR                      ULONG
DATUMS                      LONG
ID                          USHORT
NOMENKLAT                   STRING(21)
LAIKS                       DECIMAL(7,2)
GARANTIJA                   LONG
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
AUTODARBI1::Used     LONG,THREAD

AUTODARBI               FILE,DRIVER('TOPSPEED'),NAME(ADARBINAME),PRE(APD),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(APD:PAV_NR),DUP,NOCASE,OPT
DAT_KEY                  KEY(APD:DATUMS),DUP,NOCASE,OPT
ID_KEY                   KEY(APD:ID,APD:DATUMS),DUP,NOCASE,OPT
Record                   RECORD,PRE()
PAV_NR                      ULONG
DATUMS                      LONG
ID                          USHORT
NOMENKLAT                   STRING(21)
LAIKS                       DECIMAL(7,2)
GARANTIJA                   LONG
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
AUTODARBI::Used      LONG,THREAD

VAL_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('VAL_K'),PRE(VAL),CREATE,BINDABLE,THREAD
NOS_KEY                  KEY(VAL:VAL),OPT
KODS_KEY                 KEY(VAL:V_KODS),NOCASE,OPT
GNET_KEY                 KEY(VAL:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
VAL                         STRING(3)
V_KODS                      STRING(2)
VALSTS                      STRING(20)
VALSTS_A                    STRING(20)
DZIMTE                      STRING(1)
RUBLI                       STRING(20)
RUBLI_A                     STRING(20)
KAPIKI                      STRING(7)
KAPIKI_A                    STRING(7)
BKK                         STRING(5)
BKKK                        STRING(5)
Tips                        STRING(1)
TEST                        DECIMAL(14,10)
GNET_FLAG                   STRING(2)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
VAL_K::Used          LONG,THREAD

GG                      FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(GGNAME),PRE(GG),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(GG:U_NR),NOCASE,OPT
DAT_KEY                  KEY(-GG:DATUMS,-GG:SECIBA),DUP,NOCASE
Record                   RECORD,PRE()
U_NR                        ULONG
RS                          STRING(1)
ES                          DECIMAL(1)
IMP_NR                      DECIMAL(3)
TIPS                        BYTE
DOK_SENR                    STRING(14)
ATT_DOK                     STRING(1)
APMDAT                      LONG
DOKDAT                      LONG
DATUMS                      LONG
NOKA                        STRING(15)
PAR_NR                      ULONG
SATURS                      STRING(47)
SATURS2                     STRING(47)
SATURS3                     STRING(47)
SUMMA                       DECIMAL(11,2)
VAL                         STRING(3)
Atlaide                     DECIMAL(3,1)
KEKSIS                      BYTE
BAITS                       BYTE
SECIBA                      LONG
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
GG::Used             LONG,THREAD

AU_TEX                  FILE,DRIVER('TOPSPEED'),NAME(AUBTEXNAME),PRE(AUX),CREATE,BINDABLE,THREAD
AUT_KEY                  KEY(AUX:AUT_TEXT),DUP,NOCASE,OPT
Record                   RECORD,PRE()
AUT_TEXT                    STRING(10)
DATUMS                      LONG
PAR_NOS_P                   STRING(35)
PAR_TEL                     STRING(25)
PAR_AUT0                    STRING(30)
SATURS1                     STRING(45)
SATURS2                     STRING(45)
SATURS3                     STRING(45)
BAITS                       BYTE
                         END
                       END
AU_TEX::Used         LONG,THREAD

G1                      FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(FILENAME1),PRE(G1),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(G1:U_NR),NOCASE,OPT
DAT_KEY                  KEY(-G1:DATUMS,-G1:SECIBA),DUP,NOCASE
Record                   RECORD,PRE()
U_NR                        ULONG
RS                          STRING(1)
ES                          DECIMAL(1)
IMP_NR                      DECIMAL(3)
TIPS                        BYTE
DOK_SENR                    STRING(14)
ATT_DOK                     STRING(1)
APMDAT                      LONG
DOKDAT                      LONG
DATUMS                      LONG
NOKA                        STRING(15)
PAR_NR                      ULONG
SATURS                      STRING(47)
SATURS2                     STRING(47)
SATURS3                     STRING(47)
SUMMA                       DECIMAL(11,2)
VAL                         STRING(3)
ATLAIDE                     DECIMAL(3,1)
KEKSIS                      BYTE
BAITS                       BYTE
SECIBA                      LONG
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
G1::Used             LONG,THREAD

VESTURE                 FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('VESTURE'),PRE(VES),CREATE,BINDABLE,THREAD
CRM_KEY                  KEY(VES:CRM,-VES:DATUMS,-VES:SECIBA),DUP,NOCASE
DAT_KEY                  KEY(VES:PAR_NR,-VES:DATUMS,-VES:SECIBA),DUP,NOCASE
PAR_KEY                  KEY(VES:PAR_NR,VES:DATUMS),DUP,NOCASE,OPT
REF_KEY                  KEY(VES:PAR_NR,VES:DOK_SENR),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CRM                         BYTE
KAM                         USHORT
RS                          STRING(1)
PROCESS                     BYTE
DOK_SENR                    STRING(14)
APMDAT                      LONG
DOKDAT                      LONG
DATUMS                      LONG
SECIBA                      ULONG
PAR_NR                      ULONG
SATURS                      STRING(47)
SATURS2                     STRING(47)
SATURS3                     STRING(47)
SUMMA                       DECIMAL(11,2)
Atlaide                     DECIMAL(3,1)
VAL                         STRING(3)
D_K_KONTS                   STRING(5)
Samaksats                   DECIMAL(11,2)
SAM_VAL                     STRING(3)
Sam_datums                  LONG
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
VESTURE::Used        LONG,THREAD

GGK                     FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(GGKNAME),PRE(GGK),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(GGK:U_NR,GGK:BKK),DUP,NOCASE,OPT
DAT_KEY                  KEY(GGK:DATUMS,GGK:U_NR,GGK:D_K),DUP,NOCASE,OPT
BKK_DAT                  KEY(GGK:BKK,GGK:DATUMS,GGK:U_NR),DUP,NOCASE,OPT
PAR_KEY                  KEY(GGK:PAR_NR,GGK:DATUMS,GGK:U_NR),DUP,NOCASE,OPT
PARDAT_KEY               KEY(GGK:PAR_NR,-GGK:DATUMS,-GGK:U_NR),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
RS                          STRING(1)
DATUMS                      LONG
PAR_NR                      ULONG
REFERENCE                   STRING(14)
BKK                         STRING(5)
D_K                         STRING(1)
SUMMA                       DECIMAL(11,2)
SUMMAV                      DECIMAL(11,2)
VAL                         STRING(3)
PVN_PROC                    BYTE
PVN_TIPS                    STRING(1)
BAITS                       BYTE
KK                          BYTE
NODALA                      STRING(2)
OBJ_NR                      ULONG
                         END
                       END
GGK::Used            LONG,THREAD

GK1                     FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(FILENAME2),PRE(GK1),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(GK1:U_NR,GK1:BKK),DUP,NOCASE,OPT
DAT_KEY                  KEY(GK1:DATUMS,GK1:U_NR,GK1:D_K),DUP,NOCASE,OPT
BKK_DAT                  KEY(GK1:BKK,GK1:DATUMS,GK1:U_NR),DUP,NOCASE,OPT
PAR_KEY                  KEY(GK1:PAR_NR,GK1:DATUMS,GK1:U_NR),DUP,NOCASE,OPT
PARDAT_KEY               KEY(GK1:PAR_NR,-GK1:DATUMS,-GK1:U_NR),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
RS                          STRING(1)
DATUMS                      LONG
PAR_NR                      ULONG
REFERENCE                   STRING(14)
BKK                         STRING(5)
D_K                         STRING(1)
SUMMA                       DECIMAL(11,2)
SUMMAV                      DECIMAL(11,2)
VAL                         STRING(3)
PVN_PROC                    BYTE
PVN_TIPS                    STRING(1)
BAITS                       BYTE
KK                          BYTE
NODALA                      STRING(2)
Obj_nr                      ULONG
                         END
                       END
GK1::Used            LONG,THREAD

PAROLES                 FILE,DRIVER('TOPSPEED'),RECLAIM,OWNER('MARIS'),ENCRYPT,NAME('PAROLES'),PRE(SEC),CREATE,BINDABLE,THREAD
SECURE_KEY               KEY(SEC:SECURE),NOCASE,OPT
NR_KEY                   KEY(SEC:U_NR),NOCASE,OPT
PUB_KEY                  KEY(SEC:PUBLISH),NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        USHORT
SECURE                      STRING(8)
PUBLISH                     STRING(8)
SUPER_ACC                   STRING(1)
FILES_ACC                   STRING(8)
SPEC_ACC                    STRING(30)
START_NR                    BYTE
BASE_ACC                    STRING(15)
NOL_ACC                     STRING(25)
FP_ACC                      STRING(25)
ALGA_ACC                    STRING(15)
PAM_ACC                     STRING(15)
LM_ACC                      STRING(25)
DUP_ACC                     BYTE
VUT                         STRING(25)
AMATS                       STRING(25)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
PAROLES::Used        LONG,THREAD

SYSTEM                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('SYSTEM'),PRE(SYS),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(SYS:AVOTA_NR),NOCASE,OPT
Record                   RECORD,PRE()
AVOTA_NR                    BYTE
NODALA                      STRING(2)
GIL_SHOW                    LONG
AVOTS                       STRING(17)
REF_AVOTS                   BYTE
ADRESE                      STRING(60)
TEL                         STRING(17)
FAX                         STRING(17)
E_MAIL                      STRING(35)
UDL_S                       LONG
UDL_B                       LONG
UDL_6S                      LONG
UDL_6B                      LONG
UDL_7S                      LONG
UDL_7B                      LONG
CONTROL_BYTE                BYTE
ATLAUJA                     STRING(45)
NOM_CIT                     STRING(1)
NOKL_TE                     STRING(15)
NOKL_PVN                    BYTE
NOKL_B                      BYTE
NOKL_PB                     BYTE
NOKL_DC                     USHORT
NOKL_CP                     BYTE
NOKL_CA                     BYTE
NOKL_TR                     DECIMAL(3,1)
K_PVN                       STRING(5)
D_PR                        STRING(5)
D_TA                        STRING(5)
K_KO                        STRING(5)
D_DK_PRI                    STRING(5)
D_DK_PEC                    STRING(5)
D_DK_UKA                    STRING(5)
K_PA                        STRING(5)
D_PVN_PEC                   STRING(5)
D_PVN_PRI                   STRING(5)
K_DK_PRI                    STRING(5)
K_DK_PEC                    STRING(5)
K_DK_UKA                    STRING(5)
D_PA                        STRING(5)
K_PR                        STRING(5)
K_TA                        STRING(5)
D_KO                        STRING(5)
D_TR                        STRING(5)
K_TR                        STRING(5)
SUB_ES                      STRING(1)
EXP                         STRING(1)
EXT                         STRING(1)
VALODA                      STRING(1)
PARAKSTS1                   STRING(25)
AMATS1                      STRING(25)
PARAKSTS2                   STRING(25)
AMATS2                      STRING(25)
PARAKSTS3                   STRING(25)
KASES_AP                    STRING(2)
com_nr                      STRING(1)
U_SKANERIS                  STRING(1)
E_SVARI                     STRING(1)
SK_DRUKA                    STRING(1)
CEKA_NR                     ULONG
kontrolcipars               STRING(3)
Tuksni                      BYTE
PZ_SERIJA                   STRING(7)
PZ_NR                       ULONG
PZ_NR_END                   ULONG
PARAKSTS_NR                 BYTE
SUP_A4_NR                   BYTE
BAITS1                      BYTE
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
SYSTEM::Used         LONG,THREAD

TEK_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('TEK_K'),PRE(TEK),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(TEK:INI),DUP,NOCASE,OPT
Record                   RECORD,PRE()
INI                         STRING(15)
TEKSTS                      STRING(47)
TEKSTS2                     STRING(47)
TEKSTS3                     STRING(47)
TIPS                        STRING(1)
ATT_DOK                     STRING(1)
ref_obj                     BYTE
NODALA                      STRING(2)
OBJ_NR                      USHORT
PAR_NR                      ULONG
PAR_NOS                     STRING(15)
AVA_NR                      ULONG
AVA_NOS                     STRING(15)
NOKL_SUMMA                  DECIMAL(11,2)
D_K1                        STRING(1)
D_K2                        STRING(1)
D_K3                        STRING(1)
D_K4                        STRING(1)
D_K5                        STRING(1)
D_K6                        STRING(1)
BKK_1                       STRING(5)
BKK_2                       STRING(5)
BKK_3                       STRING(5)
BKK_4                       STRING(5)
BKK_5                       STRING(5)
BKK_6                       STRING(5)
PVN_1                       BYTE
PVN_2                       BYTE
PVN_3                       BYTE
PVN_4                       BYTE
PVN_5                       BYTE
PVN_6                       BYTE
K_1                         DECIMAL(6,3)
K_2                         DECIMAL(6,3)
K_3                         DECIMAL(6,3)
K_4                         DECIMAL(6,3)
K_5                         DECIMAL(6,3)
K_6                         DECIMAL(6,3)
PVN_TIPS                    STRING(1)
BAITS                       BYTE
BAITS1                      BYTE
                         END
                       END
TEK_K::Used          LONG,THREAD

NOLIK                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(NOLIKNAME),PRE(NOL),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(NOL:U_NR,NOL:NOMENKLAT),DUP,NOCASE
DAT_KEY                  KEY(NOL:DATUMS,NOL:D_K),DUP,NOCASE
PAR_KEY                  KEY(NOL:PAR_NR,NOL:DATUMS,NOL:D_K),DUP,NOCASE
NOM_KEY                  KEY(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K),DUP,NOCASE
Record                   RECORD,PRE()
U_NR                        ULONG
OBJ_NR                      ULONG
DATUMS                      LONG
NOMENKLAT                   STRING(21)
IZC_V_KODS                  STRING(2)
PAR_NR                      ULONG
D_K                         STRING(1)
RS                          STRING(1)
IEPAK_D                     DECIMAL(7,2)
DAUDZUMS                    DECIMAL(11,3)
SUMMA                       DECIMAL(11,2)
SUMMAV                      DECIMAL(11,2)
val                         STRING(3)
ATLAIDE_PR                  DECIMAL(3,1)
PVN_PROC                    BYTE
ARBYTE                      BYTE
T_SUMMA                     DECIMAL(9,2)
MUITA                       DECIMAL(9,2)
AKCIZE                      DECIMAL(9,2)
CITAS                       DECIMAL(9,2)
LOCK                        BYTE
BAITS                       BYTE
BAITS1                      BYTE
                         END
                       END
NOLIK::Used          LONG,THREAD

NOL_KOPS                FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('NOL_KOPS'),PRE(KOPS),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(KOPS:U_NR),NOCASE,OPT
NOM_key                  KEY(KOPS:NOMENKLAT),DUP,NOCASE,OPT
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
U_NR                        ULONG
KATALOGA_NR                 STRING(22)
NOS_S                       STRING(16)
STATUSS                     BYTE,DIM(18,25)
BAITS                       BYTE
                         END
                       END
NOL_KOPS::Used       LONG,THREAD

NOL_FIFO                FILE,DRIVER('TOPSPEED'),NAME('NOL_FIFO'),PRE(FIFO),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(FIFO:U_NR,FIFO:DATUMS,FIFO:D_K),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
DATUMS                      LONG
D_K                         STRING(2)
NOL_NR                      BYTE
DAUDZUMS                    DECIMAL(11,3)
SUMMA                       DECIMAL(11,2)
BAITS                       BYTE
                         END
                       END
NOL_FIFO::Used       LONG,THREAD

PAVAD                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(PAVADNAME),PRE(PAV),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(PAV:U_NR),NOCASE,OPT
DAT_KEY                  KEY(-PAV:DATUMS,-PAV:D_K,-PAV:DOK_SENR),DUP,NOCASE,OPT
PAR_KEY                  KEY(PAV:PAR_NR,PAV:DATUMS,PAV:D_K),DUP,NOCASE,OPT
SENR_KEY                 KEY(PAV:DOK_SENR),NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
GG_U_NR                     ULONG
DOKDAT                      LONG
DATUMS                      LONG
NODALA                      STRING(2)
OBJ_NR                      ULONG
D_K                         STRING(1)
RS                          STRING(1)
DOK_SENR                    STRING(14)
DEK_NR                      STRING(12)
KIE_NR                      ULONG
REK_NR                      STRING(10)
PAR_NR                      ULONG
NOKA                        STRING(15)
PAR_ADR_NR                  BYTE
MAK_NR                      ULONG
VED_NR                      ULONG
PAMAT                       STRING(28)
PIELIK                      STRING(21)
SUMMA                       DECIMAL(11,2)
SUMMA_A                     DECIMAL(9,2)
SUMMA_B                     DECIMAL(11,2)
apm_v                       STRING(1)
apm_k                       STRING(1)
DAR_V_KODS                  BYTE
TR_V_KODS                   BYTE
PIEG_N_KODS                 STRING(3)
C_DATUMS                    LONG
C_SUMMA                     DECIMAL(11,2)
T_SUMMA                     DECIMAL(11,2)
T_PVN                       BYTE
val                         STRING(3)
MUITA                       DECIMAL(9,2)
AKCIZE                      DECIMAL(9,2)
CITAS                       DECIMAL(9,2)
TEKSTS_NR                   ULONG
EXP                         BYTE
KEKSIS                      BYTE
BAITS1                      BYTE
BAITS2                      BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
PAVAD::Used          LONG,THREAD

PAMKAT                  FILE,DRIVER('TOPSPEED'),NAME(PAMKATNAME),PRE(PAK),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
MEN_SKAITS                  BYTE,DIM(40)
GD_PR                       BYTE,DIM(6,40)
SAK_V                       DECIMAL(10,2),DIM(6,40)
IEG_V                       DECIMAL(10,2),DIM(6,40)
KAP_V                       DECIMAL(10,2),DIM(6,40)
PAR_V                       DECIMAL(10,2),DIM(6,40)
ATL_V                       DECIMAL(9,2),DIM(6,40)
KOREKCIJA                   DECIMAL(9,2),DIM(6,40)
NOLIETOJUMS                 DECIMAL(10,2),DIM(6,40)
U_NOLIETOJUMS               DECIMAL(10,2),DIM(6,40)
LOCK                        STRING(6),DIM(40)
BAITS                       BYTE
ACC_DATUMS                  LONG
ACC_KODS                    STRING(8)
                         END
                       END
PAMKAT::Used         LONG,THREAD

PAR_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(PARNAME),PRE(PAR),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(PAR:U_NR),NOCASE
NOS_KEY                  KEY(PAR:NOS_A),DUP,NOCASE,OPT
NOS_U_KEY                KEY(PAR:NOS_U),NOCASE,OPT
KARTE_KEY                KEY(PAR:KARTE),NOCASE,OPT
NMR_KEY                  KEY(PAR:NMR_KODS,PAR:NMR_PLUS),NOCASE,OPT
GNET_KEY                 KEY(PAR:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
KARTE                       ULONG
TIPS                        STRING(1)
GRUPA                       STRING(7)
REDZAMIBA                   STRING(1)
NOS_S                       STRING(15)
NOS_P                       STRING(45)
NOS_A                       STRING(12)
NOS_U                       STRING(3)
NMR_KODS                    STRING(22)
NMR_PLUS                    STRING(1)
PVN                         STRING(22)
PASE                        STRING(37)
ATLAIDE                     DECIMAL(4,1)
NOKL_CP                     BYTE
KRED_LIM                    DECIMAL(9,2)
KKS231                      DECIMAL(11,2)
KKS531                      DECIMAL(11,2)
BAN_KODS                    STRING(15)
BAN_NR                      STRING(34)
BAN_KR                      STRING(11)
BAN_KODS2                   STRING(15)
BAN_NR2                     STRING(34)
BAN_KR2                     STRING(11)
ADRESE                      STRING(60)
PIEZIMES                    STRING(25)
V_KODS                      STRING(2)
KONTAKTS                    STRING(30)
L_DATUMS                    LONG
LIGUMS                      STRING(30)
L_CDATUMS                   LONG
L_SUMMA                     DECIMAL(10,2)
L_SUMMA1                    DECIMAL(10,2)
L_FAILS                     STRING(12)
LT                          BYTE
TEL                         STRING(26)
FAX                         STRING(15)
EMAIL                       STRING(30)
ATZIME1                     BYTE
ATZIME2                     BYTE
NOKL_DC                     BYTE
NOKL_DC_TIPS                STRING(1)
GNET_FLAG                   STRING(2)
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
PAR_K::Used          LONG,THREAD

NOM_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(NOMNAME),PRE(NOM),CREATE,BINDABLE,THREAD
NOM_KEY                  KEY(NOM:NOMENKLAT),NOCASE
KOD_KEY                  KEY(NOM:KODS,NOM:KODS_PLUS),NOCASE,OPT
NOS_KEY                  KEY(NOM:NOS_A),DUP,NOCASE
KAT_KEY                  KEY(NOM:KATALOGA_NR),DUP,NOCASE,OPT
ANAL_KEY                 KEY(NOM:ANALOGS),DUP,NOCASE,OPT
GNET_KEY                 KEY(NOM:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
KATALOGA_NR                 STRING(22)
MUITAS_KODS                 DECIMAL(10)
IZC_V_KODS                  STRING(2)
ANALOGS                     STRING(7)
EAN                         STRING(1)
KODS                        DECIMAL(13)
KODS_PLUS                   STRING(1)
TIPS                        STRING(1)
NOS_P                       STRING(50)
NOS_S                       STRING(16)
NOS_A                       STRING(8)
MERVIEN                     STRING(7)
REDZAMIBA                   BYTE
NEATL                       BYTE
BKK                         STRING(5)
OKK6                        STRING(5)
PVN_PROC                    BYTE
SVARSKG                     DECIMAL(10,5)
KOEF_ESKNPM                 DECIMAL(6,3)
SKAITS_I                    DECIMAL(9,4)
DER_TERM                    LONG
KRIT_DAU                    DECIMAL(7,2),DIM(25)
MAX_DAU                     DECIMAL(7,2),DIM(25)
MUITA                       DECIMAL(9,3)
AKCIZE                      DECIMAL(9,3)
REALIZ                      DECIMAL(11,4),DIM(5)
ARPVNBYTE                   BYTE
VAL                         STRING(3),DIM(5)
PROC5                       DECIMAL(3)
MINRC                       DECIMAL(11,4)
PIC                         DECIMAL(11,4)
PIC_DATUMS                  LONG
CITS_TEKSTSPZ               STRING(21)
RINDA2PZ                    STRING(50)
STATUSS                     STRING(25)
GNET_FLAG                   STRING(2)
ATBILDIGAIS                 USHORT
ETIKETES                    BYTE
PUNKTI                      DECIMAL(9,3)
DG                          BYTE
BAITS1                      BYTE
BAITS2                      BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
NOM_K::Used          LONG,THREAD

MER_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('MER_K'),PRE(MER),CREATE,BINDABLE,THREAD
MER_KEY                  KEY(MER:MERVIEN),DUP,NOCASE,OPT
Record                   RECORD,PRE()
MERVIEN                     STRING(7)
                         END
                       END
MER_K::Used          LONG,THREAD

ATL_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('ATL_K'),PRE(ATL),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(ATL:U_NR),NOCASE
NOS_KEY                  KEY(ATL:NOS_A),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        USHORT
HIDDEN                      BYTE
KOMENTARS                   STRING(50)
NOS_A                       STRING(7)
ATL_PROC_PA                 DECIMAL(4,1)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
ATL_K::Used          LONG,THREAD

KOMPLEKT                FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('KOMPLEKT'),PRE(KOM),CREATE,BINDABLE,THREAD
NOM_KEY                  KEY(KOM:NOMENKLAT,KOM:NOM_SOURCE),NOCASE
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
NOM_SOURCE                  STRING(21)
DAUDZUMS                    DECIMAL(11,3)
BAITS                       BYTE
                         END
                       END
KOMPLEKT::Used       LONG,THREAD

FPPAVAD                 FILE,DRIVER('TOPSPEED'),NAME(FPPAVADNAME),PRE(FPP),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(FPP:U_NR),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
U_NR                        ULONG
CEKA_NR                     ULONG
NOL_NR                      BYTE
OBJ_NR                      ULONG
RS                          BYTE
AV                          BYTE
RT                          BYTE
ES                          BYTE
DATUMS                      LONG
LAIKS                       LONG
PAR_NR                      ULONG
NOS_P                       STRING(35)
ADRESE                      STRING(40)
REG_NR                      STRING(13)
BAN_KODS                    STRING(10)
BAN_NR                      STRING(21)
TEKSTS                      STRING(40)
KATLAIDE                    DECIMAL(7,2)
APD_SUMMA                   DECIMAL(7,2)
KR3_SUMMA                   DECIMAL(7,2)
KR2_SUMMA                   DECIMAL(7,2)
KAR_SUMMA                   DECIMAL(7,2)
KSUMMA                      DECIMAL(7,2)
VAL                         STRING(3)
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
FPPAVAD::Used        LONG,THREAD

FPNOLIK                 FILE,DRIVER('TOPSPEED'),NAME(FPNOLIKNAME),PRE(FPN),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(FPN:U_NR,-FPN:SECIBA),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
KODS                        DECIMAL(13)
KODS_PLUS                   STRING(1)
NOM_TIPS                    STRING(1)
NOS_P                       STRING(50)
MERVIEN                     STRING(7)
DAUDZUMS                    DECIMAL(10,3)
SUMMA                       DECIMAL(7,2)
PVN_PR                      BYTE
ATLAIDE_PR                  DECIMAL(3,1)
MAK_NR                      ULONG
APD_SUMMA                   DECIMAL(7,2)
DAK_NR                      ULONG
IEST_NR                     ULONG
OBJ_NR                      ULONG
REC_NR                      STRING(10)
REC_DATUMS                  LONG
DIAG_K                      STRING(6)
BAITS                       BYTE
SECIBA                      LONG
                         END
                       END
FPNOLIK::Used        LONG,THREAD

AU_BILDE                FILE,DRIVER('TOPSPEED'),NAME(AUBNAME),PRE(AUB),CREATE,BINDABLE,THREAD
DAT_KEY                  KEY(AUB:DATUMS,AUB:PLKST_P),NOCASE,OPT
Record                   RECORD,PRE()
DATUMS                      LONG
PLKST_P                     LONG
PAV_NR                      ULONG,DIM(22)
AUT_TEXT                    STRING(10),DIM(22)
STATUSS                     BYTE,DIM(22)
BAITS                       BYTE,DIM(22)
                         END
                       END
AU_BILDE::Used       LONG,THREAD

PAMAM                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(PAMAMNAME),PRE(AMO),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(AMO:U_NR,AMO:YYYYMM),NOCASE,PRIMARY
YYYYMM_KEY               KEY(AMO:YYYYMM,AMO:U_NR),NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
YYYYMM                      LONG
LIN_G_PR                    DECIMAL(5,3)
NODALA                      STRING(2)
SAK_V_LI                    DECIMAL(11,2)
NOL_G_LI                    DECIMAL(11,3)
NOL_U_LI                    DECIMAL(11,3)
NOL_LIN                     DECIMAL(11,3)
LOCK_LIN                    BYTE
KAPREM                      DECIMAL(11,2)
PARCEN                      DECIMAL(11,2)
PARCENLI                    DECIMAL(11,2)
IZSLEGTS                    DECIMAL(11,2)
SKAITS                      DECIMAL(3)
                         END
                       END
PAMAM::Used          LONG,THREAD

OUTFILEANSI             FILE,DRIVER('ASCII'),NAME(ANSIFILENAME),PRE(OUTA),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
LINE                        STRING(500)
                         END
                       END
OUTFILEANSI::Used    LONG,THREAD

ZURNALS                 FILE,DRIVER('ASCII'),NAME(DZNAME),PRE(ZUR),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
line                        STRING(132)
                         END
                       END
ZURNALS::Used        LONG,THREAD

PAR_K1                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(FILENAME1),PRE(PAR1),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(PAR1:U_NR),NOCASE
NOS_KEY                  KEY(PAR1:NOS_A),DUP,NOCASE,OPT
NOS_U_KEY                KEY(PAR1:NOS_U),NOCASE,OPT
KARTE_KEY                KEY(PAR1:KARTE),NOCASE,OPT
NMR_KEY                  KEY(PAR1:NMR_KODS,PAR1:NMR_PLUS),NOCASE,OPT
GNET_KEY                 KEY(PAR1:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
KARTE                       ULONG
TIPS                        STRING(1)
GRUPA                       STRING(7)
REDZAMIBA                   STRING(1)
NOS_S                       STRING(15)
NOS_P                       STRING(45)
NOS_A                       STRING(12)
NOS_U                       STRING(3)
NMR_KODS                    STRING(22)
NMR_PLUS                    STRING(1)
PVN                         STRING(22)
PASE                        STRING(37)
ATLAIDE                     DECIMAL(4,1)
NOKL_CP                     BYTE
KRED_LIM                    DECIMAL(9,2)
KKS_231                     DECIMAL(11,2)
KKS_531                     DECIMAL(11,2)
BAN_KODS                    STRING(15)
BAN_NR                      STRING(34)
BAN_KR                      STRING(11)
BAN_KODS2                   STRING(15)
BAN_NR2                     STRING(34)
BAN_KR2                     STRING(11)
ADRESE                      STRING(60)
PIEZIMES                    STRING(25)
V_KODS                      STRING(2)
KONTAKTS                    STRING(30)
L_DATUMS                    LONG
LIGUMS                      STRING(30)
L_CDATUMS                   LONG
L_SUMMA                     DECIMAL(10,2)
L_SUMMA1                    DECIMAL(10,2)
L_FAILS                     STRING(12)
LT                          BYTE
TEL                         STRING(26)
FAX                         STRING(15)
EMAIL                       STRING(30)
ATZIME1                     BYTE
ATZIME2                     BYTE
NOKL_DC                     BYTE
NOKL_DC_TIPS                STRING(1)
GNET_FLAG                   STRING(2)
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
PAR_K1::Used         LONG,THREAD

NOLI1                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(FILENAME2),PRE(NO1),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(NO1:U_NR,NO1:NOMENKLAT),DUP,NOCASE
DAT_KEY                  KEY(NO1:DATUMS,NO1:D_K),DUP,NOCASE
PAR_KEY                  KEY(NO1:PAR_NR,NO1:DATUMS,NO1:D_K),DUP,NOCASE
NOM_KEY                  KEY(NO1:NOMENKLAT,NO1:DATUMS,NO1:D_K),DUP,NOCASE
Record                   RECORD,PRE()
U_NR                        ULONG
OBJ_NR                      ULONG
DATUMS                      LONG
NOMENKLAT                   STRING(21)
IZC_V_KODS                  STRING(2)
PAR_NR                      ULONG
D_K                         STRING(1)
RS                          STRING(1)
IEPAK_D                     DECIMAL(7,2)
DAUDZUMS                    DECIMAL(11,3)
SUMMA                       DECIMAL(11,2)
SUMMAV                      DECIMAL(11,2)
val                         STRING(3)
ATLAIDE_PR                  DECIMAL(3,1)
PVN_PROC                    BYTE
ARBYTE                      BYTE
T_SUMMA                     DECIMAL(9,2)
MUITA                       DECIMAL(9,2)
AKCIZE                      DECIMAL(9,2)
CITAS                       DECIMAL(9,2)
LOCK                        BYTE
BAITS                       BYTE
BAITS1                      BYTE
                         END
                       END
NOLI1::Used          LONG,THREAD

NOLPAS                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('NOLPAS'),PRE(NOS),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(NOS:U_NR,NOS:NOMENKLAT),DUP,NOCASE
NOM_KEY                  KEY(NOS:NOMENKLAT),DUP,NOCASE,OPT
PAR_KEY                  KEY(NOS:PAR_NR,NOS:DOK_NR,NOS:KATALOGA_NR),DUP,NOCASE
PARKE_KEY                KEY(NOS:PAR_KE,NOS:DOK_NR,NOS:KATALOGA_NR),DUP,NOCASE,OPT
SAN_KEY                  KEY(NOS:SAN_NR,NOS:DATUMS),DUP,NOCASE,OPT
AUT_KEY                  KEY(NOS:AUT_NR,NOS:DATUMS),DUP,NOCASE,OPT
Record                   RECORD,PRE()
RS                          STRING(1)
U_NR                        ULONG
DATUMS                      LONG
DOK_NR                      ULONG
NOMENKLAT                   STRING(21)
NOS_S                       STRING(16)
KATALOGA_NR                 STRING(22)
PAR_NR                      ULONG
PAR_KE                      ULONG
NOL_NR                      BYTE
SAN_NR                      ULONG
SAN_NOS                     STRING(15)
AUT_NR                      ULONG
KOMENTARS                   STRING(25)
DAUDZUMS                    DECIMAL(11,3)
T_DAUDZUMS                  DECIMAL(11,3)
I_DAUDZUMS                  DECIMAL(11,3)
SUMMA                       DECIMAL(11,2)
SUMMAV                      DECIMAL(11,2)
val                         STRING(3)
LIGUMCENA                   DECIMAL(11,2)
PVN_PROC                    BYTE
KEKSIS                      BYTE
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
NOLPAS::Used         LONG,THREAD

ALGAS                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(ALGASNAME),PRE(ALG),CREATE,BINDABLE,THREAD
ID_KEY                   KEY(ALG:YYYYMM,ALG:ID),NOCASE,OPT
INI_KEY                  KEY(ALG:YYYYMM,ALG:INI),DUP,NOCASE,OPT
NOD_KEY                  KEY(ALG:YYYYMM,ALG:NODALA,ALG:INI),DUP,NOCASE,OPT
ID_DAT                   KEY(ALG:ID,ALG:YYYYMM),DUP,NOCASE,OPT
Record                   RECORD,PRE()
YYYYMM                      LONG
ID                          USHORT
INI                         STRING(5)
NODALA                      STRING(2)
OBJ_NR                      ULONG
STATUSS                     STRING(1)
INV_P                       STRING(1)
APGAD_SK                    BYTE
PR37                        DECIMAL(5,2)
PR1                         DECIMAL(5,2)
PPF                         DECIMAL(7,2)
DZIVAP                      DECIMAL(7,2)
IZDEV                       DECIMAL(7,2)
PARSKAITIT                  DECIMAL(9,2)
IZMAKSAT                    DECIMAL(9,2)
N_Stundas                   USHORT
SOC_V                       STRING(1)
LMIA                        DECIMAL(6,2)
LBER                        DECIMAL(6,2)
LINV                        DECIMAL(6,2)
K                           DECIMAL(3),DIM(20)
L                           BYTE,DIM(20)
S                           DECIMAL(3),DIM(20)
D                           DECIMAL(3),DIM(20)
A                           DECIMAL(9,3),DIM(20)
R                           DECIMAL(9,2),DIM(20)
I                           DECIMAL(3),DIM(15)
J                           BYTE,DIM(15)
C                           DECIMAL(9,2),DIM(15)
N                           DECIMAL(9,2),DIM(15)
TERKOD                      DECIMAL(6)
IIN                         DECIMAL(8,2)
IIN_DATUMS                  LONG
IIN_LOCK                    BYTE
BAITS                       BYTE
BAITS1                      BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
ALGAS::Used          LONG,THREAD

PAR_Z                   FILE,DRIVER('TOPSPEED'),RECLAIM,PRE(ATZ),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(ATZ:NR),NOCASE
Record                   RECORD,PRE()
NR                          BYTE
TEKSTS                      STRING(40)
WARLEVEL                    STRING(1)
                         END
                       END
PAR_Z::Used          LONG,THREAD

DAIEV                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('DAIEV'),PRE(DAI),CREATE,BINDABLE,THREAD
KOD_KEY                  KEY(DAI:KODS),NOCASE
Record                   RECORD,PRE()
KODS                        DECIMAL(3)
NOSAUKUMS                   STRING(35)
F                           STRING(3)
T                           STRING(1)
IENAK_VEIDS                 USHORT
G                           STRING(4)
ARG_NOS                     STRING(10)
TARL                        DECIMAL(9,4)
ALGA                        DECIMAL(7,2)
PROC                        DECIMAL(3,1)
F_DAIEREZ                   DECIMAL(3),DIM(10)
NODALA                      STRING(2)
DKK                         STRING(5)
KKK                         STRING(5)
SOCYN                       STRING(1)
IENYN                       STRING(1)
SLIYN                       STRING(1)
ATVYN                       STRING(1)
VIDYN                       STRING(1)
BAITS                       BYTE
                         END
                       END
DAIEV::Used          LONG,THREAD

KADRI                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('KADRI'),PRE(KAD),CREATE,BINDABLE,THREAD
INI_Key                  KEY(KAD:INI),DUP,NOCASE
NOD_KEY                  KEY(KAD:NODALA,KAD:INI),DUP,NOCASE,OPT
ID_Key                   KEY(KAD:ID),NOCASE
Record                   RECORD,PRE()
ID                          USHORT
UZV                         STRING(20)
VAR                         STRING(15)
TEV                         STRING(15)
INI                         STRING(7)
V_KODS                      STRING(2)
DZIM                        STRING(1)
IZGLITIBA                   STRING(1)
V_VAL                       STRING(40)
PERSKOD                     STRING(@p######-#####p)
DZV_PILS                    STRING(30)
PASE                        STRING(60)
PASE_END                    LONG
PIERADR                     STRING(60)
REK_NR1                     STRING(34)
BKODS1                      STRING(15)
REK_NR2                     STRING(34)
BKODS2                      STRING(15)
TERKOD                      ULONG
KARTNR                      STRING(12)
REGNR                       STRING(12)
VID_U_Nr                    ULONG
STATUSS                     STRING(1)
AMATS                       STRING(25)
NODALA                      STRING(2)
OBJ_NR                      ULONG
DAR_LIG                     STRING(8)
DAR_DAT                     ULONG
DARBA_GR                    LONG
Z_KODS                      BYTE
NEDAR_LIG                   STRING(8)
NEDAR_DAT                   ULONG
D_GR_END                    LONG
Z_KODS_END                  BYTE
INV_P                       STRING(1)
APGAD_SK                    BYTE
SOC_V                       STRING(1)
PR37                        DECIMAL(5,2)
PR1                         DECIMAL(5,2)
PPF_PROC                    DECIMAL(4,2)
DZIVAP_PROC                 DECIMAL(4,2)
AVANSS                      DECIMAL(7,2)
PIESKLIST                   DECIMAL(3),DIM(20)
SLODZE                      STRING(20)
IETLIST                     DECIMAL(3),DIM(15)
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
KADRI::Used          LONG,THREAD

NOM_A                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('NOM_A'),PRE(NOA),CREATE,BINDABLE,THREAD
NOM_KEY                  KEY(NOA:NOMENKLAT),NOCASE
GNET_KEY                 KEY(NOA:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
D_PROJEKTS                  DECIMAL(11,3),DIM(25)
ATLIKUMS                    DECIMAL(11,3),DIM(25)
K_PROJEKTS                  DECIMAL(11,3),DIM(25)
GNET_FLAG                   STRING(3)
                         END
                       END
NOM_A::Used          LONG,THREAD

NOL_STAT                FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('NOL_STAT'),PRE(STAT),CREATE,BINDABLE,THREAD
NOM_key                  KEY(STAT:NOMENKLAT),DUP,NOCASE,OPT
ATB_KEY                  KEY(STAT:ATBILDIGAIS,STAT:NOMENKLAT),DUP,NOCASE,OPT
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
KATALOGA_NR                 STRING(22)
REDZAMIBA                   BYTE
ATBILDIGAIS                 USHORT
NOS_S                       STRING(16)
DAUDZUMS                    LONG,DIM(12,15)
SUMMA                       DECIMAL(9,2),DIM(12,15)
                         END
                       END
NOL_STAT::Used       LONG,THREAD

NOM_K1                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(FILENAME1),PRE(NOM1),CREATE,BINDABLE,THREAD
NOM_KEY                  KEY(NOM1:NOMENKLAT),NOCASE
KOD_KEY                  KEY(NOM1:KODS,NOM1:KODS_PLUS),NOCASE,OPT
NOS_KEY                  KEY(NOM1:NOS_A),DUP,NOCASE
KAT_KEY                  KEY(NOM1:KATALOGA_NR),DUP,NOCASE,OPT
ANAL_KEY                 KEY(NOM1:ANALOGS),DUP,NOCASE,OPT
GNET_KEY                 KEY(NOM1:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
KATALOGA_NR                 STRING(22)
MUITAS_KODS                 DECIMAL(10)
IZC_V_KODS                  STRING(2)
ANALOGS                     STRING(7)
EAN                         STRING(1)
KODS                        DECIMAL(13)
KODS_PLUS                   STRING(1)
TIPS                        STRING(1)
NOS_P                       STRING(50)
NOS_S                       STRING(16)
NOS_A                       STRING(8)
MERVIEN                     STRING(7)
REDZAMIBA                   BYTE
NEATL                       BYTE
BKK                         STRING(5)
OKK6                        STRING(5)
PVN_PROC                    BYTE
SVARSKG                     DECIMAL(10,5)
KOEF_ESKNPMPM               DECIMAL(6,3)
SKAITS_I                    DECIMAL(9,4)
DER_TERM                    LONG
KRIT_DAU                    DECIMAL(7,2),DIM(25)
MAX_DAU                     DECIMAL(7,2),DIM(25)
MUITA                       DECIMAL(9,3)
AKCIZE                      DECIMAL(9,3)
REALIZ                      DECIMAL(11,4),DIM(5)
ARPVNBYTE                   BYTE
VAL                         STRING(3),DIM(5)
PROC5                       DECIMAL(3)
MINRC                       DECIMAL(11,4)
PIC                         DECIMAL(11,4)
PIC_DATUMS                  LONG
CITS_TEKSTSPZ               STRING(21)
RINDA2PZ                    STRING(50)
STATUSS                     STRING(25)
GNET_FLAG                   STRING(2)
ATBILDIGAIS                 USHORT
ETIKETES                    BYTE
PUNKTI                      DECIMAL(9,3)
DG                          BYTE
BAITS1                      BYTE
BAITS2                      BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
NOM_K1::Used         LONG,THREAD

PERNOS                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('PERNOS'),PRE(PER),CREATE,BINDABLE,THREAD
ID_KEY                   KEY(PER:ID,PER:PAZIME,PER:YYYYMM),DUP,NOCASE,OPT
DAT_KEY                  KEY(PER:PAZIME,-PER:SAK_DAT),DUP,NOCASE,OPT
INI_KEY                  KEY(PER:INI,PER:PAZIME,-PER:YYYYMM),DUP,NOCASE,OPT
Record                   RECORD,PRE()
PAZIME                      STRING(1)
YYYYMM                      LONG
ID                          USHORT
INI                         STRING(5)
RIK_NR                      ULONG
SAK_DAT                     LONG
BEI_DAT                     LONG
A_DIENAS                    BYTE
VSUMMA                      DECIMAL(7,3)
VSUMMAS                     DECIMAL(7,3)
DIENAS                      BYTE
SUMMA                       DECIMAL(7,2)
DIENAS0                     BYTE
DIENAS0C                    BYTE
SUMMA0                      DECIMAL(7,2)
DIENAS1                     BYTE
DIENAS1C                    BYTE
SUMMA1                      DECIMAL(7,2)
DIENAS2                     BYTE
DIENAS2C                    BYTE
SUMMA2                      DECIMAL(7,2)
DIENASS                     BYTE
SUMMAS                      DECIMAL(7,2)
DIENASX                     BYTE
DIENASXC                    BYTE
SUMMAX                      DECIMAL(7,2)
LOCK                        BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
PERNOS::Used         LONG,THREAD

TEKSTI                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(TEXNAME),PRE(TEX),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(TEX:NR),NOCASE
TEX_KEY                  KEY(TEX:TEX_A),DUP,NOCASE
Record                   RECORD,PRE()
NR                          ULONG
TEKSTS1                     STRING(60)
TEKSTS2                     STRING(60)
TEKSTS3                     STRING(60)
TEX_A                       STRING(5)
KM                          DECIMAL(6,1)
RIK_TIPS                    STRING(1)
BAITS                       BYTE
                         END
                       END
TEKSTI::Used         LONG,THREAD

AUTO                    FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('AUTO'),PRE(AUT),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(AUT:U_NR),NOCASE
Par_key                  KEY(AUT:Par_Nr),DUP,NOCASE,OPT
V_Nr_key                 KEY(AUT:V_Nr),DUP,NOCASE,OPT
Virsb_key                KEY(AUT:Virsb_Nr),DUP,NOCASE,OPT
MARK_KEY                 KEY(AUT:MARKA),DUP,NOCASE,OPT
GNET_KEY                 KEY(AUT:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
V_Nr                        STRING(12)
V_Nr2                       STRING(7)
MARKA                       STRING(30)
MMYYYY                      LONG
Virsb_Nr                    STRING(20)
Dzinejs                     STRING(20)
Dzineja_K                   STRING(20)
Krasa                       STRING(20)
PAR_DAT                     LONG
GAR_DAT                     LONG
Gar_km                      ULONG
Pap_kods                    ULONG
Piezimes                    STRING(40)
SERVISAGRAM                 STRING(8)
SEGR_DAT                    LONG
PATERINS                    DECIMAL(4,1)
PATERINS_A                  DECIMAL(4,1)
Par_Nr                      ULONG
Par_nos                     STRING(15)
VAD_ID                      USHORT
Vaditajs                    STRING(35)
PERSKODS                    STRING(@P######-#####P)
Telefons                    STRING(20)
GNET_FLAG                   STRING(2)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
AUTO::Used           LONG,THREAD

KAT_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('KAT_K'),PRE(KAT),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(KAT:KAT),NOCASE
Record                   RECORD,PRE()
KAT                         STRING(3)
IIV                         STRING(2)
GRUPA                       STRING(2)
LIKME                       DECIMAL(3)
GADI                        DECIMAL(3,1)
APLKOEF                     DECIMAL(3,1)
KODS                        STRING(@p#.##.#p)
NOSAUKUMS                   STRING(72)
                         END
                       END
KAT_K::Used          LONG,THREAD

PAMAT                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(PAMATNAME),PRE(PAM),CREATE,BINDABLE,THREAD
DAT_KEY                  KEY(-PAM:DATUMS,-PAM:U_NR),NOCASE,OPT
NR_KEY                   KEY(PAM:U_NR),NOCASE
NOS_KEY                  KEY(PAM:NOS_A),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
NODALA                      STRING(2)
OBJ_NR                      ULONG
ATB_NR                      ULONG
ATB_NOS                     STRING(25)
IZG_GAD                     USHORT
DATUMS                      LONG
EXPL_DATUMS                 LONG
DOK_SENR                    STRING(14)
NOS_P                       STRING(35)
NOS_S                       STRING(15)
NOS_A                       STRING(5)
BKK                         STRING(5)
BKKN                        STRING(5)
OKK7                        STRING(5)
IEP_V                       DECIMAL(11,2)
KAP_V                       DECIMAL(11,2)
NOL_V                       DECIMAL(11,2)
BIL_V                       DECIMAL(11,2)
SKAITS                      DECIMAL(3)
LIN_G_PR                    DECIMAL(5,3)
NERAZ                       BYTE
KAT                         STRING(3),DIM(40)
GD_PR                       BYTE,DIM(40)
GD_KOEF                     DECIMAL(4,3),DIM(40)
SAK_V_GD                    DECIMAL(11,2),DIM(40)
NOL_GD                      DECIMAL(11,2),DIM(40)
LOCK_GD                     BYTE,DIM(40)
END_DATE                    LONG
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
PAMAT::Used          LONG,THREAD

ALGPA                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(ALPANAME),PRE(ALP),CREATE,BINDABLE,THREAD
YYYYMM_KEY               KEY(-ALP:YYYYMM),DUP,NOCASE,OPT
Record                   RECORD,PRE()
YYYYMM                      LONG
STATUSS                     STRING(40)
STAT                        BYTE
APRIIN                      DECIMAL(9,2)
IETIIN                      DECIMAL(9,2)
PARSKAITIT                  DECIMAL(10,2)
IZMAKSAT                    DECIMAL(10,2)
APGADSUM                    DECIMAL(6,2)
AT_INV1                     DECIMAL(6,2)
AT_INV2                     DECIMAL(6,2)
AT_INV3                     DECIMAL(6,2)
AT_POLR                     DECIMAL(6,2)
AT_POLRNP                   DECIMAL(6,2)
MIA                         DECIMAL(6,2)
MINA                        DECIMAL(6,2)
MINS                        DECIMAL(5,3)
PR_PAM                      BYTE
PR_PAP                      BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
ALGPA::Used          LONG,THREAD

NOM_C                   FILE,DRIVER('TOPSPEED'),NAME('NOM_C'),PRE(NOC),CREATE,BINDABLE,THREAD
NOM_KEY                  KEY(NOC:NOMENKLAT),DUP,NOCASE
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
NOSAUKUMS_C                 STRING(50)
NOSAUKUMS_A                 STRING(50)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
NOM_C::Used          LONG,THREAD

CAL                     FILE,DRIVER('TOPSPEED'),NAME('CAL'),PRE(CAL),CREATE,BINDABLE,THREAD
DAT_Key                  KEY(CAL:DATUMS),NOCASE,OPT
Record                   RECORD,PRE()
DATUMS                      LONG
STUNDAS                     STRING(1)
                         END
                       END
CAL::Used            LONG,THREAD

G2                      FILE,DRIVER('Clarion'),RECLAIM,OEM,NAME(FILENAME1),PRE(G2),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(G2:NR),NOCASE,OPT
DAT_KEY                  KEY(G2:DATUMS,G2:REFERENCE,G2:DOKDAT),DUP,NOCASE
DAT1_KEY                 KEY(G2:DATUMS1,G2:REFERENCE1,G2:DOKDAT1),DUP,NOCASE,OPT
Record                   RECORD,PRE()
NR                          DECIMAL(7)
DOK_SE                      STRING(6)
DOK_NR                      STRING(7)
IMP_NR                      DECIMAL(3)
DOKDAT                      LONG
DOKDAT1                     LONG
DATUMS                      LONG
DATUMS1                     LONG
REFDAT                      LONG
REFERENCE                   STRING(7)
REFERENCE1                  STRING(7)
NOKA                        STRING(15)
PAR_NR                      DECIMAL(5)
RS                          DECIMAL(1)
ES                          DECIMAL(1)
SATURS                      STRING(45)
SATURS2                     STRING(45)
SATURS3                     STRING(45)
SUMMA                       DECIMAL(11,2)
NOS                         STRING(3)
I_DATUMS                    LONG
OPERATORS                   STRING(4)
KEKSIS                      BYTE
                         END
                       END
G2::Used             LONG,THREAD

PAVA1                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(FILENAME1),PRE(PA1),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(PA1:U_NR),NOCASE,OPT
DAT_KEY                  KEY(-PA1:DATUMS,-PA1:D_K,-PA1:DOK_SENR),DUP,NOCASE,OPT
PAR_KEY                  KEY(PA1:PAR_NR,PA1:DATUMS,PA1:D_K),DUP,NOCASE,OPT
SENR_KEY                 KEY(PA1:DOK_SENR),NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
GG_U_NR                     ULONG
DOKDAT                      LONG
DATUMS                      LONG
NODALA                      STRING(2)
OBJ_NR                      ULONG
D_K                         STRING(1)
RS                          STRING(1)
DOK_SENR                    STRING(14)
DEK_NR                      STRING(12)
KIE_NR                      ULONG
REK_NR                      STRING(10)
PAR_NR                      ULONG
NOKA                        STRING(15)
PAR_ADR_NR                  BYTE
MAK_NR                      ULONG
VED_NR                      ULONG
PAMAT                       STRING(28)
PIELIK                      STRING(21)
SUMMA                       DECIMAL(11,2)
SUMMA_A                     DECIMAL(9,2)
SUMMA_B                     DECIMAL(11,2)
apm_v                       STRING(1)
apm_k                       STRING(1)
DAR_V_KODS                  BYTE
TR_V_KODS                   BYTE
PIEG_N_KODS                 STRING(3)
C_DATUMS                    LONG
C_SUMMA                     DECIMAL(11,2)
T_SUMMA                     DECIMAL(11,2)
T_PVN                       BYTE
val                         STRING(3)
MUITA                       DECIMAL(9,2)
AKCIZE                      DECIMAL(9,2)
CITAS                       DECIMAL(9,2)
TEKSTS_NR                   ULONG
EXP                         BYTE
KEKSIS                      BYTE
BAITS1                      BYTE
BAITS2                      BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
PAVA1::Used          LONG,THREAD

PAVPAS                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('PAVPAS'),PRE(PAS),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(PAS:U_NR),NOCASE,OPT
DAT_KEY                  KEY(-PAS:DATUMS,-PAS:DOK_NR),DUP,NOCASE,OPT
PAR_KEY                  KEY(PAS:PAR_NR,PAS:DATUMS),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
DATUMS                      LONG
KOMENT                      STRING(20)
TIPS                        STRING(1)
RS                          STRING(1)
DOK_NR                      ULONG
PAR_NR                      ULONG
NOKA                        STRING(15)
SUMMA                       DECIMAL(11,2)
SUMMAV                      DECIMAL(11,2)
val                         STRING(3)
KEKSIS                      BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
PAVPAS::Used         LONG,THREAD

GK2                     FILE,DRIVER('Clarion'),RECLAIM,OEM,NAME(FILENAME2),PRE(GK2),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(GK2:NR,GK2:BKK),DUP,NOCASE,OPT
DAT_KEY                  KEY(GK2:DATUMS,GK2:NR,GK2:D_K),DUP,NOCASE,OPT
BKK_DAT                  KEY(GK2:BKK,GK2:DATUMS,GK2:NR),DUP,NOCASE,OPT
PAR_KEY                  KEY(GK2:PAR_NR,GK2:DATUMS,GK2:NR),DUP,NOCASE,OPT
Record                   RECORD,PRE()
NR                          DECIMAL(7)
DATUMS                      LONG
PAR_NR                      DECIMAL(5)
REF_NR                      DECIMAL(7)
REF_AVOTS                   BYTE
RS                          DECIMAL(1)
BKK                         STRING(5)
D_K                         STRING(1)
SUMMA                       DECIMAL(11,2)
SUMMAV                      DECIMAL(11,2)
NOS                         STRING(3)
P1                          STRING(1)
P2                          BYTE
P3                          BYTE
P4                          STRING(1)
KK                          BYTE
                         END
                       END
GK2::Used            LONG,THREAD

B_PAVAD                 FILE,DRIVER('dBase3'),NAME(B_PAVADNAME),PRE(BPA),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
DATUMS                      DATE
D_K                         STRING(1)
DOK_SENR                    STRING(14)
PAR_NR                      STRING(@N_11)
APM_V                       STRING(1)
APM_K                       STRING(1)
C_DATUMS                    DATE
C_SUMMA                     STRING(@N_12.2)
T_SUMMA                     STRING(@N_11.2)
T_PVN                       STRING(@N2)
VAL                         STRING(3)
NOMENKLAT                   STRING(21)
KODS                        STRING(@N_13)
ARTIKULS                    STRING(22)
TIPS                        STRING(1)
NOSAUKUMS                   STRING(50)
NOS_S                       STRING(16)
MERVIEN                     STRING(7)
SVARS                       STRING(@N_6.2)
SKAITS_I                    STRING(@N_8.2)
DER_TERM                    DATE
Daudzums                    STRING(@n_12.3)
SUMMAV                      STRING(@n_10.2)
ATLAIDE_PR                  STRING(@n_4.1)
PVN_PROC                    STRING(@N2)
ARBYTE                      STRING(@N1)
                         END
                       END
B_PAVAD::Used        LONG,THREAD

GRUPA1                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('GRUPA1'),PRE(GR1),CREATE,BINDABLE,THREAD
GR1_KEY                  KEY(GR1:GRUPA1),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
GRUPA1                      STRING(3)
NOSAUKUMS                   STRING(50)
PROC                        DECIMAL(3)
                         END
                       END
GRUPA1::Used         LONG,THREAD

GRUPA2                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('GRUPA2'),PRE(GR2),CREATE,BINDABLE,THREAD
GR1_KEY                  KEY(GR2:GRUPA1,GR2:GRUPA2),NOCASE,OPT
Record                   RECORD,PRE()
GRUPA1                      STRING(3)
GRUPA2                      STRING(1)
NOSAUKUMS                   STRING(50)
PROC                        DECIMAL(3)
                         END
                       END
GRUPA2::Used         LONG,THREAD

PROJEKTI                FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('PROJEKTI'),PRE(PRO),CREATE,BINDABLE,THREAD
NR_Key                   KEY(PRO:U_NR),NOCASE,OPT
NOS_KEY                  KEY(PRO:NOS_A),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
KODS                        STRING(9)
NOS_P                       STRING(105)
NOS_A                       STRING(6)
SVARS                       BYTE
BAITS                       BYTE
                         END
                       END
PROJEKTI::Used       LONG,THREAD

KOIVUNEN                FILE,DRIVER('dBase3'),NAME(FILENAME1),PRE(KOI),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
PIEG                        STRING(3)
PIEG_KODS                   STRING(22)
MIN_IEP                     REAL,NAME('MIN_IEP=N(4.0)')
CENA                        REAL,NAME('CENA=N(7.3)')
VALUTA                      STRING(3)
VCENA                       REAL
MCENA                       REAL
DATUMS                      DATE
KEKSIS                      STRING(1)
                         END
                       END
KOIVUNEN::Used       LONG,THREAD

CENUVEST                FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('CENUVEST'),PRE(CEN),CREATE,BINDABLE,THREAD
KAT_KEY                  KEY(CEN:KATALOGA_NR,CEN:NOS_U,CEN:DATUMS),DUP,NOCASE,OPT
Record                   RECORD,PRE()
KATALOGA_NR                 STRING(22)
NOS_U                       STRING(3)
SKAITS                      USHORT
CENA                        DECIMAL(9,2)
VALUTA                      STRING(3)
CENA1                       DECIMAL(7,2)
CENA2                       DECIMAL(7,2)
DATUMS                      LONG
KEKSIS                      STRING(1)
                         END
                       END
CENUVEST::Used       LONG,THREAD

CONFIG                  FILE,DRIVER('TOPSPEED'),NAME('\WINLATS\BIN\CONFIG.TPS'),PRE(CON),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(CON:NR),NOCASE,OPT
Record                   RECORD,PRE()
NR                          BYTE
Nosaukums                   STRING(30)
TAKA                        STRING(50)
PAR_END_U_NR                ULONG
AUT_END_U_NR                ULONG
STATUSS                     BYTE
                         END
                       END
CONFIG::Used         LONG,THREAD

PAR_L                   FILE,DRIVER('TOPSPEED'),RECLAIM,PRE(PAL),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(PAL:PAR_NR,PAL:PAL_NR),NOCASE,OPT
Record                   RECORD,PRE()
PAR_NR                      ULONG
PAL_NR                      BYTE
L_DATUMS                    LONG
LIGUMS                      STRING(30)
L_CDATUMS                   LONG
L_SUMMA                     DECIMAL(10,2)
L_SUMMA1                    DECIMAL(10,2)
L_FAILS                     STRING(12)
KOR                         BYTE
BAITS                       BYTE
                         END
                       END
PAR_L::Used          LONG,THREAD

NOM_N                   FILE,DRIVER('TOPSPEED'),NAME('NOM_N'),PRE(NON),CREATE,BINDABLE,THREAD
KAT_KEY                  KEY(NON:NOMENKLAT),DUP,NOCASE
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
STATUSS                     STRING(1)
DAUDZUMS                    USHORT
KOMENTARS                   STRING(50)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
NOM_N::Used          LONG,THREAD

AUTOAPK                 FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(AAPKNAME),PRE(APK),CREATE,BINDABLE,THREAD
PAV_KEY                  KEY(APK:PAV_NR),DUP,NOCASE,OPT
DAT_KEY                  KEY(-APK:DATUMS),DUP,NOCASE,OPT
PAR_KEY                  KEY(APK:PAR_NR),DUP,NOCASE,OPT
AUT_KEY                  KEY(APK:AUT_NR,-APK:DATUMS),DUP,NOCASE,OPT
Record                   RECORD,PRE()
PAV_NR                      ULONG
PAR_NR                      ULONG
AUT_NR                      ULONG
DATUMS                      LONG
PIEN_DAT                    LONG
PLKST                       LONG
Nobraukums                  DECIMAL(7)
CTRL_DATUMS                 LONG
TEKSTS                      STRING(50)
SAVIRZE_P                   DECIMAL(4,2)
SAVIRZE_A                   DECIMAL(4,2)
AMORT_P                     DECIMAL(3),DIM(2)
AMORT_A                     DECIMAL(3),DIM(2)
BREMZES_P                   DECIMAL(3,1),DIM(2)
BREMZES_A                   DECIMAL(3,1),DIM(2)
KAROGI                      STRING(1),DIM(80)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
Diag_TEX                    STRING(50)
                         END
                       END
AUTOAPK::Used        LONG,THREAD

AUTOMARKAS              FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('AUTOMARK'),PRE(AMA),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(AMA:U_NR),NOCASE
KeyMARKA                 KEY(AMA:MARKA),NOCASE,OPT
GNET_KEY                 KEY(AMA:GNET_FLAG),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
MARKA                       STRING(30)
GNET_FLAG                   STRING(2)
                         END
                       END
AUTOMARKAS::Used     LONG,THREAD

CROSSREF                FILE,DRIVER('TOPSPEED'),RECLAIM,PRE(CRO),CREATE,BINDABLE,THREAD
KAT_Key                  KEY(CRO:KATALOGA_NR),DUP,NOCASE
NOM_KEY                  KEY(CRO:NOMENKLAT),DUP,NOCASE,OPT
Record                   RECORD,PRE()
KATALOGA_NR                 STRING(22)
RAZ_K                       STRING(3)
NOS_S                       STRING(16)
NOMENKLAT                   STRING(21)
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
CROSSREF::Used       LONG,THREAD

TEK_SER                 FILE,DRIVER('TOPSPEED'),PRE(TES),CREATE,BINDABLE,THREAD
NOS_KEY                  KEY(TES:TEK_A),DUP,NOCASE,OPT
NR_KEY                   KEY(TES:U_NR),NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
TEK_A                       STRING(7)
TEKSTS                      STRING(110)
                         END
                       END
TEK_SER::Used        LONG,THREAD

NOM_P                   FILE,DRIVER('TOPSPEED'),PRE(NOP),CREATE,BINDABLE,THREAD
NOM_KEY                  KEY(NOP:NOMENKLAT),DUP,NOCASE
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
NOL_NR                      BYTE
PLAUKTS                     STRING(15)
KOMENTARS                   STRING(25)
                         END
                       END
NOM_P::Used          LONG,THREAD

NODALAS                 FILE,DRIVER('TOPSPEED'),PRE(NOD),CREATE,BINDABLE,THREAD
Nr_Key                   KEY(NOD:U_NR),NOCASE,OPT
KODS_KEY                 KEY(NOD:KODS),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        STRING(2)
KODS                        STRING(6)
NOS_P                       STRING(90)
SVARS                       BYTE
BAITS                       BYTE
                         END
                       END
NODALAS::Used        LONG,THREAD

INVENT                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(INVNAME),PRE(INV),CREATE,BINDABLE,THREAD
NOM_KEY                  KEY(INV:NOMENKLAT),NOCASE,OPT
KOD_KEY                  KEY(INV:KODS),NOCASE,OPT
KAT_KEY                  KEY(INV:KATALOGA_NR),DUP,NOCASE
NOS_KEY                  KEY(INV:NOS_A),DUP,NOCASE
Record                   RECORD,PRE()
NOMENKLAT                   STRING(21)
KODS                        DECIMAL(13)
KATALOGA_NR                 STRING(22)
NOSAUKUMS                   STRING(50)
NOS_A                       STRING(6)
CENA                        DECIMAL(11,3)
ATLIKUMS                    DECIMAL(11,3)
ATLIKUMS_F                  DECIMAL(11,3)
X                           BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
INVENT::Used         LONG,THREAD

TEKSTI1                 FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(FILENAME1),PRE(TEX1),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(TEX1:NR),NOCASE
TEX_KEY                  KEY(TEX1:TEX_A),DUP,NOCASE
Record                   RECORD,PRE()
NR                          ULONG
TEKSTS1                     STRING(60)
TEKSTS2                     STRING(60)
TEKSTS3                     STRING(60)
TEX_A                       STRING(5)
KM                          DECIMAL(6,1)
RIK_TIPS                    STRING(1)
BAITS                       BYTE
                         END
                       END
TEKSTI1::Used        LONG,THREAD

ZURFILE                 FILE,DRIVER('ASCII'),NAME(DZFNAME),PRE(ZUF),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
line                        STRING(132)
                         END
                       END
ZURFILE::Used        LONG,THREAD

KAD_RIK                 FILE,DRIVER('TOPSPEED'),PRE(RIK),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(RIK:U_NR),NOCASE,OPT
ID_KEY                   KEY(RIK:ID,-RIK:DATUMS),DUP,NOCASE
DAT_KEY                  KEY(RIK:DATUMS,RIK:DOK_NR),DUP,NOCASE,OPT
DAT_DKEY                 KEY(-RIK:DATUMS,-RIK:DOK_NR),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
ID                          USHORT
TIPS                        STRING(1)
Z_KODS                      BYTE
DATUMS                      LONG
DOK_NR                      STRING(10)
DATUMS1                     LONG
DATUMS2                     LONG
SATURS                      STRING(60)
SATURS1                     STRING(60)
R_FAILS                     STRING(12)
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END
KAD_RIK::Used        LONG,THREAD

AUTOKRA                 FILE,DRIVER('TOPSPEED'),PRE(KRA),CREATE,BINDABLE,THREAD
KRA_Key                  KEY(KRA:KRASA_A),DUP,NOCASE
Record                   RECORD,PRE()
KRASA                       STRING(20)
KRASA_A                     STRING(7)
                         END
                       END
AUTOKRA::Used        LONG,THREAD

EIROKODI                FILE,DRIVER('TOPSPEED'),NAME('\WINLATS\BIN\EIROKODI.TPS'),PRE(EIR),CREATE,BINDABLE,THREAD
Keykods                  KEY(EIR:kods),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
kods                        DECIMAL(9)
nos_s                       STRING(50)
likme                       STRING(20)
papild                      STRING(3)
                         END
                       END
EIROKODI::Used       LONG,THREAD

KON_R                   FILE,DRIVER('TOPSPEED'),NAME(KONRNAME),PRE(KONR),CREATE,BINDABLE,THREAD
UGP_KEY                  KEY(KONR:UGP,KONR:KODS),NOCASE,OPT
Record                   RECORD,PRE()
UGP                         STRING(1)
KODS                        USHORT
USER                        BYTE
Nosaukums                   STRING(100)
NosaukumsA                  STRING(100)
                         END
                       END
KON_R::Used          LONG,THREAD

PROJ_P                  FILE,DRIVER('TOPSPEED'),PRE(PRP),CREATE,BINDABLE,THREAD
Nr_Key                   KEY(PRP:U_NR,-PRP:DATUMS),NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
DATUMS                      DATE
PLANS                       DECIMAL(10,2)
Komentars                   STRING(40)
                         END
                       END
PROJ_P::Used         LONG,THREAD

ARM_K                   FILE,DRIVER('TOPSPEED'),PRE(ARM),CREATE,BINDABLE,THREAD
KODS_KEY                 KEY(ARM:KODS),NOCASE,OPT
LB_KEY                   KEY(ARM:LB),DUP,NOCASE
Record                   RECORD,PRE()
KODS                        DECIMAL(3)
LB                          DECIMAL(3)
NOS_P                       STRING(71)
SATURS1                     STRING(70)
SATURS2                     STRING(70)
SATURS3                     STRING(70)
                         END
                       END
ARM_K::Used          LONG,THREAD

PAM_P                   FILE,DRIVER('TOPSPEED'),PRE(PAP),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(PAP:U_NR),DUP,NOCASE
Record                   RECORD,PRE()
U_NR                        DECIMAL(6)
VIETA                       STRING(25)
KOMENTARS                   STRING(25)
                         END
                       END
PAM_P::Used          LONG,THREAD

Sort:Name STRING(ScrollSort:Name)
Sort:Name:Array STRING(3),DIM(100),OVER(Sort:Name)
Sort:Alpha STRING(ScrollSort:Alpha)
Sort:Alpha:Array STRING(2),DIM(100),OVER(Sort:Alpha)
PrintPreviewQueue    QUEUE,PRE
PrintPreviewImage      STRING(80) !.tmp faila v�rds
                     END
PrintPreviewQueue1    QUEUE,PRE
PrintPreviewImage1      STRING(80)
                     END

A_TABLE              QUEUE,PRE(A)
REFERENCE               STRING(14)
PAR_NR                  ULONG
DATUMS                  LONG
SUMMAV                  DECIMAL(11,2)
SUMMA                   DECIMAL(11,2)
VAL                     STRING(3)
NODALA                  STRING(2)
OBJ_NR                  USHORT
SUMMAV_T                DECIMAL(11,2)  !TAGAD
VAL_T                   STRING(3)      !TAGAD
BKK                     STRING(5)
U_NR                    ULONG
PVN_PROC                BYTE           !15.12.2008
                     .
COMTABLE             QUEUE,PRE(C)
comtext                 STRING(130)
LEN                     USHORT
IN                      BYTE
                     .
VALTABLE             QUEUE,PRE(V)
VAL                     STRING(3)
NR                      BYTE
                     .
GGK_TABLE            QUEUE,PRE(GGT)
PAR_NR                  ULONG
REFERENCE               STRING(14)
D_K                     STRING(1)
SUMMA                   DECIMAL(14,5)  !APA�OJAM PA��S BEIG�S
SUMMAV                  DECIMAL(14,5)
BKK                     STRING(5)
NODALA                  STRING(2)
OBJ_NR                  USHORT
PVN_PROC                BYTE
PVN_TIPS                STRING(1)
VAL                     STRING(3)
KK                      BYTE
                     .
SECURITY_ATT         GROUP(SECURITY_ATTRIBUTES)
                     END
  CODE
  SystemParametersInfo( 38, 0, lCurrentFDSetting, 0 )
  IF lCurrentFDSetting = 1
    SystemParametersInfo( 37, 0, lAdjFDSetting, 3 )
  END
  Main
IF lCurrentFDSetting = 1
  SystemParametersInfo( 37, 1, lAdjFDSetting, 3 )
END
!---------------------------------------------------------------------------

