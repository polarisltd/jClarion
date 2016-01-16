#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#EQUATE(%test,'')
#FOR(%procedure)
#SET(%test,%test&',('&%procedure&','&%window&','&items(%control)&')')
#ENDFOR
#assert(%test=',(Main,QuickWindowC,8),(Updateinvitem,QuickWindowB,46),(updateInvoice,QuickWindowA,83)',%test)
#SET(%test,'')
#FOR(%procedure)
#SET(%test,%test&',('&%procedure&','&%window&','&items(%control)&')')
#ENDFOR
#assert(%test=',(Main,QuickWindowC,8),(Updateinvitem,QuickWindowB,46),(updateInvoice,QuickWindowA,83)',%test)