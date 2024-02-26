:: Name:     default_deploy_files.cmd
:: Purpose:  Create any missing default files
:: Author:   pierre@pvln.nl
:: Revision: 2020 03 12 - initial version
::           2023 09 02 - added debug numbers 
::
:: Required environment variables
:: ==============================
:: - VERBOSE                      how verbose output should be if not set script sets it to YES
:: - extensionFolderName          the name of the extension based on the top level foldername
:: - extensionType				  the type of extension
:: - extensionName				  the name of the extension

@ECHO off
SETLOCAL ENABLEEXTENSIONS

ECHO [%~n0 ] ... [0360]

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)
IF "%extensionFolderPath%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0361] extensionFolderPath environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%extensionName%" == "" (
   SET extensionName=^<extensionname^>
)
IF "%extensionType%" == "" (
   SET extensionType=^<extensiontype^>
)

:: Create default files
::
:: ======================
:: DEPLOYMENT SCRIPTS
:: ======================
IF %VERBOSE%==YES ECHO [%~n0 ] ... [0362] Start creating files for %extensionFolderPath%/dpl.

IF NOT EXIST %extensionFolderPath%/dpl (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0363] folder %extensionFolderPath%/dpl not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD %extensionFolderPath%/dpl
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO README.md in /dpl 
	ECHO # Generic Deployment Process Scripts
	ECHO --- 		
	ECHO Generic deployment scripts for Joomla! website extensions.^<br/^>
	ECHO ^<br/^>
	ECHO * Documentation and download extension: http://www.pvln.nl/deploy-joomla-extensions^<br/^>
	ECHO ^<br/^>
	ECHO Below folder structure should be present on the workstation on which development is done:^<br/^>
	ECHO.
	ECHO __Managed using git__
	ECHO ``` 
	ECHO ^<extensionname^>\code           folder with all code related items
	ECHO ^<extensionname^>\code\src       folder with the code for the Joomla! extension, which gets installed on the Joomla! website
	ECHO ^<extensionname^>\code\doc       documentation related to the source code
	ECHO ^<extensionname^>\code\set       specific settings for the extension
	ECHO ^<extensionname^>\code\tst       tests for the source code
	ECHO.			 
	ECHO ^<extensionname^>\bld            folder with scripts to build the extension zipfile
	ECHO.		 
	ECHO ^<extensionname^>\stg            folder with scripts to stage it to the update and download webserver ^<- THIS CODE
	ECHO.
	ECHO ^<extensionname^>\dpl            folder with generic deploy scripts for Joomla! website extensions
	ECHO. 
	ECHO ^<extensionname^>\struc          scripts to create the Joomla! deployment skeleton
	ECHO ```
	ECHO.
	ECHO ^<br/^>
	ECHO.
    ECHO __Not managed, only present at development workstation__
    ECHO ```
	ECHO ^<extensionname^>\misc           folder with relevant information links and inspiration, but not relevant for code
	ECHO ^<extensionname^>\misc\original  if relevant the original code which is changed in \code\src
	ECHO.
	ECHO ^<extensionname^>\_set           folder with settings used by various scripts. Files in this folder are shared between different scripts.
	ECHO.
	ECHO ^<extensionname^>\_bin           folder with the output files from scripts. Files in this folder are shared between different scripts.
	ECHO.
	ECHO ^<extensionname^>\_tmp           Folder used to place temporary output files from scripts. Files in this folder are shared between different scripts.
	ECHO ``` 
 	ECHO ^<br/^>
	ECHO The downloadable extension .zip file is available at:
	ECHO ```
	ECHO download.pvln.nl/joomla/^<extensiontype^>/^<extensionname^>/
	ECHO ```
	ECHO ^<br/^>
	ECHO The downloadable extension update .xml file is available at:
	ECHO ```
	ECHO update.pvln.nl/joomla/^<extensiontype^>/^<extensionname^>/
	ECHO ```
	) >README.md
IF NOT EXIST "CHANGELOG.md" (
	ECHO --- 
	ECHO #  Changelog Scripts: Generic Joomla! extension deployment scripts
	ECHO ---
	ECHO ^<h4^>v.0.0.1 %date:~6,4%_%date:~3,2%_%date:~0,2%^</h4^>
	ECHO ^<ul^>
	ECHO ^<li^>Initial version^</li^>
	ECHO ^</ul^>
	) >CHANGELOG.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... [0364] Files for %extensionFolderPath%/dpl created succesfully.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
