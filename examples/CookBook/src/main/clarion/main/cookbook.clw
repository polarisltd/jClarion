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
     MODULE('COOKBBC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('COOKB001.CLW')
Main                   PROCEDURE   !C55 Wizard Application for D:\example\cookbook.dct
     END
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

ingredients          FILE,DRIVER('ODBC'),OWNER('cookbook'),NAME('ingredients'),PRE(ING),CREATE,BINDABLE,THREAD
Keyid                    KEY(ING:id),NOCASE,OPT,PRIMARY
Keyname                  KEY(ING:name),DUP,NOCASE
Record                   RECORD,PRE()
id                          LONG
name                        STRING(50)
shelflife                   DECIMAL(5)
cost                        DECIMAL(8,2)
                         END
                     END                       

recipe               FILE,DRIVER('ODBC'),OWNER('cookbook'),NAME('recipe'),PRE(REC),CREATE,BINDABLE,THREAD
Keyid                    KEY(REC:id),NOCASE,OPT,PRIMARY
Keyname                  KEY(REC:name),DUP,NOCASE
Keytype                  KEY(REC:type),DUP,NOCASE
Record                   RECORD,PRE()
id                          LONG
name                        STRING(50)
type                        STRING(30)
preparation                 STRING(255)
cooking                     STRING(255)
cooktime                    DECIMAL(4)
preptime                    DECIMAL(4)
                         END
                     END                       

rimap                FILE,DRIVER('ODBC'),OWNER('cookbook'),NAME('rimap'),PRE(RIM),CREATE,BINDABLE,THREAD
primarykey               KEY(RIM:id),NOCASE,OPT,PRIMARY
recipekey                KEY(RIM:recipe_id,RIM:id),NOCASE,OPT
ingrediantkey            KEY(RIM:ingrediant_id,RIM:id),NOCASE,OPT
Record                   RECORD,PRE()
id                          LONG
recipe_id                   LONG
ingrediant_id               LONG
                         END
                     END                       



Access:ingredients   &FileManager,THREAD                   ! FileManager for ingredients
Relate:ingredients   &RelationManager,THREAD               ! RelationManager for ingredients
Access:recipe        &FileManager,THREAD                   ! FileManager for recipe
Relate:recipe        &RelationManager,THREAD               ! RelationManager for recipe
Access:rimap         &FileManager,THREAD                   ! FileManager for rimap
Relate:rimap         &RelationManager,THREAD               ! RelationManager for rimap

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
  INIMgr.Init('cookbook.INI', NVD_INI)                     ! Configure INIManager to use INI file
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

