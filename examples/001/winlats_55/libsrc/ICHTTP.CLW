  MEMBER()

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICSTD.EQU')
  INCLUDE('ERRORS.CLW')
  INCLUDE('ICHTTP.INC')

  MAP
    INCLUDE('IcStd.inc')

    GetHIQProperty(*HttpInfoQueue, STRING),STRING
    SetHIQProperty(*HttpInfoQueue, STRING, STRING, SIGNED=0, SIGNED=0)
  END

Trace           EQUATE(1)
!- Module variables ----------------------------------------------------------

ServerName           EQUATE('Clw/0.02')
MimeVersion          EQUATE('1.0')
AllowedHtml          EQUATE('GET HEAD SPACEJUMP')

BuffFILEnameOut      CSTRING(FILE:MaxFileName)
BuffFILEnameIn       CSTRING(FILE:MaxFileName)
BuffLen              EQUATE(1024)

BuffFILEOut          FILE,DRIVER('DOS'),NAME(BuffFILEnameOut),PRE(BOut),THREAD,CREATE
RECORD                 RECORD,PRE()
Buffer                   STRING(BuffLen)
                       END
                     END
BuffFILEIn           FILE,DRIVER('DOS'),NAME(BuffFILEnameIn),PRE(BIn),THREAD,CREATE
RECORD                 RECORD,PRE()
Buffer                   STRING(BuffLen)
                       END
                     END


SpecialProp          EQUATE(1)

! Helper functions....

GetHIQProperty      PROCEDURE(*HttpInfoQueue Queue, STRING PropName)
  CODE

  Queue.Name = UPPER(PropName)
  GET(Queue, +Queue.Name)
  IF (ERRORCODE())
    RETURN ''
  ELSE
    RETURN (Queue.Value)
  END


SetHIQProperty      PROCEDURE(*HttpInfoQueue Queue, STRING PropName, STRING Value, SIGNED Special=0, SIGNED Multiple=0)
  CODE

  Queue.Name = UPPER(PropName)
  Queue.Value = Value
  Queue.Special = Special
  IF (Multiple)
    ADD(Queue, +Queue.Name)
  ELSE
    GET(Queue, +Queue.Name)
    IF (ERRORCODE()) ! if not found
      ADD(Queue, +Queue.Name)
    ELSE
      Queue.Value = Value
      Queue.Special = Special
      PUT(Queue, +Queue.Name)
    END
  END



!- HttpPageBaseClass members

HttpPageBaseClass.Init      PROCEDURE(*HttpBaseClass Http, SIGNED Status, STRING Page, STRING TempFilename)

  CODE

  SELF.Http &= Http
  SELF.Status = Status
  IF (Page <> '')
    SELF.PageFilename = Page
    SELF.GotHtmlBody = TRUE
    SELF.HtmlFilename = TempFilename
  ELSE
    SELF.PageFilename = 'html'
    SELF.GotHtmlBody = FALSE
  END

  SELF.FileHandler &= NEW TextOutputClass


HttpPageBaseClass.Kill        PROCEDURE
  CODE

  DISPOSE(SELF.FileHandler)


HttpPageBaseClass.AppendFileTo      PROCEDURE(STRING SrcFile, STRING DestFile, BYTE DeleteSrc)
BuffPos              UNSIGNED,AUTO
SrcFileSize          ULONG,AUTO
  CODE

  BuffPos = 0
  BuffFILEnameIn = SrcFile
  BuffFILEnameOut = DestFile

  OPEN(BuffFILEIn, 0)
  OPEN(BuffFILEOut, 1)
  ASSERT(~ERRORCODE())

  SrcFileSize = BYTES(BuffFILEIn)
  LOOP
    GET(BuffFILEIn, (BuffPos+1))
    BOut:Buffer = BIn:Buffer
    IF ((BuffPos+BuffLen) >= SrcFileSize)
      ADD(BuffFILEOut, (SrcFileSize-BuffPos))
      BREAK
    END
    BuffPos += BuffLen
    ADD(BuffFILEOut)
  END

  CLOSE(BuffFILEIn)
  CLOSE(BuffFILEOut)

  IF (DeleteSrc)
    REMOVE(BuffFILEIn)
  END

  RETURN SrcFileSize


HttpPageBaseClass.SetupHttpStatus       PROCEDURE(SIGNED Status)
CodeMsg              STRING(15),AUTO

  CODE

  SELF.Http.SetServerProperty('HttpProtocol', 'HTTP/1.0', SpecialProp)

  CASE (Status)
  OF 200
    CodeMsg = 'OK'
  OF 201
    CodeMsg = 'Created'
  OF 202
    CodeMsg = 'Accepted'
  OF 204
    CodeMsg = 'No Content'
  OF 300
    CodeMsg = 'Multiple Choices'
  OF 301
    CodeMsg = 'Moved Permanently'
  OF 302
    CodeMsg = 'Moved Temporarily'
  OF 304
    CodeMsg = 'Not Modified'
  OF 400
    CodeMsg = 'Bad Request'
  OF 401
    CodeMsg = 'Unauthorized'
  OF 403
    CodeMsg = 'Forbidden'
  OF 404
    CodeMsg = 'Not Found'
  OF 500
    CodeMsg = 'Internal Server Error'
  OF 501
    CodeMsg = 'Not Implemented'
  OF 502
    CodeMsg = 'Bad Gateway'
  OF 503
    CodeMsg = 'Service Unavailable'
  ELSE
    CodeMsg = 'UNKNOWN!'
  END
  
  SELF.Http.SetServerProperty('ErrorNum', '' & status, SpecialProp)
  SELF.Http.SetServerProperty('ErrorMsg', CodeMsg, SpecialProp)


HttpPageBaseClass.HandleStatusCode    PROCEDURE
  CODE

  SELF.SetupHttpStatus(SELF.Status)


HttpPageBaseClass.WritePageBody        PROCEDURE
ServerItems          UNSIGNED,AUTO
I                    UNSIGNED,AUTO
  CODE

  ServerItems = RECORDS(SELF.Http.ServerInfo)
  ASSERT(ServerItems > 0)

  LOOP I = 1 TO ServerItems
    GET(SELF.Http.ServerInfo, I)

    IF (NOT SELF.Http.ServerInfo.Special) ! deal with seperatly
      SELF.FileHandler.WriteLn(SELF.Http.ServerInfo.Name & ': ' & CLIP(SELF.Http.ServerInfo.Value))
    END
  END

  RETURN


HttpPageBaseClass.PreparePage    PROCEDURE
  CODE

  IF (SELF.GotHtmlBody)
    SELF.FileLen = SELF.FileHandler.GetSize(SELF.PageFilename)
    ASSERT(SELF.FileLen<>0)

    IC:RemoveFile(SELF.HtmlFilename)
    IC:RenameFile(SELF.PageFilename, SELF.HtmlFilename)

    SELF.Http.SetServerProperty('Content-length', '' & SELF.FileLen)
  ELSE
    SELF.HtmlFilename = SELF.PageFilename
  END

  SELF.NowDateTime = IC:GetStrDateTime(TODAY(), CLOCK())
  SELF.ExpireDateTime = SELF.NowDateTime

  SELF.PreparePageBody()

  SELF.HandleStatusCode()


HttpPageBaseClass.PreparePageBody        PROCEDURE
  CODE
  ! setup up ServerInfo queue here.. for base no info needed..


HttpPageBaseClass.FinishPage PROCEDURE
Protocol             CSTRING(20)
ErrorNum             CSTRING(5)
ErrorMsg             CSTRING(30)

  CODE

  SELF.FileHandler.CreateOpen(SELF.PageFilename)

  Protocol = SELF.Http.GetServerProperty('HttpProtocol')
  ErrorNum = SELF.Http.GetServerProperty('ErrorNum')
  ErrorMsg = SELF.Http.GetServerProperty('ErrorMsg')
  SELF.FileHandler.WriteLn(Protocol & ' ' & ErrorNum & ' ' & ErrorMsg)

  SELF.WritePageBody()

  SELF.FileHandler.Writeln()
  SELF.FileHandler.Close()

  IF (SELF.GotHtmlBody)
    SELF.AppendFileTo(SELF.HtmlFilename, SELF.PageFilename, TRUE)
  ELSE
    SELF.AppendDefaultBody()
  END


HttpPageBaseClass.AppendDefaultBody        PROCEDURE
  CODE

  SELF.FileHandler.Open(SELF.PageFilename)
  SELF.FileHandler.WriteLn('<<HTML>')
  SELF.FileHandler.WriteLn('<<P>Error code: ' & SELF.Status & '<</P>')
  SELF.FileHandler.WriteLn('<</HTML>')
  SELF.FileHandler.Close()

!
!!!!!!!! HttpBrowserClass derived from HttpBaseClass
!

HttpPageBrowserClass.PreparePageBody        PROCEDURE
FileDateTime            STRING(100)
HtmlFileQueue           QUEUE(FILE:Queue),PRE(XXX).

  CODE

  PARENT.PreparePageBody()

  IF (SELF.GotHtmlBody)
    DIRECTORY(HtmlFileQueue,SELF.HtmlFilename,ff_:NORMAL)

    ASSERT(RECORDS(HtmlFileQueue) = 1)
    GET(HtmlFileQueue, 1)

    FileDateTime = IC:GetStrDateTime(HtmlFileQueue.Date, HtmlFileQueue.Time)
    SELF.Http.SetServerProperty('Last-modified', FileDateTime)
  END

  SELF.Http.SetServerProperty('Server', ServerName)        ! defaults in ichttp.inc
  SELF.Http.SetServerProperty('Date', SELF.NowDateTime)
  SELF.Http.SetServerProperty('Content-type', 'text/html')

  RETURN


HttpPageBrowserClass.HandleStatusCode    PROCEDURE
  CODE

  PARENT.HandleStatusCode()

  IF (SELF.Status = 200) OR (SELF.Status = 401)
    SELF.Http.SetServerProperty('Allowed', AllowedHtml)
    SELF.Http.SetServerProperty('MIME-Version', MimeVersion)
    SELF.Http.SetServerProperty('Expires', SELF.ExpireDateTime)
  END


HttpPageBrowserClass.FinishPage    PROCEDURE

  CODE
  SELF.Http.SendCookies()
  PARENT.FinishPage()

!
!!!!!!!! HttpJavaClass derived from HttpBaseClass
!

! no additions/alterations to base.


!
! HttpClass : HttpBaseClass
!
!

HttpClass.Init                  PROCEDURE(WebFilesClass Files)
  CODE

  SELF.ServerInfo &= NEW HttpInfoQueue
  SELF.BrowserInfo &= NEW HttpInfoQueue
  SELF.Cookies &= NEW CookiesQueue
  SELF.Files &= Files



HttpClass.Kill                  PROCEDURE
  CODE
  DISPOSE(SELF.BrowserInfo)
  DISPOSE(SELF.ServerInfo)
  DISPOSE(SELF.Cookies)


OMIT('!EndDebug!')
HttpClass.DebugBrowserInfo        PROCEDURE
BrowserItems         UNSIGNED,AUTO
I                    UNSIGNED,AUTO
  CODE

  BrowserItems = RECORDS(SELF.BrowserInfo)
  ASSERT(BrowserItems > 0)

  LOOP I = 1 TO BrowserItems
    GET(SELF.BrowserInfo, I)

    printdebugstring('BrowserInfo(' & I & ') : ' & SELF.BrowserInfo.Name & ' = ' & SELF.BrowserInfo.Value)
    printdebugline
  END

  RETURN
!EndDebug!


HttpClass.GetBrowserProperty      PROCEDURE(STRING PropName)

  CODE
  RETURN GetHIQProperty(SELF.BrowserInfo, PropName)


HttpClass.SetBrowserProperty      PROCEDURE(STRING PropName, STRING Value)

  CODE
  SetHIQProperty(SELF.BrowserInfo, PropName, Value)


HttpClass.GetServerProperty      PROCEDURE(STRING PropName)
  CODE
  RETURN GetHIQProperty(SELF.ServerInfo, PropName)


HttpClass.SetServerProperty      PROCEDURE(STRING PropName, STRING Value, SIGNED special=0, SIGNED Multiple=0)
  CODE
  SetHIQProperty(SELF.ServerInfo, PropName, Value, special, Multiple)


HttpClass.ProcessHeader      PROCEDURE(STRING Page)
PagePos              UNSIGNED,AUTO
EndPos               UNSIGNED,AUTO
EndLen               UNSIGNED,AUTO

  CODE

  SELF.Arguments = ''
  FREE(SELF.BrowserInfo)
  FREE(SELF.ServerInfo)
  FREE(SELF.Cookies)

  PagePos = 1

  LOOP
    EndPos = INSTRING('<10>', Page, 1, PagePos)
    EndLen = 1
    IF (EndPos > 1) AND (Page[EndPos-1] = '<13>')
      EndPos -= 1
      EndLen = 2
    END
    IF (EndPos = 0) ! no more lines (probably PagePos == LEN(Page)))
      BREAK
    END

    IF (EndPos = PagePos)
      BREAK ! End of http header at blank line
    ELSE
      SELF.ProcessInfoLine(Page[(PagePos):(EndPos-1)])
    END
    PagePos = EndPos+EndLen
  END


HttpClass.ProcessInfoLine      PROCEDURE(STRING Line)
LineLen              SIGNED,AUTO
InfoSepPos           UNSIGNED,AUTO
InfoSepPos2          UNSIGNED,AUTO
Tag                  CSTRING(40)
Value                CSTRING(255)
ValPos               SIGNED

  CODE

  LineLen = LEN(Line)
  InfoSepPos = 0
  IF ((LineLen > 4) AND (UPPER(Line[1:4]) = 'GET '))
    InfoSepPos = INSTRING('?', Line, 1, 5)
    IF (NOT InfoSepPos) ! no args
      SELF.Arguments = ''
      InfoSepPos = 4
    END
    InfoSepPos2 = INSTRING(' ', Line, 1, InfoSepPos+1)
    IF (NOT InfoSepPos2)
      IF (InfoSepPos <> 4) ! are there any arguments
        SELF.Arguments = Line[(InfoSepPos+1):(LineLen)]
      END
      SELF.SetBrowserProperty('HttpProtocol', 'HTTP/1.0')
    ELSE
      IF (InfoSepPos <> 4) ! are there any arguments
        SELF.Arguments = Line[(InfoSepPos+1):(InfoSepPos2-1)]
      END
      SELF.SetBrowserProperty('HttpProtocol', Line[(InfoSepPos2+1):(LineLen)])
      ASSERT(~ERRORCODE())
    END

    RETURN
  ELSE
    InfoSepPos = INSTRING(':', Line, 1, 1)

    Value = Line[(InfoSepPos+2):(LineLen)]
    ValPos = 1
    LOOP WHILE (Value[ValPos] = ' ')
      ValPos = ValPos + 1
    END
    IF (ValPos <> 1)
      Value = Value[(ValPos):(LEN(Value))]
    END

    Tag = UPPER(Line[1:(InfoSepPos-1)])

    IF ((LEN(Tag)>=5) AND (Tag[1:5] = 'HTTP_'))
      Tag = Tag[6:(LEN(Tag))]
    END

    IF (Tag = 'COOKIE')
      SELF.StoreCookies(Value)
    ELSE
      SELF.SetBrowserProperty(Tag, Value)
    END
  END


HttpClass.GetArguments      PROCEDURE()
  CODE

  RETURN SELF.Arguments


HttpClass.ClearUp                PROCEDURE
  CODE

  IF (NOT SELF.HttpPage &= NULL)
    SELF.HttpPage.Kill()
    DISPOSE(SELF.HttpPage)
  END


HttpClass.PreparePage           PROCEDURE(*HttpPageBaseClass HttpPage, SIGNED Status, <STRING Filename>)
  CODE

  SELF.ClearUp()
  SELF.HttpPage &= HttpPage
  SELF.HttpPage.Init(SELF, status, Filename, SELF.Files.GetTempFilename(Filename))
  SELF.HttpPage.PreparePage()


HttpClass.PreparePageForBrowser    PROCEDURE(SIGNED status, <STRING Filename>)
HttpPage &HttpPageBaseClass

  CODE

  HttpPage &= NEW HttpPageBrowserClass
  SELF.PreparePage(HttpPage, status, Filename)


HttpClass.PreparePageForJava    PROCEDURE(SIGNED status, <STRING Filename>)
HttpPage &HttpPageBaseClass
  CODE

  HttpPage &= NEW HttpPageJavaClass
  SELF.PreparePage(HttpPage, status, Filename)


HttpClass.PrepareUnauthorized    PROCEDURE(<STRING Filename>)
  CODE

  SELF.PreparePageForBrowser(401, Filename)
  SELF.SetServerProperty('WWW-authenticate', 'basic realm="' & SELF.ProgName & ':' & SELF.ProcName & '"')


HttpClass.StoreCookies    PROCEDURE(STRING cookies)
len                  SIGNED,AUTO
offset               SIGNED,AUTO
start                SIGNED,AUTO
  CODE

  start = 1
  len = LEN(cookies)

  LOOP
    LOOP WHILE (start <= len) AND (cookies[start] = ' ')
      start += 1
    END
    IF (start > len)
      RETURN
    END
    offset = INSTRING(';', cookies, 1, start)
    IF (NOT offset)
      ! last cookie
      SELF.StoreCookie(cookies[(start):(len)])
      BREAK
    ELSE
      SELF.StoreCookie(cookies[(start):(offset-1)])
    END
    start = offset + 1
  END


HttpClass.StoreCookie    PROCEDURE(STRING cookie)
offset               SIGNED,AUTO

  CODE

  offset = INSTRING('=', cookie, 1, 1)
  IF (0 = offset)
    SELF.SetCookieModified(FALSE, cookie, '', 0, 0)
  ELSE
    SELF.SetCookieModified(FALSE, cookie[1:(offset-1)], IC:DecodeBase64(cookie[(offset+1):(LEN(cookie))]), 0, 0)
  END


HttpClass.SetCookie    PROCEDURE(STRING name, STRING Value, LONG ExpireDate=0, LONG ExpireTime=0, <STRING Path>)
CompoundName         CSTRING(255),AUTO

  CODE
  CompoundName = SELF.ProgName & '-' & Name

  IF (ExpireDate = 0)
    ExpireDate = TODAY()+28
    ExpireTime = CLOCK()
  END
  SELF.SetCookieModified(TRUE, CompoundName, Value, ExpireDate, ExpireTime, Path)


HttpClass.SetCookieModified    PROCEDURE(BYTE Modified, STRING Name, STRING Value, LONG ExpireDate=0, LONG ExpireTime=0, <STRING Path>)
  CODE

  SELF.Cookies.Name = CLIP(Name)
  GET(SELF.Cookies, +SELF.Cookies.Name)
  SELF.Cookies.Value = CLIP(Value)
  SELF.Cookies.Path = CLIP(Path)
  SELF.Cookies.ExpireDate = ExpireDate
  SELF.Cookies.ExpireTime = ExpireTime
  SELF.Cookies.Modified = Modified
  IF (ERRORCODE()) ! if not found
    ADD(SELF.Cookies, +SELF.Cookies.Name)
  ELSE
    PUT(SELF.Cookies, +SELF.Cookies.Name)
  END


HttpClass.GetCookie    PROCEDURE(STRING Name)
CompoundName         CSTRING(255),AUTO

  CODE

  CompoundName = SELF.ProgName & '-' & Name

  SELF.Cookies.Name = CompoundName
  GET(SELF.Cookies, SELF.Cookies.Name)
  IF (ERRORCODE())
    RETURN ''
  ELSE
    RETURN (SELF.Cookies.Value)
  END


HttpClass.SendCookies    PROCEDURE
NumCookies           SIGNED,AUTO
ExtendedValue        CSTRING(1000)
DateTime             CSTRING(100)
I                    SIGNED,AUTO
  CODE

  NumCookies = RECORDS(SELF.Cookies)
  LOOP I = 1 TO NumCookies
    GET(SELF.Cookies, I)
    IF (SELF.Cookies.Modified)
      ExtendedValue = SELF.Cookies.Name & '=' & IC:EncodeBase64(SELF.Cookies.Value) & ''
      IF (NOT (SELF.Cookies.Path = ''))
        ExtendedValue = ExtendedValue & '; path=' & SELF.Cookies.Path
      ELSE
        ExtendedValue = ExtendedValue & '; path=/'
      END
      IF (SELF.Cookies.ExpireDate <> 0)
        DateTime = IC:GetStrDateTime(SELF.Cookies.ExpireDate, SELF.Cookies.ExpireTime)
        ExtendedValue = ExtendedValue & '; expires=' & DateTime
      END

      SELF.SetServerProperty('Set-Cookie', ExtendedValue, FALSE, TRUE)
    END
  END


HttpClass.FinishPage    PROCEDURE
  CODE

  SELF.HttpPage.FinishPage()
  SELF.ClearUp()


HttpClass.SetProgName          PROCEDURE(STRING ProgName)
  CODE
  SELF.ProgName = CLIP(ProgName)


HttpClass.SetProcName          PROCEDURE(STRING ProcName)
  CODE
  SELF.ProcName = CLIP(ProcName)


HttpClass.GetAuthorizedInfo    PROCEDURE(*STRING User, *STRING Pass)
UserPassCode         CSTRING(100)
UserPass             CSTRING(100)
CharPos              SIGNED
  CODE

  UserPassCode = SELF.GetBrowserProperty('Authorization')
  CharPos = INSTRING(' ', UserPassCode, 1, 1)
  UserPassCode = UserPassCode[(CharPos+1):(LEN(UserPassCode))]

  IF (UserPassCode <> '')
    UserPass = IC:DecodeBase64(UserPassCode)
    CharPos = INSTRING(':', UserPass, 1, 1)

    IF (CharPos)
      User = UPPER(UserPass[1:(CharPos-1)])
      Pass = UserPass[(CharPos+1):(LEN(UserPass))]
    END
  END
