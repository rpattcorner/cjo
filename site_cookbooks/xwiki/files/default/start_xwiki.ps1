cd 'C:\Program Files (x86)\XWiki Enterprise 6.3\'
$A = Start-Process -FilePath 'C:\Program Files (x86)\XWiki Enterprise 6.3\start_xwiki.bat' -Wait -passthru;$a.ExitCode