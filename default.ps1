properties {
  $base_dir = resolve-path .\.
  $source_dir = "$base_dir\src"
  $build_artifacts_dir = "$base_dir\build_artifacts"
  $test_dir = "$source_dir\PsakeTest.Test\bin\Release"
  $tools_dir = "$base_dir\tools"
  $config = "Release"
}

task default -depends Test

task Test -depends Compile, Clean { 
	$testassemblies = get-childitem $test_dir -recurse -include *.Test.dll
	exec { & $tools_dir\NUnit-2.6.0.12051\nunit-console.exe $testassemblies /framework:net-4.0 /exclude:Acceptance /nologo /nodots /xml=$build_artifacts_dir\tests_results.xml;}
	
  'Executed Tests!'
}

task Compile -depends Clean { 
  MsBuild $source_dir\PsakeTest.sln /t:Clean /t:Build /p:Configuration=$config 
  'Executed Compile!'
}

task Clean { 
	rd $build_artifacts_dir -recurse -force  -ErrorAction SilentlyContinue | out-null
	mkdir $build_artifacts_dir  -ErrorAction SilentlyContinue  | out-null
	'Executed Clean!'
}

task AcceptanceTest -depends Compile, Clean { 
	$testassemblies = get-childitem $test_dir -recurse -include *.Test.dll
	exec { & $tools_dir\NUnit-2.6.0.12051\nunit-console.exe $testassemblies /framework:net-4.0 /include:Acceptance /nologo /nodots /xml=$build_artifacts_dir\acceptance_tests_results.xml; }
	
	'Executed Acceptance Tests!'
}

task Package -depends Compile, Clean, Test {
	'Packaged!'
}

task Full -depends Clean, Compile, Test, AcceptanceTest, Package{
}

task ? -Description "Helper to display task info" {
	Write-Documentation
}