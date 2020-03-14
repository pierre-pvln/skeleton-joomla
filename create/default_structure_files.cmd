:: Name:     default_structure_files.cmd
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
:: STRUCTURE SCRIPTS
:: ======================
IF %VERBOSE%==YES ECHO [%~n0 ] ... Start creating files for %extensionFolderPath%/struc.

IF NOT EXIST %extensionFolderPath%/struc (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder %extensionFolderPath%/struc not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD %extensionFolderPath%/struc
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Scripts to create the default local Joomla! development environment
	ECHO --- 
	) >README.md
IF NOT EXIST "CHANGELOG.md" (
	ECHO --- 
	ECHO #  Changelog Scripts: Generic Joomla! extension structure creation scripts
	ECHO ---
	ECHO ^<h4^>v.0.0.1 %date:~9,4%-%date:~6,2%-%date:~3,2%^</h4^>
	ECHO ^<ul^>
	ECHO ^<li^>Initial version^</li^>
	ECHO ^</ul^>
	) >CHANGELOG.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for %extensionFolderPath%/struc created succesfully.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
