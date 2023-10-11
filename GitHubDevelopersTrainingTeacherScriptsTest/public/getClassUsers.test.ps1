function GitHubDevelopersTrainingTeacherScriptsTest_ClassUsers_Get{

    $owner = "ps-developers-sandbox"

    $result = Get-ClassUsers -ClassRepo "rulasg-231010" -WhatIf @InfoParameters

    Assert-IsNull -Object $result

    Assert-Contains -Expected "gh issue list -R $owner/rulasg-231010 --json title,number -s all" -Presented $infoVar
    Assert-Contains -Expected "gh issue view 1 -R $owner/rulasg-231010 --json body" -Presented $infoVar
}