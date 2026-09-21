param(
    [ValidateSet('release', 'debug')]
    [string]$Mode = 'release'
)

$ErrorActionPreference = 'Stop'
$project = $PSScriptRoot
$mirror = Join-Path $env:TEMP 'opencode\bahere_hasab_mirror'

Write-Host "Syncing sources to ASCII mirror: $mirror"
if (Test-Path $mirror) { Remove-Item -Recurse -Force $mirror }
New-Item -ItemType Directory -Path $mirror | Out-Null
robocopy $project $mirror /E /XD build .dart_tool .idea /NFL /NDL /NJH /NJS /NP | Out-Null
if ($LASTEXITCODE -ge 8) { throw 'robocopy failed' }

Push-Location $mirror
try {
    flutter pub get | Out-Null
    flutter build apk "--$Mode"
    $apk = "build\app\outputs\flutter-apk\app-$Mode.apk"
    if (Test-Path $apk) {
        $out = Join-Path $project "build\app\outputs\flutter-apk"
        New-Item -ItemType Directory -Path $out -Force | Out-Null
        Copy-Item $apk $out -Force
        Write-Host ""
        Write-Host "APK copied to: build\app\outputs\flutter-apk\app-$Mode.apk"
    }
} finally {
    Pop-Location
}