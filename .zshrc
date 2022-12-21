###---------------------------------------------------------------###
#------------------------------ zshrc ------------------------------#
###---------------------------------------------------------------###


# zmodload zsh/zprof
# History
HISTFILE=~/.cache/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%Y-%m-%d %T "
alias hist='fc -lt "$HISTTIMEFORMAT" 1'
alias history='fc -lt "$HISTTIMEFORMAT" 1'
bindkey '^R' history-incremental-search-backward
# Enable colors and change prompt:
autoload -U colors && colors
# PS1="%B%{$fg[grey]%}[%{$fg[44]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[grey]%}]%{$reset_color%}$%b "
# precmd() { print "" }
# PS1="%B%F{#c55c81}%n%F{#747474}%\@%m %F{#bd83b8}%~ %b"
PS1=''$'\n''%B%F{#FFFFFF}%~ %F{#FF544D}'$'\U276F''%F{#FFB428}'$'\U276F''%F{#24C039}'$'\U276F'' %b'
# PS1='%m %1~ '$'\U276F'' %# '
# printf '\n%.0s' {1..100}
zle_highlight=(default:bold,fg=white)

# Basic settings
setopt extendedglob nomatch notify
unsetopt autocd beep

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# autosuggest
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#bf9986,bg=#f5e7de,bold,nounderline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#bf9986,bg=none,bold,nounderline"
ZSH_AUTOSUGGEST_STRATEGY="completion"
source ~/git/zsh-autosuggestions/zsh-autosuggestions.zsh

###---------------------------------------------------------------###
#----------------------------- vi-mode -----------------------------#
###---------------------------------------------------------------###
# https://www.lshell.com/post/2021/12/zsh-bindkey-table/
# source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
# in normal mode press ':' preceded by 'Tab' to list all commands that can be mapped
bindkey -v
export KEYTIMEOUT=1

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | xclip -sel clipboard
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Use vim keys in tab complete menu:
bindkey -M menuselect 'j' vi-backward-char
bindkey -M menuselect 'l' vi-up-line-or-history
bindkey -M menuselect 'ö' vi-forward-char
bindkey -M menuselect 'k' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -a 'j' vi-backward-char
bindkey -a 'l' vi-up-line-or-history
bindkey -a 'ö' vi-forward-char
bindkey -a 'k' vi-down-line-or-history
bindkey -a 'G' end-of-buffer-or-history
bindkey '^ ' autosuggest-accept

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line

###---------------------------------------------------------------###
#--------------------- environmental variables ---------------------#
###---------------------------------------------------------------###

source /etc/environment
export TERM="st-256color"
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# export MANPAGER="sh -c 'col -bx > ~/.cache/.mantemp'"
export MANWIDTH=999
export EDITOR="code"
eval "$(pyenv init -)" #let pyenv choose python path
# export FZF_DEFAULT_OPTS='--bind=ctrl-l:up,ctrl-k:down'
export RANGER_LOAD_DEFAULT_RC='FALSE'
# factorio dotnet random bullshit error message wtf
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1


###---------------------------------------------------------------###
#------------------------------ alias ------------------------------#
###---------------------------------------------------------------###

#[global]#
# default options
alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rm='rm -vi'
alias mv='mv -vi'
alias mkdir='mkdir -vp'
alias cabal='cabal -v'
alias xbindkeys="xbindkeys -f "$XDG_CONFIG_HOME"/xbindkeys/config"
alias yay="yay --nocleanmenu --nodiffmenu --noupgrademenu"
alias du="du -h"
alias df="df -h"
alias gcc="gcc -std=c99 -Wall -pedantic -g"
alias valgrind="valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all"

# renames
alias lf='lfub'
alias pt='ptimer.sh'
alias rename='perl-rename'
alias vim='nvim'
alias s='sudo'
alias f='ranger'
alias time='/bin/time'
alias cat='bat'

# custom
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
 
 
###---------------------------------------------------------------###
#---------------------------- functions ----------------------------#
###---------------------------------------------------------------###

# functions
bold=$(tput bold)
normal=$(tput sgr0)

# alias ytdlp='yt-dlp -f bestaudio --extract-audio --audio-format best --audio-quality 0 --prefer-ffmpeg --no-playlist --no-write-playlist-metafiles --write-thumbnail --embed-thumbnail --embed-metadata --embed-info-json --xattrs --progress --sponsorblock-mark all --force-overwrites -o "/media/ext1/music/youtubedl/%(channel)s - %(title)s.%(ext)s"'
# alias ytdl='yt-dlp -f bestaudio --extract-audio --audio-format best --audio-quality 0 --prefer-ffmpeg --yes-playlist --no-write-playlist-metafiles --write-thumbnail --embed-thumbnail --embed-metadata --embed-info-json --xattrs --progress --sponsorblock-mark all --force-overwrites -o "/media/ext1/music/youtubedl/%(channel)s - %(title)s.%(ext)s"'
# alias ytdlh='yt-dlp -f bestaudio --extract-audio --audio-format best --audio-quality 0 --prefer-ffmpeg --yes-playlist --no-write-playlist-metafiles --write-thumbnail --embed-thumbnail --embed-metadata --embed-info-json --xattrs --progress --sponsorblock-mark all --force-overwrites -o "/home/sabo/download/%(channel)s - %(title)s.%(ext)s"'

# functions
killn(){
    [ "$1" = "discord" ] && { echo '$1 = discord' && ps aux | grep 'webcord\|electron\|discord' | awk '{print $2}'|sed '$d' |xargs -I {} kill {}; return 0; }
	ps aux | grep $1 | awk '{print $2}'|sed '$d' |xargs -I {} kill {}
}

killnf(){
	ps aux | grep $1 | awk '{print $2}'|sed '$d' |xargs -I {} kill -9 {}
}

c(){
	echo "$@" | xclip -sel primary
}

co(){
	"$@" | xclip -sel primary
}

mem()
{                                                                                                      
    ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{printf "'${bold}'"$1/1024 "'${bold}'MB'${normal}'"; $1=""; print }' 
}

# universal extract 
function extract {
	 if [ -z "$1" ]; then
	    # display usage if no parameters given
	    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
	    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
	    return 1
	 else
	    for n in "$@"
	    do
	      if [ -f "$n" ] ; then
		  case "${n%,}" in
		    *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
				 tar xvf "$n"       ;;
		    *.lzma)      unlzma ./"$n"      ;;
		    *.bz2)       bunzip2 ./"$n"     ;;
		    *.rar)       unrar x -ad ./"$n" ;;
		    *.gz)        gunzip ./"$n"      ;;
		    *.zip)       unzip ./"$n"       ;;
		    *.z)         uncompress ./"$n"  ;;
		    *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
				 7z x ./"$n"        ;;
		    *.xz)        unxz ./"$n"        ;;
		    *.exe)       cabextract ./"$n"  ;;
		    *)
				 echo "extract: '$n' - unknown archive method"
				 return 1
				 ;;
		  esac
	      else
		  echo "'$n , $1 , $2 , $3 , , , $@ , $#' - file does not exist"
		  return 1
	      fi
	    done
	fi
}

###---------------------------------------------------------------###
#--------------------- zsh-syntax-highlighting ---------------------#
###---------------------------------------------------------------###

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Remove ls hl
LS_COLORS=$LS_COLORS:'ow=1;34:' ; export LS_COLORS

# Enable highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=none
ZSH_HIGHLIGHT_STYLES[reserved-word]=none
ZSH_HIGHLIGHT_STYLES[alias]=none
ZSH_HIGHLIGHT_STYLES[builtin]=none
ZSH_HIGHLIGHT_STYLES[function]=none
ZSH_HIGHLIGHT_STYLES[command]=none
ZSH_HIGHLIGHT_STYLES[precommand]=none
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=none
ZSH_HIGHLIGHT_STYLES[path]=fg=none
ZSH_HIGHLIGHT_STYLES[globbing]=none
ZSH_HIGHLIGHT_STYLES[history-expansion]=none
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[assign]=none

# zprof



