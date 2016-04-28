OMIT('_EndOfInclude_',_KeycodesPresent_)
_KeycodesPresent_ EQUATE(1)

Key0             EQUATE(0030H)                    !0 Key
Key1             EQUATE(0031H)                    !1 Key
Key2             EQUATE(0032H)                    !2 Key
Key3             EQUATE(0033H)                    !3 Key
Key4             EQUATE(0034H)                    !4 Key
Key5             EQUATE(0035H)                    !5 Key
Key6             EQUATE(0036H)                    !6 Key
Key7             EQUATE(0037H)                    !7 Key
Key8             EQUATE(0038H)                    !8 Key
Key9             EQUATE(0039H)                    !9 Key

AKey             EQUATE(0041H)                    !A Key
BKey             EQUATE(0042H)                    !B Key
CKey             EQUATE(0043H)                    !C Key
DKey             EQUATE(0044H)                    !D Key
EKey             EQUATE(0045H)                    !E Key
FKey             EQUATE(0046H)                    !F Key
GKey             EQUATE(0047H)                    !G Key
HKey             EQUATE(0048H)                    !H Key
IKey             EQUATE(0049H)                    !I Key
JKey             EQUATE(004AH)                    !J Key
KKey             EQUATE(004BH)                    !K Key
LKey             EQUATE(004CH)                    !L Key
MKey             EQUATE(004DH)                    !M Key
NKey             EQUATE(004EH)                    !N Key
OKey             EQUATE(004FH)                    !O Key
PKey             EQUATE(0050H)                    !P Key
QKey             EQUATE(0051H)                    !Q Key
RKey             EQUATE(0052H)                    !R Key
SKey             EQUATE(0053H)                    !S Key
TKey             EQUATE(0054H)                    !T Key
UKey             EQUATE(0055H)                    !U Key
VKey             EQUATE(0056H)                    !V Key
WKey             EQUATE(0057H)                    !W Key
XKey             EQUATE(0058H)                    !X Key
YKey             EQUATE(0059H)                    !Y Key
ZKey             EQUATE(005AH)                    !Z Key

F1Key            EQUATE(0070H)                    !F1 Key
F2Key            EQUATE(0071H)                    !F2 Key
F3Key            EQUATE(0072H)                    !F3 Key
F4Key            EQUATE(0073H)                    !F4 Key
F5Key            EQUATE(0074H)                    !F5 Key
F6Key            EQUATE(0075H)                    !F6 Key
F7Key            EQUATE(0076H)                    !F7 Key
F8Key            EQUATE(0077H)                    !F8 Key
F9Key            EQUATE(0078H)                    !F9 Key
F10Key           EQUATE(0079H)                    !F10 Key
F11Key           EQUATE(007AH)                    !F11 Key
F12Key           EQUATE(007BH)                    !F12 Key

AstKey           EQUATE(006AH)                    !Asterisk Key
BSKey            EQUATE(0008H)                    !Backspace Key
CapsLockKey      EQUATE(0014H)                    !CapsLock Key
DecimalKey       EQUATE(006EH)                    !Decimal Key
DeleteKey        EQUATE(002EH)                    !Delete Key
DownKey          EQUATE(0028H)                    !Cursor Down Key
EndKey           EQUATE(0023H)                    !End Key
EnterKey         EQUATE(000DH)                    !Enter Key
EscKey           EQUATE(001BH)                    !Esc Key
HomeKey          EQUATE(0024H)                    !Home Key
InsertKey        EQUATE(002DH)                    !Insert Key
LeftKey          EQUATE(0025H)                    !Cursor Left Key
MinusKey         EQUATE(006DH)                    !Minus Key
PauseKey         EQUATE(0013H)                    !Pause Key
PgDnKey          EQUATE(0022H)                    !PgDn Key
PgUpKey          EQUATE(0021H)                    !PgUp Key
PlusKey          EQUATE(006BH)                    !Plus Key
PrintKey         EQUATE(002CH)                    !PrintScreen Key
RightKey         EQUATE(0027H)                    !Cursor Right Key
SlashKey         EQUATE(006FH)                    !Slash Key
SpaceKey         EQUATE(0020H)                    !Spacebar
TabKey           EQUATE(0009H)                    !Tab Key
UpKey            EQUATE(0026H)                    !Cursor Up Key

KeyPad0          EQUATE(0060H)                    !0 on numeric keypad
KeyPad1          EQUATE(0061H)                    !1 on numeric keypad
KeyPad2          EQUATE(0062H)                    !2 on numeric keypad
KeyPad3          EQUATE(0063H)                    !3 on numeric keypad
KeyPad4          EQUATE(0064H)                    !4 on numeric keypad
KeyPad5          EQUATE(0065H)                    !5 on numeric keypad
KeyPad6          EQUATE(0066H)                    !6 on numeric keypad
KeyPad7          EQUATE(0067H)                    !7 on numeric keypad
KeyPad8          EQUATE(0068H)                    !8 on numeric keypad
KeyPad9          EQUATE(0069H)                    !9 on numeric keypad

MouseLeft        EQUATE(0001H)                    !Left mouse button
MouseRight       EQUATE(0002H)                    !Right mouse button
MouseCenter      EQUATE(0003H)                    !Middle mouse button
MouseLeft2       EQUATE(0005H)                    !Left mouse double-click
MouseRight2      EQUATE(0006H)                    !Right mouse double-click
MouseCenter2     EQUATE(0007H)                    !Middle mouse double-click
MouseLeftUp      EQUATE(0081H)                    !Left mouse button release
MouseRightUp     EQUATE(0082H)                    !Right mouse button release
MouseCenterUp    EQUATE(0083H)                    !Middle mouse button release

Alt0             EQUATE(0430H)                    !Alt-0 Key
Alt1             EQUATE(0431H)                    !Alt-1 Key
Alt2             EQUATE(0432H)                    !Alt-2 Key
Alt3             EQUATE(0433H)                    !Alt-3 Key
Alt4             EQUATE(0434H)                    !Alt-4 Key
Alt5             EQUATE(0435H)                    !Alt-5 Key
Alt6             EQUATE(0436H)                    !Alt-6 Key
Alt7             EQUATE(0437H)                    !Alt-7 Key
Alt8             EQUATE(0438H)                    !Alt-8 Key
Alt9             EQUATE(0439H)                    !Alt-9 Key

AltA             EQUATE(0441H)                    !Alt-A Key
AltB             EQUATE(0442H)                    !Alt-B Key
AltC             EQUATE(0443H)                    !Alt-C Key
AltD             EQUATE(0444H)                    !Alt-D Key
AltE             EQUATE(0445H)                    !Alt-E Key
AltF             EQUATE(0446H)                    !Alt-F Key
AltG             EQUATE(0447H)                    !Alt-G Key
AltH             EQUATE(0448H)                    !Alt-H Key
AltI             EQUATE(0449H)                    !Alt-I Key
AltJ             EQUATE(044AH)                    !Alt-J Key
AltK             EQUATE(044BH)                    !Alt-K Key
AltL             EQUATE(044CH)                    !Alt-L Key
AltM             EQUATE(044DH)                    !Alt-M Key
AltN             EQUATE(044EH)                    !Alt-N Key
AltO             EQUATE(044FH)                    !Alt-O Key
AltP             EQUATE(0450H)                    !Alt-P Key
AltQ             EQUATE(0451H)                    !Alt-Q Key
AltR             EQUATE(0452H)                    !Alt-R Key
AltS             EQUATE(0453H)                    !Alt-S Key
AltT             EQUATE(0454H)                    !Alt-T Key
AltU             EQUATE(0455H)                    !Alt-U Key
AltV             EQUATE(0456H)                    !Alt-V Key
AltW             EQUATE(0457H)                    !Alt-W Key
AltX             EQUATE(0458H)                    !Alt-X Key
AltY             EQUATE(0459H)                    !Alt-Y Key
AltZ             EQUATE(045AH)                    !Alt-Z Key

AltF1            EQUATE(0470H)                    !Alt-F1 Key
AltF2            EQUATE(0471H)                    !Alt-F2 Key
AltF3            EQUATE(0472H)                    !Alt-F3 Key
AltF4            EQUATE(0473H)                    !Alt-F4 Key
AltF5            EQUATE(0474H)                    !Alt-F5 Key
AltF6            EQUATE(0475H)                    !Alt-F6 Key
AltF7            EQUATE(0476H)                    !Alt-F7 Key
AltF8            EQUATE(0477H)                    !Alt-F8 Key
AltF9            EQUATE(0478H)                    !Alt-F9 Key
AltF10           EQUATE(0479H)                    !Alt-F10 Key
AltF11           EQUATE(047AH)                    !Alt-F11 Key
AltF12           EQUATE(047BH)                    !Alt-F12 Key

AltAst           EQUATE(046AH)                    !Alt-Asterisk Key
AltBS            EQUATE(0408H)                    !Alt-Backspace Key
AltDecimal       EQUATE(046EH)                    !Alt-Decimal Key
AltDelete        EQUATE(042EH)                    !Alt-Delete Key
AltDown          EQUATE(0428H)                    !Alt-Cursor Down Key
AltEnd           EQUATE(0423H)                    !Alt-End Key
AltEnter         EQUATE(040DH)                    !Alt-Enter Key
AltEsc           EQUATE(041BH)                    !Alt-Esc Key
AltHome          EQUATE(0424H)                    !Alt-Home Key
AltInsert        EQUATE(042DH)                    !Alt-Insert Key
AltLeft          EQUATE(0425H)                    !Alt-Cursor Left Key
AltMinus         EQUATE(046DH)                    !Alt-Minus Key
AltPause         EQUATE(0413H)                    !Alt-Pause Key
AltPgDn          EQUATE(0422H)                    !Alt-PgDn Key
AltPgUp          EQUATE(0421H)                    !Alt-PgUp Key
AltPlus          EQUATE(046BH)                    !Alt-Plus Key
AltPrint         EQUATE(042CH)                    !Alt-PrintScreen Key
AltRight         EQUATE(0427H)                    !Alt-Cursor Right Key
AltSlash         EQUATE(046FH)                    !Alt-Slash Key
AltSpace         EQUATE(0420H)                    !Alt-Spacebar
AltTab           EQUATE(0409H)                    !Alt-Tab Key
AltUp            EQUATE(0426H)                    !Alt-Cursor Up Key

AltPad0          EQUATE(0460H)                    !Alt-0 on numeric keypad
AltPad1          EQUATE(0461H)                    !Alt-1 on numeric keypad
AltPad2          EQUATE(0462H)                    !Alt-2 on numeric keypad
AltPad3          EQUATE(0463H)                    !Alt-3 on numeric keypad
AltPad4          EQUATE(0464H)                    !Alt-4 on numeric keypad
AltPad5          EQUATE(0465H)                    !Alt-5 on numeric keypad
AltPad6          EQUATE(0466H)                    !Alt-6 on numeric keypad
AltPad7          EQUATE(0467H)                    !Alt-7 on numeric keypad
AltPad8          EQUATE(0468H)                    !Alt-8 on numeric keypad
AltPad9          EQUATE(0469H)                    !Alt-9 on numeric keypad

AltMouseLeft     EQUATE(0401H)                    !Alt-Left mouse button
AltMouseRight    EQUATE(0402H)                    !Alt-Right mouse button
AltMouseCenter   EQUATE(0403H)                    !Alt-Middle mouse button
AltMouseLeft2    EQUATE(0405H)                    !Alt-Left mouse double-click
AltMouseRight2   EQUATE(0406H)                    !Alt-Right mouse double-click
AltMouseCenter2  EQUATE(0407H)                    !Alt-Middle mouse double-click

Ctrl0            EQUATE(0230H)                    !Ctrl-0 Key
Ctrl1            EQUATE(0231H)                    !Ctrl-1 Key
Ctrl2            EQUATE(0232H)                    !Ctrl-2 Key
Ctrl3            EQUATE(0233H)                    !Ctrl-3 Key
Ctrl4            EQUATE(0234H)                    !Ctrl-4 Key
Ctrl5            EQUATE(0235H)                    !Ctrl-5 Key
Ctrl6            EQUATE(0236H)                    !Ctrl-6 Key
Ctrl7            EQUATE(0237H)                    !Ctrl-7 Key
Ctrl8            EQUATE(0238H)                    !Ctrl-8 Key
Ctrl9            EQUATE(0239H)                    !Ctrl-9 Key

CtrlA            EQUATE(0241H)                    !Ctrl-A Key
CtrlB            EQUATE(0242H)                    !Ctrl-B Key
CtrlC            EQUATE(0243H)                    !Ctrl-C Key
CtrlD            EQUATE(0244H)                    !Ctrl-D Key
CtrlE            EQUATE(0245H)                    !Ctrl-E Key
CtrlF            EQUATE(0246H)                    !Ctrl-F Key
CtrlG            EQUATE(0247H)                    !Ctrl-G Key
CtrlH            EQUATE(0248H)                    !Ctrl-H Key
CtrlI            EQUATE(0249H)                    !Ctrl-I Key
CtrlJ            EQUATE(024AH)                    !Ctrl-J Key
CtrlK            EQUATE(024BH)                    !Ctrl-K Key
CtrlL            EQUATE(024CH)                    !Ctrl-L Key
CtrlM            EQUATE(024DH)                    !Ctrl-M Key
CtrlN            EQUATE(024EH)                    !Ctrl-N Key
CtrlO            EQUATE(024FH)                    !Ctrl-O Key
CtrlP            EQUATE(0250H)                    !Ctrl-P Key
CtrlQ            EQUATE(0251H)                    !Ctrl-Q Key
CtrlR            EQUATE(0252H)                    !Ctrl-R Key
CtrlS            EQUATE(0253H)                    !Ctrl-S Key
CtrlT            EQUATE(0254H)                    !Ctrl-T Key
CtrlU            EQUATE(0255H)                    !Ctrl-U Key
CtrlV            EQUATE(0256H)                    !Ctrl-V Key
CtrlW            EQUATE(0257H)                    !Ctrl-W Key
CtrlX            EQUATE(0258H)                    !Ctrl-X Key
CtrlY            EQUATE(0259H)                    !Ctrl-Y Key
CtrlZ            EQUATE(025AH)                    !Ctrl-Z Key

CtrlF1           EQUATE(0270H)                    !Ctrl-F1 Key
CtrlF2           EQUATE(0271H)                    !Ctrl-F2 Key
CtrlF3           EQUATE(0272H)                    !Ctrl-F3 Key
CtrlF4           EQUATE(0273H)                    !Ctrl-F4 Key
CtrlF5           EQUATE(0274H)                    !Ctrl-F5 Key
CtrlF6           EQUATE(0275H)                    !Ctrl-F6 Key
CtrlF7           EQUATE(0276H)                    !Ctrl-F7 Key
CtrlF8           EQUATE(0277H)                    !Ctrl-F8 Key
CtrlF9           EQUATE(0278H)                    !Ctrl-F9 Key
CtrlF10          EQUATE(0279H)                    !Ctrl-F10 Key
CtrlF11          EQUATE(027AH)                    !Ctrl-F11 Key
CtrlF12          EQUATE(027BH)                    !Ctrl-F12 Key

CtrlAst          EQUATE(026AH)                    !Ctrl-Asterisk Key
CtrlBS           EQUATE(0208H)                    !Ctrl-Backspace Key
CtrlDecimal      EQUATE(026EH)                    !Ctrl-Decimal Key
CtrlDelete       EQUATE(022EH)                    !Ctrl-Delete Key
CtrlDown         EQUATE(0228H)                    !Ctrl-Cursor Down Key
CtrlEnd          EQUATE(0223H)                    !Ctrl-End Key
CtrlEnter        EQUATE(020DH)                    !Ctrl-Enter Key
CtrlEsc          EQUATE(021BH)                    !Ctrl-Esc Key
CtrlHome         EQUATE(0224H)                    !Ctrl-Home Key
CtrlInsert       EQUATE(022DH)                    !Ctrl-Insert Key
CtrlLeft         EQUATE(0225H)                    !Ctrl-Cursor Left Key
CtrlMinus        EQUATE(026DH)                    !Ctrl-Minus Key
CtrlPause        EQUATE(0213H)                    !Ctrl-Pause Key
CtrlPgDn         EQUATE(0222H)                    !Ctrl-PgDn Key
CtrlPgUp         EQUATE(0221H)                    !Ctrl-PgUp Key
CtrlPlus         EQUATE(026BH)                    !Ctrl-Plus Key
CtrlPrint        EQUATE(022CH)                    !Ctrl-PrintScreen Key
CtrlRight        EQUATE(0227H)                    !Ctrl-Cursor Right Key
CtrlSlash        EQUATE(026FH)                    !Ctrl-Slash Key
CtrlSpace        EQUATE(0220H)                    !Ctrl-Spacebar
CtrlTab          EQUATE(0209H)                    !Ctrl-Tab Key
CtrlUp           EQUATE(0226H)                    !Ctrl-Cursor Up Key

CtrlPad0         EQUATE(0260H)                    !Ctrl-0 on numeric keypad
CtrlPad1         EQUATE(0261H)                    !Ctrl-1 on numeric keypad
CtrlPad2         EQUATE(0262H)                    !Ctrl-2 on numeric keypad
CtrlPad3         EQUATE(0263H)                    !Ctrl-3 on numeric keypad
CtrlPad4         EQUATE(0264H)                    !Ctrl-4 on numeric keypad
CtrlPad5         EQUATE(0265H)                    !Ctrl-5 on numeric keypad
CtrlPad6         EQUATE(0266H)                    !Ctrl-6 on numeric keypad
CtrlPad7         EQUATE(0267H)                    !Ctrl-7 on numeric keypad
CtrlPad8         EQUATE(0268H)                    !Ctrl-8 on numeric keypad
CtrlPad9         EQUATE(0269H)                    !Ctrl-9 on numeric keypad

CtrlMouseLeft    EQUATE(0201H)                    !Ctrl-Left mouse button
CtrlMouseRight   EQUATE(0202H)                    !Ctrl-Right mouse button
CtrlMouseCenter  EQUATE(0203H)                    !Ctrl-Middle mouse button
CtrlMouseLeft2   EQUATE(0205H)                    !Ctrl-Left mouse double-click
CtrlMouseRight2  EQUATE(0206H)                    !Ctrl-Right mouse double-click
CtrlMouseCenter2 EQUATE(0207H)                    !Ctrl-Middle mouse double-click

Shift0           EQUATE(0130H)                    !Shift-0 Key
Shift1           EQUATE(0131H)                    !Shift-1 Key
Shift2           EQUATE(0132H)                    !Shift-2 Key
Shift3           EQUATE(0133H)                    !Shift-3 Key
Shift4           EQUATE(0134H)                    !Shift-4 Key
Shift5           EQUATE(0135H)                    !Shift-5 Key
Shift6           EQUATE(0136H)                    !Shift-6 Key
Shift7           EQUATE(0137H)                    !Shift-7 Key
Shift8           EQUATE(0138H)                    !Shift-8 Key
Shift9           EQUATE(0139H)                    !Shift-9 Key

ShiftA           EQUATE(0141H)                    !Shift-A Key
ShiftB           EQUATE(0142H)                    !Shift-B Key
ShiftC           EQUATE(0143H)                    !Shift-C Key
ShiftD           EQUATE(0144H)                    !Shift-D Key
ShiftE           EQUATE(0145H)                    !Shift-E Key
ShiftF           EQUATE(0146H)                    !Shift-F Key
ShiftG           EQUATE(0147H)                    !Shift-G Key
ShiftH           EQUATE(0148H)                    !Shift-H Key
ShiftI           EQUATE(0149H)                    !Shift-I Key
ShiftJ           EQUATE(014AH)                    !Shift-J Key
ShiftK           EQUATE(014BH)                    !Shift-K Key
ShiftL           EQUATE(014CH)                    !Shift-L Key
ShiftM           EQUATE(014DH)                    !Shift-M Key
ShiftN           EQUATE(014EH)                    !Shift-N Key
ShiftO           EQUATE(014FH)                    !Shift-O Key
ShiftP           EQUATE(0150H)                    !Shift-P Key
ShiftQ           EQUATE(0151H)                    !Shift-Q Key
ShiftR           EQUATE(0152H)                    !Shift-R Key
ShiftS           EQUATE(0153H)                    !Shift-S Key
ShiftT           EQUATE(0154H)                    !Shift-T Key
ShiftU           EQUATE(0155H)                    !Shift-U Key
ShiftV           EQUATE(0156H)                    !Shift-V Key
ShiftW           EQUATE(0157H)                    !Shift-W Key
ShiftX           EQUATE(0158H)                    !Shift-X Key
ShiftY           EQUATE(0159H)                    !Shift-Y Key
ShiftZ           EQUATE(015AH)                    !Shift-Z Key

ShiftF1          EQUATE(0170H)                    !Shift-F1 Key
ShiftF2          EQUATE(0171H)                    !Shift-F2 Key
ShiftF3          EQUATE(0172H)                    !Shift-F3 Key
ShiftF4          EQUATE(0173H)                    !Shift-F4 Key
ShiftF5          EQUATE(0174H)                    !Shift-F5 Key
ShiftF6          EQUATE(0175H)                    !Shift-F6 Key
ShiftF7          EQUATE(0176H)                    !Shift-F7 Key
ShiftF8          EQUATE(0177H)                    !Shift-F8 Key
ShiftF9          EQUATE(0178H)                    !Shift-F9 Key
ShiftF10         EQUATE(0179H)                    !Shift-F10 Key
ShiftF11         EQUATE(017AH)                    !Shift-F11 Key
ShiftF12         EQUATE(017BH)                    !Shift-F12 Key

ShiftAst         EQUATE(016AH)                    !Shift-Asterisk Key
ShiftBS          EQUATE(0108H)                    !Shift-Backspace Key
ShiftDecimal     EQUATE(016EH)                    !Shift-Decimal Key
ShiftDelete      EQUATE(012EH)                    !Shift-Delete Key
ShiftDown        EQUATE(0128H)                    !Shift-Cursor Down Key
ShiftEnd         EQUATE(0123H)                    !Shift-End Key
ShiftEnter       EQUATE(010DH)                    !Shift-Enter Key
ShiftEsc         EQUATE(011BH)                    !Shift-Esc Key
ShiftHome        EQUATE(0124H)                    !Shift-Home Key
ShiftInsert      EQUATE(012DH)                    !Shift-Insert Key
ShiftLeft        EQUATE(0125H)                    !Shift-Cursor Left Key
ShiftMinus       EQUATE(016DH)                    !Shift-Minus Key
ShiftPause       EQUATE(0113H)                    !Shift-Pause Key
ShiftPgDn        EQUATE(0122H)                    !Shift-PgDn Key
ShiftPgUp        EQUATE(0121H)                    !Shift-PgUp Key
ShiftPlus        EQUATE(016BH)                    !Shift-Plus Key
ShiftPrint       EQUATE(012CH)                    !Shift-PrintScreen Key
ShiftRight       EQUATE(0127H)                    !Shift-Cursor Right Key
ShiftSlash       EQUATE(016FH)                    !Shift-Slash Key
ShiftSpace       EQUATE(0120H)                    !Shift-Spacebar
ShiftTab         EQUATE(0109H)                    !Shift-Tab Key
ShiftUp          EQUATE(0126H)                    !Shift-Cursor Up Key

ShiftPad0        EQUATE(0160H)                    !Shift-0 on numeric keypad
ShiftPad1        EQUATE(0161H)                    !Shift-1 on numeric keypad
ShiftPad2        EQUATE(0162H)                    !Shift-2 on numeric keypad
ShiftPad3        EQUATE(0163H)                    !Shift-3 on numeric keypad
ShiftPad4        EQUATE(0164H)                    !Shift-4 on numeric keypad
ShiftPad5        EQUATE(0165H)                    !Shift-5 on numeric keypad
ShiftPad6        EQUATE(0166H)                    !Shift-6 on numeric keypad
ShiftPad7        EQUATE(0167H)                    !Shift-7 on numeric keypad
ShiftPad8        EQUATE(0168H)                    !Shift-8 on numeric keypad
ShiftPad9        EQUATE(0169H)                    !Shift-9 on numeric keypad


ShiftMouseLeft    EQUATE(0101H)                   !Shift-Left mouse button
ShiftMouseRight   EQUATE(0102H)                   !Shift-Right mouse button
ShiftMouseCenter  EQUATE(0103H)                   !Shift-Middle mouse button
ShiftMouseLeft2   EQUATE(0105H)                   !Shift-Left mouse double-click
ShiftMouseRight2  EQUATE(0106H)                   !Shift-Right mouse double-click
ShiftMouseCenter2 EQUATE(0107H)                   !Shift-Middle mouse double-click

AltShift0        EQUATE(0530H)                    !Alt-Shift-0 Key
AltShift1        EQUATE(0531H)                    !Alt-Shift-1 Key
AltShift2        EQUATE(0532H)                    !Alt-Shift-2 Key
AltShift3        EQUATE(0533H)                    !Alt-Shift-3 Key
AltShift4        EQUATE(0534H)                    !Alt-Shift-4 Key
AltShift5        EQUATE(0535H)                    !Alt-Shift-5 Key
AltShift6        EQUATE(0536H)                    !Alt-Shift-6 Key
AltShift7        EQUATE(0537H)                    !Alt-Shift-7 Key
AltShift8        EQUATE(0538H)                    !Alt-Shift-8 Key
AltShift9        EQUATE(0539H)                    !Alt-Shift-9 Key

AltShiftA        EQUATE(0541H)                    !Alt-Shift-A Key
AltShiftB        EQUATE(0542H)                    !Alt-Shift-B Key
AltShiftC        EQUATE(0543H)                    !Alt-Shift-C Key
AltShiftD        EQUATE(0544H)                    !Alt-Shift-D Key
AltShiftE        EQUATE(0545H)                    !Alt-Shift-E Key
AltShiftF        EQUATE(0546H)                    !Alt-Shift-F Key
AltShiftG        EQUATE(0547H)                    !Alt-Shift-G Key
AltShiftH        EQUATE(0548H)                    !Alt-Shift-H Key
AltShiftI        EQUATE(0549H)                    !Alt-Shift-I Key
AltShiftJ        EQUATE(054AH)                    !Alt-Shift-J Key
AltShiftK        EQUATE(054BH)                    !Alt-Shift-K Key
AltShiftL        EQUATE(054CH)                    !Alt-Shift-L Key
AltShiftM        EQUATE(054DH)                    !Alt-Shift-M Key
AltShiftN        EQUATE(054EH)                    !Alt-Shift-N Key
AltShiftO        EQUATE(054FH)                    !Alt-Shift-O Key
AltShiftP        EQUATE(0550H)                    !Alt-Shift-P Key
AltShiftQ        EQUATE(0551H)                    !Alt-Shift-Q Key
AltShiftR        EQUATE(0552H)                    !Alt-Shift-R Key
AltShiftS        EQUATE(0553H)                    !Alt-Shift-S Key
AltShiftT        EQUATE(0554H)                    !Alt-Shift-T Key
AltShiftU        EQUATE(0555H)                    !Alt-Shift-U Key
AltShiftV        EQUATE(0556H)                    !Alt-Shift-V Key
AltShiftW        EQUATE(0557H)                    !Alt-Shift-W Key
AltShiftX        EQUATE(0558H)                    !Alt-Shift-X Key
AltShiftY        EQUATE(0559H)                    !Alt-Shift-Y Key
AltShiftZ        EQUATE(055AH)                    !Alt-Shift-Z Key

AltShiftF1       EQUATE(0570H)                    !Alt-Shift-F1 Key
AltShiftF2       EQUATE(0571H)                    !Alt-Shift-F2 Key
AltShiftF3       EQUATE(0572H)                    !Alt-Shift-F3 Key
AltShiftF4       EQUATE(0573H)                    !Alt-Shift-F4 Key
AltShiftF5       EQUATE(0574H)                    !Alt-Shift-F5 Key
AltShiftF6       EQUATE(0575H)                    !Alt-Shift-F6 Key
AltShiftF7       EQUATE(0576H)                    !Alt-Shift-F7 Key
AltShiftF8       EQUATE(0577H)                    !Alt-Shift-F8 Key
AltShiftF9       EQUATE(0578H)                    !Alt-Shift-F9 Key
AltShiftF10      EQUATE(0579H)                    !Alt-Shift-F10 Key
AltShiftF11      EQUATE(057AH)                    !Alt-Shift-F11 Key
AltShiftF12      EQUATE(057BH)                    !Alt-Shift-F12 Key

AltShiftAst      EQUATE(056AH)                    !Alt-Shift-Asterisk Key
AltShiftBS       EQUATE(0508H)                    !Alt-Shift-Backspace Key
AltShiftDecimal  EQUATE(056EH)                    !Alt-Shift-Decimal Key
AltShiftDelete   EQUATE(052EH)                    !Alt-Shift-Delete Key
AltShiftDown     EQUATE(0528H)                    !Alt-Shift-Cursor Down Key
AltShiftEnd      EQUATE(0523H)                    !Alt-Shift-End Key
AltShiftEnter    EQUATE(050DH)                    !Alt-Shift-Enter Key
AltShiftEsc      EQUATE(051BH)                    !Alt-Shift-Esc Key
AltShiftHome     EQUATE(0524H)                    !Alt-Shift-Home Key
AltShiftInsert   EQUATE(052DH)                    !Alt-Shift-Insert Key
AltShiftLeft     EQUATE(0525H)                    !Alt-Shift-Cursor Left Key
AltShiftMinus    EQUATE(056DH)                    !Alt-Shift-Minus Key
AltShiftPause    EQUATE(0513H)                    !Alt-Shift-Pause Key
AltShiftPgDn     EQUATE(0522H)                    !Alt-Shift-PgDn Key
AltShiftPgUp     EQUATE(0521H)                    !Alt-Shift-PgUp Key
AltShiftPlus     EQUATE(056BH)                    !Alt-Shift-Plus Key
AltShiftPrint    EQUATE(052CH)                    !Alt-Shift-PrintScreen Key
AltShiftRight    EQUATE(0527H)                    !Alt-Shift-Cursor Right Key
AltShiftSlash    EQUATE(056FH)                    !Alt-Shift-Slash Key
AltShiftSpace    EQUATE(0520H)                    !Alt-Shift-Spacebar
AltShiftTab      EQUATE(0509H)                    !Alt-Shift-Tab Key
AltShiftUp       EQUATE(0526H)                    !Alt-Shift-Cursor Up Key

AltShiftPad0     EQUATE(0560H)                    !Alt-Shift-0 on numeric keypad
AltShiftPad1     EQUATE(0561H)                    !Alt-Shift-1 on numeric keypad
AltShiftPad2     EQUATE(0562H)                    !Alt-Shift-2 on numeric keypad
AltShiftPad3     EQUATE(0563H)                    !Alt-Shift-3 on numeric keypad
AltShiftPad4     EQUATE(0564H)                    !Alt-Shift-4 on numeric keypad
AltShiftPad5     EQUATE(0565H)                    !Alt-Shift-5 on numeric keypad
AltShiftPad6     EQUATE(0566H)                    !Alt-Shift-6 on numeric keypad
AltShiftPad7     EQUATE(0567H)                    !Alt-Shift-7 on numeric keypad
AltShiftPad8     EQUATE(0568H)                    !Alt-Shift-8 on numeric keypad
AltShiftPad9     EQUATE(0569H)                    !Alt-Shift-9 on numeric keypad


AltShiftMouseLeft    EQUATE(0501H)                !Alt-Shift-Left mouse button
AltShiftMouseRight   EQUATE(0502H)                !Alt-Shift-Right mouse button
AltShiftMouseCenter  EQUATE(0503H)                !Alt-Shift-Middle mouse button
AltShiftMouseLeft2   EQUATE(0505H)                !Alt-Shift-Left mouse double-click
AltShiftMouseRight2  EQUATE(0506H)                !Alt-Shift-Right mouse double-click
AltShiftMouseCenter2 EQUATE(0507H)                !Alt-Shift-Middle mouse double-click

CtrlShift0       EQUATE(0330H)                    !Ctrl-Shift-0 Key
CtrlShift1       EQUATE(0331H)                    !Ctrl-Shift-1 Key
CtrlShift2       EQUATE(0332H)                    !Ctrl-Shift-2 Key
CtrlShift3       EQUATE(0333H)                    !Ctrl-Shift-3 Key
CtrlShift4       EQUATE(0334H)                    !Ctrl-Shift-4 Key
CtrlShift5       EQUATE(0335H)                    !Ctrl-Shift-5 Key
CtrlShift6       EQUATE(0336H)                    !Ctrl-Shift-6 Key
CtrlShift7       EQUATE(0337H)                    !Ctrl-Shift-7 Key
CtrlShift8       EQUATE(0338H)                    !Ctrl-Shift-8 Key
CtrlShift9       EQUATE(0339H)                    !Ctrl-Shift-9 Key

CtrlShiftA       EQUATE(0341H)                    !Ctrl-Shift-A Key
CtrlShiftB       EQUATE(0342H)                    !Ctrl-Shift-B Key
CtrlShiftC       EQUATE(0343H)                    !Ctrl-Shift-C Key
CtrlShiftD       EQUATE(0344H)                    !Ctrl-Shift-D Key
CtrlShiftE       EQUATE(0345H)                    !Ctrl-Shift-E Key
CtrlShiftF       EQUATE(0346H)                    !Ctrl-Shift-F Key
CtrlShiftG       EQUATE(0347H)                    !Ctrl-Shift-G Key
CtrlShiftH       EQUATE(0348H)                    !Ctrl-Shift-H Key
CtrlShiftI       EQUATE(0349H)                    !Ctrl-Shift-I Key
CtrlShiftJ       EQUATE(034AH)                    !Ctrl-Shift-J Key
CtrlShiftK       EQUATE(034BH)                    !Ctrl-Shift-K Key
CtrlShiftL       EQUATE(034CH)                    !Ctrl-Shift-L Key
CtrlShiftM       EQUATE(034DH)                    !Ctrl-Shift-M Key
CtrlShiftN       EQUATE(034EH)                    !Ctrl-Shift-N Key
CtrlShiftO       EQUATE(034FH)                    !Ctrl-Shift-O Key
CtrlShiftP       EQUATE(0350H)                    !Ctrl-Shift-P Key
CtrlShiftQ       EQUATE(0351H)                    !Ctrl-Shift-Q Key
CtrlShiftR       EQUATE(0352H)                    !Ctrl-Shift-R Key
CtrlShiftS       EQUATE(0353H)                    !Ctrl-Shift-S Key
CtrlShiftT       EQUATE(0354H)                    !Ctrl-Shift-T Key
CtrlShiftU       EQUATE(0355H)                    !Ctrl-Shift-U Key
CtrlShiftV       EQUATE(0356H)                    !Ctrl-Shift-V Key
CtrlShiftW       EQUATE(0357H)                    !Ctrl-Shift-W Key
CtrlShiftX       EQUATE(0358H)                    !Ctrl-Shift-X Key
CtrlShiftY       EQUATE(0359H)                    !Ctrl-Shift-Y Key
CtrlShiftZ       EQUATE(035AH)                    !Ctrl-Shift-Z Key

CtrlShiftF1      EQUATE(0370H)                    !Ctrl-Shift-F1 Key
CtrlShiftF2      EQUATE(0371H)                    !Ctrl-Shift-F2 Key
CtrlShiftF3      EQUATE(0372H)                    !Ctrl-Shift-F3 Key
CtrlShiftF4      EQUATE(0373H)                    !Ctrl-Shift-F4 Key
CtrlShiftF5      EQUATE(0374H)                    !Ctrl-Shift-F5 Key
CtrlShiftF6      EQUATE(0375H)                    !Ctrl-Shift-F6 Key
CtrlShiftF7      EQUATE(0376H)                    !Ctrl-Shift-F7 Key
CtrlShiftF8      EQUATE(0377H)                    !Ctrl-Shift-F8 Key
CtrlShiftF9      EQUATE(0378H)                    !Ctrl-Shift-F9 Key
CtrlShiftF10     EQUATE(0379H)                    !Ctrl-Shift-F10 Key
CtrlShiftF11     EQUATE(037AH)                    !Ctrl-Shift-F11 Key
CtrlShiftF12     EQUATE(037BH)                    !Ctrl-Shift-F12 Key

CtrlShiftAst     EQUATE(036AH)                    !Ctrl-Shift-Asterisk Key
CtrlShiftBS      EQUATE(0308H)                    !Ctrl-Shift-Backspace Key
CtrlShiftDecimal EQUATE(036EH)                    !Ctrl-Shift-Decimal Key
CtrlShiftDelete  EQUATE(032EH)                    !Ctrl-Shift-Delete Key
CtrlShiftDown    EQUATE(0328H)                    !Ctrl-Shift-Cursor Down Key
CtrlShiftEnd     EQUATE(0323H)                    !Ctrl-Shift-End Key
CtrlShiftEnter   EQUATE(030DH)                    !Ctrl-Shift-Enter Key
CtrlShiftEsc     EQUATE(031BH)                    !Ctrl-Shift-Esc Key
CtrlShiftHome    EQUATE(0324H)                    !Ctrl-Shift-Home Key
CtrlShiftInsert  EQUATE(032DH)                    !Ctrl-Shift-Insert Key
CtrlShiftLeft    EQUATE(0325H)                    !Ctrl-Shift-Cursor Left Key
CtrlShiftMinus   EQUATE(036DH)                    !Ctrl-Shift-Minus Key
CtrlShiftPause   EQUATE(0313H)                    !Ctrl-Shift-Pause Key
CtrlShiftPgDn    EQUATE(0322H)                    !Ctrl-Shift-PgDn Key
CtrlShiftPgUp    EQUATE(0321H)                    !Ctrl-Shift-PgUp Key
CtrlShiftPlus    EQUATE(036BH)                    !Ctrl-Shift-Plus Key
CtrlShiftPrint   EQUATE(032CH)                    !Ctrl-Shift-PrintScreen Key
CtrlShiftRight   EQUATE(0327H)                    !Ctrl-Shift-Cursor Right Key
CtrlShiftSlash   EQUATE(036FH)                    !Ctrl-Shift-Slash Key
CtrlShiftSpace   EQUATE(0320H)                    !Ctrl-Shift-Spacebar
CtrlShiftTab     EQUATE(0309H)                    !Ctrl-Shift-Tab Key
CtrlShiftUp      EQUATE(0326H)                    !Ctrl-Shift-Cursor Up Key

CtrlShiftPad0    EQUATE(0360H)                    !Ctrl-Shift-0 on numeric keypad
CtrlShiftPad1    EQUATE(0361H)                    !Ctrl-Shift-1 on numeric keypad
CtrlShiftPad2    EQUATE(0362H)                    !Ctrl-Shift-2 on numeric keypad
CtrlShiftPad3    EQUATE(0363H)                    !Ctrl-Shift-3 on numeric keypad
CtrlShiftPad4    EQUATE(0364H)                    !Ctrl-Shift-4 on numeric keypad
CtrlShiftPad5    EQUATE(0365H)                    !Ctrl-Shift-5 on numeric keypad
CtrlShiftPad6    EQUATE(0366H)                    !Ctrl-Shift-6 on numeric keypad
CtrlShiftPad7    EQUATE(0367H)                    !Ctrl-Shift-7 on numeric keypad
CtrlShiftPad8    EQUATE(0368H)                    !Ctrl-Shift-8 on numeric keypad
CtrlShiftPad9    EQUATE(0369H)                    !Ctrl-Shift-9 on numeric keypad


CtrlShiftMouseLeft    EQUATE(0301H)               !Ctrl-Shift-Left mouse button
CtrlShiftMouseRight   EQUATE(0302H)               !Ctrl-Shift-Right mouse button
CtrlShiftMouseCenter  EQUATE(0303H)               !Ctrl-Shift-Middle mouse button
CtrlShiftMouseLeft2   EQUATE(0305H)               !Ctrl-Shift-Left mouse double-click
CtrlShiftMouseRight2  EQUATE(0306H)               !Ctrl-Shift-Right mouse double-click
CtrlShiftMouseCenter2 EQUATE(0307H)               !Ctrl-Shift-Middle mouse double-click

CtrlAlt0         EQUATE(0630H)                    !Ctrl-Alt-0 Key
CtrlAlt1         EQUATE(0631H)                    !Ctrl-Alt-1 Key
CtrlAlt2         EQUATE(0632H)                    !Ctrl-Alt-2 Key
CtrlAlt3         EQUATE(0633H)                    !Ctrl-Alt-3 Key
CtrlAlt4         EQUATE(0634H)                    !Ctrl-Alt-4 Key
CtrlAlt5         EQUATE(0635H)                    !Ctrl-Alt-5 Key
CtrlAlt6         EQUATE(0636H)                    !Ctrl-Alt-6 Key
CtrlAlt7         EQUATE(0637H)                    !Ctrl-Alt-7 Key
CtrlAlt8         EQUATE(0638H)                    !Ctrl-Alt-8 Key
CtrlAlt9         EQUATE(0639H)                    !Ctrl-Alt-9 Key

CtrlAltA         EQUATE(0641H)                    !Ctrl-Alt-A Key
CtrlAltB         EQUATE(0642H)                    !Ctrl-Alt-B Key
CtrlAltC         EQUATE(0643H)                    !Ctrl-Alt-C Key
CtrlAltD         EQUATE(0644H)                    !Ctrl-Alt-D Key
CtrlAltE         EQUATE(0645H)                    !Ctrl-Alt-E Key
CtrlAltF         EQUATE(0646H)                    !Ctrl-Alt-F Key
CtrlAltG         EQUATE(0647H)                    !Ctrl-Alt-G Key
CtrlAltH         EQUATE(0648H)                    !Ctrl-Alt-H Key
CtrlAltI         EQUATE(0649H)                    !Ctrl-Alt-I Key
CtrlAltJ         EQUATE(064AH)                    !Ctrl-Alt-J Key
CtrlAltK         EQUATE(064BH)                    !Ctrl-Alt-K Key
CtrlAltL         EQUATE(064CH)                    !Ctrl-Alt-L Key
CtrlAltM         EQUATE(064DH)                    !Ctrl-Alt-M Key
CtrlAltN         EQUATE(064EH)                    !Ctrl-Alt-N Key
CtrlAltO         EQUATE(064FH)                    !Ctrl-Alt-O Key
CtrlAltP         EQUATE(0650H)                    !Ctrl-Alt-P Key
CtrlAltQ         EQUATE(0651H)                    !Ctrl-Alt-Q Key
CtrlAltR         EQUATE(0652H)                    !Ctrl-Alt-R Key
CtrlAltS         EQUATE(0653H)                    !Ctrl-Alt-S Key
CtrlAltT         EQUATE(0654H)                    !Ctrl-Alt-T Key
CtrlAltU         EQUATE(0655H)                    !Ctrl-Alt-U Key
CtrlAltV         EQUATE(0656H)                    !Ctrl-Alt-V Key
CtrlAltW         EQUATE(0657H)                    !Ctrl-Alt-W Key
CtrlAltX         EQUATE(0658H)                    !Ctrl-Alt-X Key
CtrlAltY         EQUATE(0659H)                    !Ctrl-Alt-Y Key
CtrlAltZ         EQUATE(065AH)                    !Ctrl-Alt-Z Key

CtrlAltF1        EQUATE(0670H)                    !Ctrl-Alt-F1 Key
CtrlAltF2        EQUATE(0671H)                    !Ctrl-Alt-F2 Key
CtrlAltF3        EQUATE(0672H)                    !Ctrl-Alt-F3 Key
CtrlAltF4        EQUATE(0673H)                    !Ctrl-Alt-F4 Key
CtrlAltF5        EQUATE(0674H)                    !Ctrl-Alt-F5 Key
CtrlAltF6        EQUATE(0675H)                    !Ctrl-Alt-F6 Key
CtrlAltF7        EQUATE(0676H)                    !Ctrl-Alt-F7 Key
CtrlAltF8        EQUATE(0677H)                    !Ctrl-Alt-F8 Key
CtrlAltF9        EQUATE(0678H)                    !Ctrl-Alt-F9 Key
CtrlAltF10       EQUATE(0679H)                    !Ctrl-Alt-F10 Key
CtrlAltF11       EQUATE(067AH)                    !Ctrl-Alt-F11 Key
CtrlAltF12       EQUATE(067BH)                    !Ctrl-Alt-F12 Key

CtrlAltAst       EQUATE(066AH)                    !Ctrl-Alt-Asterisk Key
CtrlAltBS        EQUATE(0608H)                    !Ctrl-Alt-Backspace Key
CtrlAltDecimal   EQUATE(066EH)                    !Ctrl-Alt-Decimal Key
CtrlAltDelete    EQUATE(062EH)                    !Ctrl-Alt-Delete Key
CtrlAltDown      EQUATE(0628H)                    !Ctrl-Alt-Cursor Down Key
CtrlAltEnd       EQUATE(0623H)                    !Ctrl-Alt-End Key
CtrlAltEnter     EQUATE(060DH)                    !Ctrl-Alt-Enter Key
CtrlAltEsc       EQUATE(061BH)                    !Ctrl-Alt-Esc Key
CtrlAltHome      EQUATE(0624H)                    !Ctrl-Alt-Home Key
CtrlAltInsert    EQUATE(062DH)                    !Ctrl-Alt-Insert Key
CtrlAltLeft      EQUATE(0625H)                    !Ctrl-Alt-Cursor Left Key
CtrlAltMinus     EQUATE(066DH)                    !Ctrl-Alt-Minus Key
CtrlAltPause     EQUATE(0613H)                    !Ctrl-Alt-Pause Key
CtrlAltPgDn      EQUATE(0622H)                    !Ctrl-Alt-PgDn Key
CtrlAltPgUp      EQUATE(0621H)                    !Ctrl-Alt-PgUp Key
CtrlAltPlus      EQUATE(066BH)                    !Ctrl-Alt-Plus Key
CtrlAltPrint     EQUATE(062CH)                    !Ctrl-Alt-PrintScreen Key
CtrlAltRight     EQUATE(0627H)                    !Ctrl-Alt-Cursor Right Key
CtrlAltSlash     EQUATE(066FH)                    !Ctrl-Alt-Slash Key
CtrlAltSpace     EQUATE(0620H)                    !Ctrl-Alt-Spacebar
CtrlAltTab       EQUATE(0609H)                    !Ctrl-Alt-Tab Key
CtrlAltUp        EQUATE(0626H)                    !Ctrl-Alt-Cursor Up Key

CtrlAltPad0      EQUATE(0660H)                    !Ctrl-Alt-0 on numeric keypad
CtrlAltPad1      EQUATE(0661H)                    !Ctrl-Alt-1 on numeric keypad
CtrlAltPad2      EQUATE(0662H)                    !Ctrl-Alt-2 on numeric keypad
CtrlAltPad3      EQUATE(0663H)                    !Ctrl-Alt-3 on numeric keypad
CtrlAltPad4      EQUATE(0664H)                    !Ctrl-Alt-4 on numeric keypad
CtrlAltPad5      EQUATE(0665H)                    !Ctrl-Alt-5 on numeric keypad
CtrlAltPad6      EQUATE(0666H)                    !Ctrl-Alt-6 on numeric keypad
CtrlAltPad7      EQUATE(0667H)                    !Ctrl-Alt-7 on numeric keypad
CtrlAltPad8      EQUATE(0668H)                    !Ctrl-Alt-8 on numeric keypad
CtrlAltPad9      EQUATE(0669H)                    !Ctrl-Alt-9 on numeric keypad


CtrlAltMouseLeft    EQUATE(0601H)                 !Ctrl-Alt-Left mouse button
CtrlAltMouseRight   EQUATE(0602H)                 !Ctrl-Alt-Right mouse button
CtrlAltMouseCenter  EQUATE(0603H)                 !Ctrl-Alt-Middle mouse button
CtrlAltMouseLeft2   EQUATE(0605H)                 !Ctrl-Alt-Left mouse double-click
CtrlAltMouseRight2  EQUATE(0606H)                 !Ctrl-Alt-Right mouse double-click
CtrlAltMouseCenter2 EQUATE(0607H)                 !Ctrl-Alt-Middle mouse double-click

  _EndOfInclude_
