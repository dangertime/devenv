oh-my-posh init pwsh --config ~/OneDrive/Documents/PowerShell/mytheme.omp.json | Invoke-Expression

function gs() { git status }
function gaa() { git add --all }
function gc() { git commit }
function gp() { git push }
function gb() { git branch }
function gll() { git log }
function cdg() {cd C:\repos\}

# Linux/bash aliases
function ll() { Get-ChildItem -Force @args }
function la() { Get-ChildItem -Force @args }
function ..() { Set-Location .. }
function ...() { Set-Location ../.. }
function touch($file) {
    if (Test-Path $file) { (Get-Item $file).LastWriteTime = Get-Date }
    else { New-Item $file -ItemType File }
}
function mkcd($dir) { New-Item -ItemType Directory -Path $dir | Set-Location }
function which($cmd) { Get-Command $cmd | Select-Object -ExpandProperty Source }
function head { param($n = 10) $input | Select-Object -First $n }
function tail { param($n = 10) $input | Select-Object -Last $n }
function df() { Get-PSDrive -PSProvider FileSystem | Format-Table Name, @{N='Used(GB)';E={[math]::Round($_.Used/1GB,2)}}, @{N='Free(GB)';E={[math]::Round($_.Free/1GB,2)}} }
function export($var) {
    $name, $value = $var -split '=', 2
    Set-Item -Path "env:$name" -Value $value
}
