#===============================================================================
# Chapter : Data Reshaping (Pivoting, Separating, and Uniting) in dplyr/tidyr
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
# WHAT IS DATA SHAPING?
################################################################################

# Transform structure of data:
# - Rows → Columns
# - Columns → Rows
# - Convert table ↔ vector formats

# Wide → Long  → pivot_longer()
# Long → Wide  → pivot_wider()


################################################################################
# pivot_longer() → WIDE TO LONG
################################################################################

flights |> 
  select(flight, dep_delay, arr_delay) |>
  pivot_longer(
    cols = c(dep_delay, arr_delay),
    names_to = "Delay_type",   # column names become values
    values_to = "Delay"        # values column
  )


################################################################################
# pivot_longer() WITH PATTERN MATCHING
################################################################################

flights |> 
  select(flight, dep_delay, arr_delay) |>
  pivot_longer(
    cols = ends_with("delay"),
    names_to = "Delay_type",
    values_to = "Delay"
  )

# Without select (applies to full dataset)

flights |> 
  pivot_longer(
    cols = ends_with("delay"),
    names_to = "Delay_type",
    values_to = "Delay"
  )


################################################################################
# SPLITTING COLUMN NAMES INTO MULTIPLE COLUMNS
################################################################################

flights |> 
  select(flight, dep_time, arr_time) |>
  pivot_longer(
    cols = c(dep_time, arr_time),
    names_to = c("event", "type"),
    names_sep = "_"
  )


################################################################################
# HANDLING MISSING VALUES IN pivot_longer()
################################################################################

colSums(is.na(flights))

flights |> 
  select(flight, dep_time, arr_time) |>
  pivot_longer(
    cols = c(dep_time, arr_time),
    names_to = c("event", "type"),
    names_sep = "_",
    values_drop_na = TRUE
  )


################################################################################
# pivot_wider() → LONG TO WIDE
################################################################################

# Rows become columns

flights |> 
  select(flight, carrier, dep_delay) |> 
  pivot_wider(
    names_from = carrier,
    values_from = dep_delay
  )


################################################################################
# HANDLING DUPLICATES BEFORE pivot_wider()
################################################################################

# Aggregation required

flights |> 
  group_by(flight, carrier) |> 
  summarise(delay = mean(dep_delay, na.rm = TRUE), .groups = "drop") |> 
  pivot_wider(
    names_from = carrier,
    values_from = delay
  )


################################################################################
# FILL MISSING VALUES IN pivot_wider()
################################################################################

flights |> 
  group_by(flight, carrier) |> 
  summarise(delay = mean(dep_delay, na.rm = TRUE), .groups = "drop") |> 
  pivot_wider(
    names_from = carrier,
    values_from = delay,
    values_fill = 0
  )


################################################################################
# MULTIPLE VALUE COLUMNS IN pivot_wider()
################################################################################

flights |> 
  select(flight, carrier, dep_delay, arr_delay) |> 
  pivot_wider(
    names_from = carrier,
    values_from = c(dep_delay, arr_delay)
  ) |> 
  glimpse()


################################################################################
# SEPARATE → SPLIT ONE COLUMN INTO MULTIPLE
################################################################################

flights |> 
  select(tailnum) |> 
  separate(
    tailnum,
    into = c("prefix", "number"),
    sep = 1
  )


################################################################################
# UNITE → COMBINE MULTIPLE COLUMNS INTO ONE
################################################################################

flights |> 
  unite(
    "route",
    origin, dest,
    sep = "-",
    remove = FALSE
  ) |> 
  select(flight, origin, dest, route)


################################################################################
# KEY TAKEAWAYS
################################################################################

# pivot_longer() → wide to long transformation
# pivot_wider() → long to wide transformation
# ends_with() → dynamic column selection
# values_drop_na → remove missing values during reshape
# values_fill → fill missing values in wide format
# separate() → split one column into many
# unite() → combine multiple columns into one
# Always aggregate before pivot_wider() if duplicates exist


#===============================================================================
# END OF FILE
#===============================================================================