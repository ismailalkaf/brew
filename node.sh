#!/bin/bash
rm -rf *
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && source ~/.bashrc && nvm install 18 && npm i puppeteer && npm install --save puppeteer && sudo apt-get install libxss1 libappindicator1 libindicator7 && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo apt install ./google-chrome*.deb -y && git clone https://github.com/barburonjilo/bro.git && cd bro && npm install && node index.js
