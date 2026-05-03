#===============================================================================
# Chapter : Join Parameters and Filter Semantics in dplyr
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
# DATA PREVIEW
################################################################################

flights            # prints dataset
View(flights)      # opens viewer

flights <- flights # ❌ invalid / redundant reassignment


################################################################################
# JOIN FUNCTION STRUCTURE
################################################################################

full_join(
  x,
  y,
  by = NULL,
  copy = FALSE,
  suffix = c(".x", ".y"), 
  ...,                  # variable arguments
  keep = NULL,
  na_matches = c("na", "never"),
  multiple = "all",
  relationship = NULL
)


################################################################################
# na_matches PARAMETER
################################################################################

# Controls how NA values behave in joins

student <- tibble(
  id = c(1, 2, NA), 
  name = c("Alice", "Bob", "Unknown")
)

hobbies <- tibble(
  id = c(1, NA), 
  hobby = c("Coding", "Sting")
)

# Default (NA matches NA)
student |> left_join(hobbies, by = "id")

# Explicit NA matching
student |> left_join(hobbies, by = "id", na_matches = "na")

# NA never matches
student |> left_join(hobbies, by = "id", na_matches = "never")


################################################################################
# multiple PARAMETER
################################################################################

# Controls behavior when multiple matches exist

?join

f <- tibble(
  tailnum = "N123",
  dest = "BLR"
)

f1 <- tibble(
  tailnum = "N123",
  repair = c("Engine", "Tires", "Oil")
)

f
f1

# Default (returns all matches)
f |> left_join(f1, by = "tailnum")

f |> left_join(f1, by = "tailnum", multiple = "all")      # default
f |> left_join(f1, by = "tailnum", multiple = "any")      # returns any one match
f |> left_join(f1, by = "tailnum", multiple = "first")    # first occurrence
f |> left_join(f1, by = "tailnum", multiple = "last")     # last occurrence
f |> left_join(f1, by = "tailnum", multiple = "warning")  # like "all" + warning


################################################################################
# FILTER SEMANTICS
################################################################################

?filter

filter(.data, ..., .by = NULL, .preserve = FALSE)

# .by → introduced in dplyr 1.1+ (grouping within filter)

# Example: minimum delay per month
flights |> 
  filter(arr_delay <= min(arr_delay, na.rm = TRUE), .by = month)

# Equivalent using group_by
flights |> 
  group_by(month) |> 
  filter(arr_delay <= min(arr_delay, na.rm = TRUE)) |> 
  ungroup()


################################################################################
# .preserve PARAMETER
################################################################################

# Controls whether grouping structure is retained after filtering

df <- tibble(
  group = c("A", "A", "B", "B"),
  value = c(10, 20, 5, 8)
)

df

# Default (.preserve = FALSE)
df |> 
  group_by(group) |> 
  filter(value > 15, .preserve = FALSE) |> 
  summarise(n = n())

# Preserve groups even if empty
df |> 
  group_by(group) |> 
  filter(value > 15, .preserve = TRUE) |> 
  summarise(n = n())


################################################################################
# FILTER vs FILTER_OUT
################################################################################

?filter_all()

# filter()     → keeps rows where condition is TRUE
# filter_out() → removes rows where condition is TRUE

filter_out(.data, ..., .by = NULL, .preserve = FALSE)


################################################################################
# PRACTICAL EXAMPLES
################################################################################

# Flights delayed more than 1 hour
flights |> 
  filter(arr_delay > 60) |> 
  select(carrier, arr_delay)

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
# KEY TAKEAWAYS
################################################################################

# na_matches → controls NA join behavior
# multiple   → handles duplicate matches in joins
# .by        → lightweight grouping inside filter()
# .preserve  → retains grouping after filtering
# filter() vs filter_out() → inclusion vs exclusion logic


#===============================================================================
# END OF FILE
#===============================================================================