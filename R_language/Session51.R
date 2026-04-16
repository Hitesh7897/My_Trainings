#===============================================================================
# Chapter : Range Filtering, Aggregations and Dynamic Columns in dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# DATASET OVERVIEW
################################################################################

glimpse(flights)

################################################################################
# RANGE FILTERING (BETWEEN)
################################################################################

# Filter flights where arr_delay is between 30 and 60

# Traditional approach
flights |> 
  filter(arr_delay >= 30 & arr_delay <= 60) |> 
  select(carrier, arr_delay)

# Using between() → Cleaner and readable
flights |> 
  filter(between(arr_delay, 30, 60)) |> 
  select(carrier, arr_delay)

################################################################################
# RANGE FILTERING USING %in%
################################################################################

# Flights from second quarter (April to June → months 4 to 6)

# Using between()
flights |> 
  filter(between(month, 4, 6)) |> 
  select(carrier, month)

# Using %in% (works well for discrete values)
flights |> 
  filter(month %in% 4:6) |> 
  select(carrier, month)

################################################################################
# MIN AND MAX (AGGREGATION)
################################################################################

# Overall min and max of arr_delay
flights |> 
  summarise(
    min_delay = min(arr_delay, na.rm = TRUE),
    max_delay = max(arr_delay, na.rm = TRUE)
  )

################################################################################
# GROUP-WISE MIN AND MAX
################################################################################

# Min and max arr_delay by carrier
flights |> 
  group_by(carrier) |> 
  summarise(
    min_delay = min(arr_delay, na.rm = TRUE),
    max_delay = max(arr_delay, na.rm = TRUE)
  )

################################################################################
# BASE R EQUIVALENTS
################################################################################

# Range (min + max together)
range(flights$arr_delay, na.rm = TRUE)

# Summary statistics
summary(flights$arr_delay)

################################################################################
# FILTER BY PERCENTILE RANGE
################################################################################

# Filter flights within 25th to 75th percentile of arr_delay

flights |> 
  select(carrier, arr_delay) |> 
  filter(
    between(
      arr_delay,
      quantile(arr_delay, 0.25, na.rm = TRUE),
      quantile(arr_delay, 0.75, na.rm = TRUE)
    )
  )

################################################################################
# DYNAMIC COLUMN SELECTION (.data PRONOUN)
################################################################################

# Use column name stored in a variable

col_name <- "arr_delay"

flights |> 
  filter(.data[[col_name]] > 500)

# Access column by position (not recommended for production)
flights[[3]]

################################################################################
# FILTER USING AGGREGATIONS (GROUP-WISE FILTER)
################################################################################

# Flights belonging to carriers with avg dep_delay > 20 mins

flights |> 
  group_by(carrier) |> 
  filter(mean(dep_delay, na.rm = TRUE) > 20) |> 
  select(carrier, dep_delay) |> 
  arrange(carrier, dep_delay)

################################################################################
# GROUP SIZE FILTERING (n())
################################################################################

# Destinations with more than 10,000 flights per year

# Using mutate()
flights |> 
  group_by(dest) |> 
  mutate(n_dest = n()) |> 
  select(dest, n_dest) |> 
  filter(n_dest > 10000)

# Cleaner approach using filter()
flights |> 
  group_by(dest) |> 
  filter(n() > 10000)

################################################################################
# OTHER USEFUL NOTES
################################################################################

# between() → Inclusive range filter
# %in%      → Matching against a set of values
# n()       → Group size
# quantile()→ Percentile-based filtering
# .data[[ ]]→ Dynamic column reference (safe programming)

#===============================================================================
# END OF FILE
#===============================================================================