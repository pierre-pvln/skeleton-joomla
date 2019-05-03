--- 
# Scripts to create the default local Joomla! development files and folder skeleton from several git repositories
--- 
## Initialize
Go to the directory in wich the Joomla! extension folder skeleton should be created
```
SET git_username=pierre-pvln
SET joomla_extensionname=MY_NEW_EXTENSION
IF NOT EXIST %joomla_extensionname%  (md %joomla_extensionname%)
cd %joomla_extensionname%
git clone git@github.com:%git_username%/structure-joomla.git struc
cd struc
_create-it-all.cmd
```
