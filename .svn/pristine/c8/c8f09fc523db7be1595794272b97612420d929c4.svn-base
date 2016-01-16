  MEMBER('cookbook.clw')

  INCLUDE('abfile.inc'),ONCE

  MAP
COOKBBC0:DctInit    PROCEDURE
COOKBBC0:DctKill    PROCEDURE
COOKBBC0:FilesInit  PROCEDURE
  END

Hide:Access:ingredients CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:ingredients CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:recipe   CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:recipe   CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:rimap    CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:rimap    CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

COOKBBC0:DctInit PROCEDURE
  CODE
  Relate:ingredients &= Hide:Relate:ingredients
  Relate:recipe &= Hide:Relate:recipe
  Relate:rimap &= Hide:Relate:rimap

COOKBBC0:FilesInit PROCEDURE
  CODE
  Hide:Relate:ingredients.Init
  Hide:Relate:recipe.Init
  Hide:Relate:rimap.Init


COOKBBC0:DctKill PROCEDURE
  CODE
  Hide:Relate:ingredients.Kill
  Hide:Relate:recipe.Kill
  Hide:Relate:rimap.Kill


Hide:Access:ingredients.Init PROCEDURE
  CODE
  SELF.Init(ingredients,GlobalErrors)
  SELF.Buffer &= ING:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(ING:Keyid,'ING:Keyid',1)
  SELF.AddKey(ING:Keyname,'ING:Keyname',0)
  Access:ingredients &= SELF


Hide:Relate:ingredients.Init PROCEDURE
  CODE
  Hide:Access:ingredients.Init
  PARENT.Init(Access:ingredients,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:rimap,RI:None,RI:None,RIM:ingrediantkey)
  SELF.AddRelationLink(ING:id,RIM:ingrediant_id)


Hide:Access:ingredients.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ingredients &= NULL


Hide:Relate:ingredients.Kill PROCEDURE

  CODE
  Hide:Access:ingredients.Kill
  PARENT.Kill
  Relate:ingredients &= NULL


Hide:Access:recipe.Init PROCEDURE
  CODE
  SELF.Init(recipe,GlobalErrors)
  SELF.Buffer &= REC:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(REC:Keyid,'REC:Keyid',1)
  SELF.AddKey(REC:Keyname,'REC:Keyname',0)
  SELF.AddKey(REC:Keytype,'REC:Keytype',0)
  Access:recipe &= SELF


Hide:Relate:recipe.Init PROCEDURE
  CODE
  Hide:Access:recipe.Init
  PARENT.Init(Access:recipe,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:rimap,RI:None,RI:None,RIM:recipekey)
  SELF.AddRelationLink(REC:id,RIM:recipe_id)


Hide:Access:recipe.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:recipe &= NULL


Hide:Relate:recipe.Kill PROCEDURE

  CODE
  Hide:Access:recipe.Kill
  PARENT.Kill
  Relate:recipe &= NULL


Hide:Access:rimap.Init PROCEDURE
  CODE
  SELF.Init(rimap,GlobalErrors)
  SELF.Buffer &= RIM:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(RIM:primarykey,'RIM:primarykey',1)
  SELF.AddKey(RIM:recipekey,'RIM:recipekey',0)
  SELF.AddKey(RIM:ingrediantkey,'RIM:ingrediantkey',0)
  Access:rimap &= SELF


Hide:Relate:rimap.Init PROCEDURE
  CODE
  Hide:Access:rimap.Init
  PARENT.Init(Access:rimap,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:recipe)
  SELF.AddRelation(Relate:ingredients)


Hide:Access:rimap.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:rimap &= NULL


Hide:Relate:rimap.Kill PROCEDURE

  CODE
  Hide:Access:rimap.Kill
  PARENT.Kill
  Relate:rimap &= NULL

