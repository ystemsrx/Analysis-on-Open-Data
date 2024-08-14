# Load necessary libraries
library(ggplot2)
library(dplyr)

# Read the dataset
df <- read.csv('Electric_Vehicle_Population_Data.csv')

# Top 10 Electric Vehicle Makes
top_makes <- df %>%
  count(Make) %>%
  top_n(10, n) %>%
  arrange(desc(n))

# Plot for Top 10 Electric Vehicle Makes
ggplot(top_makes, aes(x = reorder(Make, -n), y = n)) +
  geom_bar(stat = 'identity', fill = 'lightgreen') +
  labs(title = 'Top 10 Electric Vehicle Makes', x = 'Make', y = 'Count') +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Top 10 Electric Vehicle Models
top_models <- df %>%
  count(Model) %>%
  top_n(10, n) %>%
  arrange(desc(n))

# Plot for Top 10 Electric Vehicle Models
ggplot(top_models, aes(x = reorder(Model, -n), y = n)) +
  geom_bar(stat = 'identity', fill = 'lightcoral') +
  labs(title = 'Top 10 Electric Vehicle Models', x = 'Model', y = 'Count') +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
