# Source the functions file
source("analysis/functions.R")

# Define time intervals for 6_21 file
intervals_6_21 <- list(
  list(name = "Positive Control", start_time = 1060, end_time = 1080, baseline_start = 1040, baseline_end = 1060),
  list(name = "Talking Attack A", start_time = 1130, end_time = 1150, baseline_start = 1110, baseline_end = 1130),
  list(name = "Talking Attack B", start_time = 1230, end_time = 1250, baseline_start = 1210, baseline_end = 1230),
  list(name = "Lightly Touching Face Attack", start_time = 1390, end_time = 1420, baseline_start = 1370, baseline_end = 1390)
)

# Process the file and print results
results_6_21 <- process_file("data/6_21_GSR_COPY.xlsx", "s", "uS", intervals_6_21)
cat("Results for 6_21_GSR_COPY.xlsx:\n")
print_results(results_6_21)
