library(targets)

lapply(list.files("R", full.names = TRUE), source)

tar_option_set(
  packages =
    c("targets",
      "data.table",
      "terra",
      "sf"
    )
)

# Load config settings
source("config.R")

list(
  ####  dat_load_ap_monitors ####
  tar_target(
    dat_load_ap_monitors,
    do_dat_load_ap_monitors(filename = filename_ap_monitors)
  )
  ,
  ####  dat_buffers_around_ap_monitors ####
  tar_target(
    dat_buffers_around_ap_monitors,
    do_dat_buffers_around_ap_monitors(dat_load_ap_monitors)
  )
  ,
  ####  dat_load_postcodes ####
  tar_target(
    dat_load_postcodes,
    do_dat_load_postcodes(filename = filename_polygons)
  )
  ,
  ####  dat_load_intersect_buffer_and_postcodes ####
  tar_target(
    dat_load_intersect_buffer_and_postcodes,
    do_dat_load_intersect_buffer_and_postcodes(dat_buffers_around_ap_monitors, dat_load_postcodes)
  )
  ,
  #### Save results ####
  tar_target(
    save_results,
    fwrite(dat_load_intersect_buffer_and_postcodes, "data_derived/buffer_postcode_coverage_all_20250715.csv")
  )
)
