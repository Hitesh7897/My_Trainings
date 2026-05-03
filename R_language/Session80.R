#===============================================================================
# Chapter : Functions with dplyr (across, select, filter, summarise, mutate)
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


################################################################################
# DATA PREVIEW
################################################################################

flights            # prints dataset
View(flights)      # opens viewer


################################################################################
# FUNCTION + across() → COLUMN-WISE TRANSFORMATION
################################################################################

# Normalize using Z-score

normalize <- function(x) {
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}

flights |> 
  mutate(
    across(c(dep_delay, arr_delay), normalize),
    .keep = "used"
  )

# Equivalent:
# normalize(flights$dep_delay)
# normalize(flights$arr_delay)


################################################################################
# FUNCTION + select() → COLUMN FILTERING
################################################################################

# Keep columns with <10% missing values

high_na <- function(x) {
  mean(is.na(x)) < 0.1
}

flights |> 
  select(where(high_na))

# Example checks
mean(is.na(flights$year))
mean(is.na(flights$dep_time)) < 0.1


################################################################################
# FUNCTION + filter() → ROW FILTERING
################################################################################

is_extreme_delay <- function(x) {
  x > 120
}

flights |> 
  filter(is_extreme_delay(dep_delay)) |> 
  select(flight, dep_delay)


################################################################################
# FUNCTION + summarise() (MULTIPLE OUTPUTS)
################################################################################

delay_summary <- function(x) {
  tibble(
    avg = mean(x, na.rm = TRUE),
    med = median(x, na.rm = TRUE),
    max = max(x, na.rm = TRUE),
    min = min(x, na.rm = TRUE)
  )
}

flights |> 
  group_by(carrier) |> 
  summarise(delay_summary(arr_delay))

# Equivalent explicit approach

flights |> 
  group_by(carrier) |> 
  summarise(
    avg = mean(arr_delay, na.rm = TRUE),
    med = median(arr_delay, na.rm = TRUE),
    max = max(arr_delay, na.rm = TRUE),
    min = min(arr_delay, na.rm = TRUE)
  )


################################################################################
# FUNCTION RETURNING SINGLE VALUE
################################################################################

safe_mean <- function(x) {
  if (all(is.na(x))) return(NA)
  mean(x, na.rm = TRUE)
}

flights |> 
  group_by(carrier) |> 
  summarise(avg_delay = safe_mean(arr_delay))


################################################################################
# FUNCTION WITH PARAMETERS
################################################################################

delay_flag <- function(x, threshold = 30) {
  x > threshold
}

flights |> 
  mutate(
    late = delay_flag(arr_delay, 45),
    .keep = "used"
  )


################################################################################
# FUNCTION INSIDE case_when()
################################################################################

is_weekend <- function(x) {
  x %in% c(6, 7)
}

flights |> 
  mutate(
    weekend_flag = case_when(
      is_weekend(day) ~ "Weekend",
      TRUE            ~ "Weekday"
    ),
    .keep = "used"
  )


################################################################################
# ANONYMOUS FUNCTIONS
################################################################################

flights |> 
  mutate(
    across(dep_delay:arr_delay, ~ .x / 60),
    .keep = "used"
  )


################################################################################
# FUNCTION + arrange()
################################################################################

delay_score <- function(dep, arr) {
  dep + arr   # total delay
}

flights |> 
  arrange(delay_score(dep_delay, arr_delay)) |> 
  select(dep_delay, arr_delay)


################################################################################
# FUNCTION + mutate() + PIPELINE ANALYSIS
################################################################################

flights |> 
  mutate(
    total = delay_score(dep_delay, arr_delay),
    .keep = "used"
  ) |> 
  arrange(total) |> 
  filter(!is.na(total)) |> 
  head(100)


################################################################################
# KEY TAKEAWAYS
################################################################################

# across() + function → apply transformation to multiple columns
# where() + function → select columns based on condition
# custom functions → reusable logic in pipelines
# summarise() → functions can return multiple outputs (tibble)
# parameterized functions → flexible transformations
# anonymous functions (~) → quick inline logic
# functions in arrange() → custom sorting logic
# always handle NA safely in custom functions


#===============================================================================
# END OF FILE
#===============================================================================