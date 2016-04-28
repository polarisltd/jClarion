  member

  include('IbArray.inc'),once
  include('IbArray.int'),once

  map
    module('runtime')
malloc             procedure(signed),long,name('_malloc')
memwmove           procedure(long, long, signed),name('_memwmove')
free               procedure(long),name('_free')
    end
    module('ibcsort.cpp')
qsortvec           procedure(long base, unsigned number, ICInterfaceCompare Compare),name('_qsortvec@FPPviR8ICompare')
qsortvec           procedure(long base, unsigned number, IIInterfaceCompare Compare),name('_qsortvec@FPPviR8ICompare')
    end
  end


 OMIT('***',__32BIT__)
MaxListLen              EQUATE(16000)
G_Amounts               group
                          SIGNED(0)
                          SIGNED(8)
                          SIGNED(16)
                          SIGNED(32)
                          SIGNED(64)
                          SIGNED(128)
                          SIGNED(256)
                          SIGNED(1024)
                          SIGNED(2048)
                          SIGNED(4096)
                          SIGNED(8196)
                          SIGNED(MaxListLen)
                        end
Amounts                 signed,dim(12),over(G_Amounts)


 ***
 COMPILE('***',__32BIT__)
MaxListLen              EQUATE(100000000)
G_Amounts               group
                          SIGNED(0)
                          SIGNED(8)
                          SIGNED(16)
                          SIGNED(32)
                          SIGNED(64)
                          SIGNED(128)
                          SIGNED(256)
                          SIGNED(1024)
                          SIGNED(2048)
                          SIGNED(4096)
                          SIGNED(8196)
                          SIGNED(16000)
                          SIGNED(32000)
                          SIGNED(65000)
                          SIGNED(130000)
                          SIGNED(250000)
                          SIGNED(500000)
                          SIGNED(1000000)
                          SIGNED(2000000)
                          SIGNED(3000000)
                          SIGNED(4000000)
                          SIGNED(5000000)
                          SIGNED(6000000)
                          SIGNED(7000000)
                          SIGNED(8000000)
                          SIGNED(9000000)
                          SIGNED(10000000)
                          SIGNED(20000000)
                          SIGNED(30000000)
                          SIGNED(40000000)
                          SIGNED(50000000)
                          SIGNED(60000000)
                          SIGNED(70000000)
                          SIGNED(80000000)
                          SIGNED(90000000)
                          SIGNED(MaxListLen)
                        end
Amounts                 signed,dim(36),over(G_Amounts)

  ***


BaseArrayIterator     CLASS(CInterface),TYPE      !,ABSTRACT
Cur                     LONG,PROTECTED

First                   PROCEDURE,CBOOL,PROTECTED
Init                    PROCEDURE,PROTECTED
IsItem                  PROCEDURE(LONG Idx),CBOOL,VIRTUAL
IsValid                 PROCEDURE,CBOOL,PROTECTED
Next                    PROCEDURE,CBOOL,PROTECTED
                      END


ArrayIIterator        CLASS(BaseArrayIterator),IMPLEMENTS(IIterator),TYPE
Arr                     &ArrayI,PRIVATE

Init                    PROCEDURE(ArrayI A)
IsItem                  PROCEDURE(LONG Idx),CBOOL,DERIVED
                      END


ArrayCIterator        CLASS(BaseArrayIterator),IMPLEMENTS(CIterator),TYPE
Arr                     &Array,PRIVATE

Init                    PROCEDURE(Array A)
IsItem                  PROCEDURE(LONG Idx),CBOOL,DERIVED
                      END



BaseArray.Construct PROCEDURE

  CODE
  SELF._Init

BaseArray.Destruct PROCEDURE

  CODE
  SELF.Kill


BaseArray.Kill PROCEDURE

  CODE
  ASSERT(False, 'Abstract base class virtual method called!')


BaseArray._Init PROCEDURE

  CODE
  SELF.head = 0
  SELF.size = 0
  SELF.used = 0
  SELF.ReleaseComponents = True


BaseArray.DoClear PROCEDURE

  CODE
  FREE(SELF.head)
  SELF._init()


BaseArray.Ordinality PROCEDURE

  code
  RETURN SELF.used


BaseArray._Space PROCEDURE

temp  LONG,AUTO

  CODE
  SELF.used += 1
  IF ( SELF.used > amounts[SELF.size + 1] )
    temp = SELF.head
    IF ( SELF.used > MaxListLen )
      SELF.used = MaxListLen - 100;
    ELSE
      SELF.size += 1
      SELF.head = malloc(amounts[SELF.size + 1] * 4);
      memwmove(SELF.head, temp, ( SELF.used - 1 ) * 2);
      FREE(temp)
    END
  END


BaseArray.Is_Item PROCEDURE(UNSIGNED index)

  CODE
  RETURN CHOOSE(index < SELF.used)



BaseArray.CastItem PROCEDURE(SIGNED index)

cur LONG,AUTO

  CODE
  PEEK(SELF.head + index*4, cur)
  RETURN cur


BaseArray.Swap PROCEDURE(UNSIGNED pos1, UNSIGNED pos2)

e1  LONG,AUTO
e2  LONG,AUTO

  CODE
  PEEK(SELF.head + pos1 * 4, e1)
  PEEK(SELF.head + pos2 * 4, e2)
  POKE(SELF.head + pos1 * 4, e2)
  POKE(SELF.head + pos2 * 4, e1)


BaseArray.SetReleaseComponents PROCEDURE(BOOL b)

  CODE
  SELF.ReleaseComponents = b









Array._set              procedure(CInterface x, signed index)
cur                       long,auto
  code
  cur = address(x)
  poke(self.head + (index)*4, cur)


Array.Item PROCEDURE(SIGNED index)

cur LONG,AUTO

  CODE
  PEEK(SELF.head + index*4, cur)
  RETURN (cur)


Array.Kill              procedure
cur                       &CInterface,auto
count                     signed,auto
index                     signed(0)
  CODE
  count = self.used
  self.used = 0
  IF SELF.ReleaseComponents
    loop while (index < count)
      cur &= self.item(index)
      cur.Release()
      index += 1
    end
  END
  self.doclear()


Array.doappend            procedure(CInterface next)
  code
  self._space()
  self._set(next, self.used-1)


Array.doadd               procedure(CInterface next, unsigned pos)
valid_above             signed,auto
  code
  valid_above = self.used - pos;
  self._space();
  memwmove(self.head + (pos + 1)*4, self.head + pos*4, valid_above * 2 );
  self._set(next, pos)


Array.replace           procedure(CInterface next, unsigned index, byte nodestruct)
cur                       &CInterface,auto
  CODE
  if (NOT nodestruct)
    cur &= self.item(index)
    cur.Release()
  end
  self._set(next, index)


Array.remove            procedure(unsigned index, byte nodestruct)
cur                       &CInterface,auto
  code
  if (NOT nodestruct)
    cur &= self.item(index)
    cur.Release()
  end
  self.used -= 1
  memwmove( self.head + index*4, self.head + (index + 1)*4, ( self.used - index) * 2 );


Array.find              procedure(CInterface sought)
cur                     &CInterface,auto
index                   signed(0)
  code
  loop while (index < self.used)
    cur &= self.item(index)
    if (cur &= sought)
      return index
    end
  end
  return -1


Array.zap               procedure(CInterface sought, BYTE nodel)
cur                       &CInterface,auto
index                   signed(0)
  code
  loop while (index < self.used)
    cur &= self.item(index)
    if (cur &= sought)
      self.remove(index, nodel)
      return true
    end
    index += 1
  end
  return false


Array.zapall            procedure(CInterface sought, byte nodel)
cur                       &CInterface,auto
ret                     byte(false)
index                   signed,auto
  code
  index = self.used;
  loop while (index)
    index -= 1
    cur &= self.item(index)
    if (cur &= sought)
      self.remove(index, nodel)
      ret = true
      nodel = true      ! if find multiple, delete only once
    end
  end
  return ret


Array.GetIterator PROCEDURE           ! returns a new instance of an Iterator

Tmp &ArrayCIterator,AUTO

  CODE
  Tmp &= NEW ArrayCIterator
? ASSERT(~Tmp &= NULL)
  Tmp.Init(SELF)
  RETURN Tmp.CIterator


Array.DoSort PROCEDURE(ICInterfaceCompare Cmp)

  CODE
  qsortvec(self.head, self.ordinality(), Cmp)















ArrayI.GetIterator PROCEDURE           ! returns a new instance of an Iterator

Tmp &ArrayIIterator,AUTO

  CODE
  Tmp &= NEW ArrayIIterator
? ASSERT(~Tmp &= NULL)
  Tmp.Init(SELF)
  RETURN Tmp.IIterator


ArrayI.Kill PROCEDURE

cur   &IInterface,AUTO
count SIGNED,AUTO
index SIGNED(0)

  CODE
  count = SELF.used
  SELF.used = 0
  IF SELF.ReleaseComponents
    LOOP WHILE (index < count)
      cur &= SELF.item(index)
      cur.Release
      index += 1
    END
  END
  SELF.DoClear


ArrayI._Set PROCEDURE(IInterface x, SIGNED index)

cur LONG,AUTO

  CODE
  cur = ADDRESS(x)
  POKE(SELF.head + (index)*4, cur)


ArrayI.DoAppend PROCEDURE(IInterface next)

  CODE
  SELF._space
  SELF._set(next, SELF.used - 1)


ArrayI.DoAdd PROCEDURE(IInterface next, UNSIGNED pos)

valid_above SIGNED,AUTO

  CODE
  valid_above = SELF.used - pos;
  SELF._space
  memwmove(SELF.head + (pos + 1) * 4, SELF.head + pos * 4, valid_above * 2 );
  SELF._set(next, pos)


ArrayI.Replace PROCEDURE(IInterface next, UNSIGNED index, BYTE nodestruct)

cur &IInterface,AUTO

  CODE
  IF (NOT nodestruct)
    cur &= SELF.item(index)
    cur.Release
  END
  SELF._set(next, index)


ArrayI.Item PROCEDURE(SIGNED index)

cur LONG,AUTO

  CODE
  PEEK(SELF.head + index*4, cur)
  RETURN (cur)


ArrayI.Remove PROCEDURE(UNSIGNED index, BYTE nodestruct)

cur &IInterface,AUTO

  CODE
  IF (NOT nodestruct)
    cur &= SELF.item(index)
    cur.Release
  END
  SELF.used -= 1
  memwmove( SELF.head + index * 4, SELF.head + (index + 1)*4, ( SELF.used - index) * 2 )


ArrayI.Find PROCEDURE(IInterface sought)

cur   &IInterface,AUTO
index SIGNED(0)

  CODE
  LOOP WHILE (index < SELF.used)
    cur &= SELF.Item(index)
    IF (cur &= sought)
      RETURN index
    END
  END
  RETURN -1


ArrayI.zap PROCEDURE(IInterface sought, BYTE nodel)

cur   &IInterface,AUTO
index SIGNED(0)

  CODE
  LOOP WHILE (index < SELF.used)
    cur &= SELF.Item(index)
    IF (cur &= sought)
      SELF.Remove(index, nodel)
      RETURN True
    END
    index += 1
  END
  RETURN False



ArrayI.ZapAll PROCEDURE(IInterface sought, byte nodel)

cur   &IInterface,AUTO
ret   BYTE(False)
index SIGNED,AUTO

  CODE
  index = self.used;
  LOOP WHILE (index)
    index -= 1
    cur &= SELF.item(index)
    IF (cur &= sought)
      SELF.Remove(index, nodel)
      ret = true
      nodel = true      ! if find multiple, delete only once
    END
  END
  RETURN ret


ArrayI.DoSort PROCEDURE(IIInterfaceCompare Cmp)

  CODE
  qsortvec(self.head, self.ordinality(), Cmp)







BaseArrayIterator.Init PROCEDURE

  CODE
  SELF.Cur = -1

BaseArrayIterator.IsValid PROCEDURE

  CODE
  RETURN CHOOSE(SELF.Cur >= 0)


BaseArrayIterator.IsItem PROCEDURE(LONG Idx)

  CODE
  ASSERT(False, 'Method of abstract class called!')
  RETURN False


BaseArrayIterator.First PROCEDURE

  CODE
  SELF.Cur = CHOOSE(SELF.IsItem(0) = True, 0, -1)             ! a zero based index....
  RETURN SELF.IsValid()


BaseArrayIterator.Next PROCEDURE

  CODE
  IF SELF.IsItem(SELF.Cur + 1)
    SELF.Cur += 1
  ELSE
    SELF.Cur = -1
  END
  RETURN SELF.IsValid()




ArrayCIterator.Init PROCEDURE(Array A)

  CODE
  SELF.Init
  SELF.Arr &= A


ArrayCIterator.IsItem PROCEDURE(LONG Idx)

  CODE
  RETURN SELF.Arr.IS_Item(Idx)


ArrayCIterator.CIterator.Release PROCEDURE

  CODE
  SELF.Release


ArrayCIterator.CIterator.Link PROCEDURE

  CODE
  SELF.Link


ArrayCIterator.CIterator.First PROCEDURE

  CODE
  RETURN SELF.First()


ArrayCIterator.CIterator.Next PROCEDURE

  CODE
  RETURN SELF.Next()


ArrayCIterator.CIterator.IsValid PROCEDURE

  CODE
  RETURN SELF.IsValid()


ArrayCIterator.CIterator.GetCurrent PROCEDURE

RVal   &CInterface,AUTO

  CODE
  RVal &= NULL

  IF SELF.IsValid()
    RVal &= SELF.Arr.CastItem(SELF.Cur)
  END
  RETURN RVal





ArrayIIterator.Init PROCEDURE(ArrayI A)

  CODE
  SELF.Init
  SELF.Arr &= A


ArrayIIterator.IsItem PROCEDURE(LONG Idx)

  CODE
  RETURN SELF.Arr.Is_Item(Idx)


ArrayIIterator.IIterator.Release PROCEDURE

  CODE
  SELF.Release                        ! Kill me...


ArrayIIterator.IIterator.Link PROCEDURE

  CODE
  SELF.Link                           ! Increments usage count


ArrayIIterator.IIterator.First PROCEDURE

  CODE
  RETURN SELF.First()


ArrayIIterator.IIterator.Next PROCEDURE

  CODE
  RETURN SELF.Next()


ArrayIIterator.IIterator.IsValid PROCEDURE

  CODE
  RETURN SELF.IsValid()


ArrayIIterator.IIterator.GetCurrent PROCEDURE

RVal   &IInterface,AUTO

  CODE
  RVal &= NULL

  IF SELF.IsValid()
    RVal &= SELF.Arr.CastItem(SELF.Cur)
  END
  RETURN RVal




