function GitHubDevelopersTrainingTeacherScriptsTest_trainingUsers_Get{

    $result = Get-ClassUsers -ClassRepo "rulasg-231010" -WhatIf @InfoParameters

    Assert-IsNull -Object $result

    Assert-Contains -Expected 'gh issue list -R ps-developers-sandbox/rulasg-231010 --json title,number -s all' -Presented $infoVar
    Assert-Contains -Expected 'gh issue view 1  -R ps-developers-sandbox/rulasg-231010 --json body' -Presented $infoVar
}