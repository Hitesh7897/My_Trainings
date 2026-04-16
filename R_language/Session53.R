#===============================================================================
# Chapter : Proportion Filtering and Window Functions in dplyr
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
# FILTER USING PROPORTIONS (MISSING VALUES)
################################################################################

# Airports where more than 2% of flights are cancelled (dep_time is NA)

flights |> 
  group_by(origin) |> 
  filter(round(mean(is.na(dep_time)), 2) > 0.02) |> 
  select(origin, dep_time)

# Summary view (proportion of missing dep_time per origin)

flights |> 
  group_by(origin) |> 
  summarise(p_missing = mean(is.na(dep_time)))

# Missing value percentage across all columns

flights |> 
  summarise(across(everything(), ~ mean(is.na(.x))))

################################################################################
# WINDOW FUNCTIONS (RANKING)
################################################################################

# Sample vector
x <- c(10, 20, 20, 40, 15, NA, NA)

row_number(x)     # Unique ranking (no ties)
min_rank(x)       # Same rank for ties (gaps)
dense_rank(x)     # Same rank for ties (no gaps)
percent_rank(x)   # Scaled rank between 0 and 1

# percent_rank formula:
# (rank - 1) / (n - 1)

################################################################################
# FIRST ROW PER GROUP (ROW_NUMBER)
################################################################################

# First flight per carrier per day

flights |> 
  group_by(carrier, year, month, day) |> 
  arrange(dep_time) |> 
  mutate(f_carrier = row_number()) |> 
  select(carrier, year, month, day, dep_time, f_carrier) |> 
  filter(f_carrier == 1)

# Optimized approach

flights |> 
  group_by(carrier, year, month, day) |> 
  arrange(dep_time) |> 
  filter(row_number() == 1)

################################################################################
# TOP / BOTTOM VALUES PER GROUP
################################################################################

# Most delayed flight per carrier

# Method 1: slice_head()
flights |> 
  group_by(carrier) |> 
  select(carrier, arr_delay) |> 
  arrange(carrier, desc(arr_delay)) |> 
  slice_head(n = 1)

# Method 2: slice_max()
flights |> 
  group_by(carrier) |> 
  select(carrier, arr_delay) |> 
  slice_max(arr_delay, n = 1)

# Method 3: row_number()
flights |> 
  group_by(carrier) |> 
  filter(row_number(desc(arr_delay)) == 1) |> 
  select(carrier, arr_delay)

################################################################################
# TOP N WITH TIES (MIN_RANK)
################################################################################

# Flights tied for top 3 longest delays per origin

# Using mutate()
flights |> 
  group_by(origin) |> 
  mutate(m_rank = min_rank(desc(arr_delay))) |> 
  arrange(origin, desc(arr_delay), m_rank) |> 
  select(origin, arr_delay, m_rank) |> 
  filter(m_rank <= 3)

# Cleaner approach
flights |> 
  group_by(origin) |> 
  filter(min_rank(desc(arr_delay)) <= 3) |> 
  select(origin, carrier, flight, arr_delay) |> 
  arrange(origin, desc(arr_delay))

################################################################################
# STRING COMPARISON (LEXICOGRAPHICAL)
################################################################################

# Character comparisons are lexicographical (based on ASCII/Unicode)

"one" > "FIfty four"
"one" < "tWo"

################################################################################
# OTHER USEFUL NOTES
################################################################################

# row_number()  → Unique ranking (no ties)
# min_rank()    → Ranking with gaps
# dense_rank()  → Ranking without gaps
# percent_rank()→ Relative ranking (0 to 1)
# slice_max()   → Top N values
# slice_min()   → Bottom N values

#===============================================================================
# END OF FILE
#===============================================================================