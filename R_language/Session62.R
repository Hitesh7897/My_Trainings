#===============================================================================
# Chapter : Column Reordering, Nested Data and Conditional Filtering in dplyr
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
# COLUMN REORDERING WITH FILTERING
################################################################################

# Move all character columns to front, then delay columns, then filter

flights |> 
  relocate(where(is.character), contains("delay")) |> 
  filter(arr_delay > 120)

################################################################################
# LOGICAL OPERATORS
################################################################################

# && → Short-circuit AND (single value)
# &  → Vectorized AND (used in dplyr)

################################################################################
# COLUMN REORDERING + FILTER (AIR_TIME EXAMPLE)
################################################################################

# Move air_time to front, filter flights with air_time < 30,
# then relocate origin and dest after air_time

flights |> 
  relocate(air_time) |> 
  filter(air_time < 30) |> 
  relocate(origin, dest, .after = air_time) |> 
  glimpse()

################################################################################
# NESTED DATA (GROUPED LIST-COLUMNS)
################################################################################

# Nest flights by carrier

nest_tibble <- flights |> 
  group_by(carrier) |> 
  nest()

# Access one group's nested data
nest_tibble$data[[15]]

################################################################################
# MISSING VALUE CHECK
################################################################################

colSums(is.na(weather))
colSums(is.na(flights))

################################################################################
# CONDITIONAL FILTERING (CANCELLATIONS & WEATHER)
################################################################################

# NOTE: Direct comparison like weather$precip inside flights filter is incorrect
# because datasets are not aligned row-wise

# Correct approach → join flights with weather first

flights_weather <- flights |> 
  left_join(weather, by = c("origin", "year", "month", "day", "hour"))

# Flights cancelled (dep_time NA) and weather precipitation available

flights_weather |> 
  filter(is.na(dep_time) & !is.na(precip)) |> 
  select(origin, dep_time, precip)

################################################################################
# VECTOR CHECKS (UNDERSTANDING NA)
################################################################################

# Logical vectors

is.na(flights$dep_time)
length(is.na(flights$dep_time))

!is.na(weather$precip)
length(!is.na(weather$precip))

# Extract precip as vector
weather |> 
  select(precip) |> 
  pull()

################################################################################
# OTHER USEFUL NOTES
################################################################################

# relocate() → Reorder columns
# nest()     → Create grouped list-columns
# left_join()→ Combine datasets for aligned filtering
# is.na()    → Detect missing values
# pull()     → Extract column as vector

#===============================================================================
# END OF FILE
#===============================================================================