param (
    [string]$destinationDirectory = "D:\Localgit\test_clone\gomi" # コピー先ディレクトリを指定
)

$excludePs1Files = $false # .ps1 ファイルを除外するかどうかのフラグを指定。$true の場合は除外し、$false の場合は除外しない。

function Copy-ItemWithRename {
    param (
        [string]$source,
        [string]$destination
    )

    if (Test-Path $destination) {
        $fileInfo = Get-Item $destination
        $fileExtension = $fileInfo.Extension
        $fileBaseName = $fileInfo.BaseName
        $newDestination = $destination
        $timestamp=Get-Date -Format "yyyyMMdd_HHmmss"

        while (Test-Path $newDestination) {
            $newDestination = ($fileInfo.DirectoryName + "\" + $fileBaseName + "_copy" + $timestamp + $fileExtension)
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
    if ($excludePs1Files -and $_.Extension -eq ".ps1") {
        continue
    }

    $relativePath = $_.FullName.Substring($sourceDirectory.ToString().Length)
    $destinationPath = Join-Path $destinationDirectory $relativePath

    Copy-ItemWithRename -source $_.FullName -destination $destinationPath
}
