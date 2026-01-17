# 1. Rutas maestras
$repoRoot = "C:\Users\david\Documents\GitHub\RA3"
$masterLicense = Join-Path $repoRoot "LICENSE.md"
$masterReadme = Join-Path $repoRoot "README.md"

# 2. Obtener subcarpetas (excluyendo .git)
$subDirectories = Get-ChildItem -Path $repoRoot -Recurse -Directory | Where-Object { $_.FullName -notlike "*\.git*" }

foreach ($dir in $subDirectories) {
    # Buscamos si existe algún fichero readme o license sin importar mayúsculas
    $existingReadme = Get-ChildItem -Path $dir.FullName -Filter "readme.md" -ErrorAction SilentlyContinue
    $existingLicense = Get-ChildItem -Path $dir.FullName -Filter "license.md" -ErrorAction SilentlyContinue

    # 3. Sustituir y unificar a README.md (Mayúsculas)
    if ($existingReadme) {
        # Eliminamos el viejo (se llame como se llame) y ponemos el maestro
        Remove-Item $existingReadme.FullName -Force
        Copy-Item -Path $masterReadme -Destination (Join-Path $dir.FullName "README.md") -Force
        Write-Host "✅ Unificado a README.md en: $($dir.FullName)" -ForegroundColor Green
    }

    # 4. Sustituir y unificar a LICENSE.md
    if ($existingLicense) {
        Remove-Item $existingLicense.FullName -Force
        Copy-Item -Path $masterLicense -Destination (Join-Path $dir.FullName "LICENSE.md") -Force
        Write-Host "✅ Unificado a LICENSE.md en: $($dir.FullName)" -ForegroundColor Cyan
    }
}

Write-Host "`n🚀 ¡Sincronización completa!" -ForegroundColor Yellow
