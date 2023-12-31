function GitHubDevelopersTrainingTeacherScriptsTest_ClassRepos_Get{

    # $result = Get-ClassRepo -name "rulasg" -owner "ps-developers-sandbox" 

    $result = Get-ClassRepo -name "repopattern" -owner "ownername" -whatif @InfoParameters

    Assert-IsNull $result

    # Assert-Contains -Expected "gh repo list ownername --limit 1000 --json nameWithOwner,name" -Presented $infovar.messageData
    Assert-Contains -Expected "gh search repos repopattern in:name --owner ownername --json fullName,name" -Presented $infovar.MessageData
}

function GitHubDevelopersTrainingTeacherScriptsTest_ClassRepos_Get_Envirement{

    # $result = Get-ClassRepo -name "rulasg" -topic rulasg

    Set-EnvironmentForScript -Owner "ownerName2323"

    $result = Get-ClassRepo -name "repopattern" -whatif @InfoParameters

    Assert-IsNull $result

    # Assert-Contains -Expected "gh repo list ownerName2323 --limit 1000 --json nameWithOwner,name --topic topicName" -Presented $infovar.messageData
    Assert-Contains -Expected "gh search repos repopattern in:name --owner ownerName2323 --json fullName,name" -Presented $infovar.messageData

    Clear-EnvironmentForScript
}