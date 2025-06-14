//Macro for an automated batch analysis of images of yeast cells via Coloc2
//Input image should be in TIF-Format. This speeds the whole thing up.
//By Sven Meinerz

//Get directory of images and results.
//For some reason the messages can not start with the same words.
images = getDirectory("Select folder with input images for Coloc2");
output = getDirectory("Where should the results be saved");
list = getFileList(images);

//Here one image will be opened to check for the channels which should be analyzed.
open(images+list[0]);
rename("Example");
Dialog.create("Basic Batch Coloc2");
Dialog.addString("Number of first channel for PCC", "1");
Dialog.addString("Number of second channel for PCC", "2");
Dialog.addString("Number of for cell segmentation", "3");
Dialog.show();

c1 = Dialog.getString();
c2 = Dialog.getString();
c3 = Dialog.getString();
run("Duplicate...", "duplicate channels=c1");
selectImage("Example");
run("Duplicate...", "duplicate channels=c2");
selectImage("Example");
close();

waitForUser("Are these the channels you want to check for correlation?");
close("*");

//Setup is finished, now the real fun begins.

setBatchMode(true);


for (i = 0; i < list.length; i++) {
	open(images+list[i]);
	imagesName=getTitle();
	//Images will be renamed so that they are more easily recognized by the macro. The names are arbitrary and have no influence on the results.
	rename("Current");
	run("Duplicate...", "duplicate channels=c1");
	rename("green");
	selectImage("Current");
	run("Duplicate...", "duplicate channels=c2");
	rename("red");
	selectImage("Current");
	run("Duplicate...", "duplicate channels=c3");
	rename("Segmentation");
	selectImage("Current");
	close();
	
	//First the image will be segmented to find the ROIs for Coloc2 analysis.
	selectImage("Segmentation");
	resetMinAndMax;
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
 	
 	//Now using Coloc2 the images will be analyzed.
 	run("Coloc 2", "channel_1=green channel_2=red roi_or_mask=[ROI Manager] threshold_regression=Bisection costes'_significance_test psf=4 costes_randomisations=10");
	getInfo("log");
	saveAs("text", output + i + "_" + imagesName + "-Coloc_data.txt");
 	close("*");
 	selectWindow("Log");
 	run("Close");
 	roiManager("reset");
 	}

print("All done!")
