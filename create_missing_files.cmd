:: Name:     create_mising_files.cmd
:: Purpose:  Create any missing default files projects folders
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 25 - initial version
::           2020 03 12 - updated to new folder structure
::
:: Required environment variables
:: ==============================
:: - VERBOSE         			  how verbose output should be if not set script sets it to YES
:: - extensionFolderName          the name of the extension based on the top level foldername
:: - extensionType				  the type of extension
:: - extensionName				  the name of the extension

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
IF "%extensionName%" == "" (
   SET extensionName=^<extensionname^>
)
IF "%extensionType%" == "" (
   SET extensionType=^<extensiontype^>
)

:: Create default files
::
:: ======================
:: OUTPUT SHARED BINARIES
:: ======================
IF NOT EXIST _bin (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder _bin not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD _bin	 
IF NOT EXIST "README.md" (
	ECHO ---
	ECHO # Used to place output binaries like zip's etc. from scripts.
	ECHO # Files in this folder are shared between different scripts.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for _bin created succesfully.
CD ..

:: ======================
:: SHARED SETTINGS
:: ======================
IF NOT EXIST _set (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder _set not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD _set
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Used to place settings specific for the Joomla Extension.
	ECHO # Files in this folder are shared between different scripts.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for _set created succesfully.
CD ..

:: ======================
:: SHARED TEMPORARY FILES
:: ======================
IF NOT EXIST _tmp (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder _tmp not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD _tmp
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Used to place temporary output files from scripts.
	ECHO # Folder is shared between different scripts.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for _tmp created succesfully.
CD ..

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

:: ======================
:: DEPLOYMENT SCRIPTS
:: ======================
IF NOT EXIST dpl (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder dpl not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD dpl
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Generic Deployment Process Scripts
	ECHO --- 		
	ECHO Generic deployment scripts for Joomla! website extensions.^<br/^>
	ECHO ^<br/^>
	ECHO * Documentation and download extension: http://www.pvln.nl/deploy-joomla-extensions^<br/^>
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
 	ECHO ^<br/^>
	ECHO The downloadable extension .zip file is available at:
	ECHO ```
	ECHO download.pvln.nl/joomla/%extensionType%/%extensionName%/
	ECHO ```
	ECHO ^<br/^>
	ECHO The downloadable extension update .xml file is available at:
	ECHO ```
	ECHO update.pvln.nl/joomla/%extensionType%/%extensionName%/
	ECHO ```
	) >README.md
IF NOT EXIST "CHANGELOG.md" (
	ECHO --- 
	ECHO #  Changelog Scripts: Generic Joomla! extension deployment scripts
	ECHO ---
	ECHO ^<h4^>v.0.0.1 %date:~9,4%-%date:~6,2%-%date:~3,2%^</h4^>
	ECHO ^<ul^>
	ECHO ^<li^>Initial version^</li^>
	ECHO ^</ul^>
	) >CHANGELOG.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for dpl created succesfully.
CD ..

:: ======================
:: MISCELLANEOUS
:: ======================
IF NOT EXIST misc (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder misc not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD misc
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Folder for miscellaneous info for the %extensionFolderName% Joomla! extension.
	ECHO ---
	) >README.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for misc created succesfully.
CD ..

:: ======================
:: ACTUAL CODE
:: ======================
IF NOT EXIST code (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder code not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD code
	IF NOT EXIST "README.md" (
		ECHO --- 
		ECHO # README file for the %extensionFolderName% Joomla! extension
		ECHO --- 
	) >README.md
	
	IF NOT EXIST src (
		SET ERROR_MESSAGE=[ERROR] [%~n0 ] folder code/src not found ...
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
			ECHO # Changes should be commented in CHANGELOG.md
			ECHO #
			ECHO majorversion=0
			ECHO minorversion=0
			ECHO patchversion=1
		) >_version.txt
	CD ..
	
	IF NOT EXIST doc (
		SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder code/src not found.
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
		SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder code/tst not found.
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

IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for code created succesfully.
CD ..

:: ======================
:: STAGING SCRIPTS
:: ======================
IF NOT EXIST stg (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder stg not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD stg
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Generic Staging Process Scripts
	ECHO --- 		
	ECHO Generic deployment scripts for Joomla! website extensions.^<br/^>
	ECHO ^<br/^>
	ECHO * Documentation and download extension: http://www.pvln.nl/stage-joomla-extensions^<br/^>
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
 	ECHO ^<br/^>
	ECHO The downloadable extension .zip file is available at:
	ECHO ```
	ECHO download.pvln.nl/joomla/%extensionType%/%extensionName%/
	ECHO ```
	ECHO ^<br/^>
	ECHO The downloadable extension update .xml file is available at:
	ECHO ```
	ECHO update.pvln.nl/joomla/%extensionType%/%extensionName%/
	ECHO ```
	) >README.md
IF NOT EXIST "CHANGELOG.md" (
	ECHO --- 
	ECHO #  Changelog Scripts: Generic Joomla! extension staging scripts
	ECHO ---
	ECHO ^<h4^>v.0.0.1 %date:~9,4%-%date:~6,2%-%date:~3,2%^</h4^>
	ECHO ^<ul^>
	ECHO ^<li^>Initial version^</li^>
	ECHO ^</ul^>
	) >CHANGELOG.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for stg created succesfully.
CD ..

:: ======================
:: STRUCTURE SCRIPTS
:: ======================
IF NOT EXIST struc (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... folder struc not found.
   GOTO ERROR_EXIT_SUBSCRIPT
)
CD struc
IF NOT EXIST "README.md" (
	ECHO --- 
	ECHO # Scripts to create the default local Joomla! development environment
	ECHO --- 
	) >README.md
IF NOT EXIST "CHANGELOG.md" (
	ECHO --- 
	ECHO #  Changelog Scripts: Generic Joomla! extension structure creation scripts
	ECHO ---
	ECHO ^<h4^>v.0.0.1 %date:~9,4%-%date:~6,2%-%date:~3,2%^</h4^>
	ECHO ^<ul^>
	ECHO ^<li^>Initial version^</li^>
	ECHO ^</ul^>
	) >CHANGELOG.md
IF %VERBOSE%==YES ECHO [%~n0 ] ... Files for struc created succesfully.
CD ..

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
