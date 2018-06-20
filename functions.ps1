Function Write-Title {
    param ([String] $title, [int16] $width = 80, [String] $char = "-")

    if ($title -eq "" -or $null -eq $title)
    {
        $title = $char * $width
    }
    elseif ($title.Length -lt $width)
    {
        $padding = $char * (($width - 2 - $title.Length) / 2)
        $title = "$padding $title $padding"

        if ($title.Length -eq ($width - 1))
        {
            $title += $char
        }
    }

    return $title
}

Function Write-TruncatedString($str) {
    process {
        $consoleWidth = 80; #default width of 80

        if ($Host -and $Host.UI -and $Host.UI.RawUI -and $host.UI.RawUI.BufferSize ) {
            $consoleWidth = $Host.UI.RawUI.BufferSize.Width
        }
        
        if ($str.Length -le $consoleWidth) {
            Write-Host $str
        } else {
            Write-Host "$($str.Substring(0, $consoleWidth - 3))..."
        }
    }
}