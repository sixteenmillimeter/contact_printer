
//include <./lamp.scad>;
//include <./box_laser.scad>;
use <./common/common.scad>;
include <./common/motors.scad>;
include <./common/2020_tslot.scad>;
include <./takeup/takeup.scad>;
use <./sprocketed_roller/scad/sprocketed_roller.scad>;
use <./filmless.scad>;

$fn = 100;

FrameX = 400;
FrameY = 260;

FrameZ = -16;

SprocketBaseD = 19.05; //8 frames
SprocketBaseH = 2.7;
FrameC = (SprocketBaseD * PI) / 8;

IN = 25.4;

Film16mmStandard = 10.26;
Film16mmStandardZ = -0.7;
Film16mmFull = 16;
Film16mmFullZ = -1.1;
Film16mmSuper = 13.25;
Film16mmSuperZ = ((16 / 2) - (Film16mmSuper / 2) - 1.1);
Film16mmSound = 2.5; // 2.99 //Film16mmSuper - Film16mmStandard;
echo("Soundtrack", Film16mmSound);
Film16mmSoundZ = ((16 / 2) - Film16mmSound / 2) - 1.1;

Sprockets = 18;
SprocketedRollerBevel = true;
SprocketedRollerModel = "gearbox_motor";
SprocketedRollerSetScrewTop = true;
SprocketedRollerSetScrewSide = false;
SprocketedRollerBolts = true;
SprocketedRollerAdjustBase = -3;

DaylightW = 92; 
DaylightH = 18;

PanelX = 155;
PanelY = 100;
PanelZ = 5;
PanelYOffset = 10;
PanelDimensions = [PanelX, PanelY, PanelZ];

ReelX = 145;
ReelY = 90;

MotorZ = -16;
TakeupMotorZ = -40;

PictureTakeupMotorRotationZ = -70;
StockTakeupMotorRotationZ = 110;

TakeupPanelX = 152;
TakeupPanelY = 100;

//Offsets the takeup panels by x,y
TakeupPanelPictureX = 133.75;
TakeupPanelPictureY = 100;

TakeupPanelStockX = 133.75;
TakeupPanelStockY = -100;

FeedPanelPictureX = -133.75;
FeedPanelPictureY = 100;

FeedPanelStockX = -133.75;
FeedPanelStockY = -100;

TakeupPanelPictureOffsetX = ReelX - TakeupPanelPictureX;
TakeupPanelStockOffsetX = ReelX - TakeupPanelStockX;

TakeupPanelPictureOffsetY = ReelY - TakeupPanelPictureY;
TakeupPanelStockOffsetY = -ReelY - TakeupPanelStockY;

FeedPanelPictureOffsetX = -ReelX - FeedPanelPictureX;
FeedPanelStockOffsetX = -ReelX - FeedPanelStockX;

FeedPanelPictureOffsetY = ReelY - FeedPanelPictureY;
FeedPanelStockOffsetY = -ReelY - FeedPanelStockY;

TakeupPanelBoltsOffsetX = -17.5;
FeedPanelBoltsOffsetX = 17.5;

TakeupCenterVoidD = 47;
TakeupCenterColumnD = 55;
TakeupCenterColumnZ = 23.25;

TakeupMotorMountX = 31;
TakeupMotorMountY = 31;

TakeupMotorPanelZ = -25;

RollerY = -20;

LampY = 20;

LampBoltX = 45;
LampBoltY = 30;
LampBoltH = 30;

LampWireX = 25;
LampWireY = 20;

LampGateX = 11;
LampGateZ = 0.5;

LampRailsSpacingX = 32;
LampRailsSpacingY = 13;
LampRailsOffsetZ = 1 / 2;

LampGateCarrierThreadedSpacingX = 30;
LampCarrierX = 40;
LampSingleX = 94;
LampSingleY = 74;
LEDWidthX = 20;

GateCarrierX = 37;
GateCarrierZ = 21.5;

IdleRollerPrintX = 55;
IdleRollerPrintY = 0;
IdleRollerStockX = 35;
IdleRollerStockY = -16;

IdleRollerBoltH = 30;

BearingOuterDiameter = 22.1 - .3;
BearingInnerDiameter = 8.05;

BearingY = (55/2) + 6 - 0.2;
BearingZ = -7;
BearingH = 9;

BearingRotateZ1 = 45;
BearingRotateZ2 = -45;
BearingRotateZ3 = 180+45;
BearingRotateZ4 = 180-45;

MotorMountX = (GearedMotorMountX + 0.1) / 2;
MotorMountY = (GearedMotorMountY + 0.1) / 2;

ESP32BoardX = 63.15;
ESP32BoardY = 77.6;
ESP32BoardZ = 1.7;

ESP32BoardClearanceX = 52.5;
ESP32BoardClearanceY = 66.66;
ESP32BoardClearanceZ = 20;

ESP32PostsX = 57.1;
ESP32PostsY = 72;
ESP32PostsD = 3.1;

L298NModuleX = 43.5;
L298NModuleY = 43.5;
L298NModuleZ = 1.5;

L298NModulePostsX = 36.5;
L298NModulePostsY = 36.5;
L298NModulePostsD = 2.8;

SpringY = 32;
SpringD = 8;
SpringPostD = 5.3;

/**
 * DEBUG MODULES
 **/

module daylight_spool (pos = [0, 0, 0], rot = [0, 0, 0], DEBUG = false) {
    //inner starting d = 31.5 or 32
    translate(pos) rotate(rot) {
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
}

module four_hundred_foot_spool (pos = [0, 0, 0]) {
    W = 175;
    H = 18;
    translate(pos) difference() { 
        color([[255, 0, 0, 1]]) cylinder(r = R(W), h = H, center = true, $fn = 200);
        cube([9, 9, 50], center=true);
        translate([4.5, 4.5, 0]) {
            rotate([0, 0, 45]) {
                cube([3, 3, 50], center=true);
            }
        }
    }
}

module centered_geared_motor (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        translate([8.25, 0, 0]) geared_motor();
    }
}

module bearing (pos = [0, 0, 0], width = 8, hole = true, padding = 0.1) {
	translate (pos) {
		difference () {
			cylinder(r = R(BearingOuterDiameter) + padding, h = width, center = true);
			if (hole) {
				cylinder(r = R(BearingInnerDiameter) - padding, h = width + 1, center = true);
			}
		}
	}
}

module ESP32_board (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate (pos) rotate(rot) {
        difference () {
            cube([ESP32BoardX, ESP32BoardY, ESP32BoardZ], center = true);
            rect_bolt_voids(X = ESP32PostsX, Y = ESP32PostsY, D = ESP32PostsD, H = ESP32BoardZ + 1);
        }
        translate([0, 0, (ESP32BoardZ / 2) + (ESP32BoardClearanceZ / 2)]) cube([ESP32BoardClearanceX, ESP32BoardClearanceY, ESP32BoardClearanceZ], center = true);
    }
}

module L298N_module (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate (pos) rotate(rot) {
        difference () {
            cube([L298NModuleX, L298NModuleY, L298NModuleZ], center = true);
            rect_bolt_voids(X = L298NModulePostsX, Y = L298NModulePostsY, H = L298NModuleZ + 1, D = L298NModulePostsD);
        }
        translate([0, 10, (L298NModuleZ / 2) + (24.75 / 2)]) cube([23, 15.7, 24.75], center = true);
    }
}

module bolex_filter_holder (pos = [0, 0, 0], rot = [0, 0, 0]) {

}

/**
 * CONTACT PRINTER MODULES
 **/

 module rect_bolt_voids (pos = [0, 0, 0], X = 1, Y = 1, D = 1, H = 1, $fn = 60) {
    translate(pos) {
        translate([ X / 2,  Y / 2, 0]) cylinder(r = R(D), h = H, $fn = $fn, center = true);
        translate([-X / 2,  Y / 2, 0]) cylinder(r = R(D), h = H, $fn = $fn, center = true);
        translate([ X / 2, -Y / 2, 0]) cylinder(r = R(D), h = H, $fn = $fn, center = true);
        translate([-X / 2, -Y / 2, 0]) cylinder(r = R(D), h = H, $fn = $fn, center = true);
    }
 }

module bearing_void (pos = [0, 0, 0], width= 8, hole = false, padding = 0.5) {
	translate (pos) {
		difference () {
			cylinder(r = R(BearingOuterDiameter) + padding, h = width, center = true);
            if (hole) {
                cylinder(r = R(BearingInnerDiameter) - padding, h = width + 1, center = true);
            }
		}
	}
}

module m3_panel_bolt_void (pos = [0, 0, 0], rot = [0, 0, 0], H = 10) {
    translate(pos) rotate(rot) {
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
    H = 17.5;
    InnerD = 5;
    BaseD = 20;
    D1 = 14;
    D2 = D1 + 1.5;

    $fn = 100;
    Picture = 11;
    translate(pos) {
        difference () {
            union () {
                cylinder(r = R(BaseD), h = 1.5, center = true);
                translate([0, 0, H]) cylinder(r = R(BaseD), h = 1.5, center = true);
                translate([0, 0, H/2]) cylinder(r = R(D1), h = H, center = true);
                translate([0, 0, (H - Picture)/4]) cylinder(r1 = R(D1), r2 = R(D2), h = (H - Picture) / 2, center = true);
                translate([0, 0, H - ((H - Picture)/4)]) cylinder(r1 = R(D2), r2 = R(D1), h = (H - Picture) / 2, center = true);
            }
            cylinder(r = R(InnerD), h = 40, center = true);
        }
    }
}

module idle_roller_half (pos = [0, 0, 0], rot = [0, 0, 0], flip = false) {
    CutZ = -1.275;
    translate(pos) rotate(rot) difference () {
        idle_roller();
        translate([0, 0, 25 + (1/2) + (17.5 / 2) + 2 + CutZ]) cube([50, 50, 50], center = true);
        difference () {
            translate([0, 24.9, 25 + (1/2) + (17.5 / 2) + CutZ]) cube([50, 50, 50], center = true);
            if (flip) {
                translate([4.25, -0.2, 25 + (1/2) + (17.5 / 2) + CutZ]) rotate([0, 0, 45]) cube([3, 3, 50], center = true);
            } else {
                translate([-4.25, -0.2, 25 + (1/2) + (17.5 / 2) + CutZ]) rotate([0, 0, 45]) cube([3, 3, 50], center = true); 
            }
        }
        if (flip) {
            translate([-4.25, 0, 25 + (1/2) + (17.5 / 2) + CutZ]) rotate([0, 0, 45]) cube([3, 3, 50], center = true);
        } else {
            translate([4.25, 0, 25 + (1/2) + (17.5 / 2) + CutZ]) rotate([0, 0, 45]) cube([3, 3, 50], center = true);   
        }
    }
}

module idle_roller_bolt_void (pos = [0, 0, 0], H = IdleRollerBoltH) {
    translate(pos) {
        cylinder(r = R(4.25), h = H, center = true);
        translate([0, 0, -H/2]) m4_nut();
    }
}

module lamp_bolt_void (pos = [0, 0, 0], H = LampBoltH, Pad = 0) {
    translate(pos) {
        cylinder(r = R(4.25 + Pad), h = H, center = true);
        translate([0, 0, -(H / 2) - (3 / 2)]) m4_nut();
    }
}

module lamp_bolts_voids (pos = [0, 0, 0], H = 10, Pad = 0) {
    X = LampBoltX/2;
    Y = LampBoltY/2;
    $fn = 30;
    translate(pos) {
        lamp_bolt_void([X, Y, 0], H, Pad);
        lamp_bolt_void([-X, Y, 0], H, Pad);
        lamp_bolt_void([X, -Y, 0], H, Pad);
        lamp_bolt_void([-X, -Y, 0], H, Pad);
    }
}

module lamp_post (pos = [0, 0, 0], H = 20) {
    $fn = 40;
    translate(pos) difference () {
        cylinder(r = R(8), h = H, center = true);
        cylinder(r = R(4.4), h = H + 1, center = true);
    }
}

module lamp_posts (pos = [0, 0, 0], H = 20) {
    X = LampBoltX / 2;
    Y = LampBoltY / 2;
    $fn = 30;
    translate(pos) {
        lamp_post([X, Y, 0], H);
        lamp_post([-X, Y, 0], H);
        lamp_post([X, -Y, 0], H);
        lamp_post([-X, -Y, 0], H);
    }
}

module lamp_gate_bracket (pos = [0, 0, 0], rot = [0, 0, 0]) {
    X = LampGateX;
    translate(pos) rotate(rot) {
        difference () { 
            cube([X, 15, 18], center = true);
            translate([0, 4, 1]) cube([X-4, 15, 18], center = true);
            translate([0, -3, 1]) cube([X-7, 15, 18], center = true);
            translate([0, -5.25, 0]) cube([X-3.5, 1.6, 18.01], center = true);
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

module gate_blank_void (pos = [0, 0, 0], rot = [0, 0, 0], bottom = [1, 1], top = [1, 1], h = 1) {
    translate(pos) rotate(rot) {
        difference () {
            if (top[0] > bottom[0] && top[1] > bottom[1]) {
                cube([top[0], top[1], h], center = true);
            } else {
                cube([bottom[0], bottom[1], h], center = true);
            }
            translate([0, bottom[1] - 1, 0]) rotate([30, 0, 0]) cube([bottom[0] + 1, bottom[1], h * 5], center = true);
            translate([0, -bottom[1] + 1, 0]) rotate([-30, 0, 0]) cube([bottom[0] + 1, bottom[1], h * 5], center = true);
        }
    }
}


module gate_blank () {
    X = 15;
    Z = 20;
    SidesX = 2;
    SidesY = 2.7;
    RollerVoidY = -2;
    SprocketShelfZ = 1.75;
    SprocketShelfOffsetZ = -7;
    SprocketShelfD = 44.75;
    RollerShelfZ = 2.9;
    RollerShelfD = 44.75;
    PictureShelfZ = 10.5;
    PictureShelfOffsetZ = -0.5;
    PictureShelfD = 44.75;
    
    RoundedBevelD = 55;
    RoundedBevelY = -3;
    difference () {
        union () {
            intersection () {
                translate([0, 1 / 2, 1 / 2]) cube([X, 7.5 + 1, 19], center = true);
                translate([0, (RoundedBevelD / 2) + RoundedBevelY, 0]) cylinder(r = R(RoundedBevelD), h = Z + 1, center = true, $fn = 260);
            }
        }
        gate_blank_void([0, 3, LampGateZ - 1.1], [0, 90, -90], [16, 12], [16, 2], 6);

        translate([0, (-42.39 / 2) + RollerVoidY, 0]) cylinder(r = R(42.39), h = 20 + 1, center = true, $fn = 240);
        //sprocket shelf
        translate([0, (-42.39 / 2) + RollerVoidY, SprocketShelfOffsetZ]) cylinder(r = R(SprocketShelfD), h = SprocketShelfZ, center = true, $fn = 240);
        //roller shelf
        translate([0, (-42.39 / 2) + RollerVoidY, (Z / 2) - (RollerShelfZ / 2) + 0.01]) cylinder(r = R(RollerShelfD), h = RollerShelfZ, center = true, $fn = 240);
        //picture channel
        difference () {
            translate([0, (-42.39 / 2) + RollerVoidY, PictureShelfOffsetZ ]) cylinder(r = R(PictureShelfD), h = PictureShelfZ, center = true, $fn = 240);
            //ramp to slit
            difference () {
                translate([0, -1, 0]) rotate([0, 0, 45]) cube([4, 4, 200 + 1], center = true);
                translate([0, (-42.39 / 2) + RollerVoidY - 1, PictureShelfOffsetZ ]) cylinder(r = R(PictureShelfD), h = PictureShelfZ, center = true, $fn = 240);
            }
        }

        //gate notches
        translate([(X / 2) + SidesX, SidesY, 0]) rotate([0, 0, 45]) cube([5, 5, Z + 1], center = true);
        translate([(-X / 2) - SidesX, SidesY, 0]) rotate([0, 0, 45]) cube([5, 5, Z + 1], center = true);
    }

}

module gate_carrier (pos = [0, 0, 0], rot = [0, 0, 0]) {
    X = 15.4;
    SidesX = 2;
    SidesY = -1.2;
    SpringRail = 4.5;
    TabX = 6;
    translate(pos) rotate(rot) {
        difference () {
            union () {
                union () {
                    rotate([90, 0, 0]) translate([0, 1, -1]) rounded_cube([GateCarrierX, GateCarrierZ, 5], d = 4, center = true, $fn = 40);
                    
                }
                translate([-12.5, 2.5, 10]) difference () {
                    rotate([0, 0, 180]) cylinder(r = R(5), h = 3, center = true, $fn = 3);
                    translate([0, 5 / 2, 0]) cube([5, 5, 5 + 1], center = true);
                }
                translate([0, -4, 1]) cube([24.5, 5, GateCarrierZ], center = true);    
            }
            
            translate([0 ,-4, 1.651]) difference () {
                cube([X, 10 + 1, GateCarrierZ], center = true);
                //notches to guide gate
                translate([(X / 2) + SidesX, SidesY, 0]) rotate([0, 0, 45]) cube([5, 5, 20 + 2], center = true);
                translate([(-X / 2) - SidesX, SidesY, 0]) rotate([0, 0, 45]) cube([5, 5, 20 + 2], center = true);
                difference () {
                     translate([0, 6.7, 0]) cube([X + 1, 10 + 1, GateCarrierZ], center = true);
                     translate([0, 0, 0]) cube([X - 5, 10 + 1, 16], center = true);
                }
            }
            //central void
            translate([0, 5, 2]) difference() {
                cube([18, 10 + 1, 16], center = true);
                translate([20 / 2, -3, 0]) rotate([0, 0, -45]) cube([5, 50, 20 + 1], center = true);
                translate([(-20 / 2), -3, 0]) rotate([0, 0, 45]) cube([5, 50, 20 + 1], center = true);
            }
        }
        //filter slot
        translate([0, (5 / 2) + (4 / 2), 0]) difference() {
            rotate([90, 0, 0]) translate([0, 1, -1]) rounded_cube([GateCarrierX, GateCarrierZ, 4], d = 4, center = true, $fn = 40);
            translate([0, (-2.5 / 2) + 1.5, 3]) cube([25, 2.5, GateCarrierZ], center = true);
            translate([0, 1, 3.5]) cube([20, 4 + 1, GateCarrierZ], center = true);
            //
            translate([-LampGateCarrierThreadedSpacingX / 2, 0, 1]) rotate([90, 0, 0]) {
                cylinder(r = R(4.25), h = 20, center = true, $fn = 40);
            }
            translate([LampGateCarrierThreadedSpacingX / 2, 0, 1]) rotate([90, 0, 0]) {
                cylinder(r = R(4.25), h = 20, center = true, $fn = 40);
            }
        }
        
        //registration tabs
        translate([(GateCarrierX / 2) - (TabX / 2), 8.5, (-GateCarrierZ / 2) + (4 / 2)]) cube([TabX - 0.4, 20, 2], center = true);
        translate([(-GateCarrierX / 2) + (TabX / 2), 8.5, (-GateCarrierZ / 2) + (4 / 2)]) cube([TabX - 0.4, 20, 2], center = true);
    }
}

module filter_carrier (pos = [0, 0, 0], rot = [0, 0, 0]) {
    X = 7;
    SidesX = 2;
    SidesY = -0.7;
    translate(pos) rotate(rot) {
        difference () {
            union () {
                rotate([90, 0, 0]) rounded_cube([LampCarrierX, 20, 5], d = 4, center = true, $fn = 40);
                translate([-12.5, 2.5, 10]) difference () {
                    rotate([0, 0, 180]) cylinder(r = R(5), h = 3, center = true, $fn = 3);
                    translate([0, 5 / 2, 0]) cube([5, 5, 5 + 1], center = true);
                }
            }
            lamp_rails_voids([0, 0, LampRailsOffsetZ], [90, 0, 0], h = 11);
            cube([12, 10, 17], center = true);
            translate([0, -1.001, 0]) intersection() {
                cube([17, 3, 20 + 1], center = true);
                union () {
                    cube([12, 3, 20 + 1], center = true);
                    translate([(X / 2) + SidesX, 0, 0]) rotate([0, 0, 45]) cube([3, 3, 20 + 1], center = true);
                    translate([(-X / 2) - SidesX, 0, 0]) rotate([0, 0, 45]) cube([3, 3, 20 + 1], center = true);
                }
            }
            translate([-LampRailsSpacingX / 2, -2, LampRailsOffsetZ]) rotate([90, 0, 0]) {
                cylinder(r = R(4.25), h = 20, center = true, $fn = 40);
                rotate([0, 0, 30]) m4_nut(5);
            }
            translate([LampRailsSpacingX / 2, -3, LampRailsOffsetZ]) rotate([90, 0, 0]) {
                cylinder(r = R(5), h = 20, center = true, $fn = 40);
            }
        }
    }
}

module picture_gate_text (pos = [0, 1.5, 9.3], label = "gate" ){
    translate(pos) {
        linear_extrude(height = 5) {
            text(label, size = 2.5, font = "Liberation Sans", halign = "center", valign = "center", $fn = 16);
        }  
    }
}

//standard, super, full, sound
module picture_gate (pos = [0, 0, 0], rot = [0, 0, 0], Type = "full", Width = 2) {
    X = LampGateX;
    translate(pos) rotate(rot) {
        difference () {
            union () {
                gate_blank();
            }
            translate([0, 0, LampGateZ]) {
                if (Type == "standard") {
                    translate([0, -6, Film16mmStandardZ]) cube([Width, 20, Film16mmStandard], center = true);
                     picture_gate_text(label = "16mm");
                } else if (Type == "full") {
                    translate([0, -6, Film16mmFullZ]) cube([Width, 20, Film16mmFull], center = true);
                    picture_gate_text(label = "full");
                } else if (Type == "super16") {
                    translate([0, -6, Film16mmSuperZ]) cube([Width, 20, Film16mmSuper], center = true);
                    picture_gate_text(label = "super16");
                } else if (Type == "sound") {
                    translate([0, -6, Film16mmSoundZ]) cube([Width, 20, Film16mmSound], center = true);
                    picture_gate_text(label = "sound");
                }
            }
        }
    }
}

/*
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
}*/

module lamp_single (pos = [0, 0, 0]) {
    Height = 20 + 5;
    BaseZ = 2;
    Z = 12;
    WallZ = Z;
    GateZ = Z;
    PostsZ = (Height / 2) + 1;
    TabX = 6;
    TabsOffsetY = 6;
    translate(pos) {
        intersection () {
            difference () {
                union () {
                    //base
                    rounded_cube([LampSingleX, LampSingleY, BaseZ], d = 4, center = true, $fn = 30);

                    translate([0, -10, Height / 2]) cube([LampSingleX, 10, BaseZ + Height], center = true);
                    translate([0, 0, Height / 2]) difference() {
                        rounded_cube([LampSingleX, LampSingleY, BaseZ + Height], d = 4, center = true, $fn = 30);
                        translate([0, 2, 0]) rounded_cube([LampSingleX - 7, 70 - 10, BaseZ + Height + 1], d = 4, center = true, $fn = 30);
                    }
                    lamp_posts([0, 14.75, PostsZ], Height);
                    //translate([-18, 1, 20 / 2]) cube([4.75, 32, 21], center = true);
                }
                
                //void for gate carrier, front
                translate([0, 1, Height / 2 ]) cube([25, 32, BaseZ + Height + 1], center = true);
                //void for gate carrier, bottom
                translate([0, -4, 0]) cube([GateCarrierX + 0.25, 12, 55], center = true);
                //void for lamp slide
                translate([0, 10, 0]) cube([LEDWidthX + 0.25, 40, 55], center = true);
                //void for gate
                translate([0, -4, 0]) cube([LEDWidthX + 0.25, 32, 55], center = true);
                translate([0, -48, 0]) cylinder(r = R(60), h = 4 + 1, center = true, $fn = 200);
                
                lamp_bolts_voids([0, 14.75, -2], 50, 0.2);
                
                translate([LampGateCarrierThreadedSpacingX / 2, 32.5, 9 + LampRailsOffsetZ]) rotate([90, 0, 0]) {
                    cylinder(r = R(4.25), h = 20, center = true, $fn = 40);
                    rotate([0, 0, 30]) m4_nut();
                }
                translate([-LampGateCarrierThreadedSpacingX / 2, 32.5, 9 + LampRailsOffsetZ]) rotate([90, 0, 0]) {
                    cylinder(r = R(4.25), h = 20, center = true, $fn = 40);
                    rotate([0, 0, 30]) m4_nut();
                }

                //void for slide rails
                translate([0, 70 / 2, -0.2]) {
                    cube([LEDWidthX + 0.25, 20, 2.8], center = true);
                    translate([((LEDWidthX + 0.25) / 2) - (3.5 / 2), 0, (5.5 / 2) - (1.5 / 2)]) cube([3.5, 20, 6.8], center = true);
                    translate([((-LEDWidthX - 0.25) / 2) + (3.5 / 2), 0, (5.5 / 2) - (1.5 / 2)]) cube([3.5, 20, 6.8], center = true); 
                }
                
                //voids for gate carrier tabs
                translate([(GateCarrierX / 2) - (TabX / 2), TabsOffsetY, 0]) cube([TabX, 20, 2.8], center = true);
                translate([(-GateCarrierX / 2) + (TabX / 2), TabsOffsetY, 0]) cube([TabX, 20, 2.8], center = true); 
            
                //DC power jack void
                translate([-34.5, LampSingleY / 2, 12]) rotate([0, 90, 90]) cylinder(r = R(11), h = 20, center = true, $fn = 80);
            
                //nut for securing lamp
                translate([0, 37, 3.8 + 0.4]) {
                    rotate([0, 0, 30]) m4_nut();
                    cylinder(r = R(4), h = 20, $fn = 40, center = true);
                }
            }
            translate([0, 66.5, 0]) cylinder(r = R(170), h = 100, center = true, $fn = 500);
        }

        difference () {
            union () {
                translate([LampGateCarrierThreadedSpacingX / 2, 12, (11 / 2) - (2 / 2)]) difference() {
                    translate([0.375, 0, 0]) cube([(GateCarrierX - LEDWidthX) / 2 + 2, 20, 11], center = true);
                    translate([0, 0, 10.2 / 2]) rotate([90, 0, 0])  cylinder(r = R(4.1), h = 20 + 1, center = true, $fn = 40);
                }
                translate([-LampGateCarrierThreadedSpacingX / 2, 12, (11 / 2) - (2 / 2)]) difference() {
                    translate([-0.375, 0, 0]) cube([(GateCarrierX - LEDWidthX) / 2 + 2, 20, 11], center = true);
                    translate([0, 0, 10.2 / 2]) rotate([90, 0, 0])  cylinder(r = R(4.1), h = 20 + 1, center = true, $fn = 40);
                }
            }
            //voids for gate carrier tabs
            translate([(GateCarrierX / 2) - (TabX / 2), TabsOffsetY, 0]) cube([TabX, 20, 2.8], center = true);
            translate([(-GateCarrierX / 2) + (TabX / 2), TabsOffsetY, 0]) cube([TabX, 20, 2.8], center = true); 
        }
    }
}

module lamp_single_assembly (pos = [0, 0, 0]) {
    translate(pos) {
        difference () {
            translate([0, 0, 6]) cube([10, 20, 10], center = true);
        }
    }
}

module lamp_cover (pos = [0, 0, 0]) {
    RollerVoidY = -17.5;
    RollerShelfD = 44.75;
    echo(LampY + 15);
    translate(pos) {
        difference () {
            union () {
                intersection () {
                    translate([0, 0.25, 0]) rounded_cube([LampSingleX, LampSingleY, 2], d = 4, center = true, $fn = 30);
                    translate([0, 66.75, 0]) cylinder(r = R(170), h = 100, center = true, $fn = 500);
                }
                //over hangs
                translate([0, -16, -3.4]) cube([20.25, 2, 6], center = true);
            }
            lamp_bolts_voids([0, 15, 0]);
            translate([0, -23, 0]) cube([40, 10, 10], center = true);
            translate([0, (-42.39 / 2) + RollerVoidY, 0]) cylinder(r = R(RollerShelfD), h = 20, center = true, $fn = 240);
        }
    }
}
module takeup_mount_bearing_plug (pos = [0, 0, 0]) {
    H = 6.75 + 1;
    translate(pos) difference() {
        translate([0, 0, -7 / 8]) cylinder(r = R(16), h = H, center = true);
        translate([0, 0, -H + 1]) cylinder(r = R(13.5), h = H, center = true);
        cylinder(r = R(7), h = H * 2, center = true);
    }
}

module panel_bearing_void (pos = [0, 0, 0]) {
    translate(pos) difference () {
        cylinder(r = R(24), h = 2, center = true);
        cylinder(r = R(12), h = 2 + 1, center = true);
    }
}

//BOM: 4, M3 hex cap bolt 6mm,N/A,Attach encoder motor to panel
//BOM: 6, M3 hex cap bolt 8mm,N/A,Attach panel to aluminum extrusions
//BOM: 6, M3 sliding t slot nut,N/A,Attach aluminum extrusions to panel
//BOM: 1, 100RPM DC geared motor with encoder,N/A,Drive the sprocketed_roller
//BOM: 4, M4 hex bolt 40mm, N/A, Attach the lamp to the panel
module panel (pos = [0, 0, 0]) {
    BoltX = (PanelX - 20) / 2;
    BoltY2 = (PanelY) / 2;
    
    BoltY1 = 30;
    
    LampBoltsZ = (LampBoltH / 2) - 1.5;
    IdleRollerBoltsZ = (IdleRollerBoltH / 2) - 1.5;
    
    SprocketedRollerZ = -3.5 - 1;
    
    MotorMountZ = 0;
    
    color("green") translate (pos) {
        difference() {
            translate([0, PanelYOffset, 0]) cube([PanelDimensions[0], PanelDimensions[1], PanelDimensions[2]], center = true);
            
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
            idle_roller_bolt_void([ IdleRollerStockX, IdleRollerStockY, IdleRollerBoltsZ]);
            idle_roller_bolt_void([-IdleRollerStockX, IdleRollerStockY, IdleRollerBoltsZ]);
            
            //lamp
            lamp_bolts_voids([0, LampY + 15, LampBoltsZ], 26.25, 0.15);

            //lamp wire voids
            translate([0, LampY, 0]) {
                translate([LampWireX, LampWireY, 0]) cylinder(r = R(10), h = 10, center = true);
                translate([-LampWireX, LampWireY, 0]) cylinder(r = R(10), h = 10, center = true);
            }
            //voids for motor pad
            translate([0, RollerY + 7.4, SprocketedRollerZ]) cube([27, 43, 6], center = true);
            panel_bearing_void([0, RollerY, 2.5]);

            //lamp bolt void
            translate([0, 57.45, 0]) cylinder(r = R(4.25), h = 20, center = true);
        }
        difference () {
            union () {
                takeup_mount_panel([0, RollerY, SprocketedRollerZ], [0, 0, 90]);
                takeup_mount_bearing_plug([0, RollerY, -0.5]);
            }
            panel_bearing_void([0, RollerY, 2.5]);
        }
        
    }
}

module panel_corner (pos = [0, 0, 0], rot = 0) {
    D = 20;
    translate([pos[0] - R(D), pos[1] - R(D), pos[2]]) rotate([0, 0, rot]) difference() {
        cube([D * 2, D * 2, 10], center = true);
        cylinder(r = R(D), h = 10 + 1, center = true, $fn = 60);
        translate([-D, -D / 2, 0]) cube([D * 2, D * 2, 10 + 1], center = true);
        translate([-D / 2, -D, 0]) cube([D * 2, D * 2, 10 + 1], center = true);
    }
}

module takeup_panel_motor_mount_bolt_void (pos = [0, 0, 0]) {
    cap = 25;
    bolt = 10;
    translate(pos) {
        translate([0, 0, -bolt / 2]) cylinder(r = R(3.5), h = bolt, center = true, $fn = 30);
        translate([0, 0, cap / 2]) cylinder(r = R(6), h = cap, center = true, $fn = 30);
    }
}

module takeup_panel_bearings_voids (pos = [0, 0, 0]) {
    translate(pos) {
        rotate([0, 0, BearingRotateZ1]) bearing_void([0, BearingY, BearingZ], BearingH);
        rotate([0, 0, BearingRotateZ2]) bearing_void([0, BearingY, BearingZ], BearingH);
        rotate([0, 0, BearingRotateZ3]) bearing_void([0, BearingY, BearingZ], BearingH);
        rotate([0, 0, BearingRotateZ4]) bearing_void([0, BearingY, BearingZ], BearingH);
    }
}

module takeup_panel_bearings_post (pos = [0, 0, 0]) {
    translate(pos) {
        cylinder(r = R(12), h = 0.5, center = true);
        translate([0, 0, - (0.5 / 2) - (8 / 2)]) cylinder(r = R(BearingInnerDiameter) - 0.1, h = 8, center = true);
    }
}

module takeup_panel_bearings_posts (pos = [0, 0, 0]) {
    translate(pos) {
        rotate([0, 0, BearingRotateZ1]) takeup_panel_bearings_post([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ2]) takeup_panel_bearings_post([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ3]) takeup_panel_bearings_post([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ4]) takeup_panel_bearings_post([0, BearingY, BearingZ]);
    }
}

module takeup_panel_bearings_m3_bolt_void (pos = [0, 0, 0]) {
    cap = 10;
    bolt = 20;
    translate(pos) {
        translate([0, 0, cap / 2]) cylinder(r = R(6), h = cap, center = true);
        translate([0, 0, -(bolt / 2) + 0.1]) cylinder(r = R(3.25), h = bolt, center = true);
    }
}

module takeup_panel_bearings_bolts_voids (pos = [0, 0, 0]) {
    translate(pos) {
        rotate([0, 0, BearingRotateZ1]) takeup_panel_bearings_m3_bolt_void([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ2]) takeup_panel_bearings_m3_bolt_void([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ3]) takeup_panel_bearings_m3_bolt_void([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ4]) takeup_panel_bearings_m3_bolt_void([0, BearingY, BearingZ]);
    }
}

module takeup_panel_motor_mount_m4_bolt_void (pos = [0, 0, 0], rot = [0, 0, 0], H = 20) {
    translate(pos) rotate(rot) {
        cylinder(r = R(4.25), h = H, center = true);
        translate([0, 0, H/2]) m4_nut();
        translate([0, 0, -14.01]) cylinder(r = R(10), h = 25, center = true, $fn = 60);
    }
}

module takeup_panel_motor_mount_m4_bolts_voids (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        takeup_panel_motor_mount_m4_bolt_void([TakeupMotorMountX, 0, 0], [0, 0, 30]);
        takeup_panel_motor_mount_m4_bolt_void([-TakeupMotorMountX, 0, 0], [0, 0, 30]);
        takeup_panel_motor_mount_m4_bolt_void([0, TakeupMotorMountY, 0]);
    }
}

module takeup_panel_motor_mount_pad (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        cylinder(r = R(10), h = 8, center = true, $fn = 60);
        translate([5, 0, 0]) cube([10, 10, 8], center = true);
    }
}

module takeup_panel_motor_mount_pads (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        takeup_panel_motor_mount_pad([TakeupMotorMountX, 0, 0], [0, 0, 180]);
        takeup_panel_motor_mount_pad([-TakeupMotorMountX, 0, 0], [0, 0, 0]);
        takeup_panel_motor_mount_pad([0, TakeupMotorMountY, 0], [0, 0, -90]);
    }
}

//BOM: 1, 250RPM DC geared motor, JSX40-370, Drive the takeup of the picture pathway
//BOM: 7, M3 hex cap bolt 8mm,N/A,Attach the takeup_panel_picture to the frame
//BOM: 7, M3 sliding t slot nut,N/A,Attach the frame to the takeup_panel_picture
module takeup_panel_picture (pos = [0, 0, 0]) {
    BoltX = (TakeupPanelX / 2) - 10;
    BoltY = (TakeupPanelY / 2) - 10;
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            union(){
                cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);
                takeup_panel_bearings_posts([TakeupPanelPictureOffsetX, TakeupPanelPictureOffsetY, 4.25]);
            }
            //void for motor
            translate([TakeupPanelPictureOffsetX, TakeupPanelPictureOffsetY, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            panel_corner([(TakeupPanelX / 2), (TakeupPanelY / 2), 0]);
            //bearings bolts voids
            takeup_panel_bearings_bolts_voids([TakeupPanelPictureOffsetX, TakeupPanelPictureOffsetY, 5]);
            //bolts
            //top center
            takeup_panel_bearings_m3_bolt_void([0, BoltY, 0]);
            //top right
            takeup_panel_bearings_m3_bolt_void([BoltX, BoltY, 0]);
            //top left
            takeup_panel_bearings_m3_bolt_void([-BoltX, BoltY, 0]);
            //bottom right
            takeup_panel_bearings_m3_bolt_void([BoltX, -BoltY, 0]);
            //bottom left
            takeup_panel_bearings_m3_bolt_void([-BoltX, -BoltY, 0]);

            //center left
            takeup_panel_bearings_m3_bolt_void([-BoltX, BoltY - 20, 0]);
            //center right
            takeup_panel_bearings_m3_bolt_void([BoltX, BoltY - 20, 0]);
            
            takeup_panel_motor_mount_m4_bolts_voids([TakeupPanelPictureOffsetX, TakeupPanelPictureOffsetY, -8.99]);
        }
        
    }
}

module takeup_panel_picture_motor_mount (pos = [0, 0, 0] ) {
    translate(pos) {
        translate([TakeupPanelPictureOffsetX, TakeupPanelPictureOffsetY, 0]) {
            difference () {
                union () {
                    translate([0, 0, -(PanelZ/2) - (TakeupCenterColumnZ/2)]) cylinder(r = R(TakeupCenterColumnD), h = TakeupCenterColumnZ, center = true, $fn = 100);
                    translate([0, 0, -16]) cylinder(r = R(TakeupCenterColumnD), h = 3, center = true, $fn = 100);
                    takeup_panel_motor_mount_pads([0, 0, -6.5]);
                }
                translate([0, 0, -16]) cylinder(r = R(15), h = TakeupCenterColumnZ, center = true, $fn = 100);
                translate([0, 0, -8]) cylinder(r = R(TakeupCenterVoidD), h = TakeupCenterColumnZ, center = true, $fn = 100);

                 //bearings
                takeup_panel_bearings_voids();
                translate([2.55, -7.1, -17-6]) rotate([0, 0, PictureTakeupMotorRotationZ]) {
                    takeup_panel_motor_mount_bolt_void([MotorMountX, MotorMountY, 0]);
                    takeup_panel_motor_mount_bolt_void([-MotorMountX, MotorMountY, 0]);
                    takeup_panel_motor_mount_bolt_void([MotorMountX, -MotorMountY, 0]);
                    takeup_panel_motor_mount_bolt_void([-MotorMountX, -MotorMountY, 0]);
                }
                takeup_panel_motor_mount_m4_bolts_voids([0, 0, -8.99]);
                translate([0, 0, -29]) rotate([0, 0, PictureTakeupMotorRotationZ]){
                    translate([10, 0, 0]) cube([50, 27, 10], center = true);
                }
            }
            takeup_mount_panel([0, 0, TakeupMotorPanelZ], [0, 0, PictureTakeupMotorRotationZ]);
        }
    }
}

//BOM: 1, 250RPM DC geared motor, JSX40-370, Drive the takeup of the stock pathway
//BOM: 6, M3 hex cap bolt 8mm,N/A,Attach the takeup_panel_stock to the frame
//BOM: 6, M3 sliding t slot nut,N/A,Attach the frame to the takeup_panel_stock
module takeup_panel_stock (pos = [0, 0, 0]) {
    BoltX = (TakeupPanelX / 2) - 10;
    BoltY = (TakeupPanelY / 2) - 10;
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            union(){
                cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);
                takeup_panel_bearings_posts([TakeupPanelStockOffsetX, TakeupPanelStockOffsetY, 4.25]);
            }
            //motor void
            translate([TakeupPanelStockOffsetX, TakeupPanelStockOffsetY, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            panel_corner([(TakeupPanelX / 2), -(TakeupPanelY / 2) + 20, 0], -90);
            //bearings
            //takeup_panel_bearings_voids([TakeupPanelStockOffsetX, 0, 0]);
            takeup_panel_bearings_bolts_voids([TakeupPanelStockOffsetX, TakeupPanelStockOffsetY, 5]);
            //bolts
            //bottom center
            takeup_panel_bearings_m3_bolt_void([0, -BoltY, 0]);
            //bottom right
            takeup_panel_bearings_m3_bolt_void([BoltX, -BoltY, 0]);
            //bottom left
            takeup_panel_bearings_m3_bolt_void([-BoltX, -BoltY, 0]);
            //top right
            takeup_panel_bearings_m3_bolt_void([BoltX, BoltY, 0]);
            //top left
            takeup_panel_bearings_m3_bolt_void([-BoltX, BoltY, 0]);
            //center left
            takeup_panel_bearings_m3_bolt_void([-BoltX, -BoltY + 20, 0]);
            //center right
            takeup_panel_bearings_m3_bolt_void([BoltX, -BoltY + 20, 0]);
            
            takeup_panel_motor_mount_m4_bolts_voids([TakeupPanelStockOffsetX, TakeupPanelStockOffsetY, -8.99], [0, 0, 180]);
        }
    }
}

module takeup_panel_stock_motor_mount (pos = [0, 0, 0] ) {
    translate(pos) {
        translate([TakeupPanelStockOffsetX, TakeupPanelStockOffsetY, 0]) {
            difference () {
                union () {
                    translate([0, 0, -(PanelZ/2) - (TakeupCenterColumnZ/2)]) cylinder(r = R(TakeupCenterColumnD), h = TakeupCenterColumnZ, center = true, $fn = 100);
                    translate([0, 0, -16]) cylinder(r = R(TakeupCenterColumnD), h = 3, center = true, $fn = 100);
                    takeup_panel_motor_mount_pads([0, 0, -6.5], [0, 0, 180]);
                }
                translate([0, 0, -16]) cylinder(r = R(15), h = TakeupCenterColumnZ, center = true, $fn = 100);
                translate([0, 0, -8]) cylinder(r = R(TakeupCenterVoidD), h = TakeupCenterColumnZ, center = true, $fn = 100);
                 //bearings
                takeup_panel_bearings_voids();
                translate([-2.55, 7.1, -17-6]) rotate([0, 0, StockTakeupMotorRotationZ]) {
                    takeup_panel_motor_mount_bolt_void([MotorMountX, MotorMountY, 0]);
                    takeup_panel_motor_mount_bolt_void([-MotorMountX, MotorMountY, 0]);
                    takeup_panel_motor_mount_bolt_void([MotorMountX, -MotorMountY, 0]);
                    takeup_panel_motor_mount_bolt_void([-MotorMountX, -MotorMountY, 0]);
                }
                takeup_panel_motor_mount_m4_bolts_voids([0, 0, -8.99], [0, 0, 180]);
                translate([0, 0, -29]) rotate([0, 0, StockTakeupMotorRotationZ]){
                    translate([10, 0, 0]) cube([50, 27, 10], center = true);
                }
            }
            takeup_mount_panel([0, 0, TakeupMotorPanelZ], [0, 0, StockTakeupMotorRotationZ]);
        }
    }
}

module feed_panel_motor_mount_pad (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        cylinder(r = R(10), h = 17, center = true, $fn = 60);
        translate([5, 0, 0]) cube([10, 10, 17], center = true);
    }
}

module feed_panel_motor_mount_pads (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        feed_panel_motor_mount_pad([TakeupMotorMountX, 0, 0], [0, 0, 180]);
        feed_panel_motor_mount_pad([-TakeupMotorMountX, 0, 0], [0, 0, 0]);
        feed_panel_motor_mount_pad([0, TakeupMotorMountY, 0], [0, 0, -90]);
    }
}

module feed_panel_motor_mount_m4_bolt_void (pos = [0, 0, 0], rot = [0, 0, 0], H = 30) {
    translate(pos) rotate(rot) {
        cylinder(r = R(4.25), h = H, center = true);
    }
}

module feed_panel_motor_mount_m4_bolts_voids (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        feed_panel_motor_mount_m4_bolt_void([TakeupMotorMountX, 0, 0], [0, 0, 30]);
        feed_panel_motor_mount_m4_bolt_void([-TakeupMotorMountX, 0, 0], [0, 0, 30]);
        feed_panel_motor_mount_m4_bolt_void([0, TakeupMotorMountY, 0]);
    }
}

module feed_panel_picture (pos = [0, 0, 0]) {
    BoltX = (TakeupPanelX / 2) - 10;
    BoltY = (TakeupPanelY / 2) - 10;
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);

            //motor void
            translate([FeedPanelPictureOffsetX, FeedPanelPictureOffsetY, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            panel_corner([-(TakeupPanelX / 2) + 20, (TakeupPanelY / 2), 0], 90);
            //bolts
            //top center
            takeup_panel_bearings_m3_bolt_void([0, BoltY, 0]);
            //top right
            takeup_panel_bearings_m3_bolt_void([BoltX, BoltY, 0]);
            //top left
            takeup_panel_bearings_m3_bolt_void([-BoltX, BoltY, 0]);
            //bottom left
            takeup_panel_bearings_m3_bolt_void([-BoltX, -BoltY, 0]);
            //bottom right
            takeup_panel_bearings_m3_bolt_void([BoltX, -BoltY, 0]);
            //center right
            takeup_panel_bearings_m3_bolt_void([BoltX, BoltY - 20, 0]);
            //center left
            takeup_panel_bearings_m3_bolt_void([-BoltX, BoltY - 20, 0]);
            
            takeup_panel_motor_mount_m4_bolts_voids([FeedPanelPictureOffsetX, FeedPanelPictureOffsetY, -8.99]);
        }
    }
}

module feed_panel_stock (pos = [0, 0, 0]) {
    BoltX = (TakeupPanelX / 2) - 10;
    BoltY = (TakeupPanelY / 2) - 10;
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);

            //motor void
            translate([FeedPanelStockOffsetX, FeedPanelStockOffsetY, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            panel_corner([-(TakeupPanelX / 2) + 20, -(TakeupPanelY / 2) + 20, 0], 180);
            //bolts
            //bottom center
            takeup_panel_bearings_m3_bolt_void([0, -BoltY, 0]);
            //bottom right
            takeup_panel_bearings_m3_bolt_void([BoltX, -BoltY, 0]);
            //bottom left
            takeup_panel_bearings_m3_bolt_void([-BoltX, -BoltY, 0]);
            //top left
            takeup_panel_bearings_m3_bolt_void([-BoltX, BoltY, 0]);
            //top right
            takeup_panel_bearings_m3_bolt_void([BoltX, BoltY, 0]);
            //center right
            takeup_panel_bearings_m3_bolt_void([BoltX, -BoltY + 20, 0]);
            //center left
            takeup_panel_bearings_m3_bolt_void([-BoltX, -BoltY + 20, 0]);
            
            takeup_panel_motor_mount_m4_bolts_voids([FeedPanelStockOffsetX, FeedPanelStockOffsetY, -8.99], [0, 0, 180]);
        }
    }
}

module feed_panel_motor_mount (pos = [0, 0, 0]) {
    translate(pos) {
        translate([FeedPanelPictureOffsetX, 0, 0]) {
            difference () {
                union () {
                    difference () {
                        union () {
                            translate([0, 0, -(PanelZ/2) - (TakeupCenterColumnZ/2)]) cylinder(r = R(TakeupCenterColumnD), h = TakeupCenterColumnZ, center = true, $fn = 100);
                            translate([0, 0, -16]) cylinder(r = R(TakeupCenterColumnD), h = 3, center = true, $fn = 100);
                            feed_panel_motor_mount_pads([0, 0, -11]);
                        }
                        translate([0, 0, -4.5]) cylinder(r = R(TakeupCenterVoidD), h = TakeupCenterColumnZ, center = true, $fn = 100);
                        feed_panel_motor_mount_m4_bolts_voids([0, 0, -8.99]);
                    }
                    translate([0, 0, -14]) cylinder(r = R(COUPLING_D), h = 5, center = true, $fn = 100);
                    translate([0, 0, -10]) magnetic_coupling();
                }
                //remove bottom
                translate([0, 0, -TakeupCenterColumnZ - 7.875]) cylinder(r = R(TakeupCenterColumnD) + 1, h = TakeupCenterColumnZ, center = true, $fn = 100);
            }
        }
    }
}

module bearing_post_nut (pos = [0, 0, 0]) {
    translate(pos) difference() {
        cylinder(r = R(10), h = 5, center = true, $fn = 70);
        cylinder(r = R(3.5), h = 5 + 1, center = true, $fn = 30);
        translate([0, 0, -2]) m3_nut(2);
        translate([0, 0, 3.25]) cylinder(r = R(BearingInnerDiameter) + 0.1, h = 5, center = true, $fn = 50);
    }
}

module m3_nut_bolt_void (pos = [0, 0, 0], rot = [0, 0, 0], H = 20) {
    translate(pos) rotate(rot) {
        m3_nut(3);
        cylinder(r = R(3.5), h = H, center = true, $fn = 30);
    }
}

module corner_foot (pos = [0, 0, 0], rot = [0, 0, 0]) {
    H = 30;
    D1 = 16;
    D2 = 26;
    translate(pos) rotate(rot) {
        difference () {
            union() {
                translate([0, 20, 0]) cube([20, 60, 6], center = true);
                translate([20, 0, 0]) cube([60, 20, 6], center = true);
            }
            rotate([180, 0, 0]) m3_panel_bolt_void([20, 0, 3]);
            rotate([180, 0, 0]) m3_panel_bolt_void([40, 0, 3]);
            translate([0, 20, 0]) rotate([180, 0, 0]) m3_panel_bolt_void([0, 0, 3]);
            translate([0, 40, 0]) rotate([180, 0, 0]) m3_panel_bolt_void([0, 0, 3]);
        }
        translate([0 , 0, -(6/2) - (H / 2)]) rotate([0, 0, 45]) cylinder(r1 = R(D1), r2 = R(D2), h = H, center = true, $fn = 4);
    }
}

module L298N_mount (pos = [0, 0, 0], rot = [0, 0, 0]) {
    $fn = 40;
    DISTANCE = L298NModulePostsX;
    H = 4;
    THICKNESS = 3;
    module stand () {
        difference () {
            cylinder(r1 = R(8), r2 = R(6), h = H, center = true);
            cylinder(r = R(3), h = H + 1, center = true);
        }
    }
    translate([pos[0] - (DISTANCE / 2), pos[1] - (DISTANCE / 2), pos[2]]) rotate(rot) {
        translate([0, 0, 0]) stand();
        translate([DISTANCE, 0, 0]) stand();
        translate([DISTANCE, DISTANCE, 0]) stand();
        translate([0, DISTANCE, 0]) stand();
        difference () {
            translate([DISTANCE/2, DISTANCE/2, -3]) rounded_cube([DISTANCE + 8, DISTANCE + 8, THICKNESS], 8, center = true); //base
            translate([DISTANCE/2, DISTANCE/2, -3]) rounded_cube([DISTANCE - 5, DISTANCE - 5, THICKNESS + 1], 10, center = true); //base
            translate([0, 0, 0]) cylinder(r = 1.5, h = H * 5, center = true);
            translate([DISTANCE, 0, 0]) cylinder(r = 1.5, h = H * 5, center = true);
            translate([DISTANCE, DISTANCE, 0]) cylinder(r = 1.5, h = H * 5, center = true);
            translate([0, DISTANCE, 0]) cylinder(r = 1.5, h = H * 5, center = true);
        }
    }
}

module motor_controller_panel (pos = [0, 0, 0]) {
    translate(pos) difference() {
        union () {
            translate([-5, 17, 0]) rounded_cube([110, 50, 3], d = 4, center = true, $fn = 30);
            L298N_mount([5, 0, 6]);
            L298N_mount([-52, 0, 6]);
        }
        translate([23, 18, 0]) rounded_cube([28, 28, 10], d = 4, center = true, $fn = 30);
        translate([-34, 18, 0]) rounded_cube([28, 28, 10], d = 4, center = true, $fn = 30);
    }
}

/*
module sprocketed_roller_upright (pos = [0, 0, 0]) {
    translate (pos) {
        difference () {
            sprocketed_roller(sprockets = Sprockets, bevel = SprocketedRollerBevel, model = SprocketedRollerModel, set_screw_top = SprocketedRollerSetScrewTop, set_screw_side = SprocketedRollerSetScrewSide, bolts = SprocketedRollerBolts, adjust_base = SprocketedRollerAdjustBase, reinforced = true);
            bearing_void([0, 0, 12.4 + 0.3], hole = true, padding = 0.2);
        }
    }
}
*/

module sprocketed_roller_invert (pos = [0, 0, 0]) {
    D = (FrameC * Sprockets) / PI;
    translate(pos) difference () {
        sprocketed_roller(sprockets = Sprockets, bevel = SprocketedRollerBevel, model = "", set_screw_top = false, set_screw_side = SprocketedRollerSetScrewSide, bolts = SprocketedRollerBolts, adjust_base = SprocketedRollerAdjustBase, reinforced = true);
        translate([0, 0, 1]) gearbox_motor_shaft_void();
        if (SprocketedRollerSetScrewTop) {
            m3_bolt_void([0, 0, 1]);
        }
        if (SprocketedRollerSetScrewSide) {
            m3_nut_void(pos=[D/4, 0, 8.5], rot = [90, 0, 90], H = D/2);
        }
    }
}

/*
//currently in testing
module sprocketed_roller_upright_solid (pos = [0, 0, 0]) {
    $fn = 120;
    OverhangD = 42.85;
    OverhangH = 2.5;
    ChannelD = 1;
    translate (pos) {
        difference () {
            sprocketed_roller(sprockets = Sprockets, bevel = SprocketedRollerBevel, model = SprocketedRollerModel, set_screw_top = SprocketedRollerSetScrewTop, set_screw_side = SprocketedRollerSetScrewSide, bolts = SprocketedRollerBolts, adjust_base = SprocketedRollerAdjustBase, reinforced = false);
            bearing_void([0, 0, 12.4 + 0.3], hole = true, padding = 0.2);
            
            //to be printed in resin
            translate([0, 0, 16.2]) {
                for (i = [0 : 3]) {
                    rotate([0, 0, i * 90]) {
                        rotate([90, 0, 0]) translate([0, 0, 60]) cylinder(r = R(ChannelD), h = 100, center = true, $fn = 20);
                        translate([7, 0, 0]) cylinder(r = R(ChannelD), h = 40, center = true, $fn = 20);
                    }
                }
            }
        }
        
        //reinforce space above motor shaft
        translate([0, 0, 4]) difference () {
            cylinder(r = R(10.5), h = 9, center = true, $fn = 80);
            cylinder(r = R(3), h = 9 + 1, center = true, $fn = 40);
        }
        
        //offset bearing = 0.8
        translate([0, 0, 8.5]) difference () {
            cylinder(r = R(23), h = 2, center = true, $fn = 80);
            cylinder(r = R(19.8), h = 2 + 1, center = true, $fn = 40);
        }
        
        //reinforce overhang
        translate([0, 0, 2.6]) difference () {
            cylinder(r1 = R(OverhangD), r2 = R(OverhangD - (OverhangH * 2)), h = OverhangH, center = true);
            cylinder(r = R(20), h = OverhangH + 1, center = true);
        }
    }
}
*/

//BOM: 1, M3 hex cap bolt 12mm, N/A, Attaches the sprocketed_roller to the geared motor
//BOM: 1, 608-RS Ball Bearing, 608-RS, Reduces wobble in the rollers spin
//PRINT: 1
module sprocketed_roller_invert_solid (pos = [0, 0, 0]) {
    D = (FrameC * Sprockets) / PI;
    OverhangD = 42.85;
    OverhangH = 2.5;
    ChannelD = 1;
    BearingZ = 12.4 + 0.3 - 11.7 - 0.5;
    translate(pos) {
        difference () {
            union () {
                sprocketed_roller(sprockets = Sprockets, bevel = SprocketedRollerBevel, model = "", set_screw_top = false, set_screw_side = SprocketedRollerSetScrewSide, bolts = SprocketedRollerBolts, adjust_base = SprocketedRollerAdjustBase, reinforced = false);
                translate([0, 0, -2]) cylinder(r = R(D), h = 1.5, center = true);
            }
            translate([0, 0, 1]) gearbox_motor_shaft_void();
            bearing_void([0, 0, BearingZ], hole = true, padding = 0.2);
            if (SprocketedRollerSetScrewTop) {
                m3_bolt_void([0, 0, 1]);
            }
            if (SprocketedRollerSetScrewSide) {
                m3_nut_void(pos = [D/4, 0, 8.5], rot = [90, 0, 90], H = D/2);
            }
            //to be printed in resin
            translate([0, 0, 16.2]) {
                for (i = [0 : 3]) {
                    rotate([0, 0, i * 90]) {
                        rotate([90, 0, 0]) translate([0, 0, 20]) cylinder(r = R(ChannelD), h = 100, center = true, $fn = 20);
                        translate([7, 0, 0]) cylinder(r = R(ChannelD), h = 40, center = true, $fn = 20);
                    }
                }
            }
        }

        //reinforce space above motor shaft
        translate([0, 0, 9]) difference () {
            cylinder(r = R(10.5), h = 8.5, center = true, $fn = 80);
            cylinder(r = R(3), h = 9 + 1, center = true, $fn = 40);
        }

        //offset bearing
        translate([0, 0, 8.5 - 2.5 - 0.8 - 0.5]) difference () {
            cylinder(r = R(23), h = 2, center = true, $fn = 80);
            cylinder(r = R(19.8), h = 2 + 1, center = true, $fn = 40);
        }

        //reinforce overhang
        translate([0, 0, 2.6]) difference () {
            cylinder(r1 = R(OverhangD), r2 = R(OverhangD - (OverhangH * 2)), h = OverhangH, center = true);
            cylinder(r = R(25), h = OverhangH + 1, center = true);
        }
    }
}

module lamp_rails_voids (pos = [0, 0, 0], rot = [0, 0, 0], h = 10, Void = true) {
    $fn = 40;
    D = 4 + (Void ? 0.25 : 0);
    translate(pos) rotate(rot) {
        translate([LampRailsSpacingX / 2, LampRailsSpacingY / 2, 0]) cylinder(r = R(4.25), h = h, center = true);
        translate([LampRailsSpacingX / 2, -LampRailsSpacingY / 2, 0]) cylinder(r = R(4.25), h = h, center = true);
        translate([-LampRailsSpacingX / 2, LampRailsSpacingY / 2, 0]) cylinder(r = R(4.25), h = h, center = true);
        translate([-LampRailsSpacingX / 2, -LampRailsSpacingY / 2, 0]) cylinder(r = R(4.25), h = h, center = true);
    }
}

module lamp_LED_side (pos = [0, 0, 0], rot = [0, 0, 0]) {
    $fn = 60;
    D = 5.3;
    SpacingZ = 11.5;
    translate(pos) rotate(rot) {
        difference () { 
            cube([LampGateX - 4.2, 10, 18], center = true);
            rotate([90, 0, 0]) cylinder(r = R(D), h = 11, center = true);
            translate([0, 0, SpacingZ / 2]) rotate([90, 0, 0]) cylinder(r = R(D), h = 11, center = true);
            translate([0, 0, -SpacingZ / 2]) rotate([90, 0, 0]) cylinder(r = R(D), h = 11, center = true);
            
            translate([0, -6, 0]) cube([5.2 + 4, 10, 18 + 1], center = true);
        }
    }
}

module lamp_LEDs (pos = [0, 0, 0], rot = [0, 0, 0]) {
    LightChannelY = 24;
    LEDOffsetY = -2;
    Length = 40;
    LEDGapY = 0;
    translate(pos) rotate(rot) {
        //frame
        difference () {
            union () {
                rotate([90, 0, 0]) rounded_cube([LEDWidthX, 20, 5], d = 4, center = true, $fn = 40);
            }
            cube([12.9, 5 + 1, 18], center = true);
        }
        difference () {
            union () {
                lamp_LED_side([3.1, LEDOffsetY, 0], [0, 0, -7.5]);
                lamp_LED_side([-3.1, LEDOffsetY, 0], [0, 0, 7.5]);
                translate([0, 3.4 + LEDOffsetY, 0]) cube([0.8, 4, 18], center = true);
                
            }
            translate([0, -5, 0]) cube([30, 5, 20], center = true);
        }
        translate([0, (Length / 2) - (5 / 2), -(20 / 2) + (1.5 / 2)]) difference() {
            cube([LEDWidthX, Length, 1.5], center = true);
            //slot
            translate([0, 2, 0]) {
                translate([0, (Length - 14) / 2, 0]) cylinder(r = R(4.25), h = 1.5 + 1, center = true, $fn = 50);
                translate([0, -(Length - 14) / 2, 0]) cylinder(r = R(4.25), h = 1.5 + 1, center = true, $fn = 50);
                cube([4.25, (Length - 14), 1.5 + 1], center = true);
            }
        }
        translate([(LEDWidthX / 2) - (3 / 2), (Length / 2) - (5 / 2) + (LEDGapY / 2), -(20 / 2) + (5 / 2) + (1.5 / 2)]) cube([3, Length - LEDGapY, 5], center = true);
        translate([(-LEDWidthX / 2) + (3 / 2), (Length / 2) - (5 / 2) + (LEDGapY / 2), -(20 / 2) + (5 / 2) + (1.5 / 2)]) cube([3, Length - LEDGapY, 5], center = true);
    }    
}

module gate_holder () {
    X = LampGateX;
    difference () { 
        translate([0, 2.5, -1]) cube([X, 20, 20], center = true);

        translate([0, 0, 1]) cube([X-7, 20 + 10, 18], center = true);
        for ( i = [0 : 5] ) {
            translate([0, -5.25 + (i * 4), 0]) cube([X-3.5, 1.6, 18.01], center = true);
        }
    }
}

module electronics_panel_m3_bolts_voids (pos = [0, 0, 0]) {
    XY = L298NModulePostsX;
    Z = 1;
    translate(pos) {
        translate([-32, 0, 0]) {
            m3_panel_bolt_void([ XY / 2,  XY / 2, Z]);
            m3_panel_bolt_void([-XY / 2,  XY / 2, Z]);
            m3_panel_bolt_void([ XY / 2, -XY / 2, Z]);
            m3_panel_bolt_void([-XY / 2, -XY / 2, Z]);
        }
    }
}

module button_void (pos = [0, 0, 0], rot = [0, 0, 0]) {
    translate(pos) rotate(rot) {
        cylinder(r = R(7), h = PanelZ + 1, center = true, $fn = 40);
        translate([0, 0, -10 / 2]) cylinder(r = R(9.5), h = 10, center = true, $fn = 40);
    }
}

//BOM: 1, ESP32 Dev board,N/A,Control the contact_printer
//BOM: 1, L298N Motor driver module, N/A, Control the 3 motors using 2 channels
//BOM: 6, M3 hex cap bolt 8mm, N/A, Attach the electronics_panel to the frame
//BOM: 6, M3 sliding t slot nut, N/A, Attach the frame to the electronics_panel
//BOM: 1, ESP32 GPIO breakout board, N/A, To make the ESP32 dev board easier to wire
//BOM: 4, M3 hex cap bolt 6mm, N/A, Attach the GPIO breakout board to the panel
module electronics_panel (pos = [0, 0, 0], rot = [0, 0, 0]) {
    X = PanelX - 40;
    Y = 100;
    WallX = 3;
    WallY = Y - 20;
    WallZ = 20;
    ESP32PostsOffsetX = 24;
    ESP32PostsOffsetY = 10;
    ESP32PostsZ = 28;
    L298NModuleOffsetY = 5;
    DCJackZ = 45;
    translate(pos) rotate(rot) {
        difference () {
            union () {
                cube([X, Y, PanelZ], center = true);
                translate([(X / 2) - (WallX / 2), 10, -WallZ / 2]) cube([WallX, WallY, WallZ], center = true);
                translate([-(X / 2) + (WallX / 2), 10, -WallZ / 2]) cube([WallX, WallY, WallZ], center = true);
                //actually the posts, overloading the module
                rect_bolt_voids([ESP32PostsOffsetX, ESP32PostsOffsetY, -ESP32PostsZ / 2], X = ESP32PostsX, Y = ESP32PostsY, D = 8, H = ESP32PostsZ);
                L298N_mount([-32, 46 + L298NModuleOffsetY, -4], [180, 0, 0]);
                //panel for DC jack
                translate([-44.5, -(Y / 2) + 20 + (PanelZ / 2), -DCJackZ / 2]) cube([20, PanelZ, DCJackZ], center = true);
            }
            rect_bolt_voids([ESP32PostsOffsetX, ESP32PostsOffsetY, -ESP32PostsZ], X = ESP32PostsX, Y = ESP32PostsY, D = 2.8, H = 10);
            translate([ESP32PostsOffsetX, ESP32PostsOffsetY, -ESP32PostsZ]) cube([ESP32BoardX + 0.3, ESP32BoardY + 0.3, 3], center = true);
            //top panel bolts
            m3_panel_bolt_void([(X / 2) - 10, -(Y / 2) + 10, 3]);
            m3_panel_bolt_void([-(X / 2) + 10, -(Y / 2) + 10, 3]);
            //underside panel bolts
            m3_panel_bolt_void([-(X / 2) + 5, (Y / 2) - 12, -13], [0,  90, 0]);
            m3_panel_bolt_void([ (X / 2) - 5, (Y / 2) - 12, -13], [0, -90, 0]);
            electronics_panel_m3_bolts_voids([0, 9.5 + L298NModuleOffsetY, 1.5]);
            //DC jack
            translate([-44.5, -(Y / 2) + 20 + (PanelZ / 2), -DCJackZ + 10]) rotate([90, 0, 0]) cylinder(r = R(11), h = 5 + 1, center = true, $fn = 60);
            button_void([-40, -20, 0]);
            button_void([40, -20, 0]);
        }

    }
}

module debug () {
    DaylightZ = 11.5;
    PanelOffsetZ = -2.5;
    BearingOffsetZ = -2.5;
    //////
    
    UseDaylight = true;
    UseAll = true;
    FrameOnly = false;
    Feet = true;

    //panel([0, -10, PanelOffsetZ]);
    
    
    if (!FrameOnly) {
        translate([0, RollerY, 18]) rotate([180, 0, 0]) difference () {
            //sprocketed_roller_upright();
            //translate([50, 0, 0]) cube([100, 100, 100], center = true);
        }
        
        debug_lamp();
        //lamp
        //difference () {
            //lamp_dual([0, LampY, 0 + 1]);
            //lamp_single([0, 10, 0 + 1]);

        //    translate([45, LampY, 0 + 2]) cube([100, 100, 100], center = true);
        //}
        //color("green") lamp_cover([0, LampY + 5, 21]);

        //gates
        //translate([-5.35, LampY -7.1, 11 + 1 + .1]) rotate([0, 0, 7]) color("blue") picture_gate();
        
        //idle rollers
        idle_roller([ IdleRollerPrintX, IdleRollerPrintY - 10, 3]);
        idle_roller([-IdleRollerPrintX, IdleRollerPrintY - 10, 3]);
        idle_roller([ IdleRollerStockX, IdleRollerStockY - 10, 3]);
        idle_roller([-IdleRollerStockX, IdleRollerStockY - 10, 3]);

        //idle roller path
       // translate([0, IdleRollerPrintY - 8, 10]) cube([200, .1, 16], center = true);
        //translate([0, IdleRollerStockY + 8, 10]) cube([200, .1, 16], center = true);
        
        if (UseDaylight) {
            //feed
            daylight_spool([-ReelX,  ReelY, DaylightZ]);
            if (UseAll) {
                daylight_spool([-ReelX, -ReelY, DaylightZ]);
                //takeup
                daylight_spool([ReelX,  ReelY, DaylightZ]);
                daylight_spool([ReelX, -ReelY, DaylightZ]);
            }
        } else {
            four_hundred_foot_spool([-ReelX,  ReelY, DaylightZ]);
            if (UseAll) {
                four_hundred_foot_spool([-ReelX, -ReelY, DaylightZ]);
                //takeup
                four_hundred_foot_spool([ReelX,  ReelY, DaylightZ]);
                four_hundred_foot_spool([ReelX, -ReelY, DaylightZ]);
            }
        }
        
        //takeup
        takeup_panel_picture([TakeupPanelPictureX,  TakeupPanelPictureY, PanelOffsetZ]);
        takeup_panel_picture_motor_mount([TakeupPanelPictureX,  TakeupPanelPictureY, PanelOffsetZ]);

        takeup_panel_stock([TakeupPanelStockX,  TakeupPanelStockY, PanelOffsetZ]);
        takeup_panel_stock_motor_mount([TakeupPanelStockX,  TakeupPanelStockY, PanelOffsetZ]);
        
        //feed
        
        feed_panel_picture([FeedPanelPictureX,  FeedPanelPictureY, PanelOffsetZ]);
        feed_panel_motor_mount([FeedPanelPictureX,  FeedPanelPictureY, PanelOffsetZ]);

        feed_panel_stock([FeedPanelStockX,  FeedPanelStockY, PanelOffsetZ]);

        difference() {
            union(){
                translate([ReelX, ReelY, -10]) magnetic_coupling();
                translate([ReelX, ReelY, -8]) slip_coupling();
            }
            translate([ReelX + 50, ReelY, -10]) cube([100, 100, 100], center = true);
        }
        difference() {
            union(){
                translate([-ReelX, ReelY, -8]) slip_coupling();
            }
            translate([-ReelX + 50, ReelY, -10]) cube([100, 100, 100], center = true);
        }
        translate([ReelX, ReelY, BearingOffsetZ + 1]) color("blue") {
            rotate([0, 0, BearingRotateZ1]) bearing([0, BearingY, BearingZ]);
            rotate([0, 0, BearingRotateZ2]) bearing([0, BearingY, BearingZ]);
            rotate([0, 0, BearingRotateZ3]) bearing([0, BearingY, BearingZ]);
            rotate([0, 0, BearingRotateZ4]) bearing([0, BearingY, BearingZ]);
        }
        
        translate([ReelX, ReelY, BearingOffsetZ + 1 - 5]) color("red") {
            rotate([0, 0, BearingRotateZ1]) bearing_post_nut([0, BearingY, BearingZ-.75]);
            rotate([0, 0, BearingRotateZ2]) bearing_post_nut([0, BearingY, BearingZ-.75]);
            rotate([0, 0, BearingRotateZ3]) bearing_post_nut([0, BearingY, BearingZ-.75]);
            rotate([0, 0, BearingRotateZ4]) bearing_post_nut([0, BearingY, BearingZ-.75]);
        }
        
        //centered_geared_motor([ReelX,  ReelY, TakeupMotorZ], [180, 0, PictureTakeupMotorRotationZ]);
        //centered_geared_motor([ReelX, -ReelY, TakeupMotorZ], [180, 0, StockTakeupMotorRotationZ]); 

        //translate([0, 0, DaylightZ]) color("red", 0.25) cube([250, 100, 16], center = true);
    }

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

    if (Feet) {
        corner_foot([FrameX / 2, (FrameY / 2) + 10, -26], [0, 0, 180]);
        corner_foot([FrameX / 2, -(FrameY / 2) - 10, -26], [0, 0, 90]);
        corner_foot([-FrameX / 2, -(FrameY / 2) - 10, -26], [0, 0, 0]);
        corner_foot([-FrameX / 2, (FrameY / 2) + 10, -26], [0, 0, -90]);
        
        corner_foot([(PanelX / 2) - 10, (FrameY / 2) + 10, -26], [0, 0, 180]);
        corner_foot([-(PanelX / 2) + 10, (FrameY / 2) + 10, -26], [0, 0, -90]);
        corner_foot([(PanelX / 2) - 10, -(FrameY / 2) - 10, -26], [0, 0, 90]);
        corner_foot([-(PanelX / 2) + 10, -(FrameY / 2) - 10, -26], [0, 0, 0]);
    }

    //motor_controller_panel([0, -75, PanelOffsetZ]);

    //electronics
    ESP32_board([0, -90, -25], [180, 0, 0]);
    L298N_module([-32, -85, -9], [180, 0, -90]);
    L298N_module([32, -85, -9], [180, 0, 90]);
    electronics_panel([0, -100, -3]);
}

module debug_lamp () {
    //color("blue") translate([0, -8.5, 10.6]) rotate([0, 90, 90]) 16mm_film(40, true, true);
    //color("red") lamp_bolts_voids([0, LampY + 5, (LampBoltH / 2) - 2], H = 30);
    //color("red") lamp_rails_voids([0, 21, 11 + LampRailsOffsetZ], [90, 0, 0], h = 51, Void = false);
    //translate([LampGateCarrierThreadedSpacingX / 2, 34, 11 + LampRailsOffsetZ]) rotate([90, 0, 0]) cylinder(r = R(4), h = 130, center = true);
    panel([0, -10, -1.5]);
    //
    lamp_single([0, 10.25, 1]);
    //lamp_cover([0, 10, 28 + 5]);
    
    translate([0, RollerY - 10, 2.75]) sprocketed_roller_invert_solid();
    centered_geared_motor([0, RollerY - 10, MotorZ], [180, 0, 90]);

    lamp_LEDs([0, 28, 10]);
    gate_carrier([0, 1.6 + 0.25, 9.75]);
    
    picture_gate([0, -6.2, 10], Type = "full"); //standard
}

module debug_clutch () {
    DaylightZ = 11.5;
    PanelOffsetZ = -2.5;
    BearingOffsetZ = -2.5;
    //////
    
    UseDaylight = true;
    UseAll = true;
    FrameOnly = false;
    Feet = true;

    takeup_panel_picture([TakeupPanelPictureX,  TakeupPanelPictureY, PanelOffsetZ]);
    takeup_panel_picture_motor_mount([TakeupPanelPictureX,  TakeupPanelPictureY, PanelOffsetZ - 30]);

    centered_geared_motor([TakeupPanelPictureX, TakeupPanelPictureY, -50], [180, 0, 0]);
}

//BOM: 840, 2020 Aluminum extrusion mm,N/A,Top and bottom frame 2x 420mm
//BOM: 1040, 2020 Aluminum extrusion mm,N/A,Sides and central frame 4x 260mm
module contact_printer () {
    //debug module for BOM
}

PART = "lamp_coverx";
LIBRARY = true;

if (PART == "panel") {
    rotate([180, 0, 0]) panel();
} else if (PART == "lamp_single") {
    lamp_single();
} else if (PART == "lamp_cover") {
    rotate([180, 0, 0]) lamp_cover();
} else if (PART == "takeup_panel_picture"){
    takeup_panel_picture();
} else if (PART == "takeup_panel_picture_motor_mount") {
    takeup_panel_picture_motor_mount();
} else if (PART == "takeup_panel_stock"){
    takeup_panel_stock();
} else if (PART == "takeup_panel_stock_motor_mount") {
    takeup_panel_stock_motor_mount();
} else if (PART == "feed_panel_picture") {
    feed_panel_picture();
} else if (PART == "feed_panel_stock") {
    feed_panel_stock();
} else if (PART == "feed_panel_motor_mount") {
    feed_panel_motor_mount();
} else if (PART == "picture_gate") {
    rotate([-90, 0, 0]) picture_gate(Type = "standard");
} else if (PART == "full_gate") {
    rotate([-90, 0, 0]) picture_gate(Type = "full");
} else if (PART == "super_gate") {
    rotate([-90, 0, 0]) picture_gate(Type = "super16");
} else if (PART == "sound_gate") {
    rotate([-90, 0, 0]) picture_gate(Type = "sound");
} else if (PART == "sprocketed_roller_invert") {
    sprocketed_roller_invert();
} else if (PART == "sprocketed_roller_invert_solid") {
    sprocketed_roller_invert_solid();
} else if (PART == "sprocketed_wheel") {
    rotate([180, 0, 0]) sprocketed_roller_reinforced_wheel(sprockets = 18, bevel = true, model = "gearbox_motor", nuts = true);
} else if (PART == "magnetic_coupling") {
    magnetic_coupling();
} else if (PART == "slip_coupling"){
    slip_coupling();
} else if (PART == "corner_foot") {
    rotate([180, 0, 0]) corner_foot();
} else if (PART == "2020_tslot_insert") {
    2020_tslot_insert();
} else if (PART == "bearing_post_nut"){
    bearing_post_nut();
} else if (PART == "daylight_spool_insert_reinforced_nut") {
    daylight_spool_insert_reinforced_nut();
} else if (PART == "daylight_spool_insert_reinforced") {
    daylight_spool_insert_reinforced();
} else if (PART == "idle_roller_half_a") {
    idle_roller_half();
} else if (PART == "idle_roller_half_b") {
    idle_roller_half(flip = true);
} else if (PART == "motor_controller_panel") {
    motor_controller_panel();
} else if (PART == "gate_holder") {
    gate_holder();
} else if (PART == "gate_carrier") {
    rotate([0, 0, 0]) gate_carrier();
} else if (PART == "filter_carrier") {
    rotate([-90, 0, 0]) filter_carrier();
} else if (PART == "lamp_LEDs") {
    rotate([90, 0, 0]) lamp_LEDs();
} else if (PART == "electronics_panel") {
    electronics_panel(rot = [180, 0, 0]);
} else {
    //debug();
    //difference () {
        debug_lamp();
        //translate([0, -50, 0]) cube([100, 100, 100], center = true);
    //}
    //debug_clutch();
}
