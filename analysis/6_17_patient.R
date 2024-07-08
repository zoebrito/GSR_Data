# Source the functions file
source("analysis/functions.R")

# Define time intervals for 6_13 file
intervals_6_17 <- list(
  list(name = "Positive Control", start_time = 22.4, end_time = 42.4, baseline_start = 2.4, baseline_end = 22.4),
  list(name = "Pain Attack", start_time = 313, end_time = 343, baseline_start = 293, baseline_end = 313)
)

# Process the file and print results
results_6_13 <- process_file("data/6_17_GSR_COPY.xlsx", "s", "uS", intervals_6_17)
cat("Results for 6_17_GSR_COPY.xlsx:\n")
print_results(results_6_13)
