#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#! Test:  Some multi dimension arrays
#CREATE('test.txt')
#LOOP,FOR(%i,1,10)
%i
#ENDLOOP
#CLOSE
#CALL(%testContent,',1,2,3,4,5,6,7,8,9,10')
#!
#OPEN('test.txt')
#LOOP,FOR(%i,1,10)
%i
#ENDLOOP
#CLOSE
#CALL(%testContent,',1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10')
#!
#CREATE('test.txt')
#LOOP,FOR(%i,1,8)
%i
#ENDLOOP
#CLOSE
#CALL(%testContent,',1,2,3,4,5,6,7,8')
#!
#!
#CREATE('test.txt')
#LOOP,FOR(%i,10,1),by(-1)
%i
#ENDLOOP
#CLOSE
#CALL(%testContent,',10,9,8,7,6,5,4,3,2,1')
#!
#! Tear down
#REMOVE('test.txt')
#REMOVE('replace.txt')
#!
#!
#GROUP(%testContent,%val)
#REPLACE('replace.txt','test.txt')
#OPEN('replace.txt'),READ
#EQUATE(%result,'')
#EQUATE(%line,'')
#LOOP
	#READ(%line)
	#IF (%line=%eof)
	   #BREAK
	#ENDIF
	#SET(%result,%result&','&%line)
#ENDLOOP
#ASSERT(%result=%val,'Test:'&%line)
