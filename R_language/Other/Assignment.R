############## Program_Structure - Assignment ##################################

#Assignment:
#===========
#1) Write a regular function for adding the two number passing the value dynamically as a arguments
#2) Write a regular S3 Method for adding the two number passing the value dynamically as a arguments
#3) Write a regular S4 Method for adding the two number passing the value dynamically as a arguments
#4) Write a regular S4 Method for adding the two number passing the value dynamically as a arguments
#5) Wrap all the above code in add_all_methods.R and create a callerScript filename run_addition.R and call the callerscriptCode.

# Refer to add_all_methods.R and run_addition.R file

############## Variable - Assignment ###########################################

install.packages("tidyverse")
library("tidyverse")
#===========
#ASSIGNMENTS: VARIABLES IN R
#-----------------------------
#ASSIGNMENT 1: Basic Variable Creation
#Q1
#Create a variable x and assign value 10. Print it.
x <- 10
x

#Q2
#Create two variables a = 5, b = 3.
#Create a third variable c as the sum of a and b.

a <- 5
b <- 3
c <- a+b
c

#Q3
#Assign a character value "R Programming" to a variable and print its class.

Lan <- "R Programming"
typeof(Lan)
class(Lan)

#Q4
#Assign TRUE to a variable and convert it to numeric.

Log <- TRUE
Log
as.numeric(TRUE)
as.character(TRUE)

#ASSIGNMENT 2: Variable Reassignment & Dynamic Typing
#Q5
#x <- 10
#x <- x + 5
#x
#Predict the output.
x <- 10
x <- x+5
x
# 15

#Q6
#x <- 100
x <- "Hundred"
class(x)
#character

#What happens to the data type?
# Q7
#x <- 5
#x <- TRUE
#x <- "Done"
#x

x <- 5
x <- TRUE
x <- "Done"
x
typeof(x)
class(x)
#character

#What is stored in x finally?
"Done"

#ASSIGNMENT 3: Variable Naming Rules
#Q8

#Which of the following are valid variable names? Explain why.
#my_var
#.myVar - Variable should not start from . or Numeric
#2value - Variable should not start from . or Numeric
#value_2
#my-value - Variable name cannot have hypen

#Q9
#Try assigning a value to a reserved word. What happens?
#if <- 10

if <- 10  #- Syatax Error

#ASSIGNMENT 4: Checking Variable Properties
-------------------------------------------
  #Q10
  #Create a variable and check:
  class()
typeof()
str()

x <- 25
typeof(x)
class(x)

x <- 25L
typeof(x)
class(x)

y <- "Integer"
typeof(y)
class(y)

l <- TRUE
typeof(l)
class(l)

n <- NULL
typeof(n)
class(n)

N <- NA
typeof(N)
class(N)

#Q11
x <- 10L
class(x)
typeof(x)
#Explain the difference.
When we assign a number ending with L, we are forcing the compiler to recognize the value as Integer instead of double / numeric



#ASSIGNMENT 5: Variables and Expressions
#---------------------------------------
#Q12
a <- 4
b <- 2
c <- a + b * 3
c
#Explain how operator precedence affects the result.
a+(b*3)

#Q13
#Rewrite Q12 using parentheses to change the result.

(a+b)*3

#ASSIGNMENT 6: Variable Scope (Very Important)
#---------------------------------------------
#Q14
x <- 10
f <- function() {
  x <- 5
  x
}
f()
x
#Explain both outputs.

The life of a variable defined inside a function lasts only until the function finishes execution

#Q15
x <- 1
f <- function() {
  x <<- x + 1
}
f()
x
#What changed and why?

X is assigned with a superassignment operator which defines the function at the global level

#ASSIGNMENT 7: Variables in Loops
#Q16
sum <- 0
for (i in 1:5) {
  sum <- sum + i
}
sum

#Explain how the variable changes in each iteration.
In each loop, the iterator increases by 1 and add up to sum
#Q17
#What happens if sum is not initialized before the loop?

Error in sum + i : non-numeric argument to binary operator

#ASSIGNMENT 8: Variables with Vectors & Objects
#Q18
x <- c(1, 2, 3)
y <- x
y[1] <- 100
x

#Why does x not change?
We have coped the value of x into Y, which will have seperate memory allocation

#Q19
#Create a vector variable and calculate:


Mean
Maximum
Length

mean(y)
max(y)
length(y)

#ASSIGNMENT 9: Variable Existence & Removal
-------------------------------------------
  #Q20
  x <- 10
exists("x")
rm(x)
exists("x")

#Explain the output.
Q21
#Remove all variables from the environment using one command.
rm(list = ls())

#ASSIGNMENT 10: Common Variable Mistakes
#Q22
mean <- 5
mean(c(1,2,3))

#What is the issue? How do you fix it?
Mean is a keyword and cannot be used

#Q23
x <- 10
y <- x
rm(x)
y
#Why does y still exist?
we have removed only variable x from the environment

#ASSIGNMENT 11: Tricky / Interview-Level
#Q24
x <- 5
y <- x <- 10
x
y
#Explain assignment associativity.
The assignment happens from Right to Left i.e rightmost expression is evaluated first and its result is passed to left

#Q25
x <- c(1,2,3)
for (x in 5:7) {
  print(x)
}
x
#What is the final value of x and why?
Last Iteration in a function has a value of 7 for the variable x

#ASSIGNMENT 12: Real-World Style
#Q26
#Create variables:
weight (kg)
height (meters)
#Calculate BMI using variables.

weight_kg <- 85
height_meters <- 175
bmi <- (weight_kg/(height_meters^2))

#Q27
#Create variables to store:
#Subject ID
#Visit number
#Lab value
#Create a formatted string like:
"SUBJ_01 | VISIT_2 | LAB=120"

subject_id <- 100100
visit <- 20
lab <- "esi"
str_c(subject_id, " | ", visit, " | ", lab)

#OPTIONAL WRITING TASKS
#Q28
#Write 3 best practices for naming variables in R.
1. Use small case or camel case
2. Use a understandable variable name
3. Do not start a variable name with . or number

#Q29
#Explain the difference between local and global variables in your own words.
Local variables are temporary variable which has a life until end of a function. However global variable will be applicable for the complete script

#Q30
#Explain why <<- should be used carefully
Variable value will gets changed at the global level

############## Operator - Assignment ###########################################

#ASSIGNMENTS ON OPERATORS IN R
#ASSIGNMENT 1: Arithmetic Operators
#Q1
#Predict the output:
10 + 4 * 2
#Q2
(10 + 4) * 2
#Q3
25 / 5 + 3^2
#Q4
17 %% 5
#Q5
17 %/% 5
#ASSIGNMENT 2: Relational (Comparison) Operators
#Q6
5 > 3
#Q7
5 == "5"
#Q8
10 != 8
#Q9
3 <= 2
#Q10
"R" < "r"
#ASSIGNMENT 3: Logical Operators
#Q11
TRUE & FALSE
#Q12
TRUE | FALSE
#Q13
!TRUE
#Q14
TRUE | FALSE & FALSE
#Q15
c(TRUE, FALSE) & c(FALSE, TRUE)
#ASSIGNMENT 4: Logical (& vs &&, | vs ||)
#Q16
c(TRUE, FALSE) && c(TRUE, TRUE)
#Q17
c(TRUE, FALSE) & c(TRUE, TRUE)
#Q18
FALSE || TRUE
#ASSIGNMENT 5: Assignment Operators
#Q19
x <- 5 + 2 * 3
x
#Q20
10 -> y
y
#Q21
z = 5
z
#ASSIGNMENT 6: Special Operators
Q22
1:5 + 1
#Q23
1:(5 + 1)
#Q24
5 %in% c(1, 3, 5, 7)
#Q25
c(2, 4, 6) %/% 4
#ASSIGNMENT 7: Vectorized Operators
#Q26
x <- c(10, 20, 30)
x + 5
#Q27
x * 2
#Q28
x > 15
#ASSIGNMENT 8: Operator Precedence
#Q29
5 + 2^3 * 4
#Q30
(5 + 2)^3 * 4
#Q31
TRUE | TRUE & FALSE
#Q32
!TRUE == FALSE
#ASSIGNMENT 9: Type Coercion + Operators
#Q33
TRUE + TRUE
#Q34
"10" + 5
#Q35
"10" == 10
#ASSIGNMENT 10: Data Frame + Operators (Real-World)
df <- data.frame(
  age = c(16, 22, 30, 15),
  salary = c(20000, 30000, 50000, 15000)
)
#Q36
df$age >= 18
#Q37
df$salary > 25000
#Q38
df$age >= 18 & df$salary > 25000
#ASSIGNMENT 11: Tricky / Interview-Level
#Q39
1:3 * 2 + 1
#Q40
(1:3) * (2 + 1)
#Q41
5 > 4 == 1
#Q42
FALSE | TRUE & TRUE | FALSE
#OPTIONAL TASKS (Write Code)
#Q43
#Write code to check if a number is even or odd using operators only.
#Q44
#Create a vector and use operators to:
#Identify values greater than 50
#Replace them with "High" and others with "Low"
#Q45
#Using operators, calculate BMI:
#BMI = weight / (height^2)

#predence
#---------
#Assignment 1: Basic Arithmetic Precedence
#Q1
5 + 2 * 3
#Q2
(5 + 2) * 3
#Q3
10 - 4 / 2
#Q4
2^3 + 4
#Q5
2^(3 + 4)
#Assignment 2: Sequence : vs Arithmetic
#Q6
1:5 + 2
#Q7
1:(5 + 2)
#Q8
(1:5) * 2
#Q9
1:3 * 2
#Q10
(1:3) * (2 + 1)
#Assignment 3: Relational vs Arithmetic
#Q11
5 + 3 > 7
#Q12
5 + (3 > 7)
#Q13
10 - 5 == 5
#Q14
10 - (5 == 5)
#Q15
8 / 4 >= 2
#Assignment 4: Logical Operator Precedence
#Q16
TRUE | FALSE & FALSE
#Q17
(TRUE | FALSE) & FALSE
#Q18
!TRUE == FALSE
#Q19
! (TRUE == FALSE)
#Q20
TRUE && FALSE | TRUE
# Assignment 5: Assignment with Precedence
#Q21
x <- 5 + 2 * 3
x
#Q22
y <- (5 + 2) * 3
y
#Q23
z <- 10 > 5 + 2
z
#Q24
a <- 10 > (5 + 2)
a
#Assignment 6: Vector & Data Examples
#Q25
x <- c(2, 4, 6)
x + 2 * 3
#Q26
x <- c(2, 4, 6)
(x + 2) * 3
#Q27
x <- c(10, 20, 30)
x > 15 & x < 30
#Q28
x <- c(10, 20, 30)
x > (15 & x < 30)
#Assignment 7: Tricky / Interview Level
#Q29
1:3 + 1:3 * 2
#Q30
(1:3 + 1:3) * 2
#Q31
5 > 4 == 1
#Q32
(5 > 4) == 1
#Q33
TRUE | TRUE & FALSE & FALSE

#Associativity
#---------
#Q1
2 ^ 3 ^ 2
#Q2
10 - 3 - 2
#Q3
5<6<7
#Q4
a <- b <- 5

############## Data Types - Assignment #########################################

#R DATA TYPES – ASSIGNMENT
#------------------------
#SECTION 1: Atomic Data Types (Foundations)
#Q1. Logical
#Create a logical vector of length 5 with at least one NA.

a <- c(TRUE, FALSE, FALSE, NA, TRUE)
a

#Convert it to numeric.

a_num <-as.numeric(a)
a_num  

#Explain the output.

# The output is 1 0 0 NA 1, i.e logical TRUE is converted into 1, Logical FALSE is converted into 0 and NA remains as it is because we can have NA in all the data types


#Q2. Integer vs Numeric
#Create one integer and one numeric variable with the same value.

ai <- 32L
an <- 32.98765

#Compare:
#  typeof()
typeof(ai) # integer
typeof(an) # double

#object.size()

object.size(ai) # 56 bytes
object.size(an) # 56 bytes

#Why does R treat them differently?
# R treates them differently at the storage level, but here it has same bytes, have to check with Ganesh

#Q3. Numeric Precision
#Store 0.1 + 0.2 in a variable.

np <- 0.1+0.2
np
typeof(np)
class(np)
object.size(np)

#Compare it with 0.3 using ==.

npc <- np == 0.3
npc
typeof(npc)
class(npc)
object.size(npc)
# Question : Why storage of integer, numeric and logical is same i.e 56 bytes?

#Explain the result.
# when we do comparison between the two variable, the output will be either TRUE or FALSE, hence the output will be logical instead of numeric / double

#Q4. Complex Numbers
#Create a complex number.

cn <- 3+4i
cn
typeof(cn)
class(cn)
object.size(cn)

#Extract real and imaginary parts.
Re(cn)
Im(cn)

#Multiply two complex numbers and explain the result.

cn1 <- 3+4i
cn2 <- 3+5i
cnm <- cn1*cn2
cnm

# The formuae for complex multiplication between the two complex values i.e (a+bi) * (c+di) = (ac-bd)+i(ad+bc)
# As per the above formulae, the caluclation in our case would be ((3*3)-(4*5))+i((3*5)+(4*3)) = -11+27i

#Q5. Character Data
#Create a character vector of 4 elements.

vec <- c(1, 2, "A", TRUE)
typeof(vec) # character
class(vec) # character

#Check its length and memory usage.

object.size(vec) # 304 bytes
length(vec) # 4

#Convert it to factor and compare storage.
vecf <- as.factor(vec)
vecf
typeof(vecf) # integer
typeof(levels(vecf)) # character

class(vecf) # factor
class(levels(vecf)) # character

object.size(vecf) # 704 bytes
object.size(levels(vecf)) # 304 bytes

# Need to understand the logic

#Q6. Raw Type
#Convert your name into raw bytes.

name_raw <- as.raw("Hitesh") # 1. NA's introduced by coercion 2. Out-Of-Range values treated as 0 in coercion to raw
name_raw # 00
typeof(name_raw) # raw
class(name_raw) # raw
object.size(name_raw) # 56 bytes

#Convert it back to character.

name_char <- as.character(name_raw)
name_char # 00

#Where is raw data used in real applications?


#SECTION 2: Special Values (Critical for Real Data)
#Q7. NA Handling
#Create a numeric vector with multiple NA values.

num_vec <- c(32, NA, 33L, 56.7654, NA)
num_vec
typeof(num_vec) # double
class(num_vec) # numeric
object.size(num_vec) # 96 bytes

#Try to calculate mean without removing NA.

num_vec_mean <- mean(num_vec)
num_vec_mean # NA (If any NA exists, the result becomes NA because the R assumes missing data means the statistics is unknown)
typeof(num_vec_mean) # double
class(num_vec_mean) # numeric
object.size(num_vec_mean) # 56 bytes

#Fix the issue and explain

num_vec_mean1 <- mean(num_vec, na.rm = TRUE)
num_vec_mean1 # 40.58847
typeof(num_vec_mean1) # double
class(num_vec_mean1) # numeric
object.size(num_vec_mean1) # 56 bytes

#Q8. Typed NA
#Create:
#  NA_integer_
#  NA_character_
#Combine each with a vector of another type.

a <- NA_integer_
b <- NA_character_

ab <- c(a, b)
ab
typeof(ab) # character
class(ab) # character
object.size(ab) #64 bytes


typeof(ab[1]) # character
class(ab[1]) # character
object.size(ab[1]) #56 bytes


typeof(ab[2]) # character
class(ab[2]) # character
object.size(ab[2]) #56 bytes


#Observe coercion.

#Q9. NaN vs NA vs Inf
#Generate one example of each.

nan1 <- 0/0 
nan1
typeof(nan1) # double
class(nan1) # numeric
object.size(nan1) # 56 bytes


na1 <- NA_integer_
na1
typeof(na1) # integer
class(na1) # integer
object.size(na1) # 56 bytes

inf1 <- 56/0
inf1
typeof(inf1) # double
class(inf1) # numeric
object.size(inf1) # 56 bytes

# Question : Why double and numeric is default for NaN and NA

#Test them using:
#  is.na()

is.na(nan1) # TRUE why?
is.na(na1) # TRUE why?
is.na(inf1) #FALSE

#  is.nan()

is.nan(nan1) # TRUE
is.nan(na1) # FALSE
is.nan(inf1) # FALSE

#  is.finite()

is.infinite(nan1) # FALSE
is.infinite(na1) # FALSE
is.infinite(inf1) # TRUE

#Explain the differences.

# NA - Not Available
# NAN - Not Considered as a number, this occurs when a 0 is dived by 0
# Inf - Infinite, this occurs when a finite number is divided by 0

#Q10. NULL
#Create a list with one element as NULL.

l1 <- list(c(32, 45, "Hitesh", NULL, 56))
l1 # NULL is excluded
typeof(l1) #list
class(l1) # list
object.size(l1) # 360 bytes

#Check its length.

length(l1) # 1 # why?

#Remove that element and observe behavior.

l2 <- list(c(32, 45, "Hitesh", 56))
l2
typeof(l2) # list
class(l2) # list
object.size(l2) # 360 bytes

length(l2) # 1 # why?

#SECTION 3: Data Structures
#Q11. Vector Coercion
#Combine logical, integer, numeric, and character into one vector.

ds1 <- c(TRUE, 32L, 56.9087, "Hitesh")
ds1
typeof(ds1) # character
class(ds1) # character
object.size(ds1) # 304 bytes
length(ds1) # 4

#Predict the output type before running.
#Verify using typeof().

#Q12. Matrix
#Create a 3×3 matrix.

mat1 <- matrix(c(82, 85, 99, 91, 80, 76, 95, 99, 100), byrow = TRUE, ncol = 3)
mat1

#Assign row and column names.

row.names(mat1) <- c("Student1", "Student2", "Student3")
colnames(mat1) <- c("Physics", "Maths", "CS")
mat1

#Extract:
# 2nd row

mat1[2,]

# 3rd column
mat1[, 3]

#diagonal elements

diag(mat1)

#Q13. Array
#Create a 3D array (2×2×3).

arr1 <- array(data = c(31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42), dim = c(2, 2, 3), dimnames = list(c("Length", "Width"),
                                                                                                          c("Length", "Height"),
                                                                                                          c("Layer1", "Layer2", "Layer3")))
arr1

#Explain how data is filled internally.

# It starts from rows, columns and then layers
# Here for Layer1, it fills the data in row first and column next

#Extract all values from 2nd layer.

arr1[, , 2]

#Q14. List
#Create a nested list containing:
#  numeric
#  character
#  another list

l2 <- list(c(32, 45, "Hitesh", 56))

l5 <- list(1, 2, 3, 5, 7, 32, 42, 53, "char123", c("Student", 54), l2)
l5
typeof(l5) # list
class(l5) # list
object.size(l5) # 1272 bytes
           
#Access deeply nested elements using:
#  [[ ]]

l5[[11]][[1]]
l5[11]

# why the above both gives the same output?

l5[[11]][[1]][[3]]


#  $
# we cannot access list using $?

#Q15. Data Frame
#Create a data frame with:
# integer
# character
# numeric

dm <- data.frame(
  STUDYID = 111111L,
  DOMAIN = "DM",
  SUBJECT = 222222,
  AGE = 28L,
  Height = 175.28
)

dm

#Check structure.

str(dm)
# Why 175.28 is getting converted into 175 when the data type is still numeric?

#Explain why data frame is actually a list.

typeof(dm) # list
# Because each variable / column in a data frame is a individual list

#SECTION 4: Factor (High-Value Concept)
#Q16. Factor Internals
#Create a factor with 3 levels.

animal_vector <- c("Elephant", "Giraffe", "Horse")
animal_vector_factor <- factor(animal_vector)
animal_vector_factor
typeof(animal_vector_factor) # integer
class(animal_vector_factor) # factor

#Convert it to numeric directly

animal_vector_num <- as.numeric(animal_vector_factor)
animal_vector_num # 1, 2, 3
typeof(animal_vector_num) # double
class(animal_vector_num) # numeric

#Explain why the output is misleading.

# Need to understand this concept more

#Q17. Ordered Factor
#Create an ordered factor (Low, Medium, High).

speed_vector <- c("low", "medium", "high")
speed_vector_fac <- factor(speed_vector)
speed_vector_fac

speed_vector <- c("low", "medium", "high")
speed_vector_fac <- factor(speed_vector,
                           ordered = TRUE,
                           levels = c("low", "medium", "high"))
speed_vector_fac

#Compare two values.

speed_vector_fac[1] # low
speed_vector_fac[2] # medium
speed_vector_fac[1] > speed_vector_fac[2] # FALSE

#Explain how ordering works internally.

# Need to understand more

#SECTION 5: Date and Time
#Q18. Date Type
#Create today’s date.

date_var <- Sys.Date()
date_var
typeof(date_var) # double
class(date_var) # Date
object.size(date_var) # 280 bytes

#Subtract 10 days.

date_var10 <- date_var-10
date_var10

#Find the difference in days.

date_var - date_var10 # Time difference of 10 days

#Q19. POSIXct vs POSIXlt
#Create current time in both formats.

datetime_var_ct <- as.POSIXct(Sys.time(), "%d-%m-%d %H:%M")
datetime_var_ct

datetime_var_lt <- as.POSIXlt(Sys.time(), tz = "ist", "%d-%m-%y %H:%M")
datetime_var_lt

#Compare:
# typeof()
#  class()

typeof(datetime_var_ct) # double
class(datetime_var_ct) # "POSIXct" "POSIXt"
object.size(datetime_var_ct) # 576 bytes

typeof(datetime_var_lt) # list
class(datetime_var_lt) # "POSIXlt" "POSIXt" 
object.size(datetime_var_lt) # 2512 bytes

# Why type of datetime_var_ct is double and type of datetime_var_lt is list?

#Explain when to use each

# Need to understnd more

#SECTION 6: Type Inspection & Coercion
#Q20. typeof vs class
#Create a factor and a Date.

var123 <- c("Male", "Female")
var123_factor <- factor(var123)
var123_factor

date123 <- Sys.Date()
date123

#Compare typeof() and class().

typeof(var123) # character
typeof(date123) # double

class(var123) # character
class(date123) # Date

#Explain why they differ.

# Need to understand the concept more

#Q21. Coercion Rules
#Create vectors that trigger each coercion step.

# Logical to Integer

v1 <- c(TRUE, FALSE, 32L)
v1 # 1 0 32
typeof(v1) # integer
class(v1) # integer

# Integer to Numeric

v2 <- c(32L, 33L, 33.56)
v2 # 32.00 33.00 33.56
typeof(v2) # double
class(v2) # numeric

#Numeric to Character

v3 <- c(10.5, 32.5, "Hitesh")
v3 # "10.5", "32.5", "Hitesh
typeof(v3) # character
class(v3) # character

# Logical to Character

v4 <- c(TRUE, FALSE, "Hitesh")
v4 # "TRUE", "FALSE", "Hitesh"
typeof(v4) # character
class(v4) # character

#Document the coercion hierarchy.

# logical -> integer -> double(numeric) -> character

#SECTION 7: Memory & Performance (Advanced)
#Q22. Memory Comparison
#Create a vector of 1 million:
# integers

vector_1 <- c(1L:1000000L)
vector_1
typeof(vector_1) # integer
class(vector_1) # integer
object.size(vector_1) # 4000048 bytes

#  numerics

vector_2 <- c(1.5:1000000)
vector_2
typeof(vector_2) # double
class(vector_2) # numeric
object.size(vector_2) # 8000040 bytes

# Compare memory usage.

8000040 - 4000048 == 3999992 

8000040 / 4000048 == 1.999986

#Draw conclusions.

# Memory used by numeric is almost the double of the memory used by integer

#Q23. Copy-on-Modify
#Create a vector.

vec1 <- c(1, 32, 33, "Hitesh")
.Internal(inspect(vec1))

#Assign it to another variable.

vec2 <- vec1
vec2
.Internal(inspect(vec2))


#Modify one element.

vec1[3] <- "Horse"
vec1
.Internal(inspect(vec1))

#Observe memory behavior.
# Have to understand the behaviour more

#SECTION 8: Error & Debug Thinking (Exam Level)
#Q24. Identify the Error
#Explain what is wrong and how to fix:
if (x == NA) {
  print("Missing")
}

# NA means not available / missing value and we cannot use binary operators on NA

#Q25. Predict the Output (NO RUNNING)
#explain
x <- factor(c("10", "20"))
as.numeric(x)

# 1, 2

#Q26. Real-World Case
#You receive a CSV where:
# IDs should be integer
#  Gender should be factor
#  Visit date is character
#Explain how you would clean and convert types safely.

# Inspec the data types of variables or columns before converting using str() function
# Then convert the data types of variable as required 

# i.e df$id <- as.integer(df$id)
# df$gender <- as.factor(df$gender)
# df$visit <- as.character(df$visit)

#Q27. One-Line Summary
#Write one sentence per data type explaining its purpose.

# logical - Stores TRUE / FALSE based upon the boolean logic
# integer - Stores finite non decimal numbers
# numeric - stores finite decimal numbers
# character - Stores text strings
# complex - Stores real and imaginary parts
