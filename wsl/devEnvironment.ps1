Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# RESTART NOW

wsl --set-default-version 2

choco install poshgit -y

refreshenv

# (Install Git in Windows machine (not WSL, but keys used for both))

prompt for git config:
git config --global user.name "BOJIT"
git config --global user.email "35117353+BOJIT@users.noreply.github.com"

ssh-keygen
Write-Output $(type "$HOME/.ssh/id_rsa.pub") | Set-Clipboard

# Get dotfiles
cd $HOME
git clone git@github.com:BOJIT/.dotfiles.git

# Get WSL2 Ubuntu (eventually get Arch, then run Arch installation script)
wsl.exe --install -d Ubuntu-20.04

# More Chocolatey Packages
choco install vscode sourcetree tabby -y

# WSL environment setup will be a separate script (run from the context of the WSL distro)

# note for copying keys to WSL https://devblogs.microsoft.com/commandline/sharing-ssh-keys-between-windows-and-wsl-2/
