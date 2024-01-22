input = getDirectory("Select input folder");
//open dialogue to find out where results should be stored
output = getDirectory("Select output folder for results");
//Get number of images in input folder
list = getFileList(input);
setBatchMode(true);

run("3D OC Options", "volume surface nb_of_obj._voxels nb_of_surf._voxels integrated_density mean_gray_value std_dev_gray_value median_gray_value minimum_gray_value maximum_gray_value centroid mean_distance_to_surface std_dev_distance_to_surface median_distance_to_surface centre_of_mass bounding_box show_masked_image_(redirection_requiered) dots_size=5 font_size=10 show_numbers white_numbers store_results_within_a_table_named_after_the_image_(macro_friendly) redirect_to=none");

for (i = 0; i < list.length; i++) {
 	open(input+list[i]);
 	//Insert macro/analysis/processing or whatever here
	run("3D Objects Counter", "threshold=20000 slice=1 min.=10 max.=8388608 exclude_objects_on_edges objects surfaces centroids centres_of_masses statistics summary");
	//saving results
	saveAs("Results", output+i+"-data.xls");
}
