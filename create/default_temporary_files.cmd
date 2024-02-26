:: Name:     default_temporary_files.cmd
:: Purpose:  Create any missing default files
:: Author:   pierre@pvln.nl
:: Revision: 2020 03 12 - initial version
::           2023 09 02 - added debug numbers 
::
:: Required environment variables
:: ==============================
:: - VERBOSE                      how verbose output should be if not set script sets it to YES
:: - extensionFolderPath          the path to the extension based on the top level foldername

@ECHO off
SETLOCAL ENABLEEXTENSIONS

ECHO [%~n0 ] ... [0340]

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)
IF "%extensionFolderPath%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0341] extensionFolderPath environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create default files
::
:: ======================
:: SHARED TEMPORARY FILES
:: ======================
IF %VERBOSE%==YES ECHO [%~n0 ] ... [0342] Start creating files for %extensionFolderPath%/_tmp.

IF NOT EXIST %extensionFolderPath%/_tmp (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0343] folder %extensionFolderPath%/_tmp not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD %extensionFolderPath%/_tmp
IF NOT EXIST "README.md" (
	ECHO ---
	ECHO README.md in /_tmp
	ECHO # Used to place temporary output files from scripts.
	ECHO Folder is shared between different scripts.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... [0344] Files for %extensionFolderPath%/_tmp created succesfully.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
