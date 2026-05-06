#===============================================================================
# Chapter : Data Transformation with mutate(), case_when(), joins & nesting
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
glimpse(flights)


################################################################################
# CREATE VARIABLES → mutate()
################################################################################

# Create new variable

flights |> 
  mutate(
    total_delay = dep_delay + arr_delay,
    .keep = "used"
  )


################################################################################
# CONDITIONAL STATEMENTS → if_else()
################################################################################

# Create delay flag

flights |> 
  mutate(
    delay_flag = if_else(arr_delay > 0, "Delayed", "On Time"),
    .keep = "used"
  )


################################################################################
# MULTIPLE CONDITIONAL LOGIC → case_when()
################################################################################

# Categorize delays

flights |> 
  mutate(
    delay_type = case_when(
      arr_delay > 60  ~ "High Delay",
      arr_delay > 0   ~ "Low Delay",
      TRUE            ~ "On Time"
    ),
    .keep = "used"
  )


################################################################################
# MODIFY EXISTING VARIABLES
################################################################################

# Convert carrier to factor

flights |> 
  mutate(
    carrier = as.factor(carrier)
  ) |> 
  glimpse()


################################################################################
# DATA TYPE CONVERSION
################################################################################

flights |> 
  mutate(
    month = as.character(month),
    day = as.numeric(day)
  ) |> 
  glimpse()


################################################################################
# HANDLING MISSING VALUES
################################################################################

# Replace missing values using coalesce()

flights |> 
  mutate(
    arr_delay = coalesce(arr_delay, 0),
    .keep = "used"
  )

# Detect missing values

is.na(flights$arr_delay)


################################################################################
# STRING CONCATENATION
################################################################################

# Combine columns

flights |> 
  mutate(
    route = paste(origin, dest, sep = "-"),
    .keep = "used"
  )


################################################################################
# SPLIT COLUMNS → separate()
################################################################################

flights |> 
  select(time_hour) |> 
  separate(
    time_hour,
    into = c("date", "time"),
    sep = " "
  )


################################################################################
# BULK TRANSFORMATION → across()
################################################################################

flights |> 
  mutate(
    across(
      dep_delay:arr_delay,
      ~ replace_na(.x, 0)
    ),
    .keep = "used"
  )


################################################################################
# RECODING VALUES → recode()
################################################################################

flights |> 
  mutate(
    carrier = recode(
      carrier,
      "UA" = "United",
      "AA" = "American"
    ),
    .keep = "used"
  )


################################################################################
# case_match() → MODERN recode() ALTERNATIVE
################################################################################

flights |> 
  mutate(
    carrier_name = case_match(
      carrier,
      "UA" ~ "United",
      "AA" ~ "American",
      .default = "Other"
    ),
    .keep = "used"
  )


################################################################################
# CUSTOM COLUMN NAMES → .names
################################################################################

flights |> 
  mutate(
    across(
      dep_delay:arr_delay,
      mean,
      .names = "mean_{.col}"
    ),
    .keep = "used"
  ) |> 
  glimpse()


################################################################################
# if_any() and if_all()
################################################################################

# Rows where any delay column has NA

flights |> 
  filter(
    if_any(dep_delay:arr_delay, is.na)
  )

# Rows where all delay columns are positive

flights |> 
  filter(
    if_all(dep_delay:arr_delay, ~ .x > 0)
  )


################################################################################
# ROW-WISE OPERATIONS → rowwise()
################################################################################

flights |> 
  rowwise() |> 
  mutate(
    avg_delay = mean(c(dep_delay, arr_delay), na.rm = TRUE)
  ) |> 
  ungroup()


################################################################################
# WINDOW FUNCTIONS → cumsum()
################################################################################

flights |> 
  arrange(year, month, day) |> 
  mutate(
    cumulative_distance = cumsum(distance),
    .keep = "used"
  )


################################################################################
# row_number()
################################################################################

flights |> 
  group_by(carrier) |> 
  mutate(
    row_id = row_number()
  )


################################################################################
# JOINS → Excel VLOOKUP Equivalent
################################################################################

carrier_lookup <- tibble(
  carrier = c("UA", "AA"),
  type = c("Full Service", "Legacy")
)

flights |> 
  left_join(carrier_lookup, by = "carrier") |> 
  select(year, month, day, carrier, type)


################################################################################
# CHAINING DEFINITIONS (LAYERED MUTATIONS)
################################################################################

flights |> 
  mutate(
    delay = arr_delay > 0
  ) |> 
  mutate(
    delay_score = if_else(delay, arr_delay, 0)
  )

# Compact version

flights |> 
  mutate(
    delay = arr_delay > 0,
    delay_score = if_else(delay, arr_delay, 0),
    .keep = "used"
  )


################################################################################
# with() FUNCTION (BASE R)
################################################################################

with(flights, distance / air_time)


################################################################################
# NESTED DATA → list columns
################################################################################

nest_data <- flights |> 
  group_by(carrier) |> 
  summarise(
    data = list(cur_data())
  )

nest_data


################################################################################
# pick() INSIDE list columns
################################################################################

flights |> 
  group_by(carrier) |> 
  summarise(
    data = list(pick(year, month, day))
  )


################################################################################
# IMPORTS AND EXPORTS
################################################################################

# Read CSV
# read_csv("data.csv")

# Export CSV
# write_csv(flights, "flights.csv")

# Read Excel
# readxl::read_excel("file.xlsx")

# Export RDS
# saveRDS(flights, "flights.rds")

# Import RDS
# readRDS("flights.rds")


################################################################################
# KEY TAKEAWAYS
################################################################################

# mutate() → create or modify variables
# if_else() → binary conditional logic
# case_when() → multiple condition handling
# recode() / case_match() → value replacement
# across() → bulk column transformations
# if_any() / if_all() → row filtering across columns
# rowwise() → row-level calculations
# cumsum() → cumulative calculations
# left_join() → merge datasets like VLOOKUP
# nest() / list columns → store grouped dataframes
# .names → dynamic column naming
# with() → simplify column references
# separate() → split columns into multiple variables


#===============================================================================
# END OF FILE
#===============================================================================