//Macro for semi-automated batch analysis of images via Coloc2
//Input image should be in TIF-Format. This speeds the whole thing up.
//By Sven Meinerz

//Get directory of images and ROIs.
//For some reason the messages can not start with the same words.
images = getDirectory("Select folder with input images for Coloc2");
boundaries = getDirectory("_Select folder with saved ROIs for Coloc2");
output = getDirectory("Where should the results be saved");
list = getFileList(images);
list2 = getFileList(boundaries);

//Here one image will be opened to check for the channels which should be analyzed.
open(images+list[0]);
rename("Example");
Dialog.create("Basic Batch Coloc2");
Dialog.addString("Number of first channel", "1");
Dialog.addString("Number of second channel", "2");
Dialog.show();

c1 = Dialog.getString();
c2 = Dialog.getString();
run("Duplicate...", "duplicate channels=c1");
selectImage("Example");
run("Duplicate...", "duplicate channels=c2");
selectImage("Example");
close();

waitForUser("Are these the channels you want to analyze?");
close("*");

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
	close();
 	roiManager("open", boundaries+list2[i]);
 	run("Coloc 2", "channel_1=green channel_2=red roi_or_mask=[ROI Manager] threshold_regression=Bisection costes'_significance_test psf=4 costes_randomisations=10");
	getInfo("log");
	saveAs("text", output + i + "_" + imagesName + "-Coloc_data.txt");
 	close("*");
 	selectWindow("Log");
 	run("Close");
 	roiManager("reset");
 	}

print("All done!")
