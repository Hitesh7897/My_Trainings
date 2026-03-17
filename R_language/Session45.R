#===============================================================================
# Chapter : Advanced Slicing, Sampling and Conditional Operations
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# SLICE MIN & MAX
################################################################################

# Minimum distance flight
flights |> 
  slice_min(distance) |> 
  select(carrier, origin, dest, distance)

# Top 3 minimum distance flights
flights |> 
  slice_min(distance, n = 3) |> 
  select(carrier, origin, dest, distance)

# Maximum distance flight (distinct distances)
flights |> 
  slice_max(distance) |> 
  select(carrier, origin, dest, distance) |> 
  distinct(distance)

# Top 3 maximum distance flights
flights |> 
  slice_max(distance, n = 3) |> 
  select(carrier, origin, dest, distance) |> 
  distinct(distance)

################################################################################
# SAMPLING DATA (slice_sample)
################################################################################

# Sample 8 rows after selecting columns (optimized)
flights |> 
  select(year, month, day, carrier) |> 
  slice_sample(n = 8)

# Sample first, then select (less optimal for large data)
flights |> 
  slice_sample(n = 8) |> 
  select(year, month, day, carrier)

################################################################################
# CODE OPTIMIZATION CONCEPT
################################################################################

# Better approach (reduces computation)
# A → B → C → D → E → F
# Optimized: A → BC → DEF

# Why optimization matters:
# Large data (e.g., 1.5 lakh rows or more)
# High RAM / CPU consumption
# Reduce intermediate steps

################################################################################
# BIG DATA CONTEXT
################################################################################

# Example:
# 1 TB dataset → select(flights) may take 30–60 mins

# Solutions:
# Parallel computing tools:
# - Spark
# - R + Spark (sparklyr)

# File systems:
# - Windows → NTFS
# - Linux → ext (lxt)
# - Big Data → HDFS (Hadoop Distributed File System)

################################################################################
# SAMPLING WITH PROPORTIONS
################################################################################

# Sample 25% of data
flights |> 
  slice_sample(prop = 0.25) |> 
  select(year, month, day, carrier)

# Sample within each carrier group
flights |> 
  slice_sample(prop = 0.25, by = carrier) |> 
  select(year, month, day, carrier)

# Random sample per group
flights |> 
  slice_sample(by = carrier) |> 
  select(year, month, day, carrier)

################################################################################
# COMPLEX FILTER CONDITIONS
################################################################################

# Count missing values
colSums(is.na(flights))

# Flights delayed but not cancelled
flights |> 
  filter(!is.na(arr_delay) & arr_delay > 0) |> 
  select(carrier, arr_delay)

# Extreme delays in winter (Nov–Feb)
flights |> 
  filter(month %in% c(11, 12, 1, 2), arr_delay > 100)

# Maximum arrival delay
flights |> 
  slice_max(arr_delay) |> 
  select(arr_delay)

################################################################################
# ROW-WISE COMPUTATIONS (rowSums + across)
################################################################################

# Total operation time > 400
# operation_time = arr_time + dep_delay + arr_delay

flights |> 
  select(arr_time, dep_delay, arr_delay) |>
  filter(rowSums(across(c(arr_time, dep_delay, arr_delay)), 
                 na.rm = TRUE) > 400)

# Example usage
sum(8, 38, 3)

################################################################################
# CREATE TOTAL DELAY COLUMN
################################################################################

flights |> 
  mutate(total_delay = rowSums(across(c(dep_delay, arr_delay)), 
                               na.rm = TRUE)) |> 
  select(arr_time, dep_delay, arr_delay, total_delay)

# Alternative syntax using "."
flights |> 
  select(dep_delay, arr_delay) |> 
  mutate(total_delay = rowSums(., na.rm = TRUE))

################################################################################
# ACROSS FUNCTION WITH GROUPING
################################################################################

# Mean of selected columns by origin
flights |> 
  group_by(origin) |> 
  summarise(across(c(arr_time, dep_delay, arr_delay), 
                   mean, na.rm = TRUE))

# Mean of all numeric columns by origin
flights |> 
  group_by(origin) |> 
  summarise(across(where(is.numeric), 
                   mean, na.rm = TRUE))

################################################################################
# MATRIX OPERATIONS (BASE R)
################################################################################

a <- matrix(1:10, nrow = 3)

dim(a)
rowSums(a)

################################################################################
# SUMMARY
################################################################################

# slice_min()     → Smallest values
# slice_max()     → Largest values
# slice_sample()  → Random sampling
# filter()        → Conditional filtering
# across()        → Apply function across columns
# rowSums()       → Row-wise aggregation
# group_by()      → Group data
# summarise()     → Aggregate calculations

#===============================================================================
# END OF FILE
#===============================================================================