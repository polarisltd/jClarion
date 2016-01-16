   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE

   MAP
     MODULE('Windows API')
SystemParametersInfo PROCEDURE (LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni),LONG,RAW,PROC,PASCAL,DLL(TRUE),NAME('SystemParametersInfoA')
     END
     MODULE('MUSICBC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('MUSIC001.CLW')
Main                   PROCEDURE   !Wizard Application for D:\example\musicdb\musicdb6.dct
     END
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

musician             FILE,DRIVER('ODBC'),OWNER('music'),NAME('musician'),PRE(MUS),CREATE,BINDABLE,THREAD
primarykey               KEY(MUS:id),NOCASE,OPT,PRIMARY
namekey                  KEY(MUS:name),NOCASE,OPT
Record                   RECORD,PRE()
id                          LONG,NAME('id')
name                        STRING(40),NAME('name')
                         END
                     END                       

albumn               FILE,DRIVER('ODBC'),OWNER('music'),NAME('albumn'),PRE(ALB),CREATE,BINDABLE,THREAD
primarkey                KEY(ALB:id),NOCASE,OPT,PRIMARY
namekey                  KEY(ALB:name,ALB:id),DUP,NOCASE,OPT
musiciankey              KEY(ALB:musician_id,ALB:year,ALB:name,ALB:id),DUP,NOCASE,OPT
Record                   RECORD,PRE()
id                          LONG,NAME('id')
name                        STRING(40),NAME('name')
year                        SHORT,NAME('year')
musician_id                 LONG,NAME('musician_id')
                         END
                     END                       



Access:musician      &FileManager,THREAD                   ! FileManager for musician
Relate:musician      &RelationManager,THREAD               ! RelationManager for musician
Access:albumn        &FileManager,THREAD                   ! FileManager for albumn
Relate:albumn        &RelationManager,THREAD               ! RelationManager for albumn

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrors         ErrorClass,THREAD                     ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END

lCurrentFDSetting    LONG                                  ! Used by window frame dragging
lAdjFDSetting        LONG                                  ! ditto

  CODE
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('musicdb6.INI', NVD_INI)                     ! Configure INIManager to use INI file
  SystemParametersInfo (38, 0, lCurrentFDSetting, 0)       ! Configure frame dragging
  IF lCurrentFDSetting = 1
    SystemParametersInfo (37, 0, lAdjFDSetting, 3)
  END
  Main
  INIMgr.Update
  IF lCurrentFDSetting = 1
    SystemParametersInfo (37, 1, lAdjFDSetting, 3)
  END
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  DctInit()


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

