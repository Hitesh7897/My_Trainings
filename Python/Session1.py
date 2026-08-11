"""
===============================================================================
PYTHON TRAINING NOTES
Environment Variables in Ubuntu/Linux and Windows
===============================================================================

This document is intended as TRAINING NOTES and is heavily commented so it can
be opened as a .py file in any editor.

===============================================================================
TABLE OF CONTENTS

1. Introduction
2. Ubuntu/Linux Environment Variables
   - Viewing variables
   - Temporary variables
   - User-level variables
   - Global variables
   - ~/.bashrc
   - ~/.profile
   - /etc/environment
   - /etc/profile
   - /etc/profile.d
   - PATH
   - PYTHONHOME
   - PYTHONPATH
   - Virtual environments
   - Reading variables in Python
   - Removing variables
   - Troubleshooting
3. Windows Environment Variables
   - Viewing variables
   - Temporary variables (CMD)
   - Temporary variables (PowerShell)
   - User variables
   - System variables
   - Environment Variables GUI
   - PATH
   - PYTHONHOME
   - PYTHONPATH
   - set
   - setx
   - PowerShell $env:
   - Registry locations
   - Reading variables in Python
   - Troubleshooting
4. Ubuntu vs Windows Comparison
5. Best Practices
===============================================================================
"""

# =============================================================================
# INTRODUCTION
# =============================================================================

"""
Environment variables are key-value pairs maintained by the operating system.

They are used by Python and other software to locate:
- Executables
- Libraries
- Configuration files
- User settings
- API keys
- Project directories

Python examples:
import os
print(os.environ["HOME"])
print(os.getenv("PYTHONPATH"))
"""

# =============================================================================
# UBUNTU / LINUX
# =============================================================================

"""
VIEW VARIABLES

printenv
env
set

echo $PATH
echo $HOME
echo $USER
echo $SHELL

env | grep PYTHON
printenv | grep JAVA
"""

"""
TEMPORARY VARIABLES

export PROJECT_NAME=PythonTraining
export APP_ENV=Development
export PYTHONHOME=/opt/python3.13
export PYTHONPATH=/home/user/modules

Verify:
echo $PROJECT_NAME

Remove:
unset PROJECT_NAME
"""

"""
USER LEVEL FILES

~/.bashrc
~/.profile
~/.bash_profile
~/.zshrc

Edit:

nano ~/.bashrc

Example:

export PROJECT_HOME=$HOME/projects
export PYTHONHOME=/opt/python3.13
export PYTHONPATH=$HOME/python_modules
export OPENAI_API_KEY="your-key"

PATH examples

export PATH=$PATH:/opt/python/bin
export PATH=/opt/python/bin:$PATH
export PATH=$PATH:$HOME/.local/bin

Reload

source ~/.bashrc
"""

"""
GLOBAL VARIABLES

sudo nano /etc/environment

NO 'export' keyword here.

Example

PYTHONHOME="/opt/python3.13"
PROJECT_ROOT="/data/project"
JAVA_HOME="/usr/lib/jvm/java-21-openjdk"

-------------------------------------------------

sudo nano /etc/profile

export COMPANY=Example
export PYTHONHOME=/opt/python3.13

-------------------------------------------------

Recommended

sudo nano /etc/profile.d/python.sh

export PYTHONHOME=/opt/python3.13
export PATH=$PATH:$PYTHONHOME/bin

sudo chmod +x /etc/profile.d/python.sh
"""

"""
PYTHON VIRTUAL ENVIRONMENT

python3 -m venv venv
source venv/bin/activate

echo $VIRTUAL_ENV

deactivate
"""

"""
VERIFY

which python3
whereis python3
echo $PATH
echo $PYTHONPATH
env | grep PYTHON
"""

"""
PYTHON ACCESS

import os

print(os.environ["HOME"])
print(os.environ["PATH"])
print(os.getenv("PYTHONHOME"))
print(os.getenv("PYTHONPATH"))
"""

"""
TROUBLESHOOTING

source ~/.bashrc

echo $PATH

which python3

ls /opt/python3.13/bin
"""

# =============================================================================
# WINDOWS
# =============================================================================

"""
VIEW VARIABLES

Command Prompt

set

echo %PATH%
echo %USERNAME%
echo %TEMP%
echo %APPDATA%
echo %PYTHONHOME%

PowerShell

Get-ChildItem Env:
echo $env:PATH
echo $env:USERNAME
"""

"""
TEMPORARY VARIABLES

Command Prompt

set PROJECT_NAME=PythonTraining
set APP_ENV=Development

View

echo %PROJECT_NAME%

PowerShell

$env:PROJECT_NAME="PythonTraining"

View

echo $env:PROJECT_NAME
"""

"""
PERMANENT USER VARIABLES

Command Prompt

setx PROJECT_HOME "C:\Projects"

setx PYTHONHOME "C:\Python313"

setx PYTHONPATH "C:\PythonModules"

NOTE:
Open a NEW Command Prompt after using setx.
"""

"""
PERMANENT SYSTEM VARIABLES

Run Command

SystemPropertiesAdvanced

Click

Environment Variables

System Variables

New...

Variable Name

PYTHONHOME

Variable Value

C:\Python313

---------------------------------------------

Alternative

Control Panel
System
Advanced System Settings
Environment Variables
"""

"""
ADD PYTHON TO PATH

GUI

Environment Variables
Path
Edit
New

C:\Python313
C:\Python313\Scripts

---------------------------------------------

CMD

setx PATH "%PATH%;C:\Python313;C:\Python313\Scripts"

(Note: setx truncation may occur on very long PATH values.)

---------------------------------------------

PowerShell (current session)

$env:PATH += ";C:\Python313"
"""

"""
COMMON WINDOWS VARIABLES

PATH
TEMP
TMP
USERNAME
USERPROFILE
APPDATA
LOCALAPPDATA
PROGRAMFILES
PROGRAMDATA
PUBLIC
COMPUTERNAME
HOMEDRIVE
HOMEPATH
NUMBER_OF_PROCESSORS
OS
PROCESSOR_ARCHITECTURE
"""

"""
WINDOWS REGISTRY LOCATIONS

User Variables

HKEY_CURRENT_USER\Environment

System Variables

HKEY_LOCAL_MACHINE
  SYSTEM
    CurrentControlSet
      Control
        Session Manager
          Environment
"""

"""
READ VARIABLES IN PYTHON

import os

print(os.environ["PATH"])
print(os.getenv("PYTHONHOME"))
print(os.getenv("PROJECT_HOME"))
"""

"""
REMOVE VARIABLES

GUI

Environment Variables
Select variable
Delete

Command Prompt

set VARIABLE=

PowerShell

Remove-Item Env:VARIABLE
"""

"""
TROUBLESHOOTING

Open a NEW CMD after setx

where python

python --version

echo %PATH%

PowerShell

$env:PATH
"""

# =============================================================================
# UBUNTU vs WINDOWS
# =============================================================================

"""
Task                     Ubuntu                     Windows CMD
----------------------------------------------------------------------
View all                 printenv                   set
View PATH                echo $PATH                 echo %PATH%
Temporary variable       export VAR=x              set VAR=x
Permanent variable       ~/.bashrc                 setx VAR value
Reload                   source ~/.bashrc          reopen CMD
Remove                   unset VAR                set VAR=
Python executable        which python3            where python
Path separator           :                         ;
Variable syntax          $PATH                    %PATH%
PowerShell syntax        N/A                      $env:PATH
"""

# =============================================================================
# BEST PRACTICES
# =============================================================================

"""
* Use uppercase variable names.
* Keep custom variables grouped together.
* Do not edit /etc/profile unless necessary.
* Prefer /etc/profile.d for custom global scripts.
* Prefer user-level variables unless every user needs them.
* Never commit API keys to Git.
* Quote values containing spaces.
* Verify using echo/printenv/set after changes.
"""

# End of training notes