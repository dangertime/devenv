$env:POSH_GIT_ENABLED = $true
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme ~/.omp/mytheme.omp.json

# posh-git settings
$GitPromptSettings.BranchColor.ForegroundColor = 0xC591E8

$GitPromptSettings.BeforeStatus.Text = ""
$GitPromptSettings.AfterStatus.Text = ""
#$GitPromptSettings.BeforeStatus.ForegroundColor = 0x5FAAE8
# $GitPromptSettings.AfterStatus.ForegroundColor = 0x5FAAE8

function gs() { git status }
function gaa() { git add --all }
function gc() { git commit }
function gp() { git push }
function gb() { git branch }
function gll() { git log }
function cdg() {cd C:\Git\}
