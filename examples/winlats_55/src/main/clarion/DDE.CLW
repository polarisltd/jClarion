! DDE.CLW
! CW DDE support map definitions

  MODULE('CWDDE')
      DDEclient(<string>,<string>), ULONG, NAME('Cla$DDEclient')
      DDEserver(<string>,<string>), ULONG, NAME('Cla$DDEserver')
      DDEclose(ULONG), NAME('Cla$DDEclose')
      DDEread(ULONG, UNSIGNED, STRING, <*?>), NAME('Cla$DDEread')
      DDEwrite(ULONG, UNSIGNED, STRING, <*?>), NAME('Cla$DDEwrite')
      DDEpoke(ULONG, STRING, STRING), NAME('Cla$DDEpoke')
      DDEexecute(ULONG, STRING), NAME('Cla$DDEexecute')
      DDEquery(<STRING>,<STRING>), STRING, NAME('Cla$DDEquery')
      DDEchannel(),ULONG,NAME('Cla$DDEchannel')
      DDEitem(),STRING,NAME('Cla$DDEitem')
      DDEapp(),STRING,NAME('Cla$DDEapp')
      DDEtopic(),STRING,NAME('Cla$DDEtopic')
      DDEvalue(),STRING,NAME('Cla$DDEvalue')
      DDEacknowledge(SIGNED),NAME('Cla$DDEacknowledge')
  .

