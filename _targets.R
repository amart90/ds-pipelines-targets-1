library(targets)
source("1_fetch/src/fetch.R")
source("2_process/src/process.R")
source("3_visualize/src/visualize.R")
source("3_visualize/src/write_diagnostics.R")

tar_option_set(packages = c("tidyverse", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    fetch(filepath_out = '1_fetch/out/model_RMSEs.csv'),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    process(filepath_in = model_RMSEs_csv,
            filepath_out = '2_process/out/model_summary_results.csv',
            viz_col = c('#1b9e77', '#d95f02', '#7570b3'),
            viz_pch = c(21, 22, 23)),
    format = "file"
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    visualize(filepath_in = eval_data,
              filepath_out = '3_visualize/out/figure_1.png'), 
    format = "file"
  ),

  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    write_diagnostics(filepath_in = eval_data,
                      filepath_out = '3_visualize/out/model_diagnostic_text.txt'), 
    format = "file"
  )
)
