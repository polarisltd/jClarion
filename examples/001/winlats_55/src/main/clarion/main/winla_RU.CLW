                     MEMBER('winlats.clw')

HoldPosition         STRING(512),THREAD
Sav                 GROUP,THREAD
ATL:U_NR               LIKE(ATL:U_NR)
GR1:GRUPA1             LIKE(GR1:GRUPA1)
NOM:NOMENKLAT          LIKE(NOM:NOMENKLAT)
PAM:U_NR               LIKE(PAM:U_NR)
                     END


!--------------------------------------------------
RISnap:ALGAS        PROCEDURE
  CODE

RISaveError PROCEDURE ! added myselves!!!! %%%%%
	CODE ! %%%%%
!--------------------------------------------------
RIUpdate:ALGAS       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,ALGAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','ALGAS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(ALGAS)
  PUT(ALGAS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(ALGAS)
      REGET(ALGAS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'ALGAS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:ALGPA        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:ALGPA       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,ALGPA)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','ALGPA')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(ALGPA)
  PUT(ALGPA)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(ALGPA)
      REGET(ALGPA,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'ALGPA')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AMATI        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AMATI       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AMATI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AMATI')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AMATI)
  PUT(AMATI)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AMATI)
      REGET(AMATI,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AMATI')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:ARM_K        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:ARM_K       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,ARM_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','ARM_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(ARM_K)
  PUT(ARM_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(ARM_K)
      REGET(ARM_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'ARM_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:ATL_K        PROCEDURE
  CODE
  Sav.ATL:U_NR = ATL:U_NR

!--------------------------------------------------
RIUpdate:ATL_K       FUNCTION(BYTE FromForm)
  CODE
  IF ATL_S::Used = 0
    CheckOpen(ATL_S,1)
  END
  ATL_S::Used += 1
  LOGOUT(2,ATL_K,ATL_S)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','ATL_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(ATL_K)
  PUT(ATL_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(ATL_K)
      REGET(ATL_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'ATL_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  IF Sav.ATL:U_NR <> ATL:U_NR
    IF RIUpdate:ATL_K:ATL_S()
      ROLLBACK
      ATS:U_NR = ATL:U_NR
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  ATL_S::Used -= 1
  IF ATL_S::Used = 0 THEN CLOSE(ATL_S).
  EXIT

!--------------------------------------------------
RISnap:ATL_S        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:ATL_S       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,ATL_S)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','ATL_S')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(ATL_S)
  PUT(ATL_S)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(ATL_S)
      REGET(ATL_S,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'ATL_S')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AUTO         PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AUTO        FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AUTO)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AUTO')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AUTO)
  PUT(AUTO)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AUTO)
      REGET(AUTO,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AUTO')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AUTOAPK      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AUTOAPK     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AUTOAPK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AUTOAPK')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AUTOAPK)
  PUT(AUTOAPK)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AUTOAPK)
      REGET(AUTOAPK,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AUTOAPK')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AUTOAPK1     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AUTOAPK1    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AUTOAPK1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AUTOAPK1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AUTOAPK1)
  PUT(AUTOAPK1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AUTOAPK1)
      REGET(AUTOAPK1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AUTOAPK1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AUTODARBI    PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AUTODARBI   FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AUTODARBI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AUTODARBI')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AUTODARBI)
  PUT(AUTODARBI)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AUTODARBI)
      REGET(AUTODARBI,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AUTODARBI')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AUTODARBI1   PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AUTODARBI1  FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AUTODARBI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AUTODARBI1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AUTODARBI1)
  PUT(AUTODARBI1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AUTODARBI1)
      REGET(AUTODARBI1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AUTODARBI1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AUTOKRA      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AUTOKRA     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AUTOKRA)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AUTOKRA')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AUTOKRA)
  PUT(AUTOKRA)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AUTOKRA)
      REGET(AUTOKRA,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AUTOKRA')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AUTOMARKAS   PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AUTOMARKAS  FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AUTOMARKAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AUTOMARKAS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AUTOMARKAS)
  PUT(AUTOMARKAS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AUTOMARKAS)
      REGET(AUTOMARKAS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AUTOMARKAS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AUTOTEX      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AUTOTEX     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AUTOTEX)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AUTOTEX')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AUTOTEX)
  PUT(AUTOTEX)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AUTOTEX)
      REGET(AUTOTEX,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AUTOTEX')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AU_BILDE     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AU_BILDE    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AU_BILDE)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AU_BILDE')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AU_BILDE)
  PUT(AU_BILDE)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AU_BILDE)
      REGET(AU_BILDE,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AU_BILDE')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:AU_TEX       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:AU_TEX      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,AU_TEX)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','AU_TEX')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AU_TEX)
  PUT(AU_TEX)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(AU_TEX)
      REGET(AU_TEX,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'AU_TEX')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:BANKAS_K     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:BANKAS_K    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,BANKAS_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','BANKAS_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(BANKAS_K)
  PUT(BANKAS_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(BANKAS_K)
      REGET(BANKAS_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'BANKAS_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:B_PAVAD      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:B_PAVAD     FUNCTION(BYTE FromForm)
  CODE
  HoldPosition = POSITION(B_PAVAD)
  PUT(B_PAVAD)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(B_PAVAD)
      REGET(B_PAVAD,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'B_PAVAD')
      DO RICloseFiles
      RETURN(1)
    END
  END
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:CAL          PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:CAL         FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,CAL)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','CAL')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(CAL)
  PUT(CAL)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(CAL)
      REGET(CAL,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'CAL')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:CENUVEST     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:CENUVEST    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,CENUVEST)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','CENUVEST')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(CENUVEST)
  PUT(CENUVEST)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(CENUVEST)
      REGET(CENUVEST,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'CENUVEST')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:CONFIG       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:CONFIG      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,CONFIG)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','CONFIG')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(CONFIG)
  PUT(CONFIG)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(CONFIG)
      REGET(CONFIG,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'CONFIG')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:CROSSREF     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:CROSSREF    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,CROSSREF)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','CROSSREF')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(CROSSREF)
  PUT(CROSSREF)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(CROSSREF)
      REGET(CROSSREF,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'CROSSREF')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:DAIEV        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:DAIEV       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,DAIEV)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','DAIEV')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(DAIEV)
  PUT(DAIEV)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(DAIEV)
      REGET(DAIEV,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'DAIEV')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:EIROKODI     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:EIROKODI    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,EIROKODI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','EIROKODI')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(EIR:Keykods)
  PUT(EIROKODI)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(EIROKODI)
      REGET(EIROKODI,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'EIROKODI')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:FPNOLIK      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:FPNOLIK     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,FPNOLIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','FPNOLIK')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(FPNOLIK)
  PUT(FPNOLIK)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(FPNOLIK)
      REGET(FPNOLIK,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'FPNOLIK')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:FPPAVAD      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:FPPAVAD     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,FPPAVAD)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','FPPAVAD')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(FPP:NR_KEY)
  PUT(FPPAVAD)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(FPPAVAD)
      REGET(FPPAVAD,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'FPPAVAD')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:G1           PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:G1          FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,G1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','G1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(G1)
  PUT(G1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(G1)
      REGET(G1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'G1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:G2           PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:G2          FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,G2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','G2')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(G2)
  PUT(G2)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(G2)
      REGET(G2,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'G2')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:GG           PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:GG          FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,GG)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','GG')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(GG)
  PUT(GG)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(GG)
      REGET(GG,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'GG')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:GGK          PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:GGK         FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,GGK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','GGK')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(GGK)
  PUT(GGK)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(GGK)
      REGET(GGK,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'GGK')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:GK1          PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:GK1         FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,GK1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','GK1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(GK1)
  PUT(GK1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(GK1)
      REGET(GK1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'GK1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:GK2          PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:GK2         FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,GK2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','GK2')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(GK2)
  PUT(GK2)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(GK2)
      REGET(GK2,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'GK2')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:GLOBAL       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:GLOBAL      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,GLOBAL)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','GLOBAL')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(GLOBAL)
  PUT(GLOBAL)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(GLOBAL)
      REGET(GLOBAL,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'GLOBAL')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:GRAFIKS      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:GRAFIKS     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,GRAFIKS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','GRAFIKS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(GRAFIKS)
  PUT(GRAFIKS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(GRAFIKS)
      REGET(GRAFIKS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'GRAFIKS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:GRUPA1       PROCEDURE
  CODE
  Sav.GR1:GRUPA1 = GR1:GRUPA1

!--------------------------------------------------
RIUpdate:GRUPA1      FUNCTION(BYTE FromForm)
  CODE
  IF GRUPA2::Used = 0
    CheckOpen(GRUPA2,1)
  END
  GRUPA2::Used += 1
  LOGOUT(2,GRUPA1,GRUPA2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','GRUPA1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(GR1:GR1_KEY)
  PUT(GRUPA1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(GRUPA1)
      REGET(GRUPA1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'GRUPA1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  IF Sav.GR1:GRUPA1 <> GR1:GRUPA1
    IF RIUpdate:GRUPA1:GRUPA2()
      ROLLBACK
      GR2:GRUPA1 = GR1:GRUPA1
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  GRUPA2::Used -= 1
  IF GRUPA2::Used = 0 THEN CLOSE(GRUPA2).
  EXIT

!--------------------------------------------------
RISnap:GRUPA2       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:GRUPA2      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,GRUPA2)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','GRUPA2')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(GRUPA2)
  PUT(GRUPA2)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(GRUPA2)
      REGET(GRUPA2,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'GRUPA2')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:INVENT       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:INVENT      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,INVENT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','INVENT')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(INVENT)
  PUT(INVENT)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(INVENT)
      REGET(INVENT,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'INVENT')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KADRI        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KADRI       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,KADRI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','KADRI')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(KADRI)
  PUT(KADRI)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KADRI)
      REGET(KADRI,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KADRI')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KAD_RIK      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KAD_RIK     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,KAD_RIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','KAD_RIK')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(KAD_RIK)
  PUT(KAD_RIK)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KAD_RIK)
      REGET(KAD_RIK,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KAD_RIK')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KAT_K        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KAT_K       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,KAT_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','KAT_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(KAT_K)
  PUT(KAT_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KAT_K)
      REGET(KAT_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KAT_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KLUDAS       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KLUDAS      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,KLUDAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','KLUDAS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(KLUDAS)
  PUT(KLUDAS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KLUDAS)
      REGET(KLUDAS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KLUDAS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KOIVUNEN     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KOIVUNEN    FUNCTION(BYTE FromForm)
  CODE
  HoldPosition = POSITION(KOIVUNEN)
  PUT(KOIVUNEN)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KOIVUNEN)
      REGET(KOIVUNEN,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KOIVUNEN')
      DO RICloseFiles
      RETURN(1)
    END
  END
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KOMPLEKT     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KOMPLEKT    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,KOMPLEKT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','KOMPLEKT')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(KOMPLEKT)
  PUT(KOMPLEKT)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KOMPLEKT)
      REGET(KOMPLEKT,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KOMPLEKT')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KON_K        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KON_K       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,KON_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','KON_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(KON_K)
  PUT(KON_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KON_K)
      REGET(KON_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KON_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KON_R        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KON_R       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,KON_R)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','KON_R')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(KON_R)
  PUT(KON_R)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KON_R)
      REGET(KON_R,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KON_R')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:KURSI_K      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:KURSI_K     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,KURSI_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','KURSI_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(KURSI_K)
  PUT(KURSI_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(KURSI_K)
      REGET(KURSI_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'KURSI_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:MER_K        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:MER_K       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,MER_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','MER_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(MER_K)
  PUT(MER_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(MER_K)
      REGET(MER_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'MER_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NODALAS      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NODALAS     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NODALAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NODALAS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NODALAS)
  PUT(NODALAS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NODALAS)
      REGET(NODALAS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NODALAS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOLI1        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOLI1       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOLI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOLI1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOLI1)
  PUT(NOLI1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOLI1)
      REGET(NOLI1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOLI1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOLIK        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOLIK       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOLIK)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOLIK')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOLIK)
  PUT(NOLIK)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOLIK)
      REGET(NOLIK,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOLIK')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOLPAS       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOLPAS      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOLPAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOLPAS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOLPAS)
  PUT(NOLPAS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOLPAS)
      REGET(NOLPAS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOLPAS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOL_FIFO     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOL_FIFO    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOL_FIFO)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOL_FIFO')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOL_FIFO)
  PUT(NOL_FIFO)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOL_FIFO)
      REGET(NOL_FIFO,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOL_FIFO')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOL_KOPS     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOL_KOPS    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOL_KOPS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOL_KOPS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOL_KOPS)
  PUT(NOL_KOPS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOL_KOPS)
      REGET(NOL_KOPS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOL_KOPS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOL_STAT     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOL_STAT    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOL_STAT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOL_STAT')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOL_STAT)
  PUT(NOL_STAT)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOL_STAT)
      REGET(NOL_STAT,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOL_STAT')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOM_A        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOM_A       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOM_A)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOM_A')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOM_A)
  PUT(NOM_A)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOM_A)
      REGET(NOM_A,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOM_A')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOM_C        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOM_C       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOM_C)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOM_C')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOM_C)
  PUT(NOM_C)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOM_C)
      REGET(NOM_C,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOM_C')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOM_K        PROCEDURE
  CODE
  Sav.NOM:NOMENKLAT = NOM:NOMENKLAT

!--------------------------------------------------
RIUpdate:NOM_K       FUNCTION(BYTE FromForm)
  CODE
  IF KOMPLEKT::Used = 0
    CheckOpen(KOMPLEKT,1)
  END
  KOMPLEKT::Used += 1
  LOGOUT(2,NOM_K,KOMPLEKT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOM_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOM_K)
  PUT(NOM_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOM_K)
      REGET(NOM_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOM_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  IF Sav.NOM:NOMENKLAT <> NOM:NOMENKLAT
    IF RIUpdate:NOM_K:KOMPLEKT()
      ROLLBACK
      KOM:NOMENKLAT = NOM:NOMENKLAT
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  KOMPLEKT::Used -= 1
  IF KOMPLEKT::Used = 0 THEN CLOSE(KOMPLEKT).
  EXIT

!--------------------------------------------------
RISnap:NOM_K1       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOM_K1      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOM_K1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOM_K1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOM_K1)
  PUT(NOM_K1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOM_K1)
      REGET(NOM_K1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOM_K1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOM_N        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOM_N       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOM_N)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOM_N')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOM_N)
  PUT(NOM_N)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOM_N)
      REGET(NOM_N,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOM_N')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:NOM_P        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:NOM_P       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,NOM_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','NOM_P')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(NOM_P)
  PUT(NOM_P)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(NOM_P)
      REGET(NOM_P,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'NOM_P')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:OUTFILE      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:OUTFILE     FUNCTION(BYTE FromForm)
  CODE
  HoldPosition = POSITION(OUTFILE)
  PUT(OUTFILE)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(OUTFILE)
      REGET(OUTFILE,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'OUTFILE')
      DO RICloseFiles
      RETURN(1)
    END
  END
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:OUTFILEANSI  PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:OUTFILEANSI FUNCTION(BYTE FromForm)
  CODE
  HoldPosition = POSITION(OUTFILEANSI)
  PUT(OUTFILEANSI)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(OUTFILEANSI)
      REGET(OUTFILEANSI,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'OUTFILEANSI')
      DO RICloseFiles
      RETURN(1)
    END
  END
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAMAM        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAMAM       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAMAM)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAMAM')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(AMO:NR_KEY)
  PUT(PAMAM)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAMAM)
      REGET(PAMAM,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAMAM')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAMAT        PROCEDURE
  CODE
  Sav.PAM:U_NR = PAM:U_NR

!--------------------------------------------------
RIUpdate:PAMAT       FUNCTION(BYTE FromForm)
  CODE
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  LOGOUT(2,PAMAT,PAMAM)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAMAT')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAMAT)
  PUT(PAMAT)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAMAT)
      REGET(PAMAT,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAMAT')
      DO RICloseFiles
      RETURN(1)
    END
  END
  IF Sav.PAM:U_NR <> PAM:U_NR
    IF RIUpdate:PAMAT:PAMAM()
      ROLLBACK
      AMO:U_NR = PAM:U_NR
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  PAMAM::Used -= 1
  IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  EXIT

!--------------------------------------------------
RISnap:PAMKAT       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAMKAT      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAMKAT)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAMKAT')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAMKAT)
  PUT(PAMKAT)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAMKAT)
      REGET(PAMKAT,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAMKAT')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAM_P        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAM_P       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAM_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAM_P')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAM_P)
  PUT(PAM_P)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAM_P)
      REGET(PAM_P,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAM_P')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAROLES      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAROLES     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAROLES)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAROLES')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAROLES)
  PUT(PAROLES)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAROLES)
      REGET(PAROLES,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAROLES')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAR_A        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAR_A       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAR_A)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAR_A')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAR_A)
  PUT(PAR_A)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAR_A)
      REGET(PAR_A,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAR_A')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAR_E        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAR_E       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAR_E)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAR_E')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAR_E)
  PUT(PAR_E)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAR_E)
      REGET(PAR_E,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAR_E')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAR_K        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAR_K       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAR_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAR_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAR_K)
  PUT(PAR_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAR_K)
      REGET(PAR_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAR_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAR_K1       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAR_K1      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAR_K1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAR_K1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAR_K1)
  PUT(PAR_K1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAR_K1)
      REGET(PAR_K1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAR_K1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAR_L        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAR_L       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAR_L)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAR_L')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAR_L)
  PUT(PAR_L)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAR_L)
      REGET(PAR_L,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAR_L')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAR_Z        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAR_Z       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAR_Z)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAR_Z')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAR_Z)
  PUT(PAR_Z)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAR_Z)
      REGET(PAR_Z,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAR_Z')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAVA1        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAVA1       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAVA1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAVA1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAVA1)
  PUT(PAVA1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAVA1)
      REGET(PAVA1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAVA1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAVAD        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAVAD       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAVAD)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAVAD')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAVAD)
  PUT(PAVAD)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAVAD)
      REGET(PAVAD,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAVAD')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PAVPAS       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PAVPAS      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PAVPAS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PAVPAS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PAVPAS)
  PUT(PAVPAS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PAVPAS)
      REGET(PAVPAS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PAVPAS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PERNOS       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PERNOS      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PERNOS)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PERNOS')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PERNOS)
  PUT(PERNOS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PERNOS)
      REGET(PERNOS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PERNOS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PROJEKTI     PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PROJEKTI    FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PROJEKTI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PROJEKTI')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PROJEKTI)
  PUT(PROJEKTI)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PROJEKTI)
      REGET(PROJEKTI,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PROJEKTI')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:PROJ_P       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:PROJ_P      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,PROJ_P)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','PROJ_P')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(PROJ_P)
  PUT(PROJ_P)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(PROJ_P)
      REGET(PROJ_P,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'PROJ_P')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:SYSTEM       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:SYSTEM      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,SYSTEM)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','SYSTEM')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(SYSTEM)
  PUT(SYSTEM)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(SYSTEM)
      REGET(SYSTEM,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'SYSTEM')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:TEKSTI       PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:TEKSTI      FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,TEKSTI)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','TEKSTI')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(TEKSTI)
  PUT(TEKSTI)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(TEKSTI)
      REGET(TEKSTI,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'TEKSTI')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:TEKSTI1      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:TEKSTI1     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,TEKSTI1)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','TEKSTI1')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(TEKSTI1)
  PUT(TEKSTI1)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(TEKSTI1)
      REGET(TEKSTI1,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'TEKSTI1')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:TEK_K        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:TEK_K       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,TEK_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','TEK_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(TEK_K)
  PUT(TEK_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(TEK_K)
      REGET(TEK_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'TEK_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:TEK_SER      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:TEK_SER     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,TEK_SER)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','TEK_SER')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(TEK_SER)
  PUT(TEK_SER)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(TEK_SER)
      REGET(TEK_SER,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'TEK_SER')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:VAL_K        PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:VAL_K       FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,VAL_K)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','VAL_K')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(VAL_K)
  PUT(VAL_K)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(VAL_K)
      REGET(VAL_K,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'VAL_K')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:VESTURE      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:VESTURE     FUNCTION(BYTE FromForm)
  CODE
  LOGOUT(2,VESTURE)
  IF ERRORCODE()
    RISaveError
    StandardWarning(Warn:LogoutError,'Update','VESTURE')
    DO RICloseFiles
    RETURN(1)
  END
  HoldPosition = POSITION(VESTURE)
  PUT(VESTURE)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(VESTURE)
      REGET(VESTURE,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'VESTURE')
      DO RICloseFiles
      RETURN(1)
    END
  END
  COMMIT
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:ZURFILE      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:ZURFILE     FUNCTION(BYTE FromForm)
  CODE
  HoldPosition = POSITION(ZURFILE)
  PUT(ZURFILE)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(ZURFILE)
      REGET(ZURFILE,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'ZURFILE')
      DO RICloseFiles
      RETURN(1)
    END
  END
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT

!--------------------------------------------------
RISnap:ZURNALS      PROCEDURE
  CODE

!--------------------------------------------------
RIUpdate:ZURNALS     FUNCTION(BYTE FromForm)
  CODE
  HoldPosition = POSITION(ZURNALS)
  PUT(ZURNALS)
  IF ERRORCODE()
    RISaveError
    IF SaveErrorCode = RecordChangedErr THEN
      IF FromForm THEN
        StandardWarning(Warn:RIFormUpdateError)
      ELSE
        StandardWarning(Warn:RIUpdateError,'Record Changed by Another Station')
      END
      WATCH(ZURNALS)
      REGET(ZURNALS,HoldPosition)
      DO RICloseFiles
      RETURN(2)
    ELSE
      StandardWarning(Warn:RIUpdateError,'ZURNALS')
      DO RICloseFiles
      RETURN(1)
    END
  END
  DO RICloseFiles
  RETURN(0)
!----------------------------------------------------------------------
RICloseFiles ROUTINE
!|
!| This routine is called to close any files opened durint RI processing
!|
  EXIT
!--------------------------------------------------
RIUpdate:ATL_K:ATL_S FUNCTION

    CODE
    CLEAR(ATS:Record,0)
    ATS:U_NR = Sav.ATL:U_NR
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
      IF ATS:U_NR <> Sav.ATL:U_NR
        RETURN(0)
      END
      RISnap:ATL_S
      ATS:U_NR = ATL:U_NR
      PUT(ATL_S)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIUpdateError,'ATL_S')
        RETURN(1)
      END
    END
!--------------------------------------------------
RIUpdate:GRUPA1:GRUPA2 FUNCTION

    CODE
    CLEAR(GR2:Record,0)
    GR2:GRUPA1 = Sav.GR1:GRUPA1
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
      IF GR2:GRUPA1 <> Sav.GR1:GRUPA1
        RETURN(0)
      END
      RISnap:GRUPA2
      GR2:GRUPA1 = GR1:GRUPA1
      PUT(GRUPA2)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIUpdateError,'GRUPA2')
        RETURN(1)
      END
    END
!--------------------------------------------------
RIUpdate:NOM_K:KOMPLEKT FUNCTION

    CODE
    CLEAR(KOM:Record,0)
    KOM:NOMENKLAT = Sav.NOM:NOMENKLAT
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
      IF KOM:NOMENKLAT <> Sav.NOM:NOMENKLAT
        RETURN(0)
      END
      RISnap:KOMPLEKT
      KOM:NOMENKLAT = NOM:NOMENKLAT
      PUT(KOMPLEKT)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIUpdateError,'KOMPLEKT')
        RETURN(1)
      END
    END
!--------------------------------------------------
RIUpdate:PAMAT:PAMAM FUNCTION

    CODE
    CLEAR(AMO:Record,0)
    AMO:U_NR = Sav.PAM:U_NR
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
      IF AMO:U_NR <> Sav.PAM:U_NR
        RETURN(0)
      END
      RISnap:PAMAM
      AMO:U_NR = PAM:U_NR
      PUT(PAMAM)
      IF ERRORCODE()
        RISaveError
        StandardWarning(Warn:RIUpdateError,'PAMAM')
        RETURN(1)
      END
    END
