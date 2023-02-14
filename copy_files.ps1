param(
    [string]$source,
    [string]$destination
)

if (!$source) {
    Write-Error "Error: Source file path is not specified."
    return
}

if (!(Test-Path $source)) {
    Write-Error "Error: Source file does not exist."
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

Copy-Item $source $destination
