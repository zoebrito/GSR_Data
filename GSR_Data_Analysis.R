required_packages <- c("readxl", "pracma", "kableExtra", "e1071", "ggplot2", "dplyr")

for (package in required_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

data <- read_excel("5_21-GSR-COPY.xlsx", skip = 2)

colnames(data) <- c("Time", "Conductance")

data <- data %>%
  select(Time, Conductance)

data <- data %>%
  mutate(Time = as.numeric(Time),
         Conductance = as.numeric(Conductance)) %>%
  na.omit()

start_time <- 3.24E+02
end_time <- 6.47E+02

filtered_data <- data %>%
  filter(Time >= start_time & Time <= end_time)

auc <- trapz(filtered_data$Time, filtered_data$Conductance)
formatted_auc <- format(auc, scientific = TRUE)
print(paste("The area under the curve within the specified region is:", formatted_auc))

summary_data <- data.frame(
  Metric = c("Area Under Curve (AUC)", "Mean Conductance (gsr)", "Median Conductance (gsr)",
             "Standard Deviation (gsr)", "Variance (gsr)", "25th Percentile (gsr)", 
             "75th Percentile (gsr)", "10th Percentile (gsr)", "90th Percentile (gsr)"),
  Value = c(auc, 
            mean(data$Conductance, na.rm = TRUE), 
            median(data$Conductance, na.rm = TRUE), 
            sd(data$Conductance, na.rm = TRUE), 
            var(data$Conductance, na.rm = TRUE), 
            quantile(data$Conductance, 0.25, na.rm = TRUE), 
            quantile(data$Conductance, 0.75, na.rm = TRUE), 
            quantile(data$Conductance, 0.10, na.rm = TRUE), 
            quantile(data$Conductance, 0.90, na.rm = TRUE))
)

summary_table <- summary_data %>%
  kable(format = "html", col.names = c("Metric", "Value")) %>%
  kable_styling()

print(summary_table)

histogram <- ggplot(data, aes(x = Conductance)) +
  geom_histogram(bins = 20, fill = "lightblue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Conductance Values", x = "Conductance (uS)", y = "Frequency") +
  theme_minimal()

scatterplot <- ggplot(data, aes(x = Time, y = Conductance)) +
  geom_point(color = "blue") +
  labs(title = "Scatterplot of Conductance vs. Time", x = "Time (s)", y = "Conductance (uS)") +
  theme_minimal()

print(histogram)
print(scatterplot)