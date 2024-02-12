include <BOSL2/std.scad>

$fn = 256;

// Settings
spool_width = 55;
spool_inner_width = 5;
head_height = 5;
brim_width = 5;
dial_height = 3;
chamfer_mm = 2;

// Function to create a chamfered cylinder
module chamfered_cylinder(h, d, chamfer) {
    difference() {
        cylinder(h = h, d = d);
        translate([0, 0, h]) {
            chamfer_cylinder_mask(d = d, chamfer = chamfer);
        }
    }
}

// Create the spool insert
module spool_insert() {
    translate([0, 0, -10]) {
        cylinder(h = 30, d = spool_width - spool_inner_width);
    }
}

// Create the head
module head() {
    chamfered_cylinder(h = dial_height + head_height + chamfer_mm, d = spool_width + 0.5, chamfer = chamfer_mm);
}

// Create the dial
module dial() {
    chamfered_cylinder(h = dial_height, d = (2 * brim_width) + spool_width, chamfer = chamfer_mm);
}

// Main assembly
difference() {
    union() {
        head();
        dial();
    }
    spool_insert();
}

