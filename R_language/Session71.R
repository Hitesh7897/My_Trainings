#===============================================================================
# Chapter : Group-wise Operations, across(), and Context Functions in dplyr
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
# MUTATE WITH group_by()
################################################################################

# Add group-wise average delay

flights |> 
  group_by(month) |> 
  mutate(month_avg = mean(arr_delay, na.rm = TRUE)) |> 
  select(month, month_avg)


################################################################################
# FILTER WITH group_by()
################################################################################

# Keep flights where delay >= monthly average

flights |> 
  group_by(month) |> 
  mutate(avg_delay = mean(arr_delay, na.rm = TRUE)) |> 
  filter(arr_delay >= avg_delay) |> 
  transmute(carrier, flight, month, arr_delay, avg_delay)


################################################################################
# transmute() REPLACEMENT USING .keep
################################################################################

# transmute() is superseded → use mutate(.keep = "none")

flights |> 
  group_by(month) |> 
  mutate(
    carrier, flight, month, arr_delay,
    month_avg = mean(arr_delay, na.rm = TRUE),
    .keep = "none"
  )


################################################################################
# ARRANGE WITHIN GROUPS
################################################################################

flights |> 
  group_by(month) |> 
  arrange(desc(arr_delay)) |> 
  transmute(carrier, flight, month, arr_delay)


################################################################################
# SLICE WITHIN GROUPS
################################################################################

# Top 3 delays per month

flights |> 
  group_by(month) |> 
  slice_max(arr_delay, n = 3) |> 
  transmute(carrier, flight, month, arr_delay)


################################################################################
# COUNTING WITHIN GROUPS (n())
################################################################################

# Using mutate()

flights |> 
  group_by(month) |> 
  mutate(count = n(), .keep = "none") |> 
  distinct()

# Using summarise()

flights |> 
  group_by(month) |> 
  summarise(count = n()) |> 
  distinct()


################################################################################
# across() WITH group_by()
################################################################################

# Apply functions across multiple columns

flights |> 
  group_by(carrier) |> 
  summarise(
    across(c(arr_delay, dep_delay), ~ mean(.x, na.rm = TRUE))
  )


################################################################################
# RANKING WITHIN GROUPS
################################################################################

flights |> 
  group_by(carrier) |> 
  mutate(
    carrier, arr_delay,
    rank = min_rank(desc(arr_delay)),
    .keep = "none"
  ) |> 
  arrange(carrier, rank)


################################################################################
# CONTEXT FUNCTIONS
################################################################################

#-------------------------------------------------------------------------------
# cur_group()
#-------------------------------------------------------------------------------

rm <- flights |> 
  group_by(origin, month) |> 
  summarise(
    group_info = list(cur_group()),
    avg_delay = mean(dep_delay, na.rm = TRUE),
    .groups = "drop"
  )

rm
class(rm)

# Access group metadata
rm$group_info[[28]]


#-------------------------------------------------------------------------------
# cur_column()
#-------------------------------------------------------------------------------

# Dynamically detect column name inside across()

flights |> 
  summarise(
    across(c(arr_delay, dep_delay), ~ {
      message("Currently processing the column: ", cur_column())
      mean(.x, na.rm = TRUE)
    })
  )


#-------------------------------------------------------------------------------
# cur_data()
#-------------------------------------------------------------------------------

# Returns current group data (excluding grouping columns)

flights |> 
  group_by(origin) |> 
  mutate(
    total_group_rows = nrow(cur_data()),
    .keep = "none"
  )

# Equivalent using summarise

flights |> 
  group_by(origin) |> 
  summarise(
    total_group_rows = n()
  )


################################################################################
# GROUP ITERATION FUNCTIONS
################################################################################

#-------------------------------------------------------------------------------
# group_map()
#-------------------------------------------------------------------------------

# Apply function to each group → returns list

flights |> 
  group_by(carrier) |> 
  group_map(~ head(.x, 2))


#-------------------------------------------------------------------------------
# group_modify()
#-------------------------------------------------------------------------------

# Transform each group and return combined dataframe

flights |> 
  group_by(carrier) |> 
  group_modify(~ head(.x, 2))


################################################################################
# KEY TAKEAWAYS
################################################################################

# mutate() + group_by() → group-level transformations
# filter() + group_by() → conditional filtering within groups
# across() → apply functions to multiple columns
# n() → count rows per group
# ranking functions → min_rank(), dense_rank(), etc.
# context functions → cur_group(), cur_column(), cur_data()
# group_map() → returns list output per group
# group_modify() → returns transformed dataframe


#===============================================================================
# END OF FILE
#===============================================================================