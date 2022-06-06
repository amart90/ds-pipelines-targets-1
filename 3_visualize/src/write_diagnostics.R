# Write model diagnostics to txt file

# Define write_diagnostics() function
## Filepath_in argument to specify file path of input directory
## Filepath_out argument to specify file path of output directory

write_diagnostics <- function(filepath_in, filepath_out){
  
  # Read data
  eval_data <- read_csv(filepath_in, show_col_types = FALSE)
  
  # Compile model performance details into list
  metric_names <- c("pgdl_980mean", "dl_980mean", "pb_980mean", "dl_500mean", "pb_500mean", "dl_100mean", "pb_100mean", "pgdl_2mean", "pb_2mean")
  render_data <- sapply(metric_names, 
                        function(X) render(eval_data, sub("_.*", "", X), paste0("similar_", gsub("[^0-9]", "", X))),
                        USE.NAMES = TRUE, simplify = FALSE)
  
  # Specify model performance report template text
  template_1 <- 'Resulted in mean RMSEs (means calculated as average of RMSEs from the five dataset iterations) of {{pgdl_980mean}}, {{dl_980mean}}, and {{pb_980mean}}°C for the PGDL, DL, and PB models, respectively.
  The relative performance of DL vs PB depended on the amount of training data. The accuracy of Lake Mendota temperature predictions from the DL was better than PB when trained on 500 profiles 
  ({{dl_500mean}} and {{pb_500mean}}°C, respectively) or more, but worse than PB when training was reduced to 100 profiles ({{dl_100mean}} and {{pb_100mean}}°C respectively) or fewer.
  The PGDL prediction accuracy was more robust compared to PB when only two profiles were provided for training ({{pgdl_2mean}} and {{pb_2mean}}°C, respectively). '
  
  # Fill template with model performance data and save to file
  whisker.render(template_1 %>% 
                   str_remove_all('\n') %>% 
                   str_replace_all('  ', ' '), 
                 render_data ) %>% 
    cat(file = filepath_out)
  return(filepath_out)
}

# Define render() function to extract model performance details
# Used within write_diagnostics() function to produce render_data
render <- function(data, model, exper){
  filter(data, model_type == model, exper_id == exper) %>% 
    pull(rmse) %>% 
    mean %>% 
    round(2)
}