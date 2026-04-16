#===============================================================================
# Chapter : Joins, Benchmarking, Slicing and Date-Time Filtering in dplyr
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
airlines
View(flights)

################################################################################
# JOIN OPERATIONS (LEFT JOIN)
################################################################################

# Filter flights belonging to "JetBlue Airways"

flights |> 
  left_join(airlines, by = "carrier") |> 
  filter(name == "JetBlue Airways") |> 
  select(carrier, name) |> 
  distinct()

################################################################################
# PERFORMANCE BENCHMARKING
################################################################################

# microbenchmark → Compare execution speed

library(microbenchmark)

results <- microbenchmark(
  base_join = left_join(flights, airlines, by = "carrier")
)
print(results)

# Benchmark full pipeline

results <- microbenchmark(
  output = flights |> 
    left_join(airlines, by = "carrier") |> 
    filter(name == "JetBlue Airways") |> 
    select(carrier, name) |> 
    distinct()
)
print(results)

################################################################################
# MODERN BENCHMARKING (bench)
################################################################################

# bench::mark → Includes memory usage

results <- bench::mark(
  output = flights |> 
    left_join(airlines, by = "carrier") |> 
    filter(name == "JetBlue Airways") |> 
    select(carrier, name) |> 
    distinct()
)
print(results)

################################################################################
# PROFILING (profvis)
################################################################################

# profvis → Identify slow parts of large scripts

library(profvis)

profvis({
  output <- flights |> 
    left_join(airlines, by = "carrier") |> 
    filter(name == "JetBlue Airways") |> 
    select(carrier, name) |> 
    distinct()
})

################################################################################
# BENCHMARKING SUMMARY
################################################################################

# microbenchmark → Speed comparison
# bench          → Speed + memory
# profvis        → Line-by-line profiling

################################################################################
# TOP / BOTTOM N VALUES
################################################################################

# Top 5 delayed flights

flights |> 
  slice_max(arr_delay, n = 5) |> 
  select(carrier, arr_delay)

# Alternative approach

flights |> 
  select(carrier, arr_delay) |> 
  arrange(desc(arr_delay)) |> 
  head(5)

# Lowest 5 delayed flights

flights |> 
  slice_min(arr_delay, n = 5) |> 
  select(carrier, arr_delay)

################################################################################
# TIME-BASED FILTERING
################################################################################

# Flights departing late night (>= 10 PM) or early morning (<= 5 AM)

flights |> 
  select(carrier, year, month, day, dep_time) |> 
  filter(dep_time >= 2200 | dep_time <= 500) |> 
  distinct()

################################################################################
# EARLIEST / LATEST FLIGHTS
################################################################################

# Check missing values
colSums(is.na(flights))

# Earliest flight

flights |> 
  select(carrier, time_hour) |> 
  slice_min(time_hour)

# Alternative methods

flights |> 
  select(carrier, time_hour) |> 
  filter(time_hour == min(time_hour))

# Latest flight

flights |> 
  select(carrier, time_hour) |> 
  filter(time_hour == max(time_hour))

################################################################################
# DATE FILTERING
################################################################################

# Flights on or after March 1, 2013

flights |> 
  select(carrier, time_hour) |> 
  filter(time_hour >= as.POSIXct("2013-03-01"))

# Using Date

flights |> 
  select(carrier, time_hour) |> 
  filter(time_hour >= as.Date("2013-03-01"))

################################################################################
# DATE RANGE FILTERING
################################################################################

# Between Jan 1 and Jan 15, 2013

flights |> 
  select(carrier, time_hour) |> 
  filter(
    between(
      time_hour,
      as.Date("2013-01-01"),
      as.Date("2013-01-15")
    )
  )

# Classical approach

flights |> 
  select(carrier, time_hour) |> 
  filter(
    time_hour >= as.Date("2013-01-01") &
    time_hour <= as.Date("2013-01-15")
  )

################################################################################
# BENCHMARK: BETWEEN VS CLASSICAL FILTER
################################################################################

bench::mark(
  bt_mark = flights |> 
    filter(between(
      time_hour,
      as.Date("2013-01-01"),
      as.Date("2013-01-15")
    )),
  cl_mark = flights |> 
    filter(
      time_hour >= as.Date("2013-01-01") &
      time_hour <= as.Date("2013-01-15")
    )
)

microbenchmark(
  bt_mark = flights |> 
    select(carrier, time_hour) |> 
    filter(between(
      time_hour,
      as.Date("2013-01-01"),
      as.Date("2013-01-15")
    )),
  cl_mark = flights |> 
    select(carrier, time_hour) |> 
    filter(
      time_hour >= as.Date("2013-01-01") &
      time_hour <= as.Date("2013-01-15")
    )
)

################################################################################
# OTHER USEFUL NOTES
################################################################################

# left_join() → Combine datasets
# slice_max() → Top N values
# slice_min() → Bottom N values
# between()   → Range filtering
# bench::mark() → Performance + memory
# profvis()   → Code profiling

#===============================================================================
# END OF FILE
#===============================================================================