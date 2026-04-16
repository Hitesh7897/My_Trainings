#===============================================================================
# Chapter : Advanced Joins with join_by(), Inequality and Aggregated Joins
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
# JOIN USING CLASSICAL vs join_by()
################################################################################

# Classical join (different column names)

flights |> 
  left_join(airports, by = c("dest" = "faa"))

# Modern join using join_by()

flights |> 
  left_join(airports, by = join_by(dest == faa))

################################################################################
# MULTI-KEY JOIN USING join_by()
################################################################################

# Join flights with weather using multiple keys

flights |> 
  left_join(weather, by = join_by(origin, year, month, day))

################################################################################
# INEQUALITY JOIN (NON-EQUI JOIN)
################################################################################

# Join where flight time >= weather time

flights |> 
  left_join(
    weather,
    by = join_by(origin, year, month, day, time_hour >= time_hour)
  )

################################################################################
# CLOSEST MATCH JOIN
################################################################################

# Match nearest earlier weather record

flights |> 
  left_join(
    weather,
    by = join_by(origin, year, month, day, closest(time_hour >= time_hour))
  )

################################################################################
# AGGREGATED JOIN (PERFORMANCE OPTIMIZATION)
################################################################################

# Create summarized weather table

weather_summary <- weather |> 
  group_by(origin) |> 
  summarise(avg_temp = mean(temp, na.rm = TRUE), .groups = "drop")

# Join summarized data (many-to-one relationship)

flights |> 
  left_join(weather_summary, by = "origin", relationship = "many-to-one") |> 
  select(flight, carrier, tailnum, origin, avg_temp)

################################################################################
# PERFORMANCE & DUPLICATION CONTROL
################################################################################

# Why aggregation helps:
# - Prevents data duplication (avoids many-to-many joins)
# - Improves performance
# - Reduces memory usage

################################################################################
# OTHER USEFUL NOTES
################################################################################

# join_by()   → Flexible join conditions
# ==          → Equality join
# >=, <=      → Inequality joins
# closest()   → Nearest match
# summarise() → Reduce data before join
# relationship→ Validate join type

#===============================================================================
# END OF FILE
#===============================================================================