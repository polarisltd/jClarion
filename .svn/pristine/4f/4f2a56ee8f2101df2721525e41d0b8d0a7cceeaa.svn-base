#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#FIX(%procedure,'updateInvoice')
#EQUATE(%result,'')
#SET(%result,'')
#FOR(%localdata)
	#set(%result,%result&','&%localdata)
#ENDFOR
#ASSERT(%result=',CurrentTab,ActionMessage,tCurrent,MyAccount,,ccDetails,CreditCard','Result:'&%result)
#FOR(%localdata)
%[20]localdata %localdatastatement
#ENDFOR