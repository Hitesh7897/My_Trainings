#===============================================================================
# Chapter : Functional Programming with dplyr + Tidy Evaluation
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)


################################################################################
# LOAD DATASET
################################################################################

data("flights")


################################################################################
# DATA PREVIEW
################################################################################

flights
View(flights)


################################################################################
# FUNCTION RETURNING DATAFRAME
################################################################################

# Top N delays for each carrier

top_n_delay <- function(df, n = 3) {
  df |> 
    arrange(desc(arr_delay)) |> 
    slice_head(n = n)
}

flights |> 
  group_by(carrier) |> 
  group_modify(~ top_n_delay(.x))


################################################################################
# SIMPLE SUMMARY FUNCTION
################################################################################

flights |> 
  group_by(carrier) |> 
  summarise(
    avg = mean(arr_delay, na.rm = TRUE)
  )


################################################################################
# TIDY EVALUATION USING {{}}
################################################################################

# Dynamic grouping + dynamic value column

multi_mean <- function(data, group_col, val_col) {
  data |> 
    group_by({{ group_col }}) |> 
    summarise(
      avg = mean({{ val_col }}, na.rm = TRUE)
    )
}

multi_mean(flights, carrier, arr_delay)


################################################################################
# MULTIPLE GROUPING VARIABLES (ASSIGNMENT IDEA)
################################################################################

# Example:
# multi_mean(data, c(carrier, origin), arr_delay)

# Practice:
# Modify the function to accept multiple grouping columns


################################################################################
# VARIABLE ARGUMENTS (...)
################################################################################

# Calculate mean for multiple columns

multi_mean <- function(data, ...) {
  data |> 
    summarise(
      across(
        c(...),
        ~ mean(.x, na.rm = TRUE)
      )
    )
}

multi_mean(flights, dep_delay, arr_delay)

# flights     → dataframe
# dep_delay   → dataframe column
# arr_delay   → dataframe column


################################################################################
# CUSTOM CLEANING FUNCTION
################################################################################

# Replace NA with 0

clean_delay <- function(x) {
  ifelse(is.na(x), 0, x)
}


################################################################################
# CUSTOM CATEGORIZATION FUNCTION
################################################################################

# Categorize delays

categorize_delay <- function(x) {
  ifelse(x > 60, "High", "Low")
}

flights |> 
  mutate(
    dep_delay = clean_delay(dep_delay),
    delay_type = categorize_delay(dep_delay),
    .keep = "used"
  )


################################################################################
# MULTIPLE CUSTOM FUNCTIONS IN PIPELINE
################################################################################

# Speed calculation

calc_speed <- function(distance, air_time) {
  distance / (air_time / 60)
}


################################################################################
# DELAY FLAG FUNCTION
################################################################################

delay_flag <- function(arr_delay, threshold = 30) {
  arr_delay > threshold
}


################################################################################
# SAFE MEAN FUNCTION
################################################################################

safe_mean <- function(x) {
  if (all(is.na(x))) return(NA)
  
  mean(x, na.rm = TRUE)
}


################################################################################
# COMPLETE PIPELINE FUNCTION
################################################################################

delay_pipeline <- function(data, threshold = 30) {
  
  data |> 
    mutate(
      speed = calc_speed(distance, air_time),
      delay_flag = delay_flag(arr_delay, threshold)
    ) |> 
    group_by(carrier) |> 
    summarise(
      avg_delay = safe_mean(arr_delay),
      avg_speed = safe_mean(speed)
    )
}

delay_pipeline(flights)


################################################################################
# FUNCTION + mutate()
################################################################################

flights |> 
  mutate(
    speed = calc_speed(distance, air_time),
    .keep = "used"
  )


################################################################################
# FUNCTION + filter()
################################################################################

flights |> 
  filter(
    delay_flag(arr_delay, 60)
  ) |> 
  select(carrier, arr_delay)


################################################################################
# FUNCTION + summarise()
################################################################################

flights |> 
  summarise(
    avg_dep_delay = safe_mean(dep_delay),
    avg_arr_delay = safe_mean(arr_delay)
  )


################################################################################
# KEY TAKEAWAYS
################################################################################

# group_modify() → apply function to grouped dataframes
# {{ }} → tidy evaluation for dynamic column names
# ... → pass multiple columns dynamically
# custom functions → reusable logic
# mutate() + functions → create derived variables
# summarise() + functions → reusable summaries
# safe_mean() → handles NA safely
# pipelines → combine multiple reusable functions
# functional programming → improves readability + reusability


#===============================================================================
# END OF FILE
#===============================================================================