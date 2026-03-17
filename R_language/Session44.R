#===============================================================================
# Chapter : Filtering, Slicing and Ranking using dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# RANKING FUNCTIONS (BASIC EXAMPLE)
################################################################################

x <- c(10, 20, 30, 30, 40, 50)

tibble(
  value   = x,
  row_num = row_number(x),
  min_rk  = min_rank(x),
  den_rk  = dense_rank(x),
  per_rnk = percent_rank(x)
)

################################################################################
# FILTERING DATA
################################################################################

# Syntax
# filter(.data, ..., .by = NULL, .preserve = FALSE)
# filter_out(.data, ..., .by = NULL, .preserve = FALSE)

################################################################################
# SIMPLE FILTERS
################################################################################

# Flights in January
flights |> 
  filter(month == 1)

# Flights with arrival delay > 2 hours
flights |> 
  filter(arr_delay > 120) |> 
  select(carrier, arr_delay)

################################################################################
# MULTIPLE CONDITIONS
################################################################################

# Flights in January AND day = 10
flights |> 
  filter(month == 1 & day == 10) |> 
  select(carrier, month, day)

# Alternative syntax (comma acts as AND)
flights |> 
  filter(month == 1, day == 10) |> 
  select(carrier, month, day)

################################################################################
# OR CONDITIONS
################################################################################

# Flights where month = 1 OR 5 OR day = 10
flights |> 
  filter(month == 1 | month == 5 | day == 10) |> 
  select(carrier, month, day)

################################################################################
# USING %in% OPERATOR
################################################################################

flights |> 
  filter(month %in% c(1, 5) | day == 10) |> 
  select(carrier, month, day)

################################################################################
# INLINE COMPUTATION (DERIVED COLUMN)
################################################################################

# Flights with speed > 500 mph
# speed = distance / air_time * 60

flights |> 
  mutate(speed = (distance / air_time) * 60) |> 
  filter(speed > 500) |> 
  select(carrier, distance, air_time, speed) |> 
  glimpse()

################################################################################
# POSITION-BASED SUBSETTING (BASE R)
################################################################################

flights[c(3, 5), ]
flights[3:6, ]
flights[3, ]
flights[, 4]
flights[, "carrier"]
flights[, 4:6]
flights[, c(4, 10)]

################################################################################
# SLICE FUNCTIONS
################################################################################

# Select rows by position
flights |> slice(6)
flights |> slice(1:4)
flights |> slice(c(1, 3))
flights |> slice(1, 3)

################################################################################
# HEAD (slice_head)
################################################################################

flights |> slice_head(3)
flights |> slice_head(n = 3)

# Percentage-based selection
flights |> slice_head(prop = 0.20)

# Slice within groups
flights |> 
  slice_head(prop = 0.25, by = carrier) |> 
  select(carrier, arr_time)

################################################################################
# TAIL (slice_tail)
################################################################################

flights |> slice_tail(3)
flights |> slice_tail(n = 3)

################################################################################
# BASE R HEAD & TAIL (COMPARISON)
################################################################################

flights |> head()
flights |> head(4)
flights |> tail()

################################################################################
# SLICE MIN (LOWEST VALUES)
################################################################################

# Minimum distance flight
flights |> 
  slice_min(distance) |> 
  select(carrier, origin, dest, distance)

# Top 3 minimum distances
flights |> 
  slice_min(distance, n = 3) |> 
  select(carrier, origin, dest, distance)

################################################################################
# SUMMARY
################################################################################

# filter()        → Subset rows based on conditions
# %in%            → Match multiple values
# mutate()        → Create new variables
# slice()         → Select rows by position
# slice_head()    → First N rows
# slice_tail()    → Last N rows
# slice_min()     → Smallest values
# row_number()    → Unique ranking
# min_rank()      → Ranking with gaps
# dense_rank()    → Ranking without gaps
# percent_rank()  → Percentile ranking

#===============================================================================
# END OF FILE
#===============================================================================