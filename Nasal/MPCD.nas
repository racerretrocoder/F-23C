# MPCD.nas
# Phoenix | YF-23 Multi Purpose Color Display's

var R1 = func() {
var page = getprop("controls/MPCD/Rpage");
    if (page == 0) {
        setprop("controls/MPCD/Rpage",1); 
    }
}

var R2 = func() {
    var page = getprop("controls/MPCD/Rpage");
    if (page == 0) {
        setprop("controls/MPCD/Rpage",2);
    }
}

var R3 = func() {
    var page = getprop("controls/MPCD/Rpage");
    if (page == 0) {
        setprop("controls/MPCD/Rpage",3); # Engine
    }
}

var R4 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R5 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R6 = func() {
    var page = getprop("controls/MPCD/Rpage");
    if (page == 6) {
        # change radar mode
        radar.radar_mode_toggle();
    }
    if (page == 0) {
        setprop("controls/MPCD/Rpage",6);
    }
}

var R7 = func() {
    var page = getprop("controls/MPCD/Rpage");
    if (page == 6) {
        # radar grid / plane
        var grid = getprop("instrumentation/radar/grid");
        print(grid);
        if(grid == 1)
        {
        setprop("instrumentation/radar/grid", 0); # turn off the grid
        }
        elsif(grid == 0)
        {
        setprop("instrumentation/radar/grid", 1); # Turn on the grid
        }
    }
}

var R8 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R9 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R10 = func() {
    var page = getprop("controls/MPCD/Rpage");

    if (page == 3) {
        setprop("controls/MPCD/Rpage",0);
    }
}

var R11 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R12 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R13 = func() {
    var page = getprop("controls/MPCD/Rpage");
    if (page == 6) {
        # return to menu from radar
        setprop("controls/MPCD/Rpage",0);
    }
}

var R14 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R15 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R16 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R17 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R18 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R19 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var R20 = func() {
    var page = getprop("controls/MPCD/Rpage");
}

var Rpower = func() {
    if (getprop("controls/MPCD/Rpower") == 0){
        setprop("controls/MPCD/Rpower",1);
    } else {
        setprop("controls/MPCD/Rpower",0);
    }
}


var L1 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L2 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L3 = func() {
    var page = getprop("controls/MPCD/Lpage");
    if (page == 0) {
        setprop("controls/MPCD/Lpage",3); # Engine
    }
}

var L4 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L5 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L6 = func() {
    var page = getprop("controls/MPCD/Lpage");
    if (page == 6) {
        # change radar mode
        radar.radar_mode_toggle();
    }
    if (page == 0) {
        setprop("controls/MPCD/Lpage",6);
    }
}

var L7 = func() {
    var page = getprop("controls/MPCD/Lpage");
    if (page == 6) {
        # radar grid / plane
        var grid = getprop("instrumentation/radar/grid");
        print(grid);
        if(grid == 1)
        {
        setprop("instrumentation/radar/grid", 0); # turn off the grid
        }
        elsif(grid == 0)
        {
        setprop("instrumentation/radar/grid", 1); # Turn on the grid
        }
    }
}

var L8 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L9 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L10 = func() {
    var page = getprop("controls/MPCD/Lpage");
    if (page == 3) {
        setprop("controls/MPCD/Lpage",0);
    }
}

var L11 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L12 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L13 = func() {
    var page = getprop("controls/MPCD/Lpage");
    if (page == 6) {
        # return to menu from radar
        setprop("controls/MPCD/Lpage",0);
    }
}

var L14 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L15 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L16 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L17 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L18 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L19 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var L20 = func() {
    var page = getprop("controls/MPCD/Lpage");
}

var Lpower = func() {
    if (getprop("controls/MPCD/Lpower") == 0){
        setprop("controls/MPCD/Lpower",1);
    } else {
        setprop("controls/MPCD/Lpower",0);
    }
}
