#===============================================================================
# Chapter : Row-wise Mean, Group-wise Calculations and Proportions
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# USING coalesce() FOR NA ANALYSIS
################################################################################

# Identify rows where arr_delay is NA (replaced with 1)
flights |> 
  filter(coalesce(arr_delay, 1) == 1) |>
  select(carrier, dep_time, arr_time, arr_delay)

################################################################################
# SIMPLE FILTER
################################################################################

# Flights with departure delay > 60 minutes
flights |> 
  filter(dep_delay > 60)

################################################################################
# COLUMN-WISE vs ROW-WISE MEAN
################################################################################

# Incorrect vs correct understanding of mean

flights |> 
  select(carrier, dep_delay, arr_delay) |>
  mutate(
    m_dep      = mean(dep_delay, na.rm = TRUE),                 # column-level mean
    m_arr      = mean(arr_delay, na.rm = TRUE),                 # column-level mean
    m_dep_arr  = mean(c(dep_delay, arr_delay), na.rm = TRUE),   # still column-level
    m_dep_arr1 = (dep_delay + arr_delay) / 2                    # row-wise mean (correct)
  ) |>
  filter(m_dep_arr1 > 50)

################################################################################
# ROW-WISE MEAN USING rowwise()
################################################################################

flights |> 
  select(carrier, dep_delay, arr_delay) |>
  rowwise() |>
  mutate(
    m_dep_arr = mean(c(dep_delay, arr_delay), na.rm = TRUE)
  ) |>
  filter(m_dep_arr > 50) |>
  ungroup()

################################################################################
# GROUP-WISE COUNT AND PROPORTION
################################################################################

flights |>
  group_by(month) |>
  mutate(
    n_month = n()                 # count per month
  ) |>
  ungroup() |>
  mutate(
    per_of_year = (n_month / n()) # proportion of total flights
  ) |>
  select(month, n_month, per_of_year) |>
  distinct(month, n_month, per_of_year) |>
  arrange(month, n_month, per_of_year)

################################################################################
# SUMMARY
################################################################################

# mean()           → Column-level aggregation
# rowwise()        → Enable row-wise operations
# mutate()         → Create new columns
# group_by()       → Group data
# n()              → Count rows in group
# ungroup()        → Remove grouping
# coalesce()       → Replace NA values
# distinct()       → Remove duplicate rows
# arrange()        → Sort data

#===============================================================================
# END OF FILE
#===============================================================================