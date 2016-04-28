! $Header: /0192-7(XML support)/XMLSupport/xLib/XMLTypeInfo.inc 15    10/21/03 12:12p Mal $
!****************************************************************************
!  FILE..........: XMLTypeInfo.inc
!  DESCRIPTION...: 
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  YYYY-MM-DD Description of changes
!****************************************************************************
!Declaration of XMLJoinInfo class that is used to get join structure information
!Declaration of XMLObjectInfo and related classes that are used to get run-time 
!type information and dynamically generate structure 
  OMIT('_EndOfInclude_',_XMLJoinInfo_)

_XMLJoinInfo_       EQUATE(1)
!Enumeration for Clarion types
CLType              EQUATE(unsigned)
              ITEMIZE,PRE(CLType)
BYTE                EQUATE(1)             ! 01
SHORT               EQUATE                ! 02
USHORT              EQUATE                ! 03
DATE                EQUATE                ! 04
TIME                EQUATE                ! 05
LONG                EQUATE                ! 06
ULONG               EQUATE                ! 07
SREAL               EQUATE                ! 08
REAL                EQUATE                ! 09
DECIMAL             EQUATE                ! 0A
PDECIMAL            EQUATE                ! 0B
BFLOAT4             EQUATE(13)            ! 0D
BFLOAT8             EQUATE                ! 0E
UFO                 EQUATE                ! 0F
STRING              EQUATE(18)            ! 12
CSTRING             EQUATE                ! 13
PSTRING             EQUATE                ! 14
MEMO                EQUATE                ! 15 - Invalid in QUEUE
GROUP               EQUATE                ! 16
CLASS               EQUATE                ! 17 - Invalid in QUEUE
QUEUE               EQUATE(26)            ! 1A - Invalid in QUEUE
PICTURE             EQUATE(29)            ! 1D - ?
REFERENCE           EQUATE(31)            ! 1F
FILEREF             EQUATE                ! 20
KEYREF              EQUATE                ! 21
QUEUEREF            EQUATE                ! 22
CLASSREF            EQUATE                ! 23
WINDOWREF           EQUATE                ! 24
VIEWREF             EQUATE                ! 25
BLOBREF             EQUATE                ! 26
NAMEREF             EQUATE                ! 27
LIKE                EQUATE                ! 28
TYPE                EQUATE                ! 29
BSTRING             EQUATE                ! 2A
ASTRING             EQUATE                ! 2B
              END
!Key attributes
CLKEY:DUP           EQUATE(0001h)
CLKEY:OPT           EQUATE(0002h)
CLKEY:NOCASE        EQUATE(0004h)
CLKEY:AUTOINC       EQUATE(0008h)
CLKEY:PRIMARY       EQUATE(0010h)

CLKEY:RUNTIME       EQUATE(0080h)

CLKEY:KEY           EQUATE(0000h)
CLKEY:INDEX         EQUATE(4000h)
CLKEY:DYNINDEX      EQUATE(8000h)

!==============================[ XMLJoinInfo CLASS DEFININITION]=============
XMLJoinInfo   CLASS,TYPE,MODULE('XMLType.CLW'),LINK('XMLType', _XJoinLinkMode_), DLL(_XJoinDllMode_)
xvw                 &xView
viewData            &VIEW
count               UNSIGNED(0), PRIVATE
curFldIdx           UNSIGNED(0), PRIVATE

construct           PROCEDURE
destruct            PROCEDURE   
                    !start iterate of JOINs
startIterate        PROCEDURE, BYTE
                    !Load VIEW run-time type information  
loadInfo            PROCEDURE(*VIEW vw), BYTE
                    !Go to the next JOIN
getNextJoin         PROCEDURE, BYTE
                    !Get the number of nested JOINs
getChilds           PROCEDURE, UNSIGNED
                    !Get number of fields in the JOIN
getFields           PROCEDURE, UNSIGNED
                    !start iterate of fields
startFieldsIterate  PROCEDURE, BYTE
                    !return fields number if 0 - end; if negative - memo
getNextField        PROCEDURE, SIGNED    
                    !get joined FILE structure
getFile             PROCEDURE, *FILE            
              END

!Base class to support run-time type information
!****flags to set mode of iteration
ITER:FIELDONLY  EQUATE(1)
ITER:MEMOONLY   EQUATE(2)
ITER:ALL        EQUATE(3)
!==============================[ XMLObjectInfo CLASS DEFININITION]=============
XMLObjectInfo CLASS,TYPE,MODULE('XMLType.CLW'),LINK('XMLType', _XJoinLinkMode_), DLL(_XJoinDllMode_)
xObj                &xObject
                    !current field
Field               &TDField
writer              &TDWriter
                    !current field index
fieldIdx            UNSIGNED(0),PRIVATE
construct           PROCEDURE
destruct            PROCEDURE
                    !get run-time information about fields
startFieldsIterate  PROCEDURE,BYTE
!***mode can be ITER:FIELDONLY, ITER:MEMOONLY, ITER:ALL
startFieldsIterate  PROCEDURE(BYTE mode),BYTE,VIRTUAL

getNextField        PROCEDURE,BYTE,VIRTUAL
getFieldType        PROCEDURE(*CLType type,*UNSIGNED size,*UNSIGNED precision),BYTE,VIRTUAL 
getFieldLabel       PROCEDURE,STRING,VIRTUAL
!Get field specific information
getFieldInfo        PROCEDURE(*LONG info1,*LONG info2,*LONG info3),BYTE,VIRTUAL
                    !generating structure by specifying types of fields
addField            PROCEDURE(STRING label,CLType type,UNSIGNED size,UNSIGNED precision),BYTE,VIRTUAL
                    !Build structure
build               PROCEDURE,BYTE,VIRTUAL
updateRef           PROCEDURE,VIRTUAL
detachRef           PROCEDURE,VIRTUAL
              END

!For GROUP
!==============================[ XMLGroupInfo CLASS DEFININITION]=============
XMLGroupInfo  CLASS(XMLObjectInfo),TYPE,MODULE('XMLType.CLW'),LINK('XMLType', _XJoinLinkMode_), DLL(_XJoinDllMode_)
groupData           &GROUP
construct           PROCEDURE
init                PROCEDURE(<*GROUP gr>),BYTE 
updateRef           PROCEDURE,VIRTUAL
detachRef           PROCEDURE,VIRTUAL
              END

!For QUEUE
!==============================[ XMLQueueInfo CLASS DEFININITION]=============
XMLQueueInfo  CLASS(XMLObjectInfo),TYPE,MODULE('XMLType.CLW'),LINK('XMLType', _XJoinLinkMode_), DLL(_XJoinDllMode_)
queueData           &QUEUE
construct           PROCEDURE
init                PROCEDURE(<*QUEUE que>),BYTE 
updateRef           PROCEDURE,VIRTUAL
detachRef           PROCEDURE,VIRTUAL
              END
!flags for attributes (see getFieldInfo info3 field)
CLMEMO:MEMO      EQUATE(01h)
CLMEMO:BINARY    EQUATE(02h)
CLMEMO:BLOB      EQUATE(04h)

CLMEMO:RUNTIME   EQUATE(80h)

!For FILE
!==============================[ XMLFileInfo CLASS DEFININITION]=============
XMLFileInfo   CLASS(XMLObjectInfo),TYPE,MODULE('XMLType.CLW'),LINK('XMLType', _XJoinLinkMode_), DLL(_XJoinDllMode_)
fileData            &FILE
mode                BYTE
memoIdx             LONG
memoOnlyIdx         LONG
memok               &xMemoKind          
construct           PROCEDURE
init                PROCEDURE(<*FILE fl>),BYTE 
updateRef           PROCEDURE,VIRTUAL
startFieldsIterate  PROCEDURE(BYTE mode),BYTE,VIRTUAL
getNextField        PROCEDURE,BYTE,VIRTUAL
getFieldType        PROCEDURE(*CLType type,*UNSIGNED size,*UNSIGNED precision),BYTE,VIRTUAL 
getFieldLabel       PROCEDURE,STRING,VIRTUAL
!get specific information
getFieldInfo        PROCEDURE(*LONG info1,*LONG info2,*LONG info3),BYTE,VIRTUAL
                    !get FILE specific information
getKeysCount        PROCEDURE,SIGNED
getKey              PROCEDURE(UNSIGNED cou,*STRING label,*STRING name,*STRING Declaration,*UNSIGNED Attrs),BYTE
                    !add key information
addKey              PROCEDURE(STRING label,STRING name,STRING Declaration,UNSIGNED Attrs),BYTE
                    !Set File Name
setName             PROCEDURE(STRING name),BYTE
                    !Set driver
setDriver           PROCEDURE(STRING Drv,<STRING DrvString>),BYTE
              END

!For VIEW (non hierarchical case)
!==============================[ XMLViewInfo CLASS DEFININITION]=============
XMLViewInfo   CLASS(XMLObjectInfo),TYPE,MODULE('XMLType.CLW'),LINK('XMLType', _XJoinLinkMode_), DLL(_XJoinDllMode_)
vw                  &VIEW
curFile             &FILE
fi                  &XMLFileInfo
construct           PROCEDURE
destruct            PROCEDURE
                    !get run-time information about fields
startFieldsIterate  PROCEDURE(BYTE mode),BYTE,VIRTUAL
getNextField        PROCEDURE,BYTE,VIRTUAL
getFieldType        PROCEDURE(*CLType type,*UNSIGNED size,*UNSIGNED precision),BYTE,VIRTUAL 
getFieldLabel       PROCEDURE,STRING,VIRTUAL
getFieldInfo        PROCEDURE(*LONG info1,*LONG info2,*LONG info3),BYTE,VIRTUAL
                    !generating structure by specifying types of fields
addField            PROCEDURE(STRING label,CLType type,UNSIGNED size,UNSIGNED precision),BYTE,VIRTUAL
                    !Build structure
build               PROCEDURE,BYTE,VIRTUAL
init                PROCEDURE(*VIEW vw),BYTE 
              END

!Error code
XIErr               EQUATE(unsigned)
              ITEMIZE,PRE(XIErr)
NoError             EQUATE(0)
NotSuccessful       EQUATE
IllegalParameter    EQUATE
NotSupported        EQUATE
IllegalObjectState  EQUATE
EOS                 EQUATE !End of sequence (in case of iteration)
InternalError       EQUATE
              END
                
! _EndOfInclude_ 
!** (END OF FILE  : xmlclass.inc) *********************************************