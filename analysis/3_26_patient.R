# Source the functions file
source("analysis/functions.R")

# Define time intervals for 5_21 file
intervals_3_26 <- list(
  list(name = "Positive Control 1", start_time = 175, end_time = 185, baseline_start = 155, baseline_end = 175),
  list(name = "Positive Control 2", start_time = 290, end_time = 300, baseline_start = 270, baseline_end = 290),
  list(name = "Positive Control 3", start_time = 395, end_time = 405, baseline_start = 375, baseline_end = 395)
)

# Process the file and print results
results_3_26 <- process_file("data/3-26_GSR.xlsx", "Time", "Shimmer_847A_GSR_Skin_Conductance_CAL", intervals_3_26)
cat("Results for 3-26_GSR.xlsx:\n")
print_results(results_3_26)