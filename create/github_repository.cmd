ECHO OFF
cd ..\..\..\..\_secrets

CALL git_settings.cmd

curl -u %git_username%:%git_password% -H "Content-Type: application/json"  -d "{\"name\":\"ipheiongraphs\"}" https://api.github.com/user/repos

PAUSE

cd C:\Users\pierr\OneDrive\@pvln_coding_PVE\_for_joomla\modules\IpheionGraphs\struc\create