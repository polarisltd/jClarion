

   MEMBER('TUTOR.clw')                                     ! This is a MEMBER module

                     MAP
                       INCLUDE('TUTOR010.INC'),ONCE        !Local module procedure declarations
                     END


ReportStatesBySTA:KeyState PROCEDURE
  CODE
  GlobalErrors.ThrowMessage(Msg:ProcedureToDo,'ReportStatesBySTA:KeyState') ! This procedure acts as a place holder for a procedure yet to be defined
  SETKEYCODE(0)
  GlobalResponse = RequestCancelled                        ! Request cancelled is the implied action
