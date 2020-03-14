:: Name:     test_missing_files.cmd
:: Purpose:  Create the baseline folder structure, connect to git and generate any missing files in Joomla! development directory
:: Author:   pierre@pvln.nl
:: Revision: 2020 03 13 - initial version
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


:: Goto folder from where sub command is started
CD ..
CD
SET
PAUSE

ECHO RUNNING THE ACTUAL CODE



::
:: (re)set environment variables
::
SET VERBOSE=YES
SET extensionFolderPath=%CD%


CALL %extensionFolderPath%/struc/create/missing_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script missing_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT
)
IF %VERBOSE%==YES ECHO [%~n0 ] ... Missing files created succesfully.

GOTO CLEAN_EXIT

:ERROR_EXIT
cd "%cmd_dir%" 
ECHO *******************
ECHO %ERROR_MESSAGE%
ECHO *******************
   
:CLEAN_EXIT
:: Wait some time and exit the script
::
timeout /T 5
