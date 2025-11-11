var fire = func(ae,aeb) {
    print(ae);
    print(aeb);
}
setprop("heat/heatmsg",1); # Auto say it the first time
# INIT radar2.nas
myRadar = radar.Radar.new();
myRadar.init();


var acmtimer = YF23.acmtimer;


var heatloop = func() {
    var throttle = getprop("controls/engines/engine/throttle");
    if (throttle < 0.60) {
        if (getprop("heat/heatmsg") == 1) {
            screen.log.write("Engine set to ISP",0,1,0);
            jammer.silentstart(); # Only run once!
        }
        setprop("heat/heatmsg",0);
    } else {
        if (getprop("heat/heatmsg") == 0) {
            jammer.silentstop(); # Only run once!
        }
        setprop("heat/heatmsg",1);
    }
}

heattimer = maketimer (0,heatloop);
heattimer.start();