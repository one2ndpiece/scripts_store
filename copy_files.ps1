param(
    [string]$file,
    [string]$destination
)

if (!$file) {
    Write-Error "Error: File name is not specified."
    return
}

if (Test-Path -PathType Container $file) {
    Write-Error "Error: $file is a directory."
    return
}

$path = Resolve-Path $file

if ($path.Count -gt 1) {
    Write-Error "Error: Ambiguous file name."
    return
}

if (!(Test-Path $path.Path)) {
    Write-Error "Error: File does not exist."
    return
}

if (!$destination) {
    Write-Error "Error: Destination folder path is not specified."
    return
}

if (!(Test-Path $destination)) {
    Write-Error "Error: Destination folder does not exist."
    return
}

$files = Get-ChildItem -Path $path.Path -File

if ($files.Count -eq 0) {
    Write-Error "Error: No file found."
    return
}

foreach ($f in $files) {
    Copy-Item $f.FullName "$destination\$($f.Name)"
}
