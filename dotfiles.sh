#!/usr/bin/env bash

function install() {
    rsync --exclude .git \
      --exclude README.md \
      --exclude dotfiles.sh \
      -arvh . $HOME
}

function diffWithLocal() {
    for f in $(find . -type f ! -path "./.git/*" ! -path "./README.md" ! -path "./dotfiles.sh" ); do
        cmp --silent $f $HOME/$f
        if [ $? -ne 0 ]; then
            echo -e "=> ${f:2}"
            colordiff $f $HOME/$f
        fi
    done
}

if [ "$1" == "install" ]; then
    if [ "$2" == "--force" -o "$2" == "-f" ]; then
        install;
    else
        read -p "This will overwrite files, are you sure? (y/n) " -n 1;
        echo "";
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install;
        fi
    fi
elif [ "$1" == "diff" ]; then
    diffWithLocal;
fi
