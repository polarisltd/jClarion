#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#DECLARE(%multi),MULTI
#ADD(%multi,'Apple')
#ADD(%multi,'Pear')
#ADD(%multi,'Banana')
#ADD(%multi,'Pear')
#ADD(%multi,'Peaches'&' & '&'Cream')
#ADD(%multi,'Queue Jumper',1+1)
#ASSERT(ITEMS(%multi)=6,'Test multi')
#SELECT(%multi,1)
#ASSERT(%multi='Apple','Test multi')
#SELECT(%multi,2)
#ASSERT(%multi='Queue Jumper','Test multi')
#SELECT(%multi,3)
#ASSERT(%multi='Pear','Test multi')
#SELECT(%multi,4)
#ASSERT(%multi='Banana','Test multi')
#SELECT(%multi,5)
#ASSERT(%multi='Pear','Test multi')
#SELECT(%multi,6)
#ASSERT(%multi='Peaches & Cream','Test multi')