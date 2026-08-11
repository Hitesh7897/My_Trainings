# SESSION 2 - PYTHON FUNDAMENTALS TRAINING NOTES

"""
Topics
------
1. Python Tokens
2. Keywords
3. Identifiers
4. Literals
5. Variables
6. Comments
7. Data Types
8. Type Conversion
9. Operators
10. Class
11. Object
12. Methods
13. Constructor
14. self
15. Built-in Functions
16. Ubuntu Python Commands
17. Windows Python Commands
18. Practice Programs
19. Interview Questions
"""

# PYTHON TOKENS
"""
A token is the smallest meaningful unit of a Python program.

Types:
- Keywords
- Identifiers
- Literals
- Operators
- Delimiters
"""

# KEYWORDS
"""
Reserved words such as:
if, else, for, while, class, def, return, import

import keyword
print(keyword.kwlist)
print(keyword.iskeyword('for'))
"""

# IDENTIFIERS
"""
Names given to variables, functions, classes and objects.

Rules:
- Start with letter or underscore
- Cannot start with digit
- Cannot be a keyword
- Case-sensitive
"""

# LITERALS
"""
Numeric:
10
10.5
3+4j

String:
'Python'

Boolean:
True
False

None:
None

Collections:
[1,2,3]
(1,2,3)
{'A':1}
{1,2,3}
"""

# VARIABLES
"""
name='John'
age=25

a,b=1,2
x=y=z=100
a,b=b,a
"""

# DATA TYPES
"""
int
float
complex
bool
str
list
tuple
set
dict
bytes
bytearray
range
NoneType
"""

# CLASS
"""
class Student:
    pass
"""

# OBJECT
"""
obj=Student()
"""

# METHODS
"""
class Student:
    def display(self):
        print('Hello')
"""

# CONSTRUCTOR
"""
class Student:
    def __init__(self,name):
        self.name=name
"""

# SELF
"""
self refers to current object.
"""

# BUILT-IN FUNCTIONS
"""
print()
input()
type()
id()
len()
range()
sum()
min()
max()
round()
sorted()
enumerate()
zip()
dir()
help()
isinstance()
"""

# UBUNTU COMMANDS
"""
python3                      -> Start Python interpreter
python3 --version            -> Show version
python3 app.py               -> Run script
which python3                -> Locate executable
whereis python3              -> Show installations
pip list                     -> List packages
pip install <pkg>            -> Install package
pip uninstall <pkg>          -> Remove package
pip freeze                   -> Export packages
python3 -m venv .venv        -> Create virtual environment
source .venv/bin/activate    -> Activate environment
deactivate                   -> Exit environment

uv init
uv add <pkg>
uv remove <pkg>
uv sync
uv lock
uv tree
uv run app.py
uv python list
uv python install 3.13
uv python pin 3.13
"""

# WINDOWS COMMANDS
"""
python --version
py --version
python app.py
py app.py
where python
pip list
pip install <pkg>
pip uninstall <pkg>
pip freeze
python -m venv .venv
.venv\Scripts\activate
deactivate

PowerShell:
.\venv\Scripts\Activate.ps1
Get-Command python
Get-ChildItem Env:

uv init
uv add <pkg>
uv remove <pkg>
uv sync
uv lock
uv tree
uv run app.py
uv python list
uv python install 3.13
uv python pin 3.13
"""

# PRACTICE PROGRAMS
"""
Hello World
Calculator
Odd Even
Largest Number
Prime Number
Factorial
Fibonacci
Class/Object
Constructor
Methods
"""

# INTERVIEW QUESTIONS
"""
What are Tokens?
What are Identifiers?
What are Literals?
What is a Class?
What is an Object?
What is self?
Difference between Function and Method?
Difference between == and is?
"""