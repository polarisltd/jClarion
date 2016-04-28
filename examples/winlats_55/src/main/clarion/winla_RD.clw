                     MEMBER('winlats.clw')


!--------------------------------------------------
RIDelete:ALGAS       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ALG:ID_KEY)
  LOGOUT(2,ALGAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','ALGAS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(ALG:ID_KEY,Current:Position)
  DELETE(ALGAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'ALGAS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:ALGPA       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ALP:YYYYMM_KEY)
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  LOGOUT(2,ALGPA,ALGAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','ALGPA')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(ALP:YYYYMM_KEY,Current:Position)
  IF RIDelete:ALGPA:ALGAS()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(ALGPA)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'ALGPA')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  ALGAS::Used -= 1
  IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
  EXIT

!--------------------------------------------------
RIDelete:AMATI       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(AMS:AMS_KEY)
  LOGOUT(2,AMATI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AMATI')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(AMS:AMS_KEY,Current:Position)
  DELETE(AMATI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AMATI')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:ARM_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ARM:KODS_KEY)
  LOGOUT(2,ARM_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','ARM_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(ARM:KODS_KEY,Current:Position)
  DELETE(ARM_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'ARM_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:ATL_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ATL:NR_KEY)
  IF ATL_S::Used = 0
    CheckOpen(ATL_S,1)
  END
  ATL_S::Used += 1
  LOGOUT(2,ATL_K,ATL_S)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','ATL_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(ATL:NR_KEY,Current:Position)
  IF RIDelete:ATL_K:ATL_S()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(ATL_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'ATL_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  ATL_S::Used -= 1
  IF ATL_S::Used = 0 THEN CLOSE(ATL_S).
  EXIT

!--------------------------------------------------
RIDelete:ATL_S       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ATS:NR_KEY)
  LOGOUT(2,ATL_S)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','ATL_S')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(ATS:NR_KEY,Current:Position)
  DELETE(ATL_S)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'ATL_S')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AUTO        FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(AUT:NR_KEY)
  LOGOUT(2,AUTO)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AUTO')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(AUT:NR_KEY,Current:Position)
  DELETE(AUTO)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AUTO')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AUTOAPK     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(APK:PAV_KEY)
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  IF AUTOTEX::Used = 0
    CheckOpen(AUTOTEX,1)
  END
  AUTOTEX::Used += 1
  LOGOUT(2,AUTOAPK,AUTODARBI,AUTOTEX)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AUTOAPK')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(APK:PAV_KEY,Current:Position)
  IF RIDelete:AUTOAPK:AUTODARBI()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  IF RIDelete:AUTOAPK:AUTOTEX()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(AUTOAPK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AUTOAPK')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  AUTODARBI::Used -= 1
  IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
  AUTOTEX::Used -= 1
  IF AUTOTEX::Used = 0 THEN CLOSE(AUTOTEX).
  EXIT

!--------------------------------------------------
RIDelete:AUTOAPK1    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(APK1:PAV_KEY)
  LOGOUT(2,AUTOAPK1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AUTOAPK1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(APK1:PAV_KEY,Current:Position)
  DELETE(AUTOAPK1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AUTOAPK1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AUTODARBI   FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(APD:NR_KEY)
  LOGOUT(2,AUTODARBI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AUTODARBI')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(APD:NR_KEY,Current:Position)
  DELETE(AUTODARBI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AUTODARBI')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AUTODARBI1  FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(APD1:NR_KEY)
  LOGOUT(2,AUTODARBI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AUTODARBI1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(APD1:NR_KEY,Current:Position)
  DELETE(AUTODARBI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AUTODARBI1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AUTOKRA     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KRA:KRA_Key)
  LOGOUT(2,AUTOKRA)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AUTOKRA')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KRA:KRA_Key,Current:Position)
  DELETE(AUTOKRA)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AUTOKRA')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AUTOMARKAS  FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(AMA:NR_KEY)
  LOGOUT(2,AUTOMARKAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AUTOMARKAS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(AMA:NR_KEY,Current:Position)
  DELETE(AUTOMARKAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AUTOMARKAS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AUTOTEX     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(APX:NR_KEY)
  LOGOUT(2,AUTOTEX)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AUTOTEX')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(APX:NR_KEY,Current:Position)
  DELETE(AUTOTEX)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AUTOTEX')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AU_BILDE    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(AUB:DAT_KEY)
  LOGOUT(2,AU_BILDE)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AU_BILDE')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(AUB:DAT_KEY,Current:Position)
  DELETE(AU_BILDE)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AU_BILDE')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:AU_TEX      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(AUX:AUT_KEY)
  LOGOUT(2,AU_TEX)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','AU_TEX')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(AUX:AUT_KEY,Current:Position)
  DELETE(AU_TEX)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'AU_TEX')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:BANKAS_K    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(BAN:KOD_KEY)
  LOGOUT(2,BANKAS_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','BANKAS_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(BAN:KOD_KEY,Current:Position)
  DELETE(BANKAS_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'BANKAS_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:B_PAVAD     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(B_PAVAD)
  REGET(B_PAVAD,Current:Position)
  DELETE(B_PAVAD)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'B_PAVAD')
    DO RICloseFiles
    RETURN(1)
  ELSE
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:CAL         FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(CAL:DAT_Key)
  LOGOUT(2,CAL)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','CAL')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(CAL:DAT_Key,Current:Position)
  DELETE(CAL)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'CAL')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:CENUVEST    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(CEN:KAT_KEY)
  LOGOUT(2,CENUVEST)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','CENUVEST')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(CEN:KAT_KEY,Current:Position)
  DELETE(CENUVEST)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'CENUVEST')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:CONFIG      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(CON:NR_KEY)
  LOGOUT(2,CONFIG)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','CONFIG')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(CON:NR_KEY,Current:Position)
  DELETE(CONFIG)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'CONFIG')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:CROSSREF    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(CRO:KAT_Key)
  LOGOUT(2,CROSSREF)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','CROSSREF')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(CRO:KAT_Key,Current:Position)
  DELETE(CROSSREF)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'CROSSREF')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:DAIEV       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(DAI:KOD_KEY)
  LOGOUT(2,DAIEV)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','DAIEV')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(DAI:KOD_KEY,Current:Position)
  DELETE(DAIEV)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'DAIEV')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:EIROKODI    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(EIR:Keykods)
  LOGOUT(2,EIROKODI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','EIROKODI')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(EIR:Keykods,Current:Position)
  DELETE(EIROKODI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'EIROKODI')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:FPNOLIK     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(FPN:NR_KEY)
  LOGOUT(2,FPNOLIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','FPNOLIK')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(FPN:NR_KEY,Current:Position)
  DELETE(FPNOLIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'FPNOLIK')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:FPPAVAD     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(FPP:NR_KEY)
  IF FPNOLIK::Used = 0
    CheckOpen(FPNOLIK,1)
  END
  FPNOLIK::Used += 1
  LOGOUT(2,FPPAVAD,FPNOLIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','FPPAVAD')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(FPP:NR_KEY,Current:Position)
  IF RIDelete:FPPAVAD:FPNOLIK()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(FPPAVAD)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'FPPAVAD')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  FPNOLIK::Used -= 1
  IF FPNOLIK::Used = 0 THEN CLOSE(FPNOLIK).
  EXIT

!--------------------------------------------------
RIDelete:G1          FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(G1:NR_KEY)
  LOGOUT(2,G1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','G1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(G1:NR_KEY,Current:Position)
  DELETE(G1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'G1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:G2          FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(G2:NR_KEY)
  LOGOUT(2,G2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','G2')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(G2:NR_KEY,Current:Position)
  DELETE(G2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'G2')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:GG          FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(GG:NR_KEY)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  LOGOUT(2,GG,GGK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','GG')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(GG:NR_KEY,Current:Position)
  IF RIDelete:GG:GGK()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(GG)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'GG')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  GGK::Used -= 1
  IF GGK::Used = 0 THEN CLOSE(GGK).
  EXIT

!--------------------------------------------------
RIDelete:GGK         FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(GGK:NR_KEY)
  LOGOUT(2,GGK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','GGK')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(GGK:NR_KEY,Current:Position)
  DELETE(GGK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'GGK')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:GK1         FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(GK1:NR_KEY)
  LOGOUT(2,GK1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','GK1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(GK1:NR_KEY,Current:Position)
  DELETE(GK1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'GK1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:GK2         FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(GK2:NR_KEY)
  LOGOUT(2,GK2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','GK2')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(GK2:NR_KEY,Current:Position)
  DELETE(GK2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'GK2')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:GLOBAL      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(GLOBAL)
  LOGOUT(2,GLOBAL)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','GLOBAL')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(GLOBAL,Current:Position)
  DELETE(GLOBAL)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'GLOBAL')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:GRAFIKS     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(GRA:INI_KEY)
  LOGOUT(2,GRAFIKS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','GRAFIKS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(GRA:INI_KEY,Current:Position)
  DELETE(GRAFIKS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'GRAFIKS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:GRUPA1      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(GR1:GR1_KEY)
  IF GRUPA2::Used = 0
    CheckOpen(GRUPA2,1)
  END
  GRUPA2::Used += 1
  LOGOUT(2,GRUPA1,GRUPA2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','GRUPA1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(GR1:GR1_KEY,Current:Position)
  IF RIDelete:GRUPA1:GRUPA2()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(GRUPA1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'GRUPA1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  GRUPA2::Used -= 1
  IF GRUPA2::Used = 0 THEN CLOSE(GRUPA2).
  EXIT

!--------------------------------------------------
RIDelete:GRUPA2      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(GR2:GR1_KEY)
  LOGOUT(2,GRUPA2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','GRUPA2')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(GR2:GR1_KEY,Current:Position)
  DELETE(GRUPA2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'GRUPA2')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:INVENT      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(INV:NOM_KEY)
  LOGOUT(2,INVENT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','INVENT')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(INV:NOM_KEY,Current:Position)
  DELETE(INVENT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'INVENT')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KADRI       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KAD:INI_Key)
  LOGOUT(2,KADRI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','KADRI')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KAD:INI_Key,Current:Position)
  DELETE(KADRI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KADRI')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KAD_RIK     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(RIK:NR_KEY)
  LOGOUT(2,KAD_RIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','KAD_RIK')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(RIK:NR_KEY,Current:Position)
  DELETE(KAD_RIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KAD_RIK')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KAT_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KAT:NR_KEY)
  LOGOUT(2,KAT_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','KAT_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KAT:NR_KEY,Current:Position)
  DELETE(KAT_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KAT_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KLUDAS      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KLU:NR_KEY)
  LOGOUT(2,KLUDAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','KLUDAS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KLU:NR_KEY,Current:Position)
  DELETE(KLUDAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KLUDAS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KOIVUNEN    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KOIVUNEN)
  REGET(KOIVUNEN,Current:Position)
  DELETE(KOIVUNEN)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KOIVUNEN')
    DO RICloseFiles
    RETURN(1)
  ELSE
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KOMPLEKT    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KOM:NOM_KEY)
  LOGOUT(2,KOMPLEKT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','KOMPLEKT')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KOM:NOM_KEY,Current:Position)
  DELETE(KOMPLEKT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KOMPLEKT')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KON_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KON:BKK_KEY)
  LOGOUT(2,KON_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','KON_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KON:BKK_KEY,Current:Position)
  DELETE(KON_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KON_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KON_R       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KONR:UGP_KEY)
  LOGOUT(2,KON_R)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','KON_R')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KONR:UGP_KEY,Current:Position)
  DELETE(KON_R)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KON_R')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:KURSI_K     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KUR:NOS_KEY)
  LOGOUT(2,KURSI_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','KURSI_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KUR:NOS_KEY,Current:Position)
  DELETE(KURSI_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'KURSI_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:MER_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(MER:MER_KEY)
  LOGOUT(2,MER_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','MER_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(MER:MER_KEY,Current:Position)
  DELETE(MER_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'MER_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NODALAS     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NOD:Nr_Key)
  LOGOUT(2,NODALAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NODALAS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NOD:Nr_Key,Current:Position)
  DELETE(NODALAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NODALAS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOLI1       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NO1:NR_KEY)
  LOGOUT(2,NOLI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOLI1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NO1:NR_KEY,Current:Position)
  DELETE(NOLI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOLI1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOLIK       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NOL:NR_KEY)
  LOGOUT(2,NOLIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOLIK')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NOL:NR_KEY,Current:Position)
  DELETE(NOLIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOLIK')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOLPAS      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NOS:NR_KEY)
  LOGOUT(2,NOLPAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOLPAS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NOS:NR_KEY,Current:Position)
  DELETE(NOLPAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOLPAS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOL_FIFO    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(FIFO:NR_KEY)
  LOGOUT(2,NOL_FIFO)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOL_FIFO')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(FIFO:NR_KEY,Current:Position)
  DELETE(NOL_FIFO)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOL_FIFO')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOL_KOPS    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(KOPS:NR_KEY)
  IF NOL_FIFO::Used = 0
    CheckOpen(NOL_FIFO,1)
  END
  NOL_FIFO::Used += 1
  LOGOUT(2,NOL_KOPS,NOL_FIFO)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOL_KOPS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(KOPS:NR_KEY,Current:Position)
  IF RIDelete:NOL_KOPS:NOL_FIFO()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(NOL_KOPS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOL_KOPS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  NOL_FIFO::Used -= 1
  IF NOL_FIFO::Used = 0 THEN CLOSE(NOL_FIFO).
  EXIT

!--------------------------------------------------
RIDelete:NOL_STAT    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(STAT:NOM_key)
  LOGOUT(2,NOL_STAT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOL_STAT')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(STAT:NOM_key,Current:Position)
  DELETE(NOL_STAT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOL_STAT')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOM_A       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NOA:NOM_KEY)
  LOGOUT(2,NOM_A)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOM_A')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NOA:NOM_KEY,Current:Position)
  DELETE(NOM_A)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOM_A')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOM_C       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NOC:NOM_KEY)
  LOGOUT(2,NOM_C)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOM_C')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NOC:NOM_KEY,Current:Position)
  DELETE(NOM_C)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOM_C')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOM_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NOM:NOM_KEY)
  IF KOMPLEKT::Used = 0
    CheckOpen(KOMPLEKT,1)
  END
  KOMPLEKT::Used += 1
  LOGOUT(2,NOM_K,KOMPLEKT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOM_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NOM:NOM_KEY,Current:Position)
  IF RIDelete:NOM_K:KOMPLEKT()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(NOM_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOM_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  KOMPLEKT::Used -= 1
  IF KOMPLEKT::Used = 0 THEN CLOSE(KOMPLEKT).
  EXIT

!--------------------------------------------------
RIDelete:NOM_K1      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NOM1:NOM_KEY)
  LOGOUT(2,NOM_K1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOM_K1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NOM1:NOM_KEY,Current:Position)
  DELETE(NOM_K1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOM_K1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOM_N       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NON:KAT_KEY)
  LOGOUT(2,NOM_N)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOM_N')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NON:KAT_KEY,Current:Position)
  DELETE(NOM_N)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOM_N')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:NOM_P       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(NOP:NOM_KEY)
  LOGOUT(2,NOM_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','NOM_P')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(NOP:NOM_KEY,Current:Position)
  DELETE(NOM_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'NOM_P')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:OUTFILE     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(OUTFILE)
  REGET(OUTFILE,Current:Position)
  DELETE(OUTFILE)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'OUTFILE')
    DO RICloseFiles
    RETURN(1)
  ELSE
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:OUTFILEANSI FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(OUTFILEANSI)
  REGET(OUTFILEANSI,Current:Position)
  DELETE(OUTFILEANSI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'OUTFILEANSI')
    DO RICloseFiles
    RETURN(1)
  ELSE
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAMAM       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(AMO:NR_KEY)
  LOGOUT(2,PAMAM)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAMAM')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(AMO:NR_KEY,Current:Position)
  DELETE(PAMAM)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAMAM')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAMAT       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PAM:DAT_KEY)
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  LOGOUT(2,PAMAT,PAMAM)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAMAT')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PAM:DAT_KEY,Current:Position)
  IF RIDelete:PAMAT:PAMAM()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(PAMAT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAMAT')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  PAMAM::Used -= 1
  IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  EXIT

!--------------------------------------------------
RIDelete:PAMKAT      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PAMKAT)
  LOGOUT(2,PAMKAT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAMKAT')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PAMKAT,Current:Position)
  DELETE(PAMKAT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAMKAT')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAM_P       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PAP:NR_KEY)
  LOGOUT(2,PAM_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAM_P')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PAP:NR_KEY,Current:Position)
  DELETE(PAM_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAM_P')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAROLES     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(SEC:SECURE_KEY)
  LOGOUT(2,PAROLES)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAROLES')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(SEC:SECURE_KEY,Current:Position)
  DELETE(PAROLES)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAROLES')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAR_A       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ADR:NR_KEY)
  LOGOUT(2,PAR_A)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAR_A')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(ADR:NR_KEY,Current:Position)
  DELETE(PAR_A)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAR_A')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAR_E       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(EMA:NR_KEY)
  LOGOUT(2,PAR_E)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAR_E')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(EMA:NR_KEY,Current:Position)
  DELETE(PAR_E)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAR_E')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAR_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PAR:NR_KEY)
  LOGOUT(2,PAR_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAR_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PAR:NR_KEY,Current:Position)
  DELETE(PAR_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAR_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAR_K1      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PAR1:NR_KEY)
  LOGOUT(2,PAR_K1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAR_K1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PAR1:NR_KEY,Current:Position)
  DELETE(PAR_K1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAR_K1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAR_L       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PAL:NR_KEY)
  LOGOUT(2,PAR_L)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAR_L')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PAL:NR_KEY,Current:Position)
  DELETE(PAR_L)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAR_L')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAR_Z       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ATZ:NR_KEY)
  LOGOUT(2,PAR_Z)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAR_Z')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(ATZ:NR_KEY,Current:Position)
  DELETE(PAR_Z)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAR_Z')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAVA1       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PA1:NR_KEY)
  LOGOUT(2,PAVA1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAVA1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PA1:NR_KEY,Current:Position)
  DELETE(PAVA1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAVA1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PAVAD       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PAV:NR_KEY)
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  IF AUTOTEX::Used = 0
    CheckOpen(AUTOTEX,1)
  END
  AUTOTEX::Used += 1
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  LOGOUT(2,PAVAD,AUTOAPK,AUTODARBI,AUTOTEX,NOLIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAVAD')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PAV:NR_KEY,Current:Position)
  IF RIDelete:PAVAD:AUTOAPK()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  IF RIDelete:PAVAD:AUTOTEX()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  IF RIDelete:PAVAD:NOLIK()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(PAVAD)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAVAD')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  AUTOAPK::Used -= 1
  IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
  AUTODARBI::Used -= 1
  IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
  AUTOTEX::Used -= 1
  IF AUTOTEX::Used = 0 THEN CLOSE(AUTOTEX).
  NOLIK::Used -= 1
  IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  EXIT

!--------------------------------------------------
RIDelete:PAVPAS      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PAS:NR_KEY)
  IF NOLPAS::Used = 0
    CheckOpen(NOLPAS,1)
  END
  NOLPAS::Used += 1
  LOGOUT(2,PAVPAS,NOLPAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PAVPAS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PAS:NR_KEY,Current:Position)
  IF RIDelete:PAVPAS:NOLPAS()
    ROLLBACK
    DO RICloseFiles
    RETURN(1)
  END
  DELETE(PAVPAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PAVPAS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  NOLPAS::Used -= 1
  IF NOLPAS::Used = 0 THEN CLOSE(NOLPAS).
  EXIT

!--------------------------------------------------
RIDelete:PERNOS      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PER:ID_KEY)
  LOGOUT(2,PERNOS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PERNOS')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PER:ID_KEY,Current:Position)
  DELETE(PERNOS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PERNOS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PROJEKTI    FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PRO:NR_Key)
  LOGOUT(2,PROJEKTI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PROJEKTI')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PRO:NR_Key,Current:Position)
  DELETE(PROJEKTI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PROJEKTI')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:PROJ_P      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(PRP:Nr_Key)
  LOGOUT(2,PROJ_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','PROJ_P')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(PRP:Nr_Key,Current:Position)
  DELETE(PROJ_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'PROJ_P')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:SYSTEM      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(SYS:NR_KEY)
  LOGOUT(2,SYSTEM)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','SYSTEM')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(SYS:NR_KEY,Current:Position)
  DELETE(SYSTEM)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'SYSTEM')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:TEKSTI      FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(TEX:NR_KEY)
  LOGOUT(2,TEKSTI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','TEKSTI')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(TEX:NR_KEY,Current:Position)
  DELETE(TEKSTI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'TEKSTI')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:TEKSTI1     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(TEX1:NR_KEY)
  LOGOUT(2,TEKSTI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','TEKSTI1')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(TEX1:NR_KEY,Current:Position)
  DELETE(TEKSTI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'TEKSTI1')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:TEK_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(TEK:NR_KEY)
  LOGOUT(2,TEK_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','TEK_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(TEK:NR_KEY,Current:Position)
  DELETE(TEK_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'TEK_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:TEK_SER     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(TES:NOS_KEY)
  LOGOUT(2,TEK_SER)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','TEK_SER')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(TES:NOS_KEY,Current:Position)
  DELETE(TEK_SER)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'TEK_SER')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:VAL_K       FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(VAL:NOS_KEY)
  LOGOUT(2,VAL_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','VAL_K')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(VAL:NOS_KEY,Current:Position)
  DELETE(VAL_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'VAL_K')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:VESTURE     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(VES:CRM_KEY)
  LOGOUT(2,VESTURE)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Delete','VESTURE')
    DO RICloseFiles
    RETURN(1)
  END
  REGET(VES:CRM_KEY,Current:Position)
  DELETE(VESTURE)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'VESTURE')
    DO RICloseFiles
    RETURN(1)
  ELSE
    COMMIT
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:ZURFILE     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ZURFILE)
  REGET(ZURFILE,Current:Position)
  DELETE(ZURFILE)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'ZURFILE')
    DO RICloseFiles
    RETURN(1)
  ELSE
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:ZURNALS     FUNCTION
Current:Position     STRING(512)
  CODE
  Current:Position = POSITION(ZURNALS)
  REGET(ZURNALS,Current:Position)
  DELETE(ZURNALS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:RIDeleteError,'ZURNALS')
    DO RICloseFiles
    RETURN(1)
  ELSE
    DO RICloseFiles
    RETURN(0)
  END
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RIDelete:ALGPA:ALGAS FUNCTION
    CODE
    CLEAR(ALG:Record,0)
    ALG:YYYYMM = ALP:YYYYMM
    CLEAR(ALG:ID,-1)
    SET(ALG:ID_KEY,ALG:ID_KEY)
    LOOP
      NEXT(ALGAS)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'ALGAS')
          RETURN(1)
        END
      END
      IF ALP:YYYYMM <> ALG:YYYYMM
        RETURN(0)
      END
      DELETE(ALGAS)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'ALGAS')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:ATL_K:ATL_S FUNCTION
    CODE
    CLEAR(ATS:Record,0)
    ATS:U_NR = ATL:U_NR
    CLEAR(ATS:NOMENKLAT,-1)
    SET(ATS:NR_KEY,ATS:NR_KEY)
    LOOP
      NEXT(ATL_S)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'ATL_S')
          RETURN(1)
        END
      END
      IF ATL:U_NR <> ATS:U_NR
        RETURN(0)
      END
      DELETE(ATL_S)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'ATL_S')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:AUTOAPK:AUTODARBI FUNCTION
    CODE
    CLEAR(APD:Record,0)
    APD:PAV_NR = APK:PAV_NR
    SET(APD:NR_KEY,APD:NR_KEY)
    LOOP
      NEXT(AUTODARBI)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'AUTODARBI')
          RETURN(1)
        END
      END
      IF APK:PAV_NR <> APD:PAV_NR
        RETURN(0)
      END
      DELETE(AUTODARBI)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'AUTODARBI')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:AUTOAPK:AUTOTEX FUNCTION
    CODE
    CLEAR(APX:Record,0)
    APX:PAV_NR = APK:PAV_NR
    SET(APX:NR_KEY,APX:NR_KEY)
    LOOP
      NEXT(AUTOTEX)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'AUTOTEX')
          RETURN(1)
        END
      END
      IF APK:PAV_NR <> APX:PAV_NR
        RETURN(0)
      END
      DELETE(AUTOTEX)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'AUTOTEX')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:FPPAVAD:FPNOLIK FUNCTION
    CODE
    CLEAR(FPN:Record,0)
    FPN:U_NR = FPP:U_NR
    CLEAR(FPN:SECIBA,1)
    SET(FPN:NR_KEY,FPN:NR_KEY)
    LOOP
      NEXT(FPNOLIK)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'FPNOLIK')
          RETURN(1)
        END
      END
      IF FPP:U_NR <> FPN:U_NR
        RETURN(0)
      END
      DELETE(FPNOLIK)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'FPNOLIK')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:GG:GGK FUNCTION
    CODE
    CLEAR(GGK:Record,0)
    GGK:U_NR = GG:U_NR
    CLEAR(GGK:BKK,-1)
    SET(GGK:NR_KEY,GGK:NR_KEY)
    LOOP
      NEXT(GGK)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'GGK')
          RETURN(1)
        END
      END
      IF GG:U_NR <> GGK:U_NR
        RETURN(0)
      END
      DELETE(GGK)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'GGK')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:GRUPA1:GRUPA2 FUNCTION
    CODE
    CLEAR(GR2:Record,0)
    GR2:GRUPA1 = GR1:GRUPA1
    CLEAR(GR2:GRUPA2,-1)
    SET(GR2:GR1_KEY,GR2:GR1_KEY)
    LOOP
      NEXT(GRUPA2)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'GRUPA2')
          RETURN(1)
        END
      END
      IF GR1:GRUPA1 <> GR2:GRUPA1
        RETURN(0)
      END
      DELETE(GRUPA2)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'GRUPA2')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:NOL_KOPS:NOL_FIFO FUNCTION
    CODE
    CLEAR(FIFO:Record,0)
    FIFO:U_NR = KOPS:U_NR
    CLEAR(FIFO:DATUMS,-1)
    CLEAR(FIFO:D_K,-1)
    SET(FIFO:NR_KEY,FIFO:NR_KEY)
    LOOP
      NEXT(NOL_FIFO)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'NOL_FIFO')
          RETURN(1)
        END
      END
      IF KOPS:U_NR <> FIFO:U_NR
        RETURN(0)
      END
      DELETE(NOL_FIFO)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'NOL_FIFO')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:NOM_K:KOMPLEKT FUNCTION
    CODE
    CLEAR(KOM:Record,0)
    KOM:NOMENKLAT = NOM:NOMENKLAT
    CLEAR(KOM:NOM_SOURCE,-1)
    SET(KOM:NOM_KEY,KOM:NOM_KEY)
    LOOP
      NEXT(KOMPLEKT)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'KOMPLEKT')
          RETURN(1)
        END
      END
      IF NOM:NOMENKLAT <> KOM:NOMENKLAT
        RETURN(0)
      END
      DELETE(KOMPLEKT)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'KOMPLEKT')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:PAMAT:PAMAM FUNCTION
    CODE
    CLEAR(AMO:Record,0)
    AMO:U_NR = PAM:U_NR
    CLEAR(AMO:YYYYMM,-1)
    SET(AMO:NR_KEY,AMO:NR_KEY)
    LOOP
      NEXT(PAMAM)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'PAMAM')
          RETURN(1)
        END
      END
      IF PAM:U_NR <> AMO:U_NR
        RETURN(0)
      END
      DELETE(PAMAM)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'PAMAM')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:PAVAD:AUTOAPK FUNCTION
    CODE
    CLEAR(APK:Record,0)
    APK:PAV_NR = PAV:U_NR
    SET(APK:PAV_KEY,APK:PAV_KEY)
    LOOP
      NEXT(AUTOAPK)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'AUTOAPK')
          RETURN(1)
        END
      END
      IF PAV:U_NR <> APK:PAV_NR
        RETURN(0)
      END
      IF RIDelete:AUTOAPK:AUTODARBI()
        RETURN(1)
      END
      IF RIDelete:AUTOAPK:AUTOTEX()
        RETURN(1)
      END
      DELETE(AUTOAPK)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'AUTOAPK')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:PAVAD:AUTOTEX FUNCTION
    CODE
    CLEAR(APX:Record,0)
    APX:PAV_NR = PAV:U_NR
    SET(APX:NR_KEY,APX:NR_KEY)
    LOOP
      NEXT(AUTOTEX)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'AUTOTEX')
          RETURN(1)
        END
      END
      IF PAV:U_NR <> APX:PAV_NR
        RETURN(0)
      END
      DELETE(AUTOTEX)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'AUTOTEX')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:PAVAD:NOLIK FUNCTION
    CODE
    CLEAR(NOL:Record,0)
    NOL:U_NR = PAV:U_NR
    CLEAR(NOL:NOMENKLAT,-1)
    SET(NOL:NR_KEY,NOL:NR_KEY)
    LOOP
      NEXT(NOLIK)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'NOLIK')
          RETURN(1)
        END
      END
      IF PAV:U_NR <> NOL:U_NR
        RETURN(0)
      END
      DELETE(NOLIK)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'NOLIK')
        RETURN(1)
      END
    END

!--------------------------------------------------
RIDelete:PAVPAS:NOLPAS FUNCTION
    CODE
    CLEAR(NOS:Record,0)
    NOS:U_NR = PAS:U_NR
    CLEAR(NOS:NOMENKLAT,-1)
    SET(NOS:NR_KEY,NOS:NR_KEY)
    LOOP
      NEXT(NOLPAS)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN(0)
        ELSE
          RISaveError
          StandardWarning(Warn:RecordFetchError,'NOLPAS')
          RETURN(1)
        END
      END
      IF PAS:U_NR <> NOS:U_NR
        RETURN(0)
      END
      DELETE(NOLPAS)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIDeleteError,'NOLPAS')
        RETURN(1)
      END
    END
