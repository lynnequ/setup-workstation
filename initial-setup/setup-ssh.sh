#!/bin/bash

echo "Checking if ssh key exists"
ls -al ~/.ssh

read -p "Enter your choice: (1: Generate a new SSH key, 2: Use an existing SSH key,  3: Clean up) => " choice

case $choice in
  1)
    echo ">>> Generate a new SSH key"
    read -p "Enter your email: " your_email
    ssh-keygen -t ed25519 -C $your_email
    echo "Public key generated"
    
    echo ">>> Adding your SSH key to the ssh-agent..."
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo "SSH key added to the ssh-agent."

    echo ">>> Adding you ssh private key to the keychain..."
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
        
    echo "[Action] Please add the generated public key to your GitHub account settings. (It's copied to your clipboard)"
    echo "Go to https://github.com/settings/ssh/new"
    pbcopy < ~/.ssh/id_ed25519.pub
    ;;
  2)
    # Use an existing SSH key
    echo "Please enter the path to your existing SSH key (e.g., ~/.ssh/id_rsa, or ~/.ssh/id_ed25519.pub):"
    read -p "Enter key path: " key_path
    if [ -f "$key_path" ]; then
      echo "[Action] Key found. It's copied, now please add the public key to your GitHub account settings."
      echo "Go to https://github.com/settings/ssh/new"
      pbcopy < ~/.ssh/id_ed25519.pub
    else
      echo "Error: Key not found."
    fi
    ;;
  3)
    echo "Clean up..."
    rm -rf ~/.ssh
    echo "Done."
    ;;
  *)
    echo "Invalid choice. Please try again."
    exit 1
    ;;
esac