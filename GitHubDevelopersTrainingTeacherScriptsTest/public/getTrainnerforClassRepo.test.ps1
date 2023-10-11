function GitHubDevelopersTrainingTeacherScriptsTest_TeacherOfClassRepo_Get{

    $result = Get-TeacherOfConflictPracticeRepo -Owner "ps-developers-sandbox" -User AnaCaraban

    Assert-AreEqual -Expected "rulasg" -Presented $result.author.login

    $result = Get-TeacherOfConflictPracticeRepo -Owner "ps-developers-sandbox" -User AnaCaraban -Whatif @InfoParameters

    Assert-IsNull -Object $result
    Assert-Contains -Expected 'gh pr view 1 -R ps-developers-sandbox/conflict-practice-AnaCaraban --json author' -Presented $infoVar
}