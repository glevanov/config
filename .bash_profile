# bash
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
export BASH_SILENCE_DEPRECATION_WARNING=1

# homebrew
export PATH="/opt/homebrew/bin/:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# node
export PATH="/opt/homebrew/opt/node@24/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/node@24/lib"
export CPPFLAGS="-I/opt/homebrew/opt/node@24/include"
export NODE_OPTIONS=--max_old_space_size=63000

# AI
export LM_STUDIO_API_KEY=dummy-api-key
export LM_STUDIO_API_BASE=http://localhost:1234/v1
# Added by LM Studio CLI (lms)
export PATH=$PATH:/Users/grigoriy/.lmstudio/bin
# End of LM Studio CLI section

# compresses screen captures
function h264() {
    if [[ -z "$1" ]]; then
        echo "Usage: h264gif <input-file>"
        return 1
    fi
    ffmpeg -i "$1" -map_metadata -1 -c:a aac -c:v libx264 -crf 24 -preset veryslow -profile:v main -pix_fmt yuv420p -movflags +faststart -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "${1%.*}".h264.mp4
}

function yt() {
    yt-dlp -f 22 "$1"
}
