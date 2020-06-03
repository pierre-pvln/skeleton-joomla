@ECHO OFF

cd ..\..\_secrets
CALL git_settings.cmd

SET "CURL_RESPONSE_CODE=" 

::curl -u %git_username%:%git_password% -H "Content-Type: application/json"  -d "{\"name\":\"%extensionfoldername%\"}" https://api.github.com/user/repos

FOR /f "tokens=*" %%G IN ('curl -u %git_username%:%git_password% -H "Content-Type: application/json" -d "{\"name\":\"%extensionfoldername%\"}" https://api.github.com/user/repos -w %%{http_code} -s') DO (
	SET CURL_RESPONSE_CODE=%%G
)

:: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/201  resource created
:: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/422  unable to process 

IF "%CURL_RESPONSE_CODE%" NEQ "201" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] Could not create github repository for %extensionfoldername% ...
   GOTO ERROR_EXIT_SUBSCRIPT
)

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B %CURL_RESPONSE_CODE%

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
