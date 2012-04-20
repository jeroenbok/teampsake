properties {
  $testMessage = 'Executed Test!'
  $compileMessage = 'Executed Compile!'
  $cleanMessage = 'Executed Clean!'
}

task default -depends Test

task Test -depends Compile, Clean { 
  $testMessage
}

task Compile -depends Clean { 
  MsBuild /t:Rebuild /p:Configuration=Release
  $compileMessage
}

task Clean { 
  $cleanMessage
}

task ? -Description "Helper to display task info" {
	Write-Documentation
}