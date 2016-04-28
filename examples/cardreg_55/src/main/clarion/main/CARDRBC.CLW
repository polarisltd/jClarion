  MEMBER('Cardreg.clw')

  MAP
    MODULE('CARDRBC0.CLW')
CARDRBC0:DctInit             PROCEDURE
CARDRBC0:DctKill             PROCEDURE
CARDRBC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  CARDRBC0:DctInit
  CARDRBC0:FilesInit


DctKill PROCEDURE
  CODE
  CARDRBC0:DctKill

