:: Name:     default_binary_files.cmd
:: Purpose:  Create any missing default files
:: Author:   pierre@pvln.nl
:: Revision: 2020 03 12 - initial version
::           2023 09 02 - added debug numbers 
::
:: Required environment variables
:: ==============================
:: - VERBOSE  how verbose output should be if not set script sets it to YES
:: - extensionFolderPath          the path to the extension based on the top level foldername

@ECHO off
SETLOCAL ENABLEEXTENSIONS

ECHO [%~n0 ] ... [0320]

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)
IF "%extensionFolderPath%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0321] extensionFolderPath environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create default files
::
:: ======================
:: OUTPUT SHARED BINARIES
:: ======================
IF %VERBOSE%==YES ECHO [%~n0 ] ... [0322] Start creating files for %extensionFolderPath%/_bin.

IF NOT EXIST %extensionFolderPath%/_bin (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0323] folder %extensionFolderPath%/_bin not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD %extensionFolderPath%/_bin	 
IF NOT EXIST "README.md" (
	ECHO ---
	ECHO README.md in /_bin 
	ECHO # Used to place output binaries like zip's etc. from scripts.
	ECHO Files in this folder are shared between different scripts.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... [0324] Files for %extensionFolderPath%/_bin created succesfully.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
