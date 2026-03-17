#===============================================================================
# Chapter : if_any(), if_all(), if_else() and Logical Helpers in dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# if_any() AND if_all() (USED IN FILTER)
################################################################################

# if_any() → TRUE if ANY column satisfies condition
# Find flights where either dep_delay OR arr_delay > 60

# Traditional approach
flights |> 
  filter(dep_delay > 60 | arr_delay > 60) |> 
  select(dep_delay, arr_delay)

# Using if_any()
flights |> 
  filter(if_any(c(dep_delay, arr_delay), ~ .x > 60)) |> 
  select(dep_delay, arr_delay)

################################################################################
# if_all()
################################################################################

# TRUE only if ALL columns satisfy condition
flights |> 
  filter(if_all(c(dep_delay, arr_delay), ~ .x > 60)) |> 
  select(dep_delay, arr_delay)

# Using helper with column selection
flights %>% 
  filter(if_any(ends_with("delay"), ~ .x > 60))

################################################################################
# if_else() (CONDITIONAL COLUMN CREATION)
################################################################################

# Create flight status based on arr_delay
flights |> 
  mutate(
    arr_status = if_else(
      condition = arr_delay > 60,
      true      = "Very Late",
      false     = "Acceptable",
      missing   = "Cancelled/Unknown"
    )
  ) |> 
  select(carrier, arr_delay, arr_status)

################################################################################
# ifelse() vs if_else()
################################################################################

ifelse(c(TRUE, FALSE), "High", 0)
if_else(c(TRUE, FALSE), "High", 0)

################################################################################
# COLUMN SELECTION WITH across()
################################################################################

flights |>  
  select(ends_with("time"))

# Incorrect usage (will not work inside filter)
# flights |> filter(across(c(dep_delay, arr_delay), ~ .x > 60))

# Correct approach
flights |> 
  filter(if_any(c(dep_delay, arr_delay), ~ .x > 60))

################################################################################
# TRANSFORM MULTIPLE COLUMNS
################################################################################

# Convert all time columns to datetime
flights |> 
  mutate(across(ends_with("time"), as_datetime))

################################################################################
# LOGICAL REDUCTIONS (any() and all())
################################################################################

# any() → TRUE if at least one condition is TRUE
flights |> 
  filter(any(c(dep_delay, arr_delay) > 60)) |> 
  select(carrier, dep_delay, arr_delay)

# all() → TRUE only if all conditions are TRUE
flights |> 
  filter(all(c(dep_delay, arr_delay) > 60)) |> 
  select(carrier, dep_delay, arr_delay)

################################################################################
# VECTOR EXAMPLES
################################################################################

a <- c(50, 60, 70, 80, 90)
b <- c(91, 81, 91, 78, 65, 30)

a
b

any(c(a, b) > 40)
all(c(a, b) > 40)

################################################################################
# DPLYR VERBS & HELPERS SUMMARY
################################################################################

# filter() → Row filtering
#   Helpers:
#   - if_any()
#   - if_all()
#   - between()
#   - near()

# select() → Column selection
#   Helpers:
#   - starts_with()
#   - ends_with()
#   - contains()
#   - everything()
#   - all_of()
#   - any_of()

# mutate() / summarise()
#   Helpers:
#   - across()
#   - pick()
#   - c_across() (for rowwise)

################################################################################
# OTHER USEFUL FUNCTIONS
################################################################################

distinct()
n_distinct()

#===============================================================================
# END OF FILE
#===============================================================================