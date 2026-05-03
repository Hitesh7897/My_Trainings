#===============================================================================
# Chapter : Row-wise Operations, .by Optimization, and Advanced mutate Patterns
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)
library(lubridate)


################################################################################
# LOAD DATASETS
################################################################################

data("flights")


################################################################################
# DATA PREVIEW
################################################################################

flights            # prints dataset
View(flights)      # opens viewer


################################################################################
# DATE-TIME FEATURE ENGINEERING (lubridate)
################################################################################

flights |> 
  select(year, month, day, time_hour) |> 
  mutate(
    dep_hour    = hour(time_hour),
    flight_date = make_datetime(year, month, day, dep_hour),
    .keep = "none"
  ) |> 
  tail()


################################################################################
# ROW-WISE OPERATIONS
################################################################################

df <- tibble(
  student = c("Alex", "Blair"),
  q1 = c(1, 2),
  q2 = c(2, 3),
  q3 = c(4, 5)
)

df

# Row-wise sum

df |> 
  rowwise() |> 
  mutate(total_marks = sum(c(q1, q2, q3)))


################################################################################
# GROUPED ARRANGE
################################################################################

# Sort within groups

df %>%
  group_by(group) %>%
  arrange(value, .by_group = TRUE)


################################################################################
# GROUP-WISE mutate()
################################################################################

flights |> 
  group_by(carrier) |> 
  mutate(avg_delay = mean(arr_delay, na.rm = TRUE), .keep = "used")


################################################################################
# .by PARAMETER (MODERN APPROACH)
################################################################################

# No need for group_by() + ungroup()

flights |> 
  mutate(avg_delay = mean(arr_delay, na.rm = TRUE), .by = carrier, .keep = "used")


################################################################################
# ROW-WISE vs COLUMN-WISE OPERATIONS
################################################################################

# Using rowMeans() + pick()

flights |> 
  mutate(
    avg_delay = rowMeans(pick(dep_delay, arr_delay), na.rm = TRUE),
    .keep = "used"
  ) |>  
  mutate(
    avg_depDelay = mean(c(dep_delay, arr_delay, avg_delay), na.rm = TRUE)
  )

# Note:
# mutate() → column-wise by default
# rowwise() or rowMeans() → required for row-level operations


################################################################################
# TOP-N PER GROUP
################################################################################

# Method 1 (recommended)

flights |> 
  slice_max(arr_delay, n = 3, by = carrier)

# Method 2

flights |> 
  group_by(carrier) |> 
  arrange(desc(arr_delay)) |> 
  slice_head(n = 3)

# Method 3

flights |> 
  arrange(carrier, desc(arr_delay)) |> 
  mutate(
    row_id = row_number(),
    .by = carrier
  ) |> 
  filter(row_id <= 3)


################################################################################
# reframe() → FLEXIBLE GROUP OUTPUT
################################################################################

# Can return multiple rows per group

flights |> 
  reframe(
    top_delay = head(sort(arr_delay, decreasing = TRUE), 3),
    .by = carrier
  )


################################################################################
# REMOVING COLUMNS USING mutate()
################################################################################

flights |> 
  mutate(
    gain = arr_delay - dep_delay,
    .keep = "used",
    gain = NULL   # removes column
  )


################################################################################
# transmute() → KEEP ONLY NEW COLUMNS
################################################################################

flights |> 
  transmute(
    gain = arr_delay - dep_delay
  )


################################################################################
# CUSTOM FUNCTION + mutate()
################################################################################

# Categorize delays

delay_category <- function(delay) {
  case_when(
    is.na(delay) ~ "unknown",
    delay <= 0   ~ "on_time",
    delay <= 30  ~ "minor_delay",
    TRUE         ~ "major_delay"
  )
}

flights |> 
  mutate(
    dep_status = delay_category(dep_delay),
    .keep = "used"
  )


################################################################################
# CUSTOM FUNCTION WITH MULTIPLE INPUTS
################################################################################

calc_speed <- function(dist, air_time) {
  (dist / air_time) * 60
}

flights |> 
  mutate(
    speed = calc_speed(distance, air_time),
    .keep = "used"
  )


################################################################################
# KEY TAKEAWAYS
################################################################################

# rowwise() → row-level operations
# .by → efficient alternative to group_by()
# pick() + rowMeans() → row-wise calculations without rowwise()
# slice_max() → top-N per group
# reframe() → flexible multi-row outputs per group
# mutate(... = NULL) → remove columns
# transmute() → keep only derived columns
# custom functions → reusable logic inside mutate()


#===============================================================================
# END OF FILE
#===============================================================================