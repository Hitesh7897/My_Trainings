#===============================================================================
# Chapter 26: String Operations + Control Flow
#===============================================================================

library(tidyverse)

################################################################################
# STRING SPLITTING
################################################################################

x <- "hitesh,swetha,jyothi,sarang"

# Using base R
a <- strsplit(x, ",")
a
typeof(a)                 # list
vec_obj <- a[[1]]         # extract vector
vec_obj                   # vector
typeof(vec_obj)           # character

# Convert list to vector explicitly
as.vector(a, mode = "character")

# Using stringr
str_split(x, pattern = ",")       # returns list
str_split_1(x, pattern = ",")     # returns character vector


################################################################################
# STRING COMPARISON
################################################################################

"abc" == "ABC"        # FALSE (case-sensitive)
"ABC" == "ABC"        # TRUE

identical("abc", "ABC")  # FALSE
identical("ABC", "ABC")  # TRUE


################################################################################
# STRING SORTING
################################################################################

x <- c("hitesh", "swetha", "jyothi", "sarang", "ganesh", "", NA)

# Base R sorting
sort(x)               

# stringr sorting
str_sort(x)        # NA appears last

# Check missing values
is.na(x)


################################################################################
# CONTROL FLOW
################################################################################

################################################################################
# IF STATEMENT
################################################################################

if (TRUE) {
  print("XXXXXXX")
}

num <- as.integer(readline("Enter the number: "))
if (num %% 2 == 0) {
  print("This is an even number")
}

# Largest among three numbers
a <- 2
b <- 5
c <- 10

if (a > b) {
  print("a is largest")
}
if (b > c) {
  print("b is largest")
}
if (c > a) {
  print("c is largest")
}

# Multiple condition
if ((a > b) & (b > c)) {
  print("a is the largest")
}

# Without if (using vectorized logic)
var <- c(a = a, b = b, c = c)
var
paste(names(var)[which.max(var)], "is greater than all")


################################################################################
# IF - ELSE STATEMENT
################################################################################

age <- 45
if (age > 18) {
  cat("You are an adult\n")
} else {
  cat("You are a teen\n")
}

# Even or odd
num <- as.integer(readline("Enter the number: "))
if (num %% 2 == 0) {
  print("This is an even number")
} else {
  print("This number is odd")
}


################################################################################
# IF - ELSE IF - ELSE STATEMENT
################################################################################

num <- 80

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
# SWITCH STATEMENT
################################################################################

choice <- "2"

result <- switch(
  choice,
  "1" = "Option One Selected",
  "2" = "Option Two Selected",
  "3" = "Option Three Selected",
  "Invalid Choice"
)

print(result)


################################################################################
# ITERATION STATEMENTS
################################################################################

################################################################################
# FOR LOOP
################################################################################

names_vec <- c("Ganesh", "Hitesh", "Swetha", "Jyothi")

for (name in names_vec) {
  print(name)
}

# Print multiplication table
for (i in 1:5) {
  for (j in 1:3) {
    print(paste(i, "X", j, "=", i * j))
  }
}


################################################################################
# WHILE LOOP
################################################################################

i <- 1
while (i <= 5) {
  print(i)
  i <- i + 1
}


################################################################################
# REPEAT LOOP
################################################################################

counter <- 1
repeat {
  print(counter)
  counter <- counter + 1
  if (counter > 5) {
     break
  }
}


################################################################################
# TRANSFER STATEMENTS
################################################################################

################################################################################
# BREAK
################################################################################

for (i in 1:10) {
  if (i == 5) {
    break
  }
  print(i)
}

################################################################################
# NEXT
################################################################################

for (i in 1:10) {
  if (i == 3) {
    next
  }
  print(i)
}


################################################################################
# NOTES
################################################################################
# if / else     -> decision making
# for           -> known iterations
# while         -> unknown iterations
# repeat        -> infinite until break
# break         -> exit loop
# next          -> skip iteration
# str_split_1() -> list → vector (very useful)
################################################################################