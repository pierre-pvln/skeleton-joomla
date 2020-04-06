:: Name:     default_code_files.cmd
:: Purpose:  Create any missing default files
:: Author:   pierre@pvln.nl
:: Revision: 2020 03 12 - initial version
::
:: Required environment variables
:: ==============================
:: - VERBOSE                      how verbose output should be if not set script sets it to YES
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
:: ACTUAL CODE
:: ======================
IF %VERBOSE%==YES ECHO [%~n0 ] ... Start creating files for %extensionFolderPath%/code.

IF NOT EXIST %extensionFolderPath%/code (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder %extensionFolderPath%/code not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD %extensionFolderPath%/code
	IF NOT EXIST "README.md" (
		ECHO --- 
		ECHO # README file for the %extensionFolderName% Joomla! extension
		ECHO --- 
	) >README.md
	
	IF NOT EXIST src (
		SET ERROR_MESSAGE=[ERROR] [%~n0 ] folder %extensionFolderPath%/code/src not found ...
		GOTO ERROR_EXIT_SUBSCRIPT
	)
	CD src
		IF NOT EXIST "README.md" (
			ECHO --- 
			ECHO # README file for the actual code 
			ECHO --- 
		) >README.md
		IF NOT EXIST "CHANGELOG.md" (
			ECHO --- 
			ECHO #  Changelog for the %extensionFolderName% Joomla! code
			ECHO ---
			ECHO ^<h4^>v.0.0.1 %date:~9,4%-%date:~6,2%-%date:~3,2%^</h4^>
			ECHO ^<ul^>
			ECHO ^<li^>Initial version^</li^>
			ECHO ^</ul^>
		) >CHANGELOG.md
		IF NOT EXIST "_version.txt" (
			ECHO # Name:          _version.txt
			ECHO # Purpose:       set the versioning elements to a value
			ECHO # Author:        pierre@pvln.nl
			ECHO #
			ECHO # For extension: %extensionFolderName%
			ECHO #
 			ECHO # Using Semantic Versioning 2.0.0 
			ECHO # Major.Minor.[patch]
			ECHO #
			ECHO # In summary:
			ECHO # Major releases indicate a break in backward compatibility.
			ECHO # - change of folder structure
			ECHO # - change of file name of generic files
			ECHO #
			ECHO # Minor releases indicate the addition of new features or a significant change to existing features.
			ECHO # 
			ECHO # Patch releases indicate that bugs have been fixed.
			ECHO # 
			ECHO # Dev releases indicate work in progress.
			ECHO # 
			ECHO # Changes should be commented in CHANGELOG.md
			ECHO #
			ECHO majorversion=0
			ECHO minorversion=0
			ECHO patchversion=1
			ECHO devversion=1
		) >_version.txt
	CD ..
	
	IF NOT EXIST doc (
		SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder %extensionFolderPath%/code/doc not found.
		GOTO ERROR_EXIT_SUBSCRIPT
	)		
	CD doc
		IF NOT EXIST "README.md" (
			ECHO --- 
			ECHO # Folder with additional documentation for %extensionFolderName% extension
			ECHO --- 
		) >README.md
	CD ..

	IF NOT EXIST tst (
		SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder %extensionFolderPath%/code/tst not found.
		GOTO ERROR_EXIT_SUBSCRIPT
	)		
	CD tst
		IF NOT EXIST "README.md" (
			ECHO --- 
			ECHO # Folder with testing scripts for source code
			ECHO --- 
		) >README.md
		IF NOT EXIST "CHANGELOG.md" (
			ECHO --- 
			ECHO #  Changelog for the %extensionFolderName% Joomla! test code:
			ECHO ---
			ECHO ^<h4^>v.0.0.1 %date:~9,4%-%date:~6,2%-%date:~3,2%^</h4^>
			ECHO ^<ul^>
			ECHO ^<li^>Initial version^</li^>
			ECHO ^</ul^>
		) >CHANGELOG.md
	CD ..
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for %extensionFolderPath%/code created succesfully.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
