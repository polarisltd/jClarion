#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#! test the differences in call scope
#APPLICATION
#DECLARE(%assert)
#call(%local)
#ASSERT(%assert='local','Assert A')
#call(%local(DEF))
#ASSERT(%assert='remote','Assert B')
#insert(%local)
#ASSERT(%assert='local','Assert C')
#insert(%local(DEF))
#ASSERT(%assert='retained scope','Assert D')
#!
#GROUP(%local)
#SET(%assert,'local')
#!
#!
#GROUP(%subcall)
#SET(%assert,'retained scope')
#!
#!
#TEMPLATE(DEF,'Application Builder Class Templates'),FAMILY('ABC')
#GROUP(%local)
#CALL(%subcall)
#!
#!
#GROUP(%subcall)
#SET(%assert,'remote')