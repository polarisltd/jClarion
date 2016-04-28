! $Header: /0192-7/XMLSupport/src/XMLNavigator.clw 4     8/05/03 12:50p Mal $
!****************************************************************************
!  FILE..........: XMLNavigator.clw
!  AUTHOR........: 
!  DESCRIPTION...: Library for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-04-18 Created by Anatoly Medyntsev
!                  YYYY-MM-DD description of changes
!                   ..........
!****************************************************************************
    member

    include('XMLClass.inc'), once

XMLNavigator.construct   procedure

    CODE
    SELF.xExch&=null
    SELF.currentNode&=null

XMLNavigator.init    procedure(*XMLExchange xExch)

    CODE
    SELF.xExch&=xExch
!Get the current node of the XMLExchange object and set the current node of 
!XMLNavigator to the retrieved value
XMLNavigator.getXMLExchangeNode     procedure
nd  &Element, auto  
    CODE
    if(SELF.xExch&=null)
       return
    end
    nd&=SELF.xExch.getNode()
    if(nd &= null)
       return
    end
    SELF.currentNode&=nd
!Set the current node of the XMLExchange object to the current node of 
!XMLNavigator 
XMLNavigator.setXMLExchangeNode     procedure 
    CODE
    if(SELF.xExch&=null)
       return
    end 
    if(SELF.currentNode &= null)
       return
    end
    SELF.xExch.setNode(SELF.currentNode)

!Move the inner current node pointer to the root node of the DOM Document
XMLNavigator.goToRoot   procedure!, byte 
doc &Document, auto
elem    &Element, auto

    CODE
    if(SELF.currentNode &=null)
       return CPXMLErr:NoCurrentNode
    end     
    doc&=SELF.currentNode.getOwnerDocument()
    if(doc&=null)
       return CPXMLErr:NotSuccessful
    end
    elem&=doc.getDocumentElement()
    if(elem&=null)
       return CPXMLErr:NotSuccessful
    end 
    SELF.currentNode&=elem
    return CPXMLErr:NoError

!Move the current node pointer to the parent node relatively to current node value
XMLNavigator.goToParent procedure!, byte 
nd  &Node, auto
tp  unsigned
    CODE
    if(SELF.currentNode &=null)
       return CPXMLErr:NoCurrentNode
    end
    nd&=SELF.currentNode.getParentNode()
    if(nd&=null)
       return CPXMLErr:NotSuccessful
    end
    tp=nd.getNodeType()
    if(tp <> Node:ELEMENT)
       return CPXMLErr:NotSuccessful
    end
    SELF.currentNode&=address(nd)
    return CPXMLErr:NoError
!Move the current node pointer to the first child node relatively to current node value
XMLNavigator.goToFirstChild     procedure!, byte 
nd  &Node, auto
tp  unsigned
    CODE
    if(SELF.currentNode &=null)
       return CPXMLErr:NoCurrentNode
    end 
    nd&=getFirstChildElem(SELF.currentNode)
    if(nd&=null)
       return CPXMLErr:NotSuccessful
    end
    tp=nd.getNodeType()
    if(tp <> Node:ELEMENT)
       return CPXMLErr:NotSuccessful
    end
    SELF.currentNode&=address(nd)
    return CPXMLErr:NoError

!Move the current node pointer to the next sibling node relatively to current node value    
XMLNavigator.goToNextSibling    procedure!, byte
nd  &Node, auto
tp  unsigned
    CODE
    if(SELF.currentNode &=null)
       return CPXMLErr:NoCurrentNode
    end
    nd&=getNextSiblingElem(SELF.currentNode)
    if(nd&=null)
       return CPXMLErr:NotSuccessful
    end
    tp=nd.getNodeType()
    if(tp <> Node:ELEMENT)
       return CPXMLErr:NotSuccessful
    end
    SELF.currentNode&=address(nd)
    return CPXMLErr:NoError

!Returns:  The current node name
XMLNavigator.getNodeName    procedure!, string
    CODE
    if(SELF.currentNode &=null)
       return ''
    end
    return SELF.currentNode.getNodeName()

!Fill the QUEUE structure with attributes information in the form of pairs 
!<attribute_name,attribute_value>
XMLNavigator.getNodeAttributes  procedure(AttrQueue aq)!, byte
Attrs   &NamedNodeMap, auto
Atr &Attr, auto
cou unsigned
idx unsigned    
    CODE
    if(SELF.currentNode &=null)
       return CPXMLErr:NoCurrentNode
    end
    Attrs&=SELF.currentNode.getAttributes()
    if(Attrs&=null)
       return CPXMLErr:NotSuccessful
    end
    free(aq)
    cou=Attrs.getLength()
    loop idx=0 to cou-1
       Atr&=address(Attrs.item(idx))
       if(not Atr&=null)
          aq.AttrName=Atr.getName()
          aq.AttrValue=Atr.getValue()
          add(aq)       
       end      
    end
    Attrs.release()
    return CPXMLErr:NoError 
!*************************EOF***************************************************
