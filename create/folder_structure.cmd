:: Name:     folder_structure.cmd
:: Purpose:  Create the baseline folder structure for development projects
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 25 - initial version
::           2020 03 13 - set subfolder added
::			 			- changed location of VERBOSE messages 
::           2023 06 29 - updated date spec 
::           2023 09 02 - added debug numbers 
::
:: Required environment variables
:: ==============================
:: - VERBOSE         			  how verbose output should be if not set script sets it to YES
:: - extensionFolderPath          the path to the extension based on the top level foldername
::

@ECHO off
SETLOCAL ENABLEEXTENSIONS

ECHO [%~n0 ] ... [0100]

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)

IF "%extensionFolderPath%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0101] extensionFolderPath environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)

CD %extensionFolderPath%

:: Create folder structure
::
IF NOT EXIST _bin (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0102] Creating _bin
	md _bin
)

IF NOT EXIST _set (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0103] Creating _set	 
	md _set
)

IF NOT EXIST _tmp (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0104] Creating _tmp
	md _tmp
)

IF NOT EXIST bld (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0105] Creating bld
	md bld
)

IF NOT EXIST dpl (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0106] Creating dpl
	md dpl
)

IF NOT EXIST misc (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0107] Creating misc	 
	md misc
)
	CD misc
		IF NOT EXIST original  (md original)
	CD ..

IF NOT EXIST code (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0108] Creating code
	md code
)
	CD code
		IF NOT EXIST src  (md src)
		IF NOT EXIST doc  (md doc)
		IF NOT EXIST tst  (md tst)
		IF NOT EXIST set  (md set)
	CD ..

IF NOT EXIST stg (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0109] Creating stg 
	md stg
)

IF NOT EXIST struc (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0110] Creating struc
	md struc
)

IF NOT EXIST @_started_* (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0111] Creating @_started_%date:~6,4%_%date:~3,2%_%date:~0,2%_@
	md @_started_%date:~6,4%_%date:~3,2%_%date:~0,2%_@
)

IF NOT EXIST @_%joomla_extensionname%_@ (
	IF %VERBOSE%==YES ECHO [%~n0 ] ... [0112] Creating @_%joomla_extensionname%_@
	md @_%joomla_extensionname%_@
)

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
