!  Default Window and Report Structures
!  ====================================
!
!  Used by Format New Structure (Ctrl-F) in CW editor
!
!  You may modify these, or add new window or report types
!  (NB remember to add preceeding '!!> title' line)
!  It *is* safe to use the CW Editor and Screen or Report
!  formatter to edit these structures
!

!!> With OK & Cancel
Window WINDOW('Caption'),AT(,,395,224),FONT('MS Sans Serif',8,,FONT:regular),GRAY
       BUTTON('&OK'),AT(309,201,35,14),USE(?OkButton),LEFT,DEFAULT
       BUTTON('&Cancel'),AT(351,201,36,14),USE(?CancelButton),LEFT
     END

!!> With OK & Cancel - STD:Actions
Window WINDOW('Caption'),AT(,,395,224),FONT('MS Sans Serif',8,,FONT:regular),GRAY
       BUTTON('&OK'),AT(309,201,35,14),USE(?OkButton),LEFT,STD(STD:Close),DEFAULT
       BUTTON('&Cancel'),AT(351,201,36,14),USE(?CancelButton),LEFT,STD(STD:Close)
     END

!!> With OK & Cancel & Help
Window WINDOW('Caption'),AT(,,395,224),FONT('MS Sans Serif',8,,FONT:regular),GRAY
       BUTTON('&OK'),AT(268,201,35,14),USE(?OkButton),LEFT,DEFAULT
       BUTTON('&Cancel'),AT(309,201,36,14),USE(?CancelButton),LEFT
       BUTTON('&Help'),AT(351,201,36,14),USE(?HelpButton),LEFT,STD(STD:Help)
     END

!!> With OK & Cancel & Help - STD:Actions
Window WINDOW('Caption'),AT(,,395,224),FONT('MS Sans Serif',8,,FONT:regular),GRAY
       BUTTON('&OK'),AT(268,201,35,14),USE(?OkButton),LEFT,STD(STD:Close),DEFAULT
       BUTTON('&Cancel'),AT(309,201,36,14),USE(?CancelButton),LEFT,STD(STD:Close)
       BUTTON('&Help'),AT(351,201,36,14),USE(?HelpButton),LEFT,STD(STD:Help)
     END

!!> With OK & Cancel ICONS
Window WINDOW('Caption'),AT(,,395,224),FONT('MS Sans Serif',8,,FONT:regular),GRAY
       BUTTON('&OK'),AT(287,201,47,14),USE(?OkButton),LEFT,ICON('WAOk.ico'),DEFAULT
       BUTTON('&Cancel'),AT(340,201,47,14),USE(?CancelButton),LEFT,ICON('WACancel.ico')
     END

!!> With OK & Cancel ICONS - STD:Actions
Window WINDOW('Caption'),AT(,,395,224),FONT('MS Sans Serif',8,,FONT:regular),GRAY
       BUTTON('&OK'),AT(287,201,47,14),USE(?OkButton),LEFT,ICON('WAOk.ico'),STD(STD:Close),DEFAULT
       BUTTON('&Cancel'),AT(340,201,47,14),USE(?CancelButton),LEFT,ICON('WACancel.ico'),STD(STD:Close)
     END

!!> With OK & Cancel & Help ICONS
Window WINDOW('Caption'),AT(,,395,224),FONT('MS Sans Serif',8,,FONT:regular),GRAY
       BUTTON('&OK'),AT(234,201,47,14),USE(?OkButton),LEFT,ICON('WAOk.ico'),DEFAULT
       BUTTON('&Cancel'),AT(287,201,47,14),USE(?CancelButton),LEFT,ICON('WACancel.ico')
       BUTTON('&Help'),AT(340,201,47,14),USE(?HelpButton),LEFT,ICON('WAHelp.ico'),STD(STD:Help)
     END

!!> With OK & Cancel & Help ICONS - STD:Actions
Window WINDOW('Caption'),AT(,,395,224),FONT('MS Sans Serif',8,,FONT:regular),GRAY
       BUTTON('&OK'),AT(234,201,47,14),USE(?OkButton),LEFT,ICON('WAOk.ico'),STD(STD:Close),DEFAULT
       BUTTON('&Cancel'),AT(287,201,47,14),USE(?CancelButton),LEFT,ICON('WACancel.ico'),STD(STD:Close)
       BUTTON('&Help'),AT(340,201,47,14),USE(?HelpButton),LEFT,ICON('WAHelp.ico'),STD(STD:Help)
     END

!!> Progress Window
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100),#ORIG(Progress:Thermometer)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER,#ORIG(?Progress:UserString)
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER,#ORIG(?Progress:PctText)
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel),#ORIG(?Progress:Cancel)
     END

!!> Progress Window ICON
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100),#ORIG(Progress:Thermometer)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER,#ORIG(?Progress:UserString)
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER,#ORIG(?Progress:PctText)
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel),LEFT,ICON('WACancel.ico'),#ORIG(?Progress:Cancel)
     END

!!> Progress Window ICON II
ProgressWindow WINDOW('Progress...'),AT(,,165,61),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),SMOOTH,AT(2,16,160,10),RANGE(0,100),#ORIG(Progress:Thermometer)
       STRING(''),AT(2,2,160,10),USE(?Progress:UserString),LEFT,#ORIG(?Progress:UserString)
       STRING(''),AT(2,30,160,10),USE(?Progress:PctText),TRN,LEFT,#ORIG(?Progress:PctText)
       BUTTON('Cancel'),AT(113,44,50,15),USE(?Progress:Cancel),LEFT,ICON('WACancel.ico'),#ORIG(?Progress:Cancel)
     END

!!> Progress Window ICON III
ProgressWindow WINDOW('Progress...'),AT(,,165,56),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),SMOOTH,AT(3,21,160,10),RANGE(0,100),#ORIG(Progress:Thermometer)
       STRING(''),AT(3,6,160,10),USE(?Progress:UserString),LEFT,#ORIG(?Progress:UserString)
       STRING(''),AT(3,22,160,10),USE(?Progress:PctText),TRN,LEFT,FONT('Arial',,COLOR:White,FONT:bold,CHARSET:ANSI), |
           #ORIG(?Progress:PctText)
       BUTTON('Cancel'),AT(112,39,50,15),USE(?Progress:Cancel),FLAT,LEFT,ICON('WACancel.ico'),#ORIG(?Progress:Cancel)
     END

!!> Progress Window Vertical ICON
ProgressWindow WINDOW('Progress...'),AT(,,165,61),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),VERTICAL,SMOOTH,AT(5,5,31,51),RANGE(0,100),#ORIG(Progress:Thermometer)
       STRING(''),AT(41,13,119,10),USE(?Progress:UserString),LEFT,#ORIG(?Progress:UserString)
       STRING(''),AT(41,31,119,10),USE(?Progress:PctText),TRN,LEFT,#ORIG(?Progress:PctText)
       BUTTON('Cancel'),AT(113,44,50,15),USE(?Progress:Cancel),FLAT,LEFT,ICON('WACancel.ico'),#ORIG(?Progress:Cancel)
     END

!!> Application Main MDI Frame
AppFrame APPLICATION('Application'),AT(,,505,318),FONT('MS Sans Serif',8,,FONT:regular),CENTER,ICON('WAFRAME.ICO'), |
         STATUS(-1,80,120,45),SYSTEM,MAX,RESIZE,MASK
       MENUBAR,USE(?Menubar)
         MENU('&File'),USE(?FileMenu)
           ITEM('&Print Setup ...'),USE(?PrintSetup),MSG('Setup printer'),STD(STD:PrintSetup)
           ITEM,SEPARATOR
           ITEM('E&xit'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
         END
         MENU('&Edit'),USE(?EditMenu)
           ITEM('Cu&t'),USE(?Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)
           ITEM('&Copy'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)
           ITEM('&Paste'),USE(?Paste),MSG('Paste contents of Windows Clipboard'),STD(STD:Paste)
         END
         MENU('&Window'),USE(?WindowMenu),STD(STD:WindowList)
           ITEM('T&ile'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
           ITEM('&Cascade'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
         END
         MENU('&Help'),USE(?HelpMenu)
           ITEM('&Contents'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
         END
       END
     END


!!> MDI Child With OK & Cancel
Window WINDOW('Caption'),AT(,,395,224),MDI,SYSTEM,RESIZE,GRAY,FONT('MS Sans Serif',8,,FONT:regular)
       BUTTON('&OK'),AT(309,201,35,14),USE(?OkButton),LEFT,STD(STD:Close),DEFAULT
       BUTTON('&Cancel'),AT(351,201,36,14),USE(?CancelButton),LEFT,STD(STD:Close)
     END

!!> MDI Child With OK & Cancel ICONS
Window WINDOW('Caption'),AT(,,395,224),MDI,SYSTEM,RESIZE,GRAY,FONT('MS Sans Serif',8,,FONT:regular)
       BUTTON('&OK'),AT(287,201,47,14),USE(?OkButton),LEFT,ICON('WAOk.ico'),STD(STD:Close),DEFAULT
       BUTTON('&Cancel'),AT(340,201,47,14),USE(?CancelButton),LEFT,ICON('WACancel.ico'),STD(STD:Close)
     END

!!> MDI Child Window
Window WINDOW('Caption'),AT(,,185,92),MDI,SYSTEM,RESIZE,GRAY,FONT('MS Sans Serif',8,,FONT:regular)
       END

!!> Simple Window
Window WINDOW('Caption'),AT(,,260,100),GRAY
       END

!!> System Resizable Window
Window WINDOW('Caption'),AT(,,300,200),FONT('MS Sans Serif',8,,FONT:regular),ICON(ICON:Application),SYSTEM,GRAY,MAX,RESIZE
     END

!!> (Paper size A4 - Portrait)
Report REPORT,AT(1000,2000,6250,7688),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',10,,FONT:regular,CHARSET:ANSI),THOUS
       HEADER,AT(1000,1000,6250,1000),USE(?Header)
       END
Detail DETAIL,USE(?Detail)
       END
       FOOTER,AT(1000,9688,6250,1000),USE(?Footer)
       END
       FORM,AT(1000,1000,6250,9688),USE(?Form)
       END
     END

!!> (Paper size A4 - Landscape)
Report REPORT,AT(1000,2000,7688,4250),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',10,,FONT:regular,CHARSET:ANSI),LANDSCAPE,THOUS
       HEADER,AT(1000,1000,7688,1000),USE(?Header)
       END
Detail DETAIL,USE(?Detail)
       END
       FOOTER,AT(1000,6250,7688,1000),USE(?Footer)
       END
       FORM,AT(1000,1000,7688,6250),USE(?Form)
       END
     END

!!> (Paper size Legal - Portrait)
Report REPORT,AT(1000,2000,6500,10000),PAPER(PAPER:LEGAL),PRE(RPT),FONT('Arial',10,,FONT:regular,CHARSET:ANSI),THOUS
       HEADER,AT(1000,1000,6500,1000),USE(?Header)
       END
Detail DETAIL,USE(?Detail)
       END
       FOOTER,AT(1000,12000,6500,1000),USE(?Footer)
       END
       FORM,AT(1000,1000,6500,12000),USE(?Form)
       END
     END

!!> (Paper size Legal - Landscape)
Report REPORT,AT(1000,2000,10000,4500),PAPER(PAPER:LEGAL),PRE(RPT),FONT('Arial',10,,FONT:regular,CHARSET:ANSI),LANDSCAPE,THOUS
       HEADER,AT(1000,1000,10000,1000),USE(?Header)
       END
Detail DETAIL,USE(?Detail)
       END
       FOOTER,AT(1000,6500,10000,1000),USE(?Footer)
       END
       FORM,AT(1000,1000,10000,6500),USE(?Form)
       END
     END

!!> (Paper size Letter - Landscape)
Report REPORT,AT(1000,2000,9000,4500),PAPER(PAPER:LETTER),PRE(RPT),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
         LANDSCAPE,THOUS
       HEADER,AT(1000,1000,9000,1000),USE(?Header)
       END
Detail DETAIL,USE(?Detail)
       END
       FOOTER,AT(1000,6500,9000,1000),USE(?Footer)
       END
       FORM,AT(1000,1000,9000,6500),USE(?Form)
       END
     END

!!> (Paper size Letter - Portrait)
Report REPORT,AT(1000,2000,6500,7000),PAPER(PAPER:LETTER),PRE(RPT),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
         THOUS
       HEADER,AT(1000,1000,6500,1000),USE(?Header)
       END
Detail DETAIL,USE(?Detail)
       END
       FOOTER,AT(1000,9000,6500,1000),USE(?Footer)
       END
       FORM,AT(1000,1000,6500,9000),USE(?Form)
       END
     END
