#!/bin/bash
set -e

# Detect OS
OS="$(uname -s)"
echo "Detected OS: $OS"

# On macOS, ensure Homebrew is installed first
if [ "$OS" = "Darwin" ]; then
  if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH for the rest of this script
    if [ -f /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi
fi

# Check if Ansible is installed
if ! command -v ansible &>/dev/null; then
  echo "Ansible is not installed. Installing..."
  if command -v apt-get &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y ansible
  elif command -v yum &>/dev/null; then
    sudo yum install -y ansible
  elif command -v pacman &>/dev/null; then
    sudo pacman -Sy --noconfirm ansible
  elif command -v brew &>/dev/null; then
    brew install ansible
  else
    echo "Could not determine package manager. Please install Ansible manually."
    exit 1
  fi
fi

# Run the Ansible playbook
echo "Installing dotfiles..."
ansible-playbook -i localhost, -c local --ask-become-pass install_dotfiles.yml

echo "Dotfiles installation complete!"
echo "Please restart your shell or run 'source ~/.zshrc' to apply changes."
