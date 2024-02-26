:: Name:     missing_files.cmd
:: Purpose:  Create any missing default files projects folders
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 25 - initial version
::           2020 03 12 - updated to new folder structure
::           2023 09 02 - added debug numbers 
::
:: Required environment variables
:: ==============================
:: - extensionFolderPath          the path to the extension based on the top level foldername

@ECHO off
SETLOCAL ENABLEEXTENSIONS

ECHO [%~n0 ] ... [0300]

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
::
IF "%extensionFolderPath%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0301] extensionFolderPath environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create default files
::
:: [0320]
CALL %extensionFolderPath%/struc/create/default_binary_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0302] Script default_binary_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: [0330]
CALL %extensionFolderPath%/struc/create/default_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0303] Script default_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: [0340]
CALL %extensionFolderPath%/struc/create/default_temporary_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0304] Script default_temporary_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: [0350]
CALL %extensionFolderPath%/struc/create/default_build_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0305] Script default_build_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: [0360]
CALL %extensionFolderPath%/struc/create/default_deploy_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0306] Script default_deploy_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: [0370]
CALL %extensionFolderPath%/struc/create/default_miscellaneous_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0307] Script default_miscellaneous_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: [0380]
CALL %extensionFolderPath%/struc/create/default_code_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0308] Script default_code_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: [0390]
CALL %extensionFolderPath%/struc/create/default_staging_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0309] Script default_staging_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: [0310]
CALL %extensionFolderPath%/struc/create/default_structure_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0310] Script default_structure_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
