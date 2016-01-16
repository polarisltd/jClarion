

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abtoolba.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE

                     MAP
                       INCLUDE('COOKB001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COOKB002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB004.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB007.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB008.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB009.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB010.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB011.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB012.INC'),ONCE        !Req'd for module callout resolution
                     END


Main PROCEDURE                                        !Generated from procedure template - Frame

SQLOpenWindow        WINDOW('Initializing Database'),AT(,,208,26),FONT('MS Sans Serif',8,,FONT:regular),CENTER,GRAY,DOUBLE
                       STRING('This process could take several seconds.'),AT(27,12)
                       IMAGE(Icon:Connect),AT(4,4,23,17)
                       STRING('Please wait while the program connects to the database.'),AT(27,3)
                     END

AppFrame             APPLICATION('Application'),AT(,,400,240),FONT('MS Sans Serif',8,,),STATUS(-1,80,120,45),SYSTEM,MAX,RESIZE,IMM
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
                         MENU('&Browse'),USE(?BrowseMenu)
                           ITEM('Browse the ingredients file'),USE(?Browseingredients),MSG('Browse ingredients')
                           ITEM('Browse the recipe file'),USE(?Browserecipe),MSG('Browse recipe')
                           ITEM('Browse the rimap file'),USE(?Browserimap),MSG('Browse rimap')
                         END
                         MENU('&Reports'),USE(?ReportMenu),MSG('Report data')
                           MENU('Report the ingredients file'),USE(?Printingredients)
                             ITEM('Print by ING:Keyid key'),USE(?PrintING:Keyid),MSG('Print ordered by the ING:Keyid key')
                             ITEM('Print by ING:Keyname key'),USE(?PrintING:Keyname),MSG('Print ordered by the ING:Keyname key')
                           END
                           MENU('Report the recipe file'),USE(?Printrecipe)
                             ITEM('Print by REC:Keyid key'),USE(?PrintREC:Keyid),MSG('Print ordered by the REC:Keyid key')
                             ITEM('Print by REC:Keyname key'),USE(?PrintREC:Keyname),MSG('Print ordered by the REC:Keyname key')
                             ITEM('Print by REC:Keytype key'),USE(?PrintREC:Keytype),MSG('Print ordered by the REC:Keytype key')
                           END
                           MENU('Report the rimap file'),USE(?Printrimap)
                             ITEM('Print by RIM:primarykey key'),USE(?PrintRIM:primarykey),MSG('Print ordered by the RIM:primarykey key')
                             ITEM('Print by RIM:recipekey key'),USE(?PrintRIM:recipekey),MSG('Print ordered by the RIM:recipekey key')
                             ITEM('Print by RIM:ingrediantkey key'),USE(?PrintRIM:ingrediantkey),MSG('Print ordered by the RIM:ingrediantkey key')
                           END
                         END
                         MENU('&Window'),USE(?WindowMenu),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('T&ile'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('&Cascade'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('&Help'),USE(?HelpMenu),MSG('Windows Help')
                           ITEM('&Contents'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()

Menu::FileMenu ROUTINE                                !Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                !Code for menu items on ?EditMenu
Menu::BrowseMenu ROUTINE                              !Code for menu items on ?BrowseMenu
  CASE ACCEPTED()
  OF ?Browseingredients
    START(Browseingredients, 050000)
  OF ?Browserecipe
    START(Browserecipe, 050000)
  OF ?Browserimap
    START(Browserimap, 050000)
  END
Menu::ReportMenu ROUTINE                              !Code for menu items on ?ReportMenu
Menu::Printingredients ROUTINE                        !Code for menu items on ?Printingredients
  CASE ACCEPTED()
  OF ?PrintING:Keyid
    START(PrintING:Keyid, 050000)
  OF ?PrintING:Keyname
    START(PrintING:Keyname, 050000)
  END
Menu::Printrecipe ROUTINE                             !Code for menu items on ?Printrecipe
  CASE ACCEPTED()
  OF ?PrintREC:Keyid
    START(PrintREC:Keyid, 050000)
  OF ?PrintREC:Keyname
    START(PrintREC:Keyname, 050000)
  OF ?PrintREC:Keytype
    START(PrintREC:Keytype, 050000)
  END
Menu::Printrimap ROUTINE                              !Code for menu items on ?Printrimap
  CASE ACCEPTED()
  OF ?PrintRIM:primarykey
    START(PrintRIM:primarykey, 050000)
  OF ?PrintRIM:recipekey
    START(PrintRIM:recipekey, 050000)
  OF ?PrintRIM:ingrediantkey
    START(PrintRIM:ingrediantkey, 050000)
  END
Menu::WindowMenu ROUTINE                              !Code for menu items on ?WindowMenu
Menu::HelpMenu ROUTINE                                !Code for menu items on ?HelpMenu

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SETCURSOR(Cursor:Wait)
  OPEN(SQLOpenWindow)
  ACCEPT
    IF EVENT() = Event:OpenWindow
  Relate:ingredients.Open
  SELF.FilesOpened = True
      POST(EVENT:CloseWindow)
    END
  END
  CLOSE(SQLOpenWindow)
  SETCURSOR()
  OPEN(AppFrame)
!  SELF.setICON()
  SELF.Opened=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ingredients.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    ELSE
      DO Menu::FileMenu                               !Process menu items on ?FileMenu menu
      DO Menu::EditMenu                               !Process menu items on ?EditMenu menu
      DO Menu::BrowseMenu                             !Process menu items on ?BrowseMenu menu
      DO Menu::ReportMenu                             !Process menu items on ?ReportMenu menu
      DO Menu::Printingredients                       !Process menu items on ?Printingredients menu
      DO Menu::Printrecipe                            !Process menu items on ?Printrecipe menu
      DO Menu::Printrimap                             !Process menu items on ?Printrimap menu
      DO Menu::WindowMenu                             !Process menu items on ?WindowMenu menu
      DO Menu::HelpMenu                               !Process menu items on ?HelpMenu menu
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

