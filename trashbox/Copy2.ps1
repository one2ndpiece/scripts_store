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

Get-ChildItem $sourceDirectory -Directory -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Substring($sourceDirectory.ToString().Length)
    $destinationPath = Join-Path $destinationDirectory $relativePath

    Copy-ItemWithRename -source $_.FullName -destination $destinationPath
}

Get-ChildItem $sourceDirectory -File -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Substring($sourceDirectory.ToString().Length)
    $destinationPath = Join-Path $destinationDirectory $relativePath

    Copy-ItemWithRename -source $_.FullName -destination $destinationPath
}
