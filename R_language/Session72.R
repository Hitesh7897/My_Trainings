#===============================================================================
# Chapter : Group Metadata, .by Optimization, and Missing Value Handling in dplyr
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
# cur_data() - GROUP CONTEXT DATA
################################################################################

# Returns all rows/columns for current group (excluding grouping columns)

flights |> 
  group_by(origin) |> 
  mutate(
    total_group_rows = nrow(cur_data()),
    .keep = "none"
  )


################################################################################
# BASIC FILTERING
################################################################################

flights |> 
  filter(origin == "EWR")


################################################################################
# GROUPING + SUMMARISE
################################################################################

# Traditional approach

flights |> 
  group_by(month) |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE))


################################################################################
# OPTIMIZED APPROACH USING .by
################################################################################

# No need for explicit group_by()

flights |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), .by = month)


################################################################################
# GROUPED JOIN (PIPELINE OPTIMIZATION)
################################################################################

# Avg delay per carrier + airline details

flights |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), .by = carrier) |> 
  left_join(airlines, by = "carrier")


################################################################################
# HANDLING MISSING VALUES
################################################################################

# Aggregation automatically ignores NA with na.rm = TRUE

flights |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), .by = carrier)


################################################################################
# FILTERING GROUPS WITHOUT MISSING VALUES
################################################################################

flights |> 
  select(carrier, arr_delay, year, month, day) |> 
  group_by(carrier) |> 
  filter(!any(is.na(arr_delay)))


################################################################################
# DISTINCT GROUP COMBINATIONS
################################################################################

# Unique combinations

flights |> 
  distinct(month, carrier)

?distinct

# Using grouping metadata

flights |> 
  group_by(month, carrier) |> 
  group_keys()


################################################################################
# GROUP METADATA FUNCTIONS
################################################################################

#-------------------------------------------------------------------------------
# group_data()
#-------------------------------------------------------------------------------

# Returns grouping structure + row indices

a <- flights |> 
  group_by(month) |> 
  group_data()

a
a$.rows


#-------------------------------------------------------------------------------
# group_rows()
#-------------------------------------------------------------------------------

# Returns list of row indices per group

flights |> 
  group_by(month) |> 
  group_rows()


#-------------------------------------------------------------------------------
# group_indices()
#-------------------------------------------------------------------------------

# Assign numeric group IDs

flights |> 
  group_by(month, carrier) |> 
  group_indices()


################################################################################
# MODERN GROUP IDENTIFIER
################################################################################

# Preferred approach using cur_group_id()

flights |> 
  group_by(month, carrier) |> 
  mutate(group_id = cur_group_id()) |> 
  select(month, carrier, group_id)


################################################################################
# GROUP SIZE SUMMARY
################################################################################

# Count rows per group

flights |> 
  group_by(month) |> 
  summarise(n_r = n())


################################################################################
# KEY TAKEAWAYS
################################################################################

# cur_data() → access current group data
# .by → faster alternative to group_by() + summarise()
# group_keys() → unique group combinations
# group_data() → full grouping metadata
# group_rows() → row indices per group
# group_indices() / cur_group_id() → assign group IDs
# distinct() → unique combinations without grouping


#===============================================================================
# END OF FILE
#===============================================================================