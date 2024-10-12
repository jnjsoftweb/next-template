$excludedDirs = @('.git', '.next', 'node_modules')
$outputFile = "_docs/dev/tree_root2.json"

function Get-CustomTree($path) {
    $items = Get-ChildItem $path -Directory | Where-Object { $excludedDirs -notcontains $_.Name }

    $result = @{}
    foreach ($item in $items) {
        $children = Get-CustomTree $item.FullName
        if ($children.Count -eq 0) {
            $result[$item.Name] = @()
        } else {
            $result[$item.Name] = $children
        }
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