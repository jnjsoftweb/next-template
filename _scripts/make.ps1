param (
    [Parameter(Mandatory=$true)]
    [string]$JsonFilePath
)

# JSON 파일 읽기
$jsonContent = Get-Content $JsonFilePath -Raw | ConvertFrom-Json

# 재귀적으로 디렉토리와 파일 생성하는 함수
function Create-Structure($structure, $path) {
    # 디렉토리 생성
    if (!(Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Host "Directory created: $path"
    }

    if ($structure -is [Array]) {
        if ($structure.Count -eq 0) {
            $gitkeepPath = Join-Path $path ".gitkeep"
            if (!(Test-Path $gitkeepPath)) {
                New-Item -ItemType File -Path $gitkeepPath -Force | Out-Null
                Write-Host "Created .gitkeep file: $gitkeepPath"
            }
        }
    } elseif ($structure -is [PSCustomObject]) {
        foreach ($key in $structure.PSObject.Properties.Name) {
            $fullPath = Join-Path $path $key
            Create-Structure $structure.$key $fullPath
        }
    }
}

# 루트 디렉토리 이름 가져오기
$rootDirName = $jsonContent.PSObject.Properties.Name

# 구조 생성 시작
Create-Structure $jsonContent.$rootDirName $rootDirName

Write-Host "Structure creation completed"