#===============================================================================
# Chapter 27: Control Flow – if, ifelse, switch, case_when, loops
#===============================================================================

library(tidyverse)

################################################################################
# IF – ELSE IF – ELSE
################################################################################

num <- 80  # check if equal to 10, 50, 80, 100

if (num == 10) {
  print("This is equal to 10")
} else if (num == 50) {
  print("This is equal to 50")
} else if (num == 100) {
  print("This is equal to 100")
} else if (num == 80) {
  print("This is equal to 80")
} else {
  print("This number is not equal to 10, 50, 80, or 100")
}


################################################################################
# GRADE CALCULATION USING IF – ELSE
################################################################################
# A   -> >85  & <=100
# B+  -> >60  & <=85
# B   -> >40  & <=60
# C   -> >30  & <=40
# Fail-> <=30

marks <- as.integer(readline("Enter the marks: "))

if (marks > 85 & marks <= 100) {
  print("Grade A")
} else if (marks > 60 & marks <= 85) {
  print("Grade B+")
} else if (marks > 40 & marks <= 60) {
  print("Grade B")
} else if (marks > 30 & marks <= 40) {
  print("Grade C")
} else {
  print("Fail")
}


################################################################################
# IFELSE (VECTORISED – ELEMENT WISE)
################################################################################

x <- c(1, 3, 4, 5, 6, 7, 8, 9, NA)
ifelse(x > 0, "Positive", "Negative")
# Note: ifelse works element-wise and handles vectors


################################################################################
# SWITCH STATEMENT
################################################################################

# 1️⃣ SWITCH USING INDEX
x <- 3
y <- switch(x, "a", "b", "c", "d")
y

# 2️⃣ SWITCH USING CHARACTER MATCH
x <- "x"
y <- switch(
  x,
  "x" = "Option A",
  "y" = "Option B",
  "z" = "Option C",
  "Invalid Option"
)
y


################################################################################
# ❌ WHY SWITCH IS NOT IDEAL FOR RANGE CONDITIONS
################################################################################
# The following looks logical but is WRONG usage of switch
# switch() does NOT evaluate conditions

marks <- 90

# ❌ NOT RECOMMENDED
y <- switch(
  TRUE,
  (marks > 85 & marks <= 100) = "Grade A",
  (marks > 60 & marks <= 85)  = "Grade B+",
  (marks > 40 & marks <= 60)  = "Grade B",
  (marks > 30 & marks <= 40)  = "Grade C",
  "Fail"
)
y


################################################################################
# CASE_WHEN (BEST PRACTICE FOR RANGE CONDITIONS)
################################################################################

marks <- 40

grade <- case_when(
  marks > 85 & marks <= 100 ~ "Grade A",
  marks > 60 & marks <= 85  ~ "Grade B+",
  marks > 40 & marks <= 60  ~ "Grade B",
  marks > 30 & marks <= 40  ~ "Grade C",
  TRUE                      ~ "Fail"
)
grade


################################################################################
# FOR LOOP
################################################################################

# Simple loop
for (i in 1:10) {
  print(i)
}

# Loop over vector
v <- c("a", "b", "c", 1, "10")
for (i in v) {
  print(i)
}

# Loop over list
v1 <- list("a", "b", "c", 1, "10", v)
for (i in v1) {
  print(i)
}

# Loop over matrix
n <- matrix(c("a","b","c","d","e","f"), nrow = 2, byrow = TRUE)
for (i in 1:nrow(n)) {
  for (j in 1:ncol(n)) {
    print(paste("Row", i, "Col", j, "=", n[i, j]))
  }
}


################################################################################
# ITERATING OVER STRING
################################################################################

x <- "hitesh"

# Character-wise extraction
for (i in 1:nchar(x)) {
  print(substr(x, i, i))
}


################################################################################
# FILE PROCESSING LOOP (REAL WORLD)
################################################################################

files <- c("ae.csv", "dm.csv", "ec.csv")

for (f in files) {
  cat("Reading file:", f, "\n")
  # df <- read.csv(f)   # Uncomment when files exist
}


################################################################################
# NESTED LOOP – MULTIPLICATION TABLE
################################################################################

for (i in 1:10) {
  for (j in 1:10) {
    print(paste(i, "X", j, "=", i * j))
  }
}


################################################################################
# SUMMARY NOTES
################################################################################
# if / else       -> single condition logic
# ifelse()        -> vectorised conditional
# switch()        -> exact match (NOT ranges)
# case_when()     -> professional alternative for complex rules
# for loop        -> known iterations
# nested loop     -> tables, matrices
################################################################################