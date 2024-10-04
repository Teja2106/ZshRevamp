#! /bin/bash

install_deps() {
	local cmd=$1
	local pkg=$2
	if ! command -v $cmd >/dev/null 2>&1; then
		echo "Installing $pkg..."
		sudo apt install $pkg -y
	else
		echo "$pkg is already installed."
	fi
}

while getopts "hidc:g:" flag; do
	case $flag in
		h)
			echo "Usage: ./install.sh [OPTIONS]"
			echo "Options:"
			echo "  -h, ------------- Show help"
			echo "  -d, ------------- Install dependencies"
			echo "  -c <theme>, ----- Change the theme"
			echo "  -i, ------------- Install oh-my-zsh"
			echo "  -g <git-link>, -- Install a theme from git"
			;;
		d)
			install_deps "curl" "curl"
			install_deps "zsh" "zsh"
			;;
		c)
			ZSHRC_FILE="$HOME/.zshrc"

			sed -i "11s/^ZSH_THEME=\".*\"/ZSH_THEME=\"$OPTARG\"/" "$ZSHRC_FILE"
			source "$ZSHRC_FILE"
			echo "Updated the theme."
			echo "\e[1;3;4mIf the terminal doesn't look updated close and restart the shell.\e[0m"
			;;

		i)
			if [ -d "$HOME/.oh-my-zsh" ]; then
				echo "~/.oh-my-zsh directory exists."
				echo "Run -h for more."
			else
				sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
				echo "\e[1;3;4mRestart your shell.\e[0m"
			fi
			;;

		g)
			BASE_DIR="$HOME/.zsh-themes"
			mkdir -p "$BASE_DIR"
			GIT_DIR=$(basename -s .git "$OPTARG")

			TARGET_DIR="$BASE_DIR/$GIT_DIR"
			git clone "$OPTARG" "$TARGET_DIR"
			echo "Cloned '$GIT_DIR' into $TARGET_DIR"

			ZSH_THEME_FILE=$(find "$TARGET_DIR" -type f -name "*.zsh-theme" | head -n 1)
			if [ -n "$ZSH_THEME_FILE" ]; then
				mv "$ZSH_THEME_FILE" "$ZSH/themes/"
				echo "Moved $(basename "$ZSH_THEME_FILE") to $ZSH/themes/"
			else
				echo "No .zsh-theme file found in the repository."
				exit 1
			fi

			rm -rf "$TARGET_DIR"
			echo "Removed cloned directory '$TARGET_DIR'"
			;;
	esac
done
