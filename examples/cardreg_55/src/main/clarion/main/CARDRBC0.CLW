  MEMBER('Cardreg.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
CARDRBC0:DctInit    PROCEDURE
CARDRBC0:DctKill    PROCEDURE
CARDRBC0:FilesInit  PROCEDURE
  END

Hide:Access:Accounts CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:Accounts CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Transactions CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
                     END


Hide:Relate:Transactions CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

CARDRBC0:DctInit PROCEDURE
  CODE
  Relate:Accounts &= Hide:Relate:Accounts
  Relate:Transactions &= Hide:Relate:Transactions

CARDRBC0:FilesInit PROCEDURE
  CODE
  Hide:Relate:Accounts.Init
  Hide:Relate:Transactions.Init


CARDRBC0:DctKill PROCEDURE
  CODE
  Hide:Relate:Accounts.Kill
  Hide:Relate:Transactions.Kill


Hide:Access:Accounts.Init PROCEDURE
  CODE
  SELF.Init(Accounts,GlobalErrors)
  SELF.FileNameValue = 'Accounts'
  SELF.Buffer &= ACC:Record
  SELF.LockRecover = 10
  SELF.AddKey(ACC:SysIDKey,'ACC:SysIDKey',1)
  SELF.AddKey(ACC:CreditCardVendorKey,'ACC:CreditCardVendorKey',0)
  SELF.AddKey(ACC:AccountNumberKey,'ACC:AccountNumberKey',0)
  Access:Accounts &= SELF


Hide:Relate:Accounts.Init PROCEDURE
  CODE
  Hide:Access:Accounts.Init
  PARENT.Init(Access:Accounts,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Transactions,RI:CASCADE,RI:CASCADE,TRA:SysIDKey)
  SELF.AddRelationLink(ACC:SysID,TRA:SysID)


Hide:Access:Accounts.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Accounts &= NULL


Hide:Access:Accounts.PrimeFields PROCEDURE

  CODE
  ACC:CardType = 'V'
  ACC:BillingDay = 10
  ACC:AccountBalance = 0
  PARENT.PrimeFields


Hide:Access:Accounts.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 15
    GlobalErrors.SetField('ACC:BillingDay')
    IF NOT INRANGE(ACC:BillingDay,1,28)
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldOutOfRange,'1 .. 28')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:Accounts.Kill PROCEDURE

  CODE
  Hide:Access:Accounts.Kill
  PARENT.Kill
  Relate:Accounts &= NULL


Hide:Access:Transactions.Init PROCEDURE
  CODE
  SELF.Init(Transactions,GlobalErrors)
  SELF.FileNameValue = 'Transactions'
  SELF.Buffer &= TRA:Record
  SELF.LockRecover = 10
  SELF.AddKey(TRA:SysIDKey,'TRA:SysIDKey',0)
  SELF.AddKey(TRA:SysIDTypeKey,'TRA:SysIDTypeKey',0)
  SELF.AddKey(TRA:SysIDDateKey,'TRA:SysIDDateKey',0)
  SELF.AddKey(TRA:DateKey,'TRA:DateKey',0)
  SELF.AddKey(TRA:TypeKey,'TRA:TypeKey',0)
  Access:Transactions &= SELF


Hide:Relate:Transactions.Init PROCEDURE
  CODE
  Hide:Access:Transactions.Init
  PARENT.Init(Access:Transactions,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Accounts)


Hide:Access:Transactions.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Transactions &= NULL


Hide:Access:Transactions.PrimeFields PROCEDURE

  CODE
  TRA:DateofTransaction = TODAY()
  TRA:TransactionType = 'C'
  TRA:TransactionAmount = 0
  TRA:ReconciledTransaction = False
  PARENT.PrimeFields


Hide:Relate:Transactions.Kill PROCEDURE

  CODE
  Hide:Access:Transactions.Kill
  PARENT.Kill
  Relate:Transactions &= NULL

