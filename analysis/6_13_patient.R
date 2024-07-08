# Load necessary packages
required_packages <- c("readxl", "pracma")

for (package in required_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Read data from the provided Excel file
data <- read_excel("data/6_13_GSR_COPY.xlsx")

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

# Define time intervals for positive control and other attacks
positive_control_start <- 58
positive_control_end <- 68
positive_control_baseline_start <- 48
positive_control_baseline_end <- 58

talking_attack_A_start <- 137
talking_attack_A_end <- 157
talking_attack_A_baseline_start <- 117
talking_attack_A_baseline_end <- 137

talking_attack_B_start <- 285
talking_attack_B_end <- 315
talking_attack_B_baseline_start <- 265
talking_attack_B_baseline_end <- 285

lightly_touching_face_attack_start <- 341
lightly_touching_face_attack_end <- 421
lightly_touching_face_attack_baseline_start <- 321
lightly_touching_face_attack_baseline_end <- 341

moving_tongue_attack_start <- 588
moving_tongue_attack_end <- 623
moving_tongue_attack_baseline_start <- 568
moving_tongue_attack_baseline_end <- 588

touching_side_face_attack_start <- 709
touching_side_face_attack_end <- 745
touching_side_face_attack_baseline_start <- 689
touching_side_face_attack_baseline_end <- 709

# Calculate AUCs for the specified regions
positive_control_result <- calculate_auc_with_baseline(data, positive_control_start, positive_control_end, positive_control_baseline_start, positive_control_baseline_end)
talking_attack_A_result <- calculate_auc_with_baseline(data, talking_attack_A_start, talking_attack_A_end, talking_attack_A_baseline_start, talking_attack_A_baseline_end)
talking_attack_B_result <- calculate_auc_with_baseline(data, talking_attack_B_start, talking_attack_B_end, talking_attack_B_baseline_start, talking_attack_B_baseline_end)
lightly_touching_face_attack_result <- calculate_auc_with_baseline(data, lightly_touching_face_attack_start, lightly_touching_face_attack_end, lightly_touching_face_attack_baseline_start, lightly_touching_face_attack_baseline_end)
moving_tongue_attack_result <- calculate_auc_with_baseline(data, moving_tongue_attack_start, moving_tongue_attack_end, moving_tongue_attack_baseline_start, moving_tongue_attack_baseline_end)
touching_side_face_attack_result <- calculate_auc_with_baseline(data, touching_side_face_attack_start, touching_side_face_attack_end, touching_side_face_attack_baseline_start, touching_side_face_attack_baseline_end)

# Print the results
cat("Positive Control AUC:", format(positive_control_result$auc, scientific = TRUE), "\n")
cat("Talking Attack A AUC:", format(talking_attack_A_result$auc, scientific = TRUE), "\n")
cat("Talking Attack B AUC:", format(talking_attack_B_result$auc, scientific = TRUE), "\n")
cat("Lightly Touching Face Attack AUC:", format(lightly_touching_face_attack_result$auc, scientific = TRUE), "\n")
cat("Moving Tongue Attack AUC:", format(moving_tongue_attack_result$auc, scientific = TRUE), "\n")
cat("Touching Side of Face Attack AUC:", format(touching_side_face_attack_result$auc, scientific = TRUE), "\n")