Param(
	[string]$Path = './app',
	[string]$DestinationPath = './'
)
$date = Get-Date -format "dd-MM-yyyy"
Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"