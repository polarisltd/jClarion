  MEMBER('musicdb6.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('MUSICBC0.CLW')
MUSICBC0:DctInit             PROCEDURE
MUSICBC0:DctKill             PROCEDURE
MUSICBC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  MUSICBC0:DctInit
  MUSICBC0:FilesInit


DctKill PROCEDURE
  CODE
  MUSICBC0:DctKill

