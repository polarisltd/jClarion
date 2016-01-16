#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#! Test:  Some multi dimension arrays
#DECLARE(%row),multi
#DECLARE(%deprow,%row)
#DECLARE(%oddeven,%row)
#LOOP,FOR(%i,1,10)
    #ADD(%row,%i)
	#FIX(%row,%i)
	#SET(%deprow,'i'&%i) 
	#SET(%oddeven,%i % 2)
#ENDLOOP
#DECLARE(%result)
#FOR(%row)
	#SET(%result,%result&','&%deprow)
#ENDFOR
#ASSERT(',i1,i2,i3,i4,i5,i6,i7,i8,i9,i10'=%result,'For A')
#!
#!
#SET(%result,'')
#FOR(%row),WHERE(%oddeven=1)
	#SET(%result,%result&','&%deprow)
#ENDFOR
#ASSERT(',i1,i3,i5,i7,i9'=%result,'For B')
#!
#!
#SET(%result,'')
#FOR(%row),WHERE(%oddeven=0),REVERSE
	#SET(%result,%result&','&%deprow)
#ENDFOR
#ASSERT(',i10,i8,i6,i4,i2'=%result,'For C')