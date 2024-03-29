# youtube-src-test

## はじめに
Youtubeに音声を上げるときに，(a)44100Hzで上げたほうがいいのか，(b)48000Hzで上げたほうがいいのかを検証する。

## 予想
サンプリングレート変換により一方の音質がもう一方の音質より悪い。  

## 検証
WaveGene (http://efu.jp.net/soft/wg/wg.html) で1kHz, -6dBのサイン波をそれぞれ44100Hz, 24bit (a: 1khz_44100_24.wav), 48000Hz, 24bit (b: 1khz_48000_24.wav) で生成する。

これをmuxしてmkvを作り，Youtubeにアップロードすると，
- https://www.youtube.com/watch?v=Cs8PW4_CQIs (a: 44100Hz),
- https://www.youtube.com/watch?v=5l4fi0HhvjE (b: 48000Hz)

が生成された。

そのフォーマットは以下である：
```
$ youtube-dl -F 'https://www.youtube.com/watch?v=Cs8PW4_CQIs'
[youtube] Cs8PW4_CQIs: Downloading webpage
[youtube] Cs8PW4_CQIs: Downloading video info webpage
WARNING: Unable to extract video title
[youtube] Cs8PW4_CQIs: Downloading MPD manifest
[info] Available formats for Cs8PW4_CQIs:
format code  extension  resolution note
139          m4a        audio only DASH audio   49k , m4a_dash container, mp4a.40.5@ 48k (22050Hz)
140          m4a        audio only DASH audio  130k , m4a_dash container, mp4a.40.2@128k (44100Hz)
251          webm       audio only DASH audio  187k , webm_dash container, opus @160k (48000Hz)
134          mp4        640x360    DASH video    2k , mp4_dash container, avc1.4d4016, 6fps, video only
136          mp4        1280x720   DASH video    3k , mp4_dash container, avc1.4d401f, 6fps, video only
278          webm       256x144    DASH video   95k , webm_dash container, vp9, 6fps, video only
160          mp4        256x144    DASH video  108k , mp4_dash container, avc1.4d400b, 6fps, video only
242          webm       426x240    DASH video  220k , webm_dash container, vp9, 6fps, video only
133          mp4        426x240    DASH video  242k , mp4_dash container, avc1.4d400c, 6fps, video only
243          webm       640x360    DASH video  405k , webm_dash container, vp9, 6fps, video only
244          webm       854x480    DASH video  752k , webm_dash container, vp9, 6fps, video only
135          mp4        854x480    DASH video 1155k , mp4_dash container, avc1.4d4014, 6fps, video only
247          webm       1280x720   DASH video 1505k , webm_dash container, vp9, 6fps, video only
43           webm       640x360    medium , vp8.0, vorbis@128k, 37.01KiB
18           mp4        640x360    medium  100k , avc1.42001E, mp4a.40.2@ 96k (44100Hz), 134.03KiB
22           mp4        1280x720   hd720  133k , avc1.64001F, mp4a.40.2@192k (44100Hz) (best)
```

このうち，format code: 22 (1: mp4a.40.2@192k 44100Hz) と，format code: 251 (2: opus @160k 48000Hz)
をダウンロードし，WaveSpectra (http://efu.jp.net/soft/ws/ws.html) でFFT (131072点 Hanning) すると THD, +N (S/N) は以下のようになった：

| format \ sampling         | a. 44100Hz         | b. 48000Hz         |
|---------------------------|--------------------|--------------------|
| 0. wav                    | 0.00000%, 0.00001% (138.84dB) | 0.00000%, 0.00001% (138.30dB) |
| 1. mp4a.40.2@192k 44100Hz | 0.00015%, 0.00467% (86.61dB) | 0.00026%, 0.00347% (89.20dB) |
| 2. opus @160k 48000Hz     | 0.00058%, 0.00774% (82.23dB) | 0.00033%, 0.00773% (82.24dB) |

## 結果
mkvをアップロードすると(1)44100Hzのmp4aと(2)48000Hzのopusが生成された。  
このうち(1)44100Hzのmp4aについては，(b)48000Hzのmkvより(a)44100HzのmkvのほうがTHDがやや低い。  
(2)48000Hzのopusについては，(a)44100Hzのmkvより(b)48000HzのmkvのほうがTHDがやや低い。  
全体として，予想に反して，どちらでも良いと思う。
