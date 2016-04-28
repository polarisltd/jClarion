
  member

  include('abcpthd.inc'),once





ThreadLocker.Wait PROCEDURE

  CODE
  PARENT.Wait()


ThreadLocker.Release PROCEDURE

  CODE
  PARENT.Release()





CooperationClass.PreemptiveThread PROCEDURE(BYTE newState)

  CODE
  SELF.Preemptive = newState


CooperationClass.Wait PROCEDURE

  CODE


CooperationClass.Release PROCEDURE

  CODE


CooperationClass.IsPreemptive PROCEDURE

  CODE
  RETURN SELF.Preemptive


CooperationClass.IsLocked PROCEDURE

  CODE
  RETURN CHOOSE(SELF.Preemptive = True, SELF.Locked, False)


