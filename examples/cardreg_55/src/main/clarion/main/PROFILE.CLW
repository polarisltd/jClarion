  MEMBER
  MAP
    EnterProc(UNSIGNED Line,*CSTRING Proc,*CSTRING File),NAME('Profile:EnterProc')
    LeaveProc(),NAME('Profile:LeaveProc')
  END

Q QUEUE
Line  UNSIGNED
File  STRING(40)
Proc  STRING(40)
Used  LONG
  END


C CLASS
Destruct PROCEDURE
  END

COMPILE('***',profile)
 Don't try and profile this, you get infinate recursion!
 Set profile=>off on this module in the project
***

EnterProc PROCEDURE(unsigned Line,*cstring Proc,*cstring File)
  CODE
    Q.Line = Line
    Q.File = File
    Q.Proc = Proc
    GET(Q,Q.Line,Q.File)
    IF ERRORCODE()
      Q.Used = 1
      ADD(Q,Q.Line,Q.File)
    ELSE
      Q.Used += 1
      PUT(Q)    ! Does not change sort order
    END

LeaveProc PROCEDURE()
  CODE
    ! Could put timing info in here

C.Destruct PROCEDURE
P FILE,DRIVER('ASCII'),CREATE,NAME('Profile')
R RECORD
B STRING(100)
  END
  END
I   LONG,AUTO
  CODE
    SORT(Q,-Q.Used)
    CREATE(P)
    ASSERT(~ERRORCODE())
    OPEN(P)
    ASSERT(~ERRORCODE())
    P.B = ' TopSpeed Profile Output :' &FORMAT(TODAY(),@D2)
    ADD(P)
    P.B = LEFT('Invoked',10)&LEFT('Procedure',30)&LEFT('File',30)&LEFT('Line',10)
    ADD(P)
    P.B = LEFT('=======',10)&LEFT('=========',30)&LEFT('====',30)&LEFT('====',10)
    ADD(P)
    P.B = ''
    ADD(P)
    LOOP I = 1 TO RECORDS(Q)
      GET(Q,I)
      P.B = LEFT(Q.Used,10)&LEFT(Q.Proc,30)&LEFT(Q.File,30)&LEFT(Q.Line,10)
      ADD(P)
    END
    CLOSE(P)
