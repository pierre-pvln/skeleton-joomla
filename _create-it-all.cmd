:: Name:     _create-it-all.cmd
:: Purpose:  Create the baseline folder structure, connect to git and generate any missing files in Joomla! development directory
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 25 - initial version
::           2020 03 13 - folder and files structure changed
::                      - variable extensionFolderPath added
::           2023 09 02 - added debug numbers 
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
SET VERBOSE=YES

::    
:: ==================================
::  CHECKING AND SETTING START FOLDER
:: ==================================
IF %VERBOSE%==YES ECHO [%~n0 ] ... [000] Checking where script is started.
::
:: get the name of the folder in an environment variable
:: https://superuser.com/questions/160702/get-current-folder-name-by-a-dos-command
:: http://www.robvanderwoude.com/ntfor.php
::
for %%I in (.) do set startedInFolderName=%%~nxI
::
:: remove spaces in name
:: http://www.dostips.com/DtTipsStringManipulation.php
:: 
SET startedInFolderName=%startedInFolderName: =%
IF %VERBOSE%==YES ECHO [%~n0 ] ... [001] startedInFolderName is: %startedInFolderName%

IF %startedInFolderName%==struc CD ..
::    
:: ==================================
::  DETERMINE EXTENSION NAME
:: ==================================
IF %VERBOSE%==YES ECHO [%~n0 ] ... [002] Determining extension name based on foldername
for %%I in (.) do set extensionFolderName=%%~nxI
SET extensionFolderName=%extensionFolderName: =%
::
:: Convert extension to lowercase
:: http://www.robvanderwoude.com/battech_convertcase.php
::
FOR %%i IN ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO CALL SET "extensionFolderName=%%extensionFolderName:%%~i%%"

SET extensionFolderPath=%CD%

IF %VERBOSE%==YES ECHO [%~n0 ] ... [003] extensionFolderName is: %extensionFolderName%
IF %VERBOSE%==YES ECHO [%~n0 ] ... [004] extensionFolderPath is: %extensionFolderPath%

:: [0100]
CALL %extensionFolderPath%/struc/create/folder_structure.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [005] Script %extensionFolderPath%/struc/create/folder_structure.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT
)
IF %VERBOSE%==YES ECHO [%~n0 ] ... [006] Folder structure created succesfully.

:: [0200]
CALL %extensionFolderPath%/struc/get_remote_scripts_repositories.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [007] Script %extensionFolderPath%/struc/get_remote_scripts_repositories.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT
)
IF %VERBOSE%==YES ECHO [%~n0 ] ... [008] Got remote repositories succesfully.

:: [0300]
CALL %extensionFolderPath%/struc/create/missing_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [009] Script %extensionFolderPath%/struc/create/missing_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT
)
IF %VERBOSE%==YES ECHO [%~n0 ] ... [010] Missing files created succesfully.

:: [0400]
CALL %extensionFolderPath%/struc/create/remote_github_repository.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [011] Script %extensionFolderPath%/struc/create/remote_github_repository.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT
)
IF %VERBOSE%==YES ECHO [%~n0 ] ... [012] New remote github repository created succesfully.

:: [0500]
CALL %extensionFolderPath%/struc/create/local_git_repository_for_code.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [013] Script %extensionFolderPath%/struc/create/local_git_repository_for_code.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT
)
IF %VERBOSE%==YES ECHO [%~n0 ] ... [014] New local git repository created succesfully.


GOTO CLEAN_EXIT

:ERROR_EXIT
cd "%cmd_dir%" 
ECHO %ERROR_MESSAGE%
   
:CLEAN_EXIT
:: Wait some time and exit the script
::
timeout /T 5
