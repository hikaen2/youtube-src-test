ffmpeg -loop 1 -r 6 -i black.png -i 1khz_44100_24.wav -c:v libx264 -tune stillimage -c:a copy -shortest -pix_fmt yuv420p 1khz_44100_24.mkv
ffmpeg -loop 1 -r 6 -i black.png -i 1khz_48000_24.wav -c:v libx264 -tune stillimage -c:a copy -shortest -pix_fmt yuv420p 1khz_48000_24.mkv
