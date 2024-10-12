$excludedDirs = @('.git', '.next', 'node_modules', '_docs', '_settings', '_scripts', 'backend', 'pages')
$outputFile = "_docs/dev/tree_root.json"

function Get-CustomTree($path) {
    $items = Get-ChildItem $path -Directory | Where-Object { $excludedDirs -notcontains $_.Name }

    $result = @()
    foreach ($item in $items) {
        $node = @{
            name = $item.Name
            children = @(Get-CustomTree $item.FullName)
        }
        $result += $node
    }

    return $result
}

$currentPath = Get-Location
$treeStructure = @{
    name = (Split-Path $currentPath -Leaf)
    children = @(Get-CustomTree $currentPath)
}

# JSON 파일로 저장
$jsonOutput = $treeStructure | ConvertTo-Json -Depth 100
$jsonOutput | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "트리 구조가 $outputFile 에 JSON 형식으로 저장되었습니다."