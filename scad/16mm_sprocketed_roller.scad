include <./common/common.scad>;

SprocketBaseD = 19.05; //8 frames
SprocketBaseH = 2.7;


SprocketH = 10;
SprocketW = 0.79;
SprocketL = 1.3;

InnerD = 13.98;
InnerH = 10.6;

TopBaseD = 18.47;
TopBaseH = 2.96;


LipD = 18.84;
LipH = 0.33;


TopD = 21.66;
TopH = 1.4;


HollowD = 4.7;
HollowBaseD = 12.01;
HollowBaseH = 6.09;

$fn = 100;

module sprocket (pos = [0, 0, 0], rot = [0, 0, 0], bevel = false) {
    //cube([SprocketL, SprocketW, SprocketH], center = true);
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

module sprocketed_roller (pos = [0, 0, 0], bevel = false) {
    SoundtrackH = (TopBaseH / 2) + InnerH + (SprocketBaseH / 2);
    translate(pos) {
        difference () {
            union () {
                //sprocket base
                cylinder(r = R(SprocketBaseD), h = SprocketBaseH, center = true);
                //center
                translate([0, 0, (InnerH / 2) + (SprocketBaseH / 2)]) cylinder(r = R(InnerD), h = InnerH, center = true);
                //soundtrack area
                translate([0, 0, SoundtrackH]) cylinder(r = R(TopBaseD), h = TopBaseH, center = true);
                translate([0, 0, SoundtrackH - (TopBaseH / 2) + (LipH / 2)]) cylinder(r = R(LipD), h = LipH, center = true);
                translate([0, 0, SoundtrackH + (TopBaseH / 2) - (LipH / 2)]) cylinder(r = R(LipD), h = LipH, center = true);
                translate([0, 0, SoundtrackH + (TopH / 2) + (TopBaseH / 2) - (LipH / 2)]) cylinder(r = R(TopD), h = TopH, center = true);
            }
            cylinder(r = HollowD / 2, h = 100, center = true);
            translate([0, 0, (HollowBaseH / 2) - (SprocketBaseH / 2)]) cylinder(r = R(HollowBaseD), h = HollowBaseH + 0.1, center = true);
        }
        for (i = [0: 8]) {
            rotate([0, 0, i * 360 / 8]) sprocket([(SprocketBaseD / 2) -.01, 0, (SprocketBaseH / 2) - (SprocketL / 2)], [0, 90, 0], bevel);
        }
    }
}

sprocketed_roller( bevel = true);
