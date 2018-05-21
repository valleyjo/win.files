$env:dotfiles = "c:\dev\win.files"
$env:sublime = "%programfiles%\Sublime Text 3\sublime_text.exe"
$env:pad = "C:\Program Files (x86)\Notepad++\notepad++.exe"
$env:path += ";c:\dev;"
$env:path += $env:dotfiles

Set-Alias -Name "subl" -Value $env:sublime
Set-Alias -Name "pad" -Value $env:pad
Function devd { Set-Location -Path 'c:\dev' }
Function dfd { Set-Location -Path $env:dotfiles }

function q() {
    $str = $args -join " ";
    $str = [uri]::EscapeDataString($str);
    Start-Process "http://bing.com/?q=$($str)";
}

function Convert-PathToVimStyle([string] $path) {
   # make path shorter like tabs in Vim,
   # handle paths starting with \\ and . correctly
   return ($path -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
}

Function ts([string]$machine, [switch]$multimon) {
    $commandStr = "mstsc /v alexval-$($machine)"
    if ($multimon) { $commandStr += " /multimon" }
    else { $commandStr += " /f" } # default is full screen
    Invoke-Expression -Command $commandStr
}

function Format-Path([string] $path) {
   $loc = $path -ireplace 'd:\\one\\azure\\compute\\src', '%srcroot%'
   $loc = $path.Replace($home, '~')
   # remove prefix for UNC paths
   $loc = $loc -replace '^[^:]+::', ''
   if ($ver -ne $null) { $loc = $ver; }
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
