

   MEMBER('TUTOR.clw')                                     ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('TUTOR001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('TUTOR002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR004.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR007.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR008.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR009.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR010.INC'),ONCE        !Req'd for module callout resolution
                     END


Main PROCEDURE                                             ! Generated from procedure template - Frame

AppFrame             APPLICATION('Application'),AT(,,505,318),FONT('MS Sans Serif',8,,FONT:regular),CENTER,ICON('WAFRAME.ICO'),STATUS(-1,80,120,45),SYSTEM,MAX,RESIZE,IMM
                       MENUBAR,USE(?Menubar)
                         MENU('&File'),USE(?FileMenu)
                           ITEM('&Print Setup ...'),USE(?PrintSetup),MSG('Setup printer'),STD(STD:PrintSetup)
                           ITEM,SEPARATOR
                           ITEM('E&xit'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('&Edit'),USE(?EditMenu)
                           ITEM('Cu&t'),USE(?Cut),MSG('Cut Selection To Clipboard'),STD(STD:Cut)
                           ITEM('&Copy'),USE(?Copy),MSG('Copy Selection To Clipboard'),STD(STD:Copy)
                           ITEM('&Paste'),USE(?Paste),MSG('Paste From Clipboard'),STD(STD:Paste)
                         END
                         MENU('&Browse'),USE(?BrowseMenu)
                           ITEM('Browse the CUSTOMER file'),USE(?BrowseCUSTOMER),MSG('Browse CUSTOMER')
                           ITEM('Browse the ORDERS file'),USE(?BrowseORDERS),MSG('Browse ORDERS')
                           ITEM('Browse the States file'),USE(?BrowseStates),MSG('Browse States')
                         END
                         MENU('&Reports'),USE(?ReportMenu),MSG('Report data')
                           MENU('Report the CUSTOMER file'),USE(?ReportCUSTOMER)
                             ITEM('Print by CUS:KEYCUSTNUMBER key'),USE(?ReportCUSTOMERByCUS:KEYCUSTNUMBER),MSG('Print ordered by the CUS:KEYCUSTNUMBER key')
                             ITEM('Print by CUS:KEYCOMPANY key'),USE(?ReportCUSTOMERByCUS:KEYCOMPANY),MSG('Print ordered by the CUS:KEYCOMPANY key')
                             ITEM('Print by CUS:KEYZIPCODE key'),USE(?ReportCUSTOMERByCUS:KEYZIPCODE),MSG('Print ordered by the CUS:KEYZIPCODE key')
                           END
                           MENU('Report the ORDERS file'),USE(?ReportORDERS)
                             ITEM('Print by ORD:KEYORDERNUMBER key'),USE(?ReportORDERSByORD:KEYORDERNUMBER),MSG('Print ordered by the ORD:KEYORDERNUMBER key')
                             ITEM('Print by ORD:KEYCUSTNUMBER key'),USE(?ReportORDERSByORD:KEYCUSTNUMBER),MSG('Print ordered by the ORD:KEYCUSTNUMBER key')
                           END
                           ITEM('Print by STA:KeyState key'),USE(?ReportStatesBySTA:KeyState),MSG('Print ordered by the STA:KeyState key')
                         END
                         MENU('&Window'),USE(?WindowMenu),STD(STD:WindowList)
                           ITEM('T&ile'),USE(?Tile),MSG('Arrange multiple opened windows'),STD(STD:TileWindow)
                           ITEM('&Cascade'),USE(?Cascade),MSG('Arrange multiple opened windows'),STD(STD:CascadeWindow)
                           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Arrange the icons for minimized windows'),STD(STD:ArrangeIcons)
                         END
                         MENU('&Help'),USE(?HelpMenu)
                           ITEM('&Contents'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('Provides general instructions on using help'),STD(STD:HelpOnHelp)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------
Menu::Menubar ROUTINE                                      ! Code for menu items on ?Menubar
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::BrowseMenu ROUTINE                                   ! Code for menu items on ?BrowseMenu
  CASE ACCEPTED()
  OF ?BrowseCUSTOMER
    START(BrowseCUSTOMER, 050000)
  OF ?BrowseORDERS
    START(BrowseORDERS, 050000)
  OF ?BrowseStates
    START(BrowseStates, 050000)
  END
Menu::ReportMenu ROUTINE                                   ! Code for menu items on ?ReportMenu
  CASE ACCEPTED()
  OF ?ReportStatesBySTA:KeyState
    START(ReportStatesBySTA:KeyState, 050000)
  END
Menu::ReportCUSTOMER ROUTINE                               ! Code for menu items on ?ReportCUSTOMER
  CASE ACCEPTED()
  OF ?ReportCUSTOMERByCUS:KEYCUSTNUMBER
    START(ReportCUSTOMERByCUS:KEYCUSTNUMBER, 050000)
  OF ?ReportCUSTOMERByCUS:KEYCOMPANY
    START(ReportCUSTOMERByCUS:KEYCOMPANY, 050000)
  OF ?ReportCUSTOMERByCUS:KEYZIPCODE
    START(ReportCUSTOMERByCUS:KEYZIPCODE, 050000)
  END
Menu::ReportORDERS ROUTINE                                 ! Code for menu items on ?ReportORDERS
  CASE ACCEPTED()
  OF ?ReportORDERSByORD:KEYORDERNUMBER
    START(ReportORDERSByORD:KEYORDERNUMBER, 050000)
  OF ?ReportORDERSByORD:KEYCUSTNUMBER
    START(ReportORDERSByORD:KEYCUSTNUMBER, 050000)
  END
Menu::WindowMenu ROUTINE                                   ! Code for menu items on ?WindowMenu
Menu::HelpMenu ROUTINE                                     ! Code for menu items on ?HelpMenu

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  OPEN(AppFrame)                                           ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  INIMgr.Fetch('Main',AppFrame)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Main',AppFrame)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    ELSE
      DO Menu::Menubar                                     ! Process menu items on ?Menubar menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::BrowseMenu                                  ! Process menu items on ?BrowseMenu menu
      DO Menu::ReportMenu                                  ! Process menu items on ?ReportMenu menu
      DO Menu::ReportCUSTOMER                              ! Process menu items on ?ReportCUSTOMER menu
      DO Menu::ReportORDERS                                ! Process menu items on ?ReportORDERS menu
      DO Menu::WindowMenu                                  ! Process menu items on ?WindowMenu menu
      DO Menu::HelpMenu                                    ! Process menu items on ?HelpMenu menu
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

