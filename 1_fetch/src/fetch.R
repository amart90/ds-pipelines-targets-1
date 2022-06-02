# Retrieve model prediction data from ScienceBase

# Define fetch() funtion
fetch <- function(){
  # Set up environment
  # Get the data from ScienceBase
  item_file_download('5d925066e4b0c4f70d0d0599', 
                     names = 'me_RMSE.csv', 
                     destinations = '1_fetch/out/model_RMSEs.csv', 
                     overwrite_file = TRUE)
}

# Execute fetch() function
fetch()