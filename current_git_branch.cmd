:: Name:     current_git_branch.cmd
:: Purpose:  Display the current gitbranch
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 25 - initial version
::
:: Required environment variables
:: ==============================
:: - VERBOSE         			  how verbose output should be if not set script sets it to YES
::
@ECHO off
SETLOCAL ENABLEEXTENSIONS

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)

:: Get current branch in environment variable
:: https://ss64.com/nt/for_cmd.html
::
FOR /F %%G IN ('git rev-parse --abbrev-ref HEAD') DO SET currentGitBranch=%%G

:: remove spaces in name
:: http://www.dostips.com/DtTipsStringManipulation.php
:: 
SET currentGitBranch=%currentGitBranch: =%
   
:: show the result 
IF %VERBOSE%==YES ECHO ... Current local branch: %currentGitBranch%

:: current git branch is determined 

PAUSE