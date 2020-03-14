:: Name:     missing_files.cmd
:: Purpose:  Create any missing default files projects folders
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 25 - initial version
::           2020 03 12 - updated to new folder structure
::

@ECHO off
SETLOCAL ENABLEEXTENSIONS

pause
cd
pause
set
pause


:: Create default files
::
CALL ./default_binary_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_binary_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL ./default_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL ./temporary_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script temporary_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL ./build_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script build_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL ./deploy_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script deploy_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL ./default_miscellaneous_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script default_miscellaneous_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL ./code_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script code_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL ./staging_settings_files.cmd
IF %ERRORLEVEL% NEQ 0 (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Script staging_settings_files.cmd returned error %ERRORLEVEL%
   GOTO ERROR_EXIT_SUBSCRIPT
)

CALL ./structure_settings_files.cmd
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
