#===============================================================================
# Chapter : Advanced Filtering, Mapping, String Handling and Helpers in dplyr
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
View(flights)

################################################################################
# DESTINATION → REGION MAPPING (LOOKUP TABLE)
################################################################################

# Create airport region lookup table (sample shown)

airport_regions <- tribble(
  ~Airport_Code, ~City, ~State_Territory, ~Region,
  "BOS", "Boston", "Massachusetts", "Northeast",
  "ATL", "Atlanta", "Georgia", "South",
  "LAX", "Los Angeles", "California", "West"
)

# Convert to named vector
region <- airport_regions |> 
  select(Airport_Code, Region) |> 
  deframe()

# Map region to flights dataset
flights |> 
  mutate(region = region[dest]) |> 
  select(dest, region)

################################################################################
# CUSTOM CATEGORIZATION USING CASE_WHEN
################################################################################

# Categorize destinations by geography and religion (example)

flights |> 
  select(carrier, flight, dest) |> 
  mutate(
    category = case_when(
      dest %in% c("BQN", "SJU", "PSE") ~ "Puerto Rico (US Territory)",
      dest == "STT" ~ "US Virgin Islands (US Territory)",
      TRUE ~ "United States (Mainland)"
    ),
    religion = case_when(
      category == "United States (Mainland)" ~ "Christianity (majority, diverse)",
      category == "US Virgin Islands (US Territory)" ~ "Christianity (Protestant majority)",
      category == "Puerto Rico (US Territory)" ~ "Christianity (Roman Catholic majority)"
    )
  )

################################################################################
# FLOATING POINT COMPARISON (near)
################################################################################

# Direct comparison may fail due to precision
2.0002 == 2

x <- sqrt(2)^2
x == 2        # FALSE

# Use near() for safe comparison
near(x, 2)

# Example usage
weather |> 
  select(origin, temp, dewp) |> 
  filter(near(dewp, 28))

################################################################################
# GROUP SIZE USING cur_data() AND pick()
################################################################################

# Legacy approach
flights |> 
  group_by(dest) |> 
  filter(nrow(cur_data()) <= 2)

# Using pick()
flights |> 
  group_by(dest) |> 
  filter(nrow(pick(everything())) <= 2) |> 
  select(dest, year, month, day, carrier, flight)

# Recommended approach
flights |> 
  group_by(dest) |> 
  filter(n() <= 2) |> 
  select(dest, year, month, day, carrier, flight)

################################################################################
# USING pick() FOR MULTI-COLUMN OPERATIONS
################################################################################

flights |> 
  group_by(dest) |> 
  mutate(total_delay = sum(pick(c(arr_delay, dep_delay)), na.rm = TRUE)) |> 
  select(dest, total_delay)

################################################################################
# STRING FILTERING (EXACT AND PATTERN MATCH)
################################################################################

# Exact match
flights |> 
  filter(dest == "SEA") |> 
  select(carrier, dest, origin)

# Using %in%
flights |> 
  filter(dest %in% "SEA") |> 
  select(carrier, dest, origin)

################################################################################
# PARTIAL MATCH (REGEX)
################################################################################

# Detect pattern "OR"
flights |> 
  filter(str_detect(dest, "OR")) |> 
  distinct(dest)

################################################################################
# POSITIONAL STRING MATCH
################################################################################

# Starts with "A"
flights |> 
  filter(str_starts(dest, "A")) |> 
  distinct(dest)

# Ends with "A"
flights |> 
  filter(str_ends(dest, "A")) |> 
  distinct(dest)

################################################################################
# MULTIPLE STRING MATCHES
################################################################################

# Exact values
flights |> 
  filter(dest %in% c("SEA", "SFO", "PDX")) |> 
  distinct(dest)

# Regex pattern
flights |> 
  filter(str_detect(dest, "SEA|SFO|PDX")) |> 
  distinct(dest)

################################################################################
# CASE-INSENSITIVE MATCHING
################################################################################

# Using tolower()
flights |> 
  filter(tolower(dest) == "sea")

# Using stringr
flights |> 
  filter(str_detect(dest, regex("sea", ignore_case = TRUE)))

################################################################################
# NEGATIVE MATCH (EXCLUDE PATTERNS)
################################################################################

flights |> 
  filter(!str_detect(dest, "SEA|SFO|PDX")) |> 
  distinct(dest)

################################################################################
# OTHER USEFUL NOTES
################################################################################

# near()        → Safe numeric comparison
# n()           → Group size
# pick()        → Select columns inside verbs
# str_detect()  → Pattern matching
# str_starts()  → Prefix matching
# str_ends()    → Suffix matching
# regex()       → Advanced pattern matching

################################################################################
# SAS VS DPLYR ANALOGY
################################################################################

# SAS              → dplyr equivalent
# %MACRO           → function()
# PROC SORT        → arrange()
# PROC MEANS       → summarise()
# DATA STEP        → mutate(), filter(), tibble()

#===============================================================================
# END OF FILE
#===============================================================================