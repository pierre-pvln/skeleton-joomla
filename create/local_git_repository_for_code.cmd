:: Name:     local_git_repository_for_code.cmd
:: Purpose:  make the code folder a git repository and link it to the remote
:: Author:   pierre@pvln.nl
:: Revision: 2020 06 03 - initial version
::
:: Required environment variables
:: ==============================
:: - extensionFolderName          the name of the extension based on the top level foldername
:: - extensionFolderPath          the path to the extension based on the top level foldername

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
IF "%extensionFolderPath%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] ... extensionFolderPath environment variable not set.
   GOTO ERROR_EXIT_SUBSCRIPT
)

:: Create local git repository
::
CD %extensionFolderPath%/code

git init

git config --local user.name "Pierre Veelen (%extensionFolderName%)"
git config --local user.email pierre@pvln.nl
git config --local color.ui auto

:: list settings
git config --list

git add .
git commit -m "first commit"
git remote add origin git@github.com:pierre-pvln/%extensionFolderName%.git
git push -u origin master

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
