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

motorShaftD = 6;
motorShaftHobble = 0.8;

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

module gearbox_motor_shaft (H = 16, pad = 0) {
    difference () {
        cylinder(r = R(motorShaftD) + pad, h = H, center = true, $fn = 60);
        translate([motorShaftD - motorShaftHobble + pad, 0, 0]) cube([motorShaftD, motorShaftD, H + 1], center = true);
    }
}

module gearbox_motor_shaft_void (H = 16) {
    pad = 0.2;
    gearbox_motor_shaft(H, pad);
}

module bearing_laser_void (x, y, z, width= 8, hole = true) {
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

module m3_nut_void (pos = [0, 0, 0], rot = [0, 0, 0], H = 20) {
    translate(pos) rotate(rot) {
        translate([0, 6, -4.25 + (2.75/2)]) cube([6, 12, 2.75], center = true);
        cylinder(r = R(3.25), h = H, center = true, $fn = 30);
        translate([0, 0, -4.25]) hex(6, 2.75);
        translate([0, 0, (H/2)-4.5]) cylinder(r = R(6), h = 5, center = true, $fn = 40);
    }
}

module m3_bolt_void (pos = [0, 0, 0]) {
    translate(pos) {
        cylinder(r = R(3.25), h = 40, center = true, $fn = 30);
        translate([0, 0, 14]) cylinder(r = R(6), h = 5, center = true, $fn = 40);
    }
}

module sprocketed_wheel_m3_nut_void (pos = [0, 0, 0]) {
    translate(pos) {
        cylinder(r = R(3.25), h = 40, center = true, $fn = 30);
        hex(6.3, 4);
    }
}

module sprocketed_roller_sprocket_wheel (pos = [0, 0, 0], rot = [0, 0, 0], sprockets = 8, D, bevel = false, bolts = false) {
    translate(pos) rotate(rot) {
        cylinder(r = R(D), h = SprocketBaseH, center = true);
        for (i = [0: sprockets]) {
            rotate([0, 0, i * 360 / sprockets]) sprocket([(D / 2) - .01, 0, (SprocketBaseH / 2) - (SprocketL / 2)], [0, 90, 0], bevel);
        }
    }
}

module sprocketed_roller_body (pos = [0, 0, 0], rot = [0, 0, 0], sprockets = 8, bevel = false, reinforced = false, bolts = false) {
    D = (FrameC * sprockets) / PI;
    LipD = (LipC * sprockets) / PI;
    TopD = (TopC * sprockets) / PI;
    TopBaseD = (TopBaseC * sprockets) / PI;
    InnerD = D - 5.07;
    ReinforcedRegistration = (InnerD - 5) / 2;
    ReinforcedRegistrationCorner = sqrt(pow(2.5, 2) + pow(2.5, 2));
    BoltsY = ReinforcedRegistration + 12.5;

    echo("D", D);
    echo("LipD", LipD);
    echo("InnerD", InnerD);

    translate(pos) rotate(rot) difference() {
        //top
        union () {
            if (!reinforced) {
                sprocketed_roller_sprocket_wheel(sprockets = sprockets, D = D, bevel = bevel);
            } else {
                cube([ReinforcedRegistration + 5, ReinforcedRegistration, SprocketBaseH], center = true);
                cube([ReinforcedRegistration, ReinforcedRegistration + 5, SprocketBaseH], center = true);
                translate([(ReinforcedRegistration/2), (ReinforcedRegistration/2), 0]) rotate([0, 0, 45]) cube([ReinforcedRegistrationCorner, ReinforcedRegistrationCorner, SprocketBaseH], center = true);
            }

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
        }
        if (reinforced && bolts) {
            m3_bolt_void([0, BoltsY/2, 0]);
            m3_bolt_void([0, -BoltsY/2, 0]);
        }
    }
}

module sprocketed_roller (pos = [0, 0, 0], rot = [0, 0, 0], sprockets = 8, bevel = false, reinforced = false, bolts = false, model = "") {
    D = (FrameC * sprockets) / PI;
    difference () {
        union () {
            sprocketed_roller_body(pos = pos, rot = rot, sprockets = sprockets, bevel = bevel, reinforced = reinforced, bolts = bolts);
            //translate(pos) rotate(rot) addition();
        }
        if (model == "gearbox_motor") {
            translate(pos) rotate(rot) translate([0, 0, 10]) gearbox_motor_shaft_void();
            translate(pos) rotate(rot) m3_nut_void(pos=[D/4, 0, 8.5], rot = [90, 0, 90], H = D/2);
        }
    }
}

module sprocketed_roller_reinforced (pos = [0, 0, 0], rot = [0, 0, 0], sprockets = 8, bevel = true, model = "", bolts = true) {
    D = (FrameC * sprockets) / PI;
    InnerD = D - 5.07;
    ReinforcedRegistration = (InnerD - 5) / 2;
    BoltsY = ReinforcedRegistration + 12;
    difference () {
        sprocketed_roller_sprocket_wheel (pos = pos, rot = rot, sprockets = sprockets, D = D, bevel = bevel);
        scale([1.01, 1.01, 1]) sprocketed_roller (pos = pos, rot = rot, sprockets = sprockets, bevel = bevel, reinforced = true, model = model);
        if (bolts) {
            sprocketed_wheel_m3_nut_void([0, BoltsY/2, -4]);
            sprocketed_wheel_m3_nut_void([0, -BoltsY/2, -4]);
        }
    }
}

PART = "sprocketed_roller_reinforced";
if (PART == "sprocketed_roller_reinforced") {
    rotate([180, 0, 0]) sprocketed_roller(sprockets = 18, bevel = false, model = "gearbox_motor", reinforced = true, bolts = true);
} else if (PART == "sprocketed_wheel") {
    rotate([180, 0, 0]) color("red") sprocketed_roller_reinforced(sprockets = 18, bevel = false, model = "gearbox_motor", bolts = true);
}


