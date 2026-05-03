$src     = "C:\Users\maaru\Dev\claude\input\coaching-log\coaching-log-publisher-SKILL.md"
$destDir = "C:\Users\maaru\AppData\Roaming\Claude\local-agent-mode-sessions\skills-plugin\247f8225-95ef-4108-b0bd-71cf1124cb88\4ec6452e-ef14-45be-8945-8bd21b3a3755\skills\coaching-log-publisher"
$dest    = "$destDir\SKILL.md"

Write-Host "Installing coaching-log-publisher skill..."
New-Item -ItemType Directory -Path $destDir -Force | Out-Null
Copy-Item -Path $src -Destination $dest -Force

if (Test-Path $dest) {
    Write-Host "OK: Skill installed. Please restart Cowork."
} else {
    Write-Host "FAILED: Could not install skill."
}
