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

CALL %extensionFolderPath%/struc/create/temporary_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script temporary_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/build_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script build_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/deploy_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script deploy_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/default_miscellaneous_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_miscellaneous_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/code_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script code_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/staging_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script staging_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL %extensionFolderPath%/struc/create/structure_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script structure_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
