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
IF NOT EXIST _set (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder _set not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD _set
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Used to place settings specific for the Joomla Extension.
	ECHO # Files in this folder are shared between different scripts.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for _set created succesfully.
CD ..

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
