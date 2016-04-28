package clarion.aberror;

import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Defaulterrors extends ClarionGroup
{
	public ClarionNumber number=Clarion.newNumber(44).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_1=Clarion.newNumber(Msg.REBUILDKEY).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_2=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_3=Clarion.newString("Invalid Key").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_4=Clarion.newString("%File key file is invalid. Key must be rebuilt.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_5=Clarion.newNumber(Msg.REBUILDFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_6=Clarion.newNumber(Level.FATAL).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_7=Clarion.newString("Key was not built").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_8=Clarion.newString("Error: (%ErrorText) repairing key for %File.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_9=Clarion.newNumber(Msg.CREATEFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_10=Clarion.newNumber(Level.FATAL).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_11=Clarion.newString("File Creation Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_12=Clarion.newString("Error: (%ErrorText) creating %File.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_13=Clarion.newNumber(Msg.PROCEDURETODO).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_14=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_15=Clarion.newString("Procedure not defined").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_16=Clarion.newString("The Procedure %Message has not been defined.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_17=Clarion.newNumber(Msg.FIELDOUTOFRANGEHIGH).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_18=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_19=Clarion.newString("Range Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_20=Clarion.newString("The value of %Field must be lower than %Message.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_21=Clarion.newNumber(Msg.FIELDOUTOFRANGELOW).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_22=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_23=Clarion.newString("Range Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_24=Clarion.newString("The value of %Field must be higher than %Message.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_25=Clarion.newNumber(Msg.FIELDOUTOFRANGE).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_26=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_27=Clarion.newString("Range Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_28=Clarion.newString("The value of %Field must be in range %Message.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_29=Clarion.newNumber(Msg.FIELDNOTINFILE).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_30=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_31=Clarion.newString("Field contents error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_32=Clarion.newString("The value of %Field must be found in the %Message file.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_33=Clarion.newNumber(Msg.RESTRICTUPDATE).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_34=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_35=Clarion.newString("Referential Integrity Update Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_36=Clarion.newString("This record is referenced from the file %File. Linking field(s) have been restricted from change and have been reset to original values.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_37=Clarion.newNumber(Msg.RESTRICTDELETE).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_38=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_39=Clarion.newString("Referential Integrity Delete Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_40=Clarion.newString("This record is referenced from the file %File. This record cannot be deleted while these references exist.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_41=Clarion.newNumber(Msg.ADDFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_42=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_43=Clarion.newString("Record Insert Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_44=Clarion.newString("An error was experienced during the creation of a record. Error: %ErrorText.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_45=Clarion.newNumber(Msg.CONCURRENCYFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_46=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_47=Clarion.newString("Record Was Not Updated").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_48=Clarion.newString("This record was changed by another station.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_49=Clarion.newNumber(Msg.CONCURRENCYFAILEDFROMFORM).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_50=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_51=Clarion.newString("Record Was Not Updated").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_52=Clarion.newString("This record was changed by another station. Those changes will now be displayed. Use the Ditto Button or Ctrl+' to recall your changes.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_53=Clarion.newNumber(Msg.RETRYSAVE).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_54=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_55=Clarion.newString("Record Update Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_56=Clarion.newString("An error was experienced changing this record. Do you want to try to save again?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_57=Clarion.newNumber(Msg.RETRYDELETE).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_58=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_59=Clarion.newString("Record Delete Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_60=Clarion.newString("An error was experienced deleting this record. Do you want to try to delete it again?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_61=Clarion.newNumber(Msg.INSERTILLEGAL).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_62=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_63=Clarion.newString("Invalid Request").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_64=Clarion.newString("This form cannot be used to insert a record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_65=Clarion.newNumber(Msg.UPDATEILLEGAL).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_66=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_67=Clarion.newString("Invalid Request").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_68=Clarion.newString("This form cannot be used to update a record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_69=Clarion.newNumber(Msg.DELETEILLEGAL).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_70=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_71=Clarion.newString("Invalid Request").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_72=Clarion.newString("This form cannot be used to delete a record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_73=Clarion.newNumber(Msg.CONFIRMCANCEL).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_74=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_75=Clarion.newString("Changes will be lost!").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_76=Clarion.newString("Are you sure you want to cancel?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_77=Clarion.newNumber(Msg.DUPLICATEKEY).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_78=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_79=Clarion.newString("Duplicate Key Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_80=Clarion.newString("Adding this record creates a duplicate entry for the key: %Message").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_81=Clarion.newNumber(Msg.RETRYAUTOINC).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_82=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_83=Clarion.newString("Auto Increment Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_84=Clarion.newString("Attempts to automatically number this record have failed.  Error: %ErrorText. Try Again?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_85=Clarion.newNumber(Msg.FILELOADFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_86=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_87=Clarion.newString("File Load Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_88=Clarion.newString("%File File Load Error.  Error: %ErrorText.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_89=Clarion.newNumber(Msg.SEARCHREACHEDBEGINNING).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_90=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_91=Clarion.newString("Beginning of File Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_92=Clarion.newString("The beginning of the file was encountered. Do you want to start again from the end of the file?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_93=Clarion.newNumber(Msg.SEARCHREACHEDEND).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_94=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_95=Clarion.newString("End of File Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_96=Clarion.newString("The end of the file was encountered. Do you want to start again from the beginning?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_97=Clarion.newNumber(Msg.OPENFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_98=Clarion.newNumber(Level.FATAL).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_99=Clarion.newString("File Access Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_100=Clarion.newString("File (%File) could not be opened.  Error: %ErrorText.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_101=Clarion.newNumber(Msg.PUTFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_102=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_103=Clarion.newString("Record was not updated").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_104=Clarion.newString("An error (%ErrorText) was experienced when making changes to the %File file.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_105=Clarion.newNumber(Msg.DELETEFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_106=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_107=Clarion.newString("Record was not deleted").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_108=Clarion.newString("An error (%ErrorText) was experienced when deleting a record from the %File file.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_109=Clarion.newNumber(Msg.CONFIRMDELETE).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_110=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_111=Clarion.newString("Confirm Delete").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_112=Clarion.newString("Are you sure you want to delete the highlighted record?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_113=Clarion.newNumber(Msg.SAVERECORD).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_114=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_115=Clarion.newString("Save Record").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_116=Clarion.newString("Do you want to save the changes to this record?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_117=Clarion.newNumber(Msg.LOGOUTFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_118=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_119=Clarion.newString("Transaction cancelled").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_120=Clarion.newString("Error: (%ErrorText) attempting to frame the transaction on %File.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_121=Clarion.newNumber(Msg.ABORTREADING).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_122=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_123=Clarion.newString("Record Retrieval Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_124=Clarion.newString("Error: (%ErrorText) attempting to access a record from the %File file.  Returning to previous window.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_125=Clarion.newNumber(Msg.VIEWOPENFAILED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_126=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_127=Clarion.newString("View Open Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_128=Clarion.newString("Error: (%ErrorText) attempting to open the current VIEW. Filter and Range Limits ignored.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_129=Clarion.newNumber(Msg.ADDANOTHER).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_130=Clarion.newNumber(Level.USER).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_131=Clarion.newString("Record Added").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_132=Clarion.newString("This record has been added to the file. Do you want to add another record?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_133=Clarion.newNumber(Msg.RECORDHELD).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_134=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_135=Clarion.newString("Record not read").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_136=Clarion.newString("A record held by another station was encountered reading from the %File file.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_137=Clarion.newNumber(Msg.ADDNEWRECORD).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_138=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_139=Clarion.newString("Add New Record?").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_140=Clarion.newString("Record match not found, do you wish to add a new one?").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_141=Clarion.newNumber(Msg.FIELDNOTINLIST).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_142=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_143=Clarion.newString("Value Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_144=Clarion.newString("The value of %Field must be in the list : %Message.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_145=Clarion.newNumber(Msg.NORECORDS).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_146=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_147=Clarion.newString("No Records").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_148=Clarion.newString("There are no records available to process.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_149=Clarion.newNumber(Msg.ACCESSDENIED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_150=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_151=Clarion.newString("Access Denied").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_152=Clarion.newString("Could not get write access to %File so trying read-only.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_153=Clarion.newNumber(Msg.USECLOSEDFILE).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_154=Clarion.newNumber(Level.PROGRAM).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_155=Clarion.newString("File Usage Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_156=Clarion.newString("Attempt to use file (%File) before it was opened").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_157=Clarion.newNumber(Msg.RECORDLIMIT).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_158=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_159=Clarion.newString("Record Limit Exceeded").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_160=Clarion.newString("Evaluation edition will not allow write-access to file %File. It will be opened for reading only.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_161=Clarion.newNumber(Msg.QBECOLUMNNOTSUPPORTED).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_162=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_163=Clarion.newString("Unsupported QBE Column").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_164=Clarion.newString("The saved QBE column, %Field is not supported. It will be dropped from the query.").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_165=Clarion.newNumber(Msg.SMTPERROR).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_166=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_167=Clarion.newString("SMTP Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_168=Clarion.newString("The following SMTP Error occurred: %Message ").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_169=Clarion.newNumber(Msg.NNTPERROR).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_170=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_171=Clarion.newString("NNTP Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_172=Clarion.newString("%Message ").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_173=Clarion.newNumber(Msg.WINSOCKERROR).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber _anon_174=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_175=Clarion.newString("Winsock Error").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_176=Clarion.newString("%Message ").setEncoding(ClarionString.PSTRING);

	public Defaulterrors()
	{
		this.addVariable("Number",this.number);
		this.addVariable("_anon_1",this._anon_1);
		this.addVariable("_anon_2",this._anon_2);
		this.addVariable("_anon_3",this._anon_3);
		this.addVariable("_anon_4",this._anon_4);
		this.addVariable("_anon_5",this._anon_5);
		this.addVariable("_anon_6",this._anon_6);
		this.addVariable("_anon_7",this._anon_7);
		this.addVariable("_anon_8",this._anon_8);
		this.addVariable("_anon_9",this._anon_9);
		this.addVariable("_anon_10",this._anon_10);
		this.addVariable("_anon_11",this._anon_11);
		this.addVariable("_anon_12",this._anon_12);
		this.addVariable("_anon_13",this._anon_13);
		this.addVariable("_anon_14",this._anon_14);
		this.addVariable("_anon_15",this._anon_15);
		this.addVariable("_anon_16",this._anon_16);
		this.addVariable("_anon_17",this._anon_17);
		this.addVariable("_anon_18",this._anon_18);
		this.addVariable("_anon_19",this._anon_19);
		this.addVariable("_anon_20",this._anon_20);
		this.addVariable("_anon_21",this._anon_21);
		this.addVariable("_anon_22",this._anon_22);
		this.addVariable("_anon_23",this._anon_23);
		this.addVariable("_anon_24",this._anon_24);
		this.addVariable("_anon_25",this._anon_25);
		this.addVariable("_anon_26",this._anon_26);
		this.addVariable("_anon_27",this._anon_27);
		this.addVariable("_anon_28",this._anon_28);
		this.addVariable("_anon_29",this._anon_29);
		this.addVariable("_anon_30",this._anon_30);
		this.addVariable("_anon_31",this._anon_31);
		this.addVariable("_anon_32",this._anon_32);
		this.addVariable("_anon_33",this._anon_33);
		this.addVariable("_anon_34",this._anon_34);
		this.addVariable("_anon_35",this._anon_35);
		this.addVariable("_anon_36",this._anon_36);
		this.addVariable("_anon_37",this._anon_37);
		this.addVariable("_anon_38",this._anon_38);
		this.addVariable("_anon_39",this._anon_39);
		this.addVariable("_anon_40",this._anon_40);
		this.addVariable("_anon_41",this._anon_41);
		this.addVariable("_anon_42",this._anon_42);
		this.addVariable("_anon_43",this._anon_43);
		this.addVariable("_anon_44",this._anon_44);
		this.addVariable("_anon_45",this._anon_45);
		this.addVariable("_anon_46",this._anon_46);
		this.addVariable("_anon_47",this._anon_47);
		this.addVariable("_anon_48",this._anon_48);
		this.addVariable("_anon_49",this._anon_49);
		this.addVariable("_anon_50",this._anon_50);
		this.addVariable("_anon_51",this._anon_51);
		this.addVariable("_anon_52",this._anon_52);
		this.addVariable("_anon_53",this._anon_53);
		this.addVariable("_anon_54",this._anon_54);
		this.addVariable("_anon_55",this._anon_55);
		this.addVariable("_anon_56",this._anon_56);
		this.addVariable("_anon_57",this._anon_57);
		this.addVariable("_anon_58",this._anon_58);
		this.addVariable("_anon_59",this._anon_59);
		this.addVariable("_anon_60",this._anon_60);
		this.addVariable("_anon_61",this._anon_61);
		this.addVariable("_anon_62",this._anon_62);
		this.addVariable("_anon_63",this._anon_63);
		this.addVariable("_anon_64",this._anon_64);
		this.addVariable("_anon_65",this._anon_65);
		this.addVariable("_anon_66",this._anon_66);
		this.addVariable("_anon_67",this._anon_67);
		this.addVariable("_anon_68",this._anon_68);
		this.addVariable("_anon_69",this._anon_69);
		this.addVariable("_anon_70",this._anon_70);
		this.addVariable("_anon_71",this._anon_71);
		this.addVariable("_anon_72",this._anon_72);
		this.addVariable("_anon_73",this._anon_73);
		this.addVariable("_anon_74",this._anon_74);
		this.addVariable("_anon_75",this._anon_75);
		this.addVariable("_anon_76",this._anon_76);
		this.addVariable("_anon_77",this._anon_77);
		this.addVariable("_anon_78",this._anon_78);
		this.addVariable("_anon_79",this._anon_79);
		this.addVariable("_anon_80",this._anon_80);
		this.addVariable("_anon_81",this._anon_81);
		this.addVariable("_anon_82",this._anon_82);
		this.addVariable("_anon_83",this._anon_83);
		this.addVariable("_anon_84",this._anon_84);
		this.addVariable("_anon_85",this._anon_85);
		this.addVariable("_anon_86",this._anon_86);
		this.addVariable("_anon_87",this._anon_87);
		this.addVariable("_anon_88",this._anon_88);
		this.addVariable("_anon_89",this._anon_89);
		this.addVariable("_anon_90",this._anon_90);
		this.addVariable("_anon_91",this._anon_91);
		this.addVariable("_anon_92",this._anon_92);
		this.addVariable("_anon_93",this._anon_93);
		this.addVariable("_anon_94",this._anon_94);
		this.addVariable("_anon_95",this._anon_95);
		this.addVariable("_anon_96",this._anon_96);
		this.addVariable("_anon_97",this._anon_97);
		this.addVariable("_anon_98",this._anon_98);
		this.addVariable("_anon_99",this._anon_99);
		this.addVariable("_anon_100",this._anon_100);
		this.addVariable("_anon_101",this._anon_101);
		this.addVariable("_anon_102",this._anon_102);
		this.addVariable("_anon_103",this._anon_103);
		this.addVariable("_anon_104",this._anon_104);
		this.addVariable("_anon_105",this._anon_105);
		this.addVariable("_anon_106",this._anon_106);
		this.addVariable("_anon_107",this._anon_107);
		this.addVariable("_anon_108",this._anon_108);
		this.addVariable("_anon_109",this._anon_109);
		this.addVariable("_anon_110",this._anon_110);
		this.addVariable("_anon_111",this._anon_111);
		this.addVariable("_anon_112",this._anon_112);
		this.addVariable("_anon_113",this._anon_113);
		this.addVariable("_anon_114",this._anon_114);
		this.addVariable("_anon_115",this._anon_115);
		this.addVariable("_anon_116",this._anon_116);
		this.addVariable("_anon_117",this._anon_117);
		this.addVariable("_anon_118",this._anon_118);
		this.addVariable("_anon_119",this._anon_119);
		this.addVariable("_anon_120",this._anon_120);
		this.addVariable("_anon_121",this._anon_121);
		this.addVariable("_anon_122",this._anon_122);
		this.addVariable("_anon_123",this._anon_123);
		this.addVariable("_anon_124",this._anon_124);
		this.addVariable("_anon_125",this._anon_125);
		this.addVariable("_anon_126",this._anon_126);
		this.addVariable("_anon_127",this._anon_127);
		this.addVariable("_anon_128",this._anon_128);
		this.addVariable("_anon_129",this._anon_129);
		this.addVariable("_anon_130",this._anon_130);
		this.addVariable("_anon_131",this._anon_131);
		this.addVariable("_anon_132",this._anon_132);
		this.addVariable("_anon_133",this._anon_133);
		this.addVariable("_anon_134",this._anon_134);
		this.addVariable("_anon_135",this._anon_135);
		this.addVariable("_anon_136",this._anon_136);
		this.addVariable("_anon_137",this._anon_137);
		this.addVariable("_anon_138",this._anon_138);
		this.addVariable("_anon_139",this._anon_139);
		this.addVariable("_anon_140",this._anon_140);
		this.addVariable("_anon_141",this._anon_141);
		this.addVariable("_anon_142",this._anon_142);
		this.addVariable("_anon_143",this._anon_143);
		this.addVariable("_anon_144",this._anon_144);
		this.addVariable("_anon_145",this._anon_145);
		this.addVariable("_anon_146",this._anon_146);
		this.addVariable("_anon_147",this._anon_147);
		this.addVariable("_anon_148",this._anon_148);
		this.addVariable("_anon_149",this._anon_149);
		this.addVariable("_anon_150",this._anon_150);
		this.addVariable("_anon_151",this._anon_151);
		this.addVariable("_anon_152",this._anon_152);
		this.addVariable("_anon_153",this._anon_153);
		this.addVariable("_anon_154",this._anon_154);
		this.addVariable("_anon_155",this._anon_155);
		this.addVariable("_anon_156",this._anon_156);
		this.addVariable("_anon_157",this._anon_157);
		this.addVariable("_anon_158",this._anon_158);
		this.addVariable("_anon_159",this._anon_159);
		this.addVariable("_anon_160",this._anon_160);
		this.addVariable("_anon_161",this._anon_161);
		this.addVariable("_anon_162",this._anon_162);
		this.addVariable("_anon_163",this._anon_163);
		this.addVariable("_anon_164",this._anon_164);
		this.addVariable("_anon_165",this._anon_165);
		this.addVariable("_anon_166",this._anon_166);
		this.addVariable("_anon_167",this._anon_167);
		this.addVariable("_anon_168",this._anon_168);
		this.addVariable("_anon_169",this._anon_169);
		this.addVariable("_anon_170",this._anon_170);
		this.addVariable("_anon_171",this._anon_171);
		this.addVariable("_anon_172",this._anon_172);
		this.addVariable("_anon_173",this._anon_173);
		this.addVariable("_anon_174",this._anon_174);
		this.addVariable("_anon_175",this._anon_175);
		this.addVariable("_anon_176",this._anon_176);
	}
}