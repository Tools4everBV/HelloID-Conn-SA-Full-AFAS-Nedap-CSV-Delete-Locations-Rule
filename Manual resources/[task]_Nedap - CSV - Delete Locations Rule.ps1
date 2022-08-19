$afasOrgUnits = $form.locationRules.AFASOEid
$nedapLocIds = $form.locationRules.NedapLocationIds

$path = $NedapOnsLocationMappingPath

$CSV = import-csv $Path -Delimiter ";"

$filteredCSV = foreach($line in $CSV){
    if(-not(($line.'Department.ExternalId' -eq $afasOrgUnits) -and ($line.NedapLocationIds -eq $nedapLocIds))){
        $line 
    }
}

$filteredCSV | ConvertTo-Csv -NoTypeInformation -Delimiter ";" | ForEach-Object {$_.Replace('"','')} | Out-File $path

$Log = @{
    Action            = "Undefined" # optional. ENUM (undefined = default) 
    System            = "NedapOns" # optional (free format text) 
    Message           = "Removed location rule for department [$afasOrgUnits] to Nedap Location id(s) [$nedapLocIds] from mapping file [$path]" # required (free format text) 
    IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
    TargetDisplayName = "$path" # optional (free format text) 
    TargetIdentifier  = "" # optional (free format text) 
}
#send result back  
Write-Information -Tags "Audit" -MessageData $log 
