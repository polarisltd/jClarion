#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#!
#! Example 1 : copied from Clarion help
#!
Test 1
#SUSPEND(Fred)       #!Begin suspended generation section named "Fred"
#?1
#SUSPEND             #!Begin unnamed suspended generation section 
#?2
#QUERY(Fred,'3')     #!Generate "3" only if the "Fred" section is released
#?4
#RESUME				 #!Below Unconditional generation causes implicit #RELEASE of "Fred"
5
#RESUME              #!End "Fred" section
#!
#!
#!
Test 2
#SUSPEND(Fred)       #!Begin suspended generation section named "Fred"
#?1
#SUSPEND             #!Begin unnamed suspended generation section 
#?2
#QUERY(Fred,'3')     #!Generate "3" only if the "Fred" section is released
#?4
#RESUME				 #!Below Unconditional generation causes implicit #RELEASE of "Fred"
#?5
#RESUME              #!End "Fred" section
#!
#!
#!
Test 3
#SUSPEND(Fred)       #!Begin suspended generation section named "Fred"
#?1
#SUSPEND             #!Begin unnamed suspended generation section 
#?2
#QUERY(Fred,'3')     #!Generate "3" only if the "Fred" section is released
#RELEASE
#?4
#RESUME				 #!Below Unconditional generation causes implicit #RELEASE of "Fred"
#?5
#RESUME              #!End "Fred" section
#!
#!
#!