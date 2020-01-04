/* This file has been generated by "music box tune tracker" v1.0 on 03 Jan 2020 17:53
 * https://github.com/odrevet/music-box-tune-tracker
 * using "Fred's Fisher Price record creator" .scad template file
 * http://www.instructables.com/id/3D-printing-records-for-a-Fisher-Price-toy-record-/
 */

// Configuration
$fn = 100;
hStock = 3;
rStock = 60.58;
oDrive = 21.8;
rDrive = 1.55;
hInset = 1;
rInset = 25.6;
hGroove = 1.2;
overlap = 0.2;

hasSecondSide = 0;

// Create disc
module createDisc() {
	union() {

		createBlank();

		// Add the notes for the song. This part is dynamically generated.
		pin(30.69,31.89,-3.6505753114420085,0);
		pin(30.69,31.89,4.721517711813806,0);
		pin(30.69,31.89,13.093610735069621,0);
		pin(30.69,31.89,21.465703758325432,0);
		pin(30.69,31.89,29.837796781581254,0);
		pin(30.69,31.89,38.20988980483707,0);
		pin(30.69,31.89,46.581982828092876,0);
		pin(30.69,31.89,54.954075851348684,0);
		pin(30.69,31.89,63.326168874604505,0);
		pin(30.69,31.89,71.69826189786032,0);
		pin(30.69,31.89,80.07035492111613,0);
		pin(30.69,31.89,88.44244794437196,0);
		pin(30.69,31.89,96.81454096762775,0);
		pin(30.69,31.89,105.18663399088356,0);
		pin(30.69,31.89,113.5587270141394,0);
		pin(30.69,31.89,121.93082003739522,0);
		pin(30.69,31.89,130.302913060651,0);
		pin(30.69,31.89,138.67500608390682,0);
		pin(30.69,31.89,147.04709910716267,0);
		pin(30.69,31.89,155.41919213041845,0);
		pin(30.69,31.89,163.79128515367427,0);
		pin(30.69,31.89,172.16337817693008,0);
		pin(30.69,31.89,180.5354712001859,0);
		pin(30.69,31.89,188.90756422344174,0);
		pin(30.69,31.89,197.27965724669752,0);
		pin(30.69,31.89,205.65175026995334,0);
		pin(30.69,31.89,214.02384329320915,0);
		pin(30.69,31.89,222.39593631646497,0);
		pin(30.69,31.89,230.7680293397208,0);
		pin(30.69,31.89,239.1401223629766,0);
		pin(30.69,31.89,247.51221538623247,0);
		pin(30.69,31.89,255.88430840948826,0);
		pin(30.69,31.89,264.2564014327441,0);
		pin(30.69,31.89,272.6284944559999,0);
		pin(30.69,31.89,281.00058747925567,0);
		pin(30.69,31.89,289.3726805025115,0);
		pin(30.69,31.89,297.74477352576736,0);
		pin(30.69,31.89,306.11686654902314,0);
		pin(30.69,31.89,314.48895957227893,0);
		pin(30.69,31.89,322.86105259553483,0);
		pin(30.69,31.89,331.23314561879056,0);
		pin(30.69,31.89,339.6052386420464,0);
		pin(30.69,31.89,347.97733166530224,0);

		title("TEST",0);


	}
}

// Create the blank, ready for dynamically added pins
module createBlank() {

	difference() {

		// stock
		cylinder(h=hStock, r=rStock);

		// top cutout
		translate(v = [0,0,hStock-hInset+overlap]) {
			cylinder(h=hInset + overlap, r=rInset);
		}

		// Bottom cutout lets the disc sit flatter, but some printers my struggle with the overhang
		translate(v = [0,0,-overlap]) {
			cylinder(h=hInset + overlap, r=rInset);
		}

		// Centre hole
		cylinder(h=hStock, r=3.22);

		// Drive holes
		translate(v = [0,oDrive,0]) { cylinder(h=hStock, r=rDrive); }
		translate(v = [0,-oDrive,0]) { cylinder(h=hStock, r=rDrive); }
		translate(v = [oDrive,0,0]) { cylinder(h=hStock, r=rDrive); }
		translate(v = [-oDrive,0,0]) { cylinder(h=hStock, r=rDrive); }

		// Tracks - each one for two notes
		track(28.15, 0);
		track(30.89, 0);
		track(33.71, 0);
		track(36.425, 0);
		track(39.225, 0);
		track(42, 0);
		track(44.825, 0);
		track(47.555, 0);
		track(50.315, 0);
		track(53.11, 0);
		track(55.9, 0);

		if (hasSecondSide > 0) {
			track(28.15, 1);
			track(30.89, 1);
			track(33.71, 1);
			track(36.425, 1);
			track(39.225, 1);
			track(42, 1);
			track(44.825, 1);
			track(47.555, 1);
			track(50.315, 1);
			track(53.11, 1);
			track(55.9, 1);
		}
	}
}

// Negative for a double track
module track(inner, onSecondSide) {
	if (onSecondSide > 0) {
		translate(v = [0,0,-overlap]) {
			difference() {
				cylinder(h=hGroove+overlap, r=inner+2);
				cylinder(h=hGroove+overlap, r=inner);
			}
		}
	}
	else {
		translate(v = [0,0,hStock-hGroove]) {
			difference() {
				cylinder(h=hGroove+overlap, r=inner+2);
				cylinder(h=hGroove+overlap, r=inner);
			}
		}
	}

}

// Create a pin at a certain angle
module pin(inner, outer, angle, onSecondSide)
{
	rotate(a=angle) {
		if (onSecondSide > 0) {
			translate(v=[inner, -0.5, - overlap]) {
				# cube (size=[outer-inner, 1 ,hGroove + overlap], center=false);
			}
		} else {
			translate(v=[inner, -0.5, hStock - hGroove - overlap]) {
				# cube (size=[outer-inner, 1 ,hGroove + overlap], center=false);
			}
		}
	}
}

// Add text
module title(text, onSecondSide)
{
// Disabled as some people had trouble with it
//	if (onSecondSide>0)
//		writecylinder(text, [0,0,-hInset], radius=20, height=hStock-hInset, h=3, t=hInset, face="bottom");
//	else
//		writecylinder(text, [0,0,0], radius=20, height=hStock-hInset, h=3, t=hInset, face="top");
}

// Do the work
createDisc();