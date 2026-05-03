#===============================================================================
# Chapter : Data Cleaning, Pattern Extraction, Nesting, and Mutation in dplyr/tidyr
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


################################################################################
# EXTRACT PATTERNS USING REGEX
################################################################################

flights |> 
  mutate(code = "AA123") |> 
  extract(
    code,
    into = c("carrier", "number"),
    regex = "([A-Z]+)([0-9])"
  ) |> 
  select(carrier, number)


################################################################################
# COMPLETE MISSING COMBINATIONS
################################################################################

df <- tibble(
  name = c("A", "AI", "Beth"),
  day = c(1, 3, 2),
  apples = c(2, 5, 3)
)

df

# Fill all missing combinations of name × day

df |> 
  complete(name, day = 1:3)


################################################################################
# FILL MISSING VALUES (FORWARD FILL)
################################################################################

df <- tibble(
  name = c("A", "AI", NA, "B", NA, "C", "D", NA, NA)
)

# Correct approach (sorted)

df |> 
  arrange(name) |> 
  fill(name, .direction = "down")

# Without sorting (may give incorrect logical order)

df |> 
  fill(name, .direction = "down")


################################################################################
# REPLACE MISSING VALUES
################################################################################

colSums(is.na(flights))

flights |> 
  mutate(dep_delay = replace_na(dep_delay, 0)) |> 
  select(dep_delay)


################################################################################
# NESTING AND UNNESTING DATA
################################################################################

# Create nested data (list-column)

nested <- flights |> 
  group_by(carrier) |> 
  nest()

# Modern syntax

nested <- flights |> nest(.by = "carrier")

nested

# Unnest back to flat structure

nested |> 
  unnest(cols = data)


################################################################################
# DATA TRANSFORMATION SUMMARY
################################################################################

# Columns → Rows        → pivot_longer()
# Rows → Columns        → pivot_wider()
# Split column          → separate()
# Combine columns       → unite()
# Regex extraction      → extract()
# Fill missing combos   → complete()
# Fill NA sequentially  → fill()
# Replace NA values     → replace_na()
# Nested structures     → nest() / unnest()


################################################################################
# MODIFYING DATA USING mutate()
################################################################################

#-------------------------------------------------------------------------------
# CREATE NEW COLUMNS
#-------------------------------------------------------------------------------

flights |> 
  mutate(
    gain  = arr_delay - dep_delay,
    speed = distance / air_time * 60,
    .keep = "none"
  )


#-------------------------------------------------------------------------------
# MODIFY EXISTING COLUMNS
#-------------------------------------------------------------------------------

flights |> 
  mutate(
    dep_delay = dep_delay / 60
  )


################################################################################
# CONDITIONAL TRANSFORMATIONS
################################################################################

#-------------------------------------------------------------------------------
# if_else()
#-------------------------------------------------------------------------------

flights |> 
  mutate(
    status = if_else(arr_delay > 0, "Delayed", "On time"),
    .keep = "none"
  )


#-------------------------------------------------------------------------------
# case_when()
#-------------------------------------------------------------------------------

flights |> 
  mutate(
    status = case_when(
      arr_delay <= 0   ~ "On-Time",
      arr_delay <= 60  ~ "Minor Delay",
      arr_delay <= 180 ~ "Moderate Delay",
      TRUE             ~ "Severe Delay"
    ),
    .keep = "none"
  )


################################################################################
# KEY TAKEAWAYS
################################################################################

# extract() → split values using regex
# complete() → generate all combinations
# fill() → propagate values (down/up)
# replace_na() → substitute missing values
# nest()/unnest() → hierarchical data handling
# mutate() → create/modify columns
# if_else() → simple conditional logic
# case_when() → multi-condition logic


#===============================================================================
# END OF FILE
#===============================================================================