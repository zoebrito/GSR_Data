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

# Function to process a single file with multiple intervals
process_file <- function(file_path, time_col, conductance_col, intervals) {
  data <- load_and_clean_data(file_path, time_col, conductance_col)
  
  results <- list()
  
  for (interval in intervals) {
    result <- calculate_auc_with_baseline(data, interval$start_time, interval$end_time, interval$baseline_start, interval$baseline_end)
    results[[interval$name]] <- result
  }
  
  return(results)
}

# Function to print results
print_results <- function(results) {
  for (name in names(results)) {
    cat(name, "AUC:", format(results[[name]]$auc, scientific = FALSE), "\n")
  }
}
