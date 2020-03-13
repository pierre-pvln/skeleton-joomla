:: Name:     create_folder_structure.cmd
:: Purpose:  Create the baseline folder structure for development projects
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 25 - initial version
::           2020 03 13 - set subfolder added 
::
:: Required environment variables
:: ==============================
:: - VERBOSE         			  how verbose output should be if not set script sets it to YES
:: - extensionFolderName          the name of the extension based on the top level foldername
::

@ECHO off
SETLOCAL ENABLEEXTENSIONS

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)
IF "%extensionFolderName%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] extensionFolderName environment variable not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create folder structure
::
IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating _bin
IF NOT EXIST _bin  (md _bin)

IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating _set	 
IF NOT EXIST _set  (md _set)

IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating _tmp
IF NOT EXIST _tmp  (md _tmp)

IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating bld
IF NOT EXIST bld   (md bld)

IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating dpl
IF NOT EXIST dpl   (md dpl)

IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating misc	 
IF NOT EXIST misc  (md misc)
	CD misc
		IF NOT EXIST original  (md original)
	CD ..

IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating code
IF NOT EXIST code   (md code)
	CD code
		IF NOT EXIST src  (md src)
		IF NOT EXIST doc  (md doc)
		IF NOT EXIST tst  (md tst)
		IF NOT EXIST set  (md set)
	CD ..

IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating stg 
IF NOT EXIST stg   (md stg)

IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating struc
IF NOT EXIST struc (md struc)


IF %VERBOSE%==YES ECHO [%~n0 ] ... Creating @_started_
IF NOT EXIST @_started_*      (md @_started_%date:~9,4%_%date:~6,2%_%date:~3,2%_@)

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
