--- 
# Scripts to create the default local Joomla! development files and folder skeleton from several git repositories
--- 
## Initialize
Go to the directory in wich the Joomla! extension skeleton folder and files should be created
```
SET git_username=pierre-pvln
SET joomla_extensionname=MY_NEW_EXTENSION
IF NOT EXIST %joomla_extensionname%  (md %joomla_extensionname%)
cd %joomla_extensionname%
git clone git@github.com:%git_username%/skeleton-joomla.git struc
cd struc
_create-it-all.cmd
```
Git Flow has now been created for all the relevant directories.
The assumption is that during the development of the extension the build, stage, deploy or skeleton process might be updated also.
Therefore the folders \bld, \stg, \dpl, and \struc are swithed to branch: FROM_%joomla_extensionname%.<br/>
So we can merge them to production (master branch) and/or development (develop branch) at a later stage.
## Working on the Joomla! extension
The folders \code\src contains the code for the Joomla! extension


