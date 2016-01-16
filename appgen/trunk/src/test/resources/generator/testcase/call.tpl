#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#DECLARE(%assert)
#!
#CALL(%basic)
#ASSERT(%assert=1,'Basic Call')
#!
#CALL(%basic(DEF))
#ASSERT(%assert=6,'Basic Call')
#!
#CALL(%auto)
#ASSERT(%assert=7,'Basic Call:'&%assert)
#!
#DECLARE(%parent),MULTI
#ADD(%parent,'A')
#ADD(%parent,'B')
#ADD(%parent,'C')
#SELECT(%parent,2)
#ASSERT(%parent='B','Basic Call')
#CALL(%nopreserve)
#ASSERT(%parent='C','Basic Call')
#!
#CALL(%return),%assert
#ASSERT(%assert=5,'Basic Call')
#!
#CALL(%fib,0,1,8),%assert
#ASSERT(%assert=34,'Basic Call:'&%assert)
#ASSERT(%fib(0,1,8)=34,'Basic Call')
#!
#!
#CALL(%fibrecursive,10),%assert
#ASSERT(%assert=55,'Basic Call:'&%assert)
#ASSERT(%fibrecursive(10)=55,'Basic Call')
#!
#!
#SET(%assert,5)
#CALL(%passByValue,%assert,2)
#ASSERT(%assert=10,'Basic Call')
#!
#SET(%assert,6)
#CALL(%passByValue,%assert)
#ASSERT(%assert=30,'Basic Call')
#!
#!
#SET(%assert,0)
#CALL(%passByReference,%assert)
#ASSERT(%assert=10,'Basic Call :'&%assert)
#!
#!
#GROUP(%passByReference,*%param1)
#SET(%param1,10)
#!
#!
#!
#GROUP(%passByValue,%param1,%param2=5)
#SET(%assert,0)
#SET(%assert,%param1*%param2)
#!
#!
#!
#GROUP(%fib,%p1,%p2,%loop)
#DECLARE(%temp)
#LOOP,TIMES(%loop)
	#SET(%temp,%p1+%p2)
	#SET(%p1,%p2)
	#SET(%p2,%temp)
#ENDLOOP
#RETURN(%p2)
#!
#!
#!
#GROUP(%fibrecursive,%loop)
#IF(%loop<=1) 
#   RETURN(%loop)
#ENDIF
#RETURN(%fibrecursive(%loop-1)+%fibrecursive(%loop-2))
#!
#!
#!
#GROUP(%return)
#SET(%assert,0)
#RETURN(3+2)
#!
#!
#!
#GROUP(%basic)
#SET(%assert,%assert+1)
#!
#!
#GROUP(%auto),AUTO
#SET(%assert,%assert+1)
#DECLARE(%assert)
#SET(%assert,%assert+1)
#!
#!
#GROUP(%preserve),PRESERVE
#FOR(%parent)
#ENDFOR
#!
#!
#GROUP(%nopreserve)
#FOR(%parent)
#ENDFOR
#!
#!
#TEMPLATE(DEF,'Application Builder Class Templates'),FAMILY('ABC')
#GROUP(%basic)
#SET(%assert,%assert+5)