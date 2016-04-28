#!------------------------------------------------------------------------------
#!
#! TEMPLATE: Clarion for Windows Finance Template v4.0
#! 
#!------------------------------------------------------------------------------
#TEMPLATE(Finance,'Clarion for Windows Finance Template v4.0'),FAMILY('ABC')
#HELP('C55BML.HLP')
#!------------------------------------------------------------------------------
#!
#!  Finance Procedure and Function Prototypes:
#!  =========================================
#!  AMORTIZE(REAL,REAL,REAL,USHORT,*DECIMAL,*DECIMAL,*DECIMAL)
#!  APR(REAL,USHORT),REAL
#!  COMPINT(REAL,REAL,USHORT),REAL
#!  CONTINT(REAL,REAL),REAL
#!  DAYS360(LONG,LONG),LONG
#!  FV(REAL,REAL,REAL,REAL),REAL
#!  IRR(REAL,*DECIMAL[],*DECIMAL[],REAL),REAL
#!  NPV(REAL,*DECIMAL[],*DECIMAL[],REAL),REAL
#!  PERS(REAL,REAL,REAL,REAL),REAL
#!  PMT(REAL,REAL,REAL,REAL),REAL
#!  PREFV(REAL,REAL,REAL,REAL),REAL
#!  PREPERS(REAL,REAL,REAL,REAL),REAL
#!  PREPMT(REAL,REAL,REAL,REAL),REAL
#!  PREPV(REAL,REAL,REAL,REAL),REAL
#!  PRERATE(REAL,REAL,REAL,REAL),REAL
#!  PV(REAL,REAL,REAL,REAL),REAL
#!  RATE(REAL,REAL,REAL,REAL),REAL
#!  SIMPINT(REAL,REAL),REAL
#!
#!------------------------------------------------------------------------------
#! Definitions:
#! -----------
#! Annual Interest Rate   = Non-compounded Annual Rate of Interest
#! Periodic Interest Rate = Annual Interest Rate(%) / (Periods Per Year * 100)
#! Applied  Interest Rate = Periodic Interest Rate * Number of Applicable Periods
#!
#!------------------------------------------------------------------------------
#!------------------------------------------------------------------------------
#!
#! EXTENSION: FinanceLibrary - Initialize and Enable Finance Library
#!
#!------------------------------------------------------------------------------
#EXTENSION(FinanceLibrary,'Clarion for Windows Finance Library v2.0'),APPLICATION,HLP('~TPLExtensionFinanceLibrary')
#BOXED(' Clarion for Windows Finance Library v2.0')
  #DISPLAY(' ')
  #DISPLAY('AMORTIZE - Amortize Loan for Number of Payments')
  #DISPLAY('APR             - Annual Percentage Rate')
  #DISPLAY('COMPINT    - Compound Interest')
  #DISPLAY('CONTINT    - Continuous Compounding Interest')
  #DISPLAY('DAYS360    - Days Difference Based on 360-day Year')
  #DISPLAY('FV               - Future Value (w/without Prepayment)')
  #DISPLAY('IRR             - Internal Rate of Return')
  #DISPLAY('NPV            - Net Present Value')
  #DISPLAY('PERS          - Periods of Annuity (w/without Prepayment)')
  #DISPLAY('PMT            - Payment of Annuity (w/without Prepayment)')
  #DISPLAY('PV               - Present Value (w/without Prepayment)')
  #DISPLAY('RATE          - Rate of Annuity (w/without Prepayment)')
  #DISPLAY('SIMPINT    - Simple Interest')
  #DISPLAY(' ')
#ENDBOXED
#AT(%GlobalMap)
INCLUDE('cwfinpro.clw')
#ENDAT
#AT(%CustomGlobalDeclarations)
#PROJECT('busmath.pr')
#ENDAT
#!------------------------------------------------------------------------------
#!
#! GROUP: %ExtractArrayName
#! 
#!------------------------------------------------------------------------------
#GROUP(%ExtractArrayName,%SymbolIn,*%ArrayNameOut)
#DECLARE(%Pos)
#DECLARE(%ErrMsg)
#SET(%Pos,INSTRING('[',%SymbolIn))
#IF(%Pos)
  #SET(%ArrayNameOut,SUB(%SymbolIn,1,(%Pos - 1)))
#ELSE
  #SET(%ArrayNameOut,'')
#ENDIF
#!------------------------------------------------------------------------------
#!
#! GROUP: %DisplayReturnValue
#! 
#!------------------------------------------------------------------------------
#GROUP(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#DECLARE(%SaveControl)
#IF(%DisplayRetVal)
  #SET(%SaveControl,%Control)
  #FIX(%Control,('?' & %RetVal))
  #IF(%Control)
DISPLAY(%Control)
  #ENDIF
  #FIX(%Control,%SaveControl)
#ENDIF
#!
#!------------------------------------------------------------------------------
#!
#! CODE: AMORTIZE - Amortize Loan for Specific Number of Payments
#!
#!------------------------------------------------------------------------------
#CODE(AMORTIZE,'Amortize Loan for Specific Number of Payments'),REQ(FinanceLibrary),HLP('~TPLCodeAMORTIZE')
#BOXED(' Description: ')
  #DISPLAY('AMORTIZE shows precisely which portions of a loan')
  #DISPLAY('payment (Payment) constitute the interest portion')
  #DISPLAY('(Interest) and the portion (Principal) which is applied')
  #DISPLAY('towards repayment of the loan.')
  #DISPLAY('The computed amounts are based upon a loan balance')
  #DISPLAY('(Balance), the periodic interest rate (Rate), and one or')
  #DISPLAY('more number of payments (Total Payments).  The')
  #DISPLAY('remaining balance (Ending Balance) is also calculated.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Balance:',FIELD),%CurrBalance,REQ
  #PROMPT('Rate (Periodic):',FIELD),%Rate,REQ
  #PROMPT('Payment:',FIELD),%Payment,REQ
  #PROMPT('Total Payments:',FIELD),%NumofPayments,REQ
#ENDBOXED
#BOXED(' Return Values: ')
  #PROMPT('Principal:',FIELD),%Principal,REQ
  #PROMPT('Interest:',FIELD),%Interest,REQ
  #PROMPT('Ending Balance:',FIELD),%EndBalance,REQ
  #PROMPT('Display Return Values',CHECK),%DisplayRetVals
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Payment, Principal, and Interest are negative numbers.')
  #DISPLAY('* Rate is the "periodic interest rate".')
#ENDBOXED
#!
#! Generated Code
#!
AMORTIZE(%CurrBalance,%Rate,%Payment,%NumofPayments,%Principal,%Interest,%EndBalance)
#INSERT(%DisplayReturnValue,%DisplayRetVals,%Principal)
#INSERT(%DisplayReturnValue,%DisplayRetVals,%Interest)
#INSERT(%DisplayReturnValue,%DisplayRetVals,%EndBalance)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: APR - Annual Percentage Rate
#!
#!------------------------------------------------------------------------------
#CODE(APR,'Annual Percentage Rate'),REQ(FinanceLibrary),HLP('~TPLCodeAPR')
#BOXED(' Description: ')
  #DISPLAY('APR determines the effective annual rate of interest')
  #DISPLAY('based upon the contracted interest rate (Rate) and the')
  #DISPLAY('number of compounding periods (Periods) per year.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Rate:',FIELD),%Rate,REQ
  #PROMPT('Periods:',FIELD),%Periods,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Annual Percentage Rate:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Rate is the "non-compounded annual interest rate".')
  #DISPLAY('* Periods specifies the "number of compounding periods".')
  #DISPLAY('  For example, Periods = 2 results in semi-annual')
  #DISPLAY('  compounding.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = APR(%Rate,%Periods)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: COMPINT - Compound Interest
#!
#!------------------------------------------------------------------------------
#CODE(COMPINT,'Compound Interest'),REQ(FinanceLibrary),HLP('~TPLCodeCOMPINT')
#BOXED(' Description: ')
  #DISPLAY('COMPINT computes total interest based on the interest')
  #DISPLAY('earned on a principal amount (Principal) and an added')
  #DISPLAY('interest amount computed at the specified intervals')
  #DISPLAY('(Periods).  The applied interest rate (Rate) is specified')
  #DISPLAY('as a parameter.')
  #DISPLAY('The computed amount includes the original principal plus')
  #DISPLAY('the interest earned.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Principle:',FIELD),%Principle,REQ
  #PROMPT('Rate (Applied):',FIELD),%Rate,REQ
  #PROMPT('Periods:',FIELD),%Periods,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Ending Balance:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Rate is the periodic rate times the number of periods.')
  #DISPLAY('* Periods specifies the "number of compounding periods".')
  #DISPLAY('  For example, Periods = 2 results in semi-annual')
  #DISPLAY('  compounding.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = COMPINT(%Principle,%Rate,%Periods)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: CONTINT - Continuous Compounding Interest
#!
#!------------------------------------------------------------------------------
#CODE(CONTINT,'Continuous Compounding Interest'),REQ(FinanceLibrary),HLP('~TPLCodeCONTINT')
#BOXED(' Description: ')
  #DISPLAY('CONTINT computes interest based on a principle amount')
  #DISPLAY('(Principle) and an interest amount added continuously')
  #DISPLAY('computed using the applied interest rate (Rate).')
  #DISPLAY('The computed amount includes the original principal plus')
  #DISPLAY('the interest earned.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Principle:',FIELD),%Principle,REQ
  #PROMPT('Rate (Applied):',FIELD),%Rate,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Ending Balance:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Rate is the periodic rate times the number of periods.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = CONTINT(%Principle,%Rate)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!
#!------------------------------------------------------------------------------
#!
#! CODE: DAYS360 - Days Difference Based on 360-day Year
#!
#!------------------------------------------------------------------------------
#CODE(DAYS360,'Days Difference Based on 360-day Year'),REQ(FinanceLibrary),HLP('~TPLCodeDAYS360')
#BOXED(' Description: ')
  #DISPLAY('DAYS360 determines the number of days difference')
  #DISPLAY('between a beginning date (Start Date) and an')
  #DISPLAY('ending date (End Date), based on a 360-day year.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Start Date:',FIELD),%StartDate,REQ
  #PROMPT('End Date:',FIELD),%EndDate,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Number of Days:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Both date parameters MUST contain Clarion standard')
  #DISPLAY('  date values.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = DAYS360(%StartDate,%EndDate)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: FV - Future Value (with/without Prepayment)
#!
#!------------------------------------------------------------------------------
#CODE(FV,'Future Value (with/without Prepayment)'),REQ(FinanceLibrary),HLP('~TPLCodeFV')
#BOXED(' Description: ')
  #DISPLAY('FV determines the future value of an amount (Present')
  #DISPLAY('Value) based upon the total number of periods (Periods),')
  #DISPLAY('the periodic interest rate (Rate), and a payment amount')
  #DISPLAY('(Payment).')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Present Value:',FIELD),%PresentValue,REQ
  #PROMPT('Periods:',FIELD),%Periods,REQ
  #PROMPT('Rate (Periodic):',FIELD),%Rate,REQ
  #PROMPT('Payment (May be EMPTY):',FIELD),%Payment
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Future Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#ENABLE(%Payment NOT = ''),CLEAR
  #BOXED(' Time of Payments: ')
    #PROMPT('Beginning of Periods',CHECK),%PrePayment
  #ENDBOXED
#ENDENABLE
#BOXED(' Notes: ')
  #DISPLAY('* If the Payment prompt is empty then 0 is assumed.')
  #DISPLAY('* If the Payment prompt is NOT empty and the "Beginning')
  #DISPLAY('  of Periods" box is checked ON then the calculations')
  #DISPLAY('  take into account the added interest earned on each')
  #DISPLAY('  period''s payment using the PREFV function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%Payment AND %PrePayment)
%RetVal = PREFV(%PresentValue,%Periods,%Rate,%Payment)
#ELSIF(%Payment = '')
%RetVal = FV(%PresentValue,%Periods,%Rate,0)
#ELSE
%RetVal = FV(%PresentValue,%Periods,%Rate,%Payment)
#ENDIF
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: IRR - Internal Rate of Return
#!
#!------------------------------------------------------------------------------
#CODE(IRR,'Internal Rate of Return'),REQ(FinanceLibrary),HLP('~TPLCodeIRR')
#DECLARE(%CashFlowsArrayName)
#DECLARE(%PeriodsArrayName)
#BOXED(' Description: ')
  #DISPLAY('IRR determines the rate of return on an investment')
  #DISPLAY('(Investment).  The result is computed by determining')
  #DISPLAY('the rate that equates the present value of future cash')
  #DISPLAY('flows to the cost of the initial investment.')
  #DISPLAY('The (Cash Flows) parameter is an array of money paid')
  #DISPLAY('out and received during the course of the investment.')
  #DISPLAY('The (Periods) parameter is an array which contains the')
  #DISPLAY('period number in which a relative cash flow occurred.')
  #DISPLAY('The desired periodic rate of return (Rate) for the')
  #DISPLAY('investment is also specified.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Investment:',FIELD),%Investment,REQ
  #PROMPT('Cash Flows (ARRAY):',FIELD),%CashFlows,REQ
  #PROMPT('Periods (ARRAY):',FIELD),%Periods,REQ
  #PROMPT('Rate (Periodic):',FIELD),%Rate,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Rate of Return (Periodic):',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Investment should contain a negative number (a cost).')
  #DISPLAY('* Cash Flows and Periods MUST both be DECIMAL arrays')
  #DISPLAY('  of single dimension and equal size.  The first element')
  #DISPLAY('  should be selected (ie. CashFlow[1] ).')
  #DISPLAY('* The last element in the Periods array MUST contain')
  #DISPLAY('  a zero to terminate the IRR analysis.')
#ENDBOXED
#!
#! Generated Code
#!
#INSERT(%ExtractArrayName,%CashFlows,%CashFlowsArrayName)
#INSERT(%ExtractArrayName,%Periods,%PeriodsArrayName)
%RetVal = IRR(%Investment,%CashFlowsArrayName,%PeriodsArrayName,%Rate)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: NPV - Net Present Value
#!
#!------------------------------------------------------------------------------
#CODE(NPV,'Net Present Value'),REQ(FinanceLibrary),HLP('~TPLCodeNPV')
#DECLARE(%CashFlowsArrayName)
#DECLARE(%PeriodsArrayName)
#BOXED(' Description: ')
  #DISPLAY('NPV determines the viability of an investment proposal')
  #DISPLAY('by calculating the present value of future returns,')
  #DISPLAY('discounted at the marginal cost of capital minus the cost')
  #DISPLAY('of the investment (Investment).')
  #DISPLAY('The (Cash Flows) parameter is an array of money paid')
  #DISPLAY('out and received during the course of the investment.')
  #DISPLAY('The (Periods) parameter is an array which contains the')
  #DISPLAY('period number in which a relative cash flow occurred.')
  #DISPLAY('The desired periodic rate of return (Rate) for the')
  #DISPLAY('investment is also specified.')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Investment:',FIELD),%Investment,REQ
  #PROMPT('Cash Flows (ARRAY):',FIELD),%CashFlows,REQ
  #PROMPT('Periods (ARRAY):',FIELD),%Periods,REQ
  #PROMPT('Rate (Periodic):',FIELD),%Rate,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Net Present Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* Investment should contain a negative number (a cost).')
  #DISPLAY('* Cash Flows and Periods MUST both be DECIMAL arrays')
  #DISPLAY('  of single dimension and equal size.  The first element')
  #DISPLAY('  should be selected (ie. CashFlow[1] ).')
  #DISPLAY('* The last element in the Periods array MUST contain')
  #DISPLAY('  a zero to terminate the NPV analysis.')
#ENDBOXED
#!
#! Generated Code
#!
#INSERT(%ExtractArrayName,%CashFlows,%CashFlowsArrayName)
#INSERT(%ExtractArrayName,%Periods,%PeriodsArrayName)
%RetVal = NPV(%Investment,%CashFlowsArrayName,%PeriodsArrayName,%Rate)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: PERS - Periods of Annuity (with/without Prepayment)
#!
#!------------------------------------------------------------------------------
#CODE(PERS,'Periods of Annuity (with/without Prepayment)'),REQ(FinanceLibrary),HLP('~TPLCodePERS')
#BOXED(' Description: ')
  #DISPLAY('PERS determines the number of periods required to reach')
  #DISPLAY('a desired amount (Future Value) based upon a starting')
  #DISPLAY('amount (Present Value), a periodic interest rate (Rate),')
  #DISPLAY('and a payment amount (Payment).')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Present Value:',FIELD),%PresentValue,REQ
  #PROMPT('Rate (Periodic):',FIELD),%Rate,REQ
  #PROMPT('Payment (May be EMPTY):',FIELD),%Payment
  #PROMPT('Future Value:',FIELD),%FutureValue,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Number of Periods:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#ENABLE(%Payment NOT = ''),CLEAR
  #BOXED(' Time of Payments: ')
    #PROMPT('Beginning of Periods',CHECK),%PrePayment
  #ENDBOXED
#ENDENABLE
#BOXED(' Notes: ')
  #DISPLAY('* If the Payment prompt is empty then 0 is assumed.')
  #DISPLAY('* If the Payment prompt is NOT empty and the "Beginning')
  #DISPLAY('  of Periods" box is checked ON then the calculations')
  #DISPLAY('  take into account the added interest earned on each')
  #DISPLAY('  period''s payment using the PREPERS function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%Payment AND %PrePayment)
%RetVal = PREPERS(%PresentValue,%Rate,%Payment,%FutureValue)
#ELSIF(%Payment = '')
%RetVal = PERS(%PresentValue,%Rate,0,%FutureValue)
#ELSE
%RetVal = PERS(%PresentValue,%Rate,%Payment,%FutureValue)
#ENDIF
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: PMT - Payment of Annuity (with/without Prepayment)
#!
#!------------------------------------------------------------------------------
#CODE(PMT,'Payment of Annuity (with/without Prepayment)'),REQ(FinanceLibrary),HLP('~TPLCodePMT')
#BOXED(' Description: ')
  #DISPLAY('PMT determines the payment required to reach a desired')
  #DISPLAY('amount (Future Value) based upon a starting amount')
  #DISPLAY('(Present Value), a total number of periods (Periods),')
  #DISPLAY('and a periodic interest rate (Rate).')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Present Value:',FIELD),%PresentValue,REQ
  #PROMPT('Periods:',FIELD),%Periods,REQ
  #PROMPT('Rate (Periodic):',FIELD),%Rate,REQ
  #PROMPT('Future Value:',FIELD),%FutureValue,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Payment Amount:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Time of Payments: ')
  #PROMPT('Beginning of Periods',CHECK),%PrePayment
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* If the "Beginning of Periods" box is checked ON then')
  #DISPLAY('  the calculations take into account the added interest')
  #DISPLAY('  earned on each period''s payment using the PREPMT')
  #DISPLAY('  function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%PrePayment)
%RetVal = PREPMT(%PresentValue,%Periods,%Rate,%FutureValue)
#ELSE
%RetVal = PMT(%PresentValue,%Periods,%Rate,%FutureValue)
#ENDIF
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: PV - Present Value (with/without Prepayment)
#!
#!------------------------------------------------------------------------------
#CODE(PV,'Present Value (with/without Prepayment)'),REQ(FinanceLibrary),HLP('~TPLCodePV')
#BOXED(' Description: ')
  #DISPLAY('PV determines the present value required today to reach')
  #DISPLAY('a desired amount (Future Value) based upon the total')
  #DISPLAY('number of periods (Periods), a periodic interest rate')
  #DISPLAY('(Rate), and a payment amount (Payment).')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Periods:',FIELD),%Periods,REQ
  #PROMPT('Rate (Periodic):',FIELD),%Rate,REQ
  #PROMPT('Payment (May be EMPTY):',FIELD),%Payment
  #PROMPT('Future Value:',FIELD),%FutureValue,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Present Value:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#ENABLE(%Payment NOT = ''),CLEAR
  #BOXED(' Time of Payments: ')
    #PROMPT('Beginning of Periods',CHECK),%PrePayment
  #ENDBOXED
#ENDENABLE
#BOXED(' Notes: ')
  #DISPLAY('* If the Payment prompt is empty then 0 is assumed.')
  #DISPLAY('* If the Payment prompt is NOT empty and the "Beginning')
  #DISPLAY('  of Periods" box is checked ON then the calculations')
  #DISPLAY('  take into account the added interest earned on each')
  #DISPLAY('  period''s payment using the PREPV function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%Payment AND %PrePayment)
%RetVal = PREPV(%Periods,%Rate,%Payment,%FutureValue)
#ELSIF(%Payment = '')
%RetVal = PV(%Periods,%Rate,0,%FutureValue)
#ELSE
%RetVal = PV(%Periods,%Rate,%Payment,%FutureValue)
#ENDIF
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: RATE - Rate of Annuity (with/without Prepayment)
#!
#!------------------------------------------------------------------------------
#CODE(RATE,'Rate of Annuity (with/without Prepayment)'),REQ(FinanceLibrary),HLP('~TPLCodeRATE')
#BOXED(' Description: ')
  #DISPLAY('RATE determines the periodic interest rate required to')
  #DISPLAY('reach a desired amount (Future Value) based upon a')
  #DISPLAY('starting amount (Present Value), the total number of')
  #DISPLAY('periods (Periods), and a payment amount (Payment).')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Present Value:',FIELD),%PresentValue,REQ
  #PROMPT('Periods:',FIELD),%Periods,REQ
  #PROMPT('Payment (May be EMPTY):',FIELD),%Payment
  #PROMPT('Future Value:',FIELD),%FutureValue,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Interest Rate (Periodic):',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#ENABLE(%Payment NOT = ''),CLEAR
  #BOXED(' Time of Payments: ')
    #PROMPT('Beginning of Periods',CHECK),%PrePayment
  #ENDBOXED
#ENDENABLE
#BOXED(' Notes: ')
  #DISPLAY('* If the Payment prompt is empty then 0 is assumed.')
  #DISPLAY('* If the Payment prompt is NOT empty and the "Beginning')
  #DISPLAY('  of Periods" box is checked ON then the calculations')
  #DISPLAY('  take into account the added interest earned on each')
  #DISPLAY('  period''s payment using the PRERATE function.')
#ENDBOXED
#!
#! Generated Code
#!
#IF(%Payment AND %PrePayment)
%RetVal = PRERATE(%PresentValue,%Periods,%Payment,%FutureValue)
#ELSIF(%Payment = '')
%RetVal = RATE(%PresentValue,%Periods,0,%FutureValue)
#ELSE
%RetVal = RATE(%PresentValue,%Periods,%Payment,%FutureValue)
#ENDIF
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
#!------------------------------------------------------------------------------
#!
#! CODE: SIMPINT - Simple Interest
#!
#!------------------------------------------------------------------------------
#CODE(SIMPINT,'Simple Interest'),REQ(FinanceLibrary),HLP('~TPLCodeSIMPINT')
#BOXED(' Description: ')
  #DISPLAY('SIMPINT determines an "interest amount earned" based')
  #DISPLAY('solely on a given amount (Principal) and the simple')
  #DISPLAY('interest rate (Rate).')
#ENDBOXED
#BOXED(' Input Parameters: ')
  #PROMPT('Principal:',FIELD),%Principal,REQ
  #PROMPT('Rate:',FIELD),%Rate,REQ
#ENDBOXED
#BOXED(' Return Value: ')
  #PROMPT('Simple Interest Amount:',FIELD),%RetVal,REQ
  #PROMPT('Display Return Value',CHECK),%DisplayRetVal
#ENDBOXED
#BOXED(' Notes: ')
  #DISPLAY('* The amount returned ONLY reflects interest earned.')
#ENDBOXED
#!
#! Generated Code
#!
%RetVal = SIMPINT(%Principal,%Rate)
#INSERT(%DisplayReturnValue,%DisplayRetVal,%RetVal)
#!
