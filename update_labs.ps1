# PowerShell script to update lab references
$labMappings = @{
    "Day1" = @("Lab 01: Installing Terraform", "Lab 02: Basic Terraform Commands")
    "Day2" = @("Lab 02: Basic Terraform Commands", "Lab 03: Terraform Providers")
    "Day3" = @("Lab 03: Terraform Providers", "Lab 04: Resource Blocks", "Lab 05: Data Sources")
    "Day4" = @("Lab 05: Data Sources", "Lab 06: Variables")
    "Day5" = @("Lab 06: Variables", "Lab 07: Output Values")
    "Day6" = @("Lab 07: Output Values", "Lab 08: State Management")
    "Day7" = @("Lab 08: State Management", "Lab 09: State Locking")
    "Day8" = @("Lab 09: State Locking", "Lab 10: Workspaces")
    "Day9" = @("Lab 10: Workspaces", "Lab 11: Modules")
    "Day10" = @("Lab 11: Modules", "Lab 12: Module Sources")
    "Day11" = @("Lab 12: Module Sources", "Lab 13: Module Composition")
    "Day12" = @("Lab 13: Module Composition", "Lab 14: Module Versioning")
    "Day13" = @("Lab 14: Module Versioning", "Lab 15: Terraform Testing")
    "Day14" = @("Lab 15: Terraform Testing", "Lab 16: Terraform CI/CD Integration")
    "Day15" = @("Lab 16: Terraform CI/CD Integration", "Lab 17: Remote State")
    "Day16" = @("Lab 17: Remote State", "Lab 18: State Migration")
    "Day17" = @("Lab 18: State Migration", "Lab 19: Import Existing Infrastructure")
    "Day18" = @("Lab 19: Import Existing Infrastructure", "Lab 20: Terraform Cloud")
    "Day19" = @("Lab 20: Terraform Cloud", "Lab 21: Terraform Enterprise")
    "Day20" = @("Lab 21: Terraform Enterprise", "Lab 22: Sentinel Policies")
    "Day21" = @("Lab 22: Sentinel Policies", "Lab 23: Cost Estimation")
    "Day22" = @("Lab 23: Cost Estimation", "Lab 24: Security Best Practices")
    "Day23" = @("Lab 24: Security Best Practices", "Lab 25: Compliance Automation")
    "Day24" = @("Lab 25: Compliance Automation", "Lab 26: Infrastructure Monitoring")
    "Day25" = @("Lab 26: Infrastructure Monitoring", "Lab 27: Disaster Recovery")
    "Day26" = @("Lab 27: Disaster Recovery", "Lab 28: Performance Optimization")
    "Day27" = @("Lab 28: Performance Optimization", "Lab 29: Advanced Workflows")
    "Day28" = @("Lab 29: Advanced Workflows", "Lab 30: Custom Providers")
    "Day29" = @("Lab 30: Custom Providers", "Lab 31: Provider Development")
    "Day30" = @("Lab 31: Provider Development", "Lab 32: Enterprise Integration")
}

foreach ($day in $labMappings.Keys) {
    $readmePath = Join-Path $day "README.md"
    $tasksPath = Join-Path $day "tasks.md"
    $submissionPath = Join-Path $day "Submissions/submission_template.md"
    
    if (Test-Path $readmePath) {
        $content = Get-Content $readmePath -Raw
        $labsSection = "### 2. **Hands-on Labs**`n   - **Lab**: Complete the following hands-on labs:`n"
        foreach ($lab in $labMappings[$day]) {
            $labsSection += "     - `"$lab`"`n"
        }
        $labsSection += "   - **Goal**: Gain hands-on experience with Terraform through practical exercises.`n"
        
        $content = $content -replace '### 2\. \*\*Videos\*\*[\s\S]*?(?=### 3\.)', $labsSection
        $content = $content -replace '- \[[ x]\] I have watched.*videos.*', '- [ ] I have completed the required hands-on labs'
        Set-Content $readmePath $content
    }
    
    if (Test-Path $tasksPath) {
        $content = Get-Content $tasksPath -Raw
        $labsSection = "2. **Hands-on Labs**: Complete the following labs:`n"
        foreach ($lab in $labMappings[$day]) {
            $labsSection += "   - `"$lab`"`n"
        }
        
        $content = $content -replace '2\. \*\*Videos\*\*[\s\S]*?(?=3\.)', $labsSection
        Set-Content $tasksPath $content
    }
    
    if (Test-Path $submissionPath) {
        $content = Get-Content $submissionPath -Raw
        $content = $content -replace '- \[ \] Completed.*Videos.*', '- [ ] Completed Required Hands-on Labs'
        Set-Content $submissionPath $content
    }
} 