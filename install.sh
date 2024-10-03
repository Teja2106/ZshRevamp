#!/bin/zsh

# Installing curl if not installed
if ! command -v curl >/dev/null 2>&1; then
	sudo apt install curl -y
fi

#Installing neovim if not installed
if ! command -v nvim >/dev/null 2>&1; then
	sudo apt install neovim -y
fi

#Installing zsh if not installed
if which zsh >/dev/null 2>&1; then
	sudo apt install zsh -y
fi

# Installing git if not installed
if which git >/dev/null 2>&1; then
	sudo apt install git -y
fi

# Checking if oh-my-zsh is installed or not
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "~/.oh-my-zsh directory exists."
	echo "Run --help or -h for more."
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

while getopts ":c:h" opt; do
	case $opt in
		c) #Change Theme
			THEME_NAME=$"OPTARG"
			change_theme="$THEME_NAME"
			exit 0
			;;

		h) #Help option
			echo "Usage: ./install.sh [-c (change_theme) <theme_name>] [-h (help)]"
			echo "	-c: Change zsh theme to the specified theme."
			echo "	-h: Show the help message."
			exit 0
			;;

		/?)
			echo "Invalid option: -$OPTARG" >&2;
			exit 1
			;;

		:)
			echo "Invalid -$OPTARG requires an argument." >&2
			exit 1
			;;

	esac
done


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