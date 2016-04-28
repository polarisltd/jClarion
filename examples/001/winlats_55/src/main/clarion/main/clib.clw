
    !CW Low-Level Run-Time API functions
    !Last Revised 09 11 95
    !Copyright 1995 - TopSpeed Corporation

    module('CW_API')
    !Conversions
      AToF(*cstring),real,raw,name('_atof')
      AToI(*cstring),short,raw,name('_atoi')
      AToL(*cstring),long,raw,name('_atol')
      AToUL(*cstring),ulong,raw,name('_atoul')
    !Integer Math
      API_Abs(short),short,name('_abs')            !Renamed to avoid conflict with Builtins.Clw
      LAbs(long),long,name('_labs')
    !Char Type Functions
      ToUpper(short),short,name('_toupper')
      ToLower(short),short,name('_tolower')
      API_IsAlpha(short),short,name('_isalpha')    !Renamed to avoid conflict with Builtins.Clw
      API_IsLower(short),short,name('_islower')    !Renamed to avoid conflict with Builtins.Clw
      API_IsUpper(short),short,name('_isupper')    !Renamed to avoid conflict with Builtins.Clw
      IsAscii(short),short,name('_isascii')
      IsCntrl(short),short,name('_iscntrl')
      IsDigit(short),short,name('_isdigit')
      IsGraph(short),short,name('_isgraph')
      IsPrint(short),short,name('_isprint')
      IsPunct(short),short,name('_ispunct')
      IsSpace(short),short,name('_isspace')
      IsXDigit(short),short,name('_isxdigit')
    !Utility Functions
      Rand(),short,name('_rand')
      SRand(ushort),name('_srand')
    !C++ (nul terminated) String functions
      StrCat(*cstring,*cstring),cstring,raw,name('_strcat')
      StrCmp(*cstring,*cstring),short,raw,name('_strcmp')
      ChrCmp(byte,byte),short,name('_chrcmp')
      StrEqu(*cstring,*cstring),short,raw,name('_strequ')
      StrCpy(*cstring,*cstring),cstring,raw,name('_strcpy')
      StrLen(*cstring),ushort,raw,name('_strlen')
      StrChr(*cstring,short),cstring,raw,name('_strchr')
      StrCSpn(*cstring,*cstring),ushort,raw,name('_strcspn')
      StrError(short),cstring,raw,name('_strerror')
      StrSpn(*cstring,*cstring),ushort,raw,name('_strspn')
      StrStr(*cstring,*cstring),cstring,raw,name('_strstr')
      StrTok(*cstring,*cstring),cstring,raw,name('_strtok')
      StrPBrk(*cstring,*cstring),cstring,raw,name('_strpbrk')
      StrRChr(*cstring,short),cstring,raw,name('_strrchr')
      StrLwr(*cstring),cstring,raw,name('_strlwr')
      StrUpr(*cstring),cstring,raw,name('_strupr')
      StrDup(*cstring),cstring,raw,name('_strdup')
      StrRev(*cstring),cstring,raw,name('_strrev')
      StrNCat(*cstring,*cstring,ushort),cstring,raw,name('_strncat')
      StrNCmp(*cstring,*cstring,ushort),short,raw,name('_strncmp')
      StrNCpy(*cstring,*cstring,ushort),cstring,raw,name('_strncpy')
      StrNICmp(*cstring,*cstring,ushort),short,raw,name('_strnicmp')
    !Low-Level File Manipulation
      Access(*cstring,short),short,raw,name('_access')
      ChMod(*cstring,short),short,raw,name('_chmod')
      API_Remove(*cstring),short,raw,name('_remove')            !Renamed to avoid conflict with Builtins.Clw
      API_Rename(*cstring,*cstring),short,raw,name('_rename')   !Renamed to avoid conflict with Builtins.Clw
      FnMerge(*cstring,*cstring,*cstring,*cstring,*cstring),raw,name('_fnmerge')
      FnSplit(*cstring,*cstring,*cstring,*cstring,*cstring),short,raw,name('_fnsplit')
      MkDir(*cstring),short,raw,name('_mkdir')
      RmDir(*cstring),short,raw,name('_rmdir')
      GetCurDir(short,*cstring),short,raw,name('_getcurdir')
      ChDir(*cstring),short,raw,name('_chdir')
      GetDisk(),short,name('_getdisk')
      SetDisk(short),short,name('_setdisk')
    .

