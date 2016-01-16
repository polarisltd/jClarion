#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#! Test:  Some multi dimension arrays
#DECLARE(%row),multi
#LOOP,FOR(%i,1,10)
    #ADD(%row,%i)
#ENDLOOP
#ASSERT(items(%row)=10)
#FIX(%row,'3')
#ASSERT(items(%row)=10)
#UNFIX(%row)
#ASSERT(items(%row)=10)
#CLEAR(%row)
#ASSERT(items(%row)=10)
#FREE(%row)
#ASSERT(items(%row)=0)