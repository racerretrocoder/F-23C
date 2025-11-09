setprop("autopilot/internal/target-roll-deg-aitrack",0);
var absoluteRoll = func() {
    var roll = getprop("orientation/model/roll-deg");
    var absroll = math.abs(roll);
    setprop("orientation/aitrack/roll-deg-abs",absroll);
    if (roll < 0) {
        # Left
        var direction = -1;
        setprop("orientation/aitrack/roll-deg-added",roll + 360);
    } else {
        # Right
        var direction = 1;
        setprop("orientation/aitrack/roll-deg-added",roll);
    }
    setprop("orientation/aitrack/direction",direction);
    if (getprop("autopilot/locks/heading") == "aitrack") {
        if (getprop("autopilot/internal/target-roll-deg-aitrack") > 179) {
            setprop("orientation/aitrack/use-mode",2);
        } else {
            setprop("orientation/aitrack/use-mode",1);
        }
    } else {
        setprop("orientation/aitrack/use-mode",1);
    }
}




rolltimer = maketimer(0,absoluteRoll);
rolltimer.start();