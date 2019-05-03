for %%I in (.) do set extensionFolderName=%%~nxI
SET extensionFolderName=%extensionFolderName: =%
::
:: Convert extension to lowercase
:: http://www.robvanderwoude.com/battech_convertcase.php
::
FOR %%i IN ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO CALL SET "extensionFolderName=%%extensionFolderName:%%~i%%"
:: start git flow with default settings ( -d )
git flow init -d
:: create the featurebranch %extensionFolderName%
git flow feature start FROM_%extensionFolderNgame%
:: share this feature branch
git flow feature publish FROM_%extensionFolderName%
