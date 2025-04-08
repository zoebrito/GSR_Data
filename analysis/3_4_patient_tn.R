# Source the functions file
source("analysis/functions.R")

# Define time intervals for 5_21 file
intervals_3_4 <- list(
  list(name = "Positive Control 1", start_time = 385, end_time = 395, baseline_start = 365, baseline_end = 385),
  list(name = "Positive Control 2", start_time = 460, end_time = 470, baseline_start = 440, baseline_end = 460),
  list(name = "Positive Control 3", start_time = 548, end_time = 558, baseline_start = 528, baseline_end = 548),
  list(name = "Pain Attack 1", start_time = 573, end_time = 660, baseline_start = 553, baseline_end = 573),
  list(name = "Pain Attack 2", start_time = 1017, end_time = 1074, baseline_start = 997, baseline_end = 1017)
  
)

# Process the file and print results
results_3_4 <- process_file("data/3-4-TN_GSR.xlsx", "Time", "Shimmer_847A_GSR_Skin_Conductance_CAL", intervals_3_4)
cat("Results for 3-4-TN_GSR.xlsx:\n")
print_results(results_3_4)