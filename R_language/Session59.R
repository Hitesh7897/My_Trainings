#===============================================================================
# Chapter : Frequency-Based Filtering, First/Last Rows and Lag/Lead in dplyr
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
# FREQUENCY COUNT (CLASSICAL vs MODERN)
################################################################################

# Classical approach → count flights per carrier

flights |> 
  select(carrier, origin, dest, month, day, year) |> 
  group_by(carrier) |> 
  summarise(n = n())

# Modern approach → using count()

flights |> 
  count(carrier, sort = TRUE)

################################################################################
# ADD_COUNT() (ADD GROUP FREQUENCY TO DATA)
################################################################################

# For each flight, how many flights does each airline operate?

flights |> 
  add_count(carrier) |> 
  select(carrier, flight, n)

################################################################################
# FILTER FREQUENT CARRIERS
################################################################################

# Keep airlines with at least 20,000 flights

flights |> 
  add_count(carrier) |> 
  select(carrier, flight, n) |> 
  filter(n >= 20000)

################################################################################
# FILTER FREQUENT AIRCRAFT (TAIL NUMBER)
################################################################################

# Aircraft that flew at least 50 times

flights |> 
  add_count(tailnum) |> 
  select(carrier, flight, n) |> 
  filter(n >= 50) |> 
  distinct(carrier, n)

################################################################################
# POPULAR ROUTES (ORIGIN → DESTINATION)
################################################################################

# Routes that occurred at least 100 times

flights |> 
  add_count(origin, dest) |> 
  filter(n >= 100) |> 
  select(origin, dest, n)

# Alternative: count()

flights |> 
  count(origin, dest)

################################################################################
# FIRST ROW PER GROUP
################################################################################

# First recorded flight from each origin

flights |> 
  group_by(origin) |> 
  slice_head(n = 1) |> 
  select(origin, carrier, flight, time_hour)

# Alternative using row_number()

flights |> 
  group_by(origin) |> 
  filter(row_number() == 1) |> 
  select(origin, carrier, flight, time_hour)

################################################################################
# LAST ROW PER GROUP
################################################################################

# Last recorded flight from each origin

flights |> 
  group_by(origin) |> 
  slice_tail(n = 1) |> 
  select(origin, carrier, flight, time_hour)

# Alternative using row_number()

flights |> 
  group_by(origin) |> 
  filter(row_number() == n()) |> 
  select(origin, carrier, flight, time_hour)

################################################################################
# ROW NUMBER INSPECTION (DEBUGGING)
################################################################################

flights |> 
  group_by(origin) |> 
  mutate(row_n = row_number()) |> 
  select(origin, carrier, flight, time_hour, row_n) |> 
  filter(origin == "EWR") |> 
  arrange(origin, carrier, desc(flight), time_hour) |> 
  tail()

################################################################################
# LAG AND LEAD (SEQUENTIAL COMPARISON)
################################################################################

# Demonstration of lag and lead

flights |> 
  select(carrier, dep_delay) |> 
  mutate(
    lag_depdelay  = lag(dep_delay),
    lead_depdelay = lead(dep_delay)
  )

################################################################################
# FILTER BASED ON PREVIOUS VALUE (LAG)
################################################################################

# Flights where departure delay differs from previous flight

flights |> 
  select(carrier, dep_delay) |> 
  mutate(lag_depdelay = lag(dep_delay)) |> 
  filter(dep_delay != lag_depdelay)

################################################################################
# OTHER USEFUL NOTES
################################################################################

# count()     → group_by + summarise shortcut
# add_count() → Adds frequency column
# slice_head()→ First row(s) per group
# slice_tail()→ Last row(s) per group
# row_number()→ Row position within group
# lag()       → Previous value
# lead()      → Next value

#===============================================================================
# END OF FILE
#===============================================================================