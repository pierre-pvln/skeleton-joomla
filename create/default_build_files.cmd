:: Name:     default_build_files.cmd
:: Purpose:  Create any missing default files
:: Author:   pierre@pvln.nl
:: Revision: 2020 03 12 - initial version
::
:: Required environment variables
:: ==============================
:: - VERBOSE  how verbose output should be if not set script sets it to YES
:: - extensionFolderName          the name of the extension based on the top level foldername

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
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... extensionFolderName environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create default files
::
:: ======================
:: BUILD SCRIPTS
:: ======================
IF NOT EXIST bld (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder bld not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD bld
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Generic Build Process Scripts
	ECHO --- 		
	ECHO Generic build scripts for Joomla! website extensions.^<br/^>
	ECHO ^<br/^>
	ECHO * Documentation and download extension: http://www.pvln.nl/build-joomla-extensions^<br/^>
	ECHO ^<br/^>
	ECHO Below folder structure should be present on the workstation on which development is done:
	ECHO.
	ECHO ``` 
	ECHO %extensionFolderName%\code           folder with all code related items __(git managed)__
	ECHO %extensionFolderName%\code\src       folder with the code for the Joomla! extension, which gets installed on the Joomla! website
	ECHO %extensionFolderName%\code\doc       documentation related to the source code
	ECHO %extensionFolderName%\code\set       specific settings for the extension
	ECHO %extensionFolderName%\code\tst       tests for the source code
	ECHO.			 
	ECHO %extensionFolderName%\bld            folder with scripts to build the extension zipfile (^<- THIS CODE) __(git managed)__
	ECHO.		 
	ECHO %extensionFolderName%\stg            folder with scripts to stage it to the update and download webserver __(git managed)__
	ECHO.
	ECHO %extensionFolderName%\dpl            folder with generic deploy scripts for Joomla! website extensions __(git managed)__
	ECHO. 
	ECHO %extensionFolderName%\struc          scripts to create the Joomla! deployment skeleton __(git managed)__
	ECHO.
	ECHO %extensionFolderName%\misc           folder with relevant information links and inspiration, but not relevant for code
	ECHO %extensionFolderName%\misc\original  if relevant the original code which is changed in \code\src
	ECHO.
	ECHO %extensionFolderName%\_set           folder with settings used by various scripts. Files in this folder are shared between different scripts.
	ECHO.
	ECHO %extensionFolderName%\_bin           folder with the output files from scripts. Files in this folder are shared between different scripts.
	ECHO.
	ECHO %extensionFolderName%\_tmp           Folder used to place temporary output files from scripts. Files in this folder are shared between different scripts.
	ECHO ``` 
    ) >README.md
IF NOT EXIST "CHANGELOG.md" (
	ECHO --- 
	ECHO #  Changelog Scripts: Generic Joomla! extension build scripts
	ECHO ---
	ECHO ^<h4^>v.0.0.1 %date:~9,4%-%date:~6,2%-%date:~3,2%^</h4^>
	ECHO ^<ul^>
	ECHO ^<li^>Initial version^</li^>
	ECHO ^</ul^>
	) >CHANGELOG.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for bld created succesfully.
CD ..

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
