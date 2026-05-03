#===============================================================================
# Chapter : Subqueries, Inline Queries, and Semi-Joins in dplyr
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
# DATA PREVIEW
################################################################################

flights            # prints dataset
View(flights)      # opens viewer

flights <- flights # ❌ invalid / redundant reassignment


################################################################################
# BASIC SUBQUERY (EXTRACT VALUES)
################################################################################

# Get carriers for selected airlines

s_carrier <- airlines |> 
  filter(name %in% c("Delta Air Lines Inc.", "United Air Lines Inc.")) |> 
  pull(carrier)


################################################################################
# SUBQUERY INSIDE FILTER (COMMON PITFALL)
################################################################################

# ❗ May fail if return type is not a vector

flights |> 
  filter(carrier %in% (
    airlines |> 
      filter(name %in% c("Delta Air Lines Inc.", "United Air Lines Inc."))
  ))


################################################################################
# FIX → STORE RESULT IN OBJECT
################################################################################

flights |> 
  filter(carrier %in% s_carrier)


################################################################################
# INLINE SUBQUERY (SAFE APPROACH)
################################################################################

flights |> 
  filter(carrier %in% (
    airlines |> 
      filter(name == "Delta Air Lines Inc.") |> 
      pull(carrier)
  ))


################################################################################
# SUBQUERY USING ANOTHER TABLE CONDITION
################################################################################

# Flights going to high altitude airports

flights |> 
  filter(dest %in% (
    airports |> 
      filter(alt > 500) |> 
      pull(faa)
  ))


################################################################################
# SUBQUERY USING semi_join() (PREFERRED)
################################################################################

# Equivalent to filtering using another table

flights |> 
  semi_join(
    airlines |> filter(name == "Delta Air Lines Inc."),
    by = "carrier"
  ) |> 
  glimpse()


################################################################################
# SUBQUERY INSIDE mutate()
################################################################################

# Inline aggregation inside mutate

flights |> 
  mutate(
    delay_vs_avg = arr_delay - (
      flights |> 
        summarise(avg = mean(arr_delay, na.rm = TRUE)) |> 
        pull(avg)
    ),
    .keep = "used"
  )


################################################################################
# OPTIMIZED APPROACH (AVOID REPEATED COMPUTATION)
################################################################################

avg_delay1 <- flights |> 
  summarise(avg = mean(arr_delay, na.rm = TRUE)) |> 
  pull(avg)

flights |> 
  mutate(delay_vs_avg = arr_delay - avg_delay1, .keep = "used")


################################################################################
# INLINE QUERY CONCEPT
################################################################################

# Inline query acts like a temporary table
# Computed once and reused within expression


################################################################################
# CORRELATED SUBQUERY (GROUP CONTEXT)
################################################################################

# Inner computation depends on outer grouping

flights |> 
  group_by(carrier) |> 
  mutate(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    diff = arr_delay - avg_delay,
    .keep = "used"
  )


################################################################################
# SUBQUERY WITH summarise()
################################################################################

flights |> 
  filter(dest %in% (
    airports |> 
      filter(tz == -8) |> 
      pull(faa)
  )) |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE))


################################################################################
# NESTED SUBQUERIES
################################################################################

flights |> 
  filter(dest %in% (                        # Query 1
    airports |> 
      filter(
        faa %in% (                          # Query 2
          flights |>                        # Query 3
            filter(arr_delay > 60) |> 
            pull(dest)
        )
      ) |> 
      pull(faa)
  ))


################################################################################
# NESTED QUERY FLOW (UNDERSTANDING)
################################################################################

# Query 3 → Get destinations where arr_delay > 60
# Query 2 → Filter airports matching those destinations
# Query 1 → Filter flights matching resulting airport list
# Final   → Flights dataset filtered using nested logic


################################################################################
# KEY TAKEAWAYS
################################################################################

# pull() → converts dataframe output to vector (critical for %in%)
# inline subqueries → act like temporary tables
# semi_join() → cleaner alternative to subqueries
# correlated queries → depend on group context
# avoid recomputation → store intermediate results
# nested queries → executed from innermost to outermost


#===============================================================================
# END OF FILE
#===============================================================================