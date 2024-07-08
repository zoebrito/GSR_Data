# Load necessary packages
required_packages <- c("readxl", "pracma")

for (package in required_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Read data from the provided Excel file
data <- read_excel("data/6_21_GSR_COPY.xlsx")

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

# Define time intervals for   positive control and pain attack
positive_control_start <- 1060
positive_control_end <- 1080
positive_control_baseline_start <- 1040
positive_control_baseline_end <- 1060

talking_attack_A_start <- 1130
talking_attack_A_end <- 1150
talking_attack_A_baseline_start <- 1110
talking_attack_A_baseline_end <- 1130

talking_attack_B_start <- 1230
talking_attack_B_end <- 1250
talking_attack_B_baseline_start <- 1210
talking_attack_B_baseline_end <- 1230

lightly_touching_face_attack_start <- 1390
lightly_touching_face_attack_end <- 1420
lightly_touching_face_attack_baseline_start <- 1370
lightly_touching_face_attack_baseline_end <- 1390

# Calculate AUC for positive control and pain attacks
positive_control_result <- calculate_auc_with_baseline(data, positive_control_start, positive_control_end, positive_control_baseline_start, positive_control_baseline_end)
talking_attack_A_result <- calculate_auc_with_baseline(data, talking_attack_A_start, talking_attack_A_end, talking_attack_A_baseline_start, talking_attack_A_baseline_end)
talking_attack_B_result <- calculate_auc_with_baseline(data, talking_attack_B_start, talking_attack_B_end, talking_attack_B_baseline_start, talking_attack_B_baseline_end)
lightly_touching_face_attack_result <- calculate_auc_with_baseline(data, lightly_touching_face_attack_start, lightly_touching_face_attack_end, lightly_touching_face_attack_baseline_start, lightly_touching_face_attack_baseline_end)

# Print the results
cat("Positive Control AUC:", format(positive_control_result$auc, scientific = FALSE), "\n")
cat("Talking Attack A AUC:", format(talking_attack_A_result$auc, scientific = FALSE), "\n")
cat("Talking Attack B AUC:", format(talking_attack_B_result$auc, scientific = FALSE), "\n")
cat("Lightly Touching Face Attack AUC:", format(lightly_touching_face_attack_result$auc, scientific = FALSE), "\n")
