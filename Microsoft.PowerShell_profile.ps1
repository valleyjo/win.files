function Convert-PathToVimStyle([string] $path) {
   # make path shorter like tabs in Vim,
   # handle paths starting with \\ and . correctly
   return ($path -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
}

function Format-Path([string] $path) {
   $loc = $path.Replace($HOME, '~')
   $loc = $path -ireplace 'd:\\one\\azure\\compute\\src', '%srcroot%'
   # remove prefix for UNC paths
   $loc = $loc -replace '^[^:]+::', ''
   if ($loc -match "c:\\fcshell\\fcshell.release.\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\\lib\\net45" -Or
       $loc -match "c:\\fcshell\\fcshell.release.\d{1,3}\.\d{1,3}\.\d{1,3}\\lib\\net45")
   {
       $loc = "FcShell"
   }
   return $loc
}

function prompt {
   # our theme
   $cdelim = [ConsoleColor]::DarkCyan
   $chost = [ConsoleColor]::Green
   $cloc = [ConsoleColor]::Cyan

   Write-Host
   Write-Host "$(Get-Date -Format G) " -n -f $cloc
   Write-Host ($env:computername) -n -f $chost
   Write-Host ' {' -n -f $cdelim
   Write-Host (Format-Path (Get-Location).Path) -n -f $cloc
   Write-Host '}' -f $cdelim
   Write-Host '$>' -n -f $chost
   return ' '
}
