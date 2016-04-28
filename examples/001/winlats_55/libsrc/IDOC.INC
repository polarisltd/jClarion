
  OMIT('_EndOfInclude_',_IDOCUMENT_)
_IDOCUMENT_  EQUATE(1)


  INCLUDE('IBLOB.INC'),ONCE
  INCLUDE('ABERROR.INC'),ONCE


Must_Support          EQUATE(80000000h)
Can_Ignore            EQUATE(40000000h)
Doc_Specific          EQUATE(20000000h)


! *** IDoc Types ***
! ******************

IDocIdType            EQUATE(LONG)
IDocMoveType          EQUATE(LONG)

Begin_Format          EQUATE(1)
End_Format            EQUATE(2)
Option_Tag            EQUATE(3)
Data_Tag              EQUATE(4)

                      ITEMIZE(1)
MV_CHILD                EQUATE
MV_BEFORE               EQUATE
MV_AFTER                EQUATE
                      END

!**********************************
!      Constraint Identifiers
!**********************************

                      ITEMIZE(Must_Support + 1)

CS_XLimit               EQUATE
CS_YLimit               EQUATE

CS_Must_Support_Last    EQUATE

                      END

ConstraintInfo        GROUP,TYPE
dwConstraintID          LONG
dwConstraintValue       LONG
                      END

ComponentGroup        GROUP,TYPE
dwID                    LONG
dwParentID              LONG              !Set to 0 if no parent
strFormat               ASTRING
OptFormatValue          &STRING
WrapFormats             &WrapFormatOptQueue
strData                 &STRING
bHadEndOnRead           BYTE
bOptionalEnd            BYTE
                      END

  MAP
  END

!TODO : Support a Named Format

IDocumentCreate     INTERFACE

WriteDocument         PROCEDURE
FlushDocument         PROCEDURE
SetFile               PROCEDURE(STRING strFileName),BYTE,PROC

PutFormat             PROCEDURE(ASTRING strFormat, LONG RelID = 0, IDocMoveType nMoveTo = 0),LONG,PROC
PutFormat             PROCEDURE(ASTRING strFormat, STRING strData, <STRING FormatValue>, LONG RelID = 0, IDocMoveType nMoveTo = 0),LONG,PROC
PutCell               PROCEDURE(LONG dwRow, LONG dwColumn, STRING strData),LONG,PROC

PutOption             PROCEDURE(ASTRING strOptionName, STRING OptionValue, LONG dwComponentID = 0),LONG,PROC

PutData               PROCEDURE(STRING strData),LONG,PROC
PutData               PROCEDURE(IBlobRead InBlob),LONG,PROC
PutData               PROCEDURE(ASTRING strFormat, IBlobRead InBlob, <STRING FormatValue>, LONG RelID = 0, IDocMoveType nMoveTo = 0),LONG,PROC

PutTag                PROCEDURE(ASTRING strName, LONG RelID = 0, IDocMoveType nMoveTo = 0),LONG,PROC
UseTag                PROCEDURE(ASTRING strName, STRING strTagData, LONG RelID = 0, IDocMoveType nMoveTo = 0),LONG,PROC

MoveComponent         PROCEDURE(LONG dwID, LONG RelID, IDocMoveType nMoveTo = 0),BYTE,PROC

                    END


IDocumentCreateSerial INTERFACE

BeginFormat           PROCEDURE(ASTRING strFormat, <STRING FormatValue>)
EndFormat             PROCEDURE(BYTE Missing = 0)

PutOption             PROCEDURE(ASTRING strOptionName, STRING OptionValue)
PutData               PROCEDURE(STRING strData)

Release               PROCEDURE

                    END

!This is a temporary Interface for testing purposes

IDocumentCreateSerialToFile INTERFACE

SetFile               PROCEDURE(STRING strFileName),BYTE,PROC
BeginFormat           PROCEDURE(ASTRING strFormat, <STRING FormatValue>)
EndFormat             PROCEDURE(BYTE Missing = 0)

PutOption             PROCEDURE(ASTRING strOptionName, STRING OptionValue)
PutData               PROCEDURE(STRING strData, BYTE bCRLF = 1)

Release               PROCEDURE

                    END


IDocumentRead       INTERFACE

ReadDocument          PROCEDURE()
SetFile               PROCEDURE(STRING strFileName),BYTE,PROC

GetNextFormat         PROCEDURE(LONG dwLastID),LONG                     !Return Current dwID
GetNextChildFormat    PROCEDURE(LONG dwParentID, LONG dwLastID),LONG    !Return Current dwID
GetFormatInfo         PROCEDURE(LONG dwID, ComponentGroup ComponentInfo),BYTE
!GetOption             PROCEDURE(LONG dwID, ASTRING strOptionName),STRING !?? More thought req here as don't have ID's
HasChildren           PROCEDURE(LONG dwID),BYTE

GetAttachment         PROCEDURE,*IDocumentConstraint                    !Get constraint Interface for Attachments
                                                                        ! ie. MIME support
                    END


IDocumentReadSerial INTERFACE

NextComponent         PROCEDURE,BYTE                                    !False if none
FetchComponentType    PROCEDURE,LONG
FetchComponentLabel   PROCEDURE,ASTRING
FetchComponentValue   PROCEDURE,STRING
Release               PROCEDURE

                    END

IDocumentReadSerialFile INTERFACE(IDocumentReadSerial)
SetFile                   PROCEDURE(STRING FileName),BYTE,PROC
                        END


IDocumentSerialize  INTERFACE
Play                  PROCEDURE(IDocumentCreateSerial OutDoc)
                    END


IDocumentSearch     INTERFACE
Replace               PROCEDURE(*CSTRING szToken, *CSTRING szReplacement),*IDocumentPosition
Find                  PROCEDURE(*CSTRING szToken),*IDocumentPosition
Find                  PROCEDURE(*CSTRING szToken, LONG nStartPos),*IDocumentPosition
Find                  PROCEDURE(*CSTRING szToken, LONG nStartPos, LONG nEndPos),*IDocumentPosition
                    END


IDocumentPosition   INTERFACE
SetSnap               PROCEDURE(LONG SnapX, LONG SnapY)
SetPos                PROCEDURE(IDocIdType Id, LONG X, LONG Y, LONG W, LONG Y)
GetPos                PROCEDURE(IDocIdType Id, *LONG X, *LONG Y, *LONG W, *LONG H),BYTE,PROC
                    END

!**********************************************************************
!
! Purpose:    Must be supported by all IDocument Objects. Determines
!             level of IDocument support and specifies other
!             constraints such as limits etc.
!             The Constraint Interface can also be used to retrieve
!             supported Interfaces.
!
!**********************************************************************

IDocumentConstraint INTERFACE
GetConstraints        PROCEDURE,*QUEUE
GetConstraint         PROCEDURE(LONG Constraint, *LONG ConstraintValue),BYTE
GetCreateInterface    PROCEDURE,*IDocumentCreate
GetCreateSerialInterface PROCEDURE,*IDocumentCreateSerial
GetReadInterface      PROCEDURE,*IDocumentRead
GetSerializeInterface PROCEDURE,*IDocumentSerialize
GetSearchInterface    PROCEDURE,*IDocumentSearch
GetPositionInterface  PROCEDURE,*IDocumentPosition
                    END

  _EndOfInclude_
