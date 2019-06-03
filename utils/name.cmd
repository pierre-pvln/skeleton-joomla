:: Name:     name.cmd
:: Purpose:  set the extensionname as an environment variable
::           and add a prefix if required
:: Author:   pierre.veelen@pvln.nl
:: Revision: 2018 07 16 - initial version
::           2018 07 24 - build process unified and extension as environment variable
::           2018 08 21 - the name of the extension is its root folder unless otherwise specified
::           2019 05 29 - getting extension name and prefix from folder structure

:: -EXTENSION
:: use lowercase characters
:: and no spaces in the name
::
SET extension=

:: get the name of the folder in an environment variable
:: https://superuser.com/questions/160702/get-current-folder-name-by-a-dos-command
:: http://www.robvanderwoude.com/ntfor.php
::
IF "%extension%"=="" (
	CD ..\..
	FOR %%I IN (.) DO SET extension=%%~nxI
)

:: remove spaces in name
:: http://www.dostips.com/DtTipsStringManipulation.php
:: 
SET extension=%extension: =%

:: Convert extension to lowercase
:: http://www.robvanderwoude.com/battech_convertcase.php
::
FOR %%i IN ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO CALL SET "extension=%%extension:%%~i%%")

:: -EXTENSION PREFIX
::
:: components:	com_
:: libraries:   lib_
:: modules:		mod_
:: package:     pkg_
:: plugins:		plg_
:: templates:	<no prefix>
::
SET extensionprefix=

:: get the name of the folder in an environment variable
:: https://superuser.com/questions/160702/get-current-folder-name-by-a-dos-command
:: http://www.robvanderwoude.com/ntfor.php
::
IF "%extensionprefix%"=="" (
	CD ..
	FOR %%I IN (.) DO SET extensionprefix=%%~nxI
)

:: remove spaces in name
:: http://www.dostips.com/DtTipsStringManipulation.php
:: 
SET extensionprefix=%extensionprefix: =%

:: Convert extensionprefix to lowercase
:: http://www.robvanderwoude.com/battech_convertcase.php
::
FOR %%i IN ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO CALL SET "extensionprefix=%%extensionprefix:%%~i%%"

IF "%extensionprefix%"=="components" (SET extensionprefix=com_)
IF "%extensionprefix%"=="libraries"  (SET extensionprefix=lib_)
IF "%extensionprefix%"=="modules"    (SET extensionprefix=mod_)
IF "%extensionprefix%"=="packages"   (SET extensionprefix=pkg_)
IF "%extensionprefix%"=="plugins"    (SET extensionprefix=plg_)
IF "%extensionprefix%"=="templates"  (SET extensionprefix=)

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
::timeout /T 5
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
::timeout /T 5
EXIT /B 0
