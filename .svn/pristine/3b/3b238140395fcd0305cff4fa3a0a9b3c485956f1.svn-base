#! this template was created to give us some insight into how dependent variables
#! actually behave in clarion. This template is designed to elicit two things
#!   1) Whether multi dependents are keyed by value or keyed by index (Answer: keyed by value)
#!   2) Whether nested dependents implicitly inherit the full dependency list.  (Answer: implicit inheritance)
#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!open('c:\test.txt')
#declare(%parent,'STRING'),multi
#declare(%child,%parent,'STRING'),multi
#declare(%grandchild,%child,'STRING')
#declare(%counter,'LONG')
#set(%counter,0)
#add(%parent,'Apple')
#add(%parent,'Pear')
#add(%parent,'Banana')
#add(%parent,'Pear')
#for(%parent)
	#IF(%parent='Apple')
		#add(%child,'Sweet')
		#add(%child,'Red')
		#add(%child,'Fruit')
	#ENDIF
	#IF(%parent='Pear')
		#add(%child,'Hard')
		#add(%child,'Orange')
		#add(%child,'Fruit')
	#ENDIF
	#IF(%parent='Banana')
		#add(%child,'Radioactive')
		#add(%child,'Yellow')
		#add(%child,'Fruit')
	#ENDIF
	#for(%child)
		#set(%grandchild,'Some Value:'&%counter)
		#set(%counter,%counter+1)
	#endfor
#endfor
 Here is some test code
#for(%parent)
	#for(%child)
      Parent: %parent Child: %child Grandchild: %grandchild
	#endfor
#endfor