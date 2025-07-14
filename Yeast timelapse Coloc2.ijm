//This macro is used to determine PCC values of a given slice of a time series
//As input a hyperstack with two channels merged und the time frame is needed.
//Your first timepoint should be your active window
//The stack must be named "Merged"

//By Sven Meinerz

selectWindow("Merged");
for (i = 1; i <= nSlices/2; i++) {
	run("Duplicate...", "duplicate frames=1");
	selectWindow("Merged");
	run("Delete Slice", "delete=frame");
	selectWindow("Merged-1");
	orig=getTitle();
	run("Split Channels");
	selectWindow("C2-Merged-1");
	rename("GFP");
	selectWindow("C1-Merged-1");
	rename("dsRED");
	selectWindow("GFP");	
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
	run("Coloc 2", "channel_1=GFP channel_2=dsRED roi_or_mask=[ROI Manager] threshold_regression=Bisection li_histogram_channel_1 li_histogram_channel_2 li_icq spearman's_rank_correlation manders'_correlation kendall's_tau_rank_correlation 2d_intensity_histogram costes'_significance_test psf=4 costes_randomisations=0");
	roiManager("delete");
	close();
	close();
}
