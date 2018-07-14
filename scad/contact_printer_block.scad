difference () {
	union () {
		translate([0, 0, 9.5/4]) cube([25.4, 9.5 * 2, 25.4 + (9.5 / 2)], center = true);
		translate([0, (25.4 * 3) / 2, 0]) cube([25.4, 25.4 * 3, 25.4], center = true);
	}
	cube([25.4, 9.7, 25.4], center = true);
	translate([5, 9.5 + (25.4 * 3) / 2, 14]) rotate([0, 45, 0]) cube([25.4 * 2, 25.4 * 3, 25.4], center = true);
}
