$env:dotfiles = "$env:HOMEDRIVE\dev\win.files"
$env:path += ";$env:HOMEDRIVE\dev;"
$env:path += $env:dotfiles
$env:path += ";${env:ProgramFiles(x86)}\vim\vim74"
$env:path += ";$env:ProgramFiles\Microsoft VS Code\bin"

. $env:dotfiles\functions.ps1

# Single line functions that serve more as aliases
Function devd { Set-Location -Path $env:HOMEDRIVE\dev }
Function dfd { Set-Location -Path $env:dotfiles }
Function d { Set-Location -path $env:d }
Function ~ { Set-Location -path ~ }
Function o { Explorer . }
Function . { Set-Location -path .. }
Function .. { Set-Location -path ..\.. }
Function ... { Set-Location -path ..\..\.. }
Function .... { Set-Location -path ..\..\..\.. }

Function psdir {
    $psdir = ""
    $profile.Split('\') | ? { $_ -notmatch ".ps1" } | % { $psdir += "$_\"; }
    $loc = Get-Location
    Push-Location $psdir
    Write-Host "Moved to $psdir"
    Write-Host "popd to get back to $loc"
}

function q() {
    $str = $args -join " ";
    $str = [uri]::EscapeDataString($str);
    Start-Process "http://bing.com/?q=$($str)";
}

Function Open-ExplorerWindowForRunningProcess {
   Param(
       [Parameter(mandatory=$true)][ValidateNotNullOrEmpty()][string]
       $processName,
       [Parameter(mandatory=$false)][Switch]
       $killProcess
   )
   $processes = Get-Process -Name $processName
   $path = ""
   if ($processes.Length -eq 1) { $path = $processes.Path }
   else { $path = $processes[0].Path }
   # explorer /select,"c:\path\to\my\file.txt"
   if ($path -ne "") { Start-Process -FilePath explorer.exe -ArgumentList "/select,""$path""" }
   if ($path -ne "" -and $killProcess) { Stop-Process -Name $processName }
}

function ts {
   Param(
       [Parameter(mandatory=$true)][ValidateNotNullOrEmpty()][string] $node,
       [Switch] $multimon,
       [string] $dimensions = [string]::Empty,
       [ValidateRange(1,100)][byte] $percentSize = 0, # % must be (0-100]
       [uint16] $width = 0,
       [uint16] $height = 0
   )

   $r = Test-NetConnection "alexval-$node"
   if (!$r.PingSucceeded) { return }

   $argList = "/v", "alexval-$node"
   [float]$percentSize = $percentSize / 100

   if ($percentSize -gt 0) {
       $obj = Get-WmiObject -Class Win32_DesktopMonitor
       $obj = Get-WmiObject -Class Win32_VideoController

       try {
           # width % coverage is working area of primary monitor - border width
           # multiply by two because % coverage is for the full rect not just one dimension
           $width = [System.Windows.Forms.SystemInformation]::WorkingArea.Width
           $width -= ([System.Windows.Forms.SystemInformation]::BorderSize.Width * 2) # border on each side
           $width *= $percentSize

           # height % coverage is working area of primary monitor - border width - title bar height
           $height = [System.Windows.Forms.SystemInformation]::WorkingArea.Height
           $height -= ([System.Windows.Forms.SystemInformation]::BorderSize.Height * 2) # border one each side
           $height -= [System.Windows.Forms.SystemInformation]::CaptionHeight
           $height *= $percentSize
           "Computed resolution of $width x $height"
       } catch {
           Write-Host "Cannot calculate percent size. Exiting..."
           return
       }
   } elseif (![string]::IsNullOrEmpty($dimensions)) {
       $values = $dimensions.Split('x');
       if ($values.Length -ne 2) {
           Write-Host "Invalid format for -dimensions. Expected something like: 1920x1080. Exiting..."
           return
       }
       $width = [uint16]::Parse($values[0])
       $height = [uint16]::Parse($values[1])
   }

   #fullscreen, multi-monitor
   if ($multimon) {
       $argList += "/multimon"
   # custom size. Can be set progrmatically with the percent coverage input
   } elseif (($width -gt 0) -and ($height -gt 0)) {
       $argList += @("/w:$width","/h:$height")
   #fullscreen, one monitor
   } else {
       $argList += "/f"
   }

   Start-Process -FilePath "mstsc.exe" -ArgumentList $argList
}

function Convert-PathToVimStyle([string] $path) {
   # make path shorter like tabs in Vim,
   # handle paths starting with \\ and . correctly
   return ($path -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
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
