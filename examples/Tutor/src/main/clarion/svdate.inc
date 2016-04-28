!ABCIncludeFile(SV)

  omit('EndDefine',_DATESupport_)
_DATESupport_  equate(1)

!************************************************************************
!
!  Module:         svdate.inc
!
!
!  Description:
!
!
!************************************************************************


!*
!* Includes
!*

!*
!* Defines
!*

CWDaysToSQLBase     equate(36161)
VdtDaysToSQLBase    equate(2)

!*
!* Declarations
!*

DateGroupType       group,type
Date                  long
Time                  long
                    end

CDateConverter      class,type,module('svdate.clw'),link('svdate.clw', _svLinkMode_),dll(_svDllMode_)

SQLDateTimeToCW       procedure(real SQLDt, *long CWDate, *long CWTime),byte
SQLDateTimeToVdt      procedure(real SQLDt, *real VDt),byte
CWDateTimeToSQL       procedure(long CWDate, long CWTime, *real SQLDt),byte
CWDateTimeToVdt       procedure(long CWDate, long CWTime, *real VDt),byte
VDateTimeToSQL        procedure(real VDt, *real SQLDt),byte
VDateTimeToCW         procedure(real VDt, *long CWDate, *long CWTime),byte

FractToCWTime         procedure(real SQLtFrac, *long CWTime)
FractToHundredths     procedure(real SQLtFrac, *long CWTime)

!FracToMilitary
!MilitaryToFrac
!FracToHundths
!FracToMs

                    end

SystemDateTime      class,type,module('svdate.clw'),link('svdate.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure
IsInitialised         procedure,byte

FromSQL               procedure
FromVdt               procedure
FromCW                procedure

Year                  procedure,long
Month                 procedure,long
Day                   procedure,long

! Protected

DateConverter         &CDateConverter,protected
bInitialised          bool,protected

                    end


  EndDefine

