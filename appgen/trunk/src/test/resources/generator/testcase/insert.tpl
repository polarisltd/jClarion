#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#DECLARE(%assert)
#!
#INSERT(%basic)
#ASSERT(%assert=1,'Basic Call')
#!
#INSERT(%basic(DEF))
#ASSERT(%assert=6,'Basic Call')
#!
#INSERT(%auto)
#ASSERT(%assert=7,'Basic Call')
#!
#DECLARE(%parent),MULTI
#ADD(%parent,'A')
#ADD(%parent,'B')
#ADD(%parent,'C')
#SELECT(%parent,2)
#ASSERT(%parent='B','Basic Call')
#INSERT(%nopreserve)
#ASSERT(%parent='C','Basic Call')
#!
#INSERT(%return),%assert
#ASSERT(%assert=5,'Basic Call')
#!
#!
#SET(%assert,5)
#INSERT(%passByValue,%assert,2)
#ASSERT(%assert=10,'Basic Call')
#!
#SET(%assert,6)
#INSERT(%passByValue,%assert)
#ASSERT(%assert=30,'Basic Call')
#!
#!
#SET(%assert,0)
#INSERT(%passByReference,%assert)
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