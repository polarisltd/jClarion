        MEMBER('winlats.clw')        ! This is a MEMBER module
         
         !sndPlaySoundA(*LPCSTR,UNSIGNED),BOOL,PROC
         sndPlaySoundA          FUNCTION (str,int)
         CODE
         RETURN true
         
         
         !CreateDirectoryA(*LPCSTR,*SECURITY_ATTRIBUTES),BOOL
         CreateDirectoryA FUNCTION (str,int)
         CODE
         RETURN true
         
         !MemoryRead(WORD,DWORD,LPVOID,DWORD),DWORD
         MemoryRead FUNCTION (str,int)
         CODE
         RETURN 0
         

         
         !CopyFileA(*LPCSTR,*LPCSTR,BOOL),BOOL
         CopyFileA FUNCTION (str,flag)
         CODE
         RETURN true
 
         
         !MoveFileA(*LPCSTR,*LPCSTR),BOOL
         MoveFileA FUNCTION (str,str)
         CODE
         RETURN true

         !GetVersion(),DWORD
         GetVersion FUNCTION()
         CODE
         RETURN 0



         
