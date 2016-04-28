HELPOWNER         ITEMIZE,PRE
Application         EQUATE
Desktop             EQUATE
                  END

tagqHelpTopics    QUEUE,TYPE
iControl            SIGNED
szTopic             CSTRING(256)
                  END


tagHTMLHelp       CLASS,TYPE,MODULE('cwHH'),EXTERNAL,DLL(TRUE)
qHelpTopics         &tagqHelpTopics,PRIVATE
szHelpFile          CSTRING(256),PRIVATE
bInitDone           BYTE(FALSE),PRIVATE
!--------------------------------------------------------------------------------------------
! Methods
!--------------------------------------------------------------------------------------------
Init                PROCEDURE( STRING sHelpFile, UNSIGNED usDummyKey=123 ), BYTE, PROC  !Initialize an instance of the HTML help Object

Kill                PROCEDURE( ), BYTE, PROC                                            !Release this instance of the HTML help Object

SetHelpFile         PROCEDURE( STRING sHelpFile )                                       !Set the Help File Name (i.e. MYHELP.CHM)

GetHelpFile         PROCEDURE( ), STRING                                                !Get the current help file

SetTopic            PROCEDURE( STRING sTopic )                                          !Set the topic name (i.e. /Section/Topic.htm)

SetTopic            PROCEDURE( SIGNED iControl, STRING sTopic )       !Set the topic name (i.e. /Section/Topic.htm) associated with a control

GetTopic            PROCEDURE( ), STRING                                                !Get the current topic name

ShowIndex           PROCEDURE( <STRING sSearchText> )                                   !Selects the Index tab in the Navigation pane of the HTML Help Viewer and searches for the keyword specified in the parameter (if specified).

ShowTopic           PROCEDURE( <STRING szThisTopic> )                                   !Opens the help topic specified in SetHelpTopic() a help topic.

ShowSearch          PROCEDURE( )                                                        !Selects the Search tab in the Navigation pane of the HTML Help Viewer.

ShowTOC             PROCEDURE( )                                                        !Selects the Contents tab in the Navigation pane of the HTML Help Viewer.

CloseHelp           PROCEDURE( )                                                        !Closes all windows opened directly or indirectly by the calling program.

KeyWordLookUp       PROCEDURE( STRING sKeyWords )                                       !Looks up one or more keywords in a compiled help (.chm) file.
                                                                                        !Separated by ;.  If the keywords are not found, defaults to the index.

KeyWordLookUp       PROCEDURE( STRING sKeyWords, STRING sMessageText, STRING sMessageTitle )  !Looks up one or more keywords in a compiled help (.chm) file.
                                                                                              !Separated by ;.  If the keywords are not found, displays the message specified by sMessageText with a window title of sMessageTitle

AlinkLookUp         PROCEDURE( STRING sKeyWords )                                       !Looks up one or more Associative link (ALink) names in a compiled help (.chm) file.
                                                                                        !Separated by ;.  If the Alink names are not found, defaults to the index.

AlinkLookUp         PROCEDURE( STRING sKeyWords, STRING sMessageText, STRING sMessageTitle )  !Looks up one or more Associative link (ALink) names in a compiled help (.chm) file.
                                                                                              !Separated by ;.  If the Alink names are not found, displays the message specified by sMessageText with a window title of sMessageTitle
                  END
