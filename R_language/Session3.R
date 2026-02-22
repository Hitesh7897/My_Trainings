#===============================================================================
# Chapter: Packages, Working Directory, Data, and Workspace Management in R
#===============================================================================

###############################################
# 1. VIEWING AVAILABLE & INSTALLED PACKAGES
###############################################

# View all packages available on CRAN (Comprehensive R Archive Network)
View(available.packages())

# View packages installed in your system
View(installed.packages())

###############################################
# 2. LOADING PACKAGES
###############################################

# Load tidyverse
library(tidyverse) # This will throw an error if the package is not installed

require(tidyverse) # This will inherently install the package if not installed

###############################################
# 3. INSTALLING & MANAGING PACKAGES USING pacman
###############################################

# Install pacman (only once)
install.packages("pacman")

# Load pacman
library(pacman)
require(pacman)

# Install & Load multiple packages at once
p_load("tidyverse", "boot", "bit", "askpass")

###############################################
# 4. LIBRARY PATHS
###############################################

# Show library paths (where packages are stored)
.libPaths()

###############################################
# 5. WORKING DIRECTORY
###############################################

# Get current working directory
getwd()

# Set working directory
setwd("/home/hitesh/Documents/GitHub/My_Trainings/R_language")

###############################################
# 6. BASIC OBJECT STRUCTURE
###############################################

a <- "Hitesh"
str(a) # chr "Hitesh"

###############################################
# 7. DATA FRAME CREATION & INSPECTION
###############################################

student <- data.frame(
  student_id = c(1, 2),
  student_name = c("Hitesh", "Harsha"),
  student_age = c(46, 35)
)

# Structure
str(student)
# 'data.frame':	2 obs. of  3 variables:
#   $ student_id  : num  1 2
# $ student_name: chr  "Hitesh" "Harsha"
# $ student_age : num  46 35

# Statistical summary
summary(student)
# student_id   student_name        student_age   
# Min.   :1.00   Length:2           Min.   :35.00  
# 1st Qu.:1.25   Class :character   1st Qu.:37.75  
# Median :1.50   Mode  :character   Median :40.50  
# Mean   :1.50                      Mean   :40.50  
# 3rd Qu.:1.75                      3rd Qu.:43.25  
# Max.   :2.00                      Max.   :46.00  

# Tidyverse glimpse
glimpse(student)
# Rows: 2
# Columns: 3
# $ student_id   <dbl> 1, 2
# $ student_name <chr> "Hitesh", "Harsha"
# $ student_age  <dbl> 46, 35

###############################################
# 8. BUILT-IN DATASETS
###############################################

# List all available datasets
data()

# View specific dataset (example: aids if available)
View(aids)

# Create a copy
aids_1 <- aids

###############################################
# 9. WRITING FILES (EXPORTING DATA)
###############################################

# Write Excel file (requires writexl package)
install.packages("writexl")
library(writexl)

write_xlsx(
  aids,
  path = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/aids.xlsx"
)

###############################################
# 10. R ENVIRONMENT & SEARCH PATH
###############################################

# Show attached packages and environment
search()

###############################################
# 11. R OPTIONS & HELP
###############################################

help("options")
options()

###############################################
# 12. COMMAND HISTORY
###############################################

# Show command history
history(max.show = Inf)

# Save history to file
savehistory(file = "Hit.txt")

###############################################
# 13. SAVE WORKSPACE IMAGE
###############################################

# Save entire R session
save.image()

###############################################
# 14. OBJECT MANAGEMENT
###############################################

# List objects in environment
ls()

# Keep only object x
x <- "a"
rm(list = setdiff(ls(), "x"))

# Reassign
x <- "b"

###############################################
# 15. FILE PATHS IN R
###############################################

# Windows path (Incorrect - escape error)
# "/home/hitesh/Documents/GitHub/My_Trainings/R_language/"

# Correct using double backslashes
"\\home\\hitesh\\Documents\\GitHub\\My_Trainings\\R_language\\"

# Recommended forward slash (best practice)
"/home/hitesh/Documents/GitHub/My_Trainings/R_language/"

###############################################
# END OF FILE
###############################################

# Key Concepts:
# - View installed/available packages
# - Install & load using library() or pacman
# - Understand working directory
# - Use str(), summary(), glimpse() for data inspection
# - Export data using write_xlsx()
# - Manage workspace using ls(), rm(), save.image()
# - Handle Windows paths properly