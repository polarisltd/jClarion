! $Header: /0192-7/XMLSupport/src/XMLTreeJoin.clw 8     4/24/03 9:58p Valeri $
!****************************************************************************
!  FILE..........: XMLExchange.clw
!  AUTHOR........: 
!  DESCRIPTION...: Library for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-04-01 Created by Anatoly Medyntsev
!                  YYYY-MM-DD description of changes
!                   ..........
!****************************************************************************
   member

   include('XMLClass.inc'), once

!XMLHRElem  class
!sw     &StructWrapper
!nd     &Node  !if null then closed
!isClosed   procedure,byte
!isRowChanged   procedure,byte
!clearChangedFlg procedure      
!       end
!*****XMLHRElem implementation
XMLHRElem.construct procedure
    code
        SELF.sw&=null
    SELF.nd&=null
    SELF.hrNext&=null
    SELF.hrChild&=null
XMLHRElem.destruct  procedure
    code
    SELF.close
XMLHRElem.isOpened  procedure
    code
    if(SELF.nd&=null)
       return false
    end
    return true
XMLHRElem.close     procedure
    code
    if(not SELF.nd&=null)
       SELF.nd&=null ! no release here
    end
    
XMLHRElem.isRowChanged  procedure
    code
    if(SELF.sw&=null)
       return false
    end
    return SELF.sw.isRowPosChanged()
XMLHRElem.clearChangedFlg procedure 
    code
    if(SELF.sw&=null)
       return 
    end
    SELF.sw.updateRowPos()
!return node's name
XMLHRElem.getName   procedure
    code
    if(not SELF.isOpened())
       return null
    end
    return SELF.nd.getNodeName()

!XMLHRManager   class
!hrq        &hrQueue
!construct  procedure
!destruct   procedure
!init       procedure(StructWrapper sw),byte
!lowChangeIdx   procedure(),signed
!getElem    procedure(signed idx),*XMLHRElem
!elems      procedure,signed    

XMLHRManager.construct  procedure
    code
    !create queue
    SELF.hrq&=new(hrQueue)
XMLHRManager.destruct   procedure
    code
    if(SELF.hrq&=null)
       return
    end
    free(SELF.hrq)
    dispose(SELF.hrq)
    SELF.hrq&=null  
XMLHRManager.elems  procedure
    code
    if(SELF.hrq&=null)
       return -1
    end
    return records(SELF.hrq)
XMLHRManager.getElem    procedure(signed idx)
hre &XMLHRElem, auto
    code
    if(SELF.hrq&=null)
       return null
    end
    get(SELF.hrq,idx)
    if(errorcode() <> 0)
       return null
    end
    hre&=SELF.hrq.hrElem
    return hre 
!look for the first elem with changed row
XMLHRManager.lowChangeIdx procedure 
cou signed, auto
idx signed, auto
elem    &XMLHRElem, auto
    code
    cou=SELF.elems()
    loop idx=1 to cou
       elem&=SELF.getElem(idx)
       if(not elem&=null)
          if(elem.isRowChanged())
              return idx
          end           
       end      
    end
    return -1
!filling the underlaying structure with info from StructWrapper   
XMLHRManager.init   procedure(StructWrapper sw,*XMLHRElem prev)
elem    &XMLHRElem, auto
curPrev &XMLHRElem, auto
first   byte
curNode    &StructWrapper, auto
idx signed
    code
    if(SELF.hrq&=null)
       return false
    end
    elem&=new(XMLHRElem)
    elem.sw&=sw
    if(not prev&=null)
       prev.hrNext&=elem
    end
    SELF.hrq.hrElem&=elem
    add(SELF.hrq)
    idx=records(SELF.hrq)
    elem.idx=idx !set the current index in the hrq
    curNode&=sw.getFirstChild()
    curPrev&=null
    first=true
    loop while(not curNode&=null)
       curPrev&=SELF.init(curNode,curPrev)
       if(curPrev&=null)
          return null
       end
       if(first)
          first=false
          elem.hrChild&=curPrev
       end      
       curNode&=curNode.getNextSibling()
    end
    return elem
                        
!** (END OF FILE  : XMLTreeJoin.clw) *********************************************