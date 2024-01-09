// This macro is used to determine the fluorescence intensity of the whole cell and the cytoplasma.
// The difference of these values is the fluorescence intensity at the plasmamembrane.
// As input a timeseries of the channel of interest is used.

//By Sven Meinerz

run("Set Measurements...", "area integrated stack display redirect=None decimal=3");
for (i = 1; i < nSlices; i++) {
    setSlice(i);
    run("Duplicate...", " ");
    run("Duplicate...", " ");
    run("Gaussian Blur...", "sigma=20");
	setAutoThreshold("Default dark no-reset");
	run("Threshold...");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Erode");
	run("Close");
	run("Watershed");
	run("Analyze Particles...", "add composite");
	close();
	roiManager("multi-measure one append");
	roiManager("reset");
	run("Duplicate...", " ");
    run("Gaussian Blur...", "sigma=15");
	setAutoThreshold("Default dark no-reset");
	run("Threshold...");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Erode");
	run("Close");
	run("Watershed");
	run("Analyze Particles...", "add composite");
	close();
	roiManager("multi-measure one append");
	roiManager("reset");
	close();
}
