  MEMBER('TUTOR.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
TUTORBC0:DctInit    PROCEDURE
TUTORBC0:DctKill    PROCEDURE
TUTORBC0:FilesInit  PROCEDURE
  END

Hide:Access:CUSTOMER CLASS(FileManager),TYPE               ! FileManager for CUSTOMER
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CUSTOMER CLASS(RelationManager),TYPE           ! RelationManager for CUSTOMER
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:ORDERS   CLASS(FileManager),TYPE               ! FileManager for ORDERS
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


Hide:Relate:ORDERS   CLASS(RelationManager),TYPE           ! RelationManager for ORDERS
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:States   CLASS(FileManager),TYPE               ! FileManager for States
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


Hide:Relate:States   CLASS(RelationManager),TYPE           ! RelationManager for States
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


_Hide:Access:CUSTOMER &Hide:Access:CUSTOMER,AUTO,THREAD
_Hide:Relate:CUSTOMER &Hide:Relate:CUSTOMER,AUTO,THREAD
_Hide:Access:ORDERS  &Hide:Access:ORDERS,AUTO,THREAD
_Hide:Relate:ORDERS  &Hide:Relate:ORDERS,AUTO,THREAD
_Hide:Access:States  &Hide:Access:States,AUTO,THREAD
_Hide:Relate:States  &Hide:Relate:States,AUTO,THREAD


TUTORBC0:DctInit PROCEDURE
  CODE
  _Hide:Access:CUSTOMER &= NEW(Hide:Access:CUSTOMER)
  _Hide:Relate:CUSTOMER &= NEW(Hide:Relate:CUSTOMER)
  _Hide:Access:ORDERS &= NEW(Hide:Access:ORDERS)
  _Hide:Relate:ORDERS &= NEW(Hide:Relate:ORDERS)
  _Hide:Access:States &= NEW(Hide:Access:States)
  _Hide:Relate:States &= NEW(Hide:Relate:States)
  Relate:CUSTOMER &= _Hide:Relate:CUSTOMER
  Relate:ORDERS &= _Hide:Relate:ORDERS
  Relate:States &= _Hide:Relate:States


TUTORBC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:CUSTOMER.Init
  _Hide:Relate:ORDERS.Init
  _Hide:Relate:States.Init


TUTORBC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:CUSTOMER.Kill
  DISPOSE(_Hide:Relate:CUSTOMER)
  _Hide:Relate:ORDERS.Kill
  DISPOSE(_Hide:Relate:ORDERS)
  _Hide:Relate:States.Kill
  DISPOSE(_Hide:Relate:States)


Hide:Access:CUSTOMER.Init PROCEDURE
  CODE
  SELF.Init(CUSTOMER,GlobalErrors)
  SELF.Buffer &= CUS:Record
  SELF.Create = 0
  SELF.LockRecover = 10
  SELF.AddKey(CUS:KEYCUSTNUMBER,'CUS:KEYCUSTNUMBER',1)
  SELF.AddKey(CUS:KEYCOMPANY,'CUS:KEYCOMPANY',0)
  SELF.AddKey(CUS:KEYZIPCODE,'CUS:KEYZIPCODE',0)
  Access:CUSTOMER &= SELF


Hide:Relate:CUSTOMER.Init PROCEDURE
  CODE
  _Hide:Access:CUSTOMER.Init
  SELF.Init(Access:CUSTOMER,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:States,RI:None,RI:None,STA:KeyState)
  SELF.AddRelationLink(CUS:STATE,STA:State)
  SELF.AddRelation(Relate:ORDERS,RI:CASCADE,RI:CASCADE,ORD:KEYCUSTNUMBER)
  SELF.AddRelationLink(CUS:CUSTNUMBER,ORD:CUSTNUMBER)


Hide:Access:CUSTOMER.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CUSTOMER &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CUSTOMER.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:States7       USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 7
    GlobalErrors.SetField('CUS:STATE')
    Save:States7 = Access:States.SaveFile()
    STA:State = CUS:STATE
    ReturnValue = Access:States.TryFetch(STA:KeyState)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'States')
      END
    END
    Access:States.RestoreFile(Save:States7)
  END
  RETURN ReturnValue


Hide:Relate:CUSTOMER.Kill PROCEDURE

  CODE
  _Hide:Access:CUSTOMER.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:CUSTOMER &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CUSTOMER)                           ! destroy the file manager


Hide:Access:ORDERS.Init PROCEDURE
  CODE
  SELF.Init(ORDERS,GlobalErrors)
  SELF.Buffer &= ORD:Record
  SELF.Create = 0
  SELF.LockRecover = 10
  SELF.AddKey(ORD:KEYORDERNUMBER,'ORD:KEYORDERNUMBER',1)
  SELF.AddKey(ORD:KEYCUSTNUMBER,'ORD:KEYCUSTNUMBER',0)
  Access:ORDERS &= SELF


Hide:Relate:ORDERS.Init PROCEDURE
  CODE
  _Hide:Access:ORDERS.Init
  SELF.Init(Access:ORDERS,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:CUSTOMER)


Hide:Access:ORDERS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ORDERS &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Relate:ORDERS.Kill PROCEDURE

  CODE
  _Hide:Access:ORDERS.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:ORDERS &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ORDERS)                             ! destroy the file manager


Hide:Access:States.Init PROCEDURE
  CODE
  SELF.Init(States,GlobalErrors)
  SELF.FileNameValue = 'States'
  SELF.Buffer &= STA:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(STA:KeyState,'STA:KeyState',0)
  Access:States &= SELF


Hide:Relate:States.Init PROCEDURE
  CODE
  _Hide:Access:States.Init
  SELF.Init(Access:States,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:CUSTOMER)


Hide:Access:States.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:States &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Relate:States.Kill PROCEDURE

  CODE
  _Hide:Access:States.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:States &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:States)                             ! destroy the file manager

