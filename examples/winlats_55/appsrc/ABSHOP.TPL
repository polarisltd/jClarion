#TEMPLATE(ShoppingTrolley,'ABC Shopping Trolley Extensions'),FAMILY('ABC')
#HELP('Shopping.HLP')
#!
#!
#EXTENSION(ShoppingTrolley, 'Shopping Trolley Application Extension'),APPLICATION,SINGLE,HLP('~ShoppingTrolleyExtension')
#!
#PREPARE
  #CALL(%ReadABCFiles(ABC))
#ENDPREPARE
#!
#SHEET, HSCROLL
  #TAB('C&lasses'),HLP('~ShoppingTrolleyExtension_Classes')
    #PROMPT('&Statistics Tracker:', FROM(%pClassName)),%StatsTrackerClass,DEFAULT('StatsTracker'),REQ
    #PROMPT('&Invoice Copier:', FROM(%pClassName)),%InvoiceCopierClass,DEFAULT('InvoiceGeneratorClass'),REQ
    #BOXED('Modifiers')
      #PROMPT('Sales &Tax:', FROM(%pClassName)),%SalesTaxModifierClass,DEFAULT('SalesTaxClass'),REQ
      #PROMPT('&Quantity Discount:', FROM(%pClassName)),%QuantityDiscountModifierClass,DEFAULT('QuantityDiscountClass'),REQ
      #PROMPT('S&hipping On Invoice Line:', FROM(%pClassName)),%ShippingOnInvoiceLineModifierClass,DEFAULT('ShippingOnInvoiceLine'),REQ
      #PROMPT('Shi&pping On Invoice:', FROM(%pClassName)),%ShippingOnInvoiceModifierClass,DEFAULT('ShippingOnInvoice'),REQ
      #PROMPT('&Category Discount:', FROM(%pClassName)),%CategoryDiscountModifierClass,DEFAULT('CategoryDiscountClass'),REQ
      #PROMPT('&Gift Wrap:', FROM(%pClassName)),%GiftWrapModifierClass,DEFAULT('OptionsClass'),REQ
    #ENDBOXED
    #PROMPT('&Reservation System:', FROM(%pClassName)),%ReservationClass,DEFAULT('ReservationClass')
    #BUTTON('Shopping Library Files'),AT(,,170)
      #BOXED('Shopping Library Files')
        #INSERT(%AbcLibraryPrompts(ABC))
      #ENDBOXED
    #ENDBUTTON
  #ENDTAB
#ENDSHEET
#!
#ATSTART
  #CALL(%ReadABCFiles(ABC))
#ENDAT
#!
#!
#AT (%BeforeGenerateApplication)
  #CALL(%AddCategory(ABC), 'SHOP')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'SHOP','Shop','SHP')
#ENDAT
#!
#!
#!
#!
#EXTENSION(AddRecord,'Add Record to a File'),PROCEDURE,MULTI,DESCRIPTION('Add record to '& %Primary),HLP('~ShoppingAddRecord'),PRIMARY('TargetFile',NOKEY),REQ(ShoppingTrolley(ShoppingTrolley))
#!
#PROMPT('&When:',DROP('Procedure Start|Control Accepted')),%WhenAdd,DEFAULT('Procedure Start')
#ENABLE(%WhenAdd='Control Accepted')
  #PROMPT('&Control:',CONTROL),%AddControl
#ENDENABLE
#BUTTON('&Prime Fields'),MULTI(%AddFields,%AddFieldTarget & ' = ' & %AddFieldExpression)
  #PROMPT('Target Field',FIELD(%Primary)),%AddFieldTarget,REQ
  #PROMPT('Source Expression',EXPR),%AddFieldExpression,REQ
#ENDBUTTON
#PROMPT('&Enforce Parent:',FILE),%AddParent
#AT(%LocalDataAfterClasses),WHERE(%AddParent)
AddedYet%ActiveTemplateInstance  BYTE,STATIC
#ENDAT
#!
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(6000),DESCRIPTION('Insert record into %Primary'),WHERE(%WhenAdd='Procedure Start')
#INSERT(%AddRecordCode)
#ENDAT
#!
#!
#AT(%ControlEventHandling,%AddControl,'Accepted'),PRIORITY(4000),DESCRIPTION('Insert record into %Primary'),WHERE(%WhenAdd='Control Accepted')
#INSERT(%AddRecordCode)
#ENDAT
#!
#!
#GROUP(%AddRecordCode)
#IF(%AddParent)
IF ~AddedYet%ActiveTemplateInstance
  Access:%AddParent.PrimeRecord
  AddedYet%ActiveTemplateInstance = 1
END
#ENDIF
CLEAR(%Primary)
Access:%Primary.PrimeFields
#FOR(%AddFields)
  %AddFieldTarget = %AddFieldExpression
#ENDFOR
IF ~Access:%Primary.PrimeRecord(1)
  Access:%Primary.Insert()
END
#!
#!
#!
#!
#EXTENSION(ProcessUponCompletion,'Perform action upon update completion'),PROCEDURE,HLP('~ShoppingCompletion'),REQ(ShoppingTrolley(ShoppingTrolley))
  #PROMPT('Insert',PROCEDURE),%CompleteInsert
  #PROMPT('Change',PROCEDURE),%CompleteChange
  #PROMPT('Delete',PROCEDURE),%CompleteDelete
#!
#AT(%WindowManagerMethodCodeSection,'TakeCompleted','(),BYTE'),PRIORITY(6000),WHERE(%CompleteInsert OR %CompleteChange OR %CompleteDelete)
IF ~ReturnValue
  GlobalRequest = ProcessRecord
#IF ( %CompleteInsert = %CompleteChange AND %CompleteChange = %CompleteDelete )
  %CompleteInsert
#ELSE
  CASE SELF.Request
  #IF ( %CompleteInsert )
  OF InsertRecord
    %CompleteInsert
  #ENDIF
  #IF ( %CompleteChange )
  OF ChangeRecord
    %CompleteChange
  #ENDIF
  #IF ( %CompleteDelete )
  OF DeleteRecord
    %CompleteDelete
  #ENDIF
  END
#ENDIF
END
#ENDAT
#!
#!
#!
#!
#EXTENSION(SerializeDataField,'Serialize the records'),PROCEDURE,HLP('~ShoppingSerialize'),REQ(ShoppingTrolley(ShoppingTrolley))
#RESTRICT
  #IF(%IsProcessProcedure() = %False)
    #REJECT
  #ENDIF
#ENDRESTRICT
  #PROMPT('Field to serialize',FIELD(%Primary)),%SerialField,REQ
  #PROMPT('Starting value',@N10),%SerialValue,DEFAULT(1)
  #PROMPT('Step value',@N10),%SerialStep,DEFAULT(1)
#!
#AT(%DataSection),PRIORITY(2500)
#?Serial%ActiveTemplateInstance LONG(%SerialValue)
#ENDAT
#!
#!
#AT(%ProcessManagerMethodCodeSection,'TakeRecord','(),BYTE'),PRIORITY(1000)
%SerialField = Serial%ActiveTemplateInstance
Serial%ActiveTemplateInstance += %SerialStep
#ENDAT
#!
#!
#!
#!
#EXTENSION(ComputeStatistics,'Compute sales statistics'),PROCEDURE,HLP('~ShoppingStatistics'),REQ(ShoppingTrolley(ShoppingTrolley))
#RESTRICT
  #IF(%IsProcessProcedure() = %False)
    #REJECT
  #ENDIF
#ENDRESTRICT
#!
#PREPARE
  #CALL (%ReadABCFiles(ABC))
  #CALL (%SetClassDefaults(ABC), 'Statistics', 'Stats', %StatsTrackerClass)
#END
  #INSERT(%OOPPrompts(ABC))
  #TAB('&General')
    #PROMPT('Invoice Id Field:',FIELD(%Primary)),%InvoiceId,REQ
    #PROMPT('Invoice Quantity:',FIELD),%InvoiceQuantity,REQ
    #PROMPT('Foreign Product Id Field:',FIELD),%ForeignProductId,REQ
    #BUTTON('Product Quantities'),MULTI(%PQuantity,%ProductQuantity)
      #PROMPT('Product File:',FILE),%ProductFile,REQ
      #PROMPT('Product Id Field:',FIELD(%ProductFile)),%ProductId,REQ
      #PROMPT('Product Access Key:',KEY(%ProductFile)),%ProductKey,REQ
      #PROMPT('Product Sold Field:',FIELD(%ProductFile)),%ProductQuantity,REQ
    #ENDBUTTON
    #PROMPT('Cross-sale file:',FILE),%CrossSale
    #ENABLE(%CrossSale)
      #PROMPT('Cross-sale key:',KEY(%CrossSale)),%CrossSaleKey,REQ
      #PROMPT('Cross-sale product id:',COMPONENT(%CrossSaleKey)),%CrossLeftId,REQ
      #PROMPT('Cross-sale other product id:',COMPONENT(%CrossSaleKey)),%CrossRightId,REQ
      #PROMPT('Cross-sale quantity:',FIELD(%CrossSale)),%CrossQuantity,REQ
    #ENDENABLE
  #ENDTAB
  #TAB('&Classes')
    #BUTTON('&Statistics'),AT(,,170)
      #WITH(%ClassItem, 'Statistics')
        #INSERT(%ClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
  #ENDTAB
#!
#ATSTART
  #CALL (%ReadABCFiles(ABC))
  #CALL (%SetClassDefaults(ABC), 'Statistics', 'Stats', %StatsTrackerClass)
#ENDAT
#!
#!
#AT(%GatherObjects)
  #CALL(%AddObjectList(ABC), 'Statistics')
#ENDAT
#!
#!
#AT(%LocalProcedures)
  #CALL(%GenerateVirtuals(ABC), 'Statistics', 'Local Objects|Shopping Trolley Objects|Compute Statistics', '%StatisticsVirtuals(ShoppingTrolley)')
#ENDAT
#!
#!
#AT(%StatsMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%LocalDataClasses)
#INSERT(%GenerateClass(ABC), 'Statistics', 'Statistics Gathering Object')
#ENDAT
#!
#!
#AT(%StatsMethodCodeSection,'Init','()'),PRIORITY(7500),DESCRIPTION('Program the stats tracker')
  #FOR(%PQuantity)
SELF.AddProduct(Access:%ProductFile,%ProductKey,%ProductId,%ProductQuantity)
  #ENDFOR
  #IF(%CrossSale)
SELF.SetCross(Access:%CrossSale,%CrossSaleKey,%CrossLeftId,%CrossRightId,%CrossQuantity)
  #ENDIF
SELF.SetInvoice(%InvoiceId,%ForeignProductId,%InvoiceQuantity)
#ENDAT
#!
#!
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(8700),DESCRIPTION('Initialize Stats Tracker')
%ThisObjectName.Init
SELF.Additem(%ThisObjectName.RecordProcessor)
#ENDAT
#!
#!
#GROUP(%StatisticsVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%StatsMethodDataSection,'Statistics Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('Statistics'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%StatsMethodCodeSection,'Statistics Broker Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('Statistics'))),TREE(%TreeText & %CodeText)
#!
#!
#!
#!
#EXTENSION(InvoiceGenerator, 'Invoice Generator for Process'),PROCEDURE,SINGLE,HLP('~InvoiceGenerator'),REQ(ShoppingTrolley(ShoppingTrolley))
#RESTRICT
  #IF(%IsProcessProcedure() = %False)
    #REJECT
  #ENDIF
#ENDRESTRICT
#!
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'InvoiceCopier', 'InvoiceCopier', %InvoiceCopierClass)
  #CALL(%SetClassDefaults(ABC), 'SalesTaxModifier', 'SalesTaxModifier', %SalesTaxModifierClass)
  #CALL(%SetClassDefaults(ABC), 'QuantityDiscountModifier', 'QuantityDiscountModifier', %QuantityDiscountModifierClass)
  #CALL(%SetClassDefaults(ABC), 'ShippingOnInvoiceLineModifier', 'ShippingOnInvoiceLineModifier', %ShippingOnInvoiceLineModifierClass)
  #CALL(%SetClassDefaults(ABC), 'ShippingOnInvoiceModifier', 'ShippingOnInvoiceModifier', %ShippingOnInvoiceModifierClass)
  #CALL(%SetClassDefaults(ABC), 'CategoryDiscountModifier', 'CategoryDiscountModifier', %CategoryDiscountModifierClass)
  #CALL(%SetClassDefaults(ABC), 'GiftWrapModifier', 'GiftWrapModifier', %GiftWrapModifierClass)
#END
#INSERT(%OOPPrompts(ABC))
#TAB('&General')
  #PROMPT('&Call upon completion',PROCEDURE),%CallUponCompletion
#ENDTAB
#TAB('Ca&rt Fields')
  #BOXED('Cart File Fields')
    #PROMPT('Cart &File:', FILE),%CartFile,REQ,DEFAULT(%Primary)
    #PROMPT('&ID Field:', FIELD(%CartFile)),%CartIDField,REQ
    #PROMPT('&Date Field (Optional):', FIELD(%CartFile)),%CartDateField
    #PROMPT('&Customer ID Field (Optional):', FIELD(%CartFile)),%CartCustomerIDField
  #ENDBOXED
  #BOXED('Cart Line File Fields')
    #PROMPT('Cart &Line File:', FILE),%CartLineFile,REQ
    #PROMPT('ID Fi&eld:', FIELD(%CartLineFile)),%CartLineIDField,REQ
    #PROMPT('&Quantity Field', FIELD(%CartLineFile)),%CartLineQuantityField,REQ
    #PROMPT('&Product ID Field:', FIELD(%CartLineFile)),%CartLineProductIDField,REQ
    #PROMPT('&Options Field (Optional):', FIELD(%CartLineFile)),%CartLineOptionsField
  #ENDBOXED
  #BOXED('Product File Fields')
    #PROMPT('Produc&t File:', FILE),%ProductFile,REQ
    #PROMPT('&Unit Price Field:',FIELD(%ProductFile)),%ProductUnitPriceField,REQ
    #PROMPT('&Name Field:',FIELD(%ProductFile)),%ProductNameField,REQ
    #PROMPT('De&scription Field:',FIELD(%ProductFile)),%ProductDescriptionField
  #ENDBOXED
#ENDTAB
#TAB('&Invoice Fields')
  #BOXED('Invoice File')
  #PROMPT('Invoice &File:', FILE),%InvoiceFile,REQ
  #ENABLE(%InvoiceFile <> ''),CLEAR
    #PROMPT('Cart &Key:',KEY(%InvoiceFile)),%InvoiceCartKey,REQ
    #PROMPT('&ID Field:',FIELD(%InvoiceFile)),%InvoiceIDField,REQ
    #PROMPT('&Cart ID Field:',FIELD(%InvoiceFile)),%InvoiceCartIDField,REQ
    #PROMPT('Custo&mer ID Field (Optional):',FIELD(%InvoiceFile)),%InvoiceCustomerIDField
    #PROMPT('&Total Field:', FIELD(%InvoiceFile)),%InvoiceTotalField,REQ
    #PROMPT('&Date Field (Optional):', FIELD(%InvoiceFile)),%InvoiceDateField
    #ENABLE(%InvoiceDateField <> ''),CLEAR
      #PROMPT('Date Field Initial Value:', @S255),%InvoiceDateFieldInitial,REQ,DEFAULT('TODAY()')
    #ENDENABLE
    #PROMPT('&Accepted Field (Optional):', FIELD(%InvoiceFile)),%InvoiceAcceptedField
  #ENDENABLE
  #ENDBOXED
  #BOXED('Invoice Line File')
  #PROMPT('Invoice &Line File:', FILE),%ILFile,REQ
  #ENABLE(%ILFile <> ''),CLEAR
    #PROMPT('File Ke&y:', KEY(%ILFile)),%ILKey,REQ
    #PROMPT('In&voice ID Field:', FIELD(%ILFile)),%ILInvoiceIDField,REQ
    #PROMPT('Li&ne ID Field:', FIELD(%ILFile)),%ILIDField,REQ
    #PROMPT('&Product ID Field:', FIELD(%ILFile)),%ILProductIDField,REQ
    #PROMPT('Product Name Field:', FIELD(%ILFile)),%ILProductNameField,REQ
    #PROMPT('&Options Field (Optional):', FIELD(%ILFile)),%ILOptionsField
    #PROMPT('&Unit Price Field:', FIELD(%ILFile)),%ILUnitPriceField,REQ
    #PROMPT('&Quantity Field:', FIELD(%ILFile)),%ILQuantityField,REQ
    #ENABLE(%ILQuantityField <> ''),CLEAR
      #PROMPT('Quanity Field Initial Value:', @S255),%ILQuantityFieldInitial,REQ,DEFAULT('1')
    #ENDENABLE
    #PROMPT('&Ship Cost Field (Optional):', FIELD(%ILFile)),%ILShippingCostField
    #PROMPT('D&escription Field:', FIELD(%ILFile)),%ILDescriptionField,REQ
    #PROMPT('P&roduct Cost Field:', FIELD(%ILFile)),%ILProductCostField,REQ
  #ENDENABLE
  #ENDBOXED
#ENDTAB
#TAB('Invoice Modifiers')
  #PROMPT('Apply Sales Tax Modifier', CHECK),%HasSalesTaxModifier,DEFAULT(%FALSE),AT(10,30)
  #ENABLE(%HasSalesTaxModifier=%TRUE)
    #BUTTON('...'),AT(160,28,12,12)
      #SHEET,HSCROLL
        #TAB('&General')
          #PROMPT('Invoke &Priority:' ,SPIN(@n3, 1, 255, 1)),%TInvokeAt,DEFAULT(100)
          #PROMPT('&Tax Amnt Field (Optional):', FIELD(%ILFile)),%TaxAmountField
          #PROMPT('T&axable Field (Optional):', FIELD(%CartLineFile)),%TaxableAmountField
          #PROMPT('Tax &Code Source:', DROP('Constant Value|File')),%TaxCodeSource,DEFAULT('Constant Value'),REQ
          #BOXED,SECTION
            #BOXED,AT(0,0),WHERE(%TaxCodeSource = 'Constant Value')
              #PROMPT('Tax &Rate:',SPIN(@N6.2,0,100)),%TaxRate,REQ
            #ENDBOXED
            #BOXED,AT(0,0),WHERE(%TaxCodeSource = 'File')
              #PROMPT('Tax &Code File:', FILE),%TaxCodeFile,REQ
              #ENABLE(%TaxCodeFile <> '')
                #PROMPT('Tax Code File &Key:', KEY(%TaxCodeFile)),%TaxCodeFileKey,REQ
                #PROMPT('Tax Code &Field:', FIELD(%TaxCodeFile)),%TaxCodeField,REQ
                #PROMPT('Tax &Rate Field:', FIELD(%TaxCodeFile)),%TaxRateField,REQ
                #BOXED('Product File Field')
                  #PROMPT('Ta&x Code Field:', FIELD(%ProductFile)),%ProductTaxCodeField,REQ
                #ENDBOXED
                #PROMPT('S&pecial Tax Code (Optional):', @S255),%ProductSpecialTaxCode
                #ENABLE(%ProductSpecialTaxCode <> '')
                  #PROMPT('Tax Code Expression (Optional):', @S255),%ProductTaxCodeExpression
                #ENDENABLE
              #ENDENABLE
            #ENDBOXED
          #ENDBOXED
        #ENDTAB
        #TAB('&Classes')
          #WITH(%ClassItem, 'SalesTaxModifier')
            #INSERT(%ClassPrompts(ABC))
          #ENDWITH
        #ENDTAB
      #ENDSHEET
    #ENDBUTTON
  #ENDENABLE
  #PROMPT('Apply Quantity Discount Modifier', CHECK),%HasQuantityDiscountModifier,DEFAULT(%FALSE),AT(10,46)
  #ENABLE(%HasQuantityDiscountModifier=%TRUE)
    #BUTTON('...'),AT(160,44,12,12)
      #SHEET,HSCROLL
        #TAB('&General')
          #PROMPT('Invoke &Priority:' ,SPIN(@n3, 1, 255, 1)),%DInvokeAt,DEFAULT(50)
          #PROMPT('&Discount File: ', FILE),%DiscountFile,REQ
          #PROMPT('Discount File &Key:', KEY(%DiscountFile)),%DiscountFileKey,REQ
          #PROMPT('P&roduct ID Field:', FIELD(%DiscountFile)),%DProductIDField,REQ
          #PROMPT('Quantity &Low:', FIELD(%DiscountFile)),%DQuantityLowField
          #PROMPT('Quantity &High:', FIELD(%DiscountFile)),%DQuantityHighField
          #PROMPT('Minimum &Spen&t:', FIELD(%DiscountFile)),%DMinSpentField
          #PROMPT('Di&scount Type Field (Optional):', FIELD(%DiscountFile)),%DiscountTypeField
          #PROMPT('Per&cent Discount Field:', FIELD(%DiscountFile)),%PercentDiscountField
          #PROMPT('Discounted &Amount Field:', FIELD(%DiscountFile)),%DiscountedAmountField
          #PROMPT('Date L&ow Field (Optional):', FIELD(%DiscountFile)),%DDateLowField
          #PROMPT('Da&te High Field (Optional):', FIELD(%DiscountFile)),%DDateHighField
          #PROMPT('D&escription:', @S255),%DDescription
          #PROMPT('De&fault Type:', @S255),%DefaultType
          #PROMPT('Discount on &New Invoice Line', CHECK),%DExtraLine,DEFAULT(%True),AT(10)
        #ENDTAB
        #TAB('&Classes')
          #WITH(%ClassItem, 'QuantityDiscountModifier')
            #INSERT(%ClassPrompts(ABC))
          #ENDWITH
        #ENDTAB
      #ENDSHEET
    #ENDBUTTON
  #ENDENABLE
  #PROMPT('Apply Shipping Per Invoice Line Modifier', CHECK),%HasShippingILModifier,DEFAULT(%FALSE),AT(10,62)
  #ENABLE(%HasShippingILModifier=%TRUE)
    #BUTTON('...'),AT(160,60,12,12)
      #SHEET,HSCROLL
        #TAB('&General')
          #PROMPT('Invoke &Priority:' ,SPIN(@n3, 1, 255, 1)),%SHILInvokeAt,DEFAULT(200)
          #PROMPT('D&escription:', @S255),%SHILDescription
          #BOXED('Shipping Cost File')
            #PROMPT('Shipping Cost &File: ', FILE),%SHILShippingCostFile
            #ENABLE(%SHILShippingCostFile <> '')
              #PROMPT('Shipping Cost File &Key:', KEY(%SHILShippingCostFile)),%SHILShippingCostFileKey
              #PROMPT('Minimum &Quantity:', FIELD(%SHILShippingCostFile)),%SHILMinQuantityField
              #PROMPT('Minimum &Spen&t:', FIELD(%SHILShippingCostFile)),%SHILMinSpentField
              #PROMPT('&Shipping:', FIELD(%SHILShippingCostFile)),%SHILShippingField,REQ
              #PROMPT('&Is Percentage:', FIELD(%SHILShippingCostFile)),%SHILIsPercentageField
              #PROMPT('&Product ID (optional):', FIELD(%SHILShippingCostFile)),%SHILProductIDField
              #PROMPT('&Destination: (optional)', FIELD(%SHILShippingCostFile)),%SHILDestinationField
            #ENDENABLE
          #ENDBOXED
          #BOXED('Shipping Per Item')
            #PROMPT('Fixed Shipping Charge If Not Found In File?', CHECK),%SHILFixedShippingPerItem,DEFAULT(%FALSE),AT(10)
            #ENABLE(%SHILFixedShippingPerItem= %TRUE)
              #PROMPT('Fi&xed:', @N14.2),%SHILFixedShipping
            #ENDENABLE
            #PROMPT('Percentage Shipping Charge If Not Found In File?', CHECK),%SHILPercentageShippingPerItem,DEFAULT(%FALSE),AT(10)
            #ENABLE(%SHILPercentageShippingPerItem= %TRUE)
              #PROMPT('Percenta&ge of Net Goods:', SPIN(@N14.2,0,100)),%SHILPercentageShipping
            #ENDENABLE
          #ENDBOXED
          #PROMPT('Cal&culate Shipping:', DROP('Total|Maximum|Minimum')),%SHILCalculateResult,DEFAULT('Total'),REQ
          #ENABLE(%SHILDestinationField <> '' OR %SHILWeightDestinationField <> '')
            #PROMPT('Desti&nation Expression (Optional):', @S255),%SHILDestinationExpression
          #ENDENABLE
          #ENABLE(%SHILProductIDField <> '' OR %SHILWeightProductIDField <> '')
            #PROMPT('IF Prod&uct ID Not Found:', DROP('Use Constant Values|Search for empty Product ID')),%SHILProductNotFound,DEFAULT('Use Constant Values')
          #ENDENABLE
        #ENDTAB
        #TAB('&Shipping By Weight')
          #BOXED('Product File Fields')
            #PROMPT('&Weight Field (optional):', FIELD(%ProductFile)),%ProductWeightField
            #ENABLE(%ProductWeightField <> '')
              #PROMPT('Shipping Fie&ld (optional):', FIELD(%ProductFile)),%ProductShippingField
            #ENDENABLE
          #ENDBOXED
          #ENABLE(%ProductWeightField <> '')
            #BOXED('Shipping Weight File')
              #PROMPT('Shipping Weight Fi&le: ', FILE),%SHILShippingWeightFile
              #ENABLE(%SHILShippingWeightFile <> '')
                #PROMPT('Shipping Weight File Ke&y:', KEY(%SHILShippingWeightFile)),%SHILShippingWeightFileKey
                #PROMPT('&Minimum Weight:', FIELD(%SHILShippingWeightFile)),%SHILMinWeightField
                #PROMPT('S&hipping:', FIELD(%SHILShippingWeightFile)),%SHILWeightShippingField,REQ
                #PROMPT('P&roduct ID (optional):', FIELD(%SHILShippingWeightFile)),%SHILWeightProductIDField
                #PROMPT('D&estination: (optional)', FIELD(%SHILShippingWeightFile)),%SHILWeightDestinationField
              #ENDENABLE
            #ENDBOXED
            #PROMPT('Shipping Charge If Not Found In File?', CHECK),%SHILEntryWeightShipping,DEFAULT(%FALSE),AT(10)
            #ENABLE(%SHILEntryWeightShipping= %TRUE)
              #PROMPT('Shipping &By Weight (optional):', @S255),%SHILShippingByWeight
            #ENDENABLE
          #ENDENABLE
        #ENDTAB
        #TAB('&Classes')
          #WITH(%ClassItem, 'ShippingOnInvoiceLineModifier')
            #INSERT(%ClassPrompts(ABC))
          #ENDWITH
        #ENDTAB
      #ENDSHEET
    #ENDBUTTON
  #ENDENABLE
  #PROMPT('Apply Shipping Per Invoice Modifier', CHECK),%HasShippingIModifier,DEFAULT(%FALSE),AT(10,78)
  #ENABLE(%HasShippingIModifier=%TRUE)
    #BUTTON('...'),AT(160,76,12,12)
      #SHEET,HSCROLL
        #TAB('&General')
          #PROMPT('Invoke &Priority:' ,SPIN(@n3, 1, 255, 1)),%SHIInvokeAt,DEFAULT(220)
          #PROMPT('D&escription:', @S255),%SHIDescription
          #PROMPT('One-Off Shipping Charge?', CHECK),%EntryOneOffShipping,DEFAULT(%FALSE),AT(10)
          #ENABLE(%EntryOneOffShipping= %TRUE)
            #PROMPT('One&-Off Shipping:', @N14.2),%OneOffShipping
          #ENDENABLE
          #BOXED('Shipping Cost File')
            #PROMPT('Shipping Cost &File: ', FILE),%SHIShippingCostFile
            #ENABLE(%SHIShippingCostFile <> '')
              #PROMPT('Shipping Cost File &Key:', KEY(%SHIShippingCostFile)),%SHIShippingCostFileKey
              #PROMPT('Minimum &Quantity:', FIELD(%SHIShippingCostFile)),%SHIMinQuantityField
              #PROMPT('Minimum Spen&t:', FIELD(%SHIShippingCostFile)),%SHIMinSpentField
              #PROMPT('&Shipping:', FIELD(%SHIShippingCostFile)),%SHIShippingField,REQ
              #PROMPT('&Is Percentage:', FIELD(%SHIShippingCostFile)),%SHIIsPercentageField
              #PROMPT('&Destination: (optional)', FIELD(%SHIShippingCostFile)),%SHIDestinationField
            #ENDENABLE
          #ENDBOXED
          #BOXED('Shipping Per Item')
            #PROMPT('Fixed Shipping Charge If Not Found In File?', CHECK),%SHIFixedShippingPerItem,DEFAULT(%FALSE),AT(10)
            #ENABLE(%SHIFixedShippingPerItem= %TRUE)
              #PROMPT('Fi&xed:', @N14.2),%SHIFixedShipping
            #ENDENABLE
            #PROMPT('Percentage Shipping Charge If Not Found In File?', CHECK),%SHIPercentageShippingPerItem,DEFAULT(%FALSE),AT(10)
            #ENABLE(%SHIPercentageShippingPerItem= %TRUE)
              #PROMPT('Percenta&ge of Net Goods:', SPIN(@N14.2,0,100)),%SHIPercentageShipping
            #ENDENABLE
          #ENDBOXED
          #PROMPT('Cal&culate Shipping:', DROP('Total|Maximum|Minimum')),%SHICalculateResult,DEFAULT('Total'),REQ
          #ENABLE(%SHIDestinationField <> '' OR %SHIWeightDestinationField <> '')
            #PROMPT('Desti&nation Expression (Optional):', @S255),%SHIDestinationExpression
          #ENDENABLE
          #PROMPT('Over&ride Invoice Line Shipping', CHECK),%OverRide,DEFAULT(%FALSE),AT(10)
          #ENABLE(%OverRide = %TRUE)
            #PROMPT('Credit Descripti&on:', @S255),%CreditDescription
          #ENDENABLE
        #ENDTAB
        #TAB('&Shipping By Weight')
          #BOXED('Product File Field')
            #PROMPT('&Weight Field (optional):', FIELD(%ProductFile)),%ProductWeightField
          #ENDBOXED
          #ENABLE(%ProductWeightField <> '')
            #BOXED('Shipping Weight File')
              #PROMPT('Shipping Weight Fi&le: ', FILE),%SHIShippingWeightFile
              #ENABLE(%SHIShippingWeightFile <> '')
                #PROMPT('Shipping Weight File Ke&y:', KEY(%SHIShippingWeightFile)),%SHIShippingWeightFileKey
                #PROMPT('&Minimum Weight:', FIELD(%SHIShippingWeightFile)),%SHIMinWeightField
                #PROMPT('S&hipping:', FIELD(%SHIShippingWeightFile)),%SHIWeightShippingField,REQ
                #PROMPT('D&estination: (optional)', FIELD(%SHIShippingWeightFile)),%SHIWeightDestinationField
              #ENDENABLE
            #ENDBOXED
            #PROMPT('Shipping Charge If Not Found In File?', CHECK),%SHIEntryWeightShipping,DEFAULT(%FALSE),AT(10)
            #ENABLE(%SHIEntryWeightShipping= %TRUE)
              #PROMPT('Shipping &By Weight (optional):', @S255),%SHIShippingByWeight
            #ENDENABLE
          #ENDENABLE
        #ENDTAB
        #TAB('&Classes')
          #WITH(%ClassItem, 'ShippingOnInvoiceModifier')
            #INSERT(%ClassPrompts(ABC))
          #ENDWITH
        #ENDTAB
      #ENDSHEET
    #ENDBUTTON
  #ENDENABLE
  #PROMPT('Apply Category Discount Modifier', CHECK),%HasCategoryDiscountModifier,DEFAULT(%FALSE),AT(10,94)
  #ENABLE(%HasCategoryDiscountModifier=%TRUE)
    #BUTTON('...'),AT(160,92,12,12)
      #SHEET,HSCROLL
        #TAB('&General')
          #PROMPT('Invoke &Priority:' ,SPIN(@n3, 1, 255, 1)),%CInvokeAt,DEFAULT(40)
          #PROMPT('D&escription:', @S255),%CDescription
          #PROMPT('Category Discount on &New Invoice Line', CHECK),%CExtraLine,DEFAULT(%True),AT(10)
          #BOXED('Category File')
            #PROMPT('&Category File: ', FILE),%CategoryFile,REQ
            #PROMPT('&Key on Category:', KEY(%CategoryFile)),%CategoryFileKey,REQ
            #PROMPT('Category &ID Field:', FIELD(%CategoryFile)),%CategoryIDField,REQ
            #PROMPT('Category Na&me Field:', FIELD(%CategoryFile)),%CategoryNameField
            #PROMPT('Date L&ow Field (Optional):', FIELD(%CategoryFile)),%CDateLowField
            #PROMPT('Da&te High Field (Optional):', FIELD(%CategoryFile)),%CDateHighField
            #PROMPT('&Discount Field:', FIELD(%CategoryFile)),%DiscountField,REQ
            #PROMPT('&Supersedes Other Discounts Field:', FIELD(%CategoryFile)),%SupersedesField
          #ENDBOXED
          #BOXED('Product Category File')
            #PROMPT('P&roduct Category File: ', FILE),%ProdCatFile,REQ
            #PROMPT('Ke&y on ProductID:', KEY(%ProdCatFile)),%ProdCatKey,REQ
            #PROMPT('C&ategory ID Field:', FIELD(%ProdCatFile)),%ProdCatCatField,REQ
            #PROMPT('P&roduct ID Field:', FIELD(%ProdCatFile)),%ProdCatProdField,REQ
          #ENDBOXED
        #ENDTAB
        #TAB('&Classes')
          #WITH(%ClassItem, 'CategoryDiscountModifier')
            #INSERT(%ClassPrompts(ABC))
          #ENDWITH
        #ENDTAB
      #ENDSHEET
    #ENDBUTTON
  #ENDENABLE
  #PROMPT('Apply Gift Wrap Modifier', CHECK),%HasGiftWrapModifier,DEFAULT(%FALSE),AT(10,110)
  #ENABLE(%HasGiftWrapModifier=%TRUE)
    #BUTTON('...'),AT(160,108,12,12)
      #SHEET,HSCROLL
        #TAB('&General')
          #PROMPT('Invoke &Priority:' ,SPIN(@n3, 1, 255, 1)),%GInvokeAt,DEFAULT(30)
          #PROMPT('Gift wrap option on &New Invoice Line', CHECK),%GExtraLine,DEFAULT(%True),AT(10)
          #BOXED('Cart Line Field')
            #PROMPT('Gift &Wrap ID Field:', FIELD(%CartLineFile)),%CartLineOptionIDField,REQ
          #ENDBOXED
          #BOXED('Gift Wrap File')
            #PROMPT('&Gift Wrap File: ', FILE),%OptionsFile,REQ
            #PROMPT('File &Key:', KEY(%OptionsFile)),%OptionsFileKey,REQ
            #PROMPT('Gift Wrap &ID Field:', FIELD(%OptionsFile)),%OptionIDField,REQ
            #PROMPT('P&roduct ID Field (Optional):', FIELD(%OptionsFile)),%GProductIDField
            #ENABLE(%GProductIDField <> '')
              #PROMPT('IF Product &Not Found:', DROP('Do Nothing|Search for empty Product ID')),%ProductNotFound,DEFAULT('Do Nothing')
            #ENDENABLE
            #PROMPT('&Description Field (Optional):', FIELD(%OptionsFile)),%GDescriptionField
            #PROMPT('&Cost Field:', FIELD(%OptionsFile)),%CostField,REQ
            #PROMPT('Cost Is Per&centage Field (Optional):', FIELD(%OptionsFile)),%IsPercentageField
          #ENDBOXED
        #ENDTAB
        #TAB('&Classes')
          #WITH(%ClassItem, 'GiftWrapModifier')
            #INSERT(%ClassPrompts(ABC))
          #ENDWITH
        #ENDTAB
      #ENDSHEET
    #ENDBUTTON
  #ENDENABLE
#ENDTAB
#TAB('&Reservation System'),WHERE(%HasReservation()=%TRUE)
  #PROMPT('&Use Reservations', CHECK),%UseProductReservation,DEFAULT(%FALSE),AT(10)
  #ENABLE(%UseProductReservation = %TRUE)
    #BOXED('Product File')
      #PROMPT('&Product File:',FILE),%ProductFile,REQ
      #ENABLE(%ProductFile <> ''),CLEAR
        #PROMPT('Reservation &Status Field:', FIELD(%ProductFile)),%PStatusField,REQ
        #PROMPT('&Availability Field:',FIELD(%ProductFile)),%PAvailabilityField
      #ENDENABLE
    #ENDBOXED
    #BOXED('Invoice Line File')
      #PROMPT('Reserva&tion Number Field:',FIELD(%ILFile)),%ILReservationField,REQ
    #ENDBOXED
    #PROMPT('Te&xt for Failed Reservation:', @S255),%FailedText
  #ENDENABLE
#ENDTAB
#TAB('&Classes')
  #WITH(%ClassItem, 'InvoiceCopier')
    #INSERT(%ClassPrompts(ABC))
  #ENDWITH
#ENDTAB
#!
#ATSTART
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'InvoiceCopier', 'InvoiceCopier', %InvoiceCopierClass)
  #CALL(%AddToView, %CartIDField)
  #CALL(%AddToView, %CartDateField)
  #CALL(%AddToView, %CartCustomerIDField)
  #CALL(%AddToView, %CartLineIDField)
  #CALL(%AddToView, %CartLineQuantityField)
  #CALL(%AddToView, %CartLineProductIDField)
  #CALL(%AddToView, %CartLineOptionsField)
  #CALL(%AddToView, %ProductUnitPriceField)
  #FIX(%ClassItem, 'InvoiceCopier')
  #EQUATE(%InvoiceCopier, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'SalesTaxModifier', 'SalesTaxModifier', %SalesTaxModifierClass)
  #FIX(%ClassItem, 'SalesTaxModifier')
  #EQUATE(%SalesTaxModifier, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'QuantityDiscountModifier', 'QuantityDiscountModifier', %QuantityDiscountModifierClass)
  #FIX(%ClassItem, 'QuantityDiscountModifier')
  #EQUATE(%QuantityDiscountModifier, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'ShippingOnInvoiceLineModifier', 'ShippingOnInvoiceLineModifier', %ShippingOnInvoiceLineModifierClass)
  #FIX(%ClassItem, 'ShippingOnInvoiceLineModifier')
  #EQUATE(%ShippingOnInvoiceLineModifier, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'ShippingOnInvoiceModifier', 'ShippingOnInvoiceModifier', %ShippingOnInvoiceModifierClass)
  #FIX(%ClassItem, 'ShippingOnInvoiceModifier')
  #EQUATE(%ShippingOnInvoiceModifier, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'CategoryDiscountModifier', 'CategoryDiscountModifier', %CategoryDiscountModifierClass)
  #FIX(%ClassItem, 'CategoryDiscountModifier')
  #EQUATE(%CategoryDiscountModifier, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'GiftWrapModifier', 'GiftWrapModifier', %GiftWrapModifierClass)
  #FIX(%ClassItem, 'GiftWrapModifier')
  #EQUATE(%GiftWrapModifier, %ThisObjectName)
#ENDAT
#!
#!
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(8600),DESCRIPTION('Initialize Invoice Copier')
%InvoiceCopier.InitCart(%ProcessObjectName, %CartIDField, %CartLineIDField, %CartLineProductIDField, %CartLineOptionsField, %ProductUnitPriceField, %CartLineQuantityField, %CartCustomerIDField, %CartDateField, %ProductNameField, %ProductDescriptionField)
  #IF(%HasReservation() AND %UseProductReservation)
    #DECLARE(%TplInstance)
    #CALL(%FindLocalTemplateInstance, 'Reservation(ShoppingTrolley)'),%TplInstance
    #IF(%TplInstance > 0)
      #ALIAS(%ThisClassItem, %ClassItem, %TplInstance)
      #FIX(%ThisClassItem, 'Reservation')
      #IF(%ThisClassItem='Reservation')
%InvoiceCopier.InitReservation(%ThisClassItem.IReservation, %PStatusField, %PAvailabilityField, %(%StripPling(%FailedText)), %ILReservationField)
      #ELSE
        #ASSERT(%False, 'Reservation class not found!')
      #ENDIF
    #ELSE
      #ASSERT(%False, 'Reservation template instance not found!')
    #ENDIF
  #ENDIF
%InvoiceCopier.InitInvoice(Access:%InvoiceFile, %InvoiceCartKey, %InvoiceIDField, %InvoiceCartIDField, %InvoiceCustomerIDField, %InvoiceTotalField, %InvoiceDateField, %InvoiceAcceptedField)
%InvoiceCopier.InitInvoiceLine(Access:%ILFile, %ILKey, %ILInvoiceIDField, %ILIDField, %ILProductIDField, %ILOptionsField, %ILUnitPriceField, %ILQuantityField, %ILShippingCostField, %ILDescriptionField, %ILProductCostField, %ILProductNameField)
#EMBED(%AddInvoiceModifiers, ''),HIDE
SELF.AddItem(%InvoiceCopier.RecordProcessor)
#ENDAT
#!
#!
#AT(%WindowManagerMethodCodeSection,'Kill','(),BYTE'),PRIORITY(5500),DESCRIPTION('Kill Invoice Copier')
%InvoiceCopier.Kill
#PRIORITY(9950)
  #IF (%CallUponCompletion)
CLOSE(%Window)
GlobalRequest = ViewRecord
%CallUponCompletion
  #ENDIF
#END
#!
#!
#AT(%FileManagerCodeSection,,'PrimeFields','()'),WHERE(%File = %InvoiceFile OR %File = %ILFile),PRIORITY(3000)
  #SUSPEND
  #IF(%File = %InvoiceFile)
    #FIX(%Field,%InvoiceDateField)
    #IF(%InvoiceDateField <> '' AND (%FieldInitial = '' OR %InvoiceDateFieldInitial <> 'TODAY()'))
      #RELEASE
%Field = %InvoiceDateFieldInitial
    #ENDIF
  #ENDIF
  #IF(%File = %ILFile)
    #FIX(%Field,%ILQuantityField)
    #IF(%FieldInitial = '' OR %ILQuantityFieldInitial <> '1')
      #RELEASE
%Field = %ILQuantityFieldInitial
    #ENDIF
  #ENDIF
  #RESUME
#ENDAT
#!
#!
#AT(%AddInvoiceModifiers)
  #IF(%HasSalesTaxModifier=%TRUE)
    #IF(%TaxAmountField <> '')
%SalesTaxModifier.AddItem('TaxAmountField', %TaxAmountField)
    #ENDIF
    #IF(%TaxAbleAmountField <> '')
%SalesTaxModifier.AddItem('TaxableField', %TaxAbleAmountField)
    #ENDIF
    #CASE(%TaxCodeSource)
    #OF('Constant Value')
%SalesTaxModifier.AddItem('TaxRate', , %(%StripPling(%TaxRate)))
    #OF('File')
%SalesTaxModifier.AddItem('TaxCodeFileManager',,,Access:%TaxCodeFile)
%SalesTaxModifier.AddItem('TaxCodeFileKey',,,,%TaxCodeFileKey)
%SalesTaxModifier.AddItem('TaxCodeField',%TaxCodeField)
%SalesTaxModifier.AddItem('TaxRateField',%TaxRateField)
%SalesTaxModifier.AddItem('ProductTaxCodeField',%ProductTaxCodeField)
      #IF(%ProductSpecialTaxCode <> '')
%SalesTaxModifier.AddItem('SpecialTaxCode',, %(%StripPling(%ProductSpecialTaxCode)))
      #ENDIF
      #IF(%ProductTaxCodeExpression <> '')
%SalesTaxModifier.AddItem('TaxCodeExpression',, %(%StripPling(%ProductTaxCodeExpression)))
      #ENDIF
    #ELSE
      #ASSERT(%False, 'Bad value in %%TaxCodeSource')
    #ENDCASE
%InvoiceCopier.AddItem(%SalesTaxModifier, %TInvokeAt)
  #ENDIF
#!
#!
  #IF(%HasQuantityDiscountModifier=%TRUE)
%QuantityDiscountModifier.AddItem('FileManager',,,Access:%DiscountFile)
%QuantityDiscountModifier.AddItem('FileKey',,,,%DiscountFileKey)
%QuantityDiscountModifier.AddItem('ProductID',%DProductIDField)
    #IF(%DQuantityLowField<> '')
%QuantityDiscountModifier.AddItem('QuantityLow',%DQuantityLowField)
    #ENDIF
    #IF(%DQuantityHighField<> '')
%QuantityDiscountModifier.AddItem('QuantityHigh',%DQuantityHighField)
    #ENDIF
    #IF(%DMinSpentField <> '')
%QuantityDiscountModifier.AddItem('MinSpent', %DMinSpentField)
    #ENDIF
    #IF(%DiscountTypeField <> '')
%QuantityDiscountModifier.AddItem('DiscountType', %DiscountTypeField)
    #ENDIF
    #IF(%PercentDiscountField <> '')
%QuantityDiscountModifier.AddItem('PercentDiscount', %PercentDiscountField)
    #ENDIF
    #IF(%DiscountedAmountField <> '')
%QuantityDiscountModifier.AddItem('DiscountAmount', %DiscountedAmountField)
    #ENDIF
    #IF(%DDateLowField<> '')
%QuantityDiscountModifier.AddItem('DateLow',%DDateLowField)
    #ENDIF
    #IF(%DDateHighField<> '')
%QuantityDiscountModifier.AddItem('DateHigh',%DDateHighField)
    #ENDIF
    #IF(%DExtraLine = %TRUE)
%QuantityDiscountModifier.AddItem('ExtraLine',,TRUE)
    #ENDIF
    #IF(%DDescription <> '')
%QuantityDiscountModifier.AddItem('Description',,%(%StripPling(%DDescription)))
    #ENDIF
    #IF(%DefaultType <> '')
%QuantityDiscountModifier.AddItem('DefaultType',,%(%StripPling(%DefaultType)))
    #ENDIF
%InvoiceCopier.AddItem(%QuantityDiscountModifier, %DInvokeAt)
  #ENDIF
#!
#!
  #IF(%HasShippingILModifier=%TRUE)
    #IF(%SHILDescription <> '')
%ShippingOnInvoiceLineModifier.AddItem('Description',,%(%StripPling(%SHILDescription)))
    #ENDIF
    #IF(%SHILShippingCostFile <> '')
%ShippingOnInvoiceLineModifier.AddItem('SCFileManager',,, Access:%SHILShippingCostFile)
    #ENDIF
    #IF(%SHILShippingCostFileKey <> '')
%ShippingOnInvoiceLineModifier.AddItem('SCKey',,,, %SHILShippingCostFileKey)
    #ENDIF
    #IF(%SHILMinQuantityField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SCMinQuantityField', %SHILMinQuantityField)
    #ENDIF
    #IF(%SHILMinSpentField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SCMinSpentField', %SHILMinSpentField)
    #ENDIF
    #IF(%SHILShippingField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SCShippingField', %SHILShippingField)
    #ENDIF
    #IF(%SHILIsPercentageField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SCIsPercentageField', %SHILIsPercentageField)
    #ENDIF
    #IF(%SHILProductIDField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SCProductIDField', %SHILProductIDField)
    #ENDIF
    #IF(%SHILDestinationField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SCDestinationCodeField', %SHILDestinationField)
    #ENDIF
    #IF(%SHILFixedShippingPerItem= %TRUE)
%ShippingOnInvoiceLineModifier.AddItem('PerItemFixedShipping',, %SHILFixedShipping)
    #ENDIF
    #IF(%SHILPercentageShippingPerItem = %TRUE)
%ShippingOnInvoiceLineModifier.AddItem('PerItemPercentageShipping',, %SHILPercentageShipping)
    #ENDIF
    #IF(%SHILDestinationExpression <> '')
%ShippingOnInvoiceLineModifier.AddItem('DestinationExpression',, %(%StripPling(%SHILDestinationExpression)))
    #ENDIF
    #IF(%ProductWeightField <> '')
%ShippingOnInvoiceLineModifier.AddItem('PWeightField', %ProductWeightField)
    #ENDIF
    #IF(%SHILShippingWeightFile <> '')
%ShippingOnInvoiceLineModifier.AddItem('SWFileManager',,, Access:%SHILShippingWeightFile)
    #ENDIF
    #IF(%SHILShippingWeightFileKey <> '')
%ShippingOnInvoiceLineModifier.AddItem('SWKey',,,, %SHILShippingWeightFileKey)
    #ENDIF
    #IF(%SHILMinWeightField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SWMinWeightField', %SHILMinWeightField)
    #ENDIF
    #IF(%SHILWeightShippingField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SWFixedWeightShippingField', %SHILWeightShippingField)
    #ENDIF
    #IF(%SHILWeightProductIDField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SWProductIDField', %SHILWeightProductIDField)
    #ENDIF
    #IF(%SHILWeightDestinationField <> '')
%ShippingOnInvoiceLineModifier.AddItem('SWDestinationCodeField', %SHILWeightDestinationField)
    #ENDIF
    #IF(%ProductShippingField <> '')
%ShippingOnInvoiceLineModifier.AddItem('PFixedWeightShippingField', %ProductShippingField)
    #ENDIF
    #IF(%SHILEntryWeightShipping= %TRUE)
%ShippingOnInvoiceLineModifier.AddItem('FixedWeightShipping',, %SHILShippingByWeight)
    #ENDIF
%ShippingOnInvoiceLineModifier.AddItem('EndResult',,%(%StripPling(%SHILCalculateResult)))
    #IF(%SHILProductNotFound = 'Search for empty Product ID')
%ShippingOnInvoiceLineModifier.AddItem('UseGenericProdID',,TRUE)
    #ENDIF
%InvoiceCopier.AddItem(%ShippingOnInvoiceLineModifier, %SHILInvokeAt)
  #ENDIF
#!
#!
  #IF(%HasShippingIModifier=%TRUE)
    #IF(%SHIDescription <> '')
%ShippingOnInvoiceModifier.AddItem('Description',,%(%StripPling(%SHIDescription)))
    #ENDIF
    #IF(%SHIShippingCostFile <> '')
%ShippingOnInvoiceModifier.AddItem('SCFileManager',,, Access:%SHIShippingCostFile)
    #ENDIF
    #IF(%SHIShippingCostFileKey <> '')
%ShippingOnInvoiceModifier.AddItem('SCKey',,,, %SHIShippingCostFileKey)
    #ENDIF
    #IF(%SHIMinQuantityField <> '')
%ShippingOnInvoiceModifier.AddItem('SCMinQuantityField', %SHIMinQuantityField)
    #ENDIF
    #IF(%SHIMinSpentField <> '')
%ShippingOnInvoiceModifier.AddItem('SCMinSpentField', %SHIMinSpentField)
    #ENDIF
    #IF(%SHIShippingField <> '')
%ShippingOnInvoiceModifier.AddItem('SCShippingField', %SHIShippingField)
    #ENDIF
    #IF(%SHIIsPercentageField <> '')
%ShippingOnInvoiceModifier.AddItem('SCIsPercentageField', %SHIIsPercentageField)
    #ENDIF
    #IF(%SHIDestinationField <> '')
%ShippingOnInvoiceModifier.AddItem('SCDestinationCodeField', %SHIDestinationField)
    #ENDIF
    #IF(%SHIFixedShippingPerItem= %TRUE)
%ShippingOnInvoiceModifier.AddItem('PerItemFixedShipping',, %SHIFixedShipping)
    #ENDIF
    #IF(%SHIPercentageShippingPerItem = %TRUE)
%ShippingOnInvoiceModifier.AddItem('PerItemPercentageShipping',, %SHIPercentageShipping)
    #ENDIF
    #IF(%SHIDestinationExpression <> '')
%ShippingOnInvoiceModifier.AddItem('DestinationExpression',, %(%StripPling(%SHIDestinationExpression)))
    #ENDIF
    #IF(%ProductWeightField <> '')
%ShippingOnInvoiceModifier.AddItem('PWeightField', %ProductWeightField)
    #ENDIF
    #IF(%SHIShippingWeightFile <> '')
%ShippingOnInvoiceModifier.AddItem('SWFileManager',,, Access:%SHIShippingWeightFile)
    #ENDIF
    #IF(%SHIShippingWeightFileKey <> '')
%ShippingOnInvoiceModifier.AddItem('SWKey',,,, %SHIShippingWeightFileKey)
    #ENDIF
    #IF(%SHIMinWeightField <> '')
%ShippingOnInvoiceModifier.AddItem('SWMinWeightField', %SHIMinWeightField)
    #ENDIF
    #IF(%SHIWeightShippingField <> '')
%ShippingOnInvoiceModifier.AddItem('SWFixedWeightShippingField', %SHIWeightShippingField)
    #ENDIF
    #IF(%SHIWeightDestinationField <> '')
%ShippingOnInvoiceModifier.AddItem('SWDestinationCodeField', %SHIWeightDestinationField)
    #ENDIF
    #IF(%SHIEntryWeightShipping= %TRUE)
%ShippingOnInvoiceModifier.AddItem('FixedWeightShipping',, %SHIShippingByWeight)
    #ENDIF
    #IF(%EntryOneOffShipping= %TRUE)
%ShippingOnInvoiceModifier.AddItem('OneOffFixedShipping',, %OneOffShipping)
    #ENDIF
    #IF(%OverRide = %TRUE)
%ShippingOnInvoiceModifier.AddItem('OverRide',,%TRUE)
    #ENDIF
    #IF(%CreditDescription <> '')
%ShippingOnInvoiceModifier.AddItem('OverRideDescription',, %(%StripPling(%CreditDescription)))
    #ENDIF
%ShippingOnInvoiceModifier.AddItem('EndResult',,%(%StripPling(%SHICalculateResult)))
%InvoiceCopier.AddItem(%ShippingOnInvoiceModifier, %SHIInvokeAt)
  #ENDIF
#!
#!
  #IF(%HasCategoryDiscountModifier=%TRUE)
%CategoryDiscountModifier.AddItem('FileManagerCat',,,Access:%CategoryFile)
%CategoryDiscountModifier.AddItem('CatKey',,,,%CategoryFileKey)
%CategoryDiscountModifier.AddItem('CatCategory',%CategoryIDField)
    #IF(%CategoryNameField<> '')
%CategoryDiscountModifier.AddItem('CatCategoryName',%CategoryNameField)
    #ENDIF
    #IF(%CDateLowField<> '')
%CategoryDiscountModifier.AddItem('CatDateLow',%CDateLowField)
    #ENDIF
    #IF(%CDateHighField<> '')
%CategoryDiscountModifier.AddItem('CatDateHigh',%CDateHighField)
    #ENDIF
%CategoryDiscountModifier.AddItem('CatDiscountRate',%DiscountField)
    #IF(%SuperSedesField <> '')
%CategoryDiscountModifier.AddItem('CatSupersedes',%SupersedesField)
    #ENDIF
%CategoryDiscountModifier.AddItem('FileManagerProdCat',,,Access:%ProdCatFile)
%CategoryDiscountModifier.AddItem('ProdCatKey',,,,%ProdCatKey)
%CategoryDiscountModifier.AddItem('PCCategory',%ProdCatCatField)
%CategoryDiscountModifier.AddItem('PCProductID',%ProdCatProdField)
    #IF(%CExtraLine = %TRUE)
%CategoryDiscountModifier.AddItem('ExtraLine',,TRUE)
    #ENDIF
    #IF(%CDescription <> '')
%CategoryDiscountModifier.AddItem('Description',,%(%StripPling(%CDescription)))
    #ENDIF
%InvoiceCopier.AddItem(%CategoryDiscountModifier, %CInvokeAt)
  #ENDIF
#!
#!
  #IF(%HasGiftWrapModifier)
%GiftWrapModifier.AddItem('CartLineOptionID',%CartLineOptionIDField)
%GiftWrapModifier.AddItem('FileManager',,,Access:%OptionsFile)
%GiftWrapModifier.AddItem('FileKey',,,,%OptionsFileKey)
%GiftWrapModifier.AddItem('OptionID',%OptionIDField)
    #IF(%GProductIDField<> '')
%GiftWrapModifier.AddItem('ProductID',%GProductIDField)
    #ENDIF
    #IF(%GDescriptionField<> '')
%GiftWrapModifier.AddItem('Description',%GDescriptionField)
    #ENDIF
%GiftWrapModifier.AddItem('Cost',%CostField)
    #IF(%IsPercentageField <> '')
%GiftWrapModifier.AddItem('IsPercentage',%IsPercentageField)
    #ENDIF
    #IF(%ProductNotFound = 'Search for empty Product ID')
%GiftWrapModifier.AddItem('UseGenericProdID',,TRUE)
    #ENDIF
    #IF(%GExtraLine = %TRUE)
%GiftWrapModifier.AddItem('ExtraLine',,TRUE)
    #ENDIF
%InvoiceCopier.AddItem(%GiftWrapModifier, %GInvokeAt)
  #ENDIF
#!
#!
#ENDAT
#AT(%InvoiceCopierMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%SalesTaxModifierMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%QuantityDiscountModifierMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%ShippingOnInvoiceLineModifierMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%ShippingOnInvoiceModifierMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%CategoryDiscountModifierMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%GiftWrapModifierMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#!
#!
#AT(%LocalProcedures)
  #CALL(%GenerateVirtuals(ABC), 'InvoiceCopier', 'Local Objects|Shopping Trolley Objects|Invoice Copier', '%InvoiceCopierVirtuals(ShoppingTrolley)')
  #CALL(%GenerateVirtuals(ABC), 'SalesTaxModifier', 'Local Objects|Shopping Trolley Objects|Sales Tax Modifier', '%SalesTaxModifierVirtuals(ShoppingTrolley)')
  #CALL(%GenerateVirtuals(ABC), 'QuantityDiscountModifier', 'Local Objects|Shopping Trolley Objects|Quantity Dicount Modifier', '%QuantityDiscountModifierVirtuals(ShoppingTrolley)')
  #CALL(%GenerateVirtuals(ABC), 'ShippingOnInvoiceLineModifier', 'Local Objects|Shopping Trolley Objects|Shipping On Invoice Line Modifier', '%ShippingOnInvoiceLineModifierVirtuals(ShoppingTrolley)')
  #CALL(%GenerateVirtuals(ABC), 'ShippingOnInvoiceModifier', 'Local Objects|Shopping Trolley Objects|Shipping On Invoice Modifier', '%ShippingOnInvoiceModifierVirtuals(ShoppingTrolley)')
  #CALL(%GenerateVirtuals(ABC), 'CategoryDiscountModifier', 'Local Objects|Shopping Trolley Objects|Category Discount Modifier', '%CategoryDiscountModifierVirtuals(ShoppingTrolley)')
  #CALL(%GenerateVirtuals(ABC), 'GiftWrapModifier', 'Local Objects|Shopping Trolley Obejcts|Gift Wrap Modifier', '%GiftWrapModifierVirtuals(ShoppingTrolley)')
#ENDAT
#!
#!
#AT(%LocalDataClasses)
#INSERT(%GenerateClass(ABC), 'InvoiceCopier')
#INSERT(%GenerateClass(ABC), 'SalesTaxModifier')
#INSERT(%GenerateClass(ABC), 'QuantityDiscountModifier')
#INSERT(%GenerateClass(ABC), 'ShippingOnInvoiceLineModifier')
#INSERT(%GenerateClass(ABC), 'ShippingOnInvoiceModifier')
#INSERT(%GenerateClass(ABC), 'CategoryDiscountModifier')
#INSERT(%GenerateClass(ABC), 'GiftWrapModifier')
#ENDAT
#!
#!
#GROUP(%InvoiceCopierVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%InvoiceCopierMethodDataSection,'Invoice Copier Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(%FixClassName(%FixBaseClassToUse('InvoiceCopier'))),TREE(%TreeText & %Datatext)
  #?CODE
  #EMBED(%InvoiceCopierMethodCodeSection,'Invoice Copier Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(%FixClassName(%FixBaseClassToUse('InvoiceCopier'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%SalesTaxModifierVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%SalesTaxModifierMethodDataSection,'Sales Tax Modifier Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(%FixClassName(%FixBaseClassToUse('SalesTaxModifier'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%SalesTaxModifierMethodCodeSection,'Sales Tax Modifier Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(%FixClassName(%FixBaseClassToUse('SalesTaxModifier'))),TREE(%TreeText % %CodeText)
#!
#!
#GROUP(%QuantityDiscountModifierVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%QuantityDiscountModifierMethodDataSection,'Quantity Discount Modifier Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(%FixClassName(%FixBaseClassToUse('QuantityDiscountModifier'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%QuantityDiscountModifierMethodCodeSection,'Quantity Discount Modifier Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(%FixClassName(%FixBaseClassToUse('QuantityDiscountModifier'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%ShippingOnInvoiceLineModifierVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%ShippingOnInvoiceLineModifierMethodDataSection,'Shipping On Invoice Line Modifier Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(%FixClassName(%FixBaseClassToUse('ShippingOnInvoiceLineModifier'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%ShippingOnInvoiceLineModifierMethodCodeSection,'Shipping On Invoice Line Modifier Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(%FixClassName(%FixBaseClassToUse('ShippingOnInvoiceLineModifier'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%ShippingOnInvoiceModifierVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%ShippingOnInvoiceModifierMethodDataSection,'Shipping On Invoice Modifier Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(%FixClassName(%FixBaseClassToUse('ShippingOnInvoiceModifier'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%ShippingOnInvoiceModifierMethodCodeSection,'Shipping On Invoice Modifier Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(%FixClassName(%FixBaseClassToUse('ShippingOnInvoiceModifier'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%CategoryDiscountModifierVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%CategoryDiscountModifierMethodDataSection,'Category Discount Modifier Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(%FixClassName(%FixBaseClassToUse('CategoryDiscountModifier'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%CategoryDiscountModifierMethodCodeSection,'Category Discount Modifier Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(%FixClassName(%FixBaseClassToUse('CategoryDiscountModifier'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%GiftWrapModifierVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%GiftWrapModifierMethodDataSection,'Gift Wrap Modifier Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(%FixClassName(%FixBaseClassToUse('GiftWrapModifier'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%GiftWrapModifierMethodCodeSection,'Gift Wrap Modifier Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(%FixClassName(%FixBaseClassToUse('GiftWrapModifier'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%AddToView, %ToAdd),AUTO
  #IF(%ToAdd <> '')
    #FOR(%HotFields)
      #IF(UPPER(%HotField) = UPPER(%ToAdd))
        #RETURN
      #ENDIF
    #ENDFOR
    #ADD(%HotFields, ITEMS(%HotFields) + 1)
    #SET(%HotField, %ToAdd)
  #ENDIF
#!
#!
#!
#!
#!
#!
#!
#!
#GROUP(%IsProcessProcedure)
  #RETURN(CHOOSE(UPPER(%ProcedureTemplate) = 'PROCESS', %True, %False))
#!
#!
#!
#!
#! ---- The following groups allow unqualified calls into the mail ABC chain ----
#!
#!
#!
#!
#GROUP(%MethodEmbedPointValid, %MustBeVirtual = %True),AUTO
  #DECLARE(%RVal)
  #CALL(%MethodEmbedPointValid(ABC), %MustBeVirtual),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%ParentCallValid),AUTO
  #DECLARE(%RVal)
  #CALL(%ParentCallValid(ABC)),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%BaseClassToUse),AUTO
  #DECLARE(%RVal)
  #CALL(%BaseClassToUse(ABC)),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%FixBaseClassToUse, %FixTo),AUTO
  #DECLARE(%Rval)
  #CALL(%FixBaseClassToUse(ABC), %FixTo),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%FixClassName, %ToUse),AUTO
  #DECLARE(%Rval)
  #CALL(%FixClassName(ABC), %ToUse),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%GetEmbedTreeDesc,%EmbedType,%ProcedureSection,%AdditionalLevels=''),AUTO
  #DECLARE(%RVal)
  #CALL(%GetEmbedTreeDesc(ABC), %EmbedType, %ProcedureSection, %AdditionalLevels),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%StripPling, %i),AUTO
  #DECLARE(%RVal)
  #CALL(%StripPling(ABC), %i),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%FindLocalTemplateInstance, %LookFor)
  #DECLARE(%RVal)
  #CALL(%FindLocalTemplateInstance(ABC), %LookFor),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%HasReservation),AUTO
  #DECLARE(%TplInstance)
  #CALL(%FindLocalTemplateInstance, 'Reservation(ShoppingTrolley)'),%TplInstance
  #IF(%TplInstance > 0)
    #ALIAS(%CheckReservation, %UseReservation, %TplInstance)
    #RETURN(%CheckReservation)
  #ELSE
    #RETURN(%FALSE)
  #ENDIF
#!
#!
#EXTENSION(LimitBrowseToCustomer, 'Limit Browse To Customer Extension Template'),PROCEDURE,REQ(BrowseBox(ABC)),HLP('~LimitBrowseToCustomer')
#!
#RESTRICT
  #FOR(%ApplicationTemplate),WHERE(%ApplicationTemplate = 'WebGuard(Web)')
    #FOR(%ApplicationTemplateInstance)
      #IF(%GuardEnabled = %True)
        #ACCEPT
      #ELSE
        #REJECT
      #ENDIF
    #ENDFOR
  #ENDFOR
  #REJECT
#ENDRESTRICT
#!
#PREPARE
  #CALL(%ReadABCFiles(ABC))
#ENDPREPARE
#!
#SHEET, HSCROLL
  #TAB('&Filtering'),HLP('~LimitBrowseToCustomer_Filtering')
    #PROMPT('&Customer ID Field:', FIELD),%CustomerIDField,REQ
  #ENDTAB
#ENDSHEET
#!
#AT(%LocalDataAfterClasses),DESCRIPTION('Record filter variable')
  #IF(%CustomerIDField <> '')
FilterVariable LIKE(%CustomerIDField)
  #ENDIF
#ENDAT
#!
#ATSTART
  #CALL(%ReadABCFiles(ABC))
#ENDAT
#!
#AT(%BrowserMethodCodeSection,%ActiveTemplateParentInstance,'Init','(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)'),WHERE(%GuardEnabled),PRIORITY(7800)
  #IF(%CustomerIDField <> '')
BIND('FilterVariable',FilterVariable)
FilterVariable = Guard.GetCurrent()
  #ENDIF
#ENDAT
#!
#!
#AT(%BrowserMethodCodeSection, 'Kill', '(),BYTE'),PRIORITY(7000)
UNBIND('FilterVariable')
#ENDAT
#!
#!
#AT(%AppendFilterExpression,%ActiveTemplateParentInstance),WHERE(%GuardEnabled AND %CustomerIDField <> '')
  #IF (%BrowseFilterStatement)
    #SET(%FilterExpression, %BrowseFilterStatement&' AND '&%CustomerIDField&'=FilterVariable' )
  #ELSE
    #SET(%FilterExpression, %CustomerIDField&'=FilterVariable' )
  #ENDIF
#ENDAT
#!
#!
#EXTENSION(Reservation, 'Reservation Class Extension'),PROCEDURE,SINGLE,HLP('~Reservation'),REQ(ShoppingTrolley(ShoppingTrolley))
#!
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'Reservation', 'Reservation', %ReservationClass)
#END
#INSERT(%OOPPrompts(ABC))
#TAB('&Reservation System')
  #PROMPT('&Use Reservation System', CHECK),%UseReservation,DEFAULT(%FALSE),AT(10)
  #ENABLE(%UseReservation = %TRUE)
    #BOXED('Reservation File')
      #PROMPT('Reser&vation File:',FILE),%ReservationFile,REQ
      #ENABLE(%ReservationFile <> ''),CLEAR
        #PROMPT('Reservation Ke&y:',KEY(%ReservationFile)),%ReservationKey,REQ
        #PROMPT('Reservation Num&ber Field:', FIELD(%ReservationFile)),%RReservationField,REQ
        #PROMPT('Pr&oduct ID Field:', FIELD(%ReservationFile)),%RProductIDField,REQ
        #PROMPT('Custo&mer ID Field:',FIELD(%ReservationFile)),%RCustomerIDField,REQ
        #PROMPT('&Enum Field:',FIELD(%ReservationFile)),%REnumField
      #ENDENABLE
    #ENDBOXED
    #BOXED('Product File')
      #PROMPT('&Product File:',FILE),%ProductFile,REQ
      #ENABLE(%ProductFile <> ''),CLEAR
        #PROMPT('Product &Key:',KEY(%ProductFile)),%ProductKey,REQ
        #PROMPT('Product &ID Field:', FIELD(%ProductFile)),%PIDField,REQ
        #PROMPT('&Capacity Field:', FIELD(%ProductFile)),%PCapacityField,REQ
        #PROMPT('Reservation &Status Field:', FIELD(%ProductFile)),%PStatusField,REQ
        #PROMPT('&Availability Field:',FIELD(%ProductFile)),%PAvailabilityField
      #ENDENABLE
    #ENDBOXED
  #ENDENABLE
#ENDTAB
#TAB('&Classes')
  #ENABLE(%UseReservation)
    #BUTTON('&Reservation System'),AT(,,170)
      #WITH(%ClassItem, 'Reservation')
        #INSERT(%ClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
  #ENDENABLE
#ENDTAB
#!
#ATSTART
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'Reservation', 'Reservation', %ReservationClass)
  #FIX(%ClassItem, 'Reservation')
  #EQUATE(%Reservation, %ThisObjectName)
#ENDAT
#!
#!
#AT(%GatherObjects)
  #CALL(%AddObjectList(ABC), 'Reservation')
#ENDAT
#!
#!
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(8600),DESCRIPTION('Initialize Reservation')
  #IF(%UseReservation)
%Reservation.Init(Access:%ProductFile,Access:%ReservationFile,%ProductKey,%PIDFIeld,%PCapacityField,%PStatusField,%PAvailabilityField,%ReservationKey,%RProductIDField,%REnumField,%RCustomerIDField,%RReservationField,GlobalErrors)
  #ENDIF
#ENDAT
#!
#!
#AT(%WindowManagerMethodCodeSection,'Kill','(),BYTE'),PRIORITY(5500),DESCRIPTION('Kill Reservation')
  #IF(%UseReservation)
%Reservation.Kill
  #ENDIF
#ENDAT
#!
#!
#AT(%ReservationMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%LocalProcedures)
  #CALL(%GenerateVirtuals(ABC), 'Reservation', 'Local Objects|Shopping Trolley Objects|Reservation', '%ReservationVirtuals(ShoppingTrolley)')
#ENDAT
#!
#!
#AT(%LocalDataClasses)
  #IF(%UseReservation)
#INSERT(%GenerateClass(ABC), 'Reservation')
  #ENDIF
#ENDAT
#!
#!
#GROUP(%ReservationVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%ReservationMethodDataSection,'Reservation Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(%FixClassName(%FixBaseClassToUse('Reservation'))),TREE(%TreeText & %Datatext)
  #?CODE
  #EMBED(%ReservationMethodCodeSection,'Reservation Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(%FixClassName(%FixBaseClassToUse('Reservation'))),TREE(%TreeText & %CodeText)
#!
#!
