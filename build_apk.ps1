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

    $buildArgs = @("--$Mode")
    if ($Mode -eq 'release') {
        # Ship phone-only, one APK per CPU architecture. This skips the
        # x86_64 (emulator / PC, e.g. BlueStacks) payload and keeps each APK
        # roughly half the size of the old universal build.
        $buildArgs += @(
            '--split-per-abi',
            '--target-platform', 'android-arm,android-arm64'
        )
    }

    flutter build apk @buildArgs

    $out = Join-Path $project "build\app\outputs\flutter-apk"
    New-Item -ItemType Directory -Path $out -Force | Out-Null

    $apks = Get-ChildItem "build\app\outputs\flutter-apk\app-*-$Mode.apk"
    if (-not $apks) { throw "No APK found for mode '$Mode'" }
    foreach ($apk in $apks) {
        Copy-Item $apk.FullName $out -Force
        Write-Host ""
        Write-Host "APK copied to: build\app\outputs\flutter-apk\$($apk.Name)"
    }
} finally {
    Pop-Location
}
