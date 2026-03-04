#===============================================================================
# Chapter 36 : Introduction to tidyverse, dplyr & nycflights13 Dataset
#===============================================================================


################################################################################
# PACKAGE INSTALLATION & LOADING
################################################################################

# Install tidyverse (only once)
install.packages("tidyverse")

# Load tidyverse (collection of data science packages)
library(tidyverse)

# Load dplyr explicitly (data manipulation package)
library(dplyr)

# Load sample dataset package
library(nycflights13)



################################################################################
# INTRODUCTION TO nycflights13 DATA
################################################################################
# nycflights13 contains real flight data from New York in 2013.
# It includes multiple related datasets (tibbles).

flights
airports
airlines
planes
weather



################################################################################
# VIEWING DATA
################################################################################

# Open spreadsheet-style viewer (RStudio only)
View(flights)

# Print dataset
flights



################################################################################
# BASIC STRUCTURE INSPECTION
################################################################################

# Dimensions (rows × columns)
dim(flights)

# Number of rows
nrow(flights)

# Number of columns
ncol(flights)

# Object type
class(flights)

# Base R structure (technical view)
str(flights)

# Tidyverse-friendly structure view
glimpse(flights)



################################################################################
# WHAT IS A DATA FRAME VS TIBBLE?
################################################################################

# flights is NOT a base data.frame
# It is a tibble (modern version of data.frame)

class(flights)

# Key Differences:

# 1) Printing Behavior
# data.frame → Prints entire dataset
# tibble     → Prints only first 10 rows and all columns that fit screen

# 2) Data Types
# data.frame → Converts characters to factors (older behavior)
# tibble     → Keeps character as character

# 3) Subsetting
# data.frame → Partial name matching allowed
# tibble     → Strict column name matching

# 4) Column Names
# tibble allows non-syntactic names more safely

# Convert tibble to data.frame
df_base <- as.data.frame(flights)

# Convert data.frame to tibble
df_tibble <- as_tibble(df_base)



################################################################################
# SUMMARY
################################################################################

# tidyverse → Collection of packages for data science
# dplyr     → Data manipulation
# nycflights13 → Example relational datasets
# tibble    → Modern data.frame
# glimpse() → Better alternative to str()
# dim(), nrow(), ncol() → Structure checks


#===============================================================================
# END OF FILE
#===============================================================================