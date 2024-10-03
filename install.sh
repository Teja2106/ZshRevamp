#! /bin/zsh

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
			install_deps "git" "git"
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
			THEME_NAME=$(basename -s .git "$OPTARG")

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
				git clone "$OPTARG" "$TARGET_DIR"
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
			;;
	esac
done