# PowerShell script to update Udemy references
$days = 1..30

foreach ($day in $days) {
    $dayFolder = "Day$day"
    
    # Update README.md
    $readmePath = Join-Path $dayFolder "README.md"
    if (Test-Path $readmePath) {
        $content = Get-Content $readmePath -Raw
        $content = $content -replace '- \*\*Udemy\*\*: Watch the following videos:', '- Watch the following topics:'
        $content = $content -replace '- \*\*Udemy\*\*: .*', '- Watch the following topics:'
        $content = $content -replace '- \*\*Udemy Videos\*\*:', '- **Videos**:'
        $content = $content -replace '- \[x\] I have watched the required Udemy videos', '- [x] I have watched the required videos'
        $content = $content -replace '- \[ \] I have watched the required Udemy videos', '- [ ] I have watched the required videos'
        $content = $content -replace '- \[x\] I have watched.* Udemy videos.*', '- [x] I have watched the required videos'
        $content = $content -replace '- \[ \] I have watched.* Udemy videos.*', '- [ ] I have watched the required videos'
        $content = $content -replace '- \[ \] I have finished watching the Udemy videos.*', '- [ ] I have finished watching the required videos'
        $content = $content -replace '- \[ \] I have rewatched the Udemy videos.*', '- [ ] I have rewatched the required videos'
        $content = $content -replace '- \[Udemy Course on Terraform\].*', ''
        $content = $content -replace 'Udemy.*course', 'video course'
        $content = $content -replace 'Udemy.*Course', 'Video Course'
        Set-Content $readmePath $content
    }
    
    # Update tasks.md
    $tasksPath = Join-Path $dayFolder "tasks.md"
    if (Test-Path $tasksPath) {
        $content = Get-Content $tasksPath -Raw
        $content = $content -replace '2\. \*\*Udemy Videos\*\*: Watch the following videos:', '2. **Videos**: Watch the following topics:'
        $content = $content -replace '2\. \*\*Udemy Videos\*\*:', '2. **Videos**:'
        Set-Content $tasksPath $content
    }
    
    # Update submission template
    $submissionPath = Join-Path $dayFolder "Submissions/submission_template.md"
    if (Test-Path $submissionPath) {
        $content = Get-Content $submissionPath -Raw
        $content = $content -replace '- \[ \] Completed Udemy Videos.*', '- [ ] Completed Required Videos'
        Set-Content $submissionPath $content
    }
}

# Update root README.md and other files
$rootFiles = @("README.md", "CERTIFICATION_PREP.md")
foreach ($file in $rootFiles) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $content = $content -replace "Udemy's.*Course", "Video Course"
        $content = $content -replace "Udemy.*course", "video course"
        $content = $content -replace "Udemy.*Course", "Video Course"
        Set-Content $file $content
    }
} 