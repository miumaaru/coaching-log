# coaching-log-publisher スキル インストーラー
$skillFile = "C:\Users\maaru\Dev\claude\input\coaching-log\coaching-log-publisher.skill"
$skillsDir = "C:\Users\maaru\AppData\Roaming\Claude\local-agent-mode-sessions\skills-plugin\247f8225-95ef-4108-b0bd-71cf1124cb88\4ec6452e-ef14-45be-8945-8bd21b3a3755\skills\coaching-log-publisher"

New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null
Expand-Archive -Path $skillFile -DestinationPath $skillsDir -Force
Write-Host "✅ スキルをインストールしました！Coworkを再起動してください。"
