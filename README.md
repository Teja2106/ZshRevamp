# ZshRevamp

[![License](https://img.shields.io/github/license/Teja2106/ZshRevamp)](LICENSE)

If you're new to the world of Linux and often find yourself scrolling through [r/unixporn](https://www.reddit.com/r/unixporn/), awestruck by those jaw-dropping terminal setups-you're not alone! You've probably wondered how to make your terminal look just as sleek, stylish and downright cool but don't have a clue where to begin.\
**ZshRevamp** is here to bridge that gap for you.

ZshRevamp is a little project I put together to make things easier. Instead of you going through multiple blog posts, trying to figure out where the configuration files are and which line to modify in the configuration file. This script handles _everything_ for **you**, from changing the theme without you having to open the configuration file to downloading the external themes and adding it to the list of your themes.

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Options](#options)
5. [Installation and Usage](#installation-and-usage)
6. [Downloading and changing to an external theme](#downloading-and-changing-to-an-external-theme)
7. [Contributing](#contributing)

---

## About

**ZshRevamp** is a script that automates the process of changing your terminal theme in a Linux environment by [themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) that already comes with installation of [_Oh-My-Zsh_](https://ohmyz.sh/) or downloading [_external_](https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes) themes which can be applied after installing Oh-My-Zsh on the system.

## Features

- **Automated Theme Installation**: Clone themes directly from GitHub.
- **Dynamic Theme Management**: Easily switch between themes without touching a single configuration file.
- **Zsh Installation**: Includes an option to install Oh-My-Zsh for managing zsh themes.

## Prerequisites

Make sure you have **`git`** installed.
> The script will install **`curl`** and **`zsh`** if you do not have them installed.

## Options

| Flag              | Description                           |
| --------          | -------                               |
| `-h`              | Show help                             |
| `-d`              | Install dependencies                  |
| `-c <theme>`      | Change the theme                      |
| `-i`              | Install Oh-My-Zsh                     |
| `-g <git-link>`   | Download and install external theme   |

## Installation & Usage

1. **Clone the Repository**:
```bash
git clone https://github.com/Teja2106/ZshRevamp.git
cd ZshRevamp
```

2. **Make the install script executable**:
```bash
chmod +x install.sh
```

3. **Run the install script**:
```bash
./install.sh [OPIONS]
```

> If you're a newbie, then below is the best way of getting things done.

1. Update your packages:
```bash
sudo apt update
```
2. Clone the repository.
3. Make the script executable.
4. Install the dependencies:
```bash
./install.sh -d
```
5. Check which shell is being used:
```bash
echo $0
```
The output for the above command should be either `/usr/bin/bash` or `bash`.
> If your output was `/usr/bin/zsh` then you can directly skip to step 8.

6. Simply type `zsh` in the terminal and you'll be shown a set of options like this

![screenshot](https://cdn.discordapp.com/attachments/1161352335054864427/1291423019331489832/image.png?ex=67020529&is=6700b3a9&hm=0601beb11432d4d2cca28b74cf48330491f1ab9d14784a48fd3f54f809eb1421&)

7. Select the 2<sup>nd</sup> option by simply typing `0`.
8. Install _oh-my-zsh_.
```bash
./install.sh -i
```
After installation it'll you'll see

![screenshot](https://cdn.discordapp.com/attachments/1161352335054864427/1291428460887277669/image.png?ex=67020a3a&is=6700b8ba&hm=3b9bf42238f9a23885b9f071189c8e937b91472dbd2d9f8b6663f958b81d73da&)
Just type `y` and hit enter.

Upon successful installation of _oh my zsh_ you'll see

![screenshot](https://cdn.discordapp.com/attachments/1161352335054864427/1291430116886450187/image.png?ex=67020bc5&is=6700ba45&hm=e5b152fa5fd3ec4e5ac91772aa2ae4ebc32f75c0ded928300bb9197fa3ebe1fc&)
> Reboot your system after the installation.

- By default the theme would be _`robbyrussell`_ you can try changing it to _`agnoster`_ which is a pre-downloaded theme.
```bash
./install.sh -c agnoster
```
- Open a new terminal window and you'll see the changes.
 
## Downloading and changing to an external theme

You can checkout the external themes [here](https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes).

For this example I'll use the _simplerich-zsh-theme_ by **philip82148**.

```bash
./install.sh -g https://github.com/philip82148/simplerich-zsh-theme.git
```
It will download the and have it in the correct folder where the configuration file will be able to access it.

To change the theme to `simplerich` just run the command with `-c` flag.
```bash
./install.sh -c simplerich
```

## Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Submit a pull request.