
  member

!**********************************************************************
!
!   Module:         svdate.clw
!
!
!**********************************************************************

!*
!*  Includes
!*

  include('svapi.inc'),once
  include('svdate.inc'),once
  include('svcom.inc'),once

!*
!*  Equates
!*

!*
!*  Declarations
!*

!*
!*  Function Prototypes
!*

  map
    include('svapifnc.inc')
  end


CDateConverter.SQLDateTimeToCW procedure(real SQLDt, *long CWDate, *long CWTime)

iSQLDt          long
test            time
iCvtDt          LONG
cDateStr        &CStr
szVal           &CSTRING
hr              HRESULT

  code
    ! check negative values for days
!TC    iSQLDt = int(SQLDt)
!TC    CWDate = iSQLDt + CWDaysToSQLBase
    hr = VarBstrFromDate(sqlDt, 0, 2, iCvtDt)
    If hr = S_OK
      cDateStr &= NEW CStr
      hr = cDateStr.Init( iCvtDt, FALSE )
      szVal &= cDateStr.GetCStr()
      CWDate = DEFORMAT( szVal, '@D17' )
      szVal &= null
      CDateStr.Release()      
      DISPOSE( cDateStr )
      SysFreeString( iCvtDt )
    end
    hr = VarBstrFromDate(sqlDt, 0, 1, iCvtDt)
    If hr = S_OK
      cDateStr &= NEW CStr
      hr = cDateStr.Init( iCvtDt, FALSE )
      szVal &= cDateStr.GetCStr()
      CWTime = DEFORMAT( szVal, '@T8' )
      szVal &= null
      CDateStr.Release()
      DISPOSE( cDateStr )
      SysFreeString( iCvtDt )
    end
!TC    self.FractToHundredths(SQLDt - iSQLDt, CWTime)
    return true


CDateConverter.SQLDateTimeToVdt procedure(real SQLDt, *real VDt)

  code

    return true


CDateConverter.CWDateTimeToSQL procedure(long CWDate, long CWTime, *real SQLDt)

  code
    return false


CDateConverter.CWDateTimeToVdt procedure(long CWDate, long CWTime, *real VDt)

  code
    return false


CDateConverter.VDateTimeToSQL procedure(real VDt, *real SQLDt)

  code
    return false


CDateConverter.VDateTimeToCW procedure(real VDt, *long CWDate, *long CWTime)

  code
    return false


CDateConverter.FractToCWTime procedure(real SQLtFrac, *long CWTime)

locTime         byte,dim(4),over(CWTime)
lmsec           long
rhr             real
rmin            real
rsec            real
rhsec           real

  code
    rhr = SQLtFrac * 24
    locTime[1] = int(rhr)
    rmin = (rhr - locTime[1]) * 60
    locTime[2] = int(rmin)
    rsec = (rmin - locTime[2]) * 60
    locTime[3] = int(rsec)
    rhsec = (rsec - locTime[3]) * 100
    locTime[4] = round(rhsec, 1)
    if (locTime[4] = 100)
      locTime[4] = 0
      locTime[3] += 1
      if (locTime[3] = 60)
        locTime[3] = 0
        locTime[2] += 1
        if (locTime[2] = 60)
          locTime[2] = 0
          locTime[1] += 1
        end
      end
    end


CDateConverter.FractToHundredths procedure(real SQLtFrac, *long CWTime)

  code
    CWTime = SQLtFrac * 8.64e6


SystemDateTime.Construct procedure

  code
    self.DateConverter &= null
    self.DateConverter &= new CDateConverter


SystemDateTime.Destruct procedure

  code
    if (~self.DateConverter &= null)
      dispose(self.DateConverter).


SystemDateTime.IsInitialised procedure

  code
    return self.bInitialised


SystemDateTime.FromSQL procedure

  code


SystemDateTime.FromVdt procedure

  code


SystemDateTime.FromCW procedure

  code


SystemDateTime.Year procedure

  code
    return 0


SystemDateTime.Month procedure

  code
    return 0


SystemDateTime.Day procedure

  code
    return 0

