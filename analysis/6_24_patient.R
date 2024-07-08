# 6_24_analysis.R

# Source the functions file
source("analysis/functions.R")

# Define time intervals for 6_24 file
intervals_6_24 <- list(
  list(name = "Positive Control", start_time = 26.8, end_time = 28.8, baseline_start = 24.8, baseline_end = 26.8),
  list(name = "Pain Attack", start_time = 980, end_time = 1030, baseline_start = 960, baseline_end = 980)
)

# Process the file and print results
results_6_24 <- process_file("data/6_24_GSR_COPY.xlsx", "s", "uS", intervals_6_24)
cat("Results for 6_24-GSR-COPY.xlsx:\n")
print_results(results_6_24)
