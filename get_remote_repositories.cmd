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
::
:: inspiration: http://batcheero.blogspot.com/2007/06/how-to-enabledelayedexpansion.html
:: using ENABLEDELAYEDEXPANSION and !env-var! ensures correct operation of script 
::
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
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

SET git_username=pierre-pvln

SET remote_git_repository=build-joomla
SET local_git_repository=bld
CALL:GIT_FLOW_INIT

SET remote_git_repository=stage-joomla
SET local_git_repository=stg
CALL:GIT_FLOW_INIT

SET remote_git_repository=deploy-joomla
SET local_git_repository=dpl
CALL:GIT_FLOW_INIT

SET remote_git_repository=skeleton-joomla
SET local_git_repository=struc
CALL:GIT_FLOW_INIT


GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0

::--------------------------------------------------------
::-- Function section starts below here
::--
::-- Inspiration: https://www.dostips.com/DtTutoFunctions.php
::-- 
::--------------------------------------------------------

:GIT_FLOW_INIT
:: Initializes git flow for folder local_git_repository
:: And links it to remote_git_repository
::
IF %VERBOSE%==YES (
	ECHO [%~n0 ] ... 
	ECHO [%~n0 ] ... Running GIT_FLOW_INIT for: %local_git_repository%
	ECHO [%~n0 ] ... 
)	
CD %local_git_repository%
IF %VERBOSE%==YES ECHO [%~n0 ] ... Currently running in %CD%
::
:: check if folder is under git control
::
IF %VERBOSE%==YES ECHO [%~n0 ] ... Check if folder is under git control
git status
:: if not clone repository in folder and set default values
IF %ERRORLEVEL% NEQ 0 (
   IF %VERBOSE%==YES ECHO [%~n0 ] ... This folder is not under git control: Initializing git
   CD ..
   git clone git@github.com:%git_username%/%remote_git_repository%.git %local_git_repository%

   CD %local_git_repository%
   IF %VERBOSE%==YES ECHO [%~n0 ] ... Currently running in %CD%
   git status
   IF !ERRORLEVEL! NEQ 0 (
		SET ERROR_MESSAGE=[ERROR] [%~n0 ] Remote repository git@github.com:%git_username%/%remote_git_repository%.git not found ...
		GOTO ERROR_EXIT_SUBSCRIPT
   )
   git config --local user.name Pierre Veelen
   git config --local user.email pierre@pvln.nl
   git config --local color.ui auto
)
IF %VERBOSE%==YES ECHO [%~n0 ] ... This folder is under git control

IF %VERBOSE%==YES ECHO [%~n0 ] ... Determine current local branch name
:: Get current branch in environment variable
:: https://ss64.com/nt/for_cmd.html
::
FOR /F %%G IN ('git rev-parse --abbrev-ref HEAD') DO SET currentGitBranch=%%G
:: remove spaces in name
:: http://www.dostips.com/DtTipsStringManipulation.php
:: 
SET currentGitBranch=%currentGitBranch: =%
:: show the result 
IF %VERBOSE%==YES ECHO [%~n0 ] ... Current branch: %currentGitBranch%
:: current git branch is determined 

IF "%currentGitBranch%" == "master" (
:: start git flow with default settings ( -d )
	git flow init -d
:: create the featurebranch %extensionFolderName%
	git flow feature start FROM_%extensionFolderName%
:: share this feature branch
	git flow feature publish FROM_%extensionFolderName%
)
CD ..
goto:eof
