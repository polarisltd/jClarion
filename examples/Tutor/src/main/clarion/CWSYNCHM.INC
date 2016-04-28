  OMIT('__EndOfInclude__',__CWIFACE_INC)

__CWIFACE_INC  EQUATE(1)

    INCLUDE('CWSYNCH.INT'),ONCE

ERROR_ALREADY_EXISTS EQUATE(183)

    MAP
      MODULE('')
        NewMutex            (),*IMutex,NAME('Cla$NewMutex')
        NewMutex            (STRING name, BYTE Own = FALSE, <*LONG Err>),*IMutex,NAME('Cla$NewProcessMutex')
        GetMutex            (STRING name, <*LONG Err>),*IMutex,NAME('Cla$GetProcessMutex')
        NewSemaphore        (LONG initial=0,LONG max=1),*ISemaphore,NAME('Cla$NewSemaphore')
        NewNamedSemaphore   (STRING name, LONG initial=0,LONG max=1, <*LONG Err>),*ISemaphore,NAME('Cla$NewProcessSemaphore')
        GetSemaphore        (STRING name, <*LONG Err>),*ISemaphore,NAME('Cla$GetProcessSemaphore')
        NewCriticalSection  (),*ICriticalSection,NAME('Cla$NewCriticalSection')
        NewReaderWriterLock (BYTE WritersHavePriority = TRUE),*IReaderWriterLock,NAME('Cla$NewReaderWriterLock')
      END
    END

! __EndOfInclude__
