function GitHubDevelopersTrainingTeacherScriptsTest_TeacherOfConflictPracticeRepo_Get{

    # $result = Get-TeacherOfConflictPracticeRepo -Owner "ps-developers-sandbox" -User tamatias
    # Assert-AreEqual -Expected "UncleBats" -Presented $result.author.login

    $result = Get-TeacherOfConflictPracticeRepo -User AnaCaraban -Whatif @InfoParameters

    Assert-IsNull -Object $result
    Assert-Contains -Expected 'gh pr view 1 -R ps-developers-sandbox/conflict-practice-AnaCaraban --json author' -Presented $infoVar
}

function GitHubDevelopersTrainingTeacherScriptsTest_TeacherOfGithubGameRepo_Get{

    # $result = Get-TeacherOfGithubGameRepo -Owner "ps-developers-sandbox" -User tamatias
    # Assert-AreEqual -Expected "UncleBats" -Presented $result.author.login

    $result = Get-TeacherOfGithubGameRepo -Owner "myorg" -User AnaCaraban -Whatif @InfoParameters

    Assert-IsNull -Object $result
    Assert-Contains -Expected 'gh issue view 1 -R myorg/github-games-AnaCaraban --json author' -Presented $infoVar
}