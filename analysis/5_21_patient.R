# Source the functions file
source("analysis/functions.R")

# Define time intervals for 5_21 file
intervals_5_21 <- list(
  list(name = "Positive Control", start_time = 50, end_time = 60, baseline_start = 40, baseline_end = 50),
  list(name = "Pretzel Attack", start_time = 419, end_time = 469, baseline_start = 369, baseline_end = 419)
)

# Process the file and print results
results_5_21 <- process_file("data/5_21-GSR-COPY.xlsx", "Time", "Shimmer_847A_GSR_Skin_Conductance_CAL", intervals_5_21)
cat("Results for 5_21-GSR-COPY.xlsx:\n")
print_results(results_5_21)