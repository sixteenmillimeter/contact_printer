include <./common/common.scad>;

SprocketBaseD = 19.05; //8 frames
SprocketBaseH = 2.7;
FrameC = (SprocketBaseD * PI) / 8;

SprocketH = 10;
SprocketW = 1;
SprocketL = 1.5;

InnerH = 10.6;


TopBaseD = 18.47;
TopBaseC = (TopBaseD * PI) / 8;
TopBaseH = 2.96;

LipD = 18.84;
LipH = 0.33;
LipC = (LipD * PI) / 8;

TopD = 21.66;
TopC = (TopD * PI) / 8;
TopH = 1.4;



echo(FrameC);

$fn = 100;

module sprocket (pos = [0, 0, 0], rot = [0, 0, 0], bevel = false) {

    translate (pos) rotate(rot) {
        difference () {
            translate([0, 0, 0]) scale([1, 1, 2.25]) rotate([90, 0, 90]) cylinder(r = SprocketW/2, h = SprocketL, center = true);
            translate([0, 0, -1]) cube([2, 2, 2], center = true);
            if (bevel) {
                translate([1.5, 0, 0]) rotate([0, -5, 0]) cube([2, 2, 3], center = true);
                translate([-1.5, 0, 0]) rotate([0, 5, 0]) cube([2, 2, 3], center = true);
            }
        }
    }
}

module sprocketed_roller_body (sprockets = 8, pos = [0, 0, 0], rot = [0, 0, 0], bevel = false) {
    D = (FrameC * sprockets) / PI;
    LipD = (LipC * sprockets) / PI;
    TopD = (TopC * sprockets) / PI;
    TopBaseD = (TopBaseC * sprockets) / PI;
    InnerD = D - 5.07;

    echo("D", D);
    echo("LipD", LipD);
    echo("InnerD", InnerD);

    translate(pos) rotate(rot) {
        //top
        cylinder(r = R(D), h = SprocketBaseH, center = true);

        //center
        translate([0, 0, (InnerH / 2) + (SprocketBaseH / 2)]) {
            cylinder(r = R(InnerD), h = InnerH, center = true);
        }

        //lip
        translate([0, 0, (TopBaseH / 2) + InnerH + (SprocketBaseH / 2) - (TopBaseH / 2) + (LipH / 2)]) {
            cylinder(r = R(LipD), h = LipH, center = true);
        }

        //bottom
        translate([0, 0, (TopH / 2) + (TopBaseH / 2) + InnerH + (SprocketBaseH / 2) + (TopBaseH / 2) - (LipH / 2)]) {
            cylinder(r = R(TopD), h = TopH, center = true);
        }

        //bottom base
        translate([0, 0, (TopBaseH / 2) + InnerH + (SprocketBaseH / 2)]) {
            cylinder(r = R(TopBaseD), h = TopBaseH, center = true);
        }

        for (i = [0: sprockets]) {
        rotate([0, 0, i * 360 / sprockets]) sprocket([(D / 2) - .01, 0, (SprocketBaseH / 2) - (SprocketL / 2)], [0, 90, 0], bevel);
        }
    }
}

module sprocketed_roller (sprockets = 8, pos = [0, 0, 0], rot = [0, 0, 0], bevel = false) {
    difference () {
        union () {
            sprocketed_roller_body(sprockets, pos, rot, bevel);
            //translate(pos) rotate(rot) addition();
        }
        //translate(pos) rotate(rot) void();
    }
}

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

sprocketed_roller(sprockets = 24, bevel = true);