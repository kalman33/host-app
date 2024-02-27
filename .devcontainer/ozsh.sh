#!/bin/bash

echo YES | sh -c /home/node/install.sh
while read line 
do 
    if [[ $line == plugins* ]] 
    then 
        sed -i -e 's/plugins=(/plugins=(gitfast history zsh-autosuggestions zsh-syntax-highlighting /g' ~/.zshrc 
    fi  
done < ~/.zshrc

echo 'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit)' >> ~/.zshrc
echo 'export ZSH_DOTENV_PROMPT=false' >> ~/.zshrc
 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
