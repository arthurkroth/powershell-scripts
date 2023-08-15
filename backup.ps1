#Declaring the parameters
Param(
    [string]$Path = './app',
    [string]$DestinationPath = './',
    [switch]$PathIsWebApp
)
#Checking if the file to be backed up is either .js, .html or .css otherwise the script will stop.
If ($PathIsWebApp -eq $True) {
    Try {
        $ContainsApplicationFiles = "$((Get-ChildItem $Path).Extension | Sort-Object -Unique)" -match '\.js|\.html|\.css'
    If ( -Not $ContainsApplicationFiles) {
        Throw "Not a web app"
    } Else {
        Write-Host "Source files look good, continuing"
    }
} Catch {
    Throw "No backup created due to: $($_.Exception.Message)"
}
}
If (-Not (Test-Path $Path)) {
    Throw "The source directory $Path does not exist, please specify an existing directory"
}

#Variables
$date = Get-Date -format "dd-MM-yyyy"
$DestinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"

#Checking if the $DestinationFile is already present in the directory, if so the script won't run the backup.
If (-Not (Test-Path $DestinationFile)){
    Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
    Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"
} Else {
    Write-Host "Today's backup already exists"
}