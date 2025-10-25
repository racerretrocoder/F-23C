#
# Experimental High Speed Intense Missile Jammer
#

# Written by Phoenix

# How it works. Constantly "Release invisible chaff and flares" as fast as possible. the goal here is protect the plane the best we can. 
# The attacker wont know the jammer is on because it wont show the flares out on multiplayer. There missile will just "miss"
# If the number is not nil or 0. then itll run an RNG every time the number changes and the targets missile code checks our number again


# INIT.
setprop("/rotors/main/blade[3]/flap-deg", 0);  #flare
setprop("/rotors/main/blade[3]/position-deg", 0); #chaff


# method 1
var method1 = func {
var flarerand = rand(); # random decimal from 0 to 1
  # every time these numbers change. the shooter runs chaff flare probability 
  # so if we change them really fast that will be good
setprop("/rotors/main/blade[3]/flap-deg", flarerand);  #flarerand
setprop("/rotors/main/blade[3]/position-deg", flarerand);
#settimer(func{
##etprop("/rotors/main/blade[3]/flap-deg", 0);
##etprop("/rotors/main/blade[3]/position-deg", 0);
#                },0.00001); # this may be the key to our speed
}

# Method1 results:
# DAMN THATS FAST!
#


# method 2
var method2 = func {
var flarerand = rand(); # random decimal from 0 to 1
  # every time these numbers change. the shooter runs chaff flare probability 
  # so if we change them really fast that will be good
setprop("/rotors/main/blade[3]/flap-deg", flarerand);
setprop("/rotors/main/blade[3]/position-deg", flarerand);
setprop("/rotors/main/blade[3]/flap-deg", 0);
setprop("/rotors/main/blade[3]/position-deg", 0);
}

# Method2 results:
# Nope. it just stayed at zero.
#

var method3 = func {

var flarerand = rand(); # random decimal from 0 to 1
  # every time these numbers change. the shooter runs chaff flare probability 
  # so if we change them really fast that will be good
setprop("/rotors/main/blade[3]/flap-deg", flarerand);
setprop("/rotors/main/blade[3]/position-deg", flarerand);
reset();
}

# Method3 results:
# same as method 2. failed 
# Stuck on zero. it runs too fast


# default method4
var method4 = func{
	var flarerand = rand(); # random decimal from 0 to 1
  # every time these numbers change. the shooter runs chaff flare probability 
  # so if we change them really fast that will be good
    setprop("/rotors/main/blade[3]/flap-deg", flarerand);  #flarerand
    setprop("/rotors/main/blade[3]/position-deg", flarerand);
settimer(func   {
    setprop("/rotors/main/blade[3]/flap-deg", 0);
    setprop("/rotors/main/blade[3]/position-deg", 0);
    #props.globals.getNode("/rotors/main/blade[3]/flap-deg").setValue(0);
    #props.globals.getNode("/rotors/main/blade[3]/position-deg").setValue(0);
                },0.1); # this may be the key to our speed
 
}

# Seems method1 is the fastest


var reset = func {
setprop("/rotors/main/blade[3]/flap-deg", 0);
setprop("/rotors/main/blade[3]/position-deg", 0);
}

var resetinf = func {
setprop("/rotors/main/blade[3]/flap-deg", 0);
setprop("/rotors/main/blade[3]/position-deg", 0);
method5(); # inf loop! goes back to rand
}

# Method 5 (chaos) USE WITH CAUTION!
var method5 = func { 
# infinate loop call1 function then call another
var flarerand = rand(); # random decimal from 0 to 1
  # every time these numbers change. the shooter runs chaff flare probability 
  # so if we change them really fast that will be good
setprop("/rotors/main/blade[3]/flap-deg", flarerand);
setprop("/rotors/main/blade[3]/position-deg", flarerand);
resetinf();
}






method1timer = maketimer(0.00001,method1);
method1timerwithzero = maketimer(0,method1);
method2timer = maketimer(0.00001,method2);
method3timer = maketimer(0.00001,method3);
method4timer = maketimer(0.00001,method4);


var start = func {
method1timerwithzero.start();
setprop("sim/messages/atc","Jammer running");
}

var stop = func {
method1timerwithzero.stop();
setprop("sim/messages/atc","Jammer stopped");
}




var silentstart = func {
method1timerwithzero.start();
}

var silentstop = func {
method1timerwithzero.stop();
screen.log.write("No Infrared Stealth",1,0,0);
}


# Ready statement
print("jammer.nas - Ready for action >:)");
# ====================== End jammer.nas ====================== # 