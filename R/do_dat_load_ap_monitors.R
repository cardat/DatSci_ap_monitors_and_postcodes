## filename_ap_monitors <- "data_provided/Location of relevant monitoring stations ACAM.csv"
do_dat_load_ap_monitors <- function(
  filename = "data_provided/Location of relevant monitoring stations ACAM.csv"
){
dat <- read.csv(filename)
names(dat) <- tolower(names(dat))
names(dat) <- gsub("\\.", "_", names(dat))
names(dat) <- gsub("__", "_", names(dat))


vect_obj <- vect(dat, geom = c("longitude_east_", "latitude_south_"), crs = "EPSG:4283") # GDA94 is EPSG:4283
plot(vect_obj)
vect_obj <- wrap(vect_obj)
return(vect_obj)
}