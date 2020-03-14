:: Name:     missing_files.cmd
:: Purpose:  Create any missing default files projects folders
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 25 - initial version
::           2020 03 12 - updated to new folder structure
::

@ECHO off
SETLOCAL ENABLEEXTENSIONS

:: Create default files
::
CALL %extensionFolderPath%/struc/create/default_binary_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_binary_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_temporary_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_temporary_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_build_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_build_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_deploy_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_deploy_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_miscellaneous_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_miscellaneous_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_code_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_code_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_staging_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_staging_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_structure_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_structure_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
