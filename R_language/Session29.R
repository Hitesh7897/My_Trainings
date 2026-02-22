#===============================================================================
# Chapter 28: Control Flow, Loops & Apply Family Functions in R
#===============================================================================
# Topics Covered
# --------------
# 1. for, while, repeat loops
# 2. Nested loops
# 3. Transfer statements (break, next)
# 4. apply() family overview
# 5. apply(), lapply(), sapply(), vapply()
# 6. tapply() & mapply()
# 7. Practical SDTM-style use cases
#===============================================================================


#===============================================================================
# PRACTICE PLATFORMS
#===============================================================================
# https://leetcode.com
# https://www.hackerrank.com


#===============================================================================
# NESTED LOOPS
#===============================================================================
# Multiplication table using nested loops

for (i in 1:10) {
  for (j in 1:10) {
    print(paste(i, "X", j, "=", i * j))
  }
}


# Parent–Child loop demonstration
for (i in 1:10) {
  print(paste("Parent Loop", i))
  for (j in 1:10) {
    Sys.sleep(2)
    print(paste("Child Loop", i))
  }
}


#===============================================================================
# FOR LOOP
#===============================================================================

for (i in 1:10) {
  print(i)
}


#===============================================================================
# WHILE LOOP
#===============================================================================

i <- 1
while (i <= 10) {
  print(i)
  i <- i + 1
}


# Example: Account balance simulation
acc_bal <- 2000
tran    <- 100
flag    <- 1

while (acc_bal > 0) {
  acc_bal <- acc_bal - tran
  flag <- flag + 1
  print(flag)
  
  if (flag == 5) {
    break
  }
  
  print(acc_bal)
}


#===============================================================================
# REPEAT LOOP
#===============================================================================

i <- 1
repeat {
  Sys.sleep(1)
  
  if (i == 10) {
    print("break")
    break
  }
  
  if (i == 5) {
    i <- i + 1
    next
  }
  
  print(i)
  i <- i + 1
}


#===============================================================================
# TRANSFER STATEMENTS
#===============================================================================
# break → exit loop
# next  → skip current iteration


#===============================================================================
# APPLY FAMILY FUNCTIONS
#===============================================================================

# apply() → works on matrix / data frame
a <- matrix(1:5, nrow = 2)
apply(a, 2, sum)


# Built-in dataset
data(mtcars)

apply(mtcars, 1, mean)   # row-wise
apply(mtcars, 2, mean)   # column-wise

apply(mtcars[, c("mpg", "cyl")], 2, mean)


#===============================================================================
# lapply()
#===============================================================================
# Always returns a LIST

sqr <- function(x) {
  x^2
}

lapply(1:10, sqr)
lapply(mtcars, sqr)


#===============================================================================
# sapply()
#===============================================================================
# Simplified output (vector or matrix)

sapply(mtcars, function(x) x^2)


#===============================================================================
# vapply()
#===============================================================================
# Safer version of sapply()

vapply(1:3, sqr, numeric(1))
vapply(mtcars$mpg, sqr, numeric(1))


#===============================================================================
# tapply()
#===============================================================================
# Group-wise operations

tapply(mtcars$mpg, mtcars$cyl, mean)
# Equivalent to SQL:
# SELECT cyl, MEAN(mpg) GROUP BY cyl


#===============================================================================
# mapply()
#===============================================================================
# Multivariate apply

mapply(sum, 1:3, 4:6)


#===============================================================================
# CLINICAL DATASETS (SDTM)
#===============================================================================

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


#===============================================================================
# apply() WITH CLINICAL DATA
#===============================================================================

# Column-wise mean
lb_matrix <- as.matrix(lb[, c("LBSTRESN")])
apply(lb_matrix, 2, mean, na.rm = TRUE)

# Row-wise mean
lb_matrix <- as.matrix(lb[, c("LBSTRESN", "LBORNRLO", "LBORNRHI")])
apply(lb_matrix, 1, mean, na.rm = TRUE)


#===============================================================================
# lapply() WITH DOMAINS
#===============================================================================

count_domain <- list(
  DM = dm,
  AE = ae,
  LB = lb,
  VS = vs
)

lapply(count_domain, nrow)


#===============================================================================
# sapply() WITH CUSTOM FUNCTION
#===============================================================================

unique_subj <- function(df) {
  length(unique(df$USUBJID))
}

sapply(count_domain, unique_subj)


#===============================================================================
# KEY INTERVIEW TAKEAWAYS
#===============================================================================
# ✔ for → known iterations
# ✔ while → condition-based loop
# ✔ repeat → infinite loop with break
# ✔ break / next → control execution
# ✔ apply() → row / column operations
# ✔ lapply() → always returns list
# ✔ sapply() → simplified output
# ✔ vapply() → safest for production
# ✔ tapply() → group-wise aggregation
# ✔ mapply() → multivariate iteration
# ✔ Apply family preferred over loops in R


#===============================================================================
# END OF FILE
#===============================================================================