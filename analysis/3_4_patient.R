# Source the functions file
source("analysis/functions.R")

# Define time intervals for 5_21 file
intervals_3_4 <- list(
  list(name = "Positive Control 1", start_time = 209, end_time = 219, baseline_start = 189, baseline_end = 209),
  list(name = "Positive Control 2", start_time = 304, end_time = 314, baseline_start = 184, baseline_end = 304),
  list(name = "Positive Control 3", start_time = 454, end_time = 464, baseline_start = 434, baseline_end = 454)
)

# Process the file and print results
results_3_4 <- process_file("data/3-4-HFS_GSR.xlsx", "Time", "Shimmer_847A_GSR_Skin_Conductance_CAL", intervals_3_4)
cat("Results for 3-4-HFS_GSR.xlsx:\n")
print_results(results_3_4)