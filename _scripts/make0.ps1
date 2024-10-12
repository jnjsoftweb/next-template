# JSON 파일 경로
$jsonFilePath = "_docs/dev/tree_root.json"

# JSON 파일 읽기
$jsonContent = Get-Content $jsonFilePath -Raw | ConvertFrom-Json

# 재귀적으로 디렉토리와 파일 생성하는 함수
function Create-Structure($structure, $path) {
    foreach ($key in $structure.PSObject.Properties.Name) {
        $fullPath = Join-Path $path $key
        if ($key -eq "_files") {
            foreach ($file in $structure.$key) {
                $filePath = Join-Path $path $file
                if (!(Test-Path $filePath)) {
                    New-Item -ItemType File -Path $filePath -Force | Out-Null
                    Write-Host "File created: $filePath"
                }
            }
        } else {
            if (!(Test-Path $fullPath)) {
                New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
                Write-Host "Directory created: $fullPath"
            }
            if ($structure.$key -is [PSCustomObject]) {
                Create-Structure $structure.$key $fullPath
            }
        }
    }
}

# 루트 디렉토리 이름 가져오기
$rootDirName = $jsonContent.PSObject.Properties.Name

# 구조 생성 시작
Create-Structure $jsonContent.$rootDirName $rootDirName

Write-Host "Structure creation completed"