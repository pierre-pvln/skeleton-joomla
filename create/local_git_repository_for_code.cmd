SET extensionfoldername=ipheiongeojsons

cd ..\..\code

dir
pause

git init

git config --local user.name "Pierre Veelen (%extensionFolderName%)"
git config --local user.email pierre@pvln.nl
git config --local color.ui auto

# list settings
git config --list
pause

git add .
git commit -m "first commit"
git remote add origin git@github.com:pierre-pvln/%extensionfoldername%.git
git push -u origin master

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
EXIT /B %CURL_RESPONSE_CODE%

:CLEAN_EXIT_SUBSCRIPT   
EXIT /B 0
