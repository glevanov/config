export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
# brew autocompletion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# compresses mac screen captures
function h264gif() { ffmpeg -i "$1" -map_metadata -1 -c:a libfdk_aac -c:v libx264 -crf 24 -preset veryslow -profile:v main -pix_fmt yuv420p -movflags +faststart -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "${1%.*}".h264.mp4 }
function av1gif() { ffmpeg -i "$1" -map_metadata -1 -c:a libopus -c:v libaom-av1 -crf 34 -b:v 0 -pix_fmt yuv420p -movflags +faststart -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -strict experimental "${1%.*}".av1.mp4 }

export PATH="/usr/local/opt/node@16/bin:$PATH"
