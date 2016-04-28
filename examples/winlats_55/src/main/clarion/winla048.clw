                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETVAL_K             FUNCTION (VALVAL,REQ)        ! Declare Procedure
  CODE                                            ! Begin processed code
 !
 !  VALVAL - PIEPRASÎTÂ VALÛTA
 !  REQ - 0 ATGRIEÞ TUKÐUMU UN NOTÎRA RECORD
 !        1 IZSAUC BROWSE
 !        2 IZSAUC KÏÛDU
 !
 IF VALVAL='' AND ~REQ   !SPEC
    RETURN('')
 ELSIF VALVAL OR REQ
    IF VAL_K::Used = 0
       CheckOpen(VAL_K,1)
    .
    VAL_K::Used += 1
    CLEAR(VAL:RECORD)
    VAL:VAL=VALVAL
    GET(VAL_K,VAL:NOS_KEY)
    IF ERROR()
       IF REQ = 2
          KLUDA(14,VALVAL)
          CLEAR(VAL:RECORD)
       ELSIF REQ = 1
          globalrequest=Selectrecord
          BROWSEVAL_K
          IF GLOBALRESPONSE=REQUESTCOMPLETED
          ELSE
             CLEAR(VAL:RECORD)
          .
       ELSE
          CLEAR(VAL:RECORD)
       .
    .
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
 ELSE
    RETURN('')
 .
 RETURN(VAL:VAL)
DOS_CONT             FUNCTION (DOS_NAME,RET,<NEW_NR>) ! Declare Procedure
DOSFILES    QUEUE,PRE(A)
NAME   STRING(13)
DATE   LONG
TIME   LONG
SIZE   LONG
ATTRIB BYTE
       .


  CODE                                            ! Begin processed code
 DIRECTORY(DOSFILES,DOS_NAME,FF_:NORMAL)
 IF ERROR() THEN RETURN(0).
 EXECUTE RET                    !1
    BEGIN
       IF RECORDS(DOSFILES)= 0
          A:DATE=0
          A_TIME=0
       ELSE
          SORT(DOSFILES,-A:DATE)
          GET(DOSFILES,1)
          A_TIME=A:TIME         !GLOBAL
       .
       FREE(DOSFILES)
       RETURN(A:DATE)
    .
    BEGIN                       !2
       R#=RECORDS(DOSFILES)
       FREE(DOSFILES)
       RETURN(R#)
    .
    BEGIN                       !3
       IF RECORDS(DOSFILES)
          LOOP I#=1 TO RECORDS(DOSFILES)
             GET(DOSFILES,I#)
             FILENAME1=DOCFOLDERK&'\'&A:NAME
!             STOP(FILENAME1)
             FILENAME2=DOCFOLDERK&'\'&FORMAT(NEW_NR,@N04)&A:NAME[5:LEN(CLIP(A:NAME))]
!             STOP(FILENAME2)
             RENAME(FILENAME1,FILENAME2)
             IF ERROR()
                RETURN(1)
             .
          .
       .
       FREE(DOSFILES)
       RETURN(0)
    .
 .
GetBankas_k          FUNCTION (ban_kods,REQ,RET)  ! Declare Procedure
  CODE                                            ! Begin processed code
 !  REQ - 0 ATGRIEÞ TUKÐUMU UN NOTÎRA RECORD
 !        1 IZSAUC BROWSE
 !        2 IZSAUC KÏÛDU
 !  RET - 1 ATGRIEÞ BAN:NOS_P
 !        2 ATGRIEÞ MAKSAJUMA_TAKA
 !

 IF ~INRANGE(RET,1,2)
    RETURN('')
 .
 IF Ban_Kods OR REQ
    IF BANKAS_K::USED=0
       CHECKOPEN(banKAS_K,1)
    .
    BANKAS_K::USED+=1
    CLEAR(BAN:RECORD)
    BAN:KODS=BAN_KODS
    GET(BANKAS_K,BAN:KOD_KEY)
    IF ERROR()
       IF REQ=2
          KLUDA(17,'Bankas kods:'&ban_kods)
       ELSIF REQ=1
          globalrequest=Selectrecord
          BROWSEBANKAS_K
          IF ~(GLOBALRESPONSE=REQUESTCOMPLETED)
             CLEAR(BAN:RECORD)
          .
       ELSE
          CLEAR(BAN:RECORD)
       .
    .
    BANKAS_K::USED-=1
    IF BANKAS_K::USED=0
       CLOSE(banKAS_K)
    .
 ELSE
    RETURN('')
 .
 EXECUTE RET
    RETURN(BAN:NOS_P)
    RETURN(BAN:MAKSAJUMA_TAKA)
 .
