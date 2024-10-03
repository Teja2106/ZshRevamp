# ZshRevamp

## Overview

**ZshRevamp** is a script that simplifies the process of managing Zsh themes in a Linux environment. It automates theme installation, updates, and configuration by downloading themes from GitHub and applying them directly to your terminal setup. With **ZshRevamp**, you can easily customize your Zsh experience and switch between themes with minimal effort.

## Features
- **Automates Dependency Installation**: Automatically installs necessary dependencies such as `curl`, `git`, and `zsh`.
- **Automated Theme Installation**: Clone Zsh theme directly from GitHub with a simple command.
- **Dynamic Theme Management**: Switch between installed themes by modifying your `.zshrc` file.
- **Easy Updates**: Check for existing themes and pull the latest updates seamlessly.
- **Oh-My-Zsh Installation**: Install Oh-My-Zsh if it's not already installed on your system.

## Prerequisites

Before running **ZshRevamp**, ensure you have the following:
- **sudo** access: The script uses `sudo` for installing dependencies.
- **Zsh**: The Z shell, a powerful command-line shell.
- **Git**: Version control system used to clone repositories.

## Installation
1. **Clone the Repository**:
```bash
git clone https://github.com/Teja2106/ZshRevamp.git
cd ZshRevamp
```
2. **Make the script executable**:
```bash
chmod +x install.sh
```

3. **Run the script**:
```bash
sudo ./install.sh [OPTIONS]
```

## Options

| Flag              | Description                                       |
| -------------     | -------------                                     |
| `-h`              | Show help.                                        |
| `-d`              | Install dependencies                              |
| `-c <theme>`      | Change the Zsh theme to the specified theme.      |
| `-i`              | Install Oh-My-Zsh if it is not already installed  |
| `-g <git-link>`   | Install a Zsh theme from GitHub repository.       |

## Example
1. **Install Dependencies**:
```bash
./install.sh -d
```
This command installs the necessary dependencies like `curl`, `git`, and `zsh`.

2. **Change Theme**:
```bash
./install.sh -c <theme_name>
```
Changes the Zsh theme to `theme_name` (like 'agnoster', 'robbyrussell') by updating the `.zshrc` file.

3. **Install Oh-My-Zsh**:
```bash
./install.sh -i
```
Installs Oh-My-Zsh if not already installed.

4. **Install a Theme from GitHub**:
```bash
./install.sh -g https://github.com/<user>/<repo_name>.git
```
Clone the specified _theme_ from GitHub and installs it.

## Preferred Way
If you're looking for a streamlined process (mostly if you're new), here's the recommended way to use **ZshRevamp**:
1. **Update your packages**:
```bash
sudo apt update
```
2. **Run the command to install the dependencies**:
```bash
./install.sh -d
```
This is to check if you have all the necessary dependencies installed.

3. **Check which shell is running**:
```bash
echo $0
```
If the output is `/usr/bin/bash` run `zsh` in the terminal.