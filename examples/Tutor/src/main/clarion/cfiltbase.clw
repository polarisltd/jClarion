    member()
    map
      module('')
StrTok      PROCEDURE(long, long), CSTRING, raw, name('_strtok')
      END
    END


    include('cFiltbase.inc'),once
    include('keycodes.clw'),once


cFilterBase.Construct               PROCEDURE

    CODE
    SELF.FilterQ &= new(TFilterQ)
    ASSERT(~(SELF.FilterQ &= NULL))

    SELF.ColFilterQ &= new(TColFilterQ)
    ASSERT(~(SELF.ColFilterQ &= NULL))



cFilterBase.Destruct                PROCEDURE

ndx     long

    CODE

    ASSERT(~(SELF.FilterQ &= NULL))
    LOOP
      ndx = RECORDS(SELF.FilterQ)
      IF ndx
        GET(SELF.FilterQ, ndx)
        DELETE(SELF.FilterQ)
      ELSE
        BREAK
      END
    END
    FREE(SELF.FilterQ)
    DISPOSE(SELF.FilterQ)

    ASSERT(~(SELF.ColFilterQ &= NULL))
    LOOP
      ndx = RECORDS(SELF.ColFilterQ)
      IF ndx
        GET(SELF.ColFilterQ, ndx)
        if ~(self.ColFilterQ.ColName_SQL &= null)
          dispose(self.ColFilterQ.ColName_SQL)
        end
        DELETE(SELF.ColFilterQ)
      ELSE
        BREAK
      END
    END
    FREE(SELF.ColFilterQ)
    DISPOSE(SELF.ColFilterQ)



cFilterBase.GenerateSet             PROCEDURE(STRING pValues, long pDataType, <string pPicture>)

ReturnStr       STRING(1024)
DelimiterStr    CSTRING(10)
szValues        CSTRING(1024)

szToken         CSTRING(128)
TokenQ          QUEUE
Token             STRING(25)
                END

QuoteStr        STRING(1)

ndx             long

szPicture       cstring(25)

    CODE

    if not(omitted(4))
      szPicture = pPicture
    else
      szPicture = '@d10'
    end
    szValues = pValues
    ReturnStr = ''
    DelimiterStr = '(),'' '
    if self.UseSQL and (pDatatype = datatype:date or pDatatype = datatype:time)
      DelimiterStr = '(),'''
    end
    ! Extract the different token contained in pValues which can be passed as A B C or (A, B, C) or ('A', 'B', 'C'), who knows!
    szToken = StrTok(address(szValues), address(DelimiterStr))
    LOOP while szToken <> ''
      TokenQ.Token = szToken
      add(TokenQ)
      szToken = StrTok(0, address(DelimiterStr))
    END

    ! If data type OF the set is STRING or date, QuoteStr should be a '
    CASE pDataType
    OF dataType:String
    OROF DataType:Date
    orof datatype:time
      QuoteStr = ''''
    ELSE
      QuoteStr = ''
    END

    ! Build the set
    ndx = 1
    LOOP ndx = 1 to RECORDS(TokenQ)
      GET(TokenQ, ndx)
      if self.UseSQL
        if pdataType = datatype:Date
          ReturnStr = CLIP(ReturnStr) & CLIP(QuoteStr) & format(deformat(CLIP(TokenQ.Token), SELF.ColFilterQ.ColPicture), szPicture) & CLIP(QuoteStr) & ','
        elsif pdatatype = datatype:time
          ReturnStr = CLIP(ReturnStr) & CLIP(QuoteStr) & CLIP(format(deformat(CLIP(TokenQ.Token), SELF.ColFilterQ.ColPicture), @t04)) & CLIP(QuoteStr) & ','
        else
          ReturnStr = CLIP(ReturnStr) & CLIP(QuoteStr) & CLIP(TokenQ.Token) & CLIP(QuoteStr) & ','
        end
      else
        ReturnStr = CLIP(ReturnStr) & CLIP(QuoteStr) & CLIP(TokenQ.Token) & CLIP(QuoteStr) & ','
      end
    END
    ReturnStr[len(CLIP(ReturnStr))] = '' ! Replace last comma with a blank

    FREE(TokenQ)

    RETURN(CLIP(ReturnStr))


cFilterBase.GenerateFilter            procedure()

RetValue        byte
ndx             long
TmpStr          cstring(1024)
StrPos          long

    code

    RetValue = 1

    IF ~RECORDS(SELF.FilterQ)
      SELF.SQLFilterStr = ''
      RetValue = 0
    ELSE
      GET(SELF.FilterQ, records(SELF.FilterQ))
      IF ~ERRORCODE()
        IF NOT INSTRING('DONE', UPPER(SELF.FilterQ.Connection), 1, 1)
          SELF.SQLFilterStr = ''
          RetValue = 0
        ELSE
          ndx = 1
          SELF.SQLFilterStr = '('
          LOOP
            GET(SELF.FilterQ, ndx)
            IF ~ERRORCODE()

              self.ColOpeQRef.OperatorUser = self.FilterQ.Operator
              get(self.ColOpeQRef, self.ColOpeQRef.OperatorUser)
              if ~errorcode()
                SELF.ColFilterQ.ColName = SELF.FilterQ.Column
                GET(SELF.ColFilterQ, SELF.ColFilterQ.ColName)
                IF ~ERRORCODE()
                  self.SQLFilterStr = clip(self.SQLFilterStr) & ' ' &  self.ParseAndReplace()
                end
              end
              IF SELF.FilterQ.Connection = '...) DONE'
                SELF.SQLFilterStr = CLIP(SELF.SQLFilterStr) & ' ' & ')'
              ELSE
                IF SELF.FilterQ.Connection <> 'DONE'
                  StrPos = instring('...', SELF.FilterQ.Connection, 1, 1)
                  IF ~StrPos
                    SELF.SQLFilterStr = CLIP(SELF.SQLFilterStr) & ' ' & CLIP(SELF.FilterQ.Connection)
                  ELSE
                    IF StrPos = 1
                      SELF.SQLFilterStr = CLIP(SELF.SQLFilterStr) & ' ' & SELF.FilterQ.Connection[4 : len(CLIP(SELF.FilterQ.Connection))]
                    ELSE
                      SELF.SQLFilterStr = CLIP(SELF.SQLFilterStr) & ' ' & SELF.FilterQ.Connection[1 : StrPos - 1]
                    END
                  END
                END
              END
              ndx += 1
            else
              break
            end
          end
        end

        SELF.SQLFilterStr = CLIP(SELF.SQLFilterStr) & ')'

        IF SELF.CopyToCB = true
          setclipboard(SELF.SQLFilterStr)
        END

      end
    end

    return(RetValue)

cFilterBase.ParseAndReplace         procedure

StrPos          long
EndPos          long
StartTokenPos   long
EndTokenPos     long
TmpStr          cstring(1024)
ndx             long
NbrOfStep       long

PictQ       queue
PictureTok    string(10)
VALPos        long
Token         string(8)
            end

szPicture   cstring(25)
VTmp        string(50)

    code
    free(PictQ)
    ! First check if there is an exeception handling defined for the datatype of that column
    self.ColOpeExQRef.OperatorUser = self.FilterQ.Operator
    self.ColOpeExQRef.ColDatatype = SELF.ColFilterQ.ColDataType
    get(self.ColOpeExQRef, self.ColOpeExQRef.OperatorUser, self.ColOpeExQRef.ColDatatype)
    if ~errorcode()
      TmpStr = self.ColOpeExQRef.Operator
    else
      TmpStr = self.ColOpeQRef.Operator
    end



    ! Find [COL] Keyword and replace by actual ColName
    loop
      StrPos = instring('[COL]', upper(TmpStr), 1, 1)
      if StrPos
        if ~self.UseSQL and ~SELF.ColFilterQ.CaseSensitive
          case SELF.ColFilterQ.ColDataType
          of datatype:string
            TmpStr = TmpStr[1 : StrPos - 1] & 'upper(' & clip(SELF.ColFilterQ.ColName_SQL) & ') ' & TmpStr[ StrPos + 5 : len(clip(TmpStr))]
          else
            TmpStr = TmpStr[1 : StrPos - 1] & clip(SELF.ColFilterQ.ColName_SQL) & TmpStr[ StrPos + 5 : len(clip(TmpStr))]
          end
        else
          TmpStr = TmpStr[1 : StrPos - 1] & clip(SELF.ColFilterQ.ColName_SQL) & TmpStr[ StrPos + 5 : len(clip(TmpStr))]
        end
      else
        break
      end
    end

    ! Find for [MV]
    loop
      StrPos = instring('[MV]', upper(TmpStr), 1, 1)
      if StrPos
        TmpStr = TmpStr[1 : StrPos - 1] & choose(SELF.ColFilterQ.CaseSensitive = 1, SELF.GenerateSet(SELF.FilterQ.Value, SELF.ColFilterQ.ColDataType), upper(SELF.GenerateSet(SELF.FilterQ.Value, SELF.ColFilterQ.ColDataType))) &|
                 TmpStr[StrPos + 4 : len(clip(TmpStr))]
      else
        break
      end
    end

    loop
      ! Process a multivalue entry with picture
      StrPos = instring('[MV,', upper(TmpStr), 1, 1)
      if StrPos
        Endpos = instring(']', upper(TmpStr), 1, StrPos + 1)
        szPicture = clip(left(Tmpstr[StrPos + 4 : EndPos - 1]))
        TmpStr = TmpStr[1 : StrPos - 1] & choose(SELF.ColFilterQ.CaseSensitive = 1, SELF.GenerateSet(SELF.FilterQ.Value, SELF.ColFilterQ.ColDataType, szPicture), upper(SELF.GenerateSet(SELF.FilterQ.Value, SELF.ColFilterQ.ColDataType, szPicture))) &|
                 TmpStr[EndPos + 1 : len(clip(TmpStr))]
      else
        break
      end
    end


    ! First loop to the operator format in order to find if a special picture needs to be applied on VAL, V1 or V2
    loop
      StrPos = instring('[PIC', upper(TmpStr), 1, 1)
      if StrPos  ! There is a picture, find the corresponding ']'
        EndPos = instring(']', TmpStr,  1, StrPos + 1)
        if EndPos
          ! Now we need to find the first '[' brcket following the EndPos value, this will be token to which the picture needs to be applied
          StartTokenPos = instring('[', TmpStr, 1, EndPos + 1)
          if StartTokenPos
            EndTokenPos = instring(']', TmpStr, 1, StartTokenPos + 1)
            if EndTokenPos
              PictQ.ValPos = StrPos
              PictQ.PictureTok = left(clip( tmpStr[ StrPos + 5 : EndPos - 1]))
              PictQ.Token = left(clip(TmpStr[StartTokenPos :  EndTokenPos]))
              add(PictQ, PictQ.ValPos)
              TmpStr = TmpStr[1 : StrPos - 1] & TmpStr[EndPos + 1 : len(clip(TmpStr))]
            end
          end
        end
      else
        break
      end
    end


    ! Process the queue with Picture and Token
    loop ndx = records(PictQ) to 1 by -1
      get(PictQ, ndx)
      if ~errorcode()
        case PictQ.Token
        of '[V1]'
        orof '[V2]'
          StrPos = instring('DATETIME', SELF.ColFilterQ.ColPicture, 1, 1)
          if StrPos
            szPicture = clip(SELF.ColFilterQ.ColPicture[1 : StrPos - 2])
          else
            szPicture = clip(SELF.ColFilterQ.ColPicture)
          end
          StrPos = instring(',', SELF.FilterQ.Value, 1, 1)
          if upper(PictQ.Token) = '[V1]'
            TmpStr = TmpStr[1 : PictQ.VALPos - 1] & format(deformat(self.FilterQ.Value[1 : StrPos - 1], szPicture), PictQ.PictureTok) & tmpStr[PictQ.VALPos + len(clip(PictQ.Token)) : len(clip(TmpStr))]
          else
            TmpStr = TmpStr[1 : PictQ.VALPos - 1] & format(deformat(left(self.FilterQ.Value[StrPos + 1 : len(clip(self.FilterQ.Value))]), szPicture), PictQ.PictureTok) & tmpStr[PictQ.VALPos + len(clip(PictQ.Token)) : len(clip(TmpStr))]
          end
        of '[VAL]'
          StrPos = instring('DATETIME', SELF.ColFilterQ.ColPicture, 1, 1)
          if StrPos
            szPicture = clip(SELF.ColFilterQ.ColPicture[1 : StrPos - 2])
          else
            szPicture = clip(SELF.ColFilterQ.ColPicture)
          end
          TmpStr = TmpStr[1 : PictQ.VALPos - 1] & format(deformat(SELF.FilterQ.Value, szPicture), PictQ.PictureTok) & tmpStr[PictQ.VALPos + 5 : len(clip(TmpStr))]
        end
      end
    end

    ! Find for [V1] and [V2] keyword
    loop
      StrPos = instring('[V1]', upper(TmpStr), 1, 1)
      if StrPos
        ndx = instring(',', SELF.FilterQ.Value, 1, 1)
        if ~ndx
          ndx = instring(' AND ', upper(SELF.FilterQ.Value), 1, 1)
          !NbrOfStep = 5
        else
          !NbrOfStep = 1
        end
        if ndx
          case SELF.ColFilterQ.ColDataType
          of datatype:string
          orof datatype:date
          orof datatype:time
            VTmp = left(self.FilterQ.Value[1 : ndx - 1])
            ! Now check if the value already has the needed quotes
            VTmp = clip(VTmp)
            if VTmp[1] = '''' and VTmp[len(clip(VTmp))] = ''''  ! Value has the quote, use as is.
              TmpStr = TmpStr[1 : StrPos - 1] & left(clip(self.FilterQ.Value[1 : ndx - 1])) & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
            else
              TmpStr = TmpStr[1 : StrPos - 1] & '''' & quote(clip(left(self.FilterQ.Value[1 : ndx - 1])),1) & '''' & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
            end
          else
            TmpStr = TmpStr[1 : StrPos - 1] & clip(left(self.FilterQ.Value[1 : ndx - 1])) & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
          end
        else
          TmpStr = ''
        end
      else
        ! Process [V2] keyword
        loop
          StrPos = instring('[V2]', upper(TmpStr), 1, 1)
          if StrPos
            ndx = instring(',', SELF.FilterQ.Value, 1, 1)
            if ~ndx
              ndx = instring(' AND ', upper(SELF.FilterQ.Value), 1, 1)
              NbrOfStep = 5
            else
              NbrOfStep = 1
            end
            if ndx
              case SELF.ColFilterQ.ColDataType
              of datatype:string
              orof datatype:date
              orof datatype:time
                VTmp = clip(left(self.FilterQ.Value[ndx + 1 : len(clip(self.FilterQ.Value))]))
                VTmp = clip(VTmp)
                if VTmp[1] = '''' and VTmp[len(clip(VTmp))] = ''''  ! Value has the quote, use as is.
                  !TmpStr = TmpStr[1 : StrPos - 1] & clip(left(self.FilterQ.Value[ndx + 1 : len(clip(self.FilterQ.Value))])) & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
                  TmpStr = TmpStr[1 : StrPos - 1] & clip(left(self.FilterQ.Value[ndx + NbrOfStep : len(clip(self.FilterQ.Value))])) & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
                else
                  !TmpStr = TmpStr[1 : StrPos - 1] & '''' & quote(clip(left(self.FilterQ.Value[ndx + 1 : len(clip(self.FilterQ.Value))])), 1) & '''' & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
                  TmpStr = TmpStr[1 : StrPos - 1] & '''' & quote(clip(left(self.FilterQ.Value[ndx + NbrOfStep : len(clip(self.FilterQ.Value))])), 1) & '''' & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
                end
              else
                !TmpStr = TmpStr[1 : StrPos - 1] & clip(left(self.FilterQ.Value[ndx + 1 : len(clip(self.FilterQ.Value))])) & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
                TmpStr = TmpStr[1 : StrPos - 1] & clip(left(self.FilterQ.Value[ndx + NbrOfStep : len(clip(self.FilterQ.Value))])) & TmpStr[ StrPos + 4 : len(clip(TmpStr))]
              end
            else
              TmpStr = ''
              break
            end
          else
            break
          end
        end
        break
      end
    end

    ! Find for [VAL] Keyword
    loop
      StrPos = instring('[VAL]', upper(TmpStr), 1, 1)
      if StrPos
        case SELF.ColFilterQ.ColDataType
        of datatype:string
          if not instring(' LIKE ', upper(TmpStr), 1, 1)  and not instring('MATCH(', upper(TmpStr), 1, 1) ! already quoted
            if ~SELF.ColFilterQ.CaseSensitive
              TmpStr = TmpStr[1 : StrPos - 1] & '''' & upper(clip(quote(SELF.FilterQ.Value, 1))) & '''' & tmpStr[StrPos + 5 : len(clip(TmpStr))]
            else
              TmpStr = TmpStr[1 : StrPos - 1] & '''' & clip(quote(SELF.FilterQ.Value, 1)) & '''' & tmpStr[StrPos + 5 : len(clip(TmpStr))]
            end
          else
            if ~SELF.ColFilterQ.CaseSensitive
              TmpStr = TmpStr[1 : StrPos - 1] & upper(clip(SELF.FilterQ.Value)) & tmpStr[StrPos + 5 : len(clip(TmpStr))]
            else
              TmpStr = TmpStr[1 : StrPos - 1] & clip(SELF.FilterQ.Value) & tmpStr[StrPos + 5 : len(clip(TmpStr))]
            end
          end
        else
          TmpStr = TmpStr[1 : StrPos - 1] & clip(SELF.FilterQ.Value) & tmpStr[StrPos + 5 : len(clip(TmpStr))]
        end
      else
        break
      end
    end

    ! Find for [APP_PIC] keyword
    loop
      StrPos = instring('[APP_PIC]', upper(TmpStr), 1, 1)
      if StrPos
        TmpStr = TmpStr[1 : StrPos - 1] & clip(SELF.ColFilterQ.ColPicture) & tmpStr[StrPos + 9 : len(clip(TmpStr))]
      else
        break
      end
    end

    return(TmpStr)


cFilterBase.Reset                   PROCEDURE

ndx     long

    CODE

    FREE(SELF.FilterQ)
    CLEAR(SELF.FilterQ)
    SELF.Saved = false
    SELF.IsNew = true


cFilterBase.Save                    PROCEDURE(STRING pQueryName)


    CODE


cFilterBase.SaveAS                  PROCEDURE(STRING pQueryName)

    CODE

cFilterBase.SetCaseSensitive        PROCEDURE(BYTE pCase)

ndx     long

    CODE
    loop ndx = 1 to records(self.ColFilterQ)
      get(self.ColFilterQ, ndx)
      if ~errorcode()
        self.ColFilterQ.CaseSensitive = pCase
        put(self.ColFilterQ)
      end
    end

cFilterBase.Load                    PROCEDURE()

    CODE
    RETURN(0)

