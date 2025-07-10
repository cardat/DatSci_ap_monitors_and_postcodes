# DatSci_ap_monitors_and_postcodes
Ivan Hanigan & Anh Han

20250708

## NSW AQ Monitoring Stations Buffer Analysis

### Overview
This repository contains an analytical pipeline using R `targets` package to analyse spatial coverage and proximity patterns of air quality monitoring stations and postcode boundaries. The analysis calculates postcodes areas and coverage proportions within 5km and 10km buffers around each monitoring stations, with initial development focused on NSW DCCEEW stations but designed for adaptation to other Australian states and territories.

### Objectives
1. Generate 5km and 10km buffers around each of the 51 NSW air quality monitoring stations
2. Identify postcodes that intersect with each buffer zone
3. Calculate the area (m^2^) of postcode coverage within each buffer
4. Calculate the percentage of each postcode covered within the buffer zones

### Data sources
- AQ monitoring stations `data_provided/` contains latitude/longitude coordinates for 51 NSW monitoring stations, using `GDA94` coordinate system (EPSG:4283)

- Postcode boundaries retrieved from the _ABS Postal Areas 2016_. Dataset can be found in [Cloud CARDAT](https://cloud.car-dat.org/index.php/apps/files/files/5714?dir=/Environment_General/ABS_data/ABS_POA/abs_poa_2016_data_provided). 