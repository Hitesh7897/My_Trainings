#===============================================================================
# Chapter : Group Iteration, Window Functions, and Advanced Group Operations
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
# GROUP SPLIT OPERATIONS
################################################################################

# Split into list of dataframes per group

flights |> 
  group_by(carrier) |> 
  group_split()


################################################################################
# group_walk() → SIDE EFFECT OPERATIONS
################################################################################

# Apply function per group (no return, just side effects)

flights |> 
  group_by(carrier) |> 
  group_walk(~ print(nrow(.x)))


################################################################################
# group_trim() → REMOVE EMPTY GROUPS
################################################################################

flights |> 
  group_by(carrier) |> 
  group_trim()


################################################################################
# WINDOW FUNCTIONS
################################################################################

flights |> 
  group_by(month) |> 
  mutate(
    lag_delay  = lag(arr_delay),
    lead_delay = lead(arr_delay),
    .keep = "none"
  )

# Other useful window functions:
# row_number()
# dense_rank()
# cumsum()
# cummean()


################################################################################
# GROUP-WISE CUSTOM FUNCTIONS
################################################################################

my_func <- function(tb) {
  summarise(tb, avg = mean(arr_delay, na.rm = TRUE))
}

flights |> 
  group_by(carrier) |> 
  group_modify(~ my_func(.x))


################################################################################
# MULTI-LEVEL AGGREGATIONS
################################################################################

# Step 1: Daily average
# Step 2: Monthly average of daily averages

flights |> 
  group_by(year, month, day) |> 
  summarise(daily_avg = mean(arr_delay, na.rm = TRUE)) |> 
  group_by(month) |> 
  summarise(month_avg = mean(daily_avg, na.rm = TRUE))


################################################################################
# DYNAMIC GROUPING
################################################################################

# Group variable defined dynamically

group_var <- "day"

flights |> 
  group_by(.data[[group_var]]) |> 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE))


################################################################################
# GROUP-WISE CASE LOGIC
################################################################################

# Categorize based on group average

flights |> 
  group_by(month) |> 
  mutate(
    category = case_when(
      arr_delay > mean(arr_delay, na.rm = TRUE) ~ "Above Avg",
      TRUE ~ "Below Avg"
    ),
    .keep = "none"
  )


################################################################################
# GROUP-WISE DISTINCT COUNTS
################################################################################

flights |> 
  group_by(carrier) |> 
  summarise(u_dest = n_distinct(dest))


################################################################################
# GROUP BY + PIVOT (RESHAPING)
################################################################################

flights |> 
  group_by(carrier, month) |> 
  summarise(avg = mean(arr_delay, na.rm = TRUE)) |> 
  pivot_wider(names_from = month, values_from = avg)


################################################################################
# EXTERNAL PACKAGE WORKFLOW (rCoreGage)
################################################################################

# Install package (once)
install.packages("rCoreGage")

library(rCoreGage)

# Step 1 — Create a new project
rCoreGage::create_project(
  name = "TRAIL_011",
  path = "C:/edit_checks"
)

# Step 2 — Open generated .Rproj file in RStudio

# Step 3 — Configure rules
# Edit: rules/config/rule_registry.xlsx

# Step 4 — Write validation scripts
# Location:
#   rules/trial/
#   rules/study/

# Step 5 — Add input data
# Place files in inputs/
# Example:
#   AE.csv, LB.csv, CM.csv

# Step 6 — Execute pipeline
source("run_coregage.R")

# Step 7 — Check outputs
# Location:
# outputs/reports/


################################################################################
# KEY TAKEAWAYS
################################################################################

# group_split() → split into list of dataframes
# group_walk() → perform side-effect operations per group
# group_modify() → apply custom transformation per group
# window functions → lag(), lead(), ranking, cumulative ops
# dynamic grouping → .data[[var]]
# case_when() → group-wise conditional logic
# pivot_wider() → reshape grouped summaries
# multi-level aggregation → hierarchical summarisation


#===============================================================================
# END OF FILE
#===============================================================================