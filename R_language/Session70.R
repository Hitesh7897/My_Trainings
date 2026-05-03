#===============================================================================
# Chapter : Advanced Filtering and Grouping in dplyr
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
data("airports")
data("weather")
data("planes")


################################################################################
# DATA PREVIEW
################################################################################

flights            # prints dataset
View(flights)      # opens viewer

flights <- flights # ❌ invalid / redundant reassignment


################################################################################
# FILTER LOGIC (INCLUSION vs EXCLUSION)
################################################################################

# Remove flights delayed more than 1 hour

flights |> 
  filter_out(arr_delay > 60) |> 
  select(carrier, arr_delay)

# Equivalent approaches

flights |> 
  filter(!(arr_delay > 60)) |> 
  select(carrier, arr_delay)

flights |> 
  filter(arr_delay < 60) |> 
  select(carrier, arr_delay)


################################################################################
# filter_all(), filter_if(), filter_at() (LEGACY)
################################################################################

# Keep rows where all selected numeric values > threshold

# Traditional method (all_vars → now replaced by if_all)

flights |> 
  select(dep_delay, arr_delay, distance) |> 
  filter_all(all_vars(. > 600))

flights |> 
  select(dep_delay, arr_delay, distance) |> 
  filter_all(all_vars(. > 5000))


# Check ranges

max(flights$dep_delay, na.rm = TRUE)
max(flights$arr_delay, na.rm = TRUE)
max(flights$distance, na.rm = TRUE)


################################################################################
# MODERN APPROACH → if_all() and if_any()
################################################################################

# All columns satisfy condition

flights |>   
  filter(if_all(c(dep_delay, arr_delay, distance), ~ . > 4000))

# Any column satisfies condition

flights |>   
  filter(if_any(c(dep_delay, arr_delay, distance), ~ . > 4000))


################################################################################
# filter_if() → BASED ON COLUMN TYPE
################################################################################

# Apply condition only to numeric columns

flights |> 
  select(dep_delay, arr_delay, distance, carrier) |> 
  filter_if(is.numeric, all_vars(. > 600))

# Modern equivalent

flights |> 
  select(dep_delay, arr_delay, distance, carrier) |> 
  filter(if_all(where(is.numeric), ~ . > 600))


################################################################################
# filter_at() → SELECT SPECIFIC COLUMNS
################################################################################

# Apply condition to specific columns

flights |>   
  filter_at(vars(dep_delay, arr_delay, distance), all_vars(. > 600))

# Modern equivalent

flights |>   
  filter(if_all(c(dep_delay, arr_delay, distance), ~ . > 4000))


################################################################################
# SUMMARY OF FILTER FUNCTIONS
################################################################################

# filter_all() → apply condition to all columns
# filter_if()  → apply based on column type
# filter_at()  → apply to selected columns

# Modern replacements:
# if_all() → replaces all_vars()
# if_any() → replaces any_vars()


################################################################################
# GROUPING DATA IN dplyr
################################################################################

# Group by one column

flights |> 
  group_by(month)

# Note: group_by() does not change data, only metadata


################################################################################
# SUMMARISE
################################################################################

# Average delay per month

flights |> 
  group_by(month) |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE))

# Group by multiple columns

flights |> 
  group_by(month, carrier) |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE))

# Distinct combinations

flights |> 
  select(month, carrier) |> 
  distinct()


################################################################################
# GROUP METADATA FUNCTIONS
################################################################################

group_vars(flights |> group_by(month, carrier))  # grouping variables
group_keys(flights |> group_by(month, carrier))  # unique key combinations


################################################################################
# .groups PARAMETER IN summarise()
################################################################################

base_summary <- flights |> 
  group_by(origin, carrier, month)

# Drop all grouping
base_summary |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), .groups = "drop")

# Drop last level (month)
base_summary |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), .groups = "drop_last")

# Keep grouping structure
base_summary |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), .groups = "keep")

# Rowwise grouping
base_summary |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), .groups = "rowwise")


################################################################################
# ROWWISE OPERATIONS
################################################################################

# Custom function

get_rating <- function(x) {
  if (x < 0) return("Early")
  if (x < 15) return("OnTime")
  return("Delayed")
}

get_rating(16)
get_rating(-1)
get_rating(4)

# Apply rowwise logic

flights |> 
  group_by(origin, carrier) |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), .groups = "rowwise") |> 
  mutate(rating = get_rating(avg_delay))


################################################################################
# ROWWISE vs GROUPED BEHAVIOR EXAMPLE
################################################################################

df <- tibble(
  Player = c("A", "A", "B", "B"),
  Score  = c(10, 20, 5, 15)
)

# Function that expects scalar input

check_level <- function(x) {
  if (x > 15) return("Pro")
  return("Starter")
}

# Without rowwise (may behave unexpectedly)

df %>%
  group_by(Player) %>%
  summarise(Total = sum(Score), .groups = "keep") %>%
  mutate(Level = check_level(Total))

# With rowwise (correct scalar evaluation)

df %>%
  group_by(Player) %>%
  summarise(Total = sum(Score), .groups = "rowwise") %>%
  mutate(Level = check_level(Total))


################################################################################
# KEY TAKEAWAYS
################################################################################

# filter_out() → removes rows matching condition
# if_all() / if_any() → modern filtering approach
# filter_*() → legacy methods (avoid in new code)
# group_by() → adds metadata, not transformation
# summarise() → aggregation
# .groups → controls grouping behavior
# rowwise → enables scalar row-level operations


#===============================================================================
# END OF FILE
#===============================================================================