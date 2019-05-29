:: Name:     version.cmd
:: Purpose:  set the version as an environment variable
:: Author:   pierre.veelen@pvln.nl
:: Revision: 2018 07 16 - initial version
::           2018 08 21 - semantic versioning added
::           2019 05 29 - new method for setting version added 

:: Using Semantic Versioning (2.0.0) 
:: Major.Minor[.patch]
::
:: In summary:
:: Major releases indicate a break in backward compatibility.
:: - change of folder structure
:: - change of file name of generic files
::
:: Minor releases indicate the addition of new features or a significant change to existing features.
:: - Language files added
::
:: Patch releases indicate that bugs have been fixed.

:: Retrieving build version parameters for default settings
::
SET majorversion=""
SET minorversion=""
SET patchversion=""

IF NOT EXIST "..\code\src\_version.txt" (
   SET ERROR_MESSAGE=[ERROR] File ..\code\src\_version.txt with version parameters doesn't exist
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Read parameters file
:: Inspiration: http://www.robvanderwoude.com/battech_inputvalidation_commandline.php#ParameterFiles
::              https://ss64.com/nt/for_f.html
::
:: Remove comment lines
TYPE "..\code\src\_version.txt" | FINDSTR /v # >"..\_bin\version_clean.txt"
:: Check parameter file for unwanted characters
FINDSTR /R "( ) & ' ` \"" "..\_bin\version_clean.txt" > NUL
IF NOT ERRORLEVEL 1 (
	SET ERROR_MESSAGE=[ERROR] The parameter file contains unwanted characters, and cannot be parsed.
	GOTO ERROR_EXIT
)
:: Only parse the file if no unwanted characters were found
FOR /F "tokens=1,2 delims==" %%A IN ('FINDSTR /R /X /C:"[^=][^=]*=.*" "..\_bin\version_clean.txt" ') DO (
	SET %%A=%%B
)

IF "%majorversion%" == "" (
	ECHO [INFO ] The majorversion is not defined. Setting it to 0.
	SET majorversion=0
)
IF "%minorversion%" == "" (
	ECHO [INFO ]The minorversion is not defined. Setting it to 0.
	SET minorversion=0
)
IF "%patchversion%" == "" (
	ECHO [INFO ]The patchversion is not defined. Setting it to 0.
	SET patchversion=0
)

:: Remove cleaned version file
del "..\_bin\version_clean.txt"

SET version=v%majorversion%.%minorversion%.%patchversion%

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
::timeout /T 5
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
::timeout /T 5
EXIT /B 0
