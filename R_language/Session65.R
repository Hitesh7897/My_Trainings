#===============================================================================
# Chapter : Handling Missing Data and Multi-Table Joins in dplyr
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
# MISSING VALUE CHECK
################################################################################

colSums(is.na(planes))
colSums(is.na(flights))

################################################################################
# FIND MISSING MATCHES AFTER JOIN
################################################################################

# Flights with missing plane information (no matching tailnum in planes)

flights |> 
  left_join(planes, by = "tailnum") |> 
  select(flight, tailnum, type, manufacturer) |> 
  filter(is.na(type))   # correct column to check

################################################################################
# RIGHT JOIN CHECK
################################################################################

flights |> 
  right_join(planes, by = "tailnum") |> 
  select(flight, tailnum, type, manufacturer) |> 
  filter(is.na(flight))  # planes with no matching flights

################################################################################
# INNER JOIN CHECK
################################################################################

# inner_join removes unmatched rows → no NA from join mismatch

flights |> 
  inner_join(planes, by = "tailnum") |> 
  select(flight, tailnum, type, manufacturer)

################################################################################
# JOIN WITH SUFFIXES
################################################################################

# Joining flights with weather (same column names)

flights |> 
  left_join(weather, by = c("origin", "time_hour"), suffix = c("_f", "_w")) |> 
  glimpse()

################################################################################
# CUSTOM RENAME AFTER JOIN
################################################################################

# Rename columns explicitly after join

flights |> 
  left_join(weather, by = c("origin", "time_hour"), suffix = c("_f", "_w")) |> 
  rename_with(~ paste0(.x, "_w"), any_of(names(weather))) |> 
  rename_with(~ paste0(.x, "_f"), any_of(names(flights))) |> 
  glimpse()

################################################################################
# MULTIPLE JOINS (CHAINED)
################################################################################

# Join multiple datasets step by step

flights |> 
  left_join(airlines, by = "carrier") |> 
  left_join(airports, by = c("dest" = "faa")) |> 
  left_join(planes, by = "tailnum")

################################################################################
# MIXED JOIN STRATEGY
################################################################################

# Stepwise joins

join1 <- flights |> 
  left_join(airlines, by = "carrier")

join2 <- join1 |> 
  inner_join(airports, by = c("dest" = "faa"))

join2 |> 
  left_join(planes, by = "tailnum")

################################################################################
# COMBINED PIPELINE (MIXED JOINS)
################################################################################

flights |> 
  left_join(airlines, by = "carrier") |> 
  inner_join(airports, by = c("dest" = "faa")) |> 
  semi_join(planes, by = "tailnum")

################################################################################
# STEP-BY-STEP COLUMN CONTROL DURING JOINS
################################################################################

flights |> 
  select(year, month, day, flight, dep_delay, carrier, dest, tailnum) |> 
  left_join(airlines, by = "carrier") |> 
  select(year, month, day, flight, dep_delay, carrier, dest, tailnum, name) |> 
  inner_join(airports, by = c("dest" = "faa")) |> 
  select(year, month, day, flight, dep_delay, carrier, dest, tailnum, name.x, name.y) |> 
  semi_join(planes, by = "tailnum")

################################################################################
# OTHER USEFUL NOTES
################################################################################

# left_join()  → Keep all rows from left
# right_join() → Keep all rows from right
# inner_join() → Only matching rows
# semi_join()  → Filter based on existence
# suffix       → Handle duplicate column names
# rename_with()→ Rename columns programmatically

#===============================================================================
# END OF FILE
#===============================================================================