:: Name:     connect_to_git.cmd
:: Purpose:  Connect folder to git repository
:: Author:   pierre@pvln.nl
:: Revision: 2019 04 30 - initial version
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

:: ==== BELOW SHOULD BE DONE FOR FOLDER bld dpl stg struc ======== 
SET git_username=pierre-pvln


:: ==
SET remote_git_repository=stage-joomla
SET local_git_repository=stg
:: ==

CD ./%local_git_repository%

IF %VERBOSE%==YES ECHO [%~n0 ] ... Currently running in %CD%
::
:: check if folder is under git control
::
IF %VERBOSE%==YES ECHO [%~n0 ] ... Check if folder is under git control
git status
:: if not initialize git in folder and set default values
IF %ERRORLEVEL% NEQ 0 (
   IF %VERBOSE%==YES ECHO [%~n0 ] ... This folder is not under git control: Initializing git
   git clone git@github.com:%git_username%/%remote_git_repository%.git
   IF %ERRORLEVEL% NEQ 0 (
		SET ERROR_MESSAGE=[ERROR] [%~n0 ] Remote reporitory git@github.com:%git_username%/%remote_git_repository%.git not found ...
		GOTO ERROR_EXIT_SUBSCRIPT
   )
   git config --local user.name Pierre Veelen
   git config --local user.email pierre@pvln.nl
   git config --local color.ui auto
)
IF %VERBOSE%==YES ECHO [%~n0 ] ... This folder is under git control





GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
