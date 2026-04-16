#===============================================================================
# Chapter : Join Debugging, Relationships and Self Joins in dplyr
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

glimpse(flights)
glimpse(weather)

################################################################################
# KEY UNIQUENESS CHECK
################################################################################

# Check uniqueness of join keys

flights |> distinct(origin, time_hour)
weather |> distinct(origin, time_hour)

################################################################################
# BASIC JOINS
################################################################################

# Correct join using origin + time_hour

flights |> 
  inner_join(weather, by = c("origin", "time_hour"))

# Alternative join using multiple date fields

flights |> 
  inner_join(weather, by = c("origin", "year", "month", "day"))

################################################################################
# INCORRECT JOIN (DATA EXPLOSION RISK)
################################################################################

# Joining only by origin → creates many-to-many explosion

flights |> 
  inner_join(weather, by = "origin") |> 
  filter(time_hour.x <= time_hour.y)

################################################################################
# SELF JOIN
################################################################################

# Join flights with itself using tailnum

flights |> 
  inner_join(flights, by = "tailnum")

################################################################################
# DEBUGGING JOINS
################################################################################

# Find mismatched carriers

flights |> 
  anti_join(airlines, by = "carrier")

# Compare row counts after joins

nrow(flights)
nrow(flights |> left_join(airlines))
nrow(flights |> left_join(weather))
nrow(flights |> left_join(airports))

################################################################################
# JOIN WITH SUFFIX HANDLING
################################################################################

flights |> 
  left_join(weather, by = c("origin", "time_hour"), suffix = c("_f", "_w")) |> 
  rename_with(~ paste0(.x, "_w"), any_of(names(weather))) |> 
  rename_with(~ paste0(.x, "_f"), any_of(names(flights))) |> 
  glimpse()

################################################################################
# JOIN RELATIONSHIPS
################################################################################

# Types:
# one-to-one
# one-to-many
# many-to-one
# many-to-many (danger: data explosion)

################################################################################
# ONE-TO-ONE / ONE-TO-MANY VALIDATION
################################################################################

# Create daily weather summary

daily_weather <- weather |> 
  group_by(year, month, day, origin) |> 
  summarise(temp = mean(temp, na.rm = TRUE), .groups = "drop")

# Unique flight days

unique_days <- flights |> 
  distinct(year, month, day, origin)

# Validate relationship

unique_days |> 
  inner_join(
    daily_weather,
    by = c("year", "month", "day", "origin"),
    relationship = "one-to-many"
  )

################################################################################
# MANY-TO-ONE RELATIONSHIP
################################################################################

# flights (many) → airlines (one)

flights |> 
  left_join(airlines, by = "carrier", relationship = "many-to-one")

################################################################################
# ONE-TO-MANY RELATIONSHIP
################################################################################

# planes (one) → flights (many)

planes |> 
  inner_join(flights, by = "tailnum", relationship = "one-to-many")

################################################################################
# MANY-TO-MANY (AVOID)
################################################################################

# Causes duplication explosion

flights |> 
  inner_join(weather, by = "origin", relationship = "many-to-many")

################################################################################
# SELF JOIN (HIERARCHY EXAMPLE)
################################################################################

# Employee-manager relationship

staff <- tibble(
  emp_id = c(1, 2, 3, 4),
  name = c("A", "B", "C", "D"),
  manager_id = c(NA, 1, 1, 2)
)

# Join to get employee + manager names

staff |> 
  inner_join(
    staff,
    by = c("manager_id" = "emp_id"),
    suffix = c("_emp", "_mgr")
  )

################################################################################
# OTHER USEFUL NOTES
################################################################################

# anti_join()   → Find mismatches
# relationship  → Validate join type
# suffix        → Handle duplicate column names
# self join     → Join table to itself
# data explosion→ Happens in many-to-many joins

#===============================================================================
# END OF FILE
#===============================================================================