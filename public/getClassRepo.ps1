function Get-ClassRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter()][string]$Topic,
        [Parameter()][string]$Owner
   )

   process {

        $limit = 1000
        $attributes = "nameWithOwner,name"

        $owner = Resolve-Owner -Owner $Owner

        $command = 'gh repo list {owner} --limit {limt} --json {attributes}'
        $command = $command -replace "{owner}",$owner
        $command = $command -replace "{limt}",$limit
        $command = $command -replace "{attributes}",$attributes

        # check if $topic is not null or whitespaces
        if(![string]::IsNullOrWhiteSpace($Topic)){
            $command = $command + " --topic $Topic"
        }

        $result = Invoke-GhExpression $command
        
        #check if $result is null
        if(!$result){
            return $null
        }

        $ret = $result | Where-Object {$_.name -like $Name}

        return  $ret

   }

} Export-ModuleMember -Function Get-ClassRepo