
  MODULE('CWSTAT')
    FACTORIAL(USHORT),REAL,NAME('FACTORIAL')             ! Factorial of n
    FREQUENCY(DATASET,REAL),ULONG,NAME('FREQUENCY')      ! Frequency Count of an Item
    LOWERQUARTILE(DATASET),REAL,NAME('LOWERQUARTILE')    ! Lower Quartile Value of a Set
    MEAN(DATASET),REAL,NAME('MEAN')                      ! Mean of a Set
    MEDIAN(DATASET),REAL,NAME('MEDIAN')                  ! Median of a Set
    MIDRANGE(DATASET),REAL,NAME('MIDRANGE')              ! Midrange of a Set
    MODE(DATASET,DATASET),ULONG,NAME('MODE')             ! Mode of a Set
    PERCENTILE(DATASET,USHORT),REAL,NAME('PERCENTILE')   ! pth Percentile Value of a Set
    RANGEOFSET(DATASET),REAL,NAME('RANGEOFSET')          ! Range of a Set
    rVALUE(DATASETXY,<REAL>,<REAL>),REAL,NAME('rVALUE')  ! Correlation Coefficient
    SS(DATASET,<REAL>),REAL,NAME('SS')                   ! Sum of Squares
    SSxy(DATASETXY,<REAL>,<REAL>),REAL,NAME('SSxy')      ! Sum of Squares for x and y
    ST1(DATASET,REAL),REAL,NAME('ST1')                   ! Student's t (single mean)
    SDEVIATIONp(DATASET,<REAL>),REAL,NAME('SDEVIATIONp') ! Population Standard Deviation
    SDEVIATIONs(DATASET,<REAL>),REAL,NAME('SDEVIATIONs') ! Sample Standard Deviation
    SUMM(DATASET),REAL,NAME('SUMM')                      ! Summation of a Set
    UPPERQUARTILE(DATASET),REAL,NAME('UPPERQUARTILE')    ! Upper Quartile Value of a Set
    VARIANCEp(DATASET,<REAL>),REAL,NAME('VARIANCEp')     ! Population Variance
    VARIANCEs(DATASET,<REAL>),REAL,NAME('VARIANCEs')     ! Sample Variance
  END
