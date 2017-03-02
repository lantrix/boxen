Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name Pester -Scope CurrentUser -Verbose -Force -SkipPublisherCheck
Install-Module -Name AzureRM -Scope CurrentUser -Verbose
Install-Module -Name posh-git -Scope CurrentUser -Verbose
Install-Module -Name AWSPowerShell -Scope CurrentUser -Verbose
