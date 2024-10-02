#!/bin/zsh

# Installing curl if not installed
if which curl >/dev/null 2>&1; then
	echo "*curl IS ALREADY INSTALLED*"
	echo "PATH: $(which curl)\n"
else
	sudo apt install curl -y
fi

#Installing neovim if not installed
if which nvim >/dev/null 2>&1; then
	echo "*neovim IS ALREADY INSTALLED*"
	echo "PATH: $(which nvim)\n"
else
	sudo apt install neovim -y
fi

#Installing zsh if not installed
if which zsh >/dev/null 2>&1; then
	echo "*zsh IS ALREADY INSTALLED*"
	echo "PATH: $(which zsh)\n"
else
	sudo apt install zsh -y
fi

# Installing git if not installed
if which git >/dev/null 2>&1; then
	echo "*git IS ALREADY INSTALLED*"
	echo "PATH: $(which git)\n"
else
	sudo apt install git -y
fi

# Checking if oh-my-zsh is installed or not
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "~/.oh-my-zsh directory exists."
	echo "\e[1;3;4mHelp yourself finding the 'oh-my-zsh' directory\e[0m\n$(ls -lah ~/)"
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Downloading the oh-my-zsh theme (you can use your favorite theme)
change_theme() {
	local NEW_THEME=$1
	local ZSHRC_FILE="$HOME/.zshrc"

	sed -i "11s/^ZSH_THEME=\".*\"/ZSH_THEME=\"$NEW_THEME\"/" "$ZSHRC_FILE"
	. "$ZSHRC_FILE"
	echo "Updated the theme."
	echo "*If the terminal doesn't look updated close and restart the shell.*"
	exit 0
}

if [ "$1" = "--change-theme" ] && [ -n "$2" ]; then
	echo "Enter the new zsh theme name\n"
	echo "If you don't know the theme name read the README file of the git repo: "
	THEME_NAME="$2"
	change_theme "$THEME_NAME"
	exit 0
fi

read -p "Enter the GitHub link for zsh theme: " GIT_LINK

BASE_DIR="$HOME/.zsh-themes"
mkdir -p "$BASE_DIR"

THEME_NAME=$(basename -s .git "$GIT_LINK")

TARGET_DIR="$BASE_DIR/$THEME_NAME"

if [ -d "$TARGET_DIR" ]; then
	echo "\e[3mTheme '$THEME_NAME' already exists in $BASE_DIR\e[0m"
	read -p "Would you like to pull the latest changes instead? (y/n): " choice
	if [[ "$choice" == 'y' ]]; then
		git -C "$TARGET_DIR" pull
	else
		echo "Skipping cloning/pull operation."
	fi
else
	git clone "$GIT_LINK" "$TARGET_DIR"
	echo "Cloned '$THEME_NAME' into $TARGET_DIR"
fi

if [ -f "$TARGET_DIR/$THEME_NAME" ]; then
	if [ ! -f "$ZSH/themes/$THEME_NAME" ]; then
		cp $TARGET_DIR/$THEME_NAME $ZSH/themes/$THEME_NAME
		echo "Copied '$THEME_NAME' to '$ZSH/themes/'"
	else
		echo "\e[1mFile '$THEME_NAME' already exists in '$ZSH/themes/'. Skipping copy.\e[0m"
	fi
else
	echo "The file '$THEME_NAME' doesn't exist in '$TARGET_DIR'"
	exit 1
fi

ZSHRC_FILE="$HOME/.zshrc"

echo "Enter the new zsh theme name\n"
read -p "If you don't know the theme name read the README file of the git repo: " NEW_THEME

sed -i "11s/^ZSH_THEME=\".*\"/ZSH_THEME=\"$NEW_THEME\"/" "$ZSHRC_FILE"
. "$ZSHRC_FILE"
echo "Updated the theme."
echo "*If the terminal doesn't look updated close and restart the shell.*"

update_theme "$NEW_THEME"