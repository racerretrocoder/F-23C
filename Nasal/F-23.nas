# PHD's TC range switch (hard coded range in nautical miles)
# ----------------------------------------------------------
var PHD_TCrange_sw = func {
	var prop = props.globals.getNode(arg[0], 1);
	var pr = prop.getValue();
	var target = props.globals.getNode("/sim/model/F-23C/instrumentation/PHD/TCrange", 1);
	if (arg[1] == 1) {
		if (pr == 0) {
			prop.setDoubleValue(1);
			target.setDoubleValue(5);
		} elsif (pr == 1) {
			prop.setDoubleValue(2);
			target.setDoubleValue(1.5);
		}
	} else {
		if (pr == 1) {
			prop.setDoubleValue(0);
			target.setDoubleValue(10);
		} elsif (pr == 2) {
			prop.setDoubleValue(1);
			target.setDoubleValue(5);
		}
	}
}



##### Terrain Follow Switch and Prty toggle switch
#
var ter_follow = func(number){

var terflw = getprop("controls/switches/terrain-follow");
var terflwmap = getprop("controls/switches/terrain-follow-map");

if(terflw == 1) {
	if(terflwmap == 0) {
	setprop("autopilot/locks/altitude", "agl-hold");
        setprop("controls/switches/terrain-follow-map-enabled", 0);#triggers the submodels radarpulse off

} elsif (terflwmap == 1) {
	setprop("autopilot/locks/altitude", "vertical-speed-hold");
        setprop("controls/switches/terrain-follow-map-enabled", 1);#triggers the submodels radarpulse on
}
} elsif(terflw == 0) {
	setprop("autopilot/locks/altitude", "");
        setprop("controls/switches/terrain-follow-map-enabled", 0);
}
} # End Function

#
##### Terrain Avoid Switch
#
var ter_avoid_switch = func {
var   tas = getprop("controls/switches/terrain-avoid");
var   rs = getprop("controls/switches/terrain-avoid-rng");

if (tas == 1) {
    if (rs == 0) {
    setprop("controls/switches/terrain-avoid-rng-25", 1);
    setprop("controls/switches/terrain-avoid-rng-50", 0);
  } elsif (rs == 1) {
    setprop("controls/switches/terrain-avoid-rng-25", 0);
    setprop("controls/switches/terrain-avoid-rng-50", 1);
     }
} else {
   setprop("controls/switches/terrain-avoid-rng-25", 0);
   setprop("controls/switches/terrain-avoid-rng-50", 0);
}
}
#
##### Terrain Avoid Toggle Radar Dist Switch
#
var radar_switch = func {
var rs = getprop("controls/switches/terrain-avoid-rng");
var tas = getprop("controls/switches/terrain-avoid");
   if(tas == 1) {
   if(rs == 0) {
   setprop("controls/switches/terrain-avoid-rng-25", 1);
   setprop("controls/switches/terrain-avoid-rng-50", 0);
} elsif (rs == 1) {
   setprop("controls/switches/terrain-avoid-rng-50", 1);
   setprop("controls/switches/terrain-avoid-rng-25", 0);
}
}
}

#
##### Terrain Avoid Toggle Radar Clearance
#
var radar_clrpln = func {

var rcs = getprop("controls/switches/terrain-avoid-clrpln");

if(rcs == 0) {
setprop("controls/switches/terrain-avoid-clr1000", 0);
}
if(rcs == 0.25) {
setprop("controls/switches/terrain-avoid-clr1000", 100);
}
if(rcs == 0.5) {
setprop("controls/switches/terrain-avoid-clr1000", 300);
}
if(rcs == 0.75) {
setprop("controls/switches/terrain-avoid-clr1000", 500);
}
if(rcs == 1.0) {
setprop("controls/switches/terrain-avoid-clr1000", 1000);
}

}

#
##### Terrain Follow Radar Clearance
#
var radar_setclr = func(number) {

var sclr = getprop("controls/switches/terrain-follow-setclr");
var oldclr = getprop("controls/switches/terrain-follow-clr");
if((number == 1) and (oldclr < 2000)) {
var newclr = (oldclr + 200);
setprop("controls/switches/terrain-follow-clr", newclr);
setprop("autopilot/settings/target-agl-ft", newclr);
} elsif((number == 0) and (oldclr > 0)) {
var newclr = (oldclr - 200);
setprop("controls/switches/terrain-follow-clr", newclr);
setprop("autopilot/settings/target-agl-ft", newclr);
}
}
#

##### Terrain Avoidance Radar Pulse (inspired from vulcanb2)
#

settimer(func {

  # Add listener for radar pulse contactm0d
  setlistener("sim/radar/teravd/contactm0d", func(n) {
    var contactm0d = n.getValue();
#    var solid = getprop(contactm0d ~ "/material/solid");
    
#    if (solid)
#    {
      var long = getprop(contactm0d ~ "/impact/longitude-deg");
      var lat = getprop(contactm0d ~ "/impact/latitude-deg");
      var elev_m = getprop(contactm0d ~ "/impact/elevation-m");
      var spd = getprop(contactm0d ~ "/impact/speed-mps");
      var time = getprop(contactm0d ~ "/sim/time/elapsed-sec");
      var elev_ft = int(elev_m * 3.28);
      var dist_ft = int(spd * time * 3.28);
      setprop("instrumentation/teravd/elevationm0d", elev_ft);
      setprop("instrumentation/teravd/distancem0d", dist_ft);

    settimer(teravd_m0d, 0);

#    }
  });
}, 0);

settimer(func {

  # Add listener for radar pulse contactm4d
  setlistener("sim/radar/teravd/contactm4d", func(n) {
    var contactm4d = n.getValue();
#    var solid = getprop(contactm4d ~ "/material/solid");
    
#    if (solid)
#    {
      var long = getprop(contactm4d ~ "/impact/longitude-deg");
      var lat = getprop(contactm4d ~ "/impact/latitude-deg");
      var elev_m = getprop(contactm4d ~ "/impact/elevation-m");
      var spd = getprop(contactm4d ~ "/impact/speed-mps");
      var time = getprop(contactm4d ~ "/sim/time/elapsed-sec");
      var elev_ft = int(elev_m * 3.28);
      var dist_ft = int(spd * time * 3.28);
      setprop("instrumentation/teravd/elevationm4d", elev_ft);
      setprop("instrumentation/teravd/distancem4d", dist_ft);

     settimer(teravd_m4d, 0);

#    }
  });
}, 0);

settimer(func {

  # Add listener for radar pulse contactm20d
  setlistener("sim/radar/teravd/contactm20d", func(n) {
    var contactm20d = n.getValue();
#    var solid = getprop(contactm20d ~ "/material/solid");
    
#    if (solid)
#    {
      var long = getprop(contactm20d ~ "/impact/longitude-deg");
      var lat = getprop(contactm20d ~ "/impact/latitude-deg");
      var elev_m = getprop(contactm20d ~ "/impact/elevation-m");
      var spd = getprop(contactm20d ~ "/impact/speed-mps");
      var time = getprop(contactm20d ~ "/sim/time/elapsed-sec");
      var elev_ft = int(elev_m * 3.28);
      var dist_ft = int(spd * time * 3.28);
      setprop("instrumentation/teravd/elevationm20d", elev_ft);
      setprop("instrumentation/teravd/distancem20d", dist_ft);

     settimer(teravd_m20d, 0);

#    }
  });
}, 0);


# control alt while climb and trigger end of climb

var teravd_m0d = func {
var calt = getprop("position/altitude-ft");
var cspd = getprop("velocities/groundspeed-kt");
var talt = getprop("autopilot/settings/target-altitude-ft");
var tvfpm = getprop("autopilot/settings/vertical-speed-fpm");
var rdist25 = getprop("controls/switches/terrain-avoid-rng-25");
var rdist50  = getprop("controls/switches/terrain-avoid-rng-50");

var elem0d = getprop("instrumentation/teravd/elevationm0d");
var distm0d = getprop("instrumentation/teravd/distancem0d");
var clr = getprop("controls/switches/terrain-avoid-clr1000");

if (rdist25 = 1) {
  var rdist = 15000;
  } elsif (rdist50 = 1) {
  var rdist = 30000;
}
var daltm0d = ((elem0d + clr) - calt);

if ((distm0d < rdist) and (daltm0d > 0)) {
  var talt = calt + daltm0d;
  var itime = distm0d / (cspd * 1.6878);
  var tvfpm = int((daltm0d) / (itime / 2)) * 60;
  setprop("instrumentation/teravd/target-vfpm", tvfpm);
  setprop("instrumentation/teravd/target-alt", talt);
  setprop("controls/switches/terra-report", 1);
  settimer(setvfpm, 0);
}
}


var teravd_m4d = func {
#var cpitch = getprop("orientation/pitch-deg");
var calt = getprop("position/altitude-ft");
var cspd = getprop("velocities/groundspeed-kt");
var talt = getprop("autopilot/settings/target-altitude-ft");
var tvfpm = getprop("autopilot/settings/vertical-speed-fpm");
var rdist25 = getprop("controls/switches/terrain-avoid-rng-25");
var rdist50  = getprop("controls/switches/terrain-avoid-rng-50");

var elem4d = getprop("instrumentation/teravd/elevationm4d");
var distm4d = getprop("instrumentation/teravd/distancem4d");
var clr = getprop("controls/switches/terrain-avoid-clr1000");

var evfpm = getprop("instrumentation/teravd/target-vfpm");
var etalt = getprop("instrumentation/teravd/target-alt");

if (rdist25 = 1) {
  var rdist = 15000;
  } elsif (rdist50 = 1) {
  var rdist = 30000;
}

var daltm4d = ((elem4d + clr) - calt);

if ((distm4d < rdist) and (daltm4d > 0)) {
var talt = calt + daltm4d;
var itime = distm4d / (cspd * 1.6878);
var tvfpm = int((daltm4d) / ((itime * 2) / 3)) * 60;

if (etalt < talt) {
  setprop("instrumentation/teravd/target-alt", talt);
}
if (evfpm < tvfpm) {
  setprop("instrumentation/teravd/target-vfpm", tvfpm);
}
setprop("controls/switches/terra-report", 1);
settimer(setvfpm, 0);
}
}

var teravd_m20d = func {
var calt = getprop("position/altitude-ft");
var cspd = getprop("velocities/groundspeed-kt");
var talt = getprop("autopilot/settings/target-altitude-ft");
var tvfpm = getprop("autopilot/settings/vertical-speed-fpm");
var rdist25 = getprop("controls/switches/terrain-avoid-rng-25");
var rdist50  = getprop("controls/switches/terrain-avoid-rng-50");

var evfpm = getprop("instrumentation/teravd/target-vfpm");
var etalt = getprop("instrumentation/teravd/target-alt");

var elem20d = getprop("instrumentation/teravd/elevationm20d");
var distm20d = getprop("instrumentation/teravd/distancem20d");
var clr = getprop("controls/switches/terrain-avoid-clr1000");
var prty = getprop("controls/switches/terrain-follow-map-enabled");

if (rdist25 = 1) {
var rdist2 = 15000;
} elsif (rdist50 = 1) {
  var rdist2 = 30000;
}

var daltm20d = ((elem20d + clr) - calt);

if ((distm20d < rdist2) and (daltm20d > 0)) {
  var talt = calt + daltm20d;
  var itime = distm20d / (cspd * 1.6878);
  var tvfpm = int((daltm20d) / (itime / 2)) * 60;

if (etalt < talt) {
  setprop("instrumentation/teravd/target-alt", talt);
}
if (evfpm < tvfpm) {
  setprop("instrumentation/teravd/target-vfpm", tvfpm);
}
setprop("controls/switches/terra-report", 1);
settimer(setvfpm, 0);
}

}


var setvfpm = func {
var calt = getprop("position/altitude-ft");
var talt = getprop("instrumentation/teravd/target-alt");
var tvfpm = getprop("instrumentation/teravd/target-vfpm");

setprop("controls/switches/apmode/alt-hold", 0);
setprop("controls/switches/apmode/ptch-hold", 0);
setprop("controls/switches/apmode/vfpm-hold", 0);
setprop("autopilot/settings/vertical-speed-fpm", tvfpm);
setprop("autopilot/locks/altitude", "vertical-speed-hold");
if (calt > talt) {
  setprop("autopilot/settings/vertical-speed-fpm", 0);
  setprop("controls/switches/terra-report", 0);
  setprop("instrumentation/teravd/target-vfpm", 0);
  setprop("instrumentation/teravd/target-alt", 0);
  #settimer(aglreinit, 0);
} else {
  settimer(setvfpm, 0.5);
  }
}



#
# APU Startup Sequencing
#


# play sound
# first open flaps
setprop("controls/apu/run",0);
var apuseq1 = func() {
  # APU Animation/sequence !
  setprop("controls/apu/start",1);
  setprop("controls/apu/flap",1);
  seq2timer.start();
}

var apuseq2 = func() {
  # APU Animation/sequence !
  setprop("controls/apu/start",1);
  seq2timer.stop();
  seq3timer.start();
}

var apuseq3 = func() {
  # APU Animation/sequence !
  setprop("controls/apu/smokespeed",10);
  setprop("controls/apu/smoke",1);
  seq3timer.stop();
  seq4timer.start();
}

var apuseq4 = func() {
  # APU Animation/sequence !
  setprop("controls/apu/smoke",0);
  setprop("controls/apu/apuflame",1);
  seq4timer.stop();
  seq5timer.start();
}

var apuseq5 = func() {
  # APU Animation/sequence !
  setprop("controls/apu/smoke",1);
  setprop("controls/apu/apuflame",0);
  setprop("controls/apu/smoke",0);
  seq5timer.stop();
  seq6timer.start();
}

var apuseq6 = func() {
  # APU Animation/sequence !
  setprop("controls/apu/smoke",1);
  seq6timer.stop();
  seq7timer.start();
}
var apuseq7 = func() {
  # APU Animation/sequence !
  setprop("controls/apu/smoke",0);
  seq7timer.stop();
  seq8timer.start();
}
var apuseq8 = func() {
  # APU Animation/sequence !
  setprop("controls/apu/run",1);
  setprop("controls/electric/apustart",0); # Return to run
  setprop("controls/electric/apustartpos",0); # Return to run
  setprop("controls/apu/start",0);
  #apuon();
  seq8timer.stop();
  #seq8timer.start();
}

var apushutoffmain = func() {
  # APU Animation/sequence !
  setprop("controls/apu/startinprogress",0);
  setprop("controls/apu/run",0);

  setprop("controls/apu/spooldown",1);
  offtimer.start();
  #seq8timer.start();
}

var apushutoff = func() {
  # APU Animation/sequence !
  setprop("controls/apu/spooldown",2); # Stop the sound
  setprop("controls/apu/flap",0); # Close the flaps
  offtimer.stop();
  #seq8timer.start();
}

# Timers

seq2timer = maketimer(0.3,apuseq2);
seq3timer = maketimer(0.4,apuseq3);
seq4timer = maketimer(0.5,apuseq4);
seq5timer = maketimer(0.5,apuseq5);
seq6timer = maketimer(2,apuseq6);
seq7timer = maketimer(0.5,apuseq7);
seq8timer = maketimer(10,apuseq8);
offtimer = maketimer(16,apushutoff);
#apudoortimer = maketimer(, apuseq1);

setprop("controls/apu/startinprogress",0);


# Electric system for the engines and the APU:

# Detect the status of the main power switch. then check if the engines are dead. 
# if all's good. start the engines
# Controls the battery switch, APU, and Engine start switches and there effectiveness (If they work or not)

setprop("f22/bingo",4000);
var checkbingo = func() {
  if (getprop("consumables/fuel/total-fuel-lbs") < getprop("f22/bingo")){
    setprop("f22/isbingo",1);
  } else {
    setprop("f22/isbingo",0);
  }
}

var engloop = func{
setprop("sim/multiplay/visibility-range-nm",2000); # Going to put this here because smh the -set dosent set it to be 1000


if (getprop("controls/engines/engine/throttle") > 0.5) {
  print("APU Spring off");
  setprop("controls/electric/apustartpos",-1);
  setprop("controls/electric/apustart",-1);
}


var starter = getprop("controls/electric/engcrank");
if (starter == 1) {
  var jfsr = 1;
  var jfsl = 0;
  print("CRANK: Right");
}
if (starter == 0) {
  var jfsr = 0;
  var jfsl = 0;
}
if (starter == -1) {
  var jfsr = 0;
  var jfsl = 1;
  print("CRANK: Left");
}

var bat = getprop("controls/electric/battswitch");
#print("In ENGINE LOOP!");
            if(getprop("controls/electric/battswitch") >= 1) {
                # check the APU the apu
                if(getprop("/controls/apu/startinprogress") == 0) {

                if(getprop("/controls/electric/apustart") == 1) {
                      # Start the APU
                      print("starting APU!");
                      apuseq1();
                      setprop("controls/apu/startinprogress",1);
                }
              }
                if(getprop("/controls/apu/startinprogress") == 1) {

                if(getprop("/controls/electric/apustart") == -1) {
                      # Stop the APU
                      print("stopping APU!");
                      apushutoffmain();
#setprop("controls/apu/startinprogress",1);
                }
              }
              if(getprop("/engines/engine/n1") < 28) {
              setprop("/controls/engines/engine/starter",jfsr);
              print("eng1 rebound disarmed");
            }

            if(getprop("/engines/engine[1]/n1") < 28) {
              setprop("/controls/engines/engine[1]/starter",jfsl);
              print("eng2 rebound disarmed");
            } 



            if(getprop("/engines/engine/n1") > 28) {
              # Rebound the switches when its good
              setprop("controls/electric/engine/start-r",getprop("/controls/engines/engine/starter"));
              if (jfsr == 1) {
                setprop("controls/electric/engcrank",0);
                setprop("controls/electric/engcrankpos",0);
              }
              #print("eng1 rebound armed");
            }

            if(getprop("/engines/engine[1]/n1") > 28) {

              # Rebound the switches when its good
              setprop("controls/electric/engine/start-l",getprop("/controls/engines/engine[1]/starter"));
              if (jfsl == 1) {
                setprop("controls/electric/engcrank",0);
                setprop("controls/electric/engcrankpos",0);
              }
              #print("eng2 rebound armed");
            } 

            }
}



# What happens when the radar Locks on, Goes into STT and spikes target (see lockhelper.nas)
# Also controls the radar mode, Scanning settings, Azimuth, Speed, etc
var tgtlock = func{
if (getprop("instrumentation/radar/lock") == 1){
var target1_x = radar.tgts_list[radar.Target_Index].TgtsFiles.getNode("h-offset",1).getValue();
var target1_z = radar.tgts_list[radar.Target_Index].TgtsFiles.getNode("v-offset",1).getValue();
setprop("instrumentation/radar2/lockmarker", target1_x / 10);
setprop("instrumentation/radar2/lockmarker", target1_x / 10);
#setprop("instrumentation/radar/az-field", 161);
# setprop("instrumentation/radar/grid", 0);
#print(target1_x / 10);
setprop("instrumentation/radar2/sweep-speed", 10);
setprop("instrumentation/radar/lock2", 2);
  } elsif (getprop("instrumentation/radar/lock") == 0){
    if(getprop("instrumentation/radar/mode/main") == 3)
    {   # SLR
        setprop("instrumentation/radar/az-field", 280);
        setprop("instrumentation/radar2/sweep-display-width", 0.1646);        
        setprop("instrumentation/radar2/sweep-speed", 2);   
        #acmtimer.stop();
      #  wcs_mode = "pulse-srch";
      #  AzField.setValue(120);
      #  swp_diplay_width = 0.0844;
    }  
    if(getprop("instrumentation/radar/mode/main") == 1)
    {   # RWS
        setprop("instrumentation/radar/az-field", 120);
        setprop("instrumentation/radar2/sweep-display-width", 0.0846);        
        setprop("instrumentation/radar2/sweep-speed", 1);   
        #acmtimer.stop();
      #  wcs_mode = "pulse-srch";
      #  AzField.setValue(120);
      #  swp_diplay_width = 0.0844;
    }
    elsif(getprop("instrumentation/radar/mode/main") == 0)
    {
        setprop("instrumentation/radar/az-field", 60);
        # TWS
        setprop("instrumentation/radar2/sweep-display-width", 0.0446);        
        setprop("instrumentation/radar2/sweep-speed", 1);   
        tgts_list = [];
        #acmtimer.stop();
    }
    elsif(getprop("instrumentation/radar/mode/main") == 2)
    {
        setprop("instrumentation/radar/az-field", 60);
        # ACM
        #acmtimer.start();
        setprop("instrumentation/radar2/sweep-display-width", 0.0446);        
        setprop("instrumentation/radar2/sweep-speed", 2);   
        tgts_list = [];
    }

    
  }
}


# HOFFSET -6,

var checkclosestmp = func(cs=nil) {
setprop("misc/closestmp", 100000); # reset
  setprop("misc/callsign","abcdefghijk"); # reset
  var list = props.globals.getNode("/ai/models").getChildren("multiplayer");
  var total = size(list);
  var mpid = 0;
  var theprop = getprop("misc/closestmp");
  for(var i = 0; i < total; i += 1) {
      var mpid = i;
      var callsign = getprop("ai/models/multiplayer[" ~ mpid ~ "]/callsign");
      var inrange = getprop("ai/models/multiplayer[" ~ mpid ~ "]/radar/in-range");
      if (inrange == 1){
      var range = getprop("ai/models/multiplayer[" ~ mpid ~ "]/radar/range-nm");
      } else {
      var range = 99999; # mm yes lol
      }

      print("checking " ~ callsign ~ "");
      if (getprop("misc/closestmp") == 100000) {
        # Has been reset
        #screen.log.write("Begin mpsearch");
        #screen.log.write(i);
       #screen.log.write(callsign);
        setprop("misc/closestmp", range); # reset
        setprop("misc/callsign",callsign);

      } else {
        # Range has been changed lets check
       #screen.log.write(i);

        if (getprop("misc/closestmp") > range) {
          #screen.log.write("Found new closer target!");
           #screen.log.write(callsign);
          setprop("misc/closestmp", range);          
          setprop("misc/callsign",callsign);
        }
      }

  }
}


# ACM "Dogfight mode"
# Still experimental
# Debug messages left on
var radarlook = func(cs=nil) {
  var list = props.globals.getNode("/instrumentation/radar2/targets").getChildren("multiplayer");
  var total = size(list);
  var mpid = 0;
  print("ACM Dogfight mode Debug!");
  for(var i = 0; i < total; i += 1) {
      var mpid = i;
      print(mpid);
      if (getprop("instrumentation/radar2/targets/multiplayer[" ~ mpid ~ "]/h-offset") == nil) {
        print("thats nil!");
      }
      var callsign = getprop("ai/models/multiplayer[" ~ mpid ~ "]/callsign");
      if (getprop("instrumentation/radar2/targets/multiplayer[" ~ mpid ~ "]/callsign") == nil or getprop("instrumentation/radar2/targets/multiplayer[" ~ mpid ~ "]/callsign") == "") {
        print("radar callsign nil!");
      }
      if (getprop("instrumentation/radar/lock") == 1){
        print("radar is already locked");
        return 1;
      }

      #print("checking " ~ callsign ~ ".");
      var radarON = 1;
      var target1_x = getprop("instrumentation/radar2/targets/multiplayer[" ~ mpid ~ "]/h-offset");
      var target1_z = getprop("instrumentation/radar2/targets/multiplayer[" ~ mpid ~ "]/v-offset");
      if (target1_x or 0 > 0 and radarON ==1)
      {
        var dist_O = math.sqrt(math.pow(target1_x, 2)+math.pow(target1_z, 2));
        var oriAngle = math.asin(target1_x / dist_O);
        if(target1_z < 0){
          oriAngle = 3.141592654 - oriAngle;
        }
        var Rollrad = (getprop("orientation/roll-deg") / 180) * 3.141592654;
        target1_x = dist_O * math.sin(oriAngle - Rollrad);
        target1_z = dist_O * math.cos(oriAngle - Rollrad);
        var kx = abs(target1_x/7.25);
        var kz = abs(target1_z/6);
        if((kx > 1) or (kz > 1)){
          if(kx > kz){
            target1_x = target1_x / kx;
            target1_z = target1_z / kx;
          }else{
            target1_z = target1_z / kz;
            target1_x = target1_x / kz;
          }
        }
#screen.log.write("x");
#screen.log.write(target1_x);
#screen.log.write("z");
#screen.log.write(target1_z); 
        # Z +6 -6
        # X +5 -5
        # i
        if (target1_x > -6 and target1_x < 6 and target1_z > -6 and target1_z < 6) {
          # Target is in the hud
          screen.log.write("Radar ACM: Can lock! Locking...");
          screen.log.write(callsign);
          #checkcloestmp("");
          #        screen.log.write("Radar: Locked "~tgts_list[Target_Index].Callsign.getValue(),1,1,0);''
         
          var radarcs = radar.tgts_list[radar.Target_Index].Callsign.getValue();
          acmcheck(radarcs,mpid,total);
          break;
        }
     }
  }
}


var acmcheck = func(radarcs,mpid,total) {
  screen.log.write("acm dbug: in here now");
  screen.log.write("total:" ~ total);
  screen.log.write("radarcs:" ~ radarcs);
  screen.log.write("mpid:" ~ mpid);
  for(var i = 0; i < total; i += 1) {
    #screen.log.write("Iteration: "~i~".");
    if (radarcs != getprop("ai/models/multiplayer[" ~ mpid ~ "]/callsign")) {
      #screen.log.write("Dosent match!");
      radar.next_Target_Index(1);
    } else {
      screen.log.write("Radar: ACM Locked "~radar.tgts_list[radar.Target_Index].Callsign.getValue());
      setprop("instrumentation/radar/lock", 1);
      break;
    }
  }
}

# Cool arrow pointer
setprop("controls/radar/lockedinhud",0);
var arrowpointer = func() {      
  var radarON = getprop("su-27/instrumentation/N010-radar/emitting");
  # First check if radar on and locked. else go away
  if (radarON != 1 or getprop("/instrumentation/radar/lock") != 1){
    return -1;
  }
  var target1_x = radar.tgts_list[radar.Target_Index].TgtsFiles.getNode("h-offset",1).getValue();
  var target1_z = radar.tgts_list[radar.Target_Index].TgtsFiles.getNode("v-offset",1).getValue();
  var lockedcallsign = radar.tgts_list[radar.Target_Index].TgtsFiles.getNode("callsign",1).getValue();
  if (target1_x or 0 > 0 and radarON == 1) {
    var dist_O = math.sqrt(math.pow(target1_x, 2)+math.pow(target1_z, 2));
    var oriAngle = math.asin(target1_x / dist_O);
    if(target1_z < 0){
      oriAngle = 3.141592654 - oriAngle;
    }
    var Rollrad = (getprop("orientation/roll-deg") / 180) * 3.141592654;
    target1_x = dist_O * math.sin(oriAngle - Rollrad);
    target1_z = dist_O * math.cos(oriAngle - Rollrad);
    var kx = abs(target1_x/7.25);
    var kz = abs(target1_z/6);
    if((kx > 1) or (kz > 1)){
      if(kx > kz){
        target1_x = target1_x / kx;
        target1_z = target1_z / kx;
      }else{
        target1_z = target1_z / kz;
        target1_x = target1_x / kz;
      }
    }
    if (target1_x > -6 and target1_x < 6 and target1_z > -6 and target1_z < 6) {
        # Target in the hud
        #screen.log.write("In HUD");
        setprop("/controls/radar/hud-pointer",0);
        setprop("/controls/radar/hud-rotate",0);
    } else {
        # Target not in hud
        setprop("/controls/radar/hud-pointer",1); # show arrow
        #screen.log.write(lockedcallsign);
        #screen.log.write(target1_x);
        #screen.log.write(target1_z);
        setprop("/controls/radar/error-deg",target1_x);
        setprop("/controls/radar/error-pitch-deg",target1_z);

    }
  }
}








# reinit previous flight params
#var aglreinit = func {
#var terflw = getprop("controls/switches/terrain-follow");
#setprop("controls/switches/terra-report", 0);
#if(terflw == 1) {
#  setprop("autopilot/locks/altitude", "vertical-speed-hold");
#} elsif {
#  setprop("autopilot/locks/altitude", "vertical-speed-hold");
  #setprop("autopilot/locks/altitude", "altitude-hold");
# }
#}
### end of terrain avoidance behaviour #########################

locktgt_timer = maketimer(0.1, tgtlock);
acmtimer = maketimer(0.5,radarlook);
timer_eng = maketimer(0.25, engloop);
bingotimer = maketimer(0.3,checkbingo);
setlistener("sim/signals/fdm-initialized", func {
# Spawned in/went to location
locktgt_timer.start();
timer_eng.start();
bingotimer.start();
});