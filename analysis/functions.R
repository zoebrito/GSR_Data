# Load necessary packages
required_packages <- c("readxl", "pracma")

for (package in required_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Function to load and clean data
load_and_clean_data <- function(file_path, time_col, conductance_col) {
  data <- read_excel(file_path)
  
  colnames(data)[which(colnames(data) == time_col)] <- "Time"
  colnames(data)[which(colnames(data) == conductance_col)] <- "Conductance"
  
  data$Time <- as.numeric(data$Time)
  data$Conductance <- as.numeric(data$Conductance)
  
  return(data)
}

# Function to calculate AUC with baseline and return adjusted data
calculate_auc_with_baseline <- function(data, start_time, end_time, baseline_start, baseline_end) {
  baseline_data <- data[data$Time >= baseline_start & data$Time < baseline_end, ]
  baseline_conductance <- mean(baseline_data$Conductance)
  
  auc_data <- data[data$Time >= start_time & data$Time < end_time, ]
  adjusted_conductance <- auc_data$Conductance - baseline_conductance
  auc_data$Adjusted_Conductance <- adjusted_conductance
  
  auc <- trapz(auc_data$Time, adjusted_conductance)
  
  return(list(auc = auc, auc_data = auc_data, baseline_conductance = baseline_conductance))
}

calculate_percent_change_peak_to_baseline <- function(data, baseline_start, baseline_end, start_time, end_time) {
  # Calculate baseline conductance
  baseline_data <- data[data$Time >= baseline_start & data$Time < baseline_end, ]
  baseline_conductance <- mean(baseline_data$Conductance)
  
  # Identify the peak conductance within the specified peak period
  peak_data <- data[data$Time >= start_time & data$Time < end_time, ]
  peak_conductance <- max(peak_data$Conductance)
  
  # Calculate the percent change from peak to baseline
  percent_change <- ((peak_conductance - baseline_conductance) / baseline_conductance) * 100
  
  return(list(
    percent_change = percent_change,
    baseline_conductance = baseline_conductance,
    peak_conductance = peak_conductance
  ))
}


# Function to process a single file with multiple intervals
process_file <- function(file_path, time_col, conductance_col, intervals) {
  data <- load_and_clean_data(file_path, time_col, conductance_col)
  
  results <- list()
  
  for (interval in intervals) {
    auc_result <- calculate_auc_with_baseline(data, interval$start_time, interval$end_time, interval$baseline_start, interval$baseline_end)
    percent_change_result <- calculate_percent_change_peak_to_baseline(data, interval$baseline_start, interval$baseline_end, interval$start_time, interval$end_time)
    
    results[[interval$name]] <- list(
      auc_result = auc_result,
      percent_change_result = percent_change_result
    )
  }
  
  return(results)
}

# Function to print results
print_results <- function(results) {
  for (name in names(results)) {
    cat(name, "AUC:", format(results[[name]]$auc_result$auc, scientific = FALSE), "\n")
    cat(name, "Percent Change from Peak to Baseline:", format(results[[name]]$percent_change_result$percent_change, scientific = FALSE), "%\n")
  }
}
