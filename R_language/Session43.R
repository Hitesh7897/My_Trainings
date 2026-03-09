#===============================================================================
# Chapter : Ranking, Sorting and Aggregation using dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# DATA INSPECTION
################################################################################

# Count missing values
colSums(is.na(flights))

# Base R structure
str(flights)

# Tidyverse structure
glimpse(flights)

################################################################################
# RANKING AIRLINES BY AVERAGE ARRIVAL DELAY
################################################################################
# Calculate average arrival delay per carrier
# and sort in descending order

flights |>
  group_by(carrier) |>
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) |>
  arrange(desc(avg_delay))

################################################################################
# ADDING SAMPLE CONTEXT COLUMNS
################################################################################
# Include representative values using first()

flights |>
  group_by(carrier) |>
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    year      = first(year),
    month     = first(month),
    dep_time  = first(day),
    arr_time  = first(day)
  ) |>
  arrange(desc(avg_delay))

################################################################################
# SORTING CHARACTER COLUMNS
################################################################################

flights |>
  arrange(tailnum) |>
  select(carrier, tailnum)

################################################################################
# RANKING FUNCTIONS
################################################################################

x <- c(10, 20, 20, 40, 60)

tibble(
  value   = x,
  row_num = row_number(x),
  min_rk  = min_rank(x),
  den_rk  = dense_rank(x),
  per_rnk = percent_rank(x)
)

################################################################################
# RANK FLIGHTS BY ARRIVAL DELAY
################################################################################

flights |>
  mutate(delay_rank = min_rank(desc(arr_delay))) |>
  select(carrier, arr_delay, delay_rank) |>
  arrange(delay_rank) |>
  add_count(delay_rank) |>
  filter(n > 5)

################################################################################
# WORST AVERAGE DELAY BY MONTH
################################################################################
# Identify airline with worst average delay each month

flights |>
  group_by(month, carrier) |>
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) |>
  arrange(month, desc(avg_delay)) |>
  slice_max(avg_delay, n = 1)

################################################################################
# SUMMARY
################################################################################

# group_by()      → Group data
# summarise()     → Aggregate calculations
# arrange()       → Sort results
# first()         → Retrieve first value in group
# row_number()    → Unique rank
# min_rank()      → Rank with gaps
# dense_rank()    → Rank without gaps
# percent_rank()  → Percentile ranking
# slice_max()     → Top N rows

#===============================================================================
# ASSIGNMENT
#===============================================================================

# 1. Find the top 5 airlines with the lowest average arrival delay.
# 2. Rank airlines by average departure delay.
# 3. Identify the airline with the worst delay for each origin airport.
# 4. Rank flights by departure delay within each month.
# 5. Find the top 3 airlines with the best (lowest) average delay each month.

#===============================================================================
# END OF FILE
#===============================================================================