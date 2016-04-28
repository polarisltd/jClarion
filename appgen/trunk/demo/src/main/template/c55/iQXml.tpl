#! © Copyright Designer Software 2004
#!-----------------------------------------------------------------------------------
#TEMPLATE(iQXML_Parser_Writer,'iQ-XML XML Parser/Writer'),family('abc','cw20')
#!-----------------------------------------------------------------------------------
#INCLUDE('iQXmlPar.tpw')
#INCLUDE('iQXmlWrt.tpw')
#INCLUDE('iQXmlGrp.tpw')
#Extension(iQXML_Global,'Globals for iQ-XML XML Parser/Writer')
#!-----------------------------------------------------------------------------------
#GlobalData
Glo:iQErrorMessageText              STRING(128)
#ENDGLOBALDATA
#SHEET
#TAB('General')
#Insert(%iQXMLVersion)
#Insert(%iQWelcome)
  #Boxed('')
   #Display('This template supports the following functions:')
    #BUTTON('Parser Functions') 
     #Insert(%ParserGroup)
    #ENDBUTTON
    #BUTTON('Write Functions')
     #Insert(%writeGroup)
    #ENDBUTTON
  #ENDBOXED
  #BOXED('')
    #PROMPT('Do Not Add Global Information',CHECK),%iQNoGlobals,DEFAULT(0),at(10)
  #ENDBOXED
#ENDTAB
#TAB('Error Checking')
 #PROMPT('Include Error Checking after Functions',CHECK),%iQIncludeError,DEFAULT(1),at(10)
  #BOXED(' Error Options '),where(%iQIncludeError=1)
   #PROMPT('Error Checking Options',OPTION),%iQErrorCheckOptions,CHOICE
   #PROMPT('Use Standard Clarion Message Box',RADIO)                   
   #PROMPT('Put Error Text in Global Variable',RADIO)                   
  #ENDBOXED
  #BOXED(' Message Option '),where(%iQErrorCheckOptions=1 and %iQIncludeError=1),AT(,73)
#DISPLAY(' ')
   #Prompt('Message Text ',TEXT),%IOErrorMessageText
   #Prompt('Message Window Title',@s40),%IOErrorMessageTitle
  #ENDBoxed
  #BOXED(' Variable '),where(%iQErrorCheckOptions=2 and %iQIncludeError=1),AT(,73)
   #Display('The Following Global Variable can be used to')
   #Display('display the Error Message. (glo:iQErrorMessageText)')
  #ENDBOXED
 #ENDTAB
#ENDSHEET


#At(%CustomGlobalDeclarations)
   #IF((sub(%CWVersion,1,1)) = '6') 
     #IF(%iQNoGlobals=0)
        #Project('iQXML.Lib')
     #ENDIF
   #ENDIF
#ENDAT

#AT(%GlobalMap)
 #IF(%iQNoGlobals=0)
   INCLUDE('iQXML.INC','Modules')
 #ENDIF
#ENDAT

#AT(%AfterGlobalIncludes)
 #IF(%iQNoGlobals=0)
   INCLUDE('iQXML.INC','Equates')
 #ENDIF
#ENDAT

