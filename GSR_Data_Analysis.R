# Load necessary packages
required_packages <- c("readxl", "pracma")

for (package in required_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Read data from the provided Excel file
data <- read_excel("5_21-GSR-COPY.xlsx", skip = 2)

# Check and clean column names
colnames(data) <- c("Time", "Conductance")

# Convert columns to numeric
data$Time <- as.numeric(data$Time)
data$Conductance <- as.numeric(data$Conductance)

# Function to calculate AUC with baseline and return adjusted data
calculate_auc_with_baseline <- function(data, start_time, end_time, baseline_start, baseline_end) {
  # Filter data for the baseline period
  baseline_data <- data[data$Time >= baseline_start & data$Time < baseline_end, ]
  
  # Calculate the average baseline conductance
  baseline_conductance <- mean(baseline_data$Conductance)
  
  # Filter data for the AUC period
  auc_data <- data[data$Time >= start_time & data$Time < end_time, ]
  
  # Subtract baseline from the conductance values
  adjusted_conductance <- auc_data$Conductance - baseline_conductance
  auc_data$Adjusted_Conductance <- adjusted_conductance
  
  # Calculate the AUC
  auc <- trapz(auc_data$Time, adjusted_conductance)
  
  return(list(auc = auc, auc_data = auc_data, baseline_conductance = baseline_conductance))
}

# Define time intervals for positive control and pretzel attack
positive_control_start <- 50
positive_control_end <- 60
positive_control_baseline_start <- 40
positive_control_baseline_end <- 50

pretzel_attack_start <- 419
pretzel_attack_end <- 469
pretzel_attack_baseline_start <- 369
pretzel_attack_baseline_end <- 419

# Calculate AUCs for the specified regions
positive_control_result <- calculate_auc_with_baseline(data, positive_control_start, positive_control_end, positive_control_baseline_start, positive_control_baseline_end)
pretzel_attack_result <- calculate_auc_with_baseline(data, pretzel_attack_start, pretzel_attack_end, pretzel_attack_baseline_start, pretzel_attack_baseline_end)

# Print the results
cat("Positive Control AUC:", format(positive_control_result$auc, scientific = FALSE), "\n")
cat("Pretzel Attack AUC:", format(pretzel_attack_result$auc, scientific = FALSE), "\n")