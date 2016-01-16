#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#APPLICATION
#insert(%func1,'flat')
  #insert(%func1,'indented')
#GROUP(%func1,%arg)
output %arg %(%outputindent)
#insert(%func2,'flat')
  #insert(%func2,'indented again')
  #insert(%func2,'with noindent'),noindent
  #call(%func2,'flat')
#GROUP(%func2,%arg)
nested output %arg %(%outputindent)