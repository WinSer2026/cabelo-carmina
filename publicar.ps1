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

# Comprime uma imagem (JPEG, max 1200px, qualidade 82). Sem dependencias externas.
function Optimize-Image($path){
  try {
    Add-Type -AssemblyName System.Drawing -ErrorAction SilentlyContinue
    $img = [System.Drawing.Image]::FromFile($path)
    $maxW = 1200
    $ratio = [math]::Min(1, $maxW / $img.Width)
    $w = $img.Width; $h = $img.Height
    if ($ratio -lt 1) { $w = [int]($img.Width*$ratio); $h = [int]($img.Height*$ratio) }
    $bmp = New-Object System.Drawing.Bitmap($w,$h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($img,0,0,$w,$h)
    $enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
    $par = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $par.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 82)
    $new = [System.IO.Path]::ChangeExtension($path,'jpg')
    $bmp.Save($new,$enc,$par)
    $g.Dispose(); $bmp.Dispose(); $img.Dispose()
    if ($new -ne $path) { Remove-Item $path -Force }
  } catch { Write-Output ("  (nao foi possivel comprimir: " + [System.IO.Path]::GetFileName($path) + ")") }
}

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
  if ($okImg -contains $ext) { $dest = Join-Path $imgDir $f.Name; Copy-Item $f.FullName -Destination $dest -Force; Optimize-Image $dest; $moved++ }
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
