param (
    [string]$destinationDirectory
)

function Copy-ItemWithRename {
    param (
        [string]$source,
        [string]$destination
    )

    if (Test-Path $destination) {
        $newDestination = $destination
        $index = 1
        while (Test-Path $newDestination) {
            $newDestination = $destination + "_コピー" * $index
            $index++
        }
        Copy-Item $source -Destination $newDestination
    } else {
        Copy-Item $source -Destination $destination
    }
}

if (-not (Test-Path $destinationDirectory)) {
    Write-Error "指定されたディレクトリは存在しません: $destinationDirectory"
    exit 1
}

$sourceDirectory = Get-Location

Get-ChildItem $sourceDirectory | ForEach-Object {
    $destinationPath = Join-Path $destinationDirectory $_.Name
    if ($_.PSIsContainer) {
        Copy-ItemWithRename -source $_.FullName -destination $destinationPath
    } else {
        Copy-ItemWithRename -source $_.FullName -destination $destinationPath
    }
}
