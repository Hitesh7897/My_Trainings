#===============================================================================
# Chapter : Row-wise Operations, across() and Formula (~) in dplyr
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

# Structure view
flights |> glimpse()

################################################################################
# INCORRECT VS CORRECT SUM APPROACH
################################################################################

# Incorrect (column-wise sum, not row-wise)
flights |> 
  glimpse() |> 
  mutate(total_time = sum(dep_time, arr_time)) |> 
  select(carrier, dep_time, arr_time, total_time) |> 
  head()

# Correct (row-wise sum using rowSums)
flights |>   
  mutate(total_time = rowSums(across(ends_with("delay")), na.rm = TRUE)) |> 
  select(ends_with("delay"), total_time) |> 
  head()

################################################################################
# PRACTICE DATASET (SALES)
################################################################################

sales <- tibble(
  item = c("apple", "banna", "cherry"),
  jan  = c(50, 0, 0),
  feb  = c(60, 80, 0),
  mar  = c(20, NA, 0),
  apr  = c(20, NA, 0)
)

sales

################################################################################
# DIFFERENT SUM METHODS
################################################################################

sales |> 
  mutate(
    tot  = sum(jan, feb, mar),                           # Wrong (column sum)
    tot1 = jan + feb + mar,                              # Row-wise (manual)
    tot2 = rowSums(across(c(jan, feb, mar)), na.rm = TRUE) # Correct
  )

sales |> 
  mutate(
    tot  = sum(jan, feb, mar),
    tot1 = jan + feb + mar,
    tot2 = rowSums(across(feb:mar), na.rm = TRUE)
  )

################################################################################
# COLUMN SELECTION HELPERS
################################################################################

flights |> 
  select(sched_dep_time, everything())

################################################################################
# ROW-WISE FILTERING WITH across()
################################################################################

flights |>   
  mutate(total_time = rowSums(across(starts_with("dep")), na.rm = TRUE)) |> 
  select(starts_with("dep"), total_time) |> 
  filter(rowSums(across(starts_with("dep")), na.rm = TRUE) < 400)

################################################################################
# FORMULA OPERATOR (~) WITH across()
################################################################################

# Convert all character columns to lowercase
flights |> 
  mutate(across(where(is.character), ~tolower(.x))) |> 
  select(where(is.character))

# Notes:
# ~     → formula syntax
# .x    → current column values

################################################################################
# CONDITIONAL ROW FILTERING USING across()
################################################################################

# Total delay > 80 minutes
flights |> 
  select(carrier, dep_delay, arr_delay) |> 
  mutate(delay_tot = rowSums(across(c(dep_delay, arr_delay)), 
                             na.rm = TRUE)) |> 
  filter(delay_tot > 80)

################################################################################
# USING ~ INSIDE across() FOR CONDITIONS
################################################################################

# Condition applied inside across()
flights |> 
  select(carrier, dep_delay, arr_delay) |> 
  filter(rowSums(across(c(dep_delay, arr_delay), ~ .x > 1300), 
                 na.rm = TRUE) >= 1)

################################################################################
# PRACTICE DATASET (PRICING)
################################################################################

sales <- tibble(
  item   = c("apple", "banna", "cherry"),
  price  = c(20, 150, 15),
  price1 = c(20, 11, 15)
)

sales

################################################################################
# ADVANCED across() OPERATIONS
################################################################################

sales |> 
  mutate(
    is_expensive = across(c(price, price1), ~ .x > 100),
    total        = rowSums(across(c(price, price1))),
    total1       = rowSums(across(c(price, price1), ~ .x > 162)),
    total2       = rowSums(across(c(price, price1), ~ .x > 150)),
    total3       = rowSums(across(c(price, price1), ~ .x >= 20)),
    total4       = rowSums(across(c(price, price1), ~ .x * 20)),
    total5       = rowSums(across(c(price, price1), ~ .x > 149))
  ) |> 
  filter(rowSums(across(c(price, price1), ~ .x * 149)) >= 1)

################################################################################
# LOGICAL TO INTEGER
################################################################################

a <- TRUE
as.integer(a)

################################################################################
# MULTIPLE CONDITIONAL FILTERS
################################################################################

# Both delays greater than threshold
flights |> 
  select(carrier, dep_delay, arr_delay) |> 
  filter(rowSums(across(c(dep_delay, arr_delay), ~ .x > 890), 
                 na.rm = TRUE) > 1)

flights |> 
  select(carrier, dep_delay, arr_delay) |> 
  filter(rowSums(across(c(dep_delay, arr_delay), ~ .x > 1100), 
                 na.rm = TRUE) > 1)

# At least one delay satisfies condition
flights |> 
  select(carrier, dep_delay, arr_delay) |> 
  filter(rowSums(across(c(dep_delay, arr_delay), ~ .x > 1300), 
                 na.rm = TRUE) >= 1)

################################################################################
# SUMMARY
################################################################################

# across()        → Apply function across multiple columns
# rowSums()       → Row-wise aggregation
# ~ (formula)     → Anonymous function in dplyr
# .x              → Current column inside across()
# where()         → Select columns by type
# starts_with()   → Select columns by prefix
# ends_with()     → Select columns by suffix

#===============================================================================
# END OF FILE
#===============================================================================