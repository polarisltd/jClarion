#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#REMOVE('test.txt')
#OPEN('test.txt')
	Line 1
	Line 2
	Line 3
	Line 4
	Line 5
#CLOSE
#OPEN('test.txt')
	Line 6
	Line 7
#CLOSE
#OPEN('test.txt'),READ
#DECLARE(%line)
#DECLARE(%linecount),MULTI
#EQUATE(%lastline,0)
#DECLARE(%buffer,%linecount)
#LOOP
	#READ(%line)
	#IF(%line=%EOF)
		#BREAK
	#ENDIF
	#SET(%lastline,%lastline+1)
	#ASSERT(%lastline<20,'Circuit breaker')
	#ADD(%linecount,%lastline)
	#SELECT(%linecount,%lastline)
	#SET(%buffer,%line)
#ENDLOOP
#CLOSE,READ
#assert(items(%linecount)=7,'Line count test')
#LOOP,FOR(%i,1,7)
    #SELECT(%linecount,%i)
    #ASSERT(%buffer='<9>Line '&%i,%buffer)
#ENDLOOP
#CREATE('test.txt')
#CLOSE
#OPEN('test.txt'),READ
#READ(%line)
#ASSERT(%EOF=%line,'Empty')
#CLOSE,READ
#REMOVE('test.txt')