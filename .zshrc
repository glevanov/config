# brew autocompletion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# compresses mac screen captures
function mp4gif() { ffmpeg -i "$1" -vcodec h264 -acodec mp2 "${1%.*}".mp4 }
