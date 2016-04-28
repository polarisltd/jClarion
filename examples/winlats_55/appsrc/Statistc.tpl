#!------------------------------------------------------------------------------
#!
#! TEMPLATE: Clarion for Windows Business Statistics Template v4.0
#! 
#!------------------------------------------------------------------------------
#TEMPLATE(Statistics,'Clarion for Windows Business Statistics Template v4.0'),FAMILY('ABC')
#HELP('C55BML.HLP')
#!------------------------------------------------------------------------------
#!
#!  Business Statistics Procedure and Function Prototypes:
#!  ======================================================
#!
#!  FACTORIAL(USHORT),REAL                  ! Factorial of n
#!  FREQUENCY(DATASET,REAL),ULONG           ! Frequency Count of an Item
#!  LOWERQUARTILE(DATASET),REAL             ! Lower Quartile Value of a Set
#!  MEAN(DATASET),REAL                      ! Mean of a Set
#!  MEDIAN(DATASET),REAL                    ! Median of a Set
#!  MIDRANGE(DATASET),REAL                  ! Midrange of a Set
#!  MODE(DATASET,DATASET),ULONG             ! Mode of a Set
#!  PERCENTILE(DATASET,REAL),REAL           ! pth Percentile Value of a Set
#!  RANGEOFSET(DATASET),REAL                ! Range of a Set
#!  rVALUE(DATASETXY,<REAL>,<REAL>),REAL    ! Linear Regression Correlation Coefficient
#!  SDEVIATIONp(DATASET,<REAL>),REAL        ! Population Standard Deviation
#!  SDEVIATIONs(DATASET,<REAL>),REAL        ! Sample Standard Deviation
#!  SS(DATASET,<REAL>),REAL                 ! Sum of Squares
#!  SSxy(DATASETXY,<REAL>,<REAL>),REAL      ! Sum of Squares for x and y
#!  ST1(DATASET,REAL),REAL                  ! Student's t (single mean)
#!  SUMM(DATASET),REAL                      ! Summation of a Set
#!  UPPERQUARTILE(DATASET),REAL             ! Upper Quartile Value of a Set
#!  VARIANCEp(DATASET,<REAL>),REAL          ! Population Variance
#!  VARIANCEs(DATASET,<REAL>),REAL          ! Sample Variance
#!
#!------------------------------------------------------------------------------
#!------------------------------------------------------------------------------
#!
#! EXTENSION: Business Statistics Library - Initialize and Enable Business Statistics Library
#!
#!------------------------------------------------------------------------------
#EXTENSION(StatisticsLibrary,'Clarion for Windows Business Statistics Library v2.0'),APPLICATION,HLP('~TPLExtensionStatisticsLibrary')
#BOXED(' Clarion for Windows Business Statistics Library v2.0 ')
  #DISPLAY(' ')
  #DISPLAY('FACTORIAL       - Factorial of n')
  #DISPLAY('FREQUENCY     - Frequency Count of an Item')
  #DISPLAY('LOWERQUARTILE - Lower Quartile Value of a Set')
  #DISPLAY('MEAN                - Mean of a Set')
  #DISPLAY('MEDIAN            - Median of a Set')
  #DISPLAY('MIDRANGE       - Midrange of a Set')
  #DISPLAY('MODE               -  Mode of a Set')
  #DISPLAY('PERCENTILE    - pth Percentile Value of a Set')
  #DISPLAY('RANGEOFSET  - Range of a Set')
  #DISPLAY('rVALUE             - Linear Regression Correlation Coefficient')
  #DISPLAY('SDEVIATION    - Standard Deviation of a Set')
  #DISPLAY('SS                      - Sum of Squares')
  #DISPLAY('SSxy                   - Sum of Squares for x and y')
  #DISPLAY('ST1                    - Student''s t (single mean)')
  #DISPLAY('SUMM                - Summation of a Set')
  #DISPLAY('UPPERQUARTILE - Upper Quartile Value of a Set')
  #DISPLAY('VARIANCE        - Variance of a Set')
#ENDBOXED
#AT(%BeforeGlobalIncludes)                       #! Define QUEUE Dat Types
INCLUDE('cwstatdt.clw')
#ENDAT
#AT(%GlobalMap)                                  #! Statistic Library Prototypes
INCLUDE('cwstatpr.clw')
#ENDAT
#AT(%CustomGlobalDeclarations)                   #! Add Library to Project
#PROJECT('busmath.pr')
#ENDAT
#!------------------------------------------------------------------------------
#!
#! GROUP: %DisplayReturnValue
#! 
#!------------------------------------------------------------------------------
#GROUP(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#DECLARE(%SaveControl)
#IF(%DisplayRetVal)
  #SET(%SaveControl,%Control)
  #FIX(%Control,('?' & %RetVal))
  #IF(%Control)
DISPLAY(%Control)
  #ENDIF
  #FIX(%Control,%SaveControl)
#ENDIF
#!
#!------------------------------------------------------------------------------
#!
#! CODE: FACTORIAL - Factorial of a Number
#!
#!------------------------------------------------------------------------------
#CODE(FACTORIAL,'Factorial of a Number'),REQ(StatisticsLibrary),HLP('~TPLCodeFACTORIAL')
#BOXED(' Description: ')
  #DISPLAY('FACTORIAL computes the factorial of a number.  For')
  #DISPLAY('example, if the number provided is 5 then the function')
  #DISPLAY('returns the value of: (1 x 2 x 3 x 4 x 5) = 120.')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Number:',FIELD),%Number,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Factorial Result:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* The largest number which can be passed in the')
  #DISPLAY('  variable to the FACTORIAL function is dependent')
  #DISPLAY('  upon the application''s Target OS (16 or 32 bit).')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = FACTORIAL(%Number)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: FREQUENCY - Frequency Count of an Item in a Set
#!
#!------------------------------------------------------------------------------
#CODE(FREQUENCY,'Frequency Count of an Item in a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeFREQUENCY')
#BOXED(' Description: ')
  #DISPLAY('FREQUENCY counts the number of instances (Frequency')
  #DISPLAY('Count) of a numeric value (Search Value) in a numeric')
  #DISPLAY('set (Data Set).  For example, given the data set:')
  #DISPLAY('[1,2,2,3,4,5] and the search value 2, the function')
  #DISPLAY('would return a frequency count of 2.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
  #PROMPT('Search Value:',FIELD),%SearchValue,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Frequency Count:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = FREQUENCY(%DataSet,%SearchValue)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: LOWERQUARTILE - Lower Quartile Value of a Set
#!
#!------------------------------------------------------------------------------
#CODE(LOWERQUARTILE,'Lower Quartile Value of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeLOWERQUARTILE')
#BOXED(' Description: ')
  #DISPLAY('LOWERQUARTILE computes a value (Lower Quartile')
  #DISPLAY('Value) such that at most 25% of the set''s values are')
  #DISPLAY('less than the amount, and at most 75% of the set''s')
  #DISPLAY('values are greater than the amount.  For example, given')
  #DISPLAY('the data set: [1,2,3,4,5,6,7,8] the lower quartile value')
  #DISPLAY('is 2.5 .')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Lower Quartile Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
  #DISPLAY('* In general, the LOWERQUARTILE function is only')
  #DISPLAY('  meaningful when the number of elements in the')
  #DISPLAY('  Data Set is large (ie. greater than 20).')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = LOWERQUARTILE(%DataSet)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: UPPERQUARTILE - Upper Quartile Value of a Set
#!
#!------------------------------------------------------------------------------
#CODE(UPPERQUARTILE,'Upper Quartile Value of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeUPPERQUARTILE')
#BOXED(' Description: ')
  #DISPLAY('UPPERQUARTILE computes a value (Upper Quartile')
  #DISPLAY('Value) such that at most 75% of the set''s values are')
  #DISPLAY('less than the amount, and at most 25% of the set''s')
  #DISPLAY('values are greater than the amount.  For example, given')
  #DISPLAY('the data set: [1,2,3,4,5,6,7,8] the upper quartile value')
  #DISPLAY('is 6.5 .')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Upper Quartile Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
  #DISPLAY('* In general, the UPPERQUARTILE function is only')
  #DISPLAY('  meaningful when the number of elements in the')
  #DISPLAY('  Data Set is large (ie. greater than 20).')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = UPPERQUARTILE(%DataSet)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: MEAN - Mean of a Set
#!
#!------------------------------------------------------------------------------
#CODE(MEAN,'Mean of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeMEAN')
#BOXED(' Description: ')
  #DISPLAY('MEAN computes the arithmetic average (Mean Value) of')
  #DISPLAY('a set.  The arithmetic average is the summation of a')
  #DISPLAY('set''s values divided by the number of elements in')
  #DISPLAY('the set.  For example, if the set contains 5 values:')
  #DISPLAY('[1,2,3,4,5] then the mean is (1+2+3+4+5) / 5 = 3.')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Mean Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = MEAN(%DataSet)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: MEDIAN - Median of a Set
#!
#!------------------------------------------------------------------------------
#CODE(MEDIAN,'Median of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeMEDIAN')
#BOXED(' Description: ')
  #DISPLAY('MEDIAN finds the value which occurs in the middle when')
  #DISPLAY('all of the data is in (sorted) order from low to high, or the')
  #DISPLAY('mean of the two data values which are nearest the middle.')
  #DISPLAY('For example, given the data set: [1,2,3,4,5] the median')
  #DISPLAY('is 3, or given the data set: [1,2,4,5] the median is')
  #DISPLAY('(2 + 4) / 2 = 3.')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Median Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = MEDIAN(%DataSet)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: MIDRANGE - Midrange of a Set
#!
#!------------------------------------------------------------------------------
#CODE(MIDRANGE,'Midrange of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeMIDRANGE')
#BOXED(' Description: ')
  #DISPLAY('MIDRANGE computes the mean of the smallest and')
  #DISPLAY('largest values in a data set.  For example, given the')
  #DISPLAY('data set:[1,2,3,4,5] the midrange is (1 + 5) / 2 = 3.')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Midrange Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = MIDRANGE(%DataSet)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: MODE - Mode of a Set
#!
#!------------------------------------------------------------------------------
#CODE(MODE,'Mode of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeMODE')
#BOXED(' Description: ')
  #DISPLAY('MODE determines which value within a set occurs most')
  #DISPLAY('often. The mode value is returned as an entry in the')
  #DISPLAY('passed QUEUE (Mode Set).  If different values have an')
  #DISPLAY('equal ''highest frequency count'' then one instance of each')
  #DISPLAY('is returned in the (Mode Set).  The function returns the')
  #DISPLAY('mode frequency count.  For example, given the data set:')
  #DISPLAY('[5,5,7,7,9] the mode count equals 2 and the (Mode Set)')
  #DISPLAY('QUEUE would contain two entries: 5 and 7.')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
#ENDBOXED
#BOXED(' Return Parameter: ')
  #PROMPT('Mode Set:',FIELD),%ModeSet,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Mode Frequency Count:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
  #DISPLAY('* Mode Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The contents of the Mode Set QUEUE is freed upon')
  #DISPLAY('  entry to the function.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = MODE(%DataSet,%ModeSet)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: PERCENTILE - pth Percentile Value of a Set
#!
#!------------------------------------------------------------------------------
#CODE(PERCENTILE,'pth Percentile Value of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodePERCENTILE')
#BOXED(' Description: ')
  #DISPLAY('PERCENTILE computes a value (Percentile Value) such')
  #DISPLAY('that at most pth% of the set''s values are less than the')
  #DISPLAY('amount, and at most 100 - pth% of the set''s values')
  #DISPLAY('are greater than the amount.  For example, given the')
  #DISPLAY('data set: [1,2,3,4,5,6], the 50th Percentile value')
  #DISPLAY('is 3.5 .')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
  #PROMPT('Percentile (pth%):',FIELD),%Percentile,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Percentile Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
  #DISPLAY('* The Percentile variable MUST contain an integer value')
  #DISPLAY('  in the range:  1 >=  p  <<= 99 .')
  #DISPLAY('* In general, the PERCENTILE function is only')
  #DISPLAY('  meaningful when the number of elements in the')
  #DISPLAY('  Data Set is large (ie. greater than 20).')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = PERCENTILE(%DataSet,%Percentile)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: RANGEOFSET - Range of a Set
#!
#!------------------------------------------------------------------------------
#CODE(RANGEOFSET,'Range of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeRANGEOFSET')
#BOXED(' Description: ')
  #DISPLAY('RANGEOFSET computes the difference between the')
  #DISPLAY('largest and smallest values in the set.  For example,')
  #DISPLAY('given the data set: [1,2,3,4,5], the range is')
  #DISPLAY('(5 - 1) = 4 .')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Range Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = RANGEOFSET(%DataSet)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: rVALUE - Linear Regression Correlation Coefficient
#!
#!------------------------------------------------------------------------------
#CODE(rVALUE,'Linear Regression Correlation Coefficient'),REQ(StatisticsLibrary),HLP('~TPLCoderVALUE')
#BOXED(' Description: ')
  #DISPLAY('rVALUE computes the Correlation Coefficient of the')
  #DISPLAY('linear relationship between the paired data points')
  #DISPLAY('in the data set.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Data Set (Paired):',FIELD),%DataSet,REQ
  #DISPLAY('(Optional Parameters)')
  #PROMPT('Mean of X Data:',FIELD),%MeanX
  #PROMPT('Mean of Y Data:',FIELD),%MeanY
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Correlation Coefficient:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first two (X and Y)')
  #DISPLAY('  components defined as REAL variables.')
  #DISPLAY('* The function operates on the data sets defined by the')
  #DISPLAY('  paired X and Y (first and second component) numeric')
  #DISPLAY('  values contained in all QUEUE entries.')
  #DISPLAY('* The Optional Parameters help to optimize the function.')
  #DISPLAY('   If not provided, either (or both) mean value(s) will be')
  #DISPLAY('   automatically computed by the rVALUE function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%MeanX)
  #IF(%MeanY)
%RetVal = rVALUE(%DataSet,%MeanX,%MeanY)
  #ELSE
%RetVal = rVALUE(%DataSet,%MeanX)
  #ENDIF
#ELSIF(%MeanY)
  #IF(%MeanX)
%RetVal = rVALUE(%DataSet,%MeanX,%MeanY)
  #ELSE
%RetVal = rVALUE(%DataSet,,%MeanY)
  #ENDIF
#ELSE
%RetVal = rVALUE(%DataSet)
#END
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: SS - Sum of Squares
#!
#!------------------------------------------------------------------------------
#CODE(SS,'Sum of Squares'),REQ(StatisticsLibrary),HLP('~TPLCodeSS')
#BOXED(' Description: ')
  #DISPLAY('SS computes the summation of the squared differences')
  #DISPLAY('between each data set value and the data set''s mean.')
  #DISPLAY('The computation is a significant factor in several')
  #DISPLAY('statistical formulas.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
  #DISPLAY('(Optional Parameter)')
  #PROMPT('Mean of Data Set:',FIELD),%MeanOfSet
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Sum of Squares Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
  #DISPLAY('* The Optional Parameter helps to optimize the function.')
  #DISPLAY('   If not provided, the mean value will be automatically')
  #DISPLAY('   computed by the SS function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%MeanOfSet)
%RetVal = SS(%DataSet,%MeanOfSet)
#ELSE
%RetVal = SS(%DataSet)
#ENDIF
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: SSxy - Sum of Squares for X and Y
#!
#!------------------------------------------------------------------------------
#CODE(SSxy,'Sum of Squares for X and Y'),REQ(StatisticsLibrary),HLP('~TPLCodeSSxy')
#BOXED(' Description: ')
  #DISPLAY('SSxy computes the summation of the products of the')
  #DISPLAY('differences between each data point and its associated')
  #DISPLAY('(either X or Y) mean value.  The computation is a')
  #DISPLAY('significant factor in linear regression formulas.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Data Set (Paired):',FIELD),%DataSet,REQ
  #DISPLAY('(Optional Parameters)')
  #PROMPT('Mean of X Data:',FIELD),%MeanX
  #PROMPT('Mean of Y Data:',FIELD),%MeanY
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Sum of Squares for X and Y:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first two (X and Y)')
  #DISPLAY('  components defined as REAL variables.')
  #DISPLAY('* The function operates on the data sets defined by the')
  #DISPLAY('  paired X and Y (first and second component) numeric')
  #DISPLAY('  values contained in all QUEUE entries.')
  #DISPLAY('* The Optional Parameters help to optimize the function.')
  #DISPLAY('   If not provided, either (or both) mean value(s) will be')
  #DISPLAY('   automatically computed by the SSxy function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%MeanX)
  #IF(%MeanY)
%RetVal = SSxy(%DataSet,%MeanX,%MeanY)
  #ELSE
%RetVal = SSxy(%DataSet,%MeanX)
  #ENDIF
#ELSIF(%MeanY)
  #IF(%MeanX)
%RetVal = SSxy(%DataSet,%MeanX,%MeanY)
  #ELSE
%RetVal = SSxy(%DataSet,,%MeanY)
  #ENDIF
#ELSE
%RetVal = SSxy(%DataSet)
#END
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: ST1 - Student's t (single mean)
#!
#!------------------------------------------------------------------------------
#CODE(ST1,'Student''s t (single mean)'),REQ(StatisticsLibrary),HLP('~TPLCodeST1')
#BOXED(' Description: ')
  #DISPLAY('ST1 computes the Student''s t value for a given data')
  #DISPLAY('set and hypothesized mean value.  The returned t value')
  #DISPLAY('is used in a statistical test of an hypothesis about a')
  #DISPLAY('normally distributed population based on a small sample.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
  #PROMPT('Hypothesized Mean Value:',FIELD),%HypothesizedMean,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Student''s t Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = ST1(%DataSet,%HypothesizedMean)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: SDEVIATION - Standard Deviation of a Set
#!
#!------------------------------------------------------------------------------
#CODE(SDEVIATION,'Standard Deviation of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeSDEVIATION')
#BOXED(' Description: ')
  #DISPLAY('SDEVIATION computes the standard deviation of a given')
  #DISPLAY('data set.  The appropriate function is called based')
  #DISPLAY('upon the data set''s type (Type).  The ''Population Data')
  #DISPLAY('Set'' radio button should be checked only if the data')
  #DISPLAY('set contains all of a population''s values.')
#ENDBOXED
#PROMPT(' Type: ',OPTION),%TypeOfDataSet
  #PROMPT('Sample Data Set',RADIO)
  #PROMPT('Population Data Set',RADIO)
#BOXED(' Input Parameters: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
  #DISPLAY('(Optional Parameter)')
  #PROMPT('Mean of Data Set:',FIELD),%MeanOfSet
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Standard Deviation:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
  #DISPLAY('* The Optional Parameter helps to optimize the function.')
  #DISPLAY('   If not provided, the mean value will be automatically')
  #DISPLAY('   computed by the function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%TypeOfDataSet = 'Sample Data Set')
  #IF(%MeanOfSet)
%RetVal = SDEVIATIONs(%DataSet,%MeanOfSet)
  #ELSE
%RetVal = SDEVIATIONs(%DataSet)
  #END
#ELSE
  #IF(%MeanOfSet)
%RetVal = SDEVIATIONp(%DataSet,%MeanOfSet)
  #ELSE
%RetVal = SDEVIATIONp(%DataSet)
  #END
#END
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: VARIANCE - Variance of a Set
#!
#!------------------------------------------------------------------------------
#CODE(VARIANCE,'Variance of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeVARIANCE')
#BOXED(' Description: ')
  #DISPLAY('VARIANCE computes the variance of a given data set.')
  #DISPLAY('The appropriate function is called based upon the')
  #DISPLAY('set''s type (Type).  The ''Population Data Set'' radio')
  #DISPLAY('button should be checked only if the data set contains')
  #DISPLAY('all of a population''s values.')
#ENDBOXED
#PROMPT(' Type: ',OPTION),%TypeOfDataSet
  #PROMPT('Sample Data Set',RADIO)
  #PROMPT('Population Data Set',RADIO)
#BOXED(' Input Parameters: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
  #DISPLAY('(Optional Parameter)')
  #PROMPT('Mean of Data Set:',FIELD),%MeanOfSet
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Variance of Set:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
  #DISPLAY('* The Optional Parameter helps to optimize the function.')
  #DISPLAY('   If not provided, the mean value will be automatically')
  #DISPLAY('   computed by the function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%TypeOfDataSet = 'Sample Data Set')
  #IF(%MeanOfSet)
%RetVal = VARIANCEs(%DataSet,%MeanOfSet)
  #ELSE
%RetVal = VARIANCEs(%DataSet)
  #END
#ELSE
  #IF(%MeanOfSet)
%RetVal = VARIANCEp(%DataSet,%MeanOfSet)
  #ELSE
%RetVal = VARIANCEp(%DataSet)
  #END
#END
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: SUMM - Summation of a Set
#!
#!------------------------------------------------------------------------------
#CODE(SUMM,'Summation of a Set'),REQ(StatisticsLibrary),HLP('~TPLCodeSUMM')
#BOXED(' Description: ')
  #DISPLAY('SUMM computes the summation of all of a data set''s')
  #DISPLAY('values.  The computation is a significant factor in')
  #DISPLAY('several statistical formulas.')
#ENDBOXED
#BOXED(' Input Parameter: ')
  #PROMPT('Data Set:',FIELD),%DataSet,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Summation Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Data Set must be a QUEUE with the first component')
  #DISPLAY('  defined as a REAL variable.')
  #DISPLAY('* The function operates on the data set defined by the')
  #DISPLAY('  (first component) numeric values contained in all')
  #DISPLAY('  QUEUE entries.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = SUMM(%DataSet)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
