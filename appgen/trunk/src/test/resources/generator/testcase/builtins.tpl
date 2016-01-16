#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#ASSERT(instring('\','c:\file\test.txt',1,1)=3,'instring')
#ASSERT(instring('\','c:\file\test.txt')=3,'instring')
#ASSERT(instring('\','c:\file\test.txt',1,4)=8,'instring')
#ASSERT(instring('file','c:\file\test.txt')=0,'instring')
#ASSERT(instring('file','c:\file\test.txt',1,1)=4,'instring')
#!
#!
#!
#ASSERT(clip('spaced   ')='spaced','clip')
#ASSERT(clip('trimmed')='trimmed','clip')
#!
#!
#ASSERT(sub('afullstring',2,4)='full','sub')
#ASSERT(sub('afullstring',-3,2)='in','sub')
#ASSERT(sub('afullstring',6)='string','sub')
#!
#!
#ASSERT(choose(5>7,'TRUE','FALSE')='FALSE','choose')
#ASSERT(choose(5+2=7,'TRUE','FALSE')='TRUE','choose')
#ASSERT(choose(1>2)=0,'choose')
#ASSERT(choose(3>2)=1,'choose')
#ASSERT(choose(4,'This','Is','The','Test','Thing')='Test','choose')
#!
#ASSERT(slice('ABCDE',2,4)='BCD','Slice')
#!
#ASSERT(INLIST('updateInvoice',%Procedure),'inlist')
#ASSERT(~INLIST('does not exist',%Procedure),'inlist')
#!
#!
#ASSERT(quote('foo')='foo','quote')
#ASSERT(quote('fo''o')='fo''''o','quote')
#ASSERT(quote('fo<<32>o')='fo<<<<32>o','quote')
#ASSERT(quote('bar{{32}')='bar{{{{32}','quote')
#ASSERT(quote('bar        ')='bar {{8}','quote')
#!
#!
#DECLARE(%extractBits)
#SET(%extractBits,'STRING(@s10),AT(61,149),USE(AC:CODE),#ORIG(?String4),#ORDINAL(7)')
#ASSERT(extract(%extractBits,'use')='USE(AC:CODE)','')
#ASSERT(extract(%extractBits,'#ORIG')='#ORIG(?String4)','')
#ASSERT(extract(%extractBits,'use')='USE(AC:CODE)','')
#ASSERT(extract(upper(%extractBits),'FROM')='','')
#!
#!
#ASSERT(left('left')='left','left')
#ASSERT(left('   right')='right','left')
#!
#!
#!
#ASSERT(inrange(10,5,12),'inrange')
#ASSERT(inrange(5,5,12),'inrange')
#ASSERT(inrange(12,5,12),'inrange')
#ASSERT(~inrange(3,5,12),'inrange')
#ASSERT(~inrange(14,5,12),'inrange')