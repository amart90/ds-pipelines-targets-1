# Load libraries
library(sbtools)
library(readr)
library(dplyr)
library(stringr)
library(whisker)


source("1_fetch/src/fetch.R")
source("2_process/src/process.R")
source("3_visualize/src/visualize.R")
source("3_visualize/src/write_diagnostics.R")


# Execute fetch() function
fetch(filepath_out = '1_fetch/out')

# Execute process() function
process(filepath_in = '1_fetch/out',
        filepath_out = '2_process/out',
        viz_col = c('#1b9e77', '#d95f02', '#7570b3'),
        viz_pch = c(21, 22, 23))

# Execute visualize() function
visualize(filepath_in = '2_process/out',
          filepath_out = '3_visualize/out')

# Execute write_diagnostics() function
write_diagnostics(filepath_in = '2_process/out',
                  filepath_out = '3_visualize/out')
