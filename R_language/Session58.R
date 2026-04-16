#===============================================================================
# Chapter : Cumulative Calculations, Lag/Lead and Frequency Counts in dplyr
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
# CHECK MISSING VALUES
################################################################################

colSums(is.na(flights))

################################################################################
# CUMULATIVE SUM (CUMSUM)
################################################################################

# How many flights contribute to first 1000 minutes of delay per day (JFK)

flights |> 
  select(origin, month, day, dep_delay) |> 
  filter(origin == "JFK", !is.na(dep_delay)) |> 
  group_by(month, day) |> 
  arrange(month, day, dep_delay) |> 
  mutate(running_delay = cumsum(dep_delay)) |> 
  filter(running_delay <= 1000)

################################################################################
# LAG AND LEAD FUNCTIONS
################################################################################

# Compare current delay with previous and next values

flights |> 
  select(origin, month, day, dep_delay) |> 
  filter(origin == "JFK", !is.na(dep_delay)) |> 
  group_by(month, day) |> 
  arrange(month, day, dep_delay) |> 
  mutate(
    lag_delay   = lag(dep_delay),
    lead_delay  = lead(dep_delay),
    running_delay = cumsum(dep_delay),
    delay_diff  = dep_delay - lag(dep_delay)
  )

################################################################################
# CUSTOM RUNNING CALCULATIONS
################################################################################

# Manual cumulative approximation using lag()

flights |> 
  select(origin, month, day, dep_delay) |> 
  filter(origin == "JFK", !is.na(dep_delay)) |> 
  group_by(month, day) |> 
  arrange(month, day, dep_delay) |> 
  mutate(
    running_delay  = cumsum(dep_delay),
    running_delay1 = dep_delay + lag(dep_delay, 1) + lag(dep_delay, 2)
  )

################################################################################
# FREQUENCY COUNT (GROUP-WISE)
################################################################################

# Number of flights per carrier

flights |> 
  select(carrier, origin, dest, month, day, year) |> 
  group_by(carrier) |> 
  summarise(n_flights = n())

################################################################################
# COUNT() SHORTCUT
################################################################################

# Simplified approach using count()

flights |> 
  count(carrier, sort = TRUE)

################################################################################
# OTHER USEFUL NOTES
################################################################################

# cumsum() → Running total
# lag()    → Previous value
# lead()   → Next value
# n()      → Row count
# count()  → Shortcut for group_by + summarise

#===============================================================================
# END OF FILE
#===============================================================================