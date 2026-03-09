#===============================================================================
# Chapter 41 : Sorting, Group-wise Ranking and Top-N Operations (dplyr)
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)



################################################################################
# DATA INSPECTION
################################################################################

# Count missing values per column
colSums(is.na(flights))

# Base R structure
str(flights)

# Tidyverse structure
glimpse(flights)



################################################################################
# SORTING A DERIVED COLUMN
################################################################################
# Create a derived variable
# delay_per_mile = arr_delay / distance

flights |>
  mutate(delay_per_mile = arr_delay / distance) |>
  select(year, month, day, carrier, delay_per_mile) |>
  arrange(desc(delay_per_mile))



################################################################################
# SORT AFTER FILTERING
################################################################################
# Example: Top delayed flights from JFK origin

flights |>
  filter(origin == "JFK") |>
  select(year, month, day, carrier, origin, dest, arr_delay) |>
  arrange(desc(arr_delay))



################################################################################
# SORTING WITHIN GROUPS
################################################################################
# Incorrect approach (does not respect group ordering)

flights |>
  group_by(carrier) |>
  select(carrier, arr_delay) |>
  arrange(desc(arr_delay))



################################################################################
# CORRECT GROUP-WISE SORTING (.by_group = TRUE)
################################################################################

f_d <- flights |>
  group_by(carrier) |>
  select(carrier, arr_delay) |>
  arrange(desc(arr_delay), .by_group = TRUE) |>
  left_join(airlines, by = "carrier") |>
  select(
    air_plane = name,
    carrier
  )



################################################################################
# ALTERNATIVE METHOD (WITHOUT .by_group)
################################################################################

flights |>
  group_by(carrier, arr_delay) |>
  select(carrier, arr_delay) |>
  arrange(carrier, desc(arr_delay))



################################################################################
# TOP-N RECORDS PER GROUP
################################################################################
# Classic approach

flights |>
  group_by(carrier) |>
  select(carrier, arr_delay) |>
  arrange(desc(arr_delay), .by_group = TRUE) |>
  filter(row_number() == 3)



################################################################################
# MODERN APPROACH — slice_max()
################################################################################
# Top 3 delays per carrier

flights |>
  group_by(carrier) |>
  slice_max(arr_delay, n = 3) |>
  select(carrier, arr_delay)

# max → descending
# min → ascending



################################################################################
# LEAST DELAY PER CARRIER
################################################################################
# Top 3 smallest delays

flights |>
  group_by(carrier) |>
  slice_min(arr_delay, n = 3) |>
  select(carrier, arr_delay)



################################################################################
# SECOND HIGHEST DELAY PER CARRIER
################################################################################

flights |>
  group_by(carrier) |>
  slice_max(arr_delay, n = 2) |>
  slice_tail(n = 1) |>
  select(carrier, arr_delay)


# Alternative method
flights |>
  group_by(carrier) |>
  arrange(desc(arr_delay), .by_group = TRUE) |>
  slice(2) |>
  select(carrier, arr_delay)



################################################################################
# SUMMARY
################################################################################

# mutate()       → Create derived variables
# filter()       → Filter rows
# arrange()      → Sort rows
# group_by()     → Group data
# slice_max()    → Top N values
# slice_min()    → Bottom N values
# row_number()   → Ranking within groups


#===============================================================================
# END OF FILE
#===============================================================================