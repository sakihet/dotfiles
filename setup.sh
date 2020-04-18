#!/bin/sh

# dotfiles
for dotfile in .?*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
  then
    ln -Fis "$PWD/$dotfile" $HOME
  fi
done

# vscode
VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
VSCODE_SETTINGS_SRC=`readlink -f vscode/settings.json`

if [[ -e $VSCODE_SETTINGS ]]; then
  echo "${VSCODE_SETTINGS} exists"
else
  ln -is "$VSCODE_SETTINGS_SRC" "$VSCODE_SETTINGS"
fi
