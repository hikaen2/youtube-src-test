# 1khz_44100_24
ffmpeg -i 1khz_44100_24.webm -c:a pcm_s24le 1khz_44100_24.webm.decode.wav
ffmpeg -i 1khz_44100_24.mp4  -c:a pcm_s24le 1khz_44100_24.mp4.decode.wav

# 1khz_48000_24
ffmpeg -i 1khz_48000_24.webm -c:a pcm_s24le 1khz_48000_24.webm.decode.wav
ffmpeg -i 1khz_48000_24.mp4  -c:a pcm_s24le 1khz_48000_24.mp4.decode.wav
