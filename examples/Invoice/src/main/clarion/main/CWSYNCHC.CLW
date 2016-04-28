          MEMBER

          MAP
          END

          INCLUDE ('CWSYNCHM.INC'),ONCE
          INCLUDE ('CWSYNCHC.INC'),ONCE

CriticalProcedure.Construct PROCEDURE()
  CODE
  SELF.Sync &= NULL
  RETURN

CriticalProcedure.Destruct PROCEDURE()
  CODE
  SELF.Kill()
  RETURN

CriticalProcedure.Init PROCEDURE (*ISyncObject O)
  CODE
  SELF.Kill()
  IF NOT O &= NULL
    O.Wait()
    SELF.Sync &= O
  END
  RETURN

CriticalProcedure.Kill PROCEDURE()
  CODE
  IF NOT SELF.Sync &= NULL
    SELF.Sync.Release()
    SELF.Sync &= NULL
  END
  RETURN

CriticalSection.Construct PROCEDURE()
  CODE
  SELF.CS &= NewCriticalSection()
  RETURN
  
CriticalSection.Destruct PROCEDURE()
  CODE
  SELF.CS.Kill()
  RETURN
  
CriticalSection.Wait PROCEDURE()
  CODE
  SELF.CS.Wait()
  RETURN
  
CriticalSection.Release PROCEDURE()
  CODE
  SELF.CS.Release()
  RETURN
  
CriticalSection.GetIFace PROCEDURE()
  CODE
  RETURN SELF.CS

Mutex.Construct PROCEDURE()
  CODE
  SELF.M &= NewMutex()
  RETURN
  
Mutex.Destruct PROCEDURE()
  CODE
  SELF.M.Kill()
  RETURN
  
Mutex.Wait PROCEDURE()
  CODE
  SELF.M.Wait()
  RETURN
  
Mutex.TryWait PROCEDURE(LONG milliseconds)
  CODE
  RETURN SELF.M.TryWait(milliseconds)
  
Mutex.Release PROCEDURE()
  CODE
  SELF.M.Release()
  RETURN
  
Mutex.Release PROCEDURE(SIGNED Count)
  CODE
  SELF.M.Release(Count)
  RETURN
  
Mutex.HandleOf PROCEDURE()
  CODE
  RETURN SELF.M.HandleOf()
  
Mutex.GetIFace PROCEDURE()
  CODE
  RETURN SELF.M
  
Semaphore.Construct PROCEDURE()
  CODE
  SELF.S &= NewSemaphore()
  RETURN
  
Semaphore.Destruct PROCEDURE()
  CODE
  SELF.S.Kill()
  RETURN
  
Semaphore.Wait PROCEDURE()
  CODE
  SELF.S.Wait()
  RETURN
  
Semaphore.TryWait PROCEDURE(LONG milliseconds)
  CODE
  RETURN SELF.S.TryWait(milliseconds)
  
Semaphore.Release PROCEDURE()
  CODE
  SELF.S.Release()
  RETURN
  
Semaphore.Release PROCEDURE(SIGNED Count)
  CODE
  SELF.S.Release(Count)
  RETURN
  
Semaphore.HandleOf PROCEDURE()
  CODE
  RETURN SELF.S.HandleOf()

Semaphore.GetIFace PROCEDURE()
  CODE
  RETURN SELF.S
  
