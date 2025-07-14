# Master script to run the pipeline
library(targets)
tar_source()
load_packages(do_it = T, force_install = F)
# this is to help running in interactive mode
# make sure you also add packages to the _targets.R file as well 
# Also load config settings
source("config.R")
# Now visualise the pipeline
tar_visnetwork(targets_only = T)
# for very dense pipelines use this layout
# library(visNetwork)
# visIgraphLayout(tar_visnetwork(targets_only = T), layout = 'layout.kamada.kawai', physics = T)

# If using the tool then you will only have a skeleton.  You need to write code then:
tar_make()

# # useful tools
# tar_meta(fields = error, complete_only = TRUE)
# tar_outdated()
# tar_invalidate()
# tar_objects()
# tar_load_everything()
tar_load(dat_load_ap_monitors)
str(dat_load_ap_monitors)
plot(dat_load_ap_monitors$Longitude..East., dat_load_ap_monitors$Latitude..South.)
