  MODULE('INVOI002.CLW')
PrintInvoiceFromBrowse PROCEDURE                      !Prints Invoice for each order
BrowseOrders           PROCEDURE                      !Browse the Orders File
BrowseCustomers        PROCEDURE                      !Browse the Customers File with "Filter Locator"
CityStateZip           FUNCTION(<String>,<String>,<String>),String !Function to return CSZ
PrintSelectedCustomer  PROCEDURE                      !Report the Customers File
PrintSelectedProduct   PROCEDURE                      !Report the Products File
BrowseProducts         PROCEDURE                      !Browse Products File (Edit-In-Place and calls Update form)
  END
