from alfg/bento4 as encryption_base

RUN apk add python3
RUN apk add ffmpeg

from encryption_base

COPY ["encrypt_video.sh", "encrypt_video.sh"]
RUN chmod +x encrypt_video.sh

COPY ["encrypt_audio.sh", "encrypt_audio.sh"]
RUN chmod +x encrypt_audio.sh
