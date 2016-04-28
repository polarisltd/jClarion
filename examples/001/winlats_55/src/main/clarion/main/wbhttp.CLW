  MEMBER

  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('ERRORS.CLW'),ONCE
  INCLUDE('WBHTTP.INC'),ONCE
  INCLUDE('WBSTD.INC'),ONCE

  MAP
GetHIQProperty  PROCEDURE(*HttpInfoQueue, STRING),STRING
SetHIQProperty  PROCEDURE(*HttpInfoQueue, STRING, STRING, SIGNED=0, SIGNED=0)
    MODULE('ClwLib')
      memchr(long address, signed search, signed maxlen),long,name('_memchr')
    END
FASTINSTRING    PROCEDURE(BYTE search, * STRING text, SIGNED start),SIGNED
  END

Trace           EQUATE(1)

!- Module variables ----------------------------------------------------------

ServerName           EQUATE('Clw/0.02')
MimeVersion          EQUATE('1.0')

AllowedHtml          EQUATE('GET POST HEAD SPACEJUMP')

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



!- WbHttpPageBaseClass members

WbHttpPageBaseClass.Init      PROCEDURE(*WbHttpBaseClass Http, SIGNED Status, STRING Page, STRING HtmlFilename)

  CODE

  SELF.Http &= Http
  SELF.Status = Status
  IF (Page <> '')
    SELF.PageFilename = Page
    SELF.GotHtmlBody = TRUE
    SELF.HtmlFilename = HtmlFilename
  ELSE
    SELF.PageFilename = 'html'
    SELF.GotHtmlBody = FALSE
  END

  SELF.FileHandler &= NEW WbTextOutputClass


WbHttpPageBaseClass.Kill        PROCEDURE
  CODE

  DISPOSE(SELF.FileHandler)


WbHttpPageBaseClass.AppendFileTo      PROCEDURE(STRING SrcFile, STRING DestFile, BYTE DeleteSrc)
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


WbHttpPageBaseClass.SetupHttpStatus       PROCEDURE(SIGNED Status)
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


WbHttpPageBaseClass.HandleStatusCode    PROCEDURE
  CODE

  SELF.SetupHttpStatus(SELF.Status)


WbHttpPageBaseClass.WritePageBody        PROCEDURE
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


WbHttpPageBaseClass.PreparePage    PROCEDURE
LastClock               long,static
LastDate                long,static
ThisClock               long,auto
ThisDate                long,auto
MaxClock                long(24*60*60*100)
  CODE

  IF (SELF.GotHtmlBody)
    SELF.FileLen = SELF.FileHandler.GetSize(SELF.PageFilename)
    ASSERT(SELF.FileLen<>0, 'Empty page returned to broker (?skeletons not found)')

    SELF.Http.SetServerProperty('Content-length', '' & SELF.FileLen)
  ELSE
    SELF.HtmlFilename = SELF.PageFilename
  END

  ! If the page gets the same date as the last page its might not get refreshed....
  ! need to be careful about midnight...
  ThisClock = CLOCK()
  ThisDate = TODAY()
  IF (ThisDate < LastDate) OR ((ThisDate = LastDate) AND (ThisClock <= LastClock))
    ThisClock = LastClock+1
    ThisDate = LastDate
    IF (ThisClock > MaxClock) THEN
      ThisClock -= MaxClock
      ThisDate += 1
    END
  END
  LastClock = ThisClock
  LastDate = ThisDate

  SELF.NowDateTime = IC:GetStrDateTime(ThisDate, ThisClock)
  SELF.ExpireDateTime = SELF.NowDateTime

  SELF.PreparePageBody()

  SELF.HandleStatusCode()


WbHttpPageBaseClass.PreparePageBody        PROCEDURE
  CODE
  ! setup up ServerInfo queue here.. for base no info needed..


WbHttpPageBaseClass.FinishPage PROCEDURE
Protocol             CSTRING(20)
ErrorNum             CSTRING(5)
ErrorMsg             CSTRING(30)

  CODE

  SELF.FileHandler.CreateOpen(SELF.HtmlFilename)

  Protocol = SELF.Http.GetServerProperty('HttpProtocol')
  ErrorNum = SELF.Http.GetServerProperty('ErrorNum')
  ErrorMsg = SELF.Http.GetServerProperty('ErrorMsg')
  SELF.FileHandler.WriteLn(Protocol & ' ' & ErrorNum & ' ' & ErrorMsg)

  SELF.WritePageBody()

  SELF.FileHandler.Writeln()
  SELF.FileHandler.Close()

  IF (SELF.GotHtmlBody)
    SELF.AppendFileTo(SELF.PageFilename, SELF.HtmlFilename, TRUE)
  ELSE
    SELF.AppendDefaultBody()
  END
  RETURN SELF.HtmlFilename


WbHttpPageBaseClass.AppendDefaultBody        PROCEDURE
  CODE

  SELF.FileHandler.Open(SELF.HtmlFilename)
  SELF.FileHandler.WriteLn('<<HTML>')
  SELF.FileHandler.WriteLn('<<P>Error code: ' & SELF.Status & '<</P>')
  SELF.FileHandler.WriteLn('<</HTML>')
  SELF.FileHandler.Close()

!
!!!!!!!! HttpBrowserClass derived from WbHttpBaseClass
!

WbHttpPageBrowserClass.PreparePageBody        PROCEDURE
FileDateTime            STRING(100)
HtmlFileQueue           QUEUE(FILE:Queue),PRE(XXX).

  CODE

  PARENT.PreparePageBody()

  IF (SELF.GotHtmlBody)
    DIRECTORY(HtmlFileQueue,SELF.PageFilename,ff_:NORMAL)

    ASSERT(RECORDS(HtmlFileQueue) = 1)
    GET(HtmlFileQueue, 1)

    FileDateTime = IC:GetStrDateTime(HtmlFileQueue.Date, HtmlFileQueue.Time)
    SELF.Http.SetServerProperty('Last-modified', FileDateTime)
  END

  SELF.Http.SetServerProperty('Server', ServerName)        ! defaults in ichttp.inc
  SELF.Http.SetServerProperty('Date', SELF.NowDateTime)
  SELF.Http.SetServerProperty('Content-type', 'text/html')

  RETURN


WbHttpPageBrowserClass.HandleStatusCode    PROCEDURE
  CODE

  PARENT.HandleStatusCode()

  IF (SELF.Status = 200) OR (SELF.Status = 401)
    SELF.Http.SetServerProperty('Allowed', AllowedHtml)
    SELF.Http.SetServerProperty('MIME-Version', MimeVersion)
    SELF.Http.SetServerProperty('Expires', SELF.ExpireDateTime)
  END


WbHttpPageBrowserClass.FinishPage    PROCEDURE

  CODE
  SELF.Http.SendCookies()
  RETURN PARENT.FinishPage()

!
!!!!!!!! HttpJavaClass derived from WbHttpBaseClass
!

! no additions/alterations to base.


!
! WbHttpClass : WbHttpBaseClass
!
!

WbHttpClass.Init                  PROCEDURE(WbFilesClass Files)
  CODE

  SELF.ServerInfo &= NEW HttpInfoQueue
  SELF.BrowserInfo &= NEW HttpInfoQueue
  SELF.Cookies &= NEW CookiesQueue
  SELF.Files &= Files



WbHttpClass.Kill                  PROCEDURE
  CODE
  DISPOSE(SELF.Arguments)
  DISPOSE(SELF.BrowserInfo)
  DISPOSE(SELF.ServerInfo)
  DISPOSE(SELF.Cookies)


OMIT('!EndDebug!')
WbHttpClass.DebugBrowserInfo        PROCEDURE
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


WbHttpClass.GetBrowserProperty      PROCEDURE(STRING PropName)

  CODE
  RETURN GetHIQProperty(SELF.BrowserInfo, PropName)


WbHttpClass.SetBrowserProperty      PROCEDURE(STRING PropName, STRING Value)

  CODE
  SetHIQProperty(SELF.BrowserInfo, PropName, Value)


WbHttpClass.GetServerProperty      PROCEDURE(STRING PropName)
  CODE
  RETURN GetHIQProperty(SELF.ServerInfo, PropName)


WbHttpClass.SetServerProperty      PROCEDURE(STRING PropName, STRING Value, SIGNED special=0, SIGNED Multiple=0)
  CODE
  SetHIQProperty(SELF.ServerInfo, PropName, Value, special, Multiple)


WbHttpClass.ProcessHeader      PROCEDURE(STRING Page)
StartOfLine          UNSIGNED,AUTO
EndOfLine            UNSIGNED,AUTO
EndLen               UNSIGNED,AUTO
PageLen              UNSIGNED,AUTO
EndOfLineAddress     LONG,AUTO

  CODE

  DISPOSE(SELF.Arguments)
  SELF.IsPost = FALSE
  FREE(SELF.BrowserInfo)
  FREE(SELF.ServerInfo)
  FREE(SELF.Cookies)

  StartOfLine = 1
  PageLen = LEN(Page)

  LOOP WHILE (StartOfLine <= PageLen)
    EndOfLineAddress = memchr(ADDRESS(Page) + (StartOfLine-1), VAL('<10>'), PageLen-(StartOfLine-1))
    EndLen = 1
    IF EndOfLineAddress = 0
      EndOfLine = PageLen+1
      EndLen = 0
    ELSE
      EndOfLine = EndOfLineAddress - ADDRESS(Page) + 1
      IF (EndOfLine > 1) AND (Page[EndOfLine-1] = '<13>')
        EndOfLine -= 1
        EndLen = 2
      END
    END

    IF (EndOfLine <> StartOfLine)
      SELF.ProcessInfoLine(Page[(StartOfLine):(EndOfLine-1)])
    ELSE
      !Blank line marks the end of the header, for POST the arguments follow.
      StartOfLine = EndOfLine+EndLen
      IF SELF.IsPost AND (StartOfLine <= PageLen)
        SELF.SetArguments(Page[StartOfLine : PageLen])
      END
      BREAK
    END
    StartOfLine = EndOfLine+EndLen
  END


WbHttpClass.ProcessInfoLine      PROCEDURE(STRING Line)
LineLen              SIGNED,AUTO
SeparatorPos         SIGNED,AUTO
StartURL             SIGNED,AUTO
StartArguments       UNSIGNED,AUTO
EndURL               UNSIGNED,AUTO
Tag                  CSTRING(40)
StartValue           SIGNED
IsFirstLine          BOOL(FALSE)

  CODE

  LineLen = LEN(Line)
  ! Format = GET URL?args <http> or
  !          POST url <http>
  IF ((LineLen > 4) AND (UPPER(Line[1:4]) = 'GET '))
    IsFirstLine = TRUE
    StartURL = 5
  ELSIF ((LineLen > 5) AND (UPPER(Line[1:5]) = 'POST '))
    IsFirstLine = TRUE
    StartURL = 6
    SELF.IsPost = TRUE
  END
  IF (IsFirstLine)
    EndURL = INSTRING(' ', Line, 1, StartURL)
    IF (EndURL)
      SELF.SetBrowserProperty('HttpProtocol', Line[(EndURL+1):(LineLen)])
    ELSE
      SELF.SetBrowserProperty('HttpProtocol', 'HTTP/1.0')
      EndURL = LineLen+1
    END
    StartArguments = INSTRING('?', Line, 1, StartURL)
    IF (StartArguments)
      ASSERT(NOT SELF.IsPost)
      SELF.SetArguments(Line[(StartArguments+1):(EndURL-1)])
    END
  ELSE
    SeparatorPos= INSTRING(':', Line, 1, 1)

    StartValue = SeparatorPos+1
    LOOP WHILE (Line[StartValue] = ' ') OR (Line[StartValue] = '<9>')
      StartValue += 1
    END

    Tag = UPPER(Line[1:(SeparatorPos-1)])

    IF ((LEN(Tag)>=5) AND (Tag[1:5] = 'HTTP_'))
      Tag = Tag[6:(LEN(Tag))]
    END

    IF (Tag = 'COOKIE')
      SELF.StoreCookies(Line[StartValue : LineLen])
    ELSE
      SELF.SetBrowserProperty(Tag, Line[StartValue : LineLen])
    END
  END


WbHttpClass.GetArguments      PROCEDURE()
  CODE
  IF (SELF.Arguments &= NULL)
    RETURN ''
  END
  RETURN SELF.Arguments


WbHttpClass.CreateArgumentIterator PROCEDURE
UrlIter                 &WbUrlEncodingIterator,AUTO
MultiIter               &WbMultiPartIterator,AUTO
S_ContentType            EQUATE('Content-Type')
S_MultiPart              EQUATE('multipart/form-data;')
S_boundary               EQUATE('boundary=')
ContentType              ANY
Start                    SIGNED,AUTO
  CODE
  ContentType = SELF.GetBrowserProperty(S_ContentType)
  IF (SUB(ContentType, 1, LEN(S_MultiPart)) = S_MultiPart)
    Start = INSTRING(S_boundary, ContentType, 1, 1)

    MultiIter &= NEW WbMultiPartIterator
    MultiIter.Init(SELF.Arguments, SUB(ContentType, Start+LEN(S_boundary), -1))
    RETURN MultiIter.IWbArgumentIterator
  END
  UrlIter &= NEW WbUrlEncodingIterator
  UrlIter.Init(SELF.Arguments)
  RETURN UrlIter.IWbArgumentIterator

WbHttpClass.SetArguments      PROCEDURE(STRING arguments)
  CODE
  DISPOSE(SELF.Arguments)
  SELF.Arguments &= NEW String(LEN(arguments))
  SELF.Arguments = arguments


WbHttpClass.ClearUp                PROCEDURE
  CODE
  IF (NOT SELF.HttpPage &= NULL)
    SELF.HttpPage.Kill()
    DISPOSE(SELF.HttpPage)
  END


WbHttpClass.PreparePage           PROCEDURE(*WbHttpPageBaseClass HttpPage, SIGNED Status, <STRING Filename>)
  CODE

  SELF.ClearUp()
  SELF.HttpPage &= HttpPage
  SELF.HttpPage.Init(SELF, status, Filename, Filename&'l')  !  SELF.Files.GetTempFilename(Filename))
  SELF.HttpPage.PreparePage()


WbHttpClass.PreparePageForBrowser    PROCEDURE(SIGNED status, <STRING Filename>)
HttpPage &WbHttpPageBaseClass

  CODE

  HttpPage &= NEW WbHttpPageBrowserClass
  SELF.PreparePage(HttpPage, status, Filename)


WbHttpClass.PreparePageForJava    PROCEDURE(SIGNED status, <STRING Filename>)
HttpPage &WbHttpPageBaseClass
  CODE

  HttpPage &= NEW WbHttpPageJavaClass
  SELF.PreparePage(HttpPage, status, Filename)


WbHttpClass.PrepareUnauthorized    PROCEDURE(<STRING Filename>)
  CODE

  SELF.PreparePageForBrowser(401, Filename)
  SELF.SetServerProperty('WWW-authenticate', 'basic realm="' & SELF.ProgName & ':' & SELF.ProcName & '"')


WbHttpClass.StoreCookies    PROCEDURE(STRING cookies)
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


WbHttpClass.StoreCookie    PROCEDURE(STRING cookie)
offset               SIGNED,AUTO

  CODE

  offset = INSTRING('=', cookie, 1, 1)
  IF (0 = offset)
    SELF.SetCookieModified(FALSE, cookie, '', 0, 0)
  ELSE
    SELF.SetCookieModified(FALSE, cookie[1:(offset-1)], IC:DecodeBase64(cookie[(offset+1):(LEN(cookie))]), 0, 0)
  END


WbHttpClass.SetCookie    PROCEDURE(STRING name, STRING Value, LONG ExpireDate=0, LONG ExpireTime=0, <STRING Path>)
CompoundName         CSTRING(255),AUTO

  CODE
  CompoundName = SELF.ProgName & '-' & Name

  IF (ExpireDate = 0)
    ExpireDate = TODAY()+28
    ExpireTime = CLOCK()
  END
  SELF.SetCookieModified(TRUE, CompoundName, Value, ExpireDate, ExpireTime, Path)


WbHttpClass.SetCookieModified    PROCEDURE(BYTE Modified, STRING Name, STRING Value, LONG ExpireDate=0, LONG ExpireTime=0, <STRING Path>)
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


WbHttpClass.GetCookie    PROCEDURE(STRING Name)
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


WbHttpClass.SendCookies    PROCEDURE
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


WbHttpClass.FinishPage    PROCEDURE
TargetFilename          CSTRING(File:MaxFilePath)
  CODE

  TargetFilename = SELF.HttpPage.FinishPage()
  SELF.ClearUp()
  RETURN TargetFilename


WbHttpClass.SetProgName          PROCEDURE(STRING ProgName)
  CODE
  SELF.ProgName = CLIP(ProgName)


WbHttpClass.SetProcName          PROCEDURE(STRING ProcName)
  CODE
  SELF.ProcName = CLIP(ProcName)


WbHttpClass.GetAuthorizedInfo    PROCEDURE(*STRING User, *STRING Pass)
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

!=========================================================================

WbArgumentIterator.Init                      PROCEDURE(* STRING Arguments)
  CODE
  SELF.Arguments &= Arguments
  SELF.Length = LEN(Arguments)
  SELF.CurIndex = SELF.Length+1

WbArgumentIterator.FirstArgument             PROCEDURE()
  CODE
  ASSERT(FALSE)
  RETURN FALSE

WbArgumentIterator.NextArgument              PROCEDURE()
  CODE
  ASSERT(FALSE)
  RETURN FALSE

WbArgumentIterator.GetName                  PROCEDURE
  CODE
  RETURN ''

WbArgumentIterator.GetValue                 PROCEDURE
  CODE
  RETURN ''

WbArgumentIterator.IWbArgumentIterator.Link              PROCEDURE
  CODE
  SELF.Link

WbArgumentIterator.IWbArgumentIterator.Release           PROCEDURE
  CODE
  SELF.Release

WbArgumentIterator.IWbArgumentIterator.First             PROCEDURE
  CODE
  RETURN SELF.FirstArgument()

WbArgumentIterator.IWbArgumentIterator.Next              PROCEDURE
  CODE
  RETURN SELF.NextArgument()

WbArgumentIterator.IWbArgumentIterator.IsValid           PROCEDURE
  CODE
  RETURN CHOOSE(SELF.CurIndex <= SELF.Length)

WbArgumentIterator.IWbArgumentIterator.GetCurrent        PROCEDURE
  CODE
  RETURN NULL

WbArgumentIterator.IWbArgumentIterator.GetName           PROCEDURE
  CODE
  RETURN SELF.GetName()

WbArgumentIterator.IWbArgumentIterator.GetValue          PROCEDURE
  CODE
  RETURN SELF.GetValue()

!=========================================================================

WbUrlEncodingIterator.FindNext                  PROCEDURE(SIGNED StartIndex)
  CODE
  SELF.CurIndex = StartIndex
  IF StartIndex > SELF.Length
    RETURN FALSE
  END
  SELF.EndIndex = FASTINSTRING(VAL('&'), SELF.Arguments, StartIndex)
  IF (SELF.EndIndex = 0)
    SELF.EndIndex = SELF.Length+1
  END

  SELF.AssignIndex = FASTINSTRING(VAL('='), SELF.Arguments, StartIndex)
  IF (SELF.AssignIndex > SELF.EndIndex)
    SELF.AssignIndex = 0
  END
  RETURN TRUE

WbUrlEncodingIterator.FirstArgument             PROCEDURE()
  CODE
  RETURN SELF.FindNext(1)

WbUrlEncodingIterator.Init                      PROCEDURE(* STRING Arguments)
  CODE
  PARENT.Init(Arguments)
  IF SELF.Length > 0 AND Arguments[SELF.Length]='<10>' THEN SELF.Length -= 1.
  IF SELF.Length > 0 AND Arguments[SELF.Length]='<13>' THEN SELF.Length -= 1.

WbUrlEncodingIterator.NextArgument              PROCEDURE
  CODE
  RETURN SELF.FindNext(SELF.EndIndex+1)


WbUrlEncodingIterator.GetName                  PROCEDURE
EndName                 SIGNED,AUTO
  CODE
  IF (SELF.AssignIndex = 0)
    EndName = SELF.EndIndex
  ELSE
    EndName = SELF.AssignIndex
  END
  RETURN IC:Html2Clarion(SUB(SELF.Arguments, SELF.CurIndex, EndName-SELF.CurIndex))

WbUrlEncodingIterator.GetValue                 PROCEDURE
  CODE
  IF (SELF.AssignIndex <> 0)
    RETURN IC:Html2Clarion(SUB(SELF.Arguments, SELF.AssignIndex+1, SELF.EndIndex-(SELF.AssignIndex+1)))
  END
  RETURN ''

!=========================================================================
!
! Format:
! ----------------------------abcdefghijk       [boundary]
! Content-Disposition: form-data; name="<NAME>"
! [extra lines....]
!
! <value>
!
!


WbMultiPartIterator.FindNext                  PROCEDURE(SIGNED StartIndex)
S_Header                EQUATE('Content-Disposition: form-data;')
S_NameEq                EQUATE('name=')
  CODE
  IF NOT SELF.ResetLine(StartIndex)
    RETURN FALSE
  END

  IF NOT INSTRING(SELF.boundary, SELF.Arguments[SELF.CurIndex : SELF.EndIndex], 1, 1)
    RETURN FALSE
  END
  IF NOT SELF.NextLine() THEN RETURN FALSE.

  ASSERT(SUB(SELF.Arguments, SELF.CurIndex, LEN(S_Header)) = S_Header)
  SELF.ExtractArgument(' name=', SELF.StartOfName, SELF.EndOfName)
  SELF.ExtractArgument(' filename=', SELF.StartOfFilename, SELF.EndOfFilename)

  ! Find the blank line and skip it...
  LOOP
    IF NOT SELF.NextLine() THEN RETURN FALSE.
  WHILE (SELF.CurIndex <> SELF.EndIndex)
  IF NOT SELF.NextLine() THEN RETURN FALSE.

  SELF.StartOfValue = SELF.CurIndex
  SELF.EndOfValue = SELF.CurIndex
  LOOP WHILE INSTRING(SELF.boundary, SELF.Arguments[SELF.CurIndex : SELF.EndIndex], 1, 1) = 0
    SELF.EndOfValue = SELF.EndIndex
    IF NOT SELF.NextLine() THEN RETURN FALSE.
  END
  RETURN TRUE


WbMultiPartIterator.ExtractArgument            PROCEDURE(STRING name, * SIGNED StartArg, * SIGNED EndArg)
NameIndex               SIGNED,AUTO
  CODE
  NameIndex = INSTRING(name, SELF.Arguments[SELF.CurIndex : SELF.EndIndex], 1, 1)
  IF (NameIndex)
    StartArg = SELF.CurIndex + (NameIndex - 1) + (LEN(name) + 1)
    EndArg = StartArg + INSTRING(SELF.Arguments[StartArg-1], SELF.Arguments[StartArg : SELF.EndIndex], 1, 1) - 1
  ELSE
    StartArg = 1
    EndArg = 1
  END

WbMultiPartIterator.FirstArgument             PROCEDURE()
  CODE
  RETURN SELF.FindNext(1)

WbMultiPartIterator.NextArgument              PROCEDURE
  CODE
  RETURN SELF.FindNext(SELF.CurIndex)


WbMultiPartIterator.GetName                  PROCEDURE
  CODE
  RETURN SELF.Arguments[SELF.StartOfName : SELF.EndOfName-1]

WbMultiPartIterator.GetValue                 PROCEDURE
  CODE
  RETURN SELF.Arguments[SELF.StartOfValue : SELF.EndOfValue-1]

WbMultiPartIterator.Init            PROCEDURE(* STRING Arguments, STRING boundary)
  CODE
  SELF.boundary = boundary
  PARENT.Init(Arguments)


WbMultiPartIterator.NextLine        PROCEDURE
  CODE
  RETURN SELF.ResetLine(SELF.EndIndex + SELF.EndLen)

WbMultiPartIterator.ResetLine       PROCEDURE(SIGNED startIndex)
EndOfLineAddress        SIGNED,AUTO
  CODE
  SELF.CurIndex = StartIndex
  IF StartIndex > SELF.Length
    RETURN false
  END

  !!Use memchr - otherwise the whole string will get cloned onto the string stack
  EndOfLineAddress = memchr(ADDRESS(SELF.Arguments) + (StartIndex-1), VAL('<10>'), SELF.Length-(StartIndex-1))
  IF EndOfLineAddress = 0
    SELF.EndIndex = SELF.Length+1
    SELF.EndLen = 0
  ELSE
    SELF.EndIndex = EndOfLineAddress - ADDRESS(SELF.Arguments) + 1
    IF (SELF.EndIndex > 1) AND (SELF.Arguments[SELF.EndIndex-1] = '<13>')
      SELF.EndIndex -= 1
      SELF.EndLen = 2
    ELSE
      SELF.EndLen = 1
    END
  END
  RETURN true

FASTINSTRING    PROCEDURE(BYTE search, * STRING text, SIGNED start)
MatchAddress            LONG,AUTO
  CODE
  MatchAddress = memchr(ADDRESS(text) + (start-1), search, LEN(text)-(start-1))
  IF (MatchAddress)
    RETURN MatchAddress - ADDRESS(text) + 1
  END
  RETURN 0


