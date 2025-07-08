## tar_load(dat_load_ap_monitors)
do_dat_buffers_around_ap_monitors <- function(
  dat_load_ap_monitors
){
vect_obj <- unwrap(dat_load_ap_monitors)
buff_5km <- buffer(vect_obj, width = 0.05)
return(wrap(buff_5km))
}