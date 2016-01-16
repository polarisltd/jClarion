#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#! basic
#DECLARE(%scalar)
#ASSERT(%scalar='','Test Scalar')
#SET(%scalar,'Some Value')
#ASSERT(%scalar='Some Value','Test Scalar')
#!
#! with type
#DECLARE(%typescalar,'LONG')
#ASSERT(%typescalar='','Test Scalar')
#SET(%typescalar,5)
#ASSERT(%typescalar=5,'Test Scalar')
#!
#!
#! with save
#DECLARE(%savescalar),SAVE
#ASSERT(%savescalar='','Test Scalar')
#SET(%savescalar,5+10)
#ASSERT(%savescalar=15,'Test Scalar')
#!
#!
#! with multi
#DECLARE(%multi),MULTI
#ASSERT(%multi='','Test multi')
#ADD(%multi,'Apple')
#ADD(%multi,'Pear')
#ADD(%multi,'Banana')
#ADD(%multi,'Pear')
#ASSERT(ITEMS(%multi)=4,'Test multi')
#SELECT(%multi,1)
#ASSERT(%multi='Apple','Test multi')
#SELECT(%multi,2)
#ASSERT(%multi='Pear','Test multi')
#SELECT(%multi,3)
#ASSERT(%multi='Banana','Test multi')
#SELECT(%multi,4)
#ASSERT(%multi='Pear','Test multi')
#!
#!
#! with unique
#DECLARE(%unique),UNIQUE
#ASSERT(%unique=%NULL,'Test multi')
#ADD(%unique,'Apple')
#ADD(%unique,'Pear')
#ADD(%unique,'Banana')
#ADD(%unique,'Pear')
#ASSERT(ITEMS(%unique)=3,'Test multi')
#SELECT(%unique,1)
#ASSERT(%unique='Apple','Test multi')
#SELECT(%unique,2)
#ASSERT(%unique='Banana','Test multi')
#SELECT(%unique,3)
#ASSERT(%unique='Pear','Test multi')
#! 
#! Named dependencies
#DECLARE(%d1,%multi)
#SELECT(%multi,1)
#SET(%d1,'Dep A')
#SELECT(%multi,2)
#SET(%d1,'Dep B')
#SELECT(%multi,1)
#ASSERT(%d1='Dep A','Dep Test')
#SELECT(%multi,2)
#ASSERT(%d1='Dep B','Dep Test')
#SELECT(%multi,3)
#ASSERT(%d1='','Dep Test')
#!
#!
#! Named dependencies #2
#DECLARE(%d2,%multi,'LONG')
#SELECT(%multi,1)
#SET(%d2,42)
#SELECT(%multi,2)
#SET(%d2,63)
#SELECT(%multi,1)
#ASSERT(%d2=42,'Dep Test')
#SELECT(%multi,2)
#ASSERT(%d2=63,'Dep Test')
#SELECT(%multi,3)
#ASSERT(%d2=0,'Dep Test')