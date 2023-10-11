function GitHubDevelopersTrainingTeacherScriptsTest_TeacherOfConflictPracticeRepo_Get{

    $result = Get-TeacherOfConflictPracticeRepo -Owner "ps-developers-sandbox" -User wulfland

    Assert-AreEqual -Expected "rulasg" -Presented $result.author.login

    $result = Get-TeacherOfConflictPracticeRepo -Owner "ps-developers-sandbox" -User AnaCaraban -Whatif @InfoParameters

    Assert-IsNull -Object $result
    Assert-Contains -Expected 'gh pr view 1 -R ps-developers-sandbox/conflict-practice-AnaCaraban --json author' -Presented $infoVar
}

function GitHubDevelopersTrainingTeacherScriptsTest_TeacherOfGithubGameRepo_Get{

    $result = Get-TeacherOfGithubGameRepo -Owner "ps-developers-sandbox" -User wulfland

    Assert-AreEqual -Expected "rulasg" -Presented $result.author.login

    $result = Get-TeacherOfGithubGameRepo -Owner "ps-developers-sandbox" -User AnaCaraban -Whatif @InfoParameters

    Assert-IsNull -Object $result
    Assert-Contains -Expected 'gh issue view 1 -R ps-developers-sandbox/github-games-AnaCaraban --json author' -Presented $infoVar
}