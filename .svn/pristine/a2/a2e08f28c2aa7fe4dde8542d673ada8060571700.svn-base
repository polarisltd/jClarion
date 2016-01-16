   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('EQUATES.CLW'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE

   MAP
     MODULE('COOKBBC.CLW')
DctInit     PROCEDURE
DctKill     PROCEDURE
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('COOKB001.CLW')
Main                   PROCEDURE   !C55 Wizard Application for D:\example\cookbook.dct
     END
   END

SilentRunning        BYTE(0)                         !Set true when application is running in silent mode

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



Access:ingredients   &FileManager
Relate:ingredients   &RelationManager
Access:recipe        &FileManager
Relate:recipe        &RelationManager
Access:rimap         &FileManager
Relate:rimap         &RelationManager
FuzzyMatcher         FuzzyClass
GlobalErrors         ErrorClass
INIMgr               INIClass
GlobalRequest        BYTE(0),THREAD
GlobalResponse       BYTE(0),THREAD
VCRRequest           LONG(0),THREAD
lCurrentFDSetting    LONG
lAdjFDSetting        LONG

  CODE
  GlobalErrors.Init
  DctInit
  FuzzyMatcher.Init
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)
  INIMgr.Init('cookbook.INI')
  SystemParametersInfo( 38, 0, lCurrentFDSetting, 0 )
  IF lCurrentFDSetting = 1
    SystemParametersInfo( 37, 0, lAdjFDSetting, 3 )
  END
  Main
  INIMgr.Update
  IF lCurrentFDSetting = 1
    SystemParametersInfo( 37, 1, lAdjFDSetting, 3 )
  END
  INIMgr.Kill
  FuzzyMatcher.Kill
  DctKill
  GlobalErrors.Kill


