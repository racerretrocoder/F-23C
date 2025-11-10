# COMP.nas
# Front Computer 
# Phoenix YF-23
setprop("YF23/glimit",9);
setprop("YF23/caslimit",800);
setprop("YF23/machlimit",2.85);
setprop("YF23/AFTCG",41.0);
setprop("YF23/AOA",20);
setprop("YF23/CG",590);
setprop("YF23/AOSS",10);
var digit1 = nil;
var digit2 = nil;
var digit3 = nil;
var digit4 = nil;
var digit5 = nil;
var digit6 = nil;
var clearnum = func{
    digit1 = nil;
    digit2 = nil;
    digit3 = nil;
    digit4 = nil;
    digit5 = nil;
    digit6 = nil;
    setprop("instrumentation/frontcontrols/digit1", 0);
    setprop("instrumentation/frontcontrols/digit2", 0);
    setprop("instrumentation/frontcontrols/digit3", 0);
    setprop("instrumentation/frontcontrols/digit4", 0);
    setprop("instrumentation/frontcontrols/digit5", 0);
    setprop("instrumentation/frontcontrols/digit6", 0);
    print("clear");
}
var addtoslots = func{
    # nil Detection
    if (digit1 == nil) {
    digit1 = 0;
    } elsif (digit2 == nil) {
    digit2 = 0;
    } elsif (digit3 == nil) {
    digit3 = 0;
    } elsif (digit4 == nil) {
    digit4 = 0;
    } elsif (digit5 == nil) {
    digit5 = 0;
    } elsif (digit6 == nil) {
    digit6 = 0;
    }
}
# Buttons
# Left row from bottom to top
var setnum = func(num){
    if (digit1 == nil) {
        setprop("instrumentation/frontcontrols/digit1", num);
        digit1 = num;
    } elsif (digit2 == nil) {
        setprop("instrumentation/frontcontrols/digit2", num);
        digit2 = num;
    } elsif (digit3 == nil) {
        setprop("instrumentation/frontcontrols/digit3", num);
        digit3 = num;
    } elsif (digit4 == nil) {
        setprop("instrumentation/frontcontrols/digit4", num);
        digit4 = num;
    } elsif (digit5 == nil) {
        setprop("instrumentation/frontcontrols/digit5", num);
        digit5 = num;
    } elsif (digit6 == nil) {
        setprop("instrumentation/frontcontrols/digit6", num);
        digit6 = num;
    }   
}


# Front Control Buttons

var UR1 = func() {

}
var UR2 = func() {
    
}
var UR3 = func() {

}
var UR4 = func() {
    if (getprop("COMP/menu") == 1) {
        setprop("COMP/menu",2);
    }
}
var UR5 = func() {
    
}
var UL1 = func() {

}
var UL2 = func() {
    
}
var UL3 = func() {
    
}
var UL4 = func() {
    
}
var UL5 = func() {
    
}


var one = func() {

}
var two = func() {
    
}
var three = func() {
    
}
var four = func() {
    
}
var five = func() {
    
}
var six = func() {
    
}
var seven = func() {
    
}
var eight = func() {
    
}
var nine = func() {
    
}
var ten = func() {
    
}

setprop("COMP/menu",1);
var mainloop = func() {
    var power = getprop("controls/electric/battswitch");
    var menu = getprop("COMP/menu");
    if (power == power) {
        if (menu == 1) {
            var bingo = getprop("f22/bingo");
            var TCN = getprop("instrumentation/tacan/display/channel");
            var COMM1 = getprop("instrumentation/comm/frequencies/selected-mhz");
            var COMM2 = getprop("instrumentation/comm[1]/frequencies/selected-mhz");
            var QNH = sprintf("% 6.2f", getprop("instrumentation/altimeter/setting-inhg"));
            setprop("COMP/text1","B " ~bingo~ "");setprop("COMP/text2","STR 18A"); # B [Bingo],STR [STPTID]
            setprop("COMP/text3","TCN " ~TCN~ "");setprop("COMP/text4",""); # TCN,[blank]
            setprop("COMP/text5","IFF 1/2/3");setprop("COMP/text6",""); # IFF 1/2/3,[blank]
            setprop("COMP/text7","QNH " ~QNH~ "");setprop("COMP/text8","ENVELOPE"); # QNH 29.95,ENVELOPE
            setprop("COMP/text9","U"~COMM1~"");setprop("COMP/text10","U"~COMM2~"G");# U[COMM1],U[COMM2]G
            setprop("COMP/text11","");setprop("COMP/text12","");# Supposed to be COMM Preset but just show KY58 status instead
        } 
        if (menu == 2) { # Envelope
            var GLIMIT = sprintf("% 6.2f", getprop("YF23/glimit"));
            var bingo = sprintf("% 6.2f", getprop("f22/bingo"));
            var CASLIM = sprintf("% 6.2f", getprop("YF23/caslimit"));
            var MLIMIT = sprintf("% 6.2f", getprop("YF23/machlimit"));
            var AFTCG = sprintf("% 6.2f", getprop("YF23/AFTCG"));
            var AOA = sprintf("% 6.2f", getprop("YF23/AOA"));
            var CG = sprintf("% 6.2f", getprop("YF23/CG"));
            var AOSS = sprintf("% 6.2f", getprop("YF23/AOSS"));
            var WT = 35000; # Static Zero Fuel Weight
            var TCN = getprop("instrumentation/tacan/display/channel");
            var COMM1 = getprop("instrumentation/comm/frequencies/selected-mhz");
            var COMM2 = getprop("instrumentation/comm[1]/frequencies/selected-mhz");
            var QNH = sprintf("% 6.2f", getprop("instrumentation/altimeter/setting-inhg"));

            setprop("COMP/text1","CAS " ~CASLIM~ "");setprop("COMP/text2","AFT CG " ~AFTCG~""); # B [Bingo],STR [STPTID]
            setprop("COMP/text3","M " ~MLIMIT~ "");setprop("COMP/text4","G LIM "~GLIMIT~""); # TCN,[blank]
            setprop("COMP/text5","AOA " ~AOA~ "");setprop("COMP/text6","CG "~CG~""); # IFF 1/2/3,[blank]
            setprop("COMP/text7","AOSS " ~AOSS~ "");setprop("COMP/text8","WT STATIC"); # QNH 29.95,ENVELOPE
            setprop("COMP/text9","U"~COMM1~"");setprop("COMP/text10","U"~COMM2~"G");# U[COMM1],U[COMM2]G
            setprop("COMP/text11","");setprop("COMP/text12","");# Supposed to be COMM Preset but just show KY58 status instead
        }
    } else {
        setprop("COMP/text1","");setprop("COMP/text2","");
        setprop("COMP/text3","");setprop("COMP/text4","");
        setprop("COMP/text5","");setprop("COMP/text6","");
        setprop("COMP/text7","");setprop("COMP/text8","");
        setprop("COMP/text9","");setprop("COMP/text10","");
        setprop("COMP/text11","");setprop("COMP/text12","");
    }
}


looptimer = maketimer(0.3,mainloop);
looptimer.start();