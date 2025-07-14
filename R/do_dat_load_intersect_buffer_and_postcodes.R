## tar_load(dat_buffers_around_ap_monitors)
# tar_load(dat_load_postcodes)
do_dat_load_intersect_buffer_and_postcodes <- function(
    dat_buffers_around_ap_monitors
    ,
    dat_load_postcodes) {
  buff_5km <- unwrap(dat_buffers_around_ap_monitors[[1]])
  buff_10km <- unwrap(dat_buffers_around_ap_monitors[[2]])
  dat_load_postcodes <- unwrap(dat_load_postcodes)

  # Calculate original postcode areas (for proportion calculations)
  dat_load_postcodes$total_postcode_area <- expanse(dat_load_postcodes, unit = "m")
  with(as.data.frame(dat_load_postcodes), plot(areasqkm16, total_postcode_area))

  # Function to process intersections for a given buffer
  process_buffer_intersections <- function(
    buffer_spatvector = buff_5km
    ,
    buffer_km = 5
    ) {

    # Perform intersection
    intersections <- intersect(dat_load_postcodes, buffer_spatvector)

    # Calculate intersection areas
    intersections$intersection_area <- expanse(intersections, unit = "m")

    # Calculate proportions (percentage of postcode within buffer)
    intersections$proportion_percent <- (intersections$intersection_area / intersections$total_postcode_area) * 100

    # Convert to data.table for easier manipulation
    # Note: Adjust column names to match your actual data structure
    result_dt <- data.table(
      postcode = intersections$poa_code16,     # Adjust column name as needed
      ap_monitor = intersections$nsw_air_quality_monitoring_aqmn_site, # Adjust column name as needed
      buffer_km = buffer_km,
      area_overlap = intersections$intersection_area,
      percent_overlap = intersections$proportion_percent
    )

    return(result_dt)
  }
  results_5km <- process_buffer_intersections(buff_5km, 5)
  results_10km <- process_buffer_intersections(buff_10km, 10)
  
  # Combine both results
  results_combined <- rbindlist(list(results_5km, results_10km))
  return(results_combined)
}

