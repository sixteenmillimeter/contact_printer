$fn = 80;

include <../readyCAD/ready.scad>;
include <./16mm_sprocketed_roller_var.scad>;

    BRACE_L = 24;
    PLATE_L = 47;
    Z = 36;
    X = 45;
    OUTER_W = 34;
    INNER_W = 22.3;

module roller_base (X = 40) {
    BEARING_OUTER_D = 22;
    
    BEARING_INNER_D = 8;
    R = BEARING_OUTER_D / 2;
    BEARING_H = 10;
    EXTRA_1 = 1;
    EXTRA_2 = 3;
    
    TEST_PAD = X;
    MOUNT_HOLES = 27;
    
    OFFSET_H = 2;
    
    //cylinder(r = R, h = BEARING_H, center = true);
    translate ([0, 0, -(BEARING_H / 2) - 1]) {
        difference() {
            translate([0, 0, -1]) cylinder(r = R + EXTRA_2, h = OFFSET_H, center = true);
            cylinder(r = BEARING_OUTER_D / 2, h = OFFSET_H + 1, center = true);
        }
    }
    translate ([0, 0, -(BEARING_H / 2) - (OFFSET_H / 2) - 2]) {
        cylinder(r = TEST_PAD / 2.5, h = 2, center = true);
    }      
}

module lamp_plate() {
    //middle
    difference () {
        union () {
            //round sides
            translate([X / 2, 0, 0])  roller_base(X);
            translate([-X / 2, 0, 0]) roller_base(X);
            //corners
            translate([12 + X / 2, 9, -8]) cube([PLATE_L / 2, PLATE_L / 2, 2], center = true); 
            translate([-12 - X / 2, 9, -8]) cube([PLATE_L / 2, PLATE_L / 2, 2], center = true);
			//middle flat plane
            translate([0, 0, -8]) cube([X, Z, 2], center = true); 
			//back flat plane
            translate([0, Z, -8]) {
                difference () {
                    cube([X + PLATE_L, Z, 2], center = true);
					//back corner voids
                    translate([32, 5, 0]) cube([30, Z + 1, 3], center = true);
                    translate([-32, 5, 0]) cube([30, Z + 1, 3], center = true);
					//void for lamp housing
                    translate([0, 0, 0]) cube([34.15, Z + 1, 3], center = true);
                }
            }
        }
		//laser voids
        translate([X / 2, 0, 0]) cylinder(r = 22 / 2, h = 31, center = true);
        translate([-X / 2, 0, 0]) cylinder(r = 22 / 2, h = 31, center = true);
    }

    //pegs for corners
    translate ([41, 20 - 4.5, 4 - 6]) {
        difference () {
            cylinder(r = 3 - .2, h = 12, center = true);
            translate([0, 7, 0]) cube([10, 10, 50], center = true);
        }
		translate([0, 0, -6 + 2.4]) cylinder(r1 = 4, r2 = 3 - .2, h = 3, center =true);
    }
    translate ([-41, 20 - 4.5, 4 - 6]) {
        difference () {
            cylinder(r = 3 - .2, h = 12, center = true);
            translate([0, 7, 0]) cube([10, 10, 50], center = true);
        }
		translate([0, 0, -6 + 2.4]) cylinder(r1 = 4, r2 = 3 - .2, h = 3, center =true);
    }
    //slide holder
	
}

module light_housing () {
	color("red") translate([0, 32, -8]) cube([34, 28, 2], center = true);
	translate([0, 31, 3])  {
        difference () {
            cube([OUTER_W, 15 + 8, BRACE_L], center = true);
            cube([INNER_W, 15 + 8 + 1, BRACE_L + 1], center = true);
            //set screw holes
            translate([0, -7, 7]) rotate([0, 90, 0]) cylinder(r = 1, h = 50, center = true, $fn = 40);
            //gaps for slide wings
            translate([(INNER_W / 2) + 1, (BRACE_L / 2) - 10, 3]) color("green") cube([2, BRACE_L, 20], center = true);
            translate([-(INNER_W / 2) - 1, (BRACE_L / 2) - 10, 3]) color("green") cube([2, BRACE_L, 20], center = true);
        }
        
    }
    //light + acrylic holder
    translate([0, 45, 5]) {
        rotate([0, 0, 180]) light_holder();
        translate([0, -7.5, -11.5]) cube([10, 17, 2], center = true);
        
        translate([0, -1.5, -1]) {
            difference () {
                    cube([OUTER_W, 2, 22], center = true);
                    cube([9, 2, 22], center = true);
            }
        }   
    }
    //extended tabs from light housing                                                                 
    translate([20, 35.5, -4]) {
		difference () {
			union () {
				cylinder(r = 5, h = 10, center = true, $fn = 60);
				translate([-2.5, 0, 0]) cube([5, 10, 10], center = true);
			}
			//
			difference() {
				cylinder(r = 3.05, h = 20, center = true);
				translate([-4, 0, 0]) cube([6, 6, 21], center = true);
			}
		}
    }
    translate([-20, 35.5, -4]) {
		difference() {
			union () {
				cylinder(r = 5, h = 10, center = true, $fn = 60);
				translate([2.5, 0, 0]) cube([5, 10, 10], center = true);
			}
			//
			difference() {
				cylinder(r = 3.05, h = 20, center = true);
				translate([4, 0, 0]) cube([6, 6, 21], center = true);
			}
		}
    }	
	
}

module lamp_plate_attached () {
    difference () {
        lamp_plate(.2);
        translate([0, 18, -6 - 5.5]) rotate([0, 0, 90]) four_point_connector();
    }
}

module corner () {
        H = 22;
        W = 26;
        L = 19;
        D = 36;
    difference () {
        translate([3, 3, 0]) cube([L, W, H], center = true);
        //top negative
        translate ([-12, -12, 0]) cylinder(r = D / 2, h = H + 1, center = true);
        //inner negative
        translate ([-10.2, -6, -2.5]) cylinder(r = D / 2, h = H + 1, center = true);
        //pin
        translate ([7, 9, -(H / 4) - .01]) {
            difference() {
                cylinder(r = 3.1, h = H / 2, center = true);
                translate([0, 7, 0]) cube([10, 10, 50], center = true);
            }
			//pyramidic cylinder
			translate ([0, 0, -4.01]) cylinder(r1 = 4, r2 = 3 - .2, h = 3, center =true);
        }
		
        translate([10, -10, 0]) rotate([0, 0, 8]) cube([10, 10, 40], center = true);
    }
}

module lamp_front () {
    
    R = 70;
    T = 2;
    W = 22;
    H = 22;
    
    SLIDE_L = 15;
    BOT_H = 2;
    
    translate ([0, R, 0]) {
        difference () {
            intersection () {
                difference () {
                        cylinder(r = R, h = H, center = true, $fn = 360);
                        cylinder(r = (R - T), h = H + 1, center = true, $fn = 360);
                }
                translate([0, -R, 0]) cube([W, W, H], center = true);
            }
            //gate gap
            translate([0, -R, 0]) cube([6, W + 1, 18], center = true);
            translate ([0, -R - .5, 0]) cube([80, 2, 16.25], center = true);
        }
        translate([0, -R, 0]) {
            //slide sides
            translate([(W / 2) - (T / 2), (SLIDE_L / 2) + (T / 2), 0]) {
                cube([T, SLIDE_L, H], center = true);
                translate([2, 5.25, 1.5]) cube([2, 4.5, 19], center = true);
            }
            translate([-(W / 2) + (T / 2), (SLIDE_L / 2) + (T / 2), 0]){
                cube([T, SLIDE_L, H], center = true);
                translate([-2, 5.25, 1.5]) cube([2, 4.5, 19], center = true);
            }
            
            
            //bottom
            translate([0, (SLIDE_L / 2) + (T / 2), -(H / 2) + (BOT_H / 2) ]) {
                difference () {
                    cube([W - (T * 2), SLIDE_L, BOT_H], center = true);
                    translate([0, 8, 0]) cube([11, SLIDE_L, BOT_H + 1], center = true);
                }
            }
        
        }
    }
}

module gate (TYPE = "full", WIDTH = 2) {
    $fn = 600;
    R = 70 - 2;
    T = 2;
    W = 17.8;
    H = 20;
    difference () {
        union() {
            intersection () {
                difference () {
                        cylinder(r = R, h = H, center = true);
                        cylinder(r = (R - T), h = H + 1, center = true);
                }
                translate([0, -R, 0]) cube([W, W, H], center = true);
            }
            translate([0, -R + 3, 0]) cube([W, T, H], center = true);
            translate([0, -R - 0.5, -1]) cube([5.9, 2, 17.9], center = true);
        }
        if  (TYPE == "full") {
            translate([0, -R, -.5]) cube([WIDTH, 20, 16], center = true);
        }
    }
}



module ws2812b (H = 1.4) {
        W = 4.91 + .25;
        Z = H;
    
        cube([W, W, Z], center = true);
}

module light_holder () {
    //
    difference () {
        translate([0, 0, 0]) cube([10, 2, 18 + 4], center = true);
        rotate ([90, 0, 0]) {
            ws2812b(9);
            translate([0,6.75,0]) ws2812b(9);
            translate([0,-6.75,0]) ws2812b(9);
        }
    }   
    difference () {
        translate([0, 8.5, -1]) color("blue") cube([10, 15, 18 + 2], center = true);
        translate([0, 8.501, 0.01]) cube([6, 65, 18], center = true);
    }
}


module acrylic_piece (PROJ = false) {
        H = 18;
        W = 6;
        L = 15;
    
        if (PROJ) {
            projection() cube([H, L, W], center = true);
        } else {
            cube([W, L, H], center = true);
        }
}

//sync with other file
module four_point_connector (fuzz = 0) {
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
        translate([X / 2, Y / 2, Z + 2.5]) cylinder(r = 2.8 + fuzz, h = H + 5, center = true);
        translate([X / 2, -Y / 2, Z + 2.5]) cylinder(r = 2.8 + fuzz, h = H + 5, center = true);
        
        translate([-X / 2, Y / 2, Z + .5]) cylinder(r = 2.8 + fuzz, h = H + 1, center = true);
        translate([-X / 2, -Y / 2, Z + .5]) cylinder(r = 2.8 + fuzz, h = H + 1, center = true);
}

//translate([22.5, 0, 0]) contact_printer_roller();
//translate([-20, 0, 0]) contact_printer_roller();

module lamp_cover () {
    difference () {
        //base solid
        cube([40, 35, 7], center = true);
        //inner negative
        translate([0, -3, -2]) cube([34.2, 35, 7], center = true);
        //lamp/led negative
        translate([0, 3, -.75]) cube([10, 35, 6], center = true);
        //front side negative
        translate([19, -18, 0]) cube([15, 15, 10], center = true);
        translate([-19, -18, 0]) cube([15, 15, 10], center = true);
        //screws negative
        translate([0, -6, -3.5]) rotate([0, 90, 0]) cylinder(r = 3.5, h = 50, center = true);   
    }
}
//corner();
translate ([0, 0, 11]) {
    rotate([0, 180, 0]) {
        //difference() {
            //lamp_plate();
            //translate([250, 0, 0]) cube([500, 500, 500], center = true);
           //rotate([0, 0, 60]) translate([255, 0, 0]) cube([500, 500, 500], center = true);
        //}
        //translate([0, 30, 14]) lamp_cover();
        //lamp_plate_attached();
        //translate([0, 18, -6 - 6]) rotate([0, 0, 90]) four_point_connector();
        //translate ([34, 6.5, 24]) corner();
        //translate ([-34, 6.5, 24]) mirror() corner();
        
        //film plane
        //#translate ([0, 16, 4.5]) color("yellow") cube([80, 0.4, 16], center = true);
        //moves up to 2.5mm forward
        //translate ([0, 16 - 2.5, 4]) color("blue") lamp_front();
        //translate ([0, 86.1, 5]) gate(WIDTH = 1);
        //acrylic_piece(true);
    }
    //translate([0, 0, 12]) cube([90, 90, 6], center = true);
}
