#===============================================================================
# Chapter : Regex Patterns, String Extraction and Group Metrics in dplyr
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
# REGEX PATTERN FILTERING
################################################################################

# Flights to airports where destination starts with "S"

flights |> 
  filter(str_detect(dest, "^S")) |> 
  select(carrier, dest)

# Flights to airports containing "KE"

flights |> 
  filter(str_detect(dest, "KE")) |> 
  select(carrier, dest)

# Multiple pattern matching

flights |> 
  filter(str_detect(dest, "KE|VG|AK")) |> 
  select(carrier, dest)

################################################################################
# COMMON REGEX PATTERNS
################################################################################

# Pattern → Meaning → Example

# ^  → Starts with        → str_detect(dest, "^A")
# $  → Ends with          → str_detect(dest, "ST$")
# .  → Any character      → str_detect(dest, "A.C")
# [] → Character set      → str_detect(dest, "^[ABC]")

################################################################################
# COMBINED PATTERN EXAMPLE
################################################################################

# Destinations that start with 'S' and end with 'C'

flights |> 
  filter(str_detect(dest, "^S.C$")) |> 
  select(carrier, dest)

################################################################################
# STRING EXTRACTION AND REPLACEMENT
################################################################################

# Extract only digits from tailnum (e.g., N14228 → 14228)

flights |> 
  select(carrier, tailnum) |> 
  mutate(tail_digit = str_extract(tailnum, "\\d+"))

# Replace "N" at the start with "USA-"

flights |> 
  select(carrier, tailnum) |> 
  mutate(new_tail = str_replace(tailnum, "^N", "USA-"))

################################################################################
# ADVANCED REGEX (REPEATED CHARACTERS)
################################################################################

# Tail numbers with consecutive repeated letters (e.g., N3ALAA)

flights |> 
  select(carrier, tailnum) |> 
  filter(str_detect(tailnum, "([A-Z])\\1")) |> 
  distinct()

################################################################################
# END-WITH PATTERN FILTERING
################################################################################

# Destinations ending with 'A' or 'N'

flights |> 
  select(carrier, dest) |> 
  filter(str_detect(dest, "[AN]$"))

################################################################################
# GROUP METRICS (n_groups, n, n_distinct)
################################################################################

# Number of unique groups

flights |> 
  group_by(carrier) |> 
  n_groups()

flights |> 
  select(year, month) |> 
  group_by(year, month) |> 
  n_groups()

flights |> 
  select(year, month, day) |> 
  group_by(year, month, day) |> 
  n_groups()

################################################################################
# COUNTING ROWS PER GROUP (n)
################################################################################

# Flights per carrier and origin

flights |> 
  group_by(carrier, origin) |> 
  summarise(n_flights = n())

# Flights per destination

flights |> 
  group_by(dest) |> 
  summarise(n_dest = n())

################################################################################
# COUNT DISTINCT VALUES
################################################################################

# Unique carriers and flight numbers

flights |> 
  select(carrier, flight, year, month, day) |> 
  summarise(
    u_carrier = n_distinct(carrier),
    u_flight  = n_distinct(flight)
  )

################################################################################
# OTHER USEFUL NOTES
################################################################################

# str_detect()  → Pattern matching (regex)
# str_extract() → Extract matching pattern
# str_replace() → Replace pattern
# n()           → Count rows
# n_groups()    → Count groups
# n_distinct()  → Count unique values

#===============================================================================
# END OF FILE
#===============================================================================