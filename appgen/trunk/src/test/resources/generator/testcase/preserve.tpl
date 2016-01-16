#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#DECLARE(%ptest),multi
#DECLARE(%ptest2,%ptest),multi
#DECLARE(%ptest3,%file),multi
#FOR(%file)
	#ADD(%ptest,%file)
	#FIX(%ptest,%file)
	#FOR(%field)
		#ADD(%ptest2,%field)
		#ADD(%ptest3,%field)
	#ENDFOR
#ENDFOR
#FIX(%file,'Franch')
#FIX(%field,'PSI:email')
#FIX(%ptest,'Franch')
#FIX(%ptest2,'PSI:email')
#FIX(%ptest3,'PSI:email')
%file %field %ptest %ptest2 %ptest3
#CALL(%PreserveTest)
%file %field %ptest %ptest2 %ptest3
#CALL(%NoPreserveTest)
%file %field %ptest %ptest2 %ptest3
#GROUP(%preservetest),PRESERVE
#FIX(%file,'invitem')
#FIX(%ptest,'invitem')
#GROUP(%nopreservetest)
#FIX(%file,'invitem')
#FIX(%ptest,'invitem')