param (
    [string]$destinationDirectory = "D:\Localgit\test_clone\gomi" # コピー先ディレクトリを指定
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
        Copy-Item $source -Destination $newDestination -Recurse
    } else {
        Copy-Item $source -Destination $destination -Recurse
    }
}

if (-not (Test-Path $destinationDirectory)) {
    Write-Error "指定されたディレクトリは存在しません: $destinationDirectory"
    exit 1
}

$sourceDirectory = Get-Location

Get-ChildItem $sourceDirectory -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Substring($sourceDirectory.ToString().Length)
    $destinationPath = Join-Path $destinationDirectory $relativePath

    if ($_.PSIsContainer) {
        Copy-ItemWithRename -source $_.FullName -destination $destinationPath
    } else {
        Copy-ItemWithRename -source $_.FullName -destination $destinationPath
    }
}
