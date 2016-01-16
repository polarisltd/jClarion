#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#DECLARE(%symbol)
#DECLARE(%assert)
#!
#SET(%symbol,'%basic')
#INVOKE(%symbol)
#ASSERT(%assert=1,'Basic Call')
#!
#SET(%symbol,'%basic(DEF)')
#INVOKE(%symbol)
#ASSERT(%assert=6,'Basic Call')
#!
#SET(%symbol,'%auto')
#INVOKE(%symbol)
#ASSERT(%assert=7,'Basic Call')
#!
#DECLARE(%parent),MULTI
#ADD(%parent,'A')
#ADD(%parent,'B')
#ADD(%parent,'C')
#SELECT(%parent,2)
#ASSERT(%parent='B','Basic Call')
#SET(%symbol,'%nopreserve')
#INVOKE(%symbol)
#ASSERT(%parent='C','Basic Call')
#!
#SET(%symbol,'%return')
#INVOKE(%symbol),%assert
#ASSERT(%assert=5,'Basic Call')
#!
#!
#SET(%assert,5)
#SET(%symbol,'%passByValue')
#INVOKE(%symbol,%assert,2)
#ASSERT(%assert=10,'Basic Call')
#!
#SET(%assert,6)
#INVOKE(%symbol,%assert)
#ASSERT(%assert=30,'Basic Call')
#!
#!
#SET(%assert,0)
#SET(%symbol,'%passByReference')
#INVOKE(%symbol,%assert)
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