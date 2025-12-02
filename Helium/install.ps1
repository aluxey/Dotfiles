[CmdletBinding()]
param(
    [string]$Profile = 'Default',
    [switch]$OpenMistStore
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Merge-JsonObject {
    param(
        [Parameter(Mandatory)]
        [psobject]$Target,

        [Parameter(Mandatory)]
        [psobject]$Source
    )

    foreach ($sourceProperty in $Source.PSObject.Properties) {
        $targetProperty = $Target.PSObject.Properties[$sourceProperty.Name]
        $sourceValue = $sourceProperty.Value

        if (
            $null -ne $targetProperty -and
            $targetProperty.Value -is [pscustomobject] -and
            $sourceValue -is [pscustomobject]
        ) {
            Merge-JsonObject -Target $targetProperty.Value -Source $sourceValue
            continue
        }

        if ($null -eq $targetProperty) {
            $Target | Add-Member -NotePropertyName $sourceProperty.Name -NotePropertyValue $sourceValue
        }
        else {
            $targetProperty.Value = $sourceValue
        }
    }
}

$localAppData = [Environment]::GetFolderPath('LocalApplicationData')
if ([string]::IsNullOrWhiteSpace($localAppData)) {
    throw 'LOCALAPPDATA est introuvable.'
}

$heliumRoot = Join-Path $localAppData 'imput\Helium'
$userDataRoot = Join-Path $heliumRoot 'User Data'
$profilePath = Join-Path $userDataRoot $Profile
$preferencesPath = Join-Path $profilePath 'Preferences'
$heliumExecutable = Join-Path $heliumRoot 'Application\chrome.exe'
$configurationPath = Join-Path $PSScriptRoot 'preferences.json'
$extensionsPath = Join-Path $PSScriptRoot 'extensions.json'

if (-not (Test-Path -LiteralPath $profilePath -PathType Container)) {
    throw "Le profil Helium '$Profile' est introuvable dans '$userDataRoot'."
}

$resolvedUserData = [IO.Path]::GetFullPath($userDataRoot + [IO.Path]::DirectorySeparatorChar)
$resolvedProfile = [IO.Path]::GetFullPath($profilePath + [IO.Path]::DirectorySeparatorChar)
if (-not $resolvedProfile.StartsWith($resolvedUserData, [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Le profil demandé se trouve en dehors du dossier Helium attendu.'
}

foreach ($requiredFile in @($preferencesPath, $configurationPath, $extensionsPath)) {
    if (-not (Test-Path -LiteralPath $requiredFile -PathType Leaf)) {
        throw "Fichier requis introuvable : $requiredFile"
    }
}

$resolvedHeliumRoot = [IO.Path]::GetFullPath($heliumRoot + [IO.Path]::DirectorySeparatorChar)
$runningHelium = @(
    Get-CimInstance Win32_Process -Filter "Name = 'chrome.exe'" |
        Where-Object {
            $_.ExecutablePath -and
            [IO.Path]::GetFullPath($_.ExecutablePath).StartsWith(
                $resolvedHeliumRoot,
                [StringComparison]::OrdinalIgnoreCase
            )
        }
)

if ($runningHelium.Count -gt 0) {
    throw 'Fermez complètement Helium avant d’appliquer la configuration.'
}

$preferences = Get-Content -LiteralPath $preferencesPath -Raw | ConvertFrom-Json
$configuration = Get-Content -LiteralPath $configurationPath -Raw | ConvertFrom-Json
Merge-JsonObject -Target $preferences -Source $configuration

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backupPath = "$preferencesPath.backup-$timestamp"
Copy-Item -LiteralPath $preferencesPath -Destination $backupPath

$temporaryPath = Join-Path $profilePath ("Preferences.dotfiles.{0}.tmp" -f [guid]::NewGuid().ToString('N'))
$serializedPreferences = $preferences | ConvertTo-Json -Depth 100 -Compress
[IO.File]::WriteAllText($temporaryPath, $serializedPreferences, [Text.UTF8Encoding]::new($false))
Move-Item -LiteralPath $temporaryPath -Destination $preferencesPath -Force

Write-Host "Configuration Helium appliquée. Sauvegarde : $backupPath"

if ($OpenMistStore) {
    if (-not (Test-Path -LiteralPath $heliumExecutable -PathType Leaf)) {
        throw "Exécutable Helium introuvable : $heliumExecutable"
    }

    $extensionManifest = Get-Content -LiteralPath $extensionsPath -Raw | ConvertFrom-Json
    $mistStoreUrl = $extensionManifest.extensions[0].storeUrl
    Start-Process -FilePath $heliumExecutable -ArgumentList $mistStoreUrl
    Write-Host 'La page Chrome Web Store de Mist a été ouverte dans Helium.'
}
