:: Name:     all_git_branches.cmd
:: Purpose:  Display the current gitbranch and all branches
:: Author:   pierre@pvln.nl
:: Revision: 2019 05 28 - initial version
::
:: Required environment variables
:: ==============================
:: - VERBOSE         			  how verbose output should be if not set script sets it to YES
::
@ECHO off
SETLOCAL ENABLEEXTENSIONS
::
:: BASIC SETTINGS
:: ==============
:: Setting the name of the script
SET me=%~n0
:: Setting the name of the directory with this script
SET parent=%~p0
:: Setting the drive of this commandfile
SET drive=%~d0
:: Setting the directory and drive of this commandfile
SET cmd_dir=%~dp0

::
:: (re)set environment variables
::

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)

SET FOLDER=code
CALL:GET_GIT_BRANCH

SET FOLDER=bld
CALL:GET_GIT_BRANCH

SET FOLDER=stg
CALL:GET_GIT_BRANCH

SET FOLDER=dpl
CALL:GET_GIT_BRANCH

SET FOLDER=struc
CALL:GET_GIT_BRANCH

GOTO CLEAN_EXIT

:ERROR_EXIT
cd "%cmd_dir%" 
ECHO *******************
ECHO %ERROR_MESSAGE%
ECHO *******************
   
:CLEAN_EXIT
:: Wait some time and exit the script
::
PAUSE
:: Exit script file here
GOTO:eof

::--------------------------------------------------------
::-- Function section starts below here
::--
::-- Inspiration: https://www.dostips.com/DtTutoFunctions.php
::-- 
::--------------------------------------------------------

:GET_GIT_BRANCH
CD ..\%FOLDER%

:: Get current branch in environment variable
:: https://ss64.com/nt/for_cmd.html
::
FOR /F %%G IN ('git rev-parse --abbrev-ref HEAD') DO SET currentGitBranch=%%G

:: remove spaces in name
:: http://www.dostips.com/DtTipsStringManipulation.php
:: 
SET currentGitBranch=%currentGitBranch: =%
   
:: show the result 
IF %VERBOSE%==YES (
	ECHO [%~n0 ] ... 
	ECHO [%~n0 ] ... Current local branch for \%FOLDER%: %currentGitBranch%
	ECHO [%~n0 ] ... 
	git branch -a
)

CD "%cmd_dir%"
goto:eof
