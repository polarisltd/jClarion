!ABCIncludeFile

OMIT('_EndOfInclude_',_SysShFileOpPresent_)
_SysShFileOpPresent_ EQUATE(1)

! Operation to perform. This member can be one of the following values:

FO_MOVE                      EQUATE(0001h) ! Moves the files specified by pFrom to the location specified by pTo.
FO_COPY                      EQUATE(0002h) ! Copies the files specified by pFrom to the location specified by pTo.
FO_DELETE                    EQUATE(0003h) ! Deletes the files specified by pFrom (pTo is ignored).
FO_RENAME                    EQUATE(0004h) ! Renames the files specified by pFrom.

FOF_MULTIDESTFILES           EQUATE(0001h)  !
FOF_CONFIRMMOUSE             EQUATE(0002h)  !
FOF_SILENT                   EQUATE(0004h)  ! { don't create progress/report }
FOF_RENAMEONCOLLISION        EQUATE(0008h)  !
FOF_NOCONFIRMATION           EQUATE(0010h)  ! { Don't prompt the user. }
FOF_WANTMAPPINGHANDLE        EQUATE(0020h)  ! { Fill in SHFILEOPSTRUCT.hNameMappings
FOF_ALLOWUNDO                EQUATE(0040h)  !
FOF_FILESONLY                EQUATE(0080h)  ! { on *.*, do only files }
FOF_SIMPLEPROGRESS           EQUATE(0100h)  ! { means don't show names of files }
FOF_NOCONFIRMMKDIR           EQUATE(0200h)  ! { don't confirm making any needed dirs }
FOF_NOERRORUI                EQUATE(0400h)  ! { don't put up error UI }

!FOF_ALLOWUNDO          Preserves undo information, if possible.
!FOF_CONFIRMMOUSE       Not implemented.
!FOF_FILESONLY          Performs the operation only on files if a wildcard filename (*.*) is specified.
!FOF_MULTIDESTFILES     Indicates that the pTo member specifies multiple destination files (one for each source file) rather than one directory where all source files are to be deposited.
!FOF_NOCONFIRMATION     Responds with "yes to all" for any dialog box that is displayed.
!FOF_NOCONFIRMMKDIR     Does not confirm the creation of a new directory if the operation requires one to be created.
!FOF_RENAMEONCOLLISION  Gives the file being operated on a new name (such as "Copy #1 of...") in a move, copy, or rename operation if a file of the target name already exists.
!FOF_SILENT             Does not display a progress dialog box.
!FOF_SIMPLEPROGRESS     Displays a progress dialog box, but does not show the filenames.
!FOF_WANTMAPPINGHANDLE  Fills in the hNameMappings member. The handle must be freed by using the SHFreeNameMappings function.

SHFileOpStruct  GROUP,TYPE
hwnd                  ULONG    ! Handle of the dialog box to use to display information about the status of the operation.
wFunc                 ULONG    ! Operation to perform. This member can be one of the following values:
pFrom                 LONG     ! ADDRESS(FromFile) Pointer to a buffer that specifies one or more source file names. Multiple names must be null-separated. The list of names must be double null-terminated.
pTo                   LONG     ! ADDRESS(ToFile) Pointer to a buffer that contains the name of the destination file or directory. The buffer can contain mutiple destination file names if the fFlags member specifies FOF_MULTIDESTFILES.
                               ! Multiple names must be null-separated. The list of names must be double null-terminated.
fFlags                SIGNED   ! Flags that control the file operation. This member can be a combination of the FOF_* values.
!fFlags               USHORT   ! Flags that control the file operation. This member can be a combination of the FOF_* values.
fAnyOperationsAborted LONG     ! Value that receives TRUE if the user aborted any file operations before they were completed or FALSE otherwise.
hNameMappings         ULONG    ! Handle of a filename mapping object that contains an array of SHNAMEMAPPING structures. Each structure contains the old and new path names for each file that was moved, copied, or renamed. This member is used only if fFla
lpscProgressTitle     LONG     ! ADDRESS(ProgressTitle) Pointer to a string to use as the title for a progress dialog box. This member is used only if fFlags includes FOF_SIMPLEPROGRESS.
                 END
! If pFrom or pTo are unqualified names, the current directories are taken from the global current drive and directory settings as managed by the GetCurrentDirectory and SetCurrentDirectory functions.

BIF_RETURNONLYFSDIRS   EQUATE(0001h)   ! For finding a folder to start document searching
BIF_DONTGOBELOWDOMAIN  EQUATE(0002h)   ! For starting the Find Computer
BIF_STATUSTEXT         EQUATE(0004h)
BIF_RETURNFSANCESTORS  EQUATE(0008h)
BIF_EDITBOX            EQUATE(0010h)
BIF_VALIDATE           EQUATE(0020h)   ! insist on valid result (or CANCEL)

BIF_BROWSEFORCOMPUTER  EQUATE(1000h)   ! Browsing for Computers.
BIF_BROWSEFORPRINTER   EQUATE(2000h)   ! Browsing for Printers
BIF_BROWSEINCLUDEFILES EQUATE(4000h)   ! Browsing for Everything

ShBrowseForFolderGroup GROUP,TYPE()
hwndOwner         LONG         ! Handle of owner window
pIDLRoot          LONG         ! Address of an ITEMIDLIST structure specifying the location of the root folder from which to browse. Null gives desktop.
pszDisplayName    LONG         ! Address of a buffer to receive the folder name
lpszTitle         LONG         ! Address of title
ulFlags           LONG         ! BIF_ ... Flags
lpfnCallback      LONG         ! Address of an application-defined function that the dialog box calls when an event occurs. May be null.
lParam            LONG         ! Application-defined value that the dialog box passes to the callback function, if one is specified.
iImage            LONG         ! Variable to receive the image associated with the selected folder.      The image is specified as an index to the system image list.
                END

SysShFileOpClass              CLASS,TYPE,MODULE('VSA_SHFI.CLW'),LINK('VSA_SHFI.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Initialized                     BYTE
Source                          CSTRING(4096),STATIC
Target                          CSTRING(4096),STATIC
ProgressTitle                   CSTRING(4096),STATIC
FileOp                          LIKE(SHFileOpStruct)

! Methods
Init                            PROCEDURE(BYTE RenameOnCollision=0)
Kill                            PROCEDURE()
Exec                            PROCEDURE(ULONG pFunc=FO_COPY),LONG,PRIVATE
! Single filespec commands
Copy                            PROCEDURE(STRING pSource,STRING pTarget),LONG
Move                            PROCEDURE(STRING pSource,STRING pTarget),LONG
Rename                          PROCEDURE(STRING pSource,STRING pTarget),LONG
Delete                          PROCEDURE(STRING pSource,BYTE pRecycle=0),LONG
Recycle                         PROCEDURE(STRING pSource),LONG
EmptyRecycleBin                 PROCEDURE()
! Convert single- to multi-filespec (delimiter is ; or | )
Assign                          PROCEDURE(STRING pSource,STRING pTarget)
ConvertMulti                    PROCEDURE(*STRING pText)
GetFolder                       PROCEDURE(STRING pTitle),STRING
GetFolder                       PROCEDURE(STRING pTitle,STRING pDefault,LONG pFlags=1),STRING
FolderDialog                    PROCEDURE(STRING pTitle,*STRING pFolder,LONG pFlags=1)
                              END

_EndOfInclude_
