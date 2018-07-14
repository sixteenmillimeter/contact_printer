include <../ReadyCAD/ready.scad>;

OUTER_D = 44.45;
CAP_D = 57.15;
WALL_THICKNESS = 3;
LENGTH = 95.25;
$fn = 100;

module rail_neg () {
    cube([17.4, 4, 120], center = true);
    cube([35, 4, 95], center = true);
    
    translate([17.4, -1.5, 0]) cube([17.5, 4, 96], center = true);
    translate([-17.4, -1.5, 0]) cube([17.5, 4, 96], center = true);
}

module rail_guide () {
    translate([10.2, 0, 0]) cube([3, 4, 72], center = true);
    translate([-10.2, 0, 0]) cube([3, 4, 72], center = true);
    translate([10.2 - .6, 1.5, 0]) cube([4.3, 1, 72], center = true);
    translate([-10.2 + .6, 1.5, 0]) cube([4.3, 1, 72], center = true);
}

module fan_holes () {
        dist = 29;
        cylinder(r = 34/2, h = 500, center = true);
        translate([dist/2, dist/2, 0]) cylinder(r = 2.9/2, h = 500, center = true);
        translate([dist/2, -dist/2, 0]) cylinder(r = 2.9/2, h = 500, center = true);
        //translate([-dist/2, -dist/2, 0]) cylinder(r = 2.9/2, h = 500, center = true);
        translate([-dist/2 + 2.1, -dist/2 + 2.1, 0]) rotate([0, 0, 45]) cube([5, 5, 500], center = true);
        translate([-dist/2, dist/2, 0]) cylinder(r = 2.9/2, h = 500, center = true);
}

module light_holder (DECOYS = false) {
	//cap
    $fn = 200;
    difference () {
        translate([0,0,(LENGTH / 2) + (WALL_THICKNESS / 2) ]) {
            cylinder(r = CAP_D / 2, h = WALL_THICKNESS, center = true);
        }
        translate([0, 22, 0]) rail_neg();
        fan_holes();
    }
     
	//tube
	difference () {
		cylinder(r = OUTER_D / 2, h = LENGTH, center = true);
		cylinder(r = (OUTER_D / 2) - WALL_THICKNESS, h = LENGTH + 10, center = true);
        translate([0, 22, 0]) rail_neg();
        //light
        translate([0, 20, -41 + 6]) rotate([90, 0, 0]) cylinder(r = 13/2, h = 25, center = true);
	}
	//rail
    translate([0, 20.5, 12]) rail_guide();
    if (DECOYS) {
        decoys(36, 48.6, 6);
    }
}
module rail (DECOYS = false) {
    difference () {
       union () {
        translate([0, 20.7, 2.4]) cube([17, 1.3, 100], center = true);
        translate([0, 21.9, 2.4]) cube([14.2, 2.8, 100], center = true);
       }
       translate([0, 20, -41 + 6]) rotate([90, 0, 0]) cylinder(r = 9/2, h = 25, center = true);
       translate([0, 23.4, -41 + 6]) rotate([90, 0, 0]) cylinder(r = 13/2, h = 3, center = true);
    }
   translate([0, 24, 52.2]) cube([24, 8, 3], center = true);
    if (DECOYS) {
        translate([0, 0, -35]) rotate([90, 45, 0]) decoys(25, -22.05);
        translate([0, 0, 42]) rotate([90, 45, 0]) decoys(25, -22.05);
    }
};

module baffle (DECOYS = false) {
    //print 3 of these
    difference () {
		cylinder(r = (OUTER_D / 2) - WALL_THICKNESS - 0.3, h = 7, center = true);
        cylinder(r = (OUTER_D / 2) - WALL_THICKNESS - 2, h = 8, center = true);
	}
    difference () {
        translate([0, 0, 2.5]) cylinder(r = (OUTER_D / 2) - WALL_THICKNESS - 0.3, h = 2, center = true);
        translate([58, 0, 0]) cube([100, 100, 100], center = true);
    }
    if (DECOYS) {
            decoys(28, 1.5, 6);
    }
}

module LED_mount () {
    $fn = 200;
    difference () {
        cylinder(r = (OUTER_D / 2) - WALL_THICKNESS - 0.015, h = 10, center = true);
        cylinder(r = (OUTER_D / 2) - WALL_THICKNESS - 0.015 - 2, h = 11, center = true);
        translate([0, (OUTER_D / 2) +4, 0]) cube([OUTER_D, OUTER_D, OUTER_D], center = true);
    }
    translate ([0, 0, -4.5]) {
        intersection() {
            difference () {
                cylinder(r = (OUTER_D / 2) - WALL_THICKNESS - 0.015, h = 15, center = true);
                cylinder(r = (OUTER_D / 2) - WALL_THICKNESS - 0.015 - 2, h = 16, center = true);
            }
           translate ([0, -17, -1]) cube([7, 7, 15], center = true); 
        }
    }
    difference () {
        union () {
            difference () {
                translate([0, -6, 0]) cube([OUTER_D - 8, 2, 10], center = true);
                translate([OUTER_D / 2 - 3.5, -6.5, 0]) rotate([0, 0, 60]) cube([4, 2, 10], center = true);
                translate([-OUTER_D / 2 + 3.5, -6.5, 0]) rotate([0, 0, -60]) cube([4, 2, 10], center = true);
            }
            translate([7.5, -5, 0]) cube([4, 4, 10], center = true);
            translate([-7.5, -5, 0]) cube([4, 4, 10], center = true);
        }
        translate([7.5, 0, 0]) rotate([90, 0, 0]) cylinder(r = 1, h = 40, center = true);
        translate([0, 0, 0]) rotate([90, 0, 0]) cylinder(r = 1, h = 40, center = true);
        translate([-7.5, 0, 0]) rotate([90, 0, 0]) cylinder(r = 1, h = 40, center = true);
    }
    translate([0, -8, 0]) scale([1.5, 1, 1]) decoys(20, 3);
}

//rail(true);
/*difference() {
    light_holder(false);
    //translate([0, 0, -36]) LED_mount();
    translate([0, 0, 60]) cube([200, 200, 200], center = true);
}
decoys(30, -45.64, 6);*/

baffle();