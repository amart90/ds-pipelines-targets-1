# Prepare data for plotting

# Define process() function
# viz_col argument to specify colors used for 'pb', 'dl', and 'pgdl' models
# viz_pch argument to specify point type used for 'pb', 'dl', and 'pgdl' models
# viz_col should be a character vector with a length of 3.
# viz_pch should be a numeric vector with a length of 3.

process <- function(filepath_in = '1_fetch/out',
                    filepath_out = '2_process/out',
                    viz_col = c('#1b9e77', '#d95f02', '#7570b3'),
                    viz_pch = c(21, 22, 23)){
  
  # Prepare the data for plotting
  eval_data <- read_csv(file.path(filepath_in, 'model_RMSEs.csv'), col_types = 'iccd') %>%
    filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
    mutate(col = case_when(
      model_type == 'pb' ~ viz_col[1],
      model_type == 'dl' ~ viz_col[2],
      model_type == 'pgdl' ~ viz_col[3]
    ), pch = case_when(
      model_type == 'pb' ~ viz_pch[1],
      model_type == 'dl' ~ viz_pch[2],
      model_type == 'pgdl' ~ viz_pch[3]
    ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))
  
  # Write evaluation data
  saveRDS(eval_data, file = file.path(filepath_out, 'eval_data'))
  write_csv(eval_data, file = file.path(filepath_out,'model_summary_results.csv'))
  
}

# Execute process() function with default color options
process()
