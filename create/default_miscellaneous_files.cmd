:: Name:     default_miscellaneous_files.cmd
:: Purpose:  Create any missing default files
:: Author:   pierre@pvln.nl
:: Revision: 2020 03 12 - initial version
::           2023 09 02 - added debug numbers 
::
:: Required environment variables
:: ==============================
:: - VERBOSE  how verbose output should be if not set script sets it to YES
:: - extensionFolderName          the name of the extension based on the top level foldername
:: - extensionFolderPath          the path to the extension based on the top level foldername

@ECHO off
SETLOCAL ENABLEEXTENSIONS

ECHO [%~n0 ] ... [0370]

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)
IF "%extensionFolderName%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0371] extensionFolderName environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%extensionFolderPath%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0372] extensionFolderPath environment variable not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create default files
::
:: ======================
:: MISCELLANEOUS
:: ======================
IF %VERBOSE%==YES ECHO [%~n0 ] ... [0373] Start creating files for %extensionFolderPath%/misc.

IF NOT EXIST %extensionFolderPath%/misc (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0374] folder %extensionFolderPath%/misc not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD %extensionFolderPath%/misc
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO README.md in /misc 
	ECHO # Folder for miscellaneous info for the %extensionFolderName% Joomla! extension.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... [0375] Files for %extensionFolderPath%/misc created succesfully.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
