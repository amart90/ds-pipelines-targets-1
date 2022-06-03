# Write model diagnostics to txt file

# Define write_diagnostics() function
## Filepath_in argument to specify file path of input directory
## Filepath_out argument to specify file path of output directory

write_diagnostics <- function(filepath_in, filepath_out){
  
  # Read data
  eval_data <- read_csv(file.path(filepath_in, 'model_summary_results.csv'), show_col_types = FALSE)
  
  # Define function to extract model performance details
  render <- function(model, exper){
    filter(eval_data, model_type == model, exper_id == exper) %>% 
      pull(rmse) %>% 
      mean %>% 
      round(2)
  }
  
  # Compile model performance details into list
  render_data <- 
    list(pgdl_980mean = render('pgdl', "similar_980"),
         dl_980mean = render('dl',  "similar_980"),
         pb_980mean = render('pb', "similar_980"),
         dl_500mean = render('dl', "similar_500"),
         pb_500mean = render('pb', "similar_500"),
         dl_100mean = render('dl', "similar_100"),
         pb_100mean = render('pb', "similar_100"),
         pgdl_2mean = render('pgdl', "similar_2"),
         pb_2mean = render('pb', "similar_2"))
  
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
    cat(file = file.path(filepath_out, 'model_diagnostic_text.txt'))
}

