# Source the functions file
source("analysis/functions.R")

# Define time intervals for 6_13 file
intervals_6_13 <- list(
  list(name = "Positive Control", start_time = 58, end_time = 68, baseline_start = 48, baseline_end = 58),
  list(name = "Talking Attack A", start_time = 137, end_time = 157, baseline_start = 117, baseline_end = 137),
  list(name = "Talking Attack B", start_time = 285, end_time = 315, baseline_start = 265, baseline_end = 285),
  list(name = "Lightly Touching Face Attack", start_time = 341, end_time = 421, baseline_start = 321, baseline_end = 341),
  list(name = "Moving Tongue Attack", start_time = 588, end_time = 623, baseline_start = 568, baseline_end = 588),
  list(name = "Touching Side of Face Attack", start_time = 709, end_time = 745, baseline_start = 689, baseline_end = 709)
)

# Process the file and print results
results_6_13 <- process_file("data/6_13_GSR_COPY.xlsx", "s", "uS", intervals_6_13)
cat("Results for 6_13_GSR_COPY.xlsx:\n")
print_results(results_6_13)
