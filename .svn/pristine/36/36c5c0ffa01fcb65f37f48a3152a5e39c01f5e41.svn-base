#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#! Test:  Some multi dimension arrays
#DECLARE(%row),multi
#DECLARE(%col),multi
#DECLARE(%res,%row,%col),multi
#DECLARE(%j,LONG)
#DECLARE(%i,LONG)
#LOOP,FOR(%i,1,15)
    #ADD(%row,%i)
	#FIX(%row,%i) 
	#LOOP,FOR(%j,1,15)
	    #ADD(%col,%j)
		#FIX(%col,%j) 
    	#ADD(%res,'MUL:'&(%i*%j))
    	#ADD(%res,'ADD:'&(%i+%j))
    	#ADD(%res,'SUB:'&(%i-%j))
    #ENDLOOP
#ENDLOOP
#!
#!
#UNFIX(%res)
#FIX(%col,'3')
#FIX(%row,'3')
#FIND(%res,'MUL:30',%row)
#ASSERT(%row=2 and %col=15,'Assert #A '&%row&' '&%col)
#!
#!	
#UNFIX(%res)
#FIX(%col,'3')
#FIX(%row,'3')
#FIND(%res,'MUL:30',%col)
#ASSERT(%row=3 and %col=10,'Assert #B '&%row&' '&%col)
#!
#!
#UNFIX(%res)
#FIND(%res,'ADD:7')
#ASSERT(%row=1 and %col=6,'Assert #C '&%row&' '&%col)