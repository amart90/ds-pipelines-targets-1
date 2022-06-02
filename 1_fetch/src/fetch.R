# Retrieve model prediction data from ScienceBase

# Define fetch() function
## Filepath_out argument to specify file path of output directory

fetch <- function(filepath_out){
  # Retrieve the data from ScienceBase
  item_file_download('5d925066e4b0c4f70d0d0599', 
                     names = 'me_RMSE.csv', 
                     destinations = file.path(filepath_out, 'model_RMSEs.csv'), 
                     overwrite_file = TRUE)
}

