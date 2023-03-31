SprocketBaseD = 19.05; //8 frames
SprocketBaseH = 2.7;

InnerD = 13.98;
InnerH = 10.6;

TopBaseD = 18.47;
TopBaseH = 2.96;

LipD = 18.84;
LipH = 0.33;

HollowD = 4.7;
HollowBaseD = 12.01;
HollowBaseH = 6.09;

TopD = 21.66;
TopH = 1.4;

SprocketH = 10;
SprocketW = 0.79;
SprocketL = 1.3;

FrameC = (SprocketBaseD * PI) / 8;

$fn = 100;
module sprocket (pos = [0, 0, 0], rot = [0, 0, 0], bevel = false) {
    //cube([SprocketL, SprocketW, SprocketH], center = true);
    translate (pos) rotate(rot) {
        difference () {
            translate([0, 0, 0]) scale([1, 1, 2.25]) rotate([90, 0, 90]) cylinder(r = SprocketW/2, h = SprocketL, center = true);
            translate([0, 0, -1]) cube([2, 2, 2], center = true);
            if (bevel) {
                translate([1.5, 0, 0]) rotate([0, -5, 0]) cube([2, 2, 2], center = true);
                translate([-1.5, 0, 0]) rotate([0, 5, 0]) cube([2, 2, 2], center = true);
            }
        }
    }
}
module sprocketed_roller (pos = [0, 0, 0], bevel = false) {
    translate(pos) {
        difference () {
            union () {
               cylinder(r = SprocketBaseD / 2, h = SprocketBaseH, center = true);

                translate([0, 0, (InnerH / 2) + (SprocketBaseH / 2)]) cylinder(r = InnerD / 2, h = InnerH, center = true);

                translate([0, 0, (TopBaseH / 2) +InnerH + (SprocketBaseH / 2)]) cylinder(r = TopBaseD / 2, h = TopBaseH, center = true);
                translate([0, 0, (TopBaseH / 2) + InnerH + (SprocketBaseH / 2) - (TopBaseH / 2) + (LipH / 2)]) cylinder(r = LipD / 2, h = LipH, center = true);
                translate([0, 0, (TopBaseH / 2) + InnerH + (SprocketBaseH / 2) + (TopBaseH / 2) - (LipH / 2)]) cylinder(r = LipD / 2, h = LipH, center = true);
                translate([0, 0, (TopH / 2) + (TopBaseH / 2) + InnerH + (SprocketBaseH / 2) + (TopBaseH / 2) - (LipH / 2)]) cylinder(r = TopD / 2, h = TopH, center = true);
            }
            cylinder(r = HollowD / 2, h = 100, center = true);
            translate([0, 0, (HollowBaseH / 2) - (SprocketBaseH / 2)]) cylinder(r = HollowBaseD/2, h = HollowBaseH + 0.1, center = true);
        }
        for (i = [0: 8]) {
            rotate([0, 0, i * 360 / 8]) sprocket([(SprocketBaseD / 2) -.01, 0, (SprocketBaseH / 2) - (SprocketL / 2)], [0, 90, 0], bevel);
        }
    }
}

sprocketed_roller( bevel = true);
