# Source the functions file
source("analysis/functions.R")

# Define time intervals for 5_21 file
intervals_4_3 <- list(
  list(name = "Positive Control 1", start_time = 473, end_time = 483, baseline_start = 453, baseline_end = 473),
  list(name = "Positive Control 2", start_time = 560, end_time = 570, baseline_start = 540, baseline_end = 560),
  list(name = "Positive Control 3", start_time = 589, end_time = 599, baseline_start = 569, baseline_end = 589),
  list(name = "Pain Attack 1", start_time = 1345, end_time = 1390, baseline_start = 1325, baseline_end = 1345),
  list(name = "Pain Attack 2", start_time = 1450, end_time = 1500, baseline_start = 1430, baseline_end = 1450)
)

# Process the file and print results
results_4_3 <- process_file("data/4-3_GSR.xlsx", "Time", "Shimmer_847A_GSR_Skin_Conductance_CAL", intervals_4_3)
cat("Results for 4-3_GSR.xlsx:\n")
print_results(results_4_3)