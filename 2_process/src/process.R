# Prepare data for plotting

process <- function(){
  # Prepare the data for plotting
  eval_data <- read_csv("1_fetch/out/model_RMSEs.csv", col_types = 'iccd') %>%
    filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
    mutate(col = case_when(
      model_type == 'pb' ~ '#1b9e77',
      model_type == 'dl' ~'#d95f02',
      model_type == 'pgdl' ~ '#7570b3'
    ), pch = case_when(
      model_type == 'pb' ~ 21,
      model_type == 'dl' ~ 22,
      model_type == 'pgdl' ~ 23
    ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))
  
  # Write evaluation data
  saveRDS(eval_data, file = '2_process/out/eval_data')
  write_csv(eval_data, file = '2_process/out/model_summary_results.csv')
}

process()