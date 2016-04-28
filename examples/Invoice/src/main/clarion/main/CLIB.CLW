
    !CW Low-Level Run-Time API functions
    !Last Revised 09 11 95
    !Copyright 1995 - TopSpeed Corporation

    module('CW_API')
    !Conversions
      AToF(*cstring),real,raw,name('_atof')
      AToI(*cstring),signed,raw,name('_atoi')
      AToL(*cstring),long,raw,name('_atol')
      AToUL(*cstring),ulong,raw,name('_atoul')
    !Integer Math
      API_Abs(signed),signed,name('_abs')            !Renamed to avoid conflict with Builtins.Clw
      LAbs(long),long,name('_labs')
    !Char Type Functions
      ToUpper(signed),signed,name('_toupper')
      ToLower(signed),signed,name('_tolower')
      API_IsAlpha(signed),signed,name('_isalpha')    !Renamed to avoid conflict with Builtins.Clw
      API_IsLower(signed),signed,name('_islower')    !Renamed to avoid conflict with Builtins.Clw
      API_IsUpper(signed),signed,name('_isupper')    !Renamed to avoid conflict with Builtins.Clw
      IsAscii(signed),signed,name('_isascii')
      IsCntrl(signed),signed,name('_iscntrl')
      IsDigit(signed),signed,name('_isdigit')
      IsGraph(signed),signed,name('_isgraph')
      IsPrint(signed),signed,name('_isprint')
      IsPunct(signed),signed,name('_ispunct')
      IsSpace(signed),signed,name('_isspace')
      IsXDigit(signed),signed,name('_isxdigit')
    !Utility Functions
      Rand(),signed,name('_rand')
      SRand(unsigned),name('_srand')
    !C++ (nul terminated) String functions
      StrCat(*cstring,*cstring),cstring,raw,name('_strcat')
      StrCmp(*cstring,*cstring),signed,raw,name('_strcmp')
      ChrCmp(byte,byte),signed,name('_chrcmp')
      StrEqu(*cstring,*cstring),signed,raw,name('_strequ')
      StrCpy(*cstring,*cstring),cstring,raw,name('_strcpy')
      StrLen(*cstring),unsigned,raw,name('_strlen')
      StrChr(*cstring,signed),cstring,raw,name('_strchr')
      StrCSpn(*cstring,*cstring),unsigned,raw,name('_strcspn')
      StrError(signed),cstring,raw,name('_strerror')
      StrSpn(*cstring,*cstring),unsigned,raw,name('_strspn')
      StrStr(*cstring,*cstring),cstring,raw,name('_strstr')
      StrTok(*cstring,*cstring),cstring,raw,name('_strtok')
      StrPBrk(*cstring,*cstring),cstring,raw,name('_strpbrk')
      StrRChr(*cstring,signed),cstring,raw,name('_strrchr')
      StrLwr(*cstring),cstring,raw,name('_strlwr')
      StrUpr(*cstring),cstring,raw,name('_strupr')
      StrDup(*cstring),cstring,raw,name('_strdup')
      StrRev(*cstring),cstring,raw,name('_strrev')
      StrNCat(*cstring,*cstring,unsigned),cstring,raw,name('_strncat')
      StrNCmp(*cstring,*cstring,unsigned),signed,raw,name('_strncmp')
      StrNCpy(*cstring,*cstring,unsigned),cstring,raw,name('_strncpy')
      StrNICmp(*cstring,*cstring,unsigned),signed,raw,name('_strnicmp')
    !Low-Level File Manipulation
      Access(*cstring,signed),signed,raw,name('_access')
      ChMod(*cstring,signed),signed,raw,name('_chmod')
      API_Remove(*cstring),signed,raw,name('_remove')            !Renamed to avoid conflict with Builtins.Clw
      API_Rename(*cstring,*cstring),signed,raw,name('_rename')   !Renamed to avoid conflict with Builtins.Clw
      FnMerge(*cstring,*cstring,*cstring,*cstring,*cstring),raw,name('_fnmerge')
      FnSplit(*cstring,*cstring,*cstring,*cstring,*cstring),signed,raw,name('_fnsplit')
      MkDir(*cstring),signed,raw,name('_mkdir')
      RmDir(*cstring),signed,raw,name('_rmdir')
      GetCurDir(signed,*cstring),signed,raw,name('_getcurdir')
      ChDir(*cstring),signed,raw,name('_chdir')
      GetDisk(),signed,name('_getdisk')
      SetDisk(signed),signed,name('_setdisk')
    END

