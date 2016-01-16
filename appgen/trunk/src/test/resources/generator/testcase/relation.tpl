#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#FOR(%FILE)
	#FOR(%relation)
%file[%filekey] <=> %relation[%relationkey] %filerelationtype
		#FOR(%filekeyfield)
%filekeyfield : %filekeyfieldlink
		#ENDFOR
		#FOR(%relationkeyfield)
%relationkeyfield : %relationkeyfieldlink
		#ENDFOR
	#ENDFOR
#ENDFOR