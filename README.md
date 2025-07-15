# Postcode coverage within air quality monitoring buffers (5km and 10km from stations) in NSW Australia

Ivan Hanigan & Anh Han

20250708

## Introduction

This repository contains an R `targets` pipeline for analysing postcode-level coverage within 5km and 10km buffers around air quality monitoring stations. Developed for NSW using `terra` package, the pipeline is designed to be replicate across Australian states and territories.

The analysis performs four main tasks:

1.  Generate 5km and 10km buffers around each of the 51 NSW air quality monitoring stations
2.  Identify postcodes that intersect with each buffer zone
3.  Calculate the area (m²) of postcode coverage within each buffer
4.  Calculate the percentage of each postcode covered within the buffer zones

All spatial operations use the `GDA94` coordinate system (`EPSG:4283`) for accurate distance-based buffering and area calculations across Australian geographies.

## Methods

### Data sources

AQ monitoring stations are provided in `.xlsx` format and converted to `.csv` format for use in the pipeline. The file contains latitude and longitude coordinates for 51 NSW DCCEEW monitoring stations. During preprocessing, column names are automatically cleaned: all names are converted to lowercase format and dots or spaces are replaced with underscores `_`.

Postcode boundary data are sourced from the **Australian Bureau of Statistics Postal Areas 2016 shapefile**, available from the ABS website or through the [`Cloud CARDAT`](https://cloud.car-dat.org/index.php/apps/files/files/1107?dir=/Environment_General/ABS_data/ABS_POA) data inventory. The analysis filters for NSW postcodes using the `poa_code16` field (postcodes starting with `2`). The shapefile path is set in `config.R` via the `filename_polygons` variable.

### Contents

`R/`: Contains the R functions for data loading, buffer generation, and spatial intersection analysis

`run.R`: A master R script to run a pipeline

`_targets.R`: A main target pipeline script

`config.R`: Configuration file for state-specific settings and file paths

The pipeline requires the following R packages: `targets`, `data.table`, `terra`, `sf`

### Pipeline structure

`dat_load_ap_monitors`: Load and convert monitoring station coordinates to spatial vector object

`dat_buffers_around_ap_monitors`: Generate 5km and 10km buffers around each station

`dat_load_postcodes`: Load postcode boundaries and filter to NSW

`dat_load_intersect_buffer_and_postcodes`: Calculate intersections and coverage values

## Results

Pipeline outputs include spatial coverage metrics for each buffer and postcode intersection:

-   Postcode identifiers `poa_code16`
-   Monitoring station identifiers `nsw_air_quality_monitoring_aqmn_site`
-   Buffer distances `5km` and `10km`
-   Intersection areas `(m²)`
-   Percentages of postcode are covered by the buffer.

## Usage

The process for running the pipeline includes the following phases:

**Execution phase**: Execute the generated pipeline with `tar_make()`

-   Run the full pipeline:

```         
source("run.R")   # Loads libraries, config, and targets 
tar_make()        # Builds all pipeline targets
```

-   Visualise the pipeline structure: `tar_visnetwork(targets_only = TRUE)`

**Exploration phase**: Develop pipeline and debug errors in Interactive mode

-   Work interactively step-by-step with target outputs:\

```         
source("run.R")  
tar_load(dat_load_ap_monitors)   # Entre target name
str(dat_load_ap_monitors)  
plot(dat_load_ap_monitors$longitude_east_, dat_load_ap_monitors$latitude_south_)
```

-   Useful diagnostics:

```         
tar_meta(fields = error)         # View targets with errors  
tar_outdated()                   # Check for outdated targets  
tar_invalidate("target_name")    # Force specific target to rebuild  
tar_objects()                    # List all targets in memory
```
