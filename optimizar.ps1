<# optimizar.ps1 — Comprime as imagens da galeria (100% gratis, usa GDI+ do Windows).
   Reduz para largura maxima 1200px e JPEG qualidade 82, convertendo PNG/WEBP/BMP para .jpg.
   Uso:  powershell -ExecutionPolicy Bypass -File optimizar.ps1
#>
param($dir = (Join-Path $PSScriptRoot 'assets\imagens'))
Add-Type -AssemblyName System.Drawing
$quality = 82; $maxW = 1200
$cfg = @('.jpg','.jpeg','.png','.webp','.gif','.bmp')
Get-ChildItem $dir -File | Where-Object { $cfg -contains $_.Extension.ToLower() } | ForEach-Object {
  try {
    $img = [System.Drawing.Image]::FromFile($_.FullName)
    $ratio = [math]::Min(1, $maxW / $img.Width)
    $w = $img.Width; $h = $img.Height
    if ($ratio -lt 1) { $w = [int]($img.Width * $ratio); $h = [int]($img.Height * $ratio) }
    $bmp = New-Object System.Drawing.Bitmap($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($img, 0, 0, $w, $h)
    $enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
    $par = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $par.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, $quality)
    $newName = [System.IO.Path]::ChangeExtension($_.FullName, 'jpg')
    $bmp.Save($newName, $enc, $par)
    $g.Dispose(); $bmp.Dispose(); $img.Dispose()
    if ($newName -ne $_.FullName) { Remove-Item $_.FullName -Force }
  } catch { Write-Output ("Falhou (ignorado): " + $_.Name) }
}
Write-Output "Optimizacao concluida."
