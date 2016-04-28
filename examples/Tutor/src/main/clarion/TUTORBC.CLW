  MEMBER('TUTOR.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('TUTORBC0.CLW')
TUTORBC0:DctInit             PROCEDURE
TUTORBC0:DctKill             PROCEDURE
TUTORBC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  TUTORBC0:DctInit
  TUTORBC0:FilesInit


DctKill PROCEDURE
  CODE
  TUTORBC0:DctKill

