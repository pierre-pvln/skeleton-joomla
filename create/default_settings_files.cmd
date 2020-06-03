:: Name:     default_settings_files.cmd
:: Purpose:  Create any missing default files
:: Author:   pierre@pvln.nl
:: Revision: 2020 03 12 - initial version
::
:: Required environment variables
:: ==============================
:: - VERBOSE  how verbose output should be if not set script sets it to YES

@ECHO off
SETLOCAL ENABLEEXTENSIONS

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)

:: Create default files
::
:: ======================
:: SHARED SETTINGS
:: ======================
IF %VERBOSE%==YES ECHO [%~n0 ] ... Start creating files for %extensionFolderPath%/_set.

IF NOT EXIST %extensionFolderPath%/_set (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder %extensionFolderPath%/_set not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD %extensionFolderPath%/_set
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO README.md in /_set 
	ECHO # Used to place settings specific for the Joomla Extension.
	ECHO Files in this folder are shared between different scripts.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for %extensionFolderPath%/_set created succesfully.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
