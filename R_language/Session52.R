#===============================================================================
# Chapter : Group-wise Filtering, Distinct Rows and Counts in dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# LOAD DATASETS
################################################################################

# Built-in datasets from nycflights13
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
# FILTER USING AGGREGATIONS (GROUP-WISE)
################################################################################

# Find the first flight of the day for each carrier

flights |> 
  group_by(carrier, year, month, day) |> 
  filter(dep_time == min(dep_time, na.rm = TRUE)) |> 
  select(carrier, year, month, day, dep_time)

################################################################################
# FILTER BASED ON GROUP TOTAL (SUM)
################################################################################

# Filter dates where total distance flown > 1,000,000

# Method 1: Using filter directly
flights |> 
  group_by(year, month, day) |> 
  filter(sum(distance) > 1000000) |> 
  select(year, month, day, distance)

# Method 2: Using mutate
flights |> 
  group_by(year, month, day) |> 
  mutate(total_distance = sum(distance)) |> 
  filter(total_distance > 1000000) |> 
  select(year, month, day, distance, total_distance)

# Method 3: Using summarise (best for reporting)
flights |> 
  group_by(year, month, day) |> 
  summarise(total_distance = sum(distance), .groups = "drop") |> 
  filter(total_distance > 1000000)

################################################################################
# MISSING VALUE ANALYSIS (CANCELLATIONS)
################################################################################

# Airports where flights are cancelled (dep_time is NA)
# Calculate percentage of missing dep_time

flights |> 
  group_by(origin) |> 
  summarise(p_missing = mean(is.na(dep_time)))

################################################################################
# DISTINCT ROWS
################################################################################

# Unique carriers
flights |> 
  distinct(carrier)

# Unique carriers (drop other columns)
flights |> 
  distinct(carrier, .keep_all = FALSE)

# Keep full row for first occurrence of each carrier
flights |> 
  distinct(carrier, .keep_all = TRUE) |> 
  glimpse()

# Unique origin-destination pairs
flights |> 
  distinct(origin, dest)

################################################################################
# DISTINCT COUNTS
################################################################################

# Count unique tail numbers and carriers
flights |> 
  summarise(
    n_tailnum = n_distinct(tailnum),
    n_carrier = n_distinct(carrier)
  )

################################################################################
# GROUP SIZE (COUNT ROWS)
################################################################################

# Count number of flights per flight number

flights |> 
  group_by(flight) |> 
  mutate(n_flight = n()) |> 
  select(flight, n_flight)

################################################################################
# SELECT COLUMNS
################################################################################

# Select specific columns
select(flights, dep_delay, arr_delay)

################################################################################
# SAMPLE DATA (TIBBLE)
################################################################################

# Create a small tibble for practice

f <- tibble(
  dep_delay = c(11, 20, 40, 50, 60),
  arr_delay = c(40, 50, 30, 20, 20)
)

################################################################################
# OTHER USEFUL NOTES
################################################################################

# distinct()   → Get unique rows
# n_distinct() → Count unique values
# n()          → Count rows per group
# mean(is.na())→ Percentage of missing values

#===============================================================================
# END OF FILE
#===============================================================================