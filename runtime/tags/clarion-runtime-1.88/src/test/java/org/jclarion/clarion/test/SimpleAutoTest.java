package org.jclarion.clarion.test;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CDate;
public class SimpleAutoTest extends ClarionTestCase
{
	public void setUp()
	{
		setUp("org.jclarion.clarion.test.simpleapp.Main");
	}
	
    public void testDefault() {
        ServerResponse s1;
        s1=assertOpen("login.window",null);
        assertText("login.window","Login");
        assertUse("login.window.acccode","");
        assertUse("login.window.passwd","");
        assertText("login.window.login","Login");
        assertText("login.window.button2","Exit");
        s1.setResult(null);

        assertLazyOpen("login.window");

        post("login.window",Event.SIZED,new Object[] {122,68,0});
        post(Event.SELECTED,"login.window.acccode");
        send("login.window.acccode","ACCEPT","report");
        post(Event.SELECTED,"login.window.login");
        post(Event.ACCEPTED,"login.window.login");

        s1=assertOpen("preview.win","login.window");
        assertText("preview.win","test");
        assertMetaData("login.window","MD_CURRENT_FOCUS","login.window.login");
        s1.setResult(null);

        assertLazyOpen("preview.win");

        post("preview.win",Event.SIZED,new Object[] {200,200,0});

        RegExMatch rem = new RegExMatch("^print:/(\\d+)$");
        assertChange("preview.img",Prop.TEXT,rem);

        s1=sendRecv("CWinImpl","GET_PAGE",rem.getValue());
        assertResult(new Object[] {
         new String[] {"This is a report"}
        ,new String[] {"This is a report"}
        ,new String[] {"This is a report"}},s1);

        post("preview.win",Event.CLOSEWINDOW);

        s1=assertClose("login.window","preview.win");
        s1.setResult(null);

        assertCommand("CWinImpl","RESTORE_WINDOW","login.window");

        post(Event.SELECTED,"login.window.acccode");
        send("login.window.acccode","ACCEPT","staff");
        post(Event.SELECTED,"login.window.login");
        post(Event.ACCEPTED,"login.window.login");

        s1=assertOpen("mainmenu.window","login.window");
        assertText("mainmenu.window","Main Menu");
        assertText("mainmenu.window.spareparts","Spare &Parts");
        assertText("mainmenu.window.workshop","&Workshop");
        assertText("mainmenu.window.units","&Units");
        assertText("mainmenu.window.accounts","&Accounts");
        assertText("mainmenu.window.accounts:2","P&honebook");
        assertText("mainmenu.window.miner","&Miner");
        assertText("mainmenu.window.miner:2","&Business");
        assertText("mainmenu.window.setup","&Setup");
        assertText("mainmenu.window.button2","E&xit");
        assertUse("mainmenu.window.heading","Main Menu - Staff");
        assertUse("mainmenu.window.usr:name_2","Test Application");
        assertUse("mainmenu.window.dtoday",CDate.date(5,18,1979));
        assertMetaData("login.window","MD_CURRENT_FOCUS","login.window.login");
        s1.setResult(null);

        assertLazyOpen("mainmenu.window");

        post(Event.SELECTED,"mainmenu.window.spareparts");
        post("mainmenu.window",Event.SIZED,new Object[] {330,268,0});
        post("mainmenu.window",Event.PREALERTKEY,0,40,0);
        post("mainmenu.window",Event.ALERTKEY,0,40,0);

        assertSelect("mainmenu.window.workshop");

        post(Event.SELECTED,"mainmenu.window.workshop");
        post("mainmenu.window",Event.PREALERTKEY,0,40,0);
        post("mainmenu.window",Event.ALERTKEY,0,40,0);

        assertSelect("mainmenu.window.units");

        post(Event.SELECTED,"mainmenu.window.units");
        post("mainmenu.window",Event.PREALERTKEY,0,40,0);
        post("mainmenu.window",Event.ALERTKEY,0,40,0);

        assertSelect("mainmenu.window.accounts");

        post(Event.SELECTED,"mainmenu.window.accounts");
        post("mainmenu.window",Event.PREALERTKEY,0,40,0);
        post("mainmenu.window",Event.ALERTKEY,0,40,0);

        assertSelect("mainmenu.window.accounts:2");

        post(Event.SELECTED,"mainmenu.window.accounts:2");
        post("mainmenu.window",Event.PREALERTKEY,0,40,0);
        post("mainmenu.window",Event.ALERTKEY,0,40,0);

        assertSelect("mainmenu.window.miner");

        post(Event.SELECTED,"mainmenu.window.miner");
        post("mainmenu.window",Event.PREALERTKEY,0,40,0);
        post("mainmenu.window",Event.ALERTKEY,0,40,0);

        assertSelect("mainmenu.window.miner:2");

        post(Event.SELECTED,"mainmenu.window.miner:2");
        post("mainmenu.window",Event.PREALERTKEY,0,40,0);
        post("mainmenu.window",Event.ALERTKEY,0,40,0);

        assertSelect("mainmenu.window.setup");

        post(Event.SELECTED,"mainmenu.window.setup");
        post(Event.SELECTED,"mainmenu.window.miner");
        post(Event.ACCEPTED,"mainmenu.window.miner");

        assertCommand(".auto_41","SET_TEXT","@n3");
        assertChange(".auto_41",Prop.HIDE,"");
        assertUse(".auto_41",0);

        assertCommand(".auto_42","SET_TEXT","@n3");
        assertChange(".auto_42",Prop.HIDE,"");
        assertUse(".auto_42",1);

        assertCommand(".auto_43","SET_TEXT","@n3");
        assertChange(".auto_43",Prop.HIDE,"");
        assertUse(".auto_43",2);

        assertCommand(".auto_44","SET_TEXT","@n3");
        assertChange(".auto_44",Prop.HIDE,"");
        assertUse(".auto_44",3);

        assertCommand(".auto_45","SET_TEXT","@n3");
        assertChange(".auto_45",Prop.HIDE,"");
        assertUse(".auto_45",4);

        assertCommand(".auto_46","SET_TEXT","@n3");
        assertChange(".auto_46",Prop.HIDE,"");
        assertUse(".auto_46",5);

        assertCommand(".auto_47","SET_TEXT","@n3");
        assertChange(".auto_47",Prop.HIDE,"");
        assertUse(".auto_47",6);

        assertCommand(".auto_48","SET_TEXT","@n3");
        assertChange(".auto_48",Prop.HIDE,"");
        assertUse(".auto_48",7);

        assertCommand(".auto_49","SET_TEXT","@n3");
        assertChange(".auto_49",Prop.HIDE,"");
        assertUse(".auto_49",8);

        assertCommand(".auto_50","SET_TEXT","@n3");
        assertChange(".auto_50",Prop.HIDE,"");
        assertUse(".auto_50",9);

        assertCommand(".auto_51","SET_TEXT","@n3");
        assertChange(".auto_51",Prop.HIDE,"");
        assertUse(".auto_51",10);

        assertCommand(".auto_52","SET_TEXT","@n3");
        assertChange(".auto_52",Prop.HIDE,"");
        assertUse(".auto_52",11);

        assertCommand(".auto_53","SET_TEXT","@n3");
        assertChange(".auto_53",Prop.HIDE,"");
        assertUse(".auto_53",12);

        assertCommand(".auto_54","SET_TEXT","@n3");
        assertChange(".auto_54",Prop.HIDE,"");
        assertUse(".auto_54",13);

        assertCommand(".auto_55","SET_TEXT","@n3");
        assertChange(".auto_55",Prop.HIDE,"");
        assertUse(".auto_55",14);

        assertCommand(".auto_56","SET_TEXT","@n3");
        assertChange(".auto_56",Prop.HIDE,"");
        assertUse(".auto_56",15);

        assertCommand(".auto_57","SET_TEXT","@n3");
        assertChange(".auto_57",Prop.HIDE,"");
        assertUse(".auto_57",16);

        assertCommand(".auto_58","SET_TEXT","@n3");
        assertChange(".auto_58",Prop.HIDE,"");
        assertUse(".auto_58",17);

        assertCommand(".auto_59","SET_TEXT","@n3");
        assertChange(".auto_59",Prop.HIDE,"");
        assertUse(".auto_59",18);

        assertCommand(".auto_60","SET_TEXT","@n3");
        assertChange(".auto_60",Prop.HIDE,"");
        assertUse(".auto_60",19);

        assertCommand(".auto_61","SET_TEXT","@n3");
        assertChange(".auto_61",Prop.HIDE,"");
        assertUse(".auto_61",20);

        assertCommand(".auto_62","SET_TEXT","@n3");
        assertChange(".auto_62",Prop.HIDE,"");
        assertUse(".auto_62",21);

        assertCommand(".auto_63","SET_TEXT","@n3");
        assertChange(".auto_63",Prop.HIDE,"");
        assertUse(".auto_63",22);

        assertCommand(".auto_64","SET_TEXT","@n3");
        assertChange(".auto_64",Prop.HIDE,"");
        assertUse(".auto_64",23);

        assertCommand(".auto_65","SET_TEXT","@n3");
        assertChange(".auto_65",Prop.HIDE,"");
        assertUse(".auto_65",24);

        assertCommand(".auto_66","SET_TEXT","@n3");
        assertChange(".auto_66",Prop.HIDE,"");
        assertUse(".auto_66",25);

        assertCommand(".auto_67","SET_TEXT","@n3");
        assertChange(".auto_67",Prop.HIDE,"");
        assertUse(".auto_67",26);

        assertCommand(".auto_68","SET_TEXT","@n3");
        assertChange(".auto_68",Prop.HIDE,"");
        assertUse(".auto_68",27);

        assertCommand(".auto_69","SET_TEXT","@n3");
        assertChange(".auto_69",Prop.HIDE,"");
        assertUse(".auto_69",28);

        assertCommand(".auto_70","SET_TEXT","@n3");
        assertChange(".auto_70",Prop.HIDE,"");
        assertUse(".auto_70",29);

        assertCommand(".auto_71","SET_TEXT","@n3");
        assertChange(".auto_71",Prop.HIDE,"");
        assertUse(".auto_71",30);

        assertCommand(".auto_72","SET_TEXT","@n3");
        assertChange(".auto_72",Prop.HIDE,"");
        assertUse(".auto_72",31);

        assertCommand(".auto_73","SET_TEXT","@n3");
        assertChange(".auto_73",Prop.HIDE,"");
        assertUse(".auto_73",32);

        assertCommand(".auto_74","SET_TEXT","@n3");
        assertChange(".auto_74",Prop.HIDE,"");
        assertUse(".auto_74",33);

        assertCommand(".auto_75","SET_TEXT","@n3");
        assertChange(".auto_75",Prop.HIDE,"");
        assertUse(".auto_75",34);

        assertCommand(".auto_76","SET_TEXT","@n3");
        assertChange(".auto_76",Prop.HIDE,"");
        assertUse(".auto_76",35);

        assertCommand(".auto_77","SET_TEXT","@n3");
        assertChange(".auto_77",Prop.HIDE,"");
        assertUse(".auto_77",36);

        assertCommand(".auto_78","SET_TEXT","@n3");
        assertChange(".auto_78",Prop.HIDE,"");
        assertUse(".auto_78",37);

        assertCommand(".auto_79","SET_TEXT","@n3");
        assertChange(".auto_79",Prop.HIDE,"");
        assertUse(".auto_79",38);

        assertCommand(".auto_80","SET_TEXT","@n3");
        assertChange(".auto_80",Prop.HIDE,"");
        assertUse(".auto_80",39);

        assertCommand(".auto_81","SET_TEXT","@n3");
        assertChange(".auto_81",Prop.HIDE,"");
        assertUse(".auto_81",40);

        assertCommand(".auto_82","SET_TEXT","@n3");
        assertChange(".auto_82",Prop.HIDE,"");
        assertUse(".auto_82",41);

        assertCommand(".auto_83","SET_TEXT","@n3");
        assertChange(".auto_83",Prop.HIDE,"");
        assertUse(".auto_83",42);

        assertCommand(".auto_84","SET_TEXT","@n3");
        assertChange(".auto_84",Prop.HIDE,"");
        assertUse(".auto_84",43);

        assertCommand(".auto_85","SET_TEXT","@n3");
        assertChange(".auto_85",Prop.HIDE,"");
        assertUse(".auto_85",44);

        assertCommand(".auto_86","SET_TEXT","@n3");
        assertChange(".auto_86",Prop.HIDE,"");
        assertUse(".auto_86",45);

        assertCommand(".auto_87","SET_TEXT","@n3");
        assertChange(".auto_87",Prop.HIDE,"");
        assertUse(".auto_87",46);

        assertCommand(".auto_88","SET_TEXT","@n3");
        assertChange(".auto_88",Prop.HIDE,"");
        assertUse(".auto_88",47);

        assertCommand(".auto_89","SET_TEXT","@n3");
        assertChange(".auto_89",Prop.HIDE,"");
        assertUse(".auto_89",48);

        assertCommand(".auto_90","SET_TEXT","@n3");
        assertChange(".auto_90",Prop.HIDE,"");
        assertUse(".auto_90",49);

        assertCommand(".auto_91","SET_TEXT","@n3");
        assertChange(".auto_91",Prop.HIDE,"");
        assertUse(".auto_91",50);

        assertCommand(".auto_92","SET_TEXT","@n3");
        assertChange(".auto_92",Prop.HIDE,"");
        assertUse(".auto_92",51);

        assertCommand(".auto_93","SET_TEXT","@n3");
        assertChange(".auto_93",Prop.HIDE,"");
        assertUse(".auto_93",52);

        assertCommand(".auto_94","SET_TEXT","@n3");
        assertChange(".auto_94",Prop.HIDE,"");
        assertUse(".auto_94",53);

        assertCommand(".auto_95","SET_TEXT","@n3");
        assertChange(".auto_95",Prop.HIDE,"");
        assertUse(".auto_95",54);

        assertCommand(".auto_96","SET_TEXT","@n3");
        assertChange(".auto_96",Prop.HIDE,"");
        assertUse(".auto_96",55);

        assertCommand(".auto_97","SET_TEXT","@n3");
        assertChange(".auto_97",Prop.HIDE,"");
        assertUse(".auto_97",56);

        assertCommand(".auto_98","SET_TEXT","@n3");
        assertChange(".auto_98",Prop.HIDE,"");
        assertUse(".auto_98",57);

        assertCommand(".auto_99","SET_TEXT","@n3");
        assertChange(".auto_99",Prop.HIDE,"");
        assertUse(".auto_99",58);

        assertCommand(".auto_100","SET_TEXT","@n3");
        assertChange(".auto_100",Prop.HIDE,"");
        assertUse(".auto_100",59);

        assertCommand(".auto_101","SET_TEXT","@n3");
        assertChange(".auto_101",Prop.HIDE,"");
        assertUse(".auto_101",60);

        assertCommand(".auto_102","SET_TEXT","@n3");
        assertChange(".auto_102",Prop.HIDE,"");
        assertUse(".auto_102",61);

        assertCommand(".auto_103","SET_TEXT","@n3");
        assertChange(".auto_103",Prop.HIDE,"");
        assertUse(".auto_103",62);

        assertCommand(".auto_104","SET_TEXT","@n3");
        assertChange(".auto_104",Prop.HIDE,"");
        assertUse(".auto_104",63);

        assertCommand(".auto_105","SET_TEXT","@n3");
        assertChange(".auto_105",Prop.HIDE,"");
        assertUse(".auto_105",64);

        assertCommand(".auto_106","SET_TEXT","@n3");
        assertChange(".auto_106",Prop.HIDE,"");
        assertUse(".auto_106",65);

        assertCommand(".auto_107","SET_TEXT","@n3");
        assertChange(".auto_107",Prop.HIDE,"");
        assertUse(".auto_107",66);

        assertCommand(".auto_108","SET_TEXT","@n3");
        assertChange(".auto_108",Prop.HIDE,"");
        assertUse(".auto_108",67);

        assertCommand(".auto_109","SET_TEXT","@n3");
        assertChange(".auto_109",Prop.HIDE,"");
        assertUse(".auto_109",68);

        assertCommand(".auto_110","SET_TEXT","@n3");
        assertChange(".auto_110",Prop.HIDE,"");
        assertUse(".auto_110",69);

        assertCommand(".auto_111","SET_TEXT","@n3");
        assertChange(".auto_111",Prop.HIDE,"");
        assertUse(".auto_111",70);

        assertCommand(".auto_112","SET_TEXT","@n3");
        assertChange(".auto_112",Prop.HIDE,"");
        assertUse(".auto_112",71);

        assertCommand(".auto_113","SET_TEXT","@n3");
        assertChange(".auto_113",Prop.HIDE,"");
        assertUse(".auto_113",72);

        assertCommand(".auto_114","SET_TEXT","@n3");
        assertChange(".auto_114",Prop.HIDE,"");
        assertUse(".auto_114",73);

        assertCommand(".auto_115","SET_TEXT","@n3");
        assertChange(".auto_115",Prop.HIDE,"");
        assertUse(".auto_115",74);

        assertCommand(".auto_116","SET_TEXT","@n3");
        assertChange(".auto_116",Prop.HIDE,"");
        assertUse(".auto_116",75);

        assertCommand(".auto_117","SET_TEXT","@n3");
        assertChange(".auto_117",Prop.HIDE,"");
        assertUse(".auto_117",76);

        assertCommand(".auto_118","SET_TEXT","@n3");
        assertChange(".auto_118",Prop.HIDE,"");
        assertUse(".auto_118",77);

        assertCommand(".auto_119","SET_TEXT","@n3");
        assertChange(".auto_119",Prop.HIDE,"");
        assertUse(".auto_119",78);

        assertCommand(".auto_120","SET_TEXT","@n3");
        assertChange(".auto_120",Prop.HIDE,"");
        assertUse(".auto_120",79);

        assertCommand(".auto_121","SET_TEXT","@n3");
        assertChange(".auto_121",Prop.HIDE,"");
        assertUse(".auto_121",80);

        assertCommand(".auto_122","SET_TEXT","@n3");
        assertChange(".auto_122",Prop.HIDE,"");
        assertUse(".auto_122",81);

        assertCommand(".auto_123","SET_TEXT","@n3");
        assertChange(".auto_123",Prop.HIDE,"");
        assertUse(".auto_123",82);

        assertCommand(".auto_124","SET_TEXT","@n3");
        assertChange(".auto_124",Prop.HIDE,"");
        assertUse(".auto_124",83);

        assertCommand(".auto_125","SET_TEXT","@n3");
        assertChange(".auto_125",Prop.HIDE,"");
        assertUse(".auto_125",84);

        assertCommand(".auto_126","SET_TEXT","@n3");
        assertChange(".auto_126",Prop.HIDE,"");
        assertUse(".auto_126",85);

        assertCommand(".auto_127","SET_TEXT","@n3");
        assertChange(".auto_127",Prop.HIDE,"");
        assertUse(".auto_127",86);

        assertCommand(".auto_128","SET_TEXT","@n3");
        assertChange(".auto_128",Prop.HIDE,"");
        assertUse(".auto_128",87);

        assertCommand(".auto_129","SET_TEXT","@n3");
        assertChange(".auto_129",Prop.HIDE,"");
        assertUse(".auto_129",88);

        assertCommand(".auto_130","SET_TEXT","@n3");
        assertChange(".auto_130",Prop.HIDE,"");
        assertUse(".auto_130",89);

        assertCommand(".auto_131","SET_TEXT","@n3");
        assertChange(".auto_131",Prop.HIDE,"");
        assertUse(".auto_131",90);

        assertCommand(".auto_132","SET_TEXT","@n3");
        assertChange(".auto_132",Prop.HIDE,"");
        assertUse(".auto_132",91);

        assertCommand(".auto_133","SET_TEXT","@n3");
        assertChange(".auto_133",Prop.HIDE,"");
        assertUse(".auto_133",92);

        assertCommand(".auto_134","SET_TEXT","@n3");
        assertChange(".auto_134",Prop.HIDE,"");
        assertUse(".auto_134",93);

        assertCommand(".auto_135","SET_TEXT","@n3");
        assertChange(".auto_135",Prop.HIDE,"");
        assertUse(".auto_135",94);

        assertCommand(".auto_136","SET_TEXT","@n3");
        assertChange(".auto_136",Prop.HIDE,"");
        assertUse(".auto_136",95);

        assertCommand(".auto_137","SET_TEXT","@n3");
        assertChange(".auto_137",Prop.HIDE,"");
        assertUse(".auto_137",96);

        assertCommand(".auto_138","SET_TEXT","@n3");
        assertChange(".auto_138",Prop.HIDE,"");
        assertUse(".auto_138",97);

        assertCommand(".auto_139","SET_TEXT","@n3");
        assertChange(".auto_139",Prop.HIDE,"");
        assertUse(".auto_139",98);

        assertCommand(".auto_140","SET_TEXT","@n3");
        assertChange(".auto_140",Prop.HIDE,"");
        assertUse(".auto_140",99);

        assertCommand("mainmenu.window.usr:name_2","REFRESH","&Miner");

        post(Event.SELECTED,"mainmenu.window.button2");
        post(Event.ACCEPTED,"mainmenu.window.button2");

        assertCommand("mainmenu.window.usr:name_2","REFRESH","E&xit");
        s1=assertClose("login.window","mainmenu.window");
        assertMetaData("mainmenu.window","MD_CURRENT_FOCUS","mainmenu.window.button2");
        s1.setResult(null);

        assertCommand("CWinImpl","RESTORE_WINDOW","login.window");

        post(Event.SELECTED,"login.window.passwd");
        post(Event.SELECTED,"login.window.acccode");
        send("login.window.acccode","ACCEPT","admin");
        post(Event.SELECTED,"login.window.login");
        post(Event.ACCEPTED,"login.window.login");

        assertChange("login.window.login",Prop.DISABLE,"1");
        assertSelect("login.window.acccode");

        post(Event.SELECTED,"login.window.button2");
        post(Event.SELECTED,"login.window.acccode");

        assertChange("login.window.login",Prop.DISABLE,"");

        post(Event.SELECTED,"login.window.passwd");
        send("login.window.passwd","ACCEPT","boss");
        post(Event.SELECTED,"login.window.login");
        post(Event.ACCEPTED,"login.window.login");

        s1=assertOpen("mainmenu.window","login.window");
        assertText("mainmenu.window","Main Menu");
        assertText("mainmenu.window.spareparts","Spare &Parts");
        assertText("mainmenu.window.workshop","&Workshop");
        assertText("mainmenu.window.units","&Units");
        assertText("mainmenu.window.accounts","&Accounts");
        assertText("mainmenu.window.accounts:2","P&honebook");
        assertText("mainmenu.window.miner","&Miner");
        assertText("mainmenu.window.miner:2","&Business");
        assertText("mainmenu.window.setup","&Setup");
        assertText("mainmenu.window.button2","E&xit");
        assertUse("mainmenu.window.heading","Main Menu - Administrator");
        assertUse("mainmenu.window.usr:name_2","E&xit");
        assertUse("mainmenu.window.dtoday",CDate.today());
        assertMetaData("login.window","MD_CURRENT_FOCUS","login.window.login");
        s1.setResult(null);

        assertLazyOpen("mainmenu.window");

        post(Event.SELECTED,"mainmenu.window.spareparts");
        post("mainmenu.window",Event.SIZED,new Object[] {330,268,0});
        post("mainmenu.window",Event.CLOSEWINDOW);

        s1=assertClose("login.window","mainmenu.window");
        assertMetaData("mainmenu.window","MD_CURRENT_FOCUS","mainmenu.window.spareparts");
        s1.setResult(null);

        assertCommand("CWinImpl","RESTORE_WINDOW","login.window");

        post("login.window",Event.CLOSEWINDOW);

        s1=assertClose(null,"login.window");
        s1.setResult(null);

    }
}
