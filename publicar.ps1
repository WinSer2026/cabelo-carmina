<# publicar.ps1 — Processo para publicar novas fotos/videos na galeria do Cabelo Carmina
   Como funciona:
   1. A Carmina recebe as fotos/videos no WhatsApp (o visitante usa "Adicionar à galeria" no site).
   2. Ela guarda esses ficheiros na pasta:  assets\para-publicar
   3. Corre este script (duplo clique ou:  powershell -ExecutionPolicy Bypass -File publicar.ps1)
   4. O script copia para assets\imagens ou assets\videos, regenera a galeria e faz push ao GitHub.
   5. O GitHub Pages reconstrói o site sozinho em ~1 minuto.
#>
$ErrorActionPreference = 'Stop'
$base   = Split-Path -Parent $MyInvocation.MyCommand.Path
$inbox  = Join-Path $base 'assets\para-publicar'
$imgDir = Join-Path $base 'assets\imagens'
$vidDir = Join-Path $base 'assets\videos'
$arch   = Join-Path $base 'assets\publicado'
$okImg  = @('.jpg','.jpeg','.png','.webp','.gif','.avif')
$okVid  = @('.mp4','.webm','.ogg','.mov','.mkv')

if (-not (Test-Path $inbox)) {
  New-Item -ItemType Directory -Force -Path $inbox | Out-Null
  Write-Output "Pasta 'assets\para-publicar' criada. Coloque ai as fotos/videos e volte a correr o script."
  exit
}

$files = Get-ChildItem $inbox -File
if ($files.Count -eq 0) { Write-Output "Nenhum ficheiro na pasta 'para-publicar'."; exit }

$moved = 0
foreach ($f in $files) {
  $ext = $f.Extension.ToLower()
  if ($okImg -contains $ext) { Copy-Item $f.FullName -Destination (Join-Path $imgDir $f.Name) -Force; $moved++ }
  elseif ($okVid -contains $ext) { Copy-Item $f.FullName -Destination (Join-Path $vidDir $f.Name) -Force; $moved++ }
  else { Write-Output ("Ignorado (formato nao suportado): " + $f.Name); continue }
  if (-not (Test-Path $arch)) { New-Item -ItemType Directory -Force -Path $arch | Out-Null }
  Move-Item $f.FullName -Destination (Join-Path $arch $f.Name) -Force
}

# Regenera assets/galeria.js com as listas atualizadas
$jsPath = Join-Path $base 'assets\galeria.js'
$imgs = (Get-ChildItem $imgDir | Where-Object { $okImg -contains $_.Extension.ToLower() } | ForEach-Object { '"assets/imagens/' + $_.Name + '"' })
$vids = (Get-ChildItem $vidDir | ForEach-Object { '"assets/videos/' + $_.Name + '"' })
$js = "const GALERIA_IMAGENS = [`n" + ($imgs -join ",`n") + "`n];`nconst GALERIA_VIDEOS = [`n" + ($vids -join ",`n") + "`n];"
Set-Content -LiteralPath $jsPath -Value $js -Encoding utf8

# Commit e push (o GitHub Pages reconstrói automaticamente)
Set-Location $base
git add -A
git commit -q -m "Publicar novas fotos/videos da galeria"
git push -u origin main
Write-Output ("Concluido. Ficheiros publicados: $moved")
