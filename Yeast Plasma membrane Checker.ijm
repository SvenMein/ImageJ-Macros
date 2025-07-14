//This macro can be used to measure fluorescence intensity at the plasma membrane of yeast cells.
//By Sven Meinerz

//Setup
//Get directory of images and results.
images = getDirectory("Select folder with input images for analysis");
output = getDirectory("Where should the results be saved");
list = getFileList(images);

//Open one image as an example and to proof check channels.
open(images+list[0]);
rename("Example");
Dialog.create("Yeast Plasma membrane Checker");
Dialog.addString("Number of channel for analysis", "1");
Dialog.show();

c1 = Dialog.getString();

//Check for correct channel.
run("Duplicate...", "duplicate channels=c1");
selectImage("Example");
close();
waitForUser("Is this the correct channel?");
close("*");

run("Set Measurements...", "area integrated stack display redirect=None decimal=3");

//Setup finished.

setBatchMode(true);

for (i = 0; i < list.length; i++) {
	open(images+list[i]);
	//Images will be renamed so that they are more easily recognized by the macro. The names are arbitrary and have no influence on the results.
	rename("Current");
	run("Duplicate...", "duplicate channels=c1");
	rename("Outer");
	selectImage("Current");
	run("Duplicate...", "duplicate channels=c1");
	rename("Inner");
	selectImage("Current");
	run("Duplicate...", "duplicate channels=c1");
	rename("Analysis");
	
	//Finding ROIs for whole cell intensity using "Outer".
	selectImage("Outer");
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
	selectImage("Analysis");
	rename("Whole Cell Intensity");
	roiManager("multi-measure one append");
	roiManager("reset");
	rename("Analysis");
	
	//Finding ROIs for cytoplasmatic intensity using "Inner".
	selectImage("Inner");
	run("Gaussian Blur...", "sigma=10");
	setAutoThreshold("Default dark no-reset");
	run("Threshold...");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Erode");
	run("Close");
	run("Watershed");
	run("Analyze Particles...", "add composite");
	close();
	selectImage("Analysis");
	rename("Cytoplasmatic Intensity");
	roiManager("multi-measure one append");
	roiManager("reset");
	close("*");
	
 	}
 	
 	//Saving results
	saveAs("Results", output+"Plasma membrane Intensity_data.txt");
 	close("*");
	

print("All done!")
