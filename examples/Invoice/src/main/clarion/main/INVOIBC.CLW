  MEMBER('invoice.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('INVOIBC0.CLW')
INVOIBC0:DctInit             PROCEDURE
INVOIBC0:DctKill             PROCEDURE
INVOIBC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  INVOIBC0:DctInit
  INVOIBC0:FilesInit


DctKill PROCEDURE
  CODE
  INVOIBC0:DctKill

