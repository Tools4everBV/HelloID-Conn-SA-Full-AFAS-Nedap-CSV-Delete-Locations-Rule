$Path = $NedapOnsLocationMappingPath

$CSV = import-csv $Path -Delimiter ";"

$filteredCSV = foreach($line in $CSV){
    if(-not(($line.'Department.ExternalId' -eq $afasOrgUnits) -and ($line.NedapLocationIds -eq $nedapLocIds))){
        $line 
    }
}

$filteredCSV | ConvertTo-Csv -NoTypeInformation -Delimiter ";" | % {$_.Replace('"','')} | Out-File $Path
