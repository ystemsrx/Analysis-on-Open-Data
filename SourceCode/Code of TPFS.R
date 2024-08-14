# Load necessary libraries
library(ggplot2)

# Load the dataset
file_path <- "Transportation_Public_Financial_Statistics__TPFS_.csv"
df <- read.csv(file_path)

# Convert year and value columns to appropriate types
df$year <- as.integer(df$year)
df$value <- as.numeric(df$value)

# Group by year and sum the values
annual_data <- aggregate(value ~ year, data = df, sum)

# Create the plot
ggplot(annual_data, aes(x = year, y = value)) +
  geom_line(color = "orange", size = 1) +
  geom_point(color = "orange", size = 3) +
  labs(title = "Annual Transportation Public Financial Statistics",
       x = "Year",
       y = "Value (in USD)") +
  theme_minimal()
