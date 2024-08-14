# Source Code

## Part II

### Code of TPFS

```r
# Load necessary libraries
library(ggplot2)

# Load the dataset
file_path <- "Transportation_Public_Financial_Statistics__TPFS_.csv"
df <- read.csv(file_path)

# Convert the year and value columns to appropriate types
df$year <- as.integer(df$year)
df$value <- as.numeric(df$value)

# Group by year and sum the values
annual_data <- aggregate(value ~ year, data = df, sum)

# Create the plot
ggplot(annual_data, aes(x = year, y = value)) +
  geom_line(color = "orange", size = 1) +  # Add line, color orange, line width 1
  geom_point(color = "orange", size = 3) +  # Add data points, color orange, point size 3
  labs(title = "Annual Transportation Public Financial Statistics",  # Set chart title
       x = "Year",  # Set x-axis label
       y = "Value (in USD)") +  # Set y-axis label
  theme_minimal()  # Use minimal theme
```

### Code of EVPD

```r
# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the dataset
df <- read.csv('Electric_Vehicle_Population_Data.csv')

# Top 10 electric vehicle manufacturers
top_makes <- df %>%
  count(Make) %>%
  top_n(10, n) %>%
  arrange(desc(n))

# Plot the bar chart for the top 10 electric vehicle manufacturers
ggplot(top_makes, aes(x = reorder(Make, -n), y = n)) +
  geom_bar(stat = 'identity', fill = 'lightgreen') +
  labs(title = 'Top 10 Electric Vehicle Makes', x = 'Make', y = 'Count') +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Top 10 electric vehicle models
top_models <- df %>%
  count(Model) %>%
  top_n(10, n) %>%
  arrange(desc(n))

# Plot the bar chart for the top 10 electric vehicle models
ggplot(top_models, aes(x = reorder(Model, -n), y = n)) +
  geom_bar(stat = 'identity', fill = 'lightcoral') +
  labs(title = 'Top 10 Electric Vehicle Models', x = 'Model', y = 'Count') +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

## Part III

```r
# Load necessary libraries
library(tidyverse)
library(caret)
library(ggplot2)
library(corrplot)
library(randomForest)

# Load the dataset
darknet <- read.csv("Darknet.CSV")

# Data transformation
darknet <- darknet %>% mutate_if(is.character, as.factor)

# Check and handle missing values
darknet <- na.omit(darknet)

# Ensure all columns are numeric types
darknet <- darknet %>% mutate_if(is.factor, as.numeric)

# Standardize numeric columns, remove columns with zero standard deviation
numeric_cols <- darknet %>% select_if(is.numeric)
darknet_scaled <- numeric_cols %>% select_if(~ sd(.) != 0) %>% scale()

# Create a new data frame with the standardized numeric columns
darknet <- cbind(darknet %>% select_if(is.factor), darknet_scaled)

# Select important feature columns based on actual column names
selected_columns <- c("Flow.Duration", "Total.Fwd.Packet", "Total.Bwd.packets", 
                      "Packet.Length.Mean", "Packet.Length.Std", "Idle.Mean", "Idle.Std")

# Create a new data frame with the selected feature columns
darknet_selected <- darknet %>% select(all_of(selected_columns))

# Calculate the correlation matrix
corr_matrix <- cor(darknet_selected, use = "complete.obs")

# Enhanced correlation matrix visualization
corrplot(corr_matrix, method = 'color', tl.col = 'black', tl.srt = 45, tl.cex = 0.8, number.cex = 0.8)

# Histogram
ggplot(darknet, aes(x = `Flow.Duration`)) +
  geom_histogram(binwidth = 1, fill = 'blue', color = 'black') +
  theme_minimal() +
  labs(title = 'Distribution of Flow Duration', x = 'Flow Duration', y = 'Frequency')

# Ensure the Label column is treated as a factor
darknet$Label <- as.factor(darknet$Label)

# Use aes(group = Label) to explicitly group
ggplot(darknet, aes(x = Label, y = `Flow.Duration`, group = Label)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = 'Boxplot of Flow Duration by Label', x = 'Label', y = 'Flow Duration')

# Scatter plot
ggplot(darknet, aes(x = `Flow.Duration`, y = `Total.Fwd.Packet`)) +
  geom_point() +
  theme_minimal() +
  labs(title = 'Scatter Plot of Flow Duration vs Total Fwd Packet', x = 'Flow Duration', y = 'Total Fwd Packet')

# Bar chart
ggplot(darknet, aes(x = Label)) +
  geom_bar(fill = 'blue', color = 'black') +
  theme_minimal() +
  labs(title = 'Count of Categories in Label', x = 'Label', y = 'Count')

# Linear regression
linear_model <- lm(`Flow.Duration` ~ ., data = darknet)
summary(linear_model)

# Linear regression residual plot
linear_pred <- predict(linear_model, darknet)
ggplot(darknet, aes(x = linear_pred, y = darknet$`Flow.Duration` - linear_pred)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  theme_minimal() +
  labs(title = 'Residual Plot for Linear Regression', x = 'Predicted Values', y = 'Residuals')

# Random forest regression
rf_model <- randomForest(`Flow.Duration` ~ ., data = darknet)
print(rf_model)
varImpPlot(rf_model)

# Random forest regression residual plot
rf_pred <- predict(rf_model, darknet)
ggplot(darknet, aes(x = rf_pred, y = darknet$`Flow.Duration` - rf_pred)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  theme_minimal() +
  labs(title = 'Residual Plot for Random Forest Regression', x = 'Predicted Values', y = 'Residuals')

# Model evaluation
linear_rmse <- sqrt(mean((darknet$`Flow.Duration` - linear_pred)^2))
rf_rmse <- sqrt(mean((darknet$`Flow.Duration` - rf_pred)^2))

evaluation <- data.frame(Model = c('Linear Regression', 'Random Forest'),
                         RMSE = c(linear_rmse, rf_rmse))
print(evaluation)

# Comparison of random forest and linear regression residuals plot
linear_residuals <- darknet$`Flow.Duration` - linear_pred
rf_residuals <- darknet$`Flow.Duration` - rf_pred

comparison_data <- data.frame(
  Random_Forest_Residuals = rf_residuals,
  Linear_Regression_Residuals = linear_residuals
)

ggplot(comparison_data, aes(x = Random_Forest_Residuals, y = Linear_Regression_Residuals)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = 'red') +
  theme_minimal() +
  labs(title = 'Comparison of Random Forest and Linear Regression Residuals',
       x = 'Random Forest Residuals',
       y = 'Linear Regression Residuals')
```
