--- 
# Scripts to create the default local Joomla! development files and folder skeleton from several git repositories
--- 
## Initialize
Go to the directory in which the Joomla! extension skeleton folder and files should be created
```
SET git_username=pierre-pvln
SET joomla_extensionname=MY_NEW_EXTENSION
IF NOT EXIST %joomla_extensionname%  (md %joomla_extensionname%)
cd %joomla_extensionname%
git clone git@github.com:%git_username%/skeleton-joomla.git struc
cd struc
_create-it-all.cmd
```
Git Flow has now been initiated for all the relevant directories.<br/>
The assumption is that during the development of the extension the build, stage, deploy or skeleton process might be updated also.<br/>
Therefore the folders \bld, \stg, \dpl, and \struc are swithed to branch: FROM_%joomla_extensionname%.<br/>
So we can merge them to production (master branch) and/or development (develop branch) at a later stage.

--- 
# Joomla! extension code
--- 

## When working on the Joomla! extension

The folder \code\src contains the code for the Joomla! extension.<br/>
The folder \code\tst contains the (if any) tests for the Joomla! extension.<br/>
The folder \code\doc contains the documentation for the Joomla! extension.<br/>

---
# Process scripts fo build, stage, deploy or skeleton
---

## After some changes

Push changes to remote git repository.
```
HOW TO DO THAT
```
## When changes are checked and can be merged to master 

Merge changes to ....
```
HOW TO DO THAT
```
