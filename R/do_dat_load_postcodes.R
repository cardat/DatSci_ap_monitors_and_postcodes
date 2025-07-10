## filename_polygons = "C:/Users/293139d/cloud-car-dat/Environment_General/ABS_data/ABS_POA/abs_poa_2016_data_provided/POA_2016_AUST.shp"
do_dat_load_postcodes <- function(
  filename = filename_polygons
){
vect_obj <- vect(filename)
names(vect_obj) <- tolower(names(vect_obj))
vect_obj <- vect_obj[substr(vect_obj$poa_code16, 1, 1) == "2"]
plot(vect_obj)
return(wrap(vect_obj))
}