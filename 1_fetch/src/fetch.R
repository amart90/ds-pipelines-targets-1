# Retrieve model prediction data from ScienceBase

# Define fetch() function
# filepath_out argument is file path to output directory
fetch <- function(filepath_out = '1_fetch/out'){
  # Set up environment
  # Get the data from ScienceBase
  item_file_download('5d925066e4b0c4f70d0d0599', 
                     names = 'me_RMSE.csv', 
                     destinations = file.path(filepath_out, 'model_RMSEs.csv'), 
                     overwrite_file = TRUE)
}

# Execute fetch() function
fetch()
sbtools::item_file_download()