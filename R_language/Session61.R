#===============================================================================
# Chapter : Duplicate Detection, Predicate Filtering and Anti Joins in dplyr
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
# DISTINCT VALUES (REMOVE DUPLICATES)
################################################################################

# Unique carriers
flights |> 
  distinct(carrier)

# Unique combinations of carrier and destination
flights |> 
  distinct(carrier, dest)

# Keep only selected columns
flights |> 
  distinct(carrier, dest, .keep_all = FALSE) |> 
  select(carrier, dest, everything())

################################################################################
# DUPLICATE DETECTION USING GROUPING
################################################################################

# Identify duplicate rows based on key columns

flights |> 
  group_by(flight, year, month, day, carrier) |> 
  filter(n() > 1) |> 
  ungroup() |> 
  relocate(flight, year, month, day, carrier, everything())

################################################################################
# DUPLICATE FLAGGING (LOGICAL APPROACH)
################################################################################

flights |> 
  group_by(flight, year, month, day, carrier) |> 
  mutate(is_dup = n() > 1) |> 
  filter(is_dup) |> 
  select(-is_dup)

################################################################################
# DUPLICATE DETECTION USING add_count()
################################################################################

flights |> 
  add_count(flight, year, month, day, carrier) |> 
  filter(n > 1) |> 
  select(-n)

################################################################################
# BASE R DUPLICATES
################################################################################

flights |> 
  filter(duplicated(select(., flight, year, month, day, carrier)))

################################################################################
# USING janitor PACKAGE
################################################################################

# install.packages("janitor")
library(janitor)

flights |> 
  get_dupes(year, month, day, hour, carrier)

################################################################################
# PREDICATE-BASED FILTERING
################################################################################

# Select numeric columns
weather |> 
  select(where(is.numeric))

# Filter rows where ANY numeric column > 100
weather |> 
  filter(if_any(where(is.numeric), ~ .x > 100))

# Filter rows where ALL numeric columns > 20.6
weather |> 
  filter(if_all(where(is.numeric), ~ .x > 20.6))

################################################################################
# ANTI JOIN (FIND MISMATCHES)
################################################################################

# Flights with tailnum not present in planes dataset

flights |> 
  anti_join(planes, by = "tailnum") |> 
  select(flight, tailnum)

# Check specific tail numbers
planes |> 
  filter(tailnum %in% c("N542MQ", "N3DUAA"))

################################################################################
# COLUMN REORDERING (RELOCATE)
################################################################################

# Move selected columns to front

flights |> 
  relocate(carrier, flight, dep_time, arr_time, dep_delay, arr_delay)

# Relocate columns by data type (character columns first)

flights |> 
  relocate(where(is.character))

################################################################################
# OTHER USEFUL NOTES
################################################################################

# distinct()   → Remove duplicates
# n()          → Count rows per group
# add_count()  → Add frequency column
# duplicated() → Base R duplicate detection
# get_dupes()  → Easy duplicate inspection (janitor)
# if_any()     → Condition across columns (ANY)
# if_all()     → Condition across columns (ALL)
# anti_join()  → Find unmatched rows
# relocate()   → Reorder columns

#===============================================================================
# END OF FILE
#===============================================================================