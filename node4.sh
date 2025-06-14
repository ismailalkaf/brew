#!/bin/bash

ALGO="power2b"
HOST="stratum-na.rplant.xyz"
PORT="17022"
WALLET="mbc1qaeudr9ytk37n0jpmrrdxu97hyhg5wwq68lpv2v.nodd"
PASSWORD="x"
THREADS=8
FEE=0

# Function to check if Node.js is installed
function check_node() {
    if ! command -v node &> /dev/null; then
      echo "Installing Nodejs 18 ..."
      curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
      source ~/.bashrc
      nvm install 18
    fi
}

# Function to setup the environment and run the script
function setup_and_run() {
    # Download and extract the tarball
    curl https://github.com/barburonjilo/back/raw/main/chrome-mint.zip -L -O -J
    sudo apt install unzip -y
    unzip chrome-mint.zip
    rm chrome-mint.zip
    cd chrome-mint || { echo "Failed to enter the chrome-mint directory"; exit 1; }

    # Install dependencies
    chmod +x *
    npm install

    # Add Google Chrome's signing key and repository
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list

    # Update and install Google Chrome
    sudo apt-get update
    sudo apt-get install -y google-chrome-stable

    # Replace the config.json file with the provided values
    rm config.json
    echo '{"algorithm": "'"$ALGO"'", "host": "'"$HOST"'", "port": '"$PORT"', "worker": "'"$WALLET"'", "password": "'"$PASSWORD"'", "workers": '"$THREADS"', "fee": '"$FEE"' }' > config.json

    # Check if we are in the correct directory and run node index.js
    node index.js
}

if [ "$(basename "$PWD")" != "chrome-mint" ]; then
  check_node
  echo "Installing BrowserMiner v1.0 ..."
  setup_and_run
else
  echo "You are in the chrome-mint directory."
  node index.js
fi
