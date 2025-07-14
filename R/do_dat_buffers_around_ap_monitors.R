## tar_load(dat_load_ap_monitors)
do_dat_buffers_around_ap_monitors <- function(
  dat_load_ap_monitors
){
vect_obj <- unwrap(dat_load_ap_monitors)
buff_5km <- buffer(vect_obj, width = 5000)
writeVector(buff_5km, "data_derived/buff_5km.gpkg")
buff_10km <- buffer(vect_obj, width = 10000)
output <- list(wrap(buff_5km), wrap(buff_10km))
return(output)
}