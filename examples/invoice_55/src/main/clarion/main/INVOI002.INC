  MODULE('INVOI002.CLW')
UpdateProducts         PROCEDURE                      !Update the Products File
BrowseProducts         PROCEDURE                      !Browse Products File (Edit-In-Place and calls Update form)
AboutAuthor            PROCEDURE                      !Help About
PrintCUS:StateKey      PROCEDURE                      !Report the Customers File
PrintPRO:KeyProductSKU PROCEDURE                      !Report the Products File
PrintInvoice           PROCEDURE                      !Prints Invoice - Using the Pause Control Template
PrintMailingLabels     PROCEDURE                      !Printing mailing labels
SplashScreen           PROCEDURE
PrintSelectedProduct   PROCEDURE                      !Report the Products File
  END
