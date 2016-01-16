  MEMBER('musicdb6.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
MUSICBC0:DctInit    PROCEDURE
MUSICBC0:DctKill    PROCEDURE
MUSICBC0:FilesInit  PROCEDURE
  END

Hide:Access:musician CLASS(FileManager),TYPE               ! FileManager for musician
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


Hide:Relate:musician CLASS(RelationManager),TYPE           ! RelationManager for musician
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:albumn   CLASS(FileManager),TYPE               ! FileManager for albumn
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


Hide:Relate:albumn   CLASS(RelationManager),TYPE           ! RelationManager for albumn
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


_Hide:Access:musician &Hide:Access:musician,AUTO,THREAD
_Hide:Relate:musician &Hide:Relate:musician,AUTO,THREAD
_Hide:Access:albumn  &Hide:Access:albumn,AUTO,THREAD
_Hide:Relate:albumn  &Hide:Relate:albumn,AUTO,THREAD


MUSICBC0:DctInit PROCEDURE
  CODE
  _Hide:Access:musician &= NEW(Hide:Access:musician)
  _Hide:Relate:musician &= NEW(Hide:Relate:musician)
  _Hide:Access:albumn &= NEW(Hide:Access:albumn)
  _Hide:Relate:albumn &= NEW(Hide:Relate:albumn)
  Relate:musician &= _Hide:Relate:musician
  Relate:albumn &= _Hide:Relate:albumn


MUSICBC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:musician.Init
  _Hide:Relate:albumn.Init


MUSICBC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:musician.Kill
  DISPOSE(_Hide:Relate:musician)
  _Hide:Relate:albumn.Kill
  DISPOSE(_Hide:Relate:albumn)


Hide:Access:musician.Init PROCEDURE
  CODE
  SELF.Init(musician,GlobalErrors)
  SELF.Buffer &= MUS:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(MUS:primarykey,'MUS:primarykey',1)
  SELF.AddKey(MUS:namekey,'MUS:namekey',0)
  Access:musician &= SELF


Hide:Relate:musician.Init PROCEDURE
  CODE
  _Hide:Access:musician.Init
  SELF.Init(Access:musician,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:albumn,RI:None,RI:CASCADE,ALB:musiciankey)
  SELF.AddRelationLink(MUS:id,ALB:musician_id)


Hide:Access:musician.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:musician &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Relate:musician.Kill PROCEDURE

  CODE
  _Hide:Access:musician.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:musician &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:musician)                           ! destroy the file manager


Hide:Access:albumn.Init PROCEDURE
  CODE
  SELF.Init(albumn,GlobalErrors)
  SELF.Buffer &= ALB:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(ALB:primarkey,'ALB:primarkey',1)
  SELF.AddKey(ALB:namekey,'ALB:namekey',0)
  SELF.AddKey(ALB:musiciankey,'ALB:musiciankey',0)
  Access:albumn &= SELF


Hide:Relate:albumn.Init PROCEDURE
  CODE
  _Hide:Access:albumn.Init
  SELF.Init(Access:albumn,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:musician)


Hide:Access:albumn.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:albumn &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Relate:albumn.Kill PROCEDURE

  CODE
  _Hide:Access:albumn.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:albumn &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:albumn)                             ! destroy the file manager

