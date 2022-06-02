# Define fetch() funtion
fetch <- function(repo_path){
  # Set up environment
  library(sbtools)
  setwd(repo_path)
  
  # Get the data from ScienceBase
  item_file_download('5d925066e4b0c4f70d0d0599', 
                     names = 'me_RMSE.csv', 
                     destinations = '1_fetch/out/model_RMSEs.csv', 
                     overwrite_file = TRUE)
}

# Execute fetch() function
fetch("C:/Users/ajmartinez/GithubProjects/ds-pipelines-targets-1")