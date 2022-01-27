# Author: Maarten Camps

#Name Script: Create  Retention Policies 

#Required Modules
ExchangeOnlineManagement
ExchangeOnlineManagement

#connect to Microsoft 365 Compliance Center 
Connect-IPPSSession
#Settings for Adaptive Scope
$Scope = "Name of the Scope"
$CustomAttribute = "Attribute Value"
$LocationType = "Group"
$filterconditions = @{
     "Value" = $CustomAttribute
     "Operator" = "Equals"
     "Name" = "CustomAttribute1"
     }

# Settings for retention policy
$policy = "Policy Name (cannot be equal to Scope name)"
$comments = "Decsription of Policy"
$RetentionApplication = "Group:Exchange,SharePoint" #applies poicy on M365 Groups 

#Policy Rule Settings
$Rule = "Name of the Rule"
$retentionaction = "Keep" #Keep of Delete if retentionperiod has been expired
$expirationDateOption = "ModificationAgeInDays" #Data Modified attribute of File
#Calculate Retention in Days since policy required years expressed in days
[int]$DaysPerYear = "365"
[int]$Years = "7" #amount of years retention
$PolicyDays  = $DaysPerYear*$Years

#Create Adaptive Scope
New-AdaptiveScope -Name $Scope -LocationType $LocationType -FilterConditions $filterconditions -Comment $comments

#Create Retention Policy
New-RetentionCompliancePolicy  -Name $policy -AdaptiveScopeLocation $Scope  -Applications $RetentionApplication

#Create Policy Rule
New-RetentionComplianceRule -Name $rule -RetentionDuration $PolicyDays -ExpirationDateOption $expirationdateoption -RetentionComplianceAction $retentionaction -Policy $policy
