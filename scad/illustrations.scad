use <./contact_printer.scad>;

PART = "gates";


if (PART == "sprocketed_roller_invert_solid") {
	$fn = 200;
	sprocketed_roller_invert_solid();
} else if (PART == "magnetic_clutch") {
	MAGNETS = 4;
	MAGNET_D = 8.1;
	MAGNET_H = 2.5;
	H = 3;
	OFFSET = 12;

	centered_geared_motor([0, 0, -70], [180, 0, 0]);
    translate([0, 0, -30]) rotate([0, 0, 90]) magnetic_coupling();
    for (i = [0 : MAGNETS - 1]) {
        rotate([0, 0, i * (360 / MAGNETS)]) {
            translate([0, OFFSET, -22]) {
                cylinder(r = R(MAGNET_D), h = MAGNET_H, center = true, $fn = 50);
            }
        }
    }
    translate([0, 0, 20]) {
    	m4_nut();
    	translate([0, 0, 20]) cylinder(r = R(4), h = 40, center = true, $fn = 30);
    }
    translate([0, 0, 0]) slip_coupling();
    translate([0, 0, 30]) contact_printer_daylight_spool_insert_reinforced();
    translate([0, 0, 70]) contact_printer_daylight_spool_insert_reinforced_nut();
	translate([0, 0, 80]) difference () {
		m4_nut();
		cylinder(r = R(4), h = 5, center = true, $fn = 30);
	} 
} else if (PART == "gates") {
    picture_gate_standard([-30, 0, 0]);
    picture_gate_full([-10, 0, 0]);
    picture_gate_super16([10, 0, 0]);
    picture_gate_sound([30, 0, 0]);
}
/*
PART = "feed_panel_picture";
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
} else if (PART == "gate_picture") {
    picture_gate_standard(rot = [-90, 0, 0]);
} else if (PART == "gate_full") {
    picture_gate_full(rot = [-90, 0, 0]);
} else if (PART == "gate_super16") {
    picture_gate_super16(rot = [-90, 0, 0]);
} else if (PART == "gate_sound") {
    picture_gate_sound(rot = [-90, 0, 0]);
} else if (PART == "sprocketed_roller_invert") {
    sprocketed_roller_invert();
} else if (PART == "sprocketed_roller_invert_solid") {
    sprocketed_roller_invert_solid();
} else if (PART == "sprocketed_roller_reinforced_wheel") {
    rotate([180, 0, 0]) sprocketed_roller_reinforced_wheel(sprockets = 18, bevel = true, model = "gearbox_motor", nuts = true);
} else if (PART == "magnetic_coupling") {
    contact_printer_magnetic_coupling();
} else if (PART == "slip_coupling"){
    contact_printer_slip_coupling();
} else if (PART == "daylight_spool_insert_reinforced_nut") {
    contact_printer_daylight_spool_insert_reinforced_nut();
} else if (PART == "daylight_spool_insert_reinforced") {
    contact_printer_daylight_spool_insert_reinforced();
} else if (PART == "corner_foot") {
    rotate([180, 0, 0]) corner_foot();
} else if (PART == "2020_tslot_insert") {
    2020_tslot_insert();
} else if (PART == "bearing_post_nut"){
    bearing_post_nut();
} else if (PART == "idle_roller_half_a") {
    idle_roller_half_a();
} else if (PART == "idle_roller_half_b") {
    idle_roller_half_b();
} else if (PART == "gate_carrier") {
    rotate([0, 0, 0]) gate_carrier();
} else if (PART == "lamp_LEDs") {
    rotate([90, 0, 0]) lamp_LEDs();
} else if (PART == "electronics_panel") {
    electronics_panel(rot = [180, 0, 0]);
} else if (PART == "knob"){
    contact_printer_knob();
} else {
    //debug();
    //difference () {
        debug_lamp();
        //translate([0, -50, 0]) cube([100, 100, 100], center = true);
    //}
    //debug_clutch();
}
*/