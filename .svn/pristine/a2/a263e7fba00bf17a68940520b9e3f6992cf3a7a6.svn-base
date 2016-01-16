#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#EQUATE(%result,'')
#FOR(%File)
	#set(%result,%result&','&%file)
#ENDFOR
#ASSERT(%result=',Accnt,invitem,invhead,Franch','Result:'&%result)
#FIX(%file,'Franch')
#SET(%result,'')
#FOR(%Field)
	#set(%result,%result&','&%field)
#ENDFOR
#ASSERT(%result=',PSI:clid,PSI:webcategory,PSI:website,PSI:phone,PSI:phonealt,PSI:fax,PSI:notes,PSI:email,PSI:LOCK,PSI:REFCODE,PSI:HEADER,PSI:FILENAME,PSI:ACCOUNTNUM,PSI:CREDCODE,PSI:PAYTAX,PSI:SPARE,PSI:DISCTRADE,PSI:USEMASTER,PSI:SPARE_2,PSI:MARKUP1,PSI:MARKUP2,PSI:MARKUP3,PSI:MARKUP4,PSI:MARKUP5,PSI:PRICEBRK1,PSI:PRICEBRK2,PSI:PRICEBRK3,PSI:PRICEBRK4,PSI:PRICEBRK5,PSI:SWITCH_1,PSI:SWITCH_2,PSI:SWITCH_3,PSI:SWITCH_4,PSI:SWITCH_5,PSI:minmargin1,PSI:minmargin2,PSI:minmargin3,PSI:minmargin4,PSI:minmargin5,PSI:listmarkup,PSI:archived,PSI:ordermethod,PSI:containsdups,PSI:allowdirectshipping,PSI:packpricefile,PSI:packorder','Result:'&%result)
#FIX(%file,'invhead')
#SET(%result,'')
#FOR(%Field)
	#set(%result,%result&','&%field)
#ENDFOR
#ASSERT(%result=',ivh:clid,ivh:INVOICE,ivh:CLIENT,ivh:INVPREFIX,ivh:ORDERNUM,ivh:FREIGHT,ivh:DEPOSIT,ivh:DISCOUNT,ivh:INVTOTAL,ivh:gst,ivh:ORDTOTAL,ivh:PAIDTOTAL,ivh:TENDERED,ivh:OTHERDESC,ivh:OTHERVALUE,ivh:PHONE,ivh:REMARKS,ivh:PARTCOUNT,ivh:DATE,ivh:TIME,ivh:TAX,ivh:taxdeposit,ivh:INV_PARENT,ivh:DEPOSIT_RECLAIM,ivh:RECLAIM_TOTAL,ivh:PICKUP_TOTAL,ivh:CLERK,ivh:ACCDEPOSIT,ivh:notify,ivh:discrate,ivh:disctype,ivh:disccosttype,ivh:exttype,ivh:extclid,ivh:conv_invoice','Result:'&%result)
#ASSERT(%filestruct='invhead FILE,DRIVER(''ODBC''),OWNER(ODBCSource),NAME(''public.invhead''),PRE(ivh),BINDABLE',%filestruct)
#ASSERT(%fileuseroptions='',%fileUserOptions)