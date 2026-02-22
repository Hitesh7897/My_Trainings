#===============================================================================
# Chapter 29: Apply Family Functions in R (apply, lapply, sapply, vapply, tapply, mapply)
#===============================================================================
# This section demonstrates functional programming in R using the apply family.
#===============================================================================


###############################################
# apply()
###############################################
# Used on matrices or data frames
# Performs row-wise or column-wise operations

a <- matrix(1:5, nrow = 2)
apply(a, 2, sum)                 # Column-wise sum

data(mtcars)

apply(mtcars, 1, mean)           # Row-wise mean
apply(mtcars, 2, mean)           # Column-wise mean

mtcars[2, ]
mtcars[1:4, ]

apply(mtcars[, c("mpg", "cyl")], 2, mean)


###############################################
# lapply()
###############################################
# Always returns a LIST

sqr <- function(a) {
  a^2
}

lapply(1:10, sqr)

lapply(mtcars, sqr)


###############################################
# sapply()
###############################################
# Simplified version of lapply()
# Returns vector or matrix (if possible)

sapply(mtcars, function(x) x^2)


###############################################
# vapply()
###############################################
# Type-safe version of sapply()
# Explicit return type is mandatory

vapply(1:3, sqr, numeric(1))
vapply(mtcars$mpg, sqr, numeric(1))


###############################################
# tapply()
###############################################
# Group-wise aggregation
# Equivalent to SQL GROUP BY

tapply(mtcars$mpg, mtcars$cyl, mean)
# SELECT cyl, MEAN(mpg) GROUP BY cyl


###############################################
# mapply()
###############################################
# Multivariate apply (multiple inputs)

mapply(sum, 1:3, 4:6)


###############################################
# Anonymous / Lambda Functions
###############################################
# Functions without names, used inline

# apply(), lapply(), sapply(), vapply(), tapply(), mapply()


###############################################
# CLINICAL DATASETS (SDTM)
###############################################

dm <- read.csv(
  "https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/dm.csv"
)

ae <- read.csv(
  "https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/ae.csv"
)

lb <- read.csv(
  "https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/lb.csv"
)

vs <- read.csv(
  "https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/vs.csv"
)


###############################################
# apply() WITH CLINICAL DATA
###############################################
# Matrix-based calculations

# Column-wise mean
lb_matrix <- as.matrix(lb[, c("LBSTRESN")])
apply(lb_matrix, 2, mean, na.rm = TRUE)

# Row-wise mean
lb_matrix <- as.matrix(lb[, c("LBSTRESN", "LBORNRLO", "LBORNRHI")])
apply(lb_matrix, 1, mean, na.rm = TRUE)


###############################################
# lapply() WITH DOMAINS
###############################################
# Always returns list

nrow(dm)
nrow(ae)
nrow(lb)
nrow(vs)

count_domain <- list(
  DM = dm,
  AE = ae,
  LB = lb,
  VS = vs
)

lapply(count_domain, nrow)

length(unique(lb$USUBJID))


###############################################
# sapply() WITH CUSTOM FUNCTION
###############################################
# Simplified output

unique_subj <- function(a) {
  length(unique(a$USUBJID))
}

sapply(count_domain, unique_subj)

length(unique(dm$USUBJID))


###############################################
# vapply() – TYPE SAFE
###############################################
# Preferred for production / validation code

vapply(count_domain, unique_subj, numeric(1))

numeric(2)


###############################################
# tapply() – GROUP-WISE (CLINICAL)
###############################################

tapply(dm$AGE, dm$SEX, mean, na.rm = TRUE)


###############################################
# mapply() – REAL-WORLD EXAMPLE (BMI)
###############################################

bmi <- function(w, h) {
  w / (h / 100)^2
}

vs_HEIGHT <- vs[vs$VSTESTCD == "HEIGHT", "VSSTRESN"]
vs_WEIGHT <- vs[vs$VSTESTCD == "WEIGHT", "VSSTRESN"]

length(vs_HEIGHT)
length(vs_WEIGHT)

# FAIR principles: vectorized, reproducible computation
mapply(bmi, vs_WEIGHT, vs_HEIGHT)


###############################################
# KEY TAKEAWAYS
###############################################
# apply()  → matrix / data frame (rows, columns)
# lapply() → always returns list
# sapply() → simplified output
# vapply() → safest (type enforced)
# tapply() → group-wise aggregation
# mapply() → multiple inputs
# Apply family preferred over loops in R
# Critical for SDTM / ADaM workflows


###############################################
# END OF FILE
###############################################