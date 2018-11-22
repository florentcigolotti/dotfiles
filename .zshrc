export TERM="xterm-256color"
export ZSH=/home/florent/.oh-my-zsh

# Themes https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Command auto-correction.
ENABLE_CORRECTION="false"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(
    git
    git-flow
    svn
    svn-fast-info
    docker
    docker-compose
    docker-machine
    boot2docker
    colored-man-pages
    vagrant
    colorize
    history
    man
    pip
    python
    rsync
    sudo
    go
    golang
    taskwarrior
    zsh-autosuggestions
    fast-syntax-highlighting
    zsh-completions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Plugins configuration
#######################

# Using CTRL+r highlight using green foreground
zle_highlight=(isearch:fg=green)

# Define autosuggestions highlight color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# User configuration
####################

# Exports
export VISUAL=vim
export EDITOR="$VISUAL"

# Alias
if [ -f $HOME/.zshalias ]; then
    source $HOME/.zshalias
fi

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Fix blank Gnome Control Center with Gnome-i3
export XDG_CURRENT_DESKTOP=GNOME

# Funny cowsay + fortune on new terminal
#m=($(cowsay -l | tail -n +2))
### Choose a random module
#banner=${m[$(shuf -i 0-$#m[@] -n 1)]}
### Run cowsay with a random fortune sentence
#cowsay -f $banner $(fortune -s)
