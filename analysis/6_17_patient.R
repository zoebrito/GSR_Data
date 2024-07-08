# Load necessary packages
required_packages <- c("readxl", "pracma")

for (package in required_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Read data from the provided Excel file
data <- read_excel("data/6_17_GSR_COPY.xlsx")

# Check and clean column names
current_colnames <- colnames(data)
colnames(data)[which(current_colnames == "s")] <- "Time"
colnames(data)[which(current_colnames == "uS")] <- "Conductance"

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

# Define time intervals for positive control and pain attack
positive_control_start <- 22.4
positive_control_end <- 42.4
positive_control_baseline_start <- 2.4
positive_control_baseline_end <- 22.4

pain_attack_start <- 313
pain_attack_end <- 343
pain_attack_baseline_start <- 293
pain_attack_baseline_end <- 313

# Calculate AUCs for the specified regions
positive_control_result <- calculate_auc_with_baseline(data, positive_control_start, positive_control_end, positive_control_baseline_start, positive_control_baseline_end)
pain_attack_result <- calculate_auc_with_baseline(data, pain_attack_start, pain_attack_end, pain_attack_baseline_start, pain_attack_baseline_end)

# Print the results
cat("Positive Control AUC:", format(positive_control_result$auc, scientific = FALSE), "\n")
cat("Pain Attack AUC:", format(pain_attack_result$auc, scientific = FALSE), "\n")
