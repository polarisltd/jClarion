   					PROGRAM

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
                         END
                       END
                     END

                     
ingredients          FILE,DRIVER('ODBC'),OWNER('cookbook'),NAME('ingredients'),PRE(ING),CREATE,BINDABLE,THREAD
Keyid                    KEY(ING:id),NOCASE,OPT,PRIMARY
Keyname                  KEY(ING:name),DUP,NOCASE
Record                   RECORD,PRE()
id                          LONG
name                        STRING(50)
shelflife                   DECIMAL(5)
cost                        DECIMAL(8,2)
                         END
                     END                       
                     
                     
                     CODE
                     OPEN(AppFrame)
                     
                     ACCEPT
                         IF EVENT() = Event:CloseWindow
                               ! POST(EVENT:CloseWindow)
                         END
                     END
                     
                     
                     
                     
                     
                     