# Source the functions file
source("analysis/functions.R")

# Define time intervals for 5_21 file
intervals_3_27 <- list(
  list(name = "Positive Control 1", start_time = 400, end_time = 410, baseline_start = 380, baseline_end = 400),
  list(name = "Positive Control 2", start_time = 603, end_time = 613, baseline_start = 583, baseline_end = 603),
  list(name = "Positive Control 3", start_time = 721, end_time = 731, baseline_start = 701, baseline_end = 721),
  list(name = "Pain Attack 1", start_time = 117, end_time = 122, baseline_start = 97, baseline_end = 117),
  list(name = "Pain Attack 2", start_time = 445, end_time = 485, baseline_start = 425, baseline_end = 445),
  list(name = "Pain Attack 3", start_time = 740, end_time = 790, baseline_start = 720, baseline_end = 740)
)

# Process the file and print results
results_3_27 <- process_file("data/3-27_GSR.xlsx", "Time", "Shimmer_847A_GSR_Skin_Conductance_CAL", intervals_3_27)
cat("Results for 3-27_GSR.xlsx:\n")
print_results(results_3_27)