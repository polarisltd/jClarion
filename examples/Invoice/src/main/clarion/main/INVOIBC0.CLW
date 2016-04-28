  MEMBER('invoice.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
INVOIBC0:DctInit    PROCEDURE
INVOIBC0:DctKill    PROCEDURE
INVOIBC0:FilesInit  PROCEDURE
  END

Hide:Access:States   CLASS(FileManager),TYPE               ! FileManager for States
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


Hide:Relate:States   CLASS(RelationManager),TYPE           ! RelationManager for States
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:Company  CLASS(FileManager),TYPE               ! FileManager for Company
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


Hide:Relate:Company  CLASS(RelationManager),TYPE           ! RelationManager for Company
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:Products CLASS(FileManager),TYPE               ! FileManager for Products
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


Hide:Relate:Products CLASS(RelationManager),TYPE           ! RelationManager for Products
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:InvHist  CLASS(FileManager),TYPE               ! FileManager for InvHist
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
PrimeFields            PROCEDURE(),PROC,DERIVED            ! Method added to host embed code
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:InvHist  CLASS(RelationManager),TYPE           ! RelationManager for InvHist
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:Detail   CLASS(FileManager),TYPE               ! FileManager for Detail
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:Detail   CLASS(RelationManager),TYPE           ! RelationManager for Detail
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:Orders   CLASS(FileManager),TYPE               ! FileManager for Orders
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
PrimeFields            PROCEDURE(),PROC,DERIVED            ! Method added to host embed code
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:Orders   CLASS(RelationManager),TYPE           ! RelationManager for Orders
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:Customers CLASS(FileManager),TYPE              ! FileManager for Customers
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
PrimeFields            PROCEDURE(),PROC,DERIVED            ! Method added to host embed code
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:Customers CLASS(RelationManager),TYPE          ! RelationManager for Customers
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


_Hide:Access:States  &Hide:Access:States,AUTO,THREAD
_Hide:Relate:States  &Hide:Relate:States,AUTO,THREAD
_Hide:Access:Company &Hide:Access:Company,AUTO,THREAD
_Hide:Relate:Company &Hide:Relate:Company,AUTO,THREAD
_Hide:Access:Products &Hide:Access:Products,AUTO,THREAD
_Hide:Relate:Products &Hide:Relate:Products,AUTO,THREAD
_Hide:Access:InvHist &Hide:Access:InvHist,AUTO,THREAD
_Hide:Relate:InvHist &Hide:Relate:InvHist,AUTO,THREAD
_Hide:Access:Detail  &Hide:Access:Detail,AUTO,THREAD
_Hide:Relate:Detail  &Hide:Relate:Detail,AUTO,THREAD
_Hide:Access:Orders  &Hide:Access:Orders,AUTO,THREAD
_Hide:Relate:Orders  &Hide:Relate:Orders,AUTO,THREAD
_Hide:Access:Customers &Hide:Access:Customers,AUTO,THREAD
_Hide:Relate:Customers &Hide:Relate:Customers,AUTO,THREAD


INVOIBC0:DctInit PROCEDURE
  CODE
  _Hide:Access:States &= NEW(Hide:Access:States)
  _Hide:Relate:States &= NEW(Hide:Relate:States)
  _Hide:Access:Company &= NEW(Hide:Access:Company)
  _Hide:Relate:Company &= NEW(Hide:Relate:Company)
  _Hide:Access:Products &= NEW(Hide:Access:Products)
  _Hide:Relate:Products &= NEW(Hide:Relate:Products)
  _Hide:Access:InvHist &= NEW(Hide:Access:InvHist)
  _Hide:Relate:InvHist &= NEW(Hide:Relate:InvHist)
  _Hide:Access:Detail &= NEW(Hide:Access:Detail)
  _Hide:Relate:Detail &= NEW(Hide:Relate:Detail)
  _Hide:Access:Orders &= NEW(Hide:Access:Orders)
  _Hide:Relate:Orders &= NEW(Hide:Relate:Orders)
  _Hide:Access:Customers &= NEW(Hide:Access:Customers)
  _Hide:Relate:Customers &= NEW(Hide:Relate:Customers)
  Relate:States &= _Hide:Relate:States
  Relate:Company &= _Hide:Relate:Company
  Relate:Products &= _Hide:Relate:Products
  Relate:InvHist &= _Hide:Relate:InvHist
  Relate:Detail &= _Hide:Relate:Detail
  Relate:Orders &= _Hide:Relate:Orders
  Relate:Customers &= _Hide:Relate:Customers


INVOIBC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:States.Init
  _Hide:Relate:Company.Init
  _Hide:Relate:Products.Init
  _Hide:Relate:InvHist.Init
  _Hide:Relate:Detail.Init
  _Hide:Relate:Orders.Init
  _Hide:Relate:Customers.Init


INVOIBC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:States.Kill
  DISPOSE(_Hide:Relate:States)
  _Hide:Relate:Company.Kill
  DISPOSE(_Hide:Relate:Company)
  _Hide:Relate:Products.Kill
  DISPOSE(_Hide:Relate:Products)
  _Hide:Relate:InvHist.Kill
  DISPOSE(_Hide:Relate:InvHist)
  _Hide:Relate:Detail.Kill
  DISPOSE(_Hide:Relate:Detail)
  _Hide:Relate:Orders.Kill
  DISPOSE(_Hide:Relate:Orders)
  _Hide:Relate:Customers.Kill
  DISPOSE(_Hide:Relate:Customers)


Hide:Access:States.Init PROCEDURE
  CODE
  SELF.Init(States,GlobalErrors)
  SELF.FileNameValue = 'States'
  SELF.Buffer &= STA:Record
  SELF.LockRecover = 10
  SELF.AddKey(STA:StateCodeKey,'STA:StateCodeKey',0)
  Access:States &= SELF


Hide:Relate:States.Init PROCEDURE
  CODE
  _Hide:Access:States.Init
  SELF.Init(Access:States,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Orders)
  SELF.AddRelation(Relate:Customers)


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


Hide:Access:Company.Init PROCEDURE
  CODE
  SELF.Init(Company,GlobalErrors)
  SELF.FileNameValue = 'Company'
  SELF.Buffer &= COM:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  Access:Company &= SELF


Hide:Relate:Company.Init PROCEDURE
  CODE
  _Hide:Access:Company.Init
  SELF.Init(Access:Company,1)


Hide:Access:Company.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Company &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Relate:Company.Kill PROCEDURE

  CODE
  _Hide:Access:Company.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:Company &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Company)                            ! destroy the file manager


Hide:Access:Products.Init PROCEDURE
  CODE
  SELF.Init(Products,GlobalErrors)
  SELF.FileNameValue = 'Products'
  SELF.Buffer &= PRO:Record
  SELF.LockRecover = 10
  SELF.AddKey(PRO:KeyProductNumber,'PRO:KeyProductNumber',1)
  SELF.AddKey(PRO:KeyProductSKU,'PRO:KeyProductSKU',0)
  SELF.AddKey(PRO:KeyDescription,'PRO:KeyDescription',0)
  Access:Products &= SELF


Hide:Relate:Products.Init PROCEDURE
  CODE
  _Hide:Access:Products.Init
  SELF.Init(Access:Products,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Detail)
  SELF.AddRelation(Relate:InvHist)


Hide:Access:Products.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Products &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Relate:Products.Kill PROCEDURE

  CODE
  _Hide:Access:Products.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:Products &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Products)                           ! destroy the file manager


Hide:Access:InvHist.Init PROCEDURE
  CODE
  SELF.Init(InvHist,GlobalErrors)
  SELF.FileNameValue = 'InvHist'
  SELF.Buffer &= INV:Record
  SELF.LockRecover = 10
  SELF.AddKey(INV:KeyProductNumberDate,'INV:KeyProductNumberDate',0)
  SELF.AddKey(INV:KeyProdNumberDate,'INV:KeyProdNumberDate',0)
  SELF.AddKey(INV:KeyVendorNumberDate,'INV:KeyVendorNumberDate',0)
  Access:InvHist &= SELF


Hide:Relate:InvHist.Init PROCEDURE
  CODE
  _Hide:Access:InvHist.Init
  SELF.Init(Access:InvHist,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Products,RI:None,RI:None,PRO:KeyProductNumber)
  SELF.AddRelationLink(INV:ProductNumber,PRO:ProductNumber)


Hide:Access:InvHist.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:InvHist &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:InvHist.PrimeFields PROCEDURE

  CODE
  INV:Date = today()                                       ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:InvHist.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:Products3     USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('Product Identification Number')
    Save:Products3 = Access:Products.SaveFile()
    PRO:ProductNumber = INV:ProductNumber
    ReturnValue = Access:Products.TryFetch(PRO:KeyProductNumber)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'Products')
      END
    END
    Access:Products.RestoreFile(Save:Products3)
  END
  RETURN ReturnValue


Hide:Relate:InvHist.Kill PROCEDURE

  CODE
  _Hide:Access:InvHist.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:InvHist &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:InvHist)                            ! destroy the file manager


Hide:Access:Detail.Init PROCEDURE
  CODE
  SELF.Init(Detail,GlobalErrors)
  SELF.FileNameValue = 'Detail'
  SELF.Buffer &= DTL:Record
  SELF.LockRecover = 10
  SELF.AddKey(DTL:KeyDetails,'DTL:KeyDetails',3)
  Access:Detail &= SELF


Hide:Relate:Detail.Init PROCEDURE
  CODE
  _Hide:Access:Detail.Init
  SELF.Init(Access:Detail,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Products,RI:None,RI:None,PRO:KeyProductNumber)
  SELF.AddRelationLink(DTL:ProductNumber,PRO:ProductNumber)
  SELF.AddRelation(Relate:Orders)


Hide:Access:Detail.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Detail &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Detail.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:Products4     USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('Line number')
    IF NOT INRANGE(DTL:LineNumber,1,99999.99)
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldOutOfRange,'1 .. 99999.99')
      END
    END
  OF 4
    GlobalErrors.SetField('Product Identification Number')
    Save:Products4 = Access:Products.SaveFile()
    PRO:ProductNumber = DTL:ProductNumber
    ReturnValue = Access:Products.TryFetch(PRO:KeyProductNumber)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'Products')
      END
    END
    Access:Products.RestoreFile(Save:Products4)
  OF 5
    GlobalErrors.SetField('Quantity of product ordered')
    IF NOT INRANGE(DTL:QuantityOrdered,1,99999)
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldOutOfRange,'1 .. 99999')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:Detail.Kill PROCEDURE

  CODE
  _Hide:Access:Detail.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:Detail &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Detail)                             ! destroy the file manager


Hide:Access:Orders.Init PROCEDURE
  CODE
  SELF.Init(Orders,GlobalErrors)
  SELF.Buffer &= ORD:Record
  SELF.LockRecover = 10
  SELF.AddKey(ORD:KeyCustOrderNumber,'ORD:KeyCustOrderNumber',2)
  SELF.AddKey(ORD:InvoiceNumberKey,'ORD:InvoiceNumberKey',1)
  Access:Orders &= SELF


Hide:Relate:Orders.Init PROCEDURE
  CODE
  _Hide:Access:Orders.Init
  SELF.Init(Access:Orders,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Customers)
  SELF.AddRelation(Relate:States,RI:None,RI:None,STA:StateCodeKey)
  SELF.AddRelationLink(ORD:ShipState,STA:StateCode)
  SELF.AddRelation(Relate:Detail,RI:None,RI:CASCADE,DTL:KeyDetails)
  SELF.AddRelationLink(ORD:CustNumber,DTL:CustNumber)
  SELF.AddRelationLink(ORD:OrderNumber,DTL:OrderNumber)


Hide:Access:Orders.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Orders &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Orders.PrimeFields PROCEDURE

  CODE
  ORD:OrderDate = TODAY()                                  ! Assign initial field value
  ORD:ShipState = 'FL'                                     ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:Orders.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:Customers1    USHORT,AUTO
Save:States11      USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 1
    GlobalErrors.SetField('Customer''s Identification Number')
    Save:Customers1 = Access:Customers.SaveFile()
    CUS:CustNumber = ORD:CustNumber
    ReturnValue = Access:Customers.TryFetch(CUS:KeyCustNumber)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'Customers')
      END
    END
    Access:Customers.RestoreFile(Save:Customers1)
  OF 11
    GlobalErrors.SetField('State to ship to')
    Save:States11 = Access:States.SaveFile()
    STA:StateCode = ORD:ShipState
    ReturnValue = Access:States.TryFetch(STA:StateCodeKey)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'States')
      END
    END
    Access:States.RestoreFile(Save:States11)
  END
  RETURN ReturnValue


Hide:Relate:Orders.Kill PROCEDURE

  CODE
  _Hide:Access:Orders.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:Orders &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Orders)                             ! destroy the file manager


Hide:Access:Customers.Init PROCEDURE
  CODE
  SELF.Init(Customers,GlobalErrors)
  SELF.FileNameValue = 'Customers'
  SELF.Buffer &= CUS:Record
  SELF.LockRecover = 10
  SELF.AddKey(CUS:KeyCustNumber,'CUS:KeyCustNumber',1)
  SELF.AddKey(CUS:KeyFullName,'CUS:KeyFullName',0)
  SELF.AddKey(CUS:KeyCompany,'CUS:KeyCompany',0)
  SELF.AddKey(CUS:KeyZipCode,'CUS:KeyZipCode',0)
  SELF.AddKey(CUS:StateKey,'CUS:StateKey',0)
  Access:Customers &= SELF


Hide:Relate:Customers.Init PROCEDURE
  CODE
  _Hide:Access:Customers.Init
  SELF.Init(Access:Customers,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Orders,RI:None,RI:RESTRICT,ORD:KeyCustOrderNumber)
  SELF.AddRelationLink(CUS:CustNumber,ORD:CustNumber)
  SELF.AddRelation(Relate:States,RI:None,RI:None,STA:StateCodeKey)
  SELF.AddRelationLink(CUS:State,STA:StateCode)


Hide:Access:Customers.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Customers &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Customers.PrimeFields PROCEDURE

  CODE
  CUS:State = 'FL'                                         ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:Customers.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:States9       USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 9
    GlobalErrors.SetField('Customer''s State')
    Save:States9 = Access:States.SaveFile()
    STA:StateCode = CUS:State
    ReturnValue = Access:States.TryFetch(STA:StateCodeKey)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'States')
      END
    END
    Access:States.RestoreFile(Save:States9)
  END
  RETURN ReturnValue


Hide:Relate:Customers.Kill PROCEDURE

  CODE
  _Hide:Access:Customers.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:Customers &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Customers)                          ! destroy the file manager

