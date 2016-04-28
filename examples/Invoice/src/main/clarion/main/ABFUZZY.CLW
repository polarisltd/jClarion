  MEMBER

  INCLUDE('ABFUZZY.INC'),ONCE


FuzzyObject &FuzzyClass,PRIVATE


  MAP
  END


FuzzyClass.Construct PROCEDURE
  CODE
    SELF.BaseValue[1][1]=100
    SELF.BaseValue[2][1]=65
    SELF.BaseValue[2][2]=35
    SELF.BaseValue[3][1]=50
    SELF.BaseValue[3][2]=30
    SELF.BaseValue[3][3]=20
    SELF.BaseValue[4][1]=40
    SELF.BaseValue[4][2]=30
    SELF.BaseValue[4][3]=20
    SELF.BaseValue[4][4]=10
    SELF.BaseValue[5][1]=34
    SELF.BaseValue[5][2]=27
    SELF.BaseValue[5][3]=20
    SELF.BaseValue[5][4]=13
    SELF.BaseValue[5][5]=6
    SELF.BaseValue[6][1]=29
    SELF.BaseValue[6][2]=24
    SELF.BaseValue[6][3]=19
    SELF.BaseValue[6][4]=14
    SELF.BaseValue[6][5]=9
    SELF.BaseValue[6][6]=5
    SELF.BaseValue[7][1]=25
    SELF.BaseValue[7][2]=21
    SELF.BaseValue[7][3]=17
    SELF.BaseValue[7][4]=14
    SELF.BaseValue[7][5]=11
    SELF.BaseValue[7][6]=8
    SELF.BaseValue[7][7]=4
    SELF.BaseValue[8][1]=20
    SELF.BaseValue[8][2]=18
    SELF.BaseValue[8][3]=15
    SELF.BaseValue[8][4]=14
    SELF.BaseValue[8][5]=11
    SELF.BaseValue[8][6]=10
    SELF.BaseValue[8][7]=7
    SELF.BaseValue[8][8]=5
    SELF.BaseValue[9][1]=20
    SELF.BaseValue[9][2]=17
    SELF.BaseValue[9][3]=15
    SELF.BaseValue[9][4]=13
    SELF.BaseValue[9][5]=11
    SELF.BaseValue[9][6]=9
    SELF.BaseValue[9][7]=7
    SELF.BaseValue[9][8]=5
    SELF.BaseValue[9][9]=3
    SELF.BaseValue[10][1]=19
    SELF.BaseValue[10][2]=17
    SELF.BaseValue[10][3]=15
    SELF.BaseValue[10][4]=13
    SELF.BaseValue[10][5]=11
    SELF.BaseValue[10][6]=9
    SELF.BaseValue[10][7]=7
    SELF.BaseValue[10][8]=5
    SELF.BaseValue[10][9]=3
    SELF.BaseValue[10][10]=1


FuzzyClass.Init PROCEDURE()
  CODE
  CLEAR(SELF.NoCase)
  CLEAR(SELF.WordOnly)
  FuzzyObject &= SELF


FuzzyClass.Kill PROCEDURE
  CODE


FuzzyClass.Match PROCEDURE(ASTRING Doc, ASTRING Query)
  CODE
    IF NOT Doc
      RETURN 0
    ELSIF NOT Query
     RETURN 100
    END
    DO ClearVar
    IF SELF.Query <> Query
      SELF.Query = Query
      SELF._SplitQuery(CHOOSE(SELF.NoCase,UPPER(Query),Query))
      CLEAR(SELF.ReturnIndexDone)
    END
    SELF._FindMatches(CHOOSE(SELF.NoCase,UPPER(Doc),Doc))
    RETURN SELF._Evaluate(Doc)

ClearVar ROUTINE
  CLEAR(SELF.ResultIndex)


FuzzyClass._Evaluate PROCEDURE(ASTRING Doc)
I BYTE,AUTO
ret BYTE
  CODE
    LOOP I=1 TO SELF.WordCnt
      ret+= SELF.BaseValue[SELF.WordCnt][I]*SELF._EvaluateWord(Doc, SELF.Words[I] ,I)*.01
    END
    RETURN ret


FuzzyClass._EvaluateWord PROCEDURE(ASTRING Doc, ASTRING Word, BYTE WhichWord)
Percentage BYTE,AUTO
Best BYTE
I USHORT,AUTO
  CODE
    LOOP I=1 TO MaxResults
      IF NOT SELF.ResultIndex[WhichWord][I] THEN BREAK END
      Percentage = SELF._ComputePercentage(Doc, SELF.ResultIndex[WhichWord][I],Word, WhichWord)
      IF Percentage > Best
        Best = Percentage
      END
    END
    RETURN Best


FuzzyClass._ComputePercentage PROCEDURE(ASTRING Doc, BYTE Pos, ASTRING Word, BYTE WhichWord)
res BYTE(100)
a STRING(1)
L BYTE,AUTO
  CODE
    L=LEN(Word)
    IF SELF.NoCase AND SUB(Doc,Pos,L) <>  SUB(SELF.Query,SELF.QWordPos[WhichWord],L)
      res -= 10
    END
    IF L <> LEN(Doc)
      a = SUB(Doc,Pos+L,1)
      res = CHOOSE(SELF._IsWordDelimiter(a)=TRUE,res,CHOOSE(a='-',res-2,res-5))
      IF Pos = 1
        RETURN res-10
      ELSE
        res -= 15
        a = SUB(Doc,Pos-1,1)
        res = CHOOSE(SELF._IsWordDelimiter(a,TRUE)=TRUE,res,CHOOSE(a='-',res-3,res-10))
      END
    END
    RETURN res


FuzzyClass._FindMatches PROCEDURE(ASTRING Doc)
I USHORT,AUTO
L USHORT,AUTO
J USHORT,AUTO
Idx USHORT(1),DIM(SELF.WordCnt)
Found USHORT(1),DIM(SELF.WordCnt)
Candidate USHORT,DIM(SELF.WordCnt)
  CODE
    L = LEN(Doc)
    LOOP I=1 TO L  !step through Doc
      LOOP J=1 TO SELF.WordCnt
        IF SELF.Words[J][Idx[J]] = SUB(Doc,I,1)
          IF Idx[J] = 1
            IF SELF.WordOnly AND I>1 AND NOT SELF._IsWordDelimiter(SUB(Doc,I-1,1),TRUE)
              CYCLE
            ELSE
              Candidate[J]=I
            END
          END
          IF Idx[J] = LEN(SELF.Words[J])
            IF NOT (SELF.WordOnly AND I<L AND NOT SELF._IsWordDelimiter(SUB(Doc,I+1,1)))
              SELF.ResultIndex[J][Found[J]]=Candidate[J]
              Found[J] += 1
            END
            Idx[J]=1
          ELSE
            Idx[J]+=1
          END
        ELSE
          IF Idx[J]>1
            LOOP
              Idx[J] = SELF._GetReturnIndex(J, Idx[J])
              IF SELF.Words[J][Idx[J]] = SUB(Doc,I,1)
                Candidate[J]=I-Idx[J]+1
                Idx[J]+=1
                BREAK
              END
            UNTIL Idx[J]=1
          END
        END
      END
    END


FuzzyClass._IsWordDelimiter PROCEDURE(STRING C, BYTE Leading)
  CODE
    IF Leading
      RETURN CHOOSE(C='' OR C='''' OR C='"')
    ELSE
      RETURN CHOOSE(C='' OR C='.' OR C=',' OR C='!' OR C='?' OR C='''' OR C='"')
    END


FuzzyClass._GetReturnIndex PROCEDURE(USHORT WhichWord, USHORT Idx)
  CODE
    IF NOT SELF.ReturnIndexDone[WhichWord]
      SELF._ComputeReturnIndex(WhichWord)
    END
    RETURN SELF.ReturnIndex[WhichWord][Idx]


FuzzyClass._ComputeReturnIndex PROCEDURE(USHORT WhichWord)
s CSTRING(MaxWordLen)
si BYTE(1),DIM(MaxWordLen)
i SIGNED
j SIGNED
  CODE
    s = SELF.Words[WhichWord]
    i=1
    j=0
    si[1]=0
    LOOP
      IF ~j OR s[i]=s[j]
        i+=1
        j+=1
        si[i]=j
      ELSE
        j=si[j]
      END
    UNTIL i>LEN(s)      
    LOOP i=1 TO LEN(s)
      SELF.ReturnIndex[WhichWord][i] = si[i]
    END
    SELF.ReturnIndexDone[WhichWord]=TRUE


FuzzyClass._SplitQuery PROCEDURE(ASTRING Query)
I USHORT(0)
J USHORT,AUTO
K BYTE(1)
L USHORT,AUTO
Blanks BYTE
  CODE

    CLEAR(SELF.Words)
    CLEAR(SELF.WordCnt)
    CLEAR(SELF.QWordPos)
    Query = LEFT(Query)
    L = LEN(Query)
    IF NOT L THEN RETURN END
    ASSERT(L <= MaxDocLen)
    LOOP J = 1 TO L
      IF SUB(Query,J,1) <> ''
        IF Blanks THEN
          Blanks = FALSE
          SELF.QWordPos[K]=J
        END
        I += 1
        SELF.Words[K][I]=SUB(Query,J,1)
      ELSE
        IF NOT Blanks
          Blanks = TRUE
          SELF.Words[K][I+1]='<0>'
          I = 0
          K += 1
        END
      END
    END
    SELF.Words[K][I+1]='<0>'
    SELF.WordCnt = K


FuzzyClass.SetOption PROCEDURE(BYTE WhichOption, BYTE Value)
  CODE
    CASE WhichOption
    OF MatchOption:NoCase
      IF SELF.NoCase <> CHOOSE(Value)
        SELF.NoCase = CHOOSE(Value)
        CLEAR(SELF.Query)  !force splitting of query if NoCase changes
      END
    OF MatchOption:WordOnly
      SELF.WordOnly = CHOOSE(Value)
    END



!This is the method called from the VIEWs ORDER clause

FuzzyMatch PROCEDURE(STRING Query, STRING Document)

  CODE
? ASSERT(~FuzzyObject &= NULL, 'FuzzyObject null; Init has probably not been called!')
  RETURN FuzzyObject.Match(Document, Query)

