:: Name:     remonte_github_repository.cmd
:: Purpose:  Create repository at github
:: Author:   pierre@pvln.nl
:: Revision: 2020 06 03 - initial version
::
:: Required environment variables
:: ==============================
:: - extensionFolderName          the name of the extension based on the top level foldername

@ECHO off
SETLOCAL ENABLEEXTENSIONS

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%extensionFolderName%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... extensionFolderName environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create github repository
::
SET "CURL_RESPONSE_CODE=" 

cd ..\..\_secrets
CALL git_settings.cmd

::curl -u %git_username%:%git_password% -H "Content-Type: application/json"  -d "{\"name\":\"%extensionfoldername%\"}" https://api.github.com/user/repos

FOR /f "tokens=*" %%G IN ('curl -u %git_username%:%git_password% -H "Content-Type: application/json" -d "{\"name\":\"%extensionFolderName%\"}" https://api.github.com/user/repos -w %%{http_code} -s') DO (
	SET CURL_RESPONSE_CODE=%%G
)

:: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/201  resource created
:: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/422  unable to process 

IF "%CURL_RESPONSE_CODE%" NEQ "201" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... Could not create github repository for %extensionFolderName%. Responsecode %CURL_RESPONSE_CODE%.
   GOTO ERROR_EXIT_SUBSCRIPT
)

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B %CURL_RESPONSE_CODE%

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
