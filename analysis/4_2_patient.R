# Source the functions file
source("analysis/functions.R")

# Define time intervals for 5_21 file
intervals_4_2 <- list(
  list(name = "Positive Control 1", start_time = 243, end_time = 253, baseline_start = 223, baseline_end = 243),
  list(name = "Positive Control 2", start_time = 375, end_time = 385, baseline_start = 355, baseline_end = 375),
  list(name = "Positive Control 3", start_time = 527, end_time = 537, baseline_start = 507, baseline_end = 527),
  list(name = "Pain Attack 1", start_time = 620, end_time = 670, baseline_start = 600, baseline_end = 620),
  list(name = "Pain Attack 2", start_time = 836, end_time = 875, baseline_start = 816, baseline_end = 836),
  list(name = "Pain Attack 3", start_time = 1013, end_time = 1051, baseline_start = 993, baseline_end = 1013)
)

# Process the file and print results
results_4_2 <- process_file("data/4-2_GSR.xlsx", "Time", "Shimmer_847A_GSR_Skin_Conductance_CAL", intervals_4_2)
cat("Results for 4-2_GSR.xlsx:\n")
print_results(results_4_2)