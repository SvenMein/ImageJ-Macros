//Macro for PCC-calculation for yeast cells
//Input image should be split into two channels, that are needed for Coloc
//close other channels
//GFP-Channel needs to be active
//Do not treat this macro as plug and play!
//Sigma of Gaussian Blur may need to be adjusted to your experiment/liking
//Same goes for number of Costes rand.

//By Sven Meinerz

resetMinAndMax
run("Duplicate...", " ");
//Check Sigma
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
//Check Coloc 2 settings
run("Coloc 2", "roi_or_mask=[ROI Manager] threshold_regression=Bisection li_histogram_channel_1 li_histogram_channel_2 li_icq spearman's_rank_correlation manders'_correlation kendall's_tau_rank_correlation 2d_intensity_histogram costes'_significance_test psf=4 costes_randomisations=50");
roiManager("delete");
close();
close();
