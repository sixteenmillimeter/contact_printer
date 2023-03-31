$fn = 100;

SPROCKET_BASE_D = 19.05; //8 frames
SPROCKET_BASE_H = 2.7;
FRAME_C = (SPROCKET_BASE_D * PI) / 8;

SPROCKET_H = 10;
SPROCKET_W = 1;
SPROCKET_L = 1.5;

INNER_H = 10.6;

TOP_D = 21.66;
TOP_C = (TOP_D * PI) / 8;
TOP_H = 1.4;

TOP_BASE_D = 18.47;
TOP_BASE_C = (TOP_BASE_D * PI) / 8;
TOP_BASE_H = 2.96;

LIP_D = 18.84;
LIP_H = 0.33;
LIP_C = (LIP_D * PI) / 8;

echo(FRAME_C);

module bearing_laser (x, y, z, width= 8, hole = true) {
	innerD = 8.05;
	outerD = 22.1 - .4;
	fuzz = 0.3;
	translate ([x, y, z]) {
		difference () {
			cylinder(r = (outerD / 2) + fuzz, h = width, center = true);
			if (hole) {
				cylinder(r = innerD / 2 - fuzz, h = width, center = true);
			}
		}
	}
}

module sprocket () {
    translate ([0, 0, -SPROCKET_H/2]) {
        difference () {
            translate([0, 0, 0]) scale([1, 1.2, 2]) rotate([90, 0, 90]) cylinder(r = SPROCKET_W/2, h = SPROCKET_L, center = true);
            translate([0, 0, -1]) cube([2, 2, 2], center = true);
        }
    }
}

module sprocketed_roller (sprockets = 8) {
  D = (FRAME_C * sprockets) / PI;
  LIP_D = (LIP_C * sprockets) / PI;
  TOP_D = (TOP_C * sprockets) / PI;
  TOP_BASE_D = (TOP_BASE_C * sprockets) / PI;
  INNER_D = D - 5.07;
    
  echo(D);
  echo(LIP_D);

  //top
  cylinder(r = D / 2, h = SPROCKET_BASE_H, center = true);
    
  //center
  translate([0, 0, (INNER_H / 2) + (SPROCKET_BASE_H / 2)]) {
    cylinder(r = INNER_D / 2, h = INNER_H, center = true);
  }
  
  //lip
  translate([0, 0, (TOP_BASE_H / 2) + INNER_H + (SPROCKET_BASE_H / 2) - (TOP_BASE_H / 2) + (LIP_H / 2)]) {
      cylinder(r = LIP_D / 2, h = LIP_H, center = true);
  }
  
  //bottom
  translate([0, 0, (TOP_H / 2) + (TOP_BASE_H / 2) + INNER_H + (SPROCKET_BASE_H / 2) + (TOP_BASE_H / 2) - (LIP_H / 2)]) {
      cylinder(r = TOP_D / 2, h = TOP_H, center = true);
  }
  
  //bottom base
  translate([0, 0, (TOP_BASE_H / 2) +INNER_H + (SPROCKET_BASE_H / 2)]) {
      cylinder(r = TOP_BASE_D / 2, h = TOP_BASE_H, center = true);
  }

  for (i = [0: sprockets]) {
    rotate([0, 0, i * 360 / sprockets]) translate([(D / 2) + (SPROCKET_H / 2) - .15, 0, (SPROCKET_BASE_H / 2) - (SPROCKET_L / 2)]) rotate([0, 90, 0]) sprocket();
  }
}

//rotate([0, 0, time]) sprocketed_roller(sprockets = 13);

module corner (sprockets = 8) {
    
}

module contact_printer_roller () {
    union () {
        sprocketed_roller(13);
        translate([0, 0, 16]) cylinder(r = 12 / 2, h = 2, center = true);
        translate([0, 0, 22]) {
            difference () {
                translate([0, 0, 3]) cylinder(r = 8 / 2, h = 26, center = true, $fn = 50);
                translate([0, 6.5, 11]) cube([10, 10, 12], center = true);
            }
        }
        
    }
}
module contact_printer_roller2 () {
	innerD = 8.05;
	fuzz = 0.3;
	translate([0, 0, 21]) cylinder(r = innerD / 2 - fuzz, h = 10, center = true);
    sprocketed_roller(13);
}
//contact_printer_roller();
//contact_printer_roller2();