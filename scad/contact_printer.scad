
//include <./lamp.scad>;
include <./box_laser.scad>;
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

DaylightW = 92; 
DaylightH = 18;

PanelX = 130;
PanelY = 100;
PanelZ = 5;
PanelYOffset = 10;
PanelDimensions = [PanelX, PanelY, PanelZ];

MotorZ = -16;

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

PictureTakeupMotorRotationZ = -70;
StockTakeupMotorRotationZ = 180-70;

echo("Frame 2020 X (x2)", FrameX + 20);
echo("Frame 2020 Y (x4)", FrameY);

/*
AT = 25.4 * 0.22;


INNER_BOX_X = 225;
INNER_BOX_Y = 400;
INNER_BOX_Z = 40;

OUTER_BOX_X = INNER_BOX_X + (25.4 / 2) + .2;
OUTER_BOX_Y = INNER_BOX_Y + (25.4 / 2) + .2;
OUTER_BOX_Z = 70;

REEL_SPACING = 250;
REEL_SPACING_X = 115;

REEL_HOLDER_Z = 4;

IDLE_SPACING = 120;
IDLE_OFFSET = 0;
IDLE_PLAY = 20;
IDLE_PLAY_ANGLE = 45;
IDLE_PLAY_SLOT = 8.1;

SPROCKETED_SPACING = 45;
SPROCKETED_OFFSET = 40;
SPROCKETED_Z = 7.5;

LAMP_Z = -3;

SLIT = 1;

BOLT_R = 2.55; //M5 25mm 0.8
BOLT_Z = 25;

INVOLUTE_SCALE = 1.45;
INVOLUTE_ROTATE = (360 / 12);

PEG_INNER_D = 4;
PEG_OUTER_D = 7;
PEG_H = 10;

PRESSURE_PEG_SPACING = 60;
PRESURE_PEG_OFFSET = -25;

BREAK_PEG_SPACING = 190;
BREAK_PEG_OFFSET = -80;

module m5_25 () {
    cylinder(r = BOLT_R, h = BOLT_Z, center = true);
}
  
module roller (DEBUG = false) {
    $fn = 100;
    H = 21;
    echo("ROLLER_CLEARANCE");
    echo(H - 4);
	//translate([0, 0, 9]) cube([16, 16, 20], center = true);
	difference () {
		union () {
			cylinder(r = 24 / 2, h = 2, center = true);
			translate([0, 0, 1]) cylinder(r = 16 / 2, h = 4, center = true);
			translate([0, 0, 10]) cylinder(r = 14 / 2, h = 18, center = true);
			translate([0, 0, H - 3.5]) cylinder(r = 16 / 2, h = 4, center = true);
			translate([0, 0, H - 2]) cylinder(r = 24 / 2, h = 2, center = true);
		}
		cylinder(r = (IDLE_PLAY_SLOT / 2) + .1, h = 50, center = true);
        if (DEBUG){
            translate([50, 0, 0]) cube([100, 100, 100], center = true);
        }
	}
    //translate([0, 0, H/2 - 1]) cube([25, 25, H], center = true);
}

module idle_roller_peg () {
    translate([0, 0, -.6]) cylinder(r = (IDLE_PLAY_SLOT / 2) - .1, h = 39.25, center = true);
    translate([0, 0, -6.75]) cylinder(r = 16 / 2, h = 2.4, center = true); 
}

module idle_roller_peg_top (DEBUG = false) {
    difference() {
        union () {
            cylinder(r = (IDLE_PLAY_SLOT / 2) + 2, h = PEG_H, center = true);//inner peg
            translate([0, 0, PEG_H / 2 - 1]) cylinder(r = (IDLE_PLAY_SLOT / 2) + 4, h = 2, center = true);
            translate([0, 0, -PEG_H / 2 - 1]) cylinder(r = (IDLE_PLAY_SLOT / 2) + 4, h = 2, center = true);
        }
        translate([0, 0, (25.4  / 4)]) cylinder(r = (IDLE_PLAY_SLOT / 2), h = 15.5 , center = true);
        if (DEBUG) {
            translate([50, 0, 0]) cube([100, 100, 100], center = true);
        }
    }
}

module idle_roller_peg_cap (DEBUG = false) {
    difference() {
        union () {
            cylinder(r = (IDLE_PLAY_SLOT / 2) + 2, h = 5.5, center = true);//inner peg
            translate([0, 0, -1.75]) cylinder(r = (IDLE_PLAY_SLOT / 2) + 4, h = 2, center = true);
        }
        translate([0, 0, -7.1 - .2]) cylinder(r = (IDLE_PLAY_SLOT / 2), h = 15.5 , center = true);
        if (DEBUG) {
            translate([50, 0, 0]) cube([100, 100, 100], center = true);
        }
    }
}

module sprocketed_roller_peg () {
    D = 4.7;
    cylinder(r = (D / 2) - .1, h = 30, center = true);
    translate([0, 0, -2.75]) cylinder(r = 16 / 2, h = 3, center = true); 
    translate([0, 0, -9.25]) cylinder(r = 6 / 2, h = 11.5, center = true);
}

module sprocketed_roller_peg_cap (DEBUG = false) {
    D = 4.7;
    difference() {
        translate([0, 0, 1.3]) cylinder(r = 5.92 - .1, h = 6, center = true); 
        cylinder(r = (D / 2) - .1, h = 6, center = true);
        if (DEBUG) {
            translate([50, 0, 0]) cube([100, 100, 100], center = true);
        } 
    }
}

module reel_holder (top = true) {
	$fn = 60;
    SQUARE_INNER = 8;
	difference(){
		translate([0, 0, -1.5]) cube([SQUARE_INNER, SQUARE_INNER, 21.5], center= true);
		for (i = [0:4]) {
			rotate([0, 0, (i * 90)]){
				translate([(SQUARE_INNER / 2) + .4, (SQUARE_INNER / 2) + .4, 18.5 / 2]) rotate([0, -15, 45]) cube([2.5, SQUARE_INNER, SQUARE_INNER], center = true);
			}
		}		
	}
	difference () {
		union() {
			translate([0, 0, (18.5 / 2) + (3.5 / 2)]) cylinder(r = SQUARE_INNER / 2, h = 3.5, center = true);
			translate([0, 0, (18.5 / 2) + (7.5 / 2)]) sphere(SQUARE_INNER / 2, center = true);
		}
		translate ([0, 0, (18.5 / 2) + 7.5]) cube([10, 10, 2], center = true);
	}
    difference () {
        translate([0, 0, -(18.5/ 2) - (3 / 2) - 3]) cylinder(r = 16 /2, h = 3, center = true);
        //translate([0, 0, -14.3]) cube([4, 4, 2], center = true); //notch
        difference() {
            translate([0, 0, -14.3]) cylinder(r = 8 / 2, h = 2, center = true);
            translate([0, 6, -14.3]) cube([8, 8, 2], center = true);
        }
    }
}

module bearing_laser (x, y, z, width= 8, hole = true) {
	innerD = 8.05;
	outerD = 22.1 - .5;
	fuzz = 0.1;
	translate ([x, y, z]) {
		difference () {
			cylinder(r = outerD / 2 + fuzz, h = width, center = true);
			if (hole) {
				cylinder(r = innerD / 2 - fuzz, h = width, center = true);
			}
		}
	}
}

module inner_box (DUMMY = false) {
    difference () {
        //8.8 inches x 15 inches
        if (DUMMY) {
            color("lightblue") cube([INNER_BOX_X, INNER_BOX_Y, 6], center = true);
        } else {
            translate([0, -209.5, 0]) Box2D([INNER_BOX_X, INNER_BOX_Y, INNER_BOX_Z], SIDE_TABS = 1, TOP_TABS = 0, TOP = false, BOTTOM_TABS = 3, MATERIAL = 6);
            //translate([INNER_BOX_X + 4, 14, 0]) cube([INNER_BOX_X, INNER_BOX_Y, INNER_BOX_Z], center = true);
        }
        idle_play_voids();
        bearing_voids();
        sprocketed_voids();
        elastic_peg_voids();
        //takeup motor mount point
        translate([0, 157 + 1.25, 0]) {
            cylinder(r = 6, h = 100, center = true);
            //bolts
            translate([(15.2 / 2), 19.14 + 1,  0]) cylinder(r = (3.75 / 2), h = 100, center = true); 
            translate([-(15.2 / 2), 19.14  +1,  0]) cylinder(r = (3.75 / 2), h = 100, center = true); 
        }
		//drive motor mount point
		translate([5, 0, 14.5]) rotate([0, 0, 90]) {
			cylinder(r = 6, h = 100, center = true);
			 translate([(15.2 / 2), 19.14 + 1,  0]) cylinder(r = (3.75 / 2), h = 100, center = true); 
            translate([-(15.2 / 2), 19.14  +1,  0]) cylinder(r = (3.75 / 2), h = 100, center = true);
		}
        
        //light mount points, 40mm spread
        translate([75, 20, 0]) cylinder(r = 3, h = 7, center = true);
        translate([75, -20, 0])cylinder(r = 3, h = 7, center = true);
        
        //Hole for light strip
        translate([87, 0, 0]) cylinder(r = 5, h = 50, center = true);
        
        //Hole for power cable to motor
        translate([-10, 195, 0]) cylinder(r = 2, h = 50, center = true);
        
        CENTER_ELEC = 546;
        //Arduino USB B plug hole 
        translate([CENTER_ELEC, -205, 0]) cube([11.5, 11.5, 20], center = true);
        
        //DC power
        translate([CENTER_ELEC + 30, -205, 0]) cylinder(r = (11.5 / 2), h = 20, center = true);
    }
}

module outer_box (DUMMY = false) {
    difference () {
        if (DUMMY) {
            cube([OUTER_BOX_X, OUTER_BOX_Y, OUTER_BOX_Z], center = true);
        } else {    
            translate([0, -209.5, 0]) Box2D([OUTER_BOX_X, OUTER_BOX_Y, OUTER_BOX_Z], SIDE_TABS = 1, TOP_TABS = 0, TOP = false, BOTTOM_TABS = 3, MATERIAL = 6);
        }
        CENTER_ELEC = 571;
        //Arduino USB B plug hole 
        translate([CENTER_ELEC, -205, 0]) cube([11.5, 11.5, 20], center = true);
        
        //DC power
        translate([CENTER_ELEC + 30, -205, 0]) cylinder(r = (11.5 / 2), h = 20, center = true);
    }
}

module light_source () {
    //light mount points, 40mm spread
    translate([0, 20, 0]) cylinder(r = 3, h = 7, center = true);
    translate([0, -20, 0])cylinder(r = 3, h = 7, center = true);

    translate ([10, 0, (7 / 2) + (3 / 2)]) {
        rounded_cube([55, 80, 3], d = 20, center = true);
        translate ([0, 0, 0]) {
            cube([55 / 2, 80, 3], d = 20, center = true);
        }
    }

}

module idle_play_voids () {
        translate([IDLE_OFFSET, IDLE_SPACING / 2, 0]) {
            rotate([0, 0, IDLE_PLAY_ANGLE]) {
                cube([IDLE_PLAY, IDLE_PLAY_SLOT, 50], center = true);
                translate([IDLE_PLAY / 2, 0, 0]) cylinder(r = IDLE_PLAY_SLOT / 2, h = 50, center = true);
                translate([-IDLE_PLAY / 2, 0, 0]) cylinder(r = IDLE_PLAY_SLOT / 2, h = 50, center = true);
            }
        }
        
            translate([IDLE_OFFSET, -IDLE_SPACING / 2, 0]) {
            rotate([0, 0, -IDLE_PLAY_ANGLE]) {
                cube([IDLE_PLAY, IDLE_PLAY_SLOT, 50], center = true);
                translate([IDLE_PLAY / 2, 0, 0]) cylinder(r = IDLE_PLAY_SLOT / 2, h = 50, center = true);
                translate([-IDLE_PLAY / 2, 0, 0]) cylinder(r = IDLE_PLAY_SLOT / 2, h = 50, center = true);
            }  
        }  
}

module bearing_voids () {
    bearing_laser(REEL_SPACING_X / 2, REEL_SPACING / 2, 0, hole = false);
    bearing_laser(REEL_SPACING_X / 2, -REEL_SPACING / 2, 0, hole = false);
    
    bearing_laser(-REEL_SPACING_X / 2, REEL_SPACING / 2, 0, hole = false);
    bearing_laser(-REEL_SPACING_X / 2, -REEL_SPACING / 2, 0, hole = false);
}

module sprocketed_voids () {
    //translate([SPROCKETED_OFFSET, -SPROCKETED_SPACING / 2, 0]) {
        //cylinder(r = 6 / 2, h = 50, center = true);
    //}
    //translate([SPROCKETED_OFFSET, SPROCKETED_SPACING / 2, 0]) {
        //cylinder(r = 6 / 2, h = 50, center = true);
    //}
	bearing_laser(SPROCKETED_OFFSET, SPROCKETED_SPACING / 2, 0, hole=false);
	bearing_laser(SPROCKETED_OFFSET, -SPROCKETED_SPACING / 2, 0, hole=false);
}

module bearing_hobbled_rod () {
    RH_CONNECT_R = 4; //inside of bearing
    difference () {
        cylinder(r = RH_CONNECT_R, h = 30, center = true);
        translate([RH_CONNECT_R + 2, 0, 0]) cube([RH_CONNECT_R * 2, RH_CONNECT_R * 2, 31], center = true);
    }
}

module motor_hobbled_rod (h = 11) {
    difference () {
        translate([0, 0, 0]) cylinder(r = 5.9 / 2, h = h, center = true, $fn = 24);
        translate([5.3, 0, 0]) cube([6, 6, h + .1], center = true);
    }
}

module motor_15RPM (DEBUG = false) {
    H = 52;
    ROD = 16;
    difference () {
        union(){
            cylinder(r = 37 / 2, h = H, center = true);
            translate([0, -6, -(H / 2) - (6 / 2 )]) cylinder(r = 6, h = 6, center = true);
            translate([0, -6, -(H / 2) - 6 - (ROD / 2)]) motor_hobbled_rod(ROD);
        }
        if (DEBUG) {
            translate([50, 0, 0]) cube([100, 100, 100], center = true);
        }
    }
}

module gears_to_cut () {
    //http://hessmer.org/gears/InvoluteSpurGearBuilder.html
    //settings 12 and 24 gears
    //render with projection()
    
    GEAR_2_CENTER = 57.8 + 8.6;
    difference () {
        scale([INVOLUTE_SCALE, INVOLUTE_SCALE, INVOLUTE_SCALE]) {
            union () {
                linear_extrude(height = 1) import("../dxf/InvoluteGear_1.dxf");
                translate([0, 0, 0.5]) cube([20, 20, 1], center = true);
                translate([GEAR_2_CENTER / INVOLUTE_SCALE, 0, 0.5]) cube([20, 20, 1], center = true);
            }
        }
        bearing_hobbled_rod();
        translate([GEAR_2_CENTER, 0, 0]) {
            //bearing_hobbled_rod();
            motor_hobbled_rod();
        }
    }
    //find gear 2 center
    //translate([GEAR_2_CENTER, 0, 0])cylinder(r = 3, h = 30, center = true);
}

module gears_to_cut_2 () {
    //http://hessmer.org/gears/InvoluteSpurGearBuilder.html
    //settings 20 and 12 gears
    //render with projection()
    
    GEAR_2_CENTER = 40.75;
	ORIENTATION = 0;
    difference () {
        union () {
            linear_extrude(height = 1) import("../dxf/InvoluteGear_2.dxf");
        }
		motor_hobbled_rod();
        translate([GEAR_2_CENTER, 0, 30]) {
			rotate([180, 0, ORIENTATION]) contact_printer_roller();
        }
    }
    //find gear 2 center
    //translate([GEAR_2_CENTER, 0, 0])cylinder(r = 1/2, h = 30, center = true);
}

module drive_gear_cap () {
    difference () {
        union () {
            cylinder(r = 5, h = 5, center = true);
            translate([0, 0, -(5 / 2) + (1.5 / 2)]) cylinder(r = 8, h = 1.5, center = true);
        }
        motor_hobbled_rod(11);
    }
}

module temp_inner_walls () {
    difference () {
        cube([INNER_BOX_X, INNER_BOX_Y, INNER_BOX_Z], center = true);
        cube([INNER_BOX_X - (25.4 / 2), INNER_BOX_Y - (25.4 / 2), INNER_BOX_Z + 1], center = true);
    }
}

module temp_outer_walls () {
    difference () {
        cube([OUTER_BOX_X, OUTER_BOX_Y, OUTER_BOX_Z], center = true);
        cube([OUTER_BOX_X - (25.4 / 2), OUTER_BOX_Y - (25.4 / 2), OUTER_BOX_Z + 1], center = true);
    }
}

module temp_bottom () {
    difference () {
       cube([OUTER_BOX_X, OUTER_BOX_Y, 6], center = true);
    }
}

module elastic_peg_bottom (DEBUG = false) {
    difference() {
        union () {
            cylinder(r = PEG_INNER_D / 2, h = PEG_H, center = true);//inner peg
            translate([0, 0, PEG_H / 2 - 1]) cylinder(r = PEG_OUTER_D, h = 2, center = true);
        }
        if (DEBUG) {
            translate([50, 0, 0]) cube([100, 100, 100], center = true);
        }
    }
}

module elastic_peg_top (DEBUG = false) {
    difference() {
        union () {
            cylinder(r = PEG_OUTER_D / 2, h = PEG_H, center = true);//inner peg
            translate([0, 0, PEG_H / 2 - 1]) cylinder(r = PEG_OUTER_D, h = 2, center = true);
            translate([0, 0, -PEG_H / 2 - 1]) cylinder(r = (PEG_OUTER_D / 2) + 2, h = 2, center = true);
        }
        translate([0, 0, (25.4  / 4)]) cylinder(r = (PEG_INNER_D / 2), h = PEG_H , center = true);
        if (DEBUG) {
            translate([50, 0, 0]) cube([100, 100, 100], center = true);
        }
    }
}

module elastic_peg_voids () {
    translate ([PRESURE_PEG_OFFSET, PRESSURE_PEG_SPACING / 2, 0]){
        cylinder(r = (PEG_INNER_D / 2) + .1, h = 50, center = true);
    }
    translate ([PRESURE_PEG_OFFSET, -PRESSURE_PEG_SPACING / 2, 0]) {
        cylinder(r = (PEG_INNER_D / 2) + .1, h = 50, center = true);
    }
    translate ([BREAK_PEG_SPACING / 2, BREAK_PEG_OFFSET,  0]){
        cylinder(r = (PEG_INNER_D / 2) + .1, h = 50, center = true);
    }
    translate ([-BREAK_PEG_SPACING / 2, BREAK_PEG_OFFSET, 0]) {
        cylinder(r = (PEG_INNER_D / 2) + .1, h = 50, center = true);
    }
}

module reel_holder_bearing () {
    $fn = 40;
    BASE_D = 14;
    //translate([0, 0, -0.9]) cube([3.9, 3.9, 1.9], center = true); 
    difference() {
        translate([0, 0, -0.9]) cylinder(r = 8 / 2, h = 1.9, center = true);
        translate([0, 6, -0.9]) cube([8, 8, 1.9], center = true);
    }
    translate([0, 0, -5.8]) cylinder(r = 8 / 2, h = 8, center = true);
    translate([0, 0, -9.9]) cylinder(r = BASE_D / 2, h = 2, center=true); 
}

module reel_holder_breaked () {
    BREAK_D = 24;
    BREAK_INNER_D = 20;
    BREAK_VOID = 6;
    reel_holder_bearing();
    
    translate([0, 0, -11.5]) cylinder(r = BREAK_D / 2, h = 2, center = true);
    translate([0, 0, -11.5 - BREAK_VOID / 2 - 1]) cylinder(r = BREAK_INNER_D / 2, h = BREAK_VOID, center = true);
    translate([0, 0, -11.5 - BREAK_VOID - 2]) cylinder(r = BREAK_D / 2, h = 2, center = true); 
}

module break () {
    BREAK_INNER_D = 20.5;
    BREAK_H = 5;
    THICKNESS = 8;
    difference() {
        cylinder(r = (BREAK_INNER_D / 2) + THICKNESS, h = BREAK_H, center = true);
        cylinder(r = BREAK_INNER_D / 2, h = BREAK_H + 1, center = true);
        
        translate([0, 50, 0]) cube([100, 100, 100], center = true);
    }
    translate ([(BREAK_INNER_D / 2) + 11, 0, 0]) {
        difference () {
            translate([-2, 0, 0]) cylinder(r = 9, h = BREAK_H, center = true);
            cylinder(r = 3, h = BREAK_H + 1, center = true);
            
            translate([0, -50, 0]) cube([100, 100, 100], center = true);
        }
        translate([5, 0, 0]) cylinder(r = 2, h = BREAK_H, center = true);
    }
    translate ([-(BREAK_INNER_D / 2) - 11, 0, 0]) {
        difference () {
            translate([2, 0, 0]) cylinder(r = 9, h = BREAK_H, center = true);
            cylinder(r = 3, h = BREAK_H + 1, center = true);
            
            translate([0, -50, 0]) cube([100, 100, 100], center = true);
        }
        translate([-5, 0, 0]) cylinder(r = 2, h = BREAK_H, center = true);
    }
}

module reel_holder_gear () {
    reel_holder_bearing();
    translate([0, 0, -13]) {
        difference() {
            translate([0, 0, -0.9]) cylinder(r = 8 / 2, h = 24.5 / 4, center = true);
            translate([0, 6, -0.9]) cube([8, 8, (24.5 / 4) + 1], center = true);
        }
    }
}

module idle_roller_plate () {
    //translate([0, 0, -.5]) cube([70, 70, 1], center = true);
    translate([0, 0, 1]) roller();
    translate([0, 30, (39.25 / 2) + .6]) idle_roller_peg();
    translate([30, 30, PEG_H / 2 + 2]) idle_roller_peg_top();
    translate([30, 0, 5.5 / 2]) rotate([180, 0, 0]) idle_roller_peg_cap();
}

module sprocketed_roller_plate () {
    translate([0, 0, 15]) sprocketed_roller_peg();
    translate([20, 0, 4.5]) rotate([180, 0, 0]) sprocketed_roller_peg_cap();
}

module plate () {
    //translate([0, 0, -.5]) cube([150, 150, 1], center = true);
    //pressure elastic_pegs
    translate([60, 60, PEG_H / 2]) rotate([180, 0, 0]) elastic_peg_bottom();
    translate([60, 45, (PEG_H / 2) + 2]) elastic_peg_top();
    translate([45, 60, PEG_H / 2]) rotate([180, 0, 0]) elastic_peg_bottom();
    translate([45, 45, (PEG_H / 2) + 2]) elastic_peg_top();
    //break elastic_pegs
    translate([30, 60, PEG_H / 2]) rotate([180, 0, 0]) elastic_peg_bottom();
    translate([30, 45, (PEG_H / 2) + 2]) elastic_peg_top();
    translate([15, 60, PEG_H / 2]) rotate([180, 0, 0]) elastic_peg_bottom();
    translate([15, 45, (PEG_H / 2) + 2]) elastic_peg_top();
    //reel holders
    translate([60, 25, 15.25]) reel_holder();
    translate([40, 25, 15.25]) reel_holder();
    translate([20, 25, 15.25]) reel_holder();
    translate([00, 25, 15.25]) reel_holder();
}

module sprocketed_roller_mold () {
    //sprocketed_roller();
    //translate([0, 0, 5]) cube([32, 32, 22],center=true);
    //(CUBE = [100, 200, 50], MATERIAL = 3, SIDE_TABS = 1, BOTTOM = true, BOTTOM_TABS = 3, TOP = true, TOP_TABS = 4, PADDING = 4, PROJECTION = false)
    Box2D([32, 32, 22], MATERIAL = 3, SIDE_TABS = 2, BOTTOM = true, BOTTOM_TABS = 2, TOP = false, PROJECTION = true);
}

module contact_printer (DEBUG = false) {
    translate([0, 0, -15]) inner_box(true);
    translate ([0, 15, 5 - (25.4 / 8)]) temp_inner_walls();
    translate ([0, 15, -8 + (25.4 / 4) ]) temp_outer_walls();
    //translate ([0, 15, -(25.4 / 4) - 12]) temp_bottom();
    //projection() 
    //gears_to_cut();
    //translate([0, 0, 20]) reel_holder();
    //rotate([0, 0, 90]) bearing_hobbled_rod();

    //translate([53, 0, .25]) gate();

    translate ([PRESURE_PEG_OFFSET, PRESSURE_PEG_SPACING / 2, -14.25]) {
        elastic_peg_bottom();   
        translate([0, 0, -25.4 / 4 - 2.2]) elastic_peg_top();
    }

    translate ([PRESURE_PEG_OFFSET, -PRESSURE_PEG_SPACING / 2, -14.25]) {
        elastic_peg_bottom();   
        translate([0, 0, -25.4 / 4 - 2.2]) elastic_peg_top();
    }

    translate ([BREAK_PEG_SPACING / 2, BREAK_PEG_OFFSET, -14.25]) {
        elastic_peg_bottom();   
        translate([0, 0, -25.4 / 4 - 2.2]) elastic_peg_top();
    }

    translate ([-BREAK_PEG_SPACING / 2, BREAK_PEG_OFFSET, -14.25]) {
        elastic_peg_bottom();   
        translate([0, 0, -25.4 / 4 - 2.2]) elastic_peg_top();
    }

    //negative feed
    translate([REEL_SPACING_X / 2, -REEL_SPACING / 2, 0]) {
        translate([0, 0, 1]) daylight_spool();
        translate([0, 0, REEL_HOLDER_Z]) reel_holder();
        //translate([0, 0, -10]) reel_holder_breaked();
        
        translate([0, 0, -25.5]) rotate([0, 0, -40]) break();
    }

    //negative takeup
    translate([REEL_SPACING_X / 2, REEL_SPACING / 2, 0]) {
        translate([0, 0, 1]) daylight_spool();
        translate([0, 0, REEL_HOLDER_Z]) reel_holder();
        translate([0, 0, -10]) reel_holder_gear();
    }

    //print stock feed
    translate([-REEL_SPACING_X / 2, -REEL_SPACING / 2, 0]) {
        translate([0, 0, 1]) daylight_spool();
        if (DEBUG) {
            translate([0, 0, 1]) color([1, 1, 1, .5]) cylinder(r = 150, h = 16, center = true);
        }
        translate([0, 0, REEL_HOLDER_Z]) reel_holder();
        //translate([0, 0, -10]) reel_holder_breaked();
        
        translate([0, 0, -25.5]) rotate([0, 0, 40]) break();
    }

    //print stock takeup
    translate([-REEL_SPACING_X / 2, REEL_SPACING / 2, 0]) {
        //translate([0, 0, 1]) daylight_spool();
        translate([0, 0, REEL_HOLDER_Z]) reel_holder();
        translate([0, 0, -10]) reel_holder_gear();
    }

    translate([IDLE_OFFSET - 7, (IDLE_SPACING / 2) - 7, -9]) {
        roller();
        translate([0, 0, 5]) idle_roller_peg();
        translate([0, 0, -14]) idle_roller_peg_top();
        translate([0, 0, 23]) idle_roller_peg_cap();
    }
    translate([IDLE_OFFSET, -(IDLE_SPACING / 2), -9]) {
        translate([0, 0, 0.5]) roller(DEBUG);
        translate([0, 0, 5]) idle_roller_peg();
        translate([0, 0, -14]) idle_roller_peg_top(DEBUG);
        translate([0, 0, 23.5]) idle_roller_peg_cap(DEBUG);
    }

    translate([SPROCKETED_OFFSET, -SPROCKETED_SPACING / 2, SPROCKETED_Z]) {
        rotate([180, 0 ,0]) {
            //difference () {
                contact_printer_roller();
                //translate([50, 0, 0]) cube([100, 100, 100], center = true); 
            //}
        }
        //translate([0, 0, -15]) sprocketed_roller_peg();
        //translate([0, 0, -3]) sprocketed_roller_peg_cap();
    }
    translate([SPROCKETED_OFFSET, SPROCKETED_SPACING / 2, SPROCKETED_Z]) {
        rotate([180, 0 ,0]) contact_printer_roller();
        //translate([0, 0, -15]) sprocketed_roller_peg();
        //translate([0, 0, -3]) sprocketed_roller_peg_cap();
    }
        
    //find motor mount point
    //translate([0, 157, 0]) cylinder(r = 3, h = 100, center = true);
    //takeup motor
    translate([0, 157 + 6 + 1.25, 14 + .5]) motor_15RPM();
    translate([0, 0, 14.5]) rotate([0, 0, 90]) motor_15RPM();
    
    echo("ROTATING GEARS");
    echo(INVOLUTE_ROTATE);
    translate([-REEL_SPACING_X / 2, REEL_SPACING / 2, -23]) rotate([0, 0, INVOLUTE_ROTATE]) gears_to_cut();
    //translate([REEL_SPACING_X / 2, REEL_SPACING / 2, -23]) rotate([0, 0, 180 - INVOLUTE_ROTATE ]) gears_to_cut();

    //translate([75, 0, -15]) light_source(); 
}

module reel_holder_plate () {
    reel_holder();
    translate([0, 20, 0]) reel_holder();
    translate([20, 20, 0]) reel_holder();
    translate([20, 0, 0]) reel_holder();
}

//corner pieces for outer box to support inner box 

// ___________
// |/       \|
// |         |
// |\_______/|

module spacer () {
        H = 16.3;
        W = 25;
    difference () {
            rotate([0, 0, 45]) cube([W, W, H], center = true);
            translate([150, 0, 0]) cube([300, 300, 300], center = true);
    }
}

module four_point_connector () {
        $fn = 120;
        X = 35;
        Y = 40;
        H = 8.5;
        Z = ((H - 6) / 2) - 1;
        translate([0, 0, -4.5]) {
            difference () {
                //plate
                rounded_cube([X + 5.6 + 2, Y + 5.6 + 2, 3], d = 2.8 * 2, center = true);
                //negative
                rounded_cube([X - 7, Y - 7, 4], d = 20, center = true);
            }
        }
        translate([X / 2, Y / 2, Z + 2.5]) cylinder(r = 2.8, h = H + 5, center = true);
        translate([X / 2, -Y / 2, Z + 2.5]) cylinder(r = 2.8, h = H + 5, center = true);
        
        translate([-X / 2, Y / 2, Z + .5]) cylinder(r = 2.8, h = H + 1, center = true);
        translate([-X / 2, -Y / 2, Z + .5]) cylinder(r = 2.8, h = H + 1, center = true);
}

module sprocketed_roller_gear_cap () {
    difference () {
        union () {
            cylinder(r = 16 / 2, h = 3, center = true);
            translate([0, 0, 1.5]) cylinder(r = 11 / 2, h = 6, center = true);
        }
        translate([0, 0, -30]) contact_printer_roller();
    }
}*/



//contact_printer();
/*projection() {
    intersection () {
        inner_box();
        translate([30, 0, 0]) cube([130, 160, 50], center = true);
    }
}*/
//translate([23, 0, 0]) cube([35, 45, 5], center = true);
//translate([8, 0, -26]) rotate([0, 0, 34]) import("/home/mathias/Desktop/InvoluteGear_2.dxf");
//translate([20, 0, -20]) cube([41.6, 0.5, 2], center = true);
//translate([0, 0, 6]) outer_box();
//translate([57.5, 0, 0]) four_point_connector();
//translate([40, 0, LAMP_Z]) rotate([0, 0, -90]) {
    //lamp_plate();
    //lamp_housing();
    //translate([0, 15, 4]) lamp_front();
    //gate();
    
//}
//sprocketed_roller_gear_cap ();
//reel_holder_plate();
//reel_holder();
//translate([60, 45, PEG_H / 2]) rotate([180, 0, 0]) elastic_peg_top();
//reel_holder_breaked();
//projection() gears_to_cut();
//projection() gears_to_cut_2();
//drive_gear_cap();
//break();
//sprocketed_roller();
//sprocketed_roller_plate();
//projection() 
//translate([0, 0, 15 - 6]) inner_box(true);
//projection() outer_box();
//idle_roller_plate();
//plate();
//roller();
//light_source();
//spacer();
//contact_printer_roller();

//sprocketed_roller_mold();

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

module debug () {
    DaylightZ = 11.5;
    //////
    panel([0, 0, -2.5]);
    
    translate([0, RollerY, 18]) rotate([180, 0, 0]) difference () {
        sprocketed_roller(sprockets = 18, bevel = false, model = "gearbox_motor", set_screw_top = true);
        //translate([50, 0, 0]) cube([100, 100, 100], center = true);
    }
    //lamp
    //difference () {
        lamp([0, LampY, 0 + 1]);
    //    translate([45, LampY, 0 + 2]) cube([100, 100, 100], center = true);
    //}
    color("green") lamp_cover([0, LampY + 15, 21]);
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
    //feed
    //translate([-100,  50, DaylightZ]) daylight_spool();
    //translate([-100, -50, DaylightZ]) daylight_spool();
    //takeup
    //translate([100,  50, DaylightZ]) daylight_spool();
    //translate([100, -50, DaylightZ]) daylight_spool();
    centered_geared_motor([100,  50, MotorZ], [180, 0, PictureTakeupMotorRotationZ]);
    centered_geared_motor([100, -50, MotorZ], [180, 0, StockTakeupMotorRotationZ]); 

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

module lamp (pos = [0, 0, 0]) {
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
        translate([0, 10.6+7, 11]) cube([5.5, 34, 18], center = true);
        translate([0, 5, 11]) cube([3, 20, 18], center = true);
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
    BoltX = (PanelX-10)/2;
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

PART = "";
LIBRARY = true;

if (PART == "panel") {
    rotate([180, 0, 0]) panel();
} else if (PART == "lamp") {
    lamp();
} else if (PART == "picture_gate") {
    rotate([-90, 0, 0]) picture_gate(Type = "standard");
} else if (PART == "sprocketed_roller_reinforced") {
    sprocketed_roller(sprockets = 18, bevel = false, model = "gearbox_motor", reinforced = true, bolts = true);
} else if (PART == "2020_tslot_insert") {
    2020_tslot_insert();
} else {
    debug();
}
