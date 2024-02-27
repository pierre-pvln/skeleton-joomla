:: Name:     local_git_repository_for_code.cmd
:: Purpose:  make the code folder a git repository and link it to the remote
:: Author:   pierre@pvln.nl
:: Revision: 2020 06 03 - initial version
::           2023 09 02 - added debug numbers 
::
:: Required environment variables
:: ==============================
:: - extensionFolderName          the name of the extension based on the top level foldername
:: - extensionFolderPath          the path to the extension based on the top level foldername
:: - githubDestination            the github username including git@github.com:

@ECHO off
SETLOCAL ENABLEEXTENSIONS

ECHO [%~n0 ] ... [0500]

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%extensionFolderName%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0501] extensionFolderName environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%extensionFolderPath%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0502] extensionFolderPath environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%githubDestination%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... [0503] githubDestination environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create local git repository
::
CD %extensionFolderPath%/code/src

IF %VERBOSE%==YES ECHO [%~n0 ] ... [0511] Git init.
git init

IF %VERBOSE%==YES ECHO [%~n0 ] ... [0512] Git config.
git config --local user.name "Pierre Veelen (%extensionFolderName%)"
git config --local user.email pierre@amultis.dev
git config --local color.ui auto

IF %VERBOSE%==YES ECHO [%~n0 ] ... [0513] Git show settings.
:: list settings
git config --list

IF %VERBOSE%==YES ECHO [%~n0 ] ... [0514] Git add files.
git add .

IF %VERBOSE%==YES ECHO [%~n0 ] ... [0515] Git first commit.
git commit -m "first commit"

IF %VERBOSE%==YES ECHO [%~n0 ] ... [0516] Git add remote detination %githubDestination%/%extensionFolderName%.git .
git remote add origin %githubDestination%/%extensionFolderName%.git

IF %VERBOSE%==YES ECHO [%~n0 ] ... [0517] Git push to remote.
git push -u origin master

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
