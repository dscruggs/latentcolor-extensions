[CmdletBinding()]
param([string]$Version, [string]$InstallDir = $env:LATENTCOLOR_INSTALL_DIR)
$ErrorActionPreference = 'Stop'
$repo = 'dscruggs/latentcolor-extensions'
if ([string]::IsNullOrWhiteSpace($InstallDir)) { $InstallDir = Join-Path $env:LOCALAPPDATA 'Programs\\LatentColor' }
if (-not [Environment]::Is64BitOperatingSystem) { throw 'LatentColor publishes only 64-bit Windows executables.' }
$arch = if ([System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture -eq 'Arm64') { 'arm64' } else { 'amd64' }
if ([string]::IsNullOrWhiteSpace($Version)) { $archive = "latentcolor-windows-$arch.zip"; $sums = 'checksums.txt'; $base = "https://github.com/$repo/releases/latest/download" } else { $tag = if ($Version.StartsWith('v')) { $Version } else { "v$Version" }; $archive = "latentcolor-$tag-windows-$arch.zip"; $sums = "latentcolor-$tag-checksums.txt"; $base = "https://github.com/$repo/releases/download/$tag" }
$tmp = Join-Path ([IO.Path]::GetTempPath()) ("latentcolor-install-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $tmp | Out-Null
try {
  $sumPath = Join-Path $tmp 'checksums.txt'; $archivePath = Join-Path $tmp $archive
  Invoke-WebRequest -Uri "$base/$sums" -OutFile $sumPath; Invoke-WebRequest -Uri "$base/$archive" -OutFile $archivePath
  $expected = (Get-Content $sumPath | ForEach-Object { $parts = $_ -split '\s+', 2; if ($parts.Count -eq 2 -and $parts[1] -eq $archive) { $parts[0] } } | Select-Object -First 1)
  $actual = (Get-FileHash -Algorithm SHA256 -LiteralPath $archivePath).Hash.ToLowerInvariant()
  if ([string]::IsNullOrWhiteSpace($expected) -or $actual -ne $expected.ToLowerInvariant()) { throw 'Checksum verification failed.' }
  Expand-Archive -LiteralPath $archivePath -DestinationPath $tmp -Force
  $binary = Join-Path $tmp 'latentcolor.exe'; if (-not (Test-Path -LiteralPath $binary -PathType Leaf)) { throw 'Archive has no LatentColor executable.' }
  New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null; Copy-Item $binary (Join-Path $InstallDir 'latentcolor.exe') -Force
  Write-Output "Installed $InstallDir\\latentcolor.exe"
} finally { Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue }
