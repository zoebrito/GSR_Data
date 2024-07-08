# Source the functions file
source("analysis/functions.R")

# Define time intervals for 6_26 file
intervals_6_26 <- list(
  list(name = "Positive Control", start_time = 951, end_time = 961, baseline_start = 941, baseline_end = 951),
  list(name = "Pain Attack", start_time = 648, end_time = 688, baseline_start = 628, baseline_end = 648),
  list(name = "Large Pain Attack", start_time = 1000, end_time = 1030, baseline_start = 980, baseline_end = 1000)
)

# Process the file and print results
results_6_26 <- process_file("data/6_26_GSR_COPY.xlsx", "s", "uS", intervals_6_26)
cat("Results for 6_26_GSR_COPY.xlsx:\n")
print_results(results_6_26)
