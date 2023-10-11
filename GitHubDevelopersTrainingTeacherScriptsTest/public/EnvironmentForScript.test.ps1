
function GitHubDevelopersTrainingTeacherScriptsTest_EnvironmentForScript_Set{
    Clear-EnvironmentForScript

    # Set with WhatIf
    $result = Set-EnvironmentForScript -ApiUrl "api.bit21.eu" -Owner "validOwer" -HostUrl "bit21.eu" @WarningParameters
 
    Assert-Count -Expected 0 -Presented $warningVar

    Assert-IsNotNull -Object $result
    Assert-AreEqual -Expected "api.bit21.eu" -Presented $result.ApiUrl
    Assert-AreEqual -Expected "validOwer" -Presented $result.Owner
    Assert-AreEqual -Expected "bit21.eu" -Presented $result.HostUrl

    # confirm that is has not set value
    $result = Get-EnvironmentForScript

    Assert-IsNotNull -Object $result
    Assert-AreEqual -Expected "api.bit21.eu" -Presented $result.ApiUrl
    Assert-AreEqual -Expected "validOwer" -Presented $result.Owner
    Assert-AreEqual -Expected "bit21.eu" -Presented $result.HostUrl

    Clear-EnvironmentForScript
}

function GitHubDevelopersTrainingTeacherScriptsTest_EnvironmentForScript_Set_Whatif{

    Clear-EnvironmentForScript

    # Set with WhatIf
    $result = Set-EnvironmentForScript -ApiUrl "api.bit21.eu" -Owner "validOwer" -HostUrl "bit21.eu" -WhatIf @WarningParameters @InfoParameters

    Assert-Count -Expected 0 -Presented $warningVar
    Assert-Contains -Expected "api.bit21.eu, bit21.eu, validOwer" -Presented $infoVar

    Assert-IsNotNull -Object $result
    Assert-AreEqual -Expected "api.bit21.eu" -Presented $result.ApiUrl
    Assert-AreEqual -Expected "validOwer" -Presented $result.Owner
    Assert-AreEqual -Expected "bit21.eu" -Presented $result.HostUrl

}


function GitHubDevelopersTrainingTeacherScriptsTest_EnvironmentForScript_Set_WrongApiUrl{

    Clear-EnvironmentForScript
    
    $result = Set-EnvironmentForScript -ApiUrl " " -Owner "validOwer" -HostUrl "bit21.eu" -WhatIf @WarningParameters
    
    Assert-IsNull -Object $result
    Assert-Count -Expected 1 -Presented $warningVar
    Assert-Contains -Expected "ApiUrl is not set" -Presented $warningVar
    
    Clear-EnvironmentForScript
}
