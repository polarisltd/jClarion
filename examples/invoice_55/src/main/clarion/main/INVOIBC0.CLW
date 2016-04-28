  MEMBER('Invoice.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
INVOIBC0:DctInit    PROCEDURE
INVOIBC0:DctKill    PROCEDURE
INVOIBC0:FilesInit  PROCEDURE
  END

Hide:Access:States   CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:States   CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Company  CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:Company  CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Products CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:Products CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:InvHist  CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:InvHist  CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Detail   CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:Detail   CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Orders   CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:Orders   CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Customers CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:Customers CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

INVOIBC0:DctInit PROCEDURE
  CODE
  Relate:States &= Hide:Relate:States
  Relate:Company &= Hide:Relate:Company
  Relate:Products &= Hide:Relate:Products
  Relate:InvHist &= Hide:Relate:InvHist
  Relate:Detail &= Hide:Relate:Detail
  Relate:Orders &= Hide:Relate:Orders
  Relate:Customers &= Hide:Relate:Customers

INVOIBC0:FilesInit PROCEDURE
  CODE
  Hide:Relate:States.Init
  Hide:Relate:Company.Init
  Hide:Relate:Products.Init
  Hide:Relate:InvHist.Init
  Hide:Relate:Detail.Init
  Hide:Relate:Orders.Init
  Hide:Relate:Customers.Init


INVOIBC0:DctKill PROCEDURE
  CODE
  Hide:Relate:States.Kill
  Hide:Relate:Company.Kill
  Hide:Relate:Products.Kill
  Hide:Relate:InvHist.Kill
  Hide:Relate:Detail.Kill
  Hide:Relate:Orders.Kill
  Hide:Relate:Customers.Kill


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
  Hide:Access:States.Init
  PARENT.Init(Access:States,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Orders)
  SELF.AddRelation(Relate:Customers)


Hide:Access:States.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:States &= NULL


Hide:Relate:States.Kill PROCEDURE

  CODE
  Hide:Access:States.Kill
  PARENT.Kill
  Relate:States &= NULL


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
  Hide:Access:Company.Init
  PARENT.Init(Access:Company,1)


Hide:Access:Company.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Company &= NULL


Hide:Relate:Company.Kill PROCEDURE

  CODE
  Hide:Access:Company.Kill
  PARENT.Kill
  Relate:Company &= NULL


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
  Hide:Access:Products.Init
  PARENT.Init(Access:Products,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Detail)
  SELF.AddRelation(Relate:InvHist)


Hide:Access:Products.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Products &= NULL


Hide:Relate:Products.Kill PROCEDURE

  CODE
  Hide:Access:Products.Kill
  PARENT.Kill
  Relate:Products &= NULL


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
  Hide:Access:InvHist.Init
  PARENT.Init(Access:InvHist,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Products,RI:None,RI:None,PRO:KeyProductNumber)
  SELF.AddRelationLink(INV:ProductNumber,PRO:ProductNumber)


Hide:Access:InvHist.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:InvHist &= NULL


Hide:Access:InvHist.PrimeFields PROCEDURE

  CODE
  INV:Date = today()
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
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'Products')
      END
    END
    Access:Products.RestoreFile(Save:Products3)
  END
  RETURN ReturnValue


Hide:Relate:InvHist.Kill PROCEDURE

  CODE
  Hide:Access:InvHist.Kill
  PARENT.Kill
  Relate:InvHist &= NULL


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
  Hide:Access:Detail.Init
  PARENT.Init(Access:Detail,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Products,RI:None,RI:None,PRO:KeyProductNumber)
  SELF.AddRelationLink(DTL:ProductNumber,PRO:ProductNumber)
  SELF.AddRelation(Relate:Orders)


Hide:Access:Detail.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Detail &= NULL


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
      IF HandleErrors
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
  Hide:Access:Detail.Kill
  PARENT.Kill
  Relate:Detail &= NULL


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
  Hide:Access:Orders.Init
  PARENT.Init(Access:Orders,1)
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
  Access:Orders &= NULL


Hide:Access:Orders.PrimeFields PROCEDURE

  CODE
  ORD:OrderDate = TODAY()
  ORD:ShipState = 'FL'
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
      IF HandleErrors
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
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'States')
      END
    END
    Access:States.RestoreFile(Save:States11)
  END
  RETURN ReturnValue


Hide:Relate:Orders.Kill PROCEDURE

  CODE
  Hide:Access:Orders.Kill
  PARENT.Kill
  Relate:Orders &= NULL


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
  Hide:Access:Customers.Init
  PARENT.Init(Access:Customers,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Orders,RI:None,RI:RESTRICT,ORD:KeyCustOrderNumber)
  SELF.AddRelationLink(CUS:CustNumber,ORD:CustNumber)
  SELF.AddRelation(Relate:States,RI:None,RI:None,STA:StateCodeKey)
  SELF.AddRelationLink(CUS:State,STA:StateCode)


Hide:Access:Customers.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Customers &= NULL


Hide:Access:Customers.PrimeFields PROCEDURE

  CODE
  CUS:State = 'FL'
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
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'States')
      END
    END
    Access:States.RestoreFile(Save:States9)
  END
  RETURN ReturnValue


Hide:Relate:Customers.Kill PROCEDURE

  CODE
  Hide:Access:Customers.Kill
  PARENT.Kill
  Relate:Customers &= NULL

