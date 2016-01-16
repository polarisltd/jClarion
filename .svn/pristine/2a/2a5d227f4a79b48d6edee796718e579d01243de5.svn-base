#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#! Test basic for loop
#EQUATE(%cycleloop,0)
#EQUATE(%aftercycleloop,0)
#LOOP,FOR(%i,1,30)
	#IF(%i % 3=0)
	   #SET(%cycleloop,%cycleloop+1)
	   #CYCLE 
	#ENDIF
	#SET(%aftercycleloop,%aftercycleloop+1) 
	#IF(%i=20)
		#BREAK
	#ENDIF
#ENDLOOP
#ASSERT(%cycleloop=6,'for cycle '&%cycleloop)
#ASSERT(%aftercycleloop=14,'for aftercycle '&%aftercycleloop)
#!
#!
#! Test reverse loop
#DECLARE(%REV),multi
#LOOP,FOR(%i,20,10),BY(-3)
	#ADD(%rev,%i)
#ENDLOOP
#ASSERT(items(%rev)=4,'rev.count')
#SELECT(%rev,1)
#ASSERT(%rev=20,'rev')
#SELECT(%rev,2)
#ASSERT(%rev=17,'rev')
#SELECT(%rev,3)
#ASSERT(%rev=14,'rev')
#SELECT(%rev,4)
#ASSERT(%rev=11,'rev')
#!
#! Test times loop
#EQUATE(%times,1)
#LOOP,TIMES(8)
    #SET(%times,%times*2)
#ENDLOOP
#ASSERT(%times=256,'times')
#!
#! While/until loops
#EQUATE(%expr,1)
#EQUATE(%count,0)
#LOOP,WHILE(%expr<512)
	#set(%count,%count+1)
	#set(%expr,%expr*2)
#ENDLOOP
#ASSERT(%expr=512,'while')
#ASSERT(%count=9,'while#')
#LOOP,UNTIL(%expr=1)
	#set(%count,%count+1)
	#set(%expr,%expr/2)
#ENDLOOP
#ASSERT(%expr=1,'while')
#ASSERT(%count=18,'while#')