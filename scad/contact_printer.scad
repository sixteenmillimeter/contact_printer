
//include <./lamp.scad>;
//include <./box_laser.scad>;
include <./common/common.scad>;
include <./common/motors.scad>;
include <./common/2020_tslot.scad>;
include <./takeup/takeup.scad>;
include <./sprocketed_roller/sprocketed_roller_var.scad>;

IN = 25.4;

16mmFilmStandard = 10.26;
16mmFilmStandardZ = -0.7;
16mmFilmFull = 16;
16mmFilmFullZ = -1.1;
16mmFilmSuper = 13.25;
16mmFilmSuperZ = -(16 - 16mmFilmSuper) + 0.7;
16mmFilmSound = 16mmFilmSuper - 16mmFilmStandard;
16mmFilmSoundZ = -7.75;

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
TakeupMotorZ = -40;

PictureTakeupMotorRotationZ = -70;
StockTakeupMotorRotationZ = 180-70;

TakeupPanelPictureX = 100;
TakeupPanelPictureY = 50;

TakeupPanelStockX = 100;
TakeupPanelStockY = -50;

FeedPanelPictureX = -100;
FeedPanelPictureY = 50;

FeedPanelStockX = -100;
FeedPanelStockY = -50;

TakeupPanelPictureOffsetX = ReelX - TakeupPanelPictureX;
TakeupPanelStockOffsetX = ReelX - TakeupPanelPictureX;

FeedPanelPictureOffsetX = -ReelX - FeedPanelPictureX;
FeedPanelStockOffsetX = -ReelX - FeedPanelPictureX;

TakeupPanelX = 95;
TakeupPanelY = 90;
TakeupCenterVoidD = 47;
TakeupCenterColumnD = 55;
TakeupCenterColumnZ = 23.25;

TakeupMotorMountX = 31;
TakeupMotorMountY = 31;

TakeupMotorPanelZ = -25;

RollerY = -20;

LampY = 20;

LampBoltX = 55;
LampBoltY = 30;
LampBoltH = 30;

LampWireX = 25;
LampWireY = 20;

LampGateX = 11;

IdleRollerPrintX = 55;
IdleRollerPrintY = 0;
IdleRollerStockX = 35;
IdleRollerStockY = -16;

IdleRollerBoltH = 30;

BearingOuterDiameter = 22.1 - .5;
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
    BearingOffsetZ = -2.5;
    //////
    panel([0, 0, PanelOffsetZ]);
    UseDaylight = true;
    
    translate([0, RollerY, 18]) rotate([180, 0, 0]) difference () {
        sprocketed_roller(sprockets = Sprockets, bevel = SprocketedRollerBevel, model =     SprocketedRollerModel, set_screw_top = SprocketedRollerSetScrewTop, set_screw_side = SprocketedRollerSetScrewSide, bolts = SprocketedRollerBolts, adjust_base = SprocketedRollerAdjustBase);
        //translate([50, 0, 0]) cube([100, 100, 100], center = true);
    }
    //centered_geared_motor([0, RollerY, MotorZ], [180, 0, 90]);
    //lamp
    //difference () {
        //lamp_dual([0, LampY, 0 + 1]);
        lamp_single([0, LampY, 0 + 1]);
    //    translate([45, LampY, 0 + 2]) cube([100, 100, 100], center = true);
    //}
    //color("green") lamp_cover([0, LampY + 15, 21]);
    color("red") lamp_bolts_voids([0, LampY + 15, (LampBoltH/2) - 1.5 - 2.5]);
    //gates
    translate([-5.35, LampY -7.1, 11 + 1 + .1]) rotate([0, 0, 7]) color("blue") picture_gate();
    
    //idle rollers
    idle_roller([ IdleRollerPrintX, IdleRollerPrintY, 3]);
    idle_roller([-IdleRollerPrintX, IdleRollerPrintY, 3]);
    idle_roller([ IdleRollerStockX, IdleRollerStockY, 3]);
    idle_roller([-IdleRollerStockX, IdleRollerStockY, 3]);


    //idle roller path
    translate([0, IdleRollerPrintY - 8, 10]) cube([200, .1, 16], center = true);
    translate([0, IdleRollerStockY + 8, 10]) cube([200, .1, 16], center = true);
    
    if (UseDaylight) {
        //feed
        //translate([-ReelX,  ReelY, DaylightZ]) daylight_spool();
        //translate([-ReelX, -ReelY, DaylightZ]) daylight_spool();
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
    takeup_panel_picture_motor_mount([TakeupPanelPictureX,  TakeupPanelPictureY, PanelOffsetZ]);

    takeup_panel_stock([TakeupPanelStockX,  TakeupPanelStockY, PanelOffsetZ]);
    takeup_panel_stock_motor_mount([TakeupPanelStockX,  TakeupPanelStockY, PanelOffsetZ]);
    
    //feed
    
    feed_panel_picture([FeedPanelPictureX,  FeedPanelPictureY, PanelOffsetZ]);
    feed_panel_motor_mount([FeedPanelPictureX,  FeedPanelPictureY, PanelOffsetZ]);

    feed_panel_stock([FeedPanelStockX,  FeedPanelStockY, PanelOffsetZ]);

    difference() {
        union(){
            translate([ReelX,  ReelY, -10]) magnetic_coupling();
            translate([ReelX,  ReelY, -8]) slip_coupling();
        }
        translate([ReelX + 50,  ReelY, -10]) cube([100, 100, 100], center = true);
    }
    difference() {
        union(){
            translate([-ReelX,  ReelY, -8]) slip_coupling();
        }
        translate([-ReelX + 50,  ReelY, -10]) cube([100, 100, 100], center = true);
    }
    translate([ReelX,  ReelY, BearingOffsetZ+1]) {
        rotate([0, 0, BearingRotateZ1]) color("blue") bearing([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ2]) color("blue") bearing([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ3]) color("blue") bearing([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ4]) color("blue") bearing([0, BearingY, BearingZ]);
    }
    
    translate([ReelX,  ReelY, BearingOffsetZ+1-5]) {
        rotate([0, 0, BearingRotateZ1]) color("red") bearing_post_nut([0, BearingY, BearingZ-.75]);
        rotate([0, 0, BearingRotateZ2]) color("red") bearing_post_nut([0, BearingY, BearingZ-.75]);
        rotate([0, 0, BearingRotateZ3]) color("red") bearing_post_nut([0, BearingY, BearingZ-.75]);
        rotate([0, 0, BearingRotateZ4]) color("red") bearing_post_nut([0, BearingY, BearingZ-.75]);
    }
    
    //centered_geared_motor([ReelX,  ReelY, TakeupMotorZ], [180, 0, PictureTakeupMotorRotationZ]);
    //centered_geared_motor([ReelX, -ReelY, TakeupMotorZ], [180, 0, StockTakeupMotorRotationZ]); 

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

    //feet
    corner_foot([FrameX/2, (FrameY/2) + 10, -26], [0, 0, 180]);

    //motor_controller_panel([0, -75, PanelOffsetZ]);
}

/**
 * CONTACT PRINTER MODULES
 **/

module bearing_void (pos = [0, 0, 0], width= 8) {
	fuzz = 0.5;
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
        cylinder(r = R(4.4), h = H + 1, center = true);
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
                translate([0, -6, 16mmFilmStandardZ]) cube([Width, 10, 16mmFilmStandard], center = true);
            } else if (Type == "full") {
                translate([0, -6, 16mmFilmFullZ]) cube([Width, 10, 16mmFilmFull], center = true);
            } else if (Type == "super16") {
                translate([0, -6, 16mmFilmSuperZ]) cube([Width, 10, 16mmFilmSuper], center = true);
            } else if (Type == "sound") {
                translate([0, -6, 16mmFilmSoundZ]) cube([Width, 10, 16mmFilmSound], center = true);
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

module lamp_single (pos = [0, 0, 0]) {
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
            translate([0, -20, 0]) cube([10, 40-6, 18 + 1], center = true);
        }
        lamp_posts([0, 15, PostsZ]);
        //
        picture_gate_bracket([0, -7, GateZ]);
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
    
    LampBoltsZ = (LampBoltH/2) - 1.5;
    IdleRollerBoltsZ = (IdleRollerBoltH/2) - 1.5;
    
    SprocketedRollerZ = -3.5;
    
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
            lamp_bolts_voids([0, LampY + 15, LampBoltsZ]);
            //lamp wire voids
            translate([0, LampY, 0]) {
                translate([LampWireX, LampWireY, 0]) cylinder(r = R(10), h = 10, center = true);
                translate([-LampWireX, LampWireY, 0]) cylinder(r = R(10), h = 10, center = true);
            }
            //voids for motor pad
            translate([0, RollerY + 7.4, SprocketedRollerZ]) cube([27, 43, 6], center = true);
        }
        takeup_mount_panel([0, RollerY, SprocketedRollerZ], [0, 0, 90]);
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

module takeup_panel_bearings_bolt_void (pos = [0, 0, 0]) {
    cap = 10;
    bolt = 20;
    translate(pos) {
        translate([0, 0, cap / 2]) cylinder(r = R(6), h = cap, center = true);
        translate([0, 0, -(bolt / 2) + 0.1]) cylinder(r = R(3.25), h = bolt, center = true);
    }
}

module takeup_panel_bearings_bolts_voids (pos = [0, 0, 0]) {
    translate(pos) {
        rotate([0, 0, BearingRotateZ1]) takeup_panel_bearings_bolt_void([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ2]) takeup_panel_bearings_bolt_void([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ3]) takeup_panel_bearings_bolt_void([0, BearingY, BearingZ]);
        rotate([0, 0, BearingRotateZ4]) takeup_panel_bearings_bolt_void([0, BearingY, BearingZ]);
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

module takeup_panel_picture (pos = [0, 0, 0]) {
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            union(){
                translate([12.5, 12.5, 0]) cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);
                translate([-(TakeupPanelX/2) + 2.5, (TakeupPanelY/2) - 10, 0]) cube([OtherX, OtherY, PanelZ], center = true);
                takeup_panel_bearings_posts([TakeupPanelPictureOffsetX, 0, 4.25]);
            }
            translate([TakeupPanelPictureOffsetX, 0, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            //bearings
            //takeup_panel_bearings_voids([TakeupPanelPictureOffsetX, 0, 0]);
            takeup_panel_bearings_bolts_voids([TakeupPanelPictureOffsetX, 0, 5]);
            //bolts
            takeup_panel_bearings_bolt_void([TakeupPanelPictureOffsetX, (TakeupPanelY / 2) + 2.5, 0]);
            takeup_panel_bearings_bolt_void([TakeupPanelPictureOffsetX + (TakeupPanelX / 2), (TakeupPanelY / 2) + 2.5, 0]);
            takeup_panel_bearings_bolt_void([TakeupPanelPictureOffsetX - (TakeupPanelX / 2), (TakeupPanelY / 2) + 2.5, 0]);
            takeup_panel_bearings_bolt_void([TakeupPanelPictureOffsetX + (TakeupPanelX / 2), 2.5 - 20, 0]);
            takeup_panel_bearings_bolt_void([TakeupPanelPictureOffsetX - (TakeupPanelX / 2), 2.5 + 20, 0]);
            
            takeup_panel_motor_mount_m4_bolts_voids([TakeupPanelPictureOffsetX, 0, -8.99]);
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

module takeup_panel_stock (pos = [0, 0, 0]) {
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            union(){
                translate([12.5, -12.5, 0]) cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);
                translate([-(TakeupPanelX/2) + 2.5, -(TakeupPanelY/2) + 10, 0]) cube([OtherX, OtherY, PanelZ], center = true);
                takeup_panel_bearings_posts([TakeupPanelStockOffsetX, 0, 4.25]);
            }
            translate([TakeupPanelStockOffsetX, 0, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            //bearings
            //takeup_panel_bearings_voids([TakeupPanelStockOffsetX, 0, 0]);
            takeup_panel_bearings_bolts_voids([TakeupPanelStockOffsetX, 0, 5]);
            //bolts
            takeup_panel_bearings_bolt_void([TakeupPanelStockOffsetX, -(TakeupPanelY / 2) - 2.5, 0]);
            takeup_panel_bearings_bolt_void([TakeupPanelStockOffsetX + (TakeupPanelX / 2), -(TakeupPanelY / 2) - 2.5, 0]);
            takeup_panel_bearings_bolt_void([TakeupPanelStockOffsetX - (TakeupPanelX / 2), -(TakeupPanelY / 2) - 2.5, 0]);
            takeup_panel_bearings_bolt_void([TakeupPanelStockOffsetX + (TakeupPanelX / 2), -2.5 + 20, 0]);
            takeup_panel_bearings_bolt_void([TakeupPanelStockOffsetX - (TakeupPanelX / 2), -2.5 - 20, 0]);
            
            takeup_panel_motor_mount_m4_bolts_voids([TakeupPanelStockOffsetX, 0, -8.99], [0, 0, 180]);
        }
    }
}

module takeup_panel_stock_motor_mount (pos = [0, 0, 0] ) {
    translate(pos) {
        translate([TakeupPanelPictureOffsetX, 0, 0]) {
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
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            union(){
                translate([-12.5, 12.5, 0]) cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);
                translate([(TakeupPanelX/2) - 2.5, (TakeupPanelY/2) - 10, 0]) cube([OtherX, OtherY, PanelZ], center = true);
            }
            translate([FeedPanelPictureOffsetX, 0, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            //bolts
            //top center
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX, (TakeupPanelY / 2) + 2.5, 0]);
            //top right
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX + (TakeupPanelX / 2), (TakeupPanelY / 2) + 2.5, 0]);
            //top left
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX - (TakeupPanelX / 2), (TakeupPanelY / 2) + 2.5, 0]);
            //bottom left
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX - (TakeupPanelX / 2), 2.5 - 20, 0]);
            //center right
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX + (TakeupPanelX / 2), 2.5 + 20, 0]);
            
            takeup_panel_motor_mount_m4_bolts_voids([FeedPanelPictureOffsetX, 0, -8.99]);
        }
    }
}

module feed_panel_stock (pos = [0, 0, 0]) {
    OtherX = 25;
    OtherY = 45;

    translate(pos) {
        difference() {
            union(){
                translate([-12.5, -12.5, 0]) cube([TakeupPanelX, TakeupPanelY, PanelZ], center = true);
                translate([(TakeupPanelX/2) - 2.5, -(TakeupPanelY/2) + 10, 0]) cube([OtherX, OtherY, PanelZ], center = true);
            }
            translate([FeedPanelPictureOffsetX, 0, 0]) cylinder(r = R(TakeupCenterVoidD), h = 50, center = true, $fn = 100);
            //bolts
            //bottom center
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX, -(TakeupPanelY / 2) - 2.5, 0]);
            //bottom right
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX + (TakeupPanelX / 2), -(TakeupPanelY / 2) - 2.5, 0]);
            //bottom left
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX - (TakeupPanelX / 2), -(TakeupPanelY / 2) - 2.5, 0]);
            //bottom left
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX - (TakeupPanelX / 2), -2.5 + 20, 0]);
            //center right
            takeup_panel_bearings_bolt_void([FeedPanelPictureOffsetX + (TakeupPanelX / 2), -2.5 - 20, 0]);
            
            takeup_panel_motor_mount_m4_bolts_voids([FeedPanelPictureOffsetX, 0, -8.99], [0, 0, 180]);
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

module l289N_mount (pos = [0, 0, 0], rot = [0, 0, 0]) {
    $fn = 60;
    DISTANCE = 36.5;
    H = 4;
    THICKNESS = 3;
    module stand () {
        difference () {
            cylinder(r1 = 4, r2 = 3, h = H, center = true);
            cylinder(r = 1.5, h = H + 1, center = true);
        }
    }
    translate(pos) rotate(rot) {
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
            l289N_mount([5, 0, 6]);
            l289N_mount([-52, 0, 6]);
        }
        translate([23, 18, 0]) rounded_cube([28, 28, 10], d = 4, center = true, $fn = 30);
        translate([-34, 18, 0]) rounded_cube([28, 28, 10], d = 4, center = true, $fn = 30);
    }
}

module sprocketed_roller_upright (pos = [0, 0, 0]) {
    translate (pos) {
        sprocketed_roller(sprockets = Sprockets, bevel = SprocketedRollerBevel, model = SprocketedRollerModel, set_screw_top = SprocketedRollerSetScrewTop, set_screw_side = SprocketedRollerSetScrewSide, bolts = SprocketedRollerBolts, adjust_base = SprocketedRollerAdjustBase, reinforced = true);
    }
}

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

module lamp_LEDs (pos = [0, 0, 0], rot = [0, 0, 0]) {
    D = 5.1;
    X = LampGateX;
    translate(pos) rotate(rot) {
        difference () { 
            cube([X-4.2, 10, 16], center = true);
            rotate([90, 0, 0]) cylinder(r = R(D), h = 11, center = true);
            translate([0, 0, 5.2]) rotate([90, 0, 0]) cylinder(r = R(D), h = 11, center = true);
            translate([0, 0, -5.2]) rotate([90, 0, 0]) cylinder(r = R(D), h = 11, center = true);
            
            translate([0, -6, 0]) cube([5.2, 10, 16 + 1], center = true);
        }
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

PART = "lamp_LEDs";
LIBRARY = true;

if (PART == "panel") {
    rotate([180, 0, 0]) panel();
} else if (PART == "lamp_dual") {
    lamp_dual();
} else if (PART == "lamp_single") {
    lamp_single();
} else if (PART == "lamp_cover") {
    lamp_cover();
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
} else if (PART == "sprocketed_roller") {
    rotate([180, 0, 0]) sprocketed_roller_upright();
} else if (PART == "sprocketed_roller_invert") {
    sprocketed_roller_invert();
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
} else if (PART == "lamp_LEDs") {
    lamp_LEDs();
} else {
    debug();
}
