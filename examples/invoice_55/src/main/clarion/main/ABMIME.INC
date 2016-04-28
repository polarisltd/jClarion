
!ABCIncludeFile(MAI)

OMIT('_EndOfInclude_',_MIME64_)
_MIME64_ EQUATE(1)

       INCLUDE('ABFILE.INC'),ONCE
       INCLUDE('ABWINDOW.INC'),ONCE

IEncoder            INTERFACE
Encode               PROCEDURE(IMIMETarget MIMETarget, *CSTRING FilePath, *CSTRING FileName, BYTE Embedded=0)
Encode               PROCEDURE(IMIMETarget MIMETarget, STRING Text,  *CSTRING FileName, BYTE Embedded=0)
GetName              PROCEDURE(),STRING
                    END

NoneFM                CLASS(FileManager),IMPLEMENTS(IEncoder),TYPE,MODULE('ABMIME.CLW'),LINK('ABMIME.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
Name               STRING('no-encoding'),PROTECTED
MIMETarget         &IMIMETarget,PROTECTED
Init                PROCEDURE(ErrorClass ErrorHandler)   !,EXTENDS
Next                PROCEDURE,BYTE,PROC,DERIVED
                      END


QuotedPrintFM         CLASS(FileManager),IMPLEMENTS(IEncoder),TYPE,MODULE('ABMIME.CLW'),LINK('ABMIME.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
Name               STRING('quoted-printable'),PROTECTED
MIMETarget         &IMIMETarget,PROTECTED
EncodeText          PROCEDURE(*STRING In, *String Out, *USHORT LastCRLF),SIGNED ! Bytes put out
DecodeText          PROCEDURE(*STRING In, *String Out),SIGNED ! Bytes out
Init                PROCEDURE(ErrorClass ErrorHandler)   !,EXTENDS
Next                PROCEDURE,BYTE,PROC,DERIVED
Hex                 PROCEDURE(*STRING Str),BYTE,PRIVATE
                      END

Base64FileMgr         CLASS(FileManager),IMPLEMENTS(IEncoder),TYPE,MODULE('ABMIME.CLW'),LINK('ABMIME.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
BytesEncoded       UNSIGNED,PROTECTED
Name               STRING('Base64'),PROTECTED
EncodedString      STRING(76),PROTECTED ! 19 X 4 (6 Bit groups)
DecodedString      STRING(57),PROTECTED ! 19 X 3 (8 Bit groups)
MIMETarget         &IMIMETarget,PROTECTED
Size               UNSIGNED,PROTECTED
Init                PROCEDURE(ErrorClass ErrorHandler)   !,EXTENDS
Next                PROCEDURE,BYTE,PROC,DERIVED
Take24              PROCEDURE(byte h,byte m,byte l,*STRING Into),PROTECTED
Take32              PROCEDURE(*byte h,*byte m,*byte l,*STRING SFrom),PROC,BYTE,PROTECTED ! Returns bytes valid
ToBase64            PROCEDURE(STRING In, *STRING Out),SIGNED,PROTECTED ! Length encoded
FromBase64          PROCEDURE(STRING In, *STRING Out),SIGNED,PROTECTED ! Length decoded
                      END

IMIMETarget      INTERFACE
PutText           PROCEDURE(STRING Text)
                 END

MIMEBQueue       QUEUE,TYPE
ID                ULONG
                 END

AttachmentQueue  QUEUE,TYPE
MD                 &MIMEDoc
Encoder            &IEncoder
ContentType        CSTRING(50)
ContentSubtype     CSTRING(50)
FilePath           CSTRING(FILE:MaxFilePath+1)
FileName           CSTRING(FILE:MaxFileName+1)
Embedded           BYTE
Description        ASTRING
Text               ASTRING
InBody             BYTE
                 END

MIMEVisual            CLASS(WindowManager),TYPE,MODULE('ABMIME.CLW'),LINK('ABMIME.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
AttachmentList     &AttachmentQueue,PROTECTED
Ask                 PROCEDURE(*AttachmentQueue AttachmentList),BYTE,VIRTUAL,PROC
Init                PROCEDURE,BYTE,DERIVED,PROC   !,EXTENDS
Kill                PROCEDURE,BYTE,DERIVED,PROC
                      END

MIMEDoc              CLASS,TYPE,MODULE('ABMIME.CLW'),LINK('ABMIME.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
Attachments        &AttachmentQueue,PROTECTED
Boundary           CSTRING(76),PRIVATE
CharSet            CSTRING(50) ! Move this to .trn
ContentType        CSTRING(50),PROTECTED
ContentSubtype     CSTRING(50),PROTECTED
Description        CSTRING(150)
Embedded           BYTE,PROTECTED
Encoder            &IEncoder,PROTECTED
Errors             &ErrorClass,PROTECTED
FileName           CSTRING(FILE:MaxFileName+1),PROTECTED
FilePath           CSTRING(FILE:MaxFilePath+1),PROTECTED
MPBodyType         CSTRING(50) ! For a multipart body where it contains various bits 'n pieces (alternative\digest..)
PlainEncoder       &IEncoder
Text               ASTRING
TextOnly           BYTE
Version            CSTRING(50)

AttachmentWM       &MIMEVisual,PRIVATE
AddAttachment         PROCEDURE(STRING FilePath, <STRING FileName>, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>, BYTE Embedded=0)
AddAttachmentFromText PROCEDURE(STRING Text, <STRING FileName>, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>, BYTE Embedded=0)
AddBody               PROCEDURE(STRING Text, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>)
AddBodyFromFile       PROCEDURE(STRING FilePath, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>)
AppendBody            PROCEDURE(STRING Text)
Ask                   PROCEDURE,VIRTUAL
CheckContentType      PROCEDURE(*CSTRING ContentType, *CSTRING ContentSubType),PRIVATE
FreeAttachments       PROCEDURE()
Init                  PROCEDURE(ErrorClass ErrorHandler),VIRTUAL
PutData               PROCEDURE(IMIMETarget MIMETarget)
PutData               PROCEDURE(IMIMETarget MIMETarget, MIMEBQueue MBQ)
PutMIMEHeader         PROCEDURE(IMIMETarget MIMETarget, STRING Text),PRIVATE
SetFile               PROCEDURE(STRING FilePath, <STRING FileName>, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>, BYTE Embedded=0),PROTECTED
SetText               PROCEDURE(STRING Text, STRING FileName, <STRING ContentType>, <STRING SubType>, <IEncoder Encoder>, BYTE Embedded=0),PROTECTED
SetContents           PROCEDURE(<STRING ContentType>, <STRING SubType>, <IEncoder Encoder>),PRIVATE
SetAttachmentWin      PROCEDURE(*MIMEVisual WM)
Kill                  PROCEDURE,VIRTUAL
                     END

    ITEMIZE(400),PRE(FEQ)
MimeFirstControl EQUATE
MimeClose        EQUATE(Feq:MimeFirstControl)
MimeInsert       EQUATE
MimeChange       EQUATE
MimeDelete       EQUATE
MimeProperties   EQUATE
MimeList         EQUATE
    END

! NB Keep the Type and SubType Equates below in this format for the supporting templates.
! Content Types
Content:Text         EQUATE('text')
Content:Image        EQUATE('image')
Content:Audio        EQUATE('audio')
Content:Video        EQUATE('video')
Content:Multipart    EQUATE('multipart')
Content:Message      EQUATE('message')
Content:Application  EQUATE('application')
Content:MIME         EQUATE('mime') ! read as is since already encoded.

!* Content:text
SubType:plain        EQUATE('/plain')
SubType:html         EQUATE('/html')

!* Content:multipart
SubType:mixed        EQUATE('/mixed')
SubType:alternative  EQUATE('/alternative')
SubType:digest       EQUATE('/digest')
SubType:parallel     EQUATE('/parallel')
SubType:related      EQUATE('/related')

!* Content:message
SubType:RFC822       EQUATE('/rfc822')
SubType:partial      EQUATE('/partial')
SubType:externalbody EQUATE('/external-body')

!* Content:application
SubType:octetstream  EQUATE('/octet-stream')
SubType:msword       EQUATE('/msword')

!* Content:image
SubType:jpeg         EQUATE('/jpeg')
SubType:gif          EQUATE('/gif')

! General Equates.
CRLF    EQUATE('<13,10>')

_EndOfInclude_
