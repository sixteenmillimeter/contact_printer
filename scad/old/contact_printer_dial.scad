include <../common/common.scad>

in = 25.4;
$fn = 100;
module arrow () {
	difference () {
		cube([20, 10, 15], center=true);
		translate([0, 0, 5]) rotate([0, 20, 0]) cube([230, 10, 15], center=true);
		translate([0, -8, 0]) rotate([0, 0, 15]) cube([230, 10, 15], center=true);
		translate([0, 8, 0]) rotate([0, 0, -15]) cube([230, 10, 15], center=true);
	}
}

module dial () {
	rod_d = (3/8) * in;
	outer_d1 = 58;
	outer_d2 = 48;
	
	dial_d1 = 30;
	dial_d2 = 25;
	dial_h2 = 10;
	
	dial_h = 15;
	difference () {
		union(){
			translate([0, 0, dial_h/2]) cylinder(r1 = outer_d1/2, r2 = outer_d2/2, h = dial_h, center =true);
			translate([0, 0, dial_h + (dial_h2/2)]) cylinder(r1 = dial_d1/2, r2 = dial_d2/2, h = dial_h2, center =true);
			translate([33, 0, 7.5]) arrow();
		}
		translate([0, 0, rod_d/2 - .5]) cylinder(r = rod_d/2, h = rod_d, center=true);
		translate([rod_d - .5, 0, rod_d/2 - .5]) cube([rod_d, 3, rod_d], center=true);
		translate([rod_d + 2.5, 0, rod_d/2 - .5]) cube([4, (in/4) + 2, rod_d], center=true);
	}
}

//intersection(){
    dial();
    rotate([0, 0, 20]) decoys(41, 2, 7);
	//translate([0, 5.5, 7]) cube([32, 11, 14], center=true);
//}
