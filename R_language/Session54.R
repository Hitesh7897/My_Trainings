#===============================================================================
# Chapter : Ranking, Percentiles and Conditional Categorization in dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# LOAD DATASETS
################################################################################

data("flights")
data("airlines")
data("airports")
data("weather")
data("planes")

################################################################################
# DATASET PREVIEW
################################################################################

flights
View(flights)

################################################################################
# TOP N PER GROUP (DENSE RANK)
################################################################################

# Find top 2 most delayed flights per day

flights |> 
  group_by(year, month, day) |> 
  filter(dense_rank(desc(arr_delay)) <= 2) |> 
  select(flight, day, arr_delay)

################################################################################
# PERCENTILE-BASED FILTERING (PERCENT_RANK)
################################################################################

# Identify "nightmare flights" → worst 1% of delays

# percent_rank() gives relative ranking between 0 and 1
# >= 0.99 → top 1% worst delays

flights |> 
  filter(percent_rank(arr_delay) >= 0.99) |> 
  select(flight, arr_delay)

################################################################################
# UNDERSTANDING PERCENTILES
################################################################################

# Absolute vs Relative filtering

# Absolute count (fixed rows)
1000 * 0.1   # 10% of 1000
1000 * 0.01  # 1% of 1000
1000000 * 0.1

# Relative ranking ignores total number of rows
# percent_rank() scales values between 0 and 1

################################################################################
# CUMULATIVE DISTRIBUTION (CUME_DIST)
################################################################################

# Example dataset
df <- data.frame(score = c(10, 20, 30, 40))

# Compute cumulative distribution
df |> 
  mutate(cume_dist_value = cume_dist(score))

################################################################################
# CONDITIONAL CATEGORIZATION (CASE_WHEN)
################################################################################

# Categorize flight delay severity

flights |> 
  select(carrier, flight, arr_delay) |> 
  mutate(
    severity = case_when(
      arr_delay < 0  ~ "Early",
      arr_delay == 0 ~ "On Time",
      arr_delay < 30 ~ "Little Delay",
      arr_delay <= 60 ~ "Late",
      arr_delay > 60 ~ "Very Late",
      TRUE ~ "Cancelled/Unknown"
    )
  )

################################################################################
# DISTINCT VALUES EXTRACTION
################################################################################

# List all unique destinations

flights |> 
  distinct(dest) |> 
  pull()

################################################################################
# OTHER USEFUL NOTES
################################################################################

# dense_rank()   → Ranking without gaps
# percent_rank() → Relative rank (0 to 1)
# cume_dist()    → Cumulative distribution
# case_when()    → Multi-condition if-else
# pull()         → Extract column as vector

#===============================================================================
# END OF FILE
#===============================================================================