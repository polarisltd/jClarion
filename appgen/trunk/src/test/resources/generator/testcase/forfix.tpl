#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#! Test:  Some multi dimension arrays
#DECLARE(%row),multi
#DECLARE(%col,%row),multi
#ADD(%row,'A')
#ADD(%row,'B')
#FIX(%row,'A')
#LOOP,FOR(%i,1,10)
    #ADD(%col,'i'&%i)
#ENDLOOP
#DECLARE(%result)
#FOR(%file)
	#SET(%result,%result&','&%file)
	#CALL(%somethingwithpreserve)
#ENDFOR
#ASSERT(',Accnt,invitem,invhead,Franch'=%result,%result)
#GROUP(%somethingwithpreserve),PRESERVE
#FIX(%file,'Franch')