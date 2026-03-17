#===============================================================================
# Chapter : Filtering, Logical Operators and Missing Values Handling
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# CONDITIONAL FILTER USING across()
################################################################################

# Flights where either dep_delay OR arr_delay > 80 minutes
flights |>  
  select(carrier, dep_delay, arr_delay) |> 
  filter(rowSums(across(c(dep_delay, arr_delay), ~ .x > 80), 
                 na.rm = TRUE) >= 1)

################################################################################
# COMPARISON OPERATORS
################################################################################

# == (equal to)
flights |> 
  filter(dest == "MIA")

# != (not equal to)
flights |> 
  filter(origin != "EWR") |> 
  distinct(origin)

# > (greater than)
flights |> 
  filter(dep_delay > 120)

# < (less than)
flights |> 
  filter(dep_delay < 120)

# <=, >= (less than or equal, greater than or equal)
# (examples similar to above)

################################################################################
# %in% OPERATOR (GROUP MATCHING)
################################################################################

flights |> 
  filter(carrier %in% c("UA", "AA", "DL")) |> 
  distinct(carrier)

################################################################################
# LOGICAL OPERATORS
################################################################################

# AND (&)
flights |> 
  filter(month == 1 & day == 1) |> 
  select(carrier, month, day)

# OR (|)
flights |> 
  filter(month == 1 | month == 11) |> 
  select(carrier, month, day)

# NOT (!)
# Flights NOT delayed more than 2 hours
flights |> 
  filter(!(arr_delay > 120)) |> 
  distinct(arr_delay)

################################################################################
# HANDLING MISSING VALUES (NA)
################################################################################

# Check NA values (vector level)
is.na(flights$arr_delay)

# Count NA values per column (Base R)
missing_col <- colSums(is.na(flights))
missing_col[missing_col > 0]

################################################################################
# NA ANALYSIS USING dplyr
################################################################################

flights |> 
  summarise(across(everything(), ~ sum(is.na(.x)))) |> 
  glimpse()

################################################################################
# DATA.TABLE APPROACH (FAST)
################################################################################

library(data.table)

flight_dt <- as.data.table(flights)

flight_dt[, lapply(.SD, function(x) sum(is.na(x)))]

################################################################################
# VISUALIZING MISSING DATA (naniar)
################################################################################

library(naniar)

gg_miss_var(flights)

################################################################################
# FILTERING NA VALUES
################################################################################

# Incorrect way (does not work)
flights |> filter(dep_time == NA)

# Correct way
flights |> filter(is.na(dep_time))

# Flights that actually departed
flights |> filter(!is.na(dep_time))

################################################################################
# CANCELLED FLIGHTS
################################################################################

# Flights cancelled (both dep_time & arr_time missing)
flights |> 
  filter(is.na(dep_time) & is.na(arr_time)) |> 
  select(carrier, dep_time, arr_time)

# Remove NA rows
flights |> 
  filter(!is.na(dep_time) & !is.na(arr_time)) |> 
  select(carrier, dep_time, arr_time)

# Alternative using drop_na()
flights |> 
  drop_na(dep_time, arr_time) |> 
  select(carrier, dep_time, arr_time)

################################################################################
# FILTER WITH CONDITIONS ON NA HANDLING
################################################################################

# Example logic
3 > 60
0 > 60

# Flights with arrival delay > 60 minutes
flights |> 
  drop_na(arr_delay) |> 
  filter(arr_delay > 60) |> 
  select(carrier, dep_time, arr_time, arr_delay)

################################################################################
# USING coalesce()
################################################################################

# Replace NA with 0 before filtering
flights |> 
  filter(coalesce(arr_delay, 0) > 60) |> 
  select(carrier, dep_time, arr_time, arr_delay)

################################################################################
# COALESCE WITH MULTIPLE COLUMNS
################################################################################

# If dep_delay is NA, use arr_delay
flights |> 
  filter(is.na(dep_delay) | !is.na(arr_delay)) |> 
  mutate(delay = coalesce(dep_delay, arr_delay)) |> 
  select(carrier, dep_delay, arr_delay, delay)

################################################################################
# PRACTICE EXAMPLES
################################################################################

demo_1 <- flights |> 
  mutate(n_a = coalesce(arr_delay, 1)) |> 
  select(carrier, dep_time, arr_time, arr_delay, n_a) |> 
  filter(is.na(arr_delay))

# Identify rows where NA replaced with 1
flights |> 
  filter(coalesce(arr_delay, 1) == 1) |> 
  select(carrier, dep_time, arr_time, arr_delay)

################################################################################
# SUMMARY
################################################################################

# ==, !=, >, <, >=, <= → Comparison operators
# %in%                 → Match multiple values
# &, |, !              → Logical operators
# is.na()              → Identify missing values
# drop_na()            → Remove missing rows
# across()             → Apply function across columns
# rowSums()            → Row-wise condition evaluation
# coalesce()           → Replace NA with fallback values
# naniar               → Visualize missing data
# data.table           → Fast NA computation

#===============================================================================
# END OF FILE
#===============================================================================