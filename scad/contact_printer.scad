
//include <./lamp.scad>;
//include <./box_laser.scad>;
include <./common/common.scad>;
include <./common/motors.scad>;
include <./common/2020_tslot.scad>;
include <./takeup/takeup.scad>;
include <./sprocketed_roller/sprocketed_roller_var.scad>;

IN = 25.4;

16mmFilmStandard = 10.26;
16mmFilmFull = 16;

FrameX = 300;
FrameY = 175;
FrameZ = -16;

Sprockets = 18;
SprocketedRollerBevel = false;
SprocketedRollerModel = "gearbox_motor";
SprocketedRollerSetScrewTop = true;
SprocketedRollerSetScrewSide = true;
SprocketedRollerBolts = true;
SprocketedRollerAdjustBase = -3;

DaylightW = 92; 
DaylightH = 18;

PanelX = 130;
PanelY = 100;
PanelZ = 5;
PanelYOffset = 10;
PanelDimensions = [PanelX, PanelY, PanelZ];

ReelX = 102.5;
ReelY = 50;

MotorZ = -16;
TakeupMotorZ = -35;

PictureTakeupMotorRotationZ = -70;
StockTakeupMotorRotationZ = 180-70;

TakeupPanelPictureX = 100;
TakeupPanelPictureY = 50;

TakeupPanelPictureOffsetX = ReelX - TakeupPanelPictureX;
TakeupPanelX = 95;
TakeupPanelY = 90;
TakeupCenterVoidD = 47;
TakeupCenterColumnD = 55;
TakeupCenterColumnZ = 12;

RollerY = -20;

LampY = 20;

LampBoltX = 55;
LampBoltY = 30;
LampBoltH = 30;

LampWireX = 25;
LampWireY = 20;

LampGateX = 11;

IdleRollerPrintX = 55;
IdleRollerPrintY = 5;
IdleRollerNegativeX = 35;
IdleRollerNegativeY = -10;

IdleRollerBoltH = 30;

BearingOuterDiameter = 22.1 - .5;
BearingInnerDiameter = 8.05;

BearingY = (55/2) + 6;
BearingZ = -7;
BearingH = 9;

BearingRotateZ1 = 45;
BearingRotateZ2 = -45;
BearingRotateZ3 = 180+45;
BearingRotateZ4 = 180-45;

echo("Frame 2020 X (x2)", FrameX + 20);
echo("Frame 2020 Y (x4)", FrameY);

/**
 * DEBUG MODULES
 **/

module daylight_spool (DEBUG = false) {  
    //inner starting d = 31.5 or 32
    color([[255, 0, 0, 1]]) difference () {
        cylinder(r = R(DaylightW), h = DaylightH - 0.1, center = true);
        cylinder(r = R(DaylightW) + 1, h = DaylightH - 2, center = true);
        cube([9, 9, 50], center=true);
        translate([4.5, 4.5, 0]) {
            rotate([0, 0, 45]) {
                cube([3, 3, 50], center=true);
            }
        }
    }
    difference () {
        cylinder(r = R(32), h = DaylightH - 0.2, center=true);
        cylinder(r = R(32) - 1, h = DaylightH + 1, center=true);
        translate([0, 32/2, 0]) {
            cube([1.3, 10, 18], center=true);
        }
    }
}

module four_hundred_foot_spool (pos = [0, 0, 0]) {
    W = 175;
    H = 18;
    translate(pos) { 
        cylinder(r = R(W), h = H, center = true, $fn = 200);
    }
}

module centered_geared_motor (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        translate([8.25, 0, 0]) geared_motor();
    }
}

module bearing (pos = [0, 0, 0], width= 8, hole = true) {
	fuzz = 0.1;
	translate (pos) {
		difference () {
			cylinder(r = R(BearingOuterDiameter) + fuzz, h = width, center = true);
			if (hole) {
				cylinder(r = R(BearingInnerDiameter) - fuzz, h = width + 1, center = true);
			}
		}
	}
}

module debug () {
    DaylightZ = 11.5;
    PanelOffsetZ = -2.5;
    //////
    panel([0, 0, PanelOffsetZ]);
    UseDaylight = true;
    
    translate([0, RollerY, 18]) rotate([180, 0, 0]) difference () {
        sprocketed_roller(sprockets = Sprockets, bevel = SprocketedRollerBevel, model = SprocketedRollerModel, set_screw_top = SprocketedRollerSetScrewTop, set_screw_side = SprocketedRollerSetScrewSide, bolts = SprocketedRollerBolts, adjust_base = SprocketedRollerAdjustBase);
        //translate([50, 0, 0]) cube([100, 100, 100], center = true);
    }
    //lamp
    //difference () {
        lamp_dual([0, LampY, 0 + 1]);
    //    translate([45, LampY, 0 + 2]) cube([100, 100, 100], center = true);
    //}
    //color("green") lamp_cover([0, LampY + 15, 21]);
    color("red") lamp_bolts_voids([0, LampY + 15, (LampBoltH/2) - 1.5 - 2.5]);
    //gates
    translate([-5.35, LampY -7.1, 11 + 1 + .1]) rotate([0, 0, 7]) color("blue") picture_gate();
    
    //idle rollers
    idle_roller([ IdleRollerPrintX, IdleRollerPrintY, 3]);
    idle_roller([-IdleRollerPrintX, IdleRollerPrintY, 3]);
    idle_roller([ IdleRollerNegativeX, IdleRollerNegativeY, 3]);
    idle_roller([-IdleRollerNegativeX, IdleRollerNegativeY, 3]);
    //active roller
    centered_geared_motor([0, RollerY, MotorZ], [180, 0, 90]);
    
    if (UseDaylight) {
        //feed
        translate([-ReelX,  ReelY, DaylightZ]) daylight_spool();
        translate([-ReelX, -ReelY, DaylightZ]) daylight_spool();
        //takeup
        //translate([ReelX,  ReelY, DaylightZ]) daylight_spool();
        //translate([ReelX, -ReelY, DaylightZ]) daylight_spool();
    } else {
        four_hundred_foot_spool([-ReelX,  ReelY, DaylightZ]);
        four_hundred_foot_spool([-ReelX, -ReelY, DaylightZ]);
        //takeup
        four_hundred_foot_spool([ReelX,  ReelY, DaylightZ]);
        four_hundred_foot_spool([ReelX, -ReelY, DaylightZ]);
    }
    
    //takeup
    takeup_panel_picture([TakeupPanelPictureX,  TakeupPanelPictureY, PanelOffsetZ]);
    difference() {
        union(){
            translate([ReelX,  ReelY, -10]) magnetic_coupling();
            translate([ReelX,  ReelY, -8]) slip_coupling();
        }
        translate([ReelX + 50,  ReelY, -10]) cube([100, 100, 100], center = true);
    }
        translate([ReelX,  ReelY, PanelOffsetZ+1]) {
            rotate([0, 0, BearingRotateZ1]) color("blue") bearing([0, BearingY, BearingZ]);
            rotate([0, 0, BearingRotateZ2]) color("blue") bearing([0, BearingY, BearingZ]);
            rotate([0, 0, BearingRotateZ3]) color("blue") bearing([0, BearingY, BearingZ]);
            rotate([0, 0, BearingRotateZ4]) color("blue") bearing([0, BearingY, BearingZ]);
        }
    
    centered_geared_motor([ReelX,  ReelY, TakeupMotorZ], [180, 0, PictureTakeupMotorRotationZ]);
    centered_geared_motor([ReelX, -ReelY, TakeupMotorZ], [180, 0, StockTakeupMotorRotationZ]); 

    //translate([0, 0, DaylightZ]) color("red", 0.25) cube([250, 100, 16], center = true);
    
    //2020 frame
    //top/bottom
    translate([0, (FrameY/2) + 10, FrameZ]) rotate([0, 90, 0]) 2020_tslot(FrameX + 20);
    translate([0, -(FrameY/2) - 10, FrameZ]) rotate([0, 90, 0]) 2020_tslot(FrameX + 20);
    //far sides
    translate([FrameX/2, 0, FrameZ]) rotate([90, 0, 0]) 2020_tslot(FrameY);
    translate([-FrameX/2, 0, FrameZ]) rotate([90, 0, 0]) 2020_tslot(FrameY);
    //inner rails
    translate([(PanelX/2) - 10, 0, FrameZ]) rotate([90, 0, 0]) 2020_tslot(FrameY);
    translate([-(PanelX/2) + 10, 0, FrameZ]) rotate([90, 0, 0]) 2020_tslot(FrameY);
}

/**
 * CONTACT PRINTER MODULES
 **/

module bearing_void (pos = [0, 0, 0], width= 8) {
	fuzz = 0.3;
	translate (pos) {
		difference () {
			cylinder(r = R(BearingOuterDiameter) + fuzz, h = width, center = true);
		}
	}
}

module m3_panel_bolt_void (pos = [0, 0, 0], H = 10) {
    translate(pos) {
        cylinder(r = R(6), h = 5, center = true, $fn = 40);
        translate([0, 0, -(H/2) - (5/2) + 0.01]) cylinder(r = R(3.25), h = H, center = true, $fn = 25);
    }
}

module takeup_mount_panel (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) intersection() {
        minimal_mount();
        translate([10, 0, 0]) cube([50, 30, 10], center = true);
    }
}

module panel_motor_mount_void (pos = [0, 0, 0]) {
    H = 10;
    D = 7.5 + 1.5;
    translate(pos) {
        cylinder(r = R(6), h = H, center = true, $fn = 40);
    }
}

module idle_roller (pos = [0, 0, 0]) {
    $fn = 80;
    translate(pos) {
        difference () {
            union () {
                cylinder(r = R(16), h = 1, center = true);
                translate([0, 0, 17]) cylinder(r = R(16), h = 1, center = true);
                translate([0, 0, 17/2]) cylinder(r = R(12), h = 17, center = true);
            }
            cylinder(r = R(4.5), h = 20, center = true);
        }
    }
}

module lamp_bolt_void (pos = [0, 0, 0], H = LampBoltH) {
    translate(pos) {
        cylinder(r = R(4.25), h = H, center = true);
        translate([0, 0, -H/2]) m4_nut();
    }
}

module idle_roller_bolt_void (pos = [0, 0, 0], H = IdleRollerBoltH) {
    translate(pos) {
        cylinder(r = R(4.25), h = H, center = true);
        translate([0, 0, -H/2]) m4_nut();
    }
}

module lamp_bolts_voids (pos = [0, 0, 0], H = 10) {
    X = LampBoltX/2;
    Y = LampBoltY/2;
    $fn = 30;
    translate(pos) {
        lamp_bolt_void([X, Y, 0]);
        lamp_bolt_void([-X, Y, 0]);
        lamp_bolt_void([X, -Y, 0]);
        lamp_bolt_void([-X, -Y, 0]);
    }
}

module lamp_post (pos = [0, 0, 0]) {
    $fn = 40;
    H = 20;
    translate(pos) difference () {
        cylinder(r = R(8), h = H, center = true);
        cylinder(r = R(4.25), h = H + 1, center = true);
    }
}

module lamp_posts (pos = [0, 0, 0], H = 10) {
    X = LampBoltX/2;
    Y = LampBoltY/2;
    $fn = 30;
    translate(pos) {
        lamp_post([X, Y, 0]);
        lamp_post([-X, Y, 0]);
        lamp_post([X, -Y, 0]);
        lamp_post([-X, -Y, 0]);
    }
}

module lamp_gate_bracket (pos = [0, 0, 0], rot = [0, 0, 0]) {
    X = LampGateX;
    translate(pos) rotate(rot) {
        difference () { 
            cube([X, 15, 18], center = true);
            translate([0, 4, 1]) cube([X-4, 15, 18], center = true);
            translate([0, -3, 1]) cube([X-7, 15, 18], center = true);
            translate([0, -5.25, 0]) cube([X-4, 1.5, 18.01], center = true);
        }
    }
}

module picture_gate_bracket (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) difference() {
        lamp_gate_bracket();
        translate([0, 0, 0]) cube([4, 20, 17], center = true);
    }
}

module sound_gate_bracket (pos = [0, 0, 0], rot = [0, 0, 0]) {
    LedD = 5;
    LedZ = -6.5;
    translate(pos) rotate(rot) {
        difference () {
            lamp_gate_bracket();
            translate([0, 2, LedZ]) rotate([0, 90, 90]) {
                cylinder(r = R(LedD), h = 16, center = true, $fn = 40);
            }
        }
    }
}

module gate_blank () {
    X = LampGateX;
    //front
    translate([0, -6.25, 0]) cube([X-7.2, 1.2, 19.25], center = true);
    //middle
    translate([0, -5.1, -0.5]) cube([X-4.2, 1.4, 19], center = true);
    
    //top
    translate([0, -5.9, 9]) cube([X-4.2, 3, 2], center = true);
}
//standard, super, full, sound
module picture_gate (pos = [0, 0, 0], rot = [0, 0, 0], Type = "full", Width = 2) {
    X = LampGateX;
    translate(pos) rotate(rot) {
        difference () {
            union () {
                gate_blank();
            }
            if (Type == "standard") {
                translate([0, -6, -0.7]) cube([Width, 10, 16mmFilmStandard], center = true);
            } else if (Type == "full") {
                translate([0, -6, -1.1]) cube([Width, 10, 16mmFilmFull], center = true);
            } else if (Type == "super") {

            }
        }
    }
}

module lamp_dual (pos = [0, 0, 0]) {
    Z = 10;
    WallZ = Z;
    GateZ = Z;
    PostsZ = Z - 1;
    translate(pos) {
        intersection () {
            difference () {
                rounded_cube([70, 70, 2], d = 4, center = true);
                translate([0, -45, 0]) cylinder(r = R(60), h = 4 + 1, center = true, $fn = 200);
                lamp_bolts_voids([0, 15, -2]);
                translate([LampWireX, LampWireY, 0]) cylinder(r = R(10), h = 10, center = true);
                translate([-LampWireX, LampWireY, 0]) cylinder(r = R(10), h = 10, center = true);
            }
            translate([0, 45, 0]) cylinder(r = R(130), h = 4 + 1, center = true, $fn = 200);
        }
        //walls
        translate([0, 15, WallZ]) difference () {
            rounded_cube([70, 40, 18], d = 4, center = true);
            cube([70-6, 40-6, 18 + 1], center = true);
            translate([0, -20, 0]) cube([20, 40-6, 18 + 1], center = true);
        }
        lamp_posts([0, 15, PostsZ]);
        //sound
        difference () {
            union () {
                sound_gate_bracket([5.35, -7, GateZ], [0, 0, -7]);
                picture_gate_bracket([-5.35, -7, GateZ], [0, 0, 7]);
            }
            translate([0, -53.5, 11]) cylinder(r = R(80), h = 18.01, center = true, $fn = 200);
        }
        //barrier
        translate([0, 10.6+7, Z]) cube([5.5, 34, 18], center = true);
        translate([0, 5, Z]) cube([3, 20, 18], center = true);
    }
}

module lamp_cover (pos = [0, 0, 0]) {
    translate(pos) difference () {
        union () {
            rounded_cube([70, 40, 2], d = 4, center = true);
            translate([5.35, -15-7, 0]) rotate([0, 0, -7]) cube([LampGateX, 15-6, 2], center = true);
            translate([-5.35, -15-7, 0]) rotate([0, 0, 7]) cube([LampGateX, 15-6, 2], center = true);
            translate([0, -15-7, 0])cube([4, 4, 2], center = true);

        }
        lamp_bolts_voids([0, 0, 0]);
    }
}

module panel (pos = [0, 0, 0]) {
    BoltX = (PanelX-20)/2;
    BoltY2 = (PanelY)/2;
    
    BoltY1 = 30;
    
    MotorMountX = (GearedMotorMountX + 0.1) / 2;
    MotorMountY = (GearedMotorMountY + 0.1) / 2;
    
    LampBoltsZ = (LampBoltH/2) - 1.5;
    IdleRollerBoltsZ = (IdleRollerBoltH/2) - 1.5;
    
    SprocketedRollerZ = -5;
    
    color("green") translate (pos) difference() {
        translate([0, PanelYOffset, 0]) cube(PanelDimensions, center = true);
        
        //sprocketed roller
        translate([0, RollerY, 0]) cylinder(r = R(15), h = PanelZ + 1, center = true, $fn = 60);
        translate([0, -12.5, -4 + 2.5]) rotate([0, 0, 90]) {
            panel_motor_mount_void([MotorMountX, MotorMountY, 0]);
            panel_motor_mount_void([-MotorMountX, MotorMountY, 0]);
            panel_motor_mount_void([MotorMountX, -MotorMountY, 0]);
            panel_motor_mount_void([-MotorMountX, -MotorMountY, 0]);
        }
        
        //panel bolts
        m3_panel_bolt_void([BoltX, -BoltY1, 3]);
        m3_panel_bolt_void([-BoltX, -BoltY1, 3]);
        m3_panel_bolt_void([BoltX, BoltY1, 3]);
        m3_panel_bolt_void([-BoltX, BoltY1, 3]);
        m3_panel_bolt_void([BoltX, BoltY2, 3]);
        m3_panel_bolt_void([-BoltX, BoltY2, 3]);
        
        //idle roller posts
        idle_roller_bolt_void([ IdleRollerPrintX, IdleRollerPrintY, IdleRollerBoltsZ]);
        idle_roller_bolt_void([-IdleRollerPrintX, IdleRollerPrintY, IdleRollerBoltsZ]);
        idle_roller_bolt_void([ IdleRollerNegativeX, IdleRollerNegativeY, IdleRollerBoltsZ]);
        idle_roller_bolt_void([-IdleRollerNegativeX, IdleRollerNegativeY, IdleRollerBoltsZ]);
        
        //lamp
        lamp_bolts_voids([0, LampY + 15, LampBoltsZ]);
        //lamp wire voids
        translate([0, LampY, 0]) {
            translate([LampWireX, LampWireY, 0]) cylinder(r = R(10), h = 10, center = true);
            translate([-LampWireX, LampWireY, 0]) cylinder(r = R(10), h = 10, center = true);
        }
        
    }
    takeup_mount_panel([0, RollerY, SprocketedRollerZ], [0, 0, 90]);
}

module takeup_panel_bearings_voids (pos = [0, 0, 0]) {
    translate(pos) {
        rotate([0, 0, BearingRotateZ1]) bearing_void([0, BearingY, BearingZ], BearingH);
        rotate([0, 0, BearingRotateZ2]) bearing_void([0, BearingY, BearingZ], BearingH);
        rotate([0, 0, BearingRotateZ3]) bearing_void([0, BearingY, BearingZ], BearingH);
        rotate([0, 0, BearingRotateZ4]) bearing_void([0, BearingY, BearingZ], BearingH);
    }
}

module takeup_panel_picture (pos = [0, 0, 0]) {
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            union(){
                translate([12.5, 10, 0]) cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);
                translate([-(TakeupPanelX/2) + 2.5, (TakeupPanelY/2)-12.5, 0]) cube([OtherX, OtherY, PanelZ], center = true);

            }
            translate([TakeupPanelPictureOffsetX, 0, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            //bearings
            takeup_panel_bearings_voids([TakeupPanelPictureOffsetX, 0, 0]);
        }
    }
}

module takeup_panel_picture_motor_mount (pos = [0, 0, 0] ) {
    translate(pos) {
        translate([TakeupPanelPictureOffsetX, 0, 0]) {
            difference () {
                union () {
                    translate([0, 0, -(PanelZ/2) - (TakeupCenterColumnZ/2)]) cylinder(r = R(TakeupCenterColumnD), h = TakeupCenterColumnZ, center = true, $fn = 100);
                    translate([0, 0, -16]) cylinder(r = R(TakeupCenterColumnD), h = 3, center = true, $fn = 100);
                }
                translate([0, 0, -16]) cylinder(r = R(21), h = 3 + 1, center = true, $fn = 100);
                translate([0, 0, -8]) cylinder(r = R(TakeupCenterVoidD), h = TakeupCenterColumnZ, center = true, $fn = 100);
                //motor shaft void
                translate([0, 0, 0]) cylinder(r = R(18), h = 50, center = true, $fn = 100);
                 //bearings
                takeup_panel_bearings_voids();
            }
            takeup_mount_panel([0, 0, -21], [0, 0, PictureTakeupMotorRotationZ]);
        }
        
    }
}

module takeup_panel_stock (pos = [0, 0, 0]) {
    translate(pos) {
    
    }
}

module corner_foot (pos = [0, 0, 0]) {
    H = 20;
    D1 = 12;
    D2 = 24;
    translate(pos) {
        difference () {
            union() {
                translate([0, 20, 0]) cube([20, 60, 6], center = true);
                translate([20, 0, 0]) cube([60, 20, 6], center = true);
            }
            rotate([180, 0, 0]) m3_panel_bolt_void([20, 0, 1]);
            rotate([180, 0, 0])m3_panel_bolt_void([40, 0, 1]);
            translate([0, 20, 0]) rotate([180, 0, 0]) m3_panel_bolt_void([0, 0, 1]);
            translate([0, 40, 0]) rotate([180, 0, 0]) m3_panel_bolt_void([0, 0, 1]);
        }
        translate([0 , 0, -(6/2) - (H / 2)]) rotate([0, 0, 45]) cylinder(r1 = R(D1), r2 = R(D2), h = H, center = true, $fn = 4);
    }
}

PART = "takeup_panel_picture";
LIBRARY = true;

if (PART == "panel") {
    rotate([180, 0, 0]) panel();
} else if (PART == "lamp_dual") {
    lamp_dual();
} else if (PART == "takeup_panel_picture"){
    takeup_panel_picture();
    color("blue") takeup_panel_picture_motor_mount([0, 0, -1]);
} else if (PART == "picture_gate") {
    rotate([-90, 0, 0]) picture_gate(Type = "standard");
} else if (PART == "sprocketed_roller_reinforced") {
    rotate([180, 0, 0]) sprocketed_roller(sprockets = Sprockets, bevel = SprocketedRollerBevel, model = SprocketedRollerModel, set_screw_top = SprocketedRollerSetScrewTop, set_screw_side = SprocketedRollerSetScrewSide, bolts = SprocketedRollerBolts, adjust_base = SprocketedRollerAdjustBase, reinforced = true);
} else if (PART == "magnetic_coupling") {
    magnetic_coupling();
} else if (PART == "slip_coupling"){
    slip_coupling();
} else if (PART == "corner_foot") {
    rotate([180, 0, 0]) corner_foot();
} else if (PART == "2020_tslot_insert") {
    2020_tslot_insert();
} else {
    debug();
}
