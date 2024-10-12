$excludedDirs = @('.git', '.next', 'node_modules', '_docs', '_settings', '_scripts', 'backend', 'pages')
$outputFile = "_docs/dev/tree_root.json"

function Get-CustomTree($path) {
    $items = Get-ChildItem $path | Where-Object { $excludedDirs -notcontains $_.Name }

    $result = @{}
    $files = @()

    foreach ($item in $items) {
        if ($item.PSIsContainer) {
            $children = Get-CustomTree $item.FullName
            if ($children.Count -eq 0) {
                $result[$item.Name] = @()
            } else {
                $result[$item.Name] = $children
            }
        } else {
            $files += $item.Name
        }
    }

    if ($files.Count -gt 0) {
        $result["_files"] = $files
    }

    return $result
}

$currentPath = Get-Location
$treeStructure = @{
    (Split-Path $currentPath -Leaf) = Get-CustomTree $currentPath
}

# JSON 파일로 저장
$jsonOutput = $treeStructure | ConvertTo-Json -Depth 100 -Compress
$jsonOutput | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "트리 구조가 $outputFile 에 JSON 형식으로 저장되었습니다."