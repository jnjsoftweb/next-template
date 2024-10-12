# 실행 방법
# ```powershell
# .\_scripts\tree.ps1 -ExcludedDirs @('.git', '.next', 'node_modules') -OutputFile "custom_tree.json" -IncludeFiles:$false
# ```

# ```cmd
# chcp 65001
# pwsh -NoProfile -ExecutionPolicy Bypass -File .\_scripts\tree.ps1 -ExcludedDirs @('.git', '.next', 'node_modules') -OutputFile ".\_docs\tree\custom_tree.json" -IncludeFiles:$false
# # powershell -NoProfile -InputFormat UTF8 -ExecutionPolicy Bypass -File .\_scripts\tree.ps1
# ```

param (
    [string[]]$ExcludedDirs = @('.git', '.next', 'node_modules', '_docs', '_settings', '_scripts', 'backend', 'pages'),
    [string]$OutputFile = "_docs/dev/tree_root.json",
    [switch]$IncludeFiles = $true
)

function Get-CustomTree($path) {
    $items = Get-ChildItem $path | Where-Object { $ExcludedDirs -notcontains $_.Name }

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
        } elseif ($IncludeFiles) {
            $files += $item.Name
        }
    }

    if ($IncludeFiles -and $files.Count -gt 0) {
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
$jsonOutput | Out-File -FilePath $OutputFile -Encoding utf8

Write-Host "트리 구조가 $OutputFile 에 JSON 형식으로 저장되었습니다."