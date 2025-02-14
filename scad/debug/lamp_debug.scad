include <../contact_printer.scad>;

PART="blank";

translate([0, -30, 4]) sprocketed_roller_invert_solid();
lamp_single([0, 10, 0 + 1]);
lamp_single_assembly([0, 10, 0 + 1]);