# compresses mac screen captures
function mp4gif() { ffmpeg -i "$1" -vcodec h264 -acodec mp2 "${1%.*}".mp4 }
