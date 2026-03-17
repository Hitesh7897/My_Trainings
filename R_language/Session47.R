#===============================================================================
# Chapter : Logical Operations, across() Conditions and Real Dataset Filtering
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)

################################################################################
# PRACTICE DATASET (SALES)
################################################################################

sales <- tibble(
  item   = c("apple", "banna", "cherry"),
  price  = c(20, 150, 15),
  price1 = c(20, 11, 15)
)

sales

################################################################################
# ADVANCED across() WITH LOGICAL OPERATIONS
################################################################################

sales |> 
  mutate(
    is_expensive = across(c(price, price1), ~ .x > 100),
    
    total  = rowSums(across(c(price, price1))),
    total1 = rowSums(across(c(price, price1), ~ .x > 162)),
    total2 = rowSums(across(c(price, price1), ~ .x > 150)),   # observe
    total3 = rowSums(across(c(price, price1), ~ .x >= 20)),
    total4 = rowSums(across(c(price, price1), ~ .x * 20)),    # observe
    total5 = rowSums(across(c(price, price1), ~ .x > 149)),
    
    # Logical aggregation (TRUE/FALSE result)
    total15 = rowSums(across(c(price, price1), ~ .x > 14)) > 1
  ) |> 
  filter(rowSums(across(c(price, price1), ~ .x >= 20)) > 1)

# Alternative
# filter(total3 > 1)

################################################################################
# LOGICAL TO NUMERIC BEHAVIOR
################################################################################

a <- TRUE
as.integer(a)

a <- FALSE
as.integer(a)

# Logical arithmetic
FALSE + FALSE
FALSE + TRUE
TRUE + TRUE

################################################################################
# REAL DATASET (CLINICAL - DM DOMAIN)
################################################################################

# Load dataset
dm <- read_csv("C:\\Users\\ganes\\Downloads\\dm.csv")

# Inspect structure
glimpse(dm)

################################################################################
# FILTERING CLINICAL DATA
################################################################################

# Valid SEX, selected treatments, age >= 18
dm |> 
  filter(!is.na(SEX)) |> 
  filter(ARM %in% c("Treatment 3", "Treatment 2") & AGE >= 18) |>
  select(STUDYID, USUBJID, ARM, AGE, SEX, RACE) |>
  arrange(ARM, USUBJID) |> 
  slice_head(n = 10)

################################################################################
# CREATE FILTERED DATASET
################################################################################

adult_dm <- dm |>
  filter(AGE >= 18, ARM != "Screen Failure")

# Quick view
dm |> 
  filter(AGE >= 18, ARM != "Screen Failure") |> 
  select(SUBJID, AGE, ARM)

################################################################################
# FLIGHTS EXAMPLE (LOGICAL FILTER USING across)
################################################################################

# Flights where either dep_delay OR arr_delay > 80 minutes
flights |>  
  select(carrier, dep_delay, arr_delay) |> 
  filter(rowSums(across(c(dep_delay, arr_delay), ~ .x > 80), 
                 na.rm = TRUE) >= 1)

################################################################################
# SUMMARY
################################################################################

# across()        → Apply condition across multiple columns
# ~ (formula)     → Anonymous function
# .x              → Current column value
# rowSums()       → Count TRUE/FALSE or sum values row-wise
# TRUE = 1, FALSE = 0
# filter()        → Subset data
# %in%            → Match multiple values
# arrange()       → Sort data
# slice_head()    → Top N rows

#===============================================================================
# END OF FILE
#===============================================================================