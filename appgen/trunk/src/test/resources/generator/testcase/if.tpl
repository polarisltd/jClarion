#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#DECLARE(%result)
#SET(%result,0)
#CALL(%test,9)
#ASSERT(%result=1)
#!
#SET(%result,0)
#CALL(%test,8)
#ASSERT(%result=2)
#!
#SET(%result,0)
#CALL(%test,7)
#ASSERT(%result=2)
#!
#SET(%result,0)
#CALL(%test,6)
#ASSERT(%result=3)
#!
#GROUP(%test,%expr)
#IF (%expr=9)
	#SET(%result,1)
#ELSIF (%expr+1=9)
	#SET(%result,2)
#ELSIF (%expr+2=9)
	#SET(%result,2)
#ELSE	
    #SET(%result,3)
#ENDIF
