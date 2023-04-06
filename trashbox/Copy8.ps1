param (
    [string]$destinationDirectory = "D:\Localgit\test_clone\gom" # コピー先ディレクトリを指定
)

$excludePs1Files = $true # .ps1 ファイルを除外するかどうかのフラグを指定。$true の場合は除外し、$false の場合は除外しない。

function Copy-ItemWithRename {
    param (
        [string]$source,
        [string]$destination,
        [bool]$isFile
    )

    if (Test-Path $destination) {
        $parentDirectory = Split-Path $destination -Parent
        if ($isFile) {
            $fileInfo = Get-Item $destination
            $fileExtension = $fileInfo.Extension
            $fileBaseName = $fileInfo.BaseName
            $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
            $newDestination = $parentDirectory + "\" + $fileBaseName + "_copy_" + $timestamp + $fileExtension
        } else {
            $folderInfo = Get-Item $destination
            $folderName = $folderInfo.Name
            $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
            $newDestination = $parentDirectory + "\" + $folderName + "_copy_" + $timestamp
        }
        Copy-Item $source -Destination $newDestination -Recurse
    } else {
        Copy-Item $source -Destination $destination -Recurse
    }
}

if (-not (Test-Path $destinationDirectory)) {
    Throw "指定されたディレクトリは存在しません: $destinationDirectory"
}

$sourceDirectory = Get-Location

Get-ChildItem $sourceDirectory -Directory -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Substring($sourceDirectory.ToString().Length)
    $destinationPath = Join-Path $destinationDirectory $relativePath

    Copy-ItemWithRename -source $_.FullName -destination $destinationPath -isFile $false
}

Get-ChildItem $sourceDirectory -File -Recurse | ForEach-Object {
    if ($excludePs1Files -and $_.Extension -eq ".ps1") {
        continue
    }

    $relativePath = $_.FullName.Substring($sourceDirectory.ToString().Length)
    $destinationPath = Join-Path $destinationDirectory $relativePath

    Copy-ItemWithRename -source $_.FullName -destination $destinationPath -isFile $true
}
