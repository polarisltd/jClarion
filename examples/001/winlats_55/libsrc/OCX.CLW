 MODULE ('OCX')
   OcxEventProc(*SHORT,SIGNED,LONG),LONG,TYPE
   OcxPropEdit(SIGNED,STRING),LONG,TYPE
   OcxPropChange(SIGNED,STRING),TYPE

   OcxRegisterPropEdit(SIGNED,OcxPropEdit),NAME('OcxRegisterPropEdit')
   OcxRegisterPropChange(SIGNED,OcxPropChange),NAME('OcxRegisterPropChange')
   OcxRegisterEventProc(SIGNED,OcxEventProc),NAME('OcxRegisterEventProc')

   OCxUnRegisterPropEdit(SIGNED),NAME('OCxUnRegisterPropEdit')
   OCxUnRegisterPropChange(SIGNED),NAME('OCxUnRegisterPropChange')
   OCxUnRegisterEventProc(SIGNED),NAME('OCxUnRegisterEventProc')

   OcxGetParamCount(*SHORT),UNSIGNED,NAME('OcxGetParamCount')
   OcxGetParam(*SHORT,SIGNED),STRING,NAME('OcxGetParam')
   OcxSetParam(*SHORT,SIGNED,STRING),NAME('OcxSetParam')

   HookOle(),NAME('CLA$HookOle')

   OcxLoadImage(STRING),STRING,NAME('OcxLoadImage')
   OLEDIRECTORY(oleQ result,SIGNED ocx,SIGNED=0),NAME('Cla$OLEDIRECTORY')
 .
