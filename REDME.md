# Encryption reference
https://github.com/Dash-Industry-Forum/dash.js/wiki/Generate-MPEG-DASH-content-encrypted-with-MPEG-CENC-ClearKey

#Libraries Used
https://www.bento4.com/
https://dashif.org/
https://www.ffmpeg.org/

Note: In order for this code to work, you need to have directory name source_media - which the code will use for reading and writing the video files


# Start the video encryption(With Docker)
docker-compose run bento4_encrypt /bin/sh encrypt_video.sh <source_filename.mp4> <output directory_name>
Example:
docker-compose run bento4_encrypt /bin/sh encrypt_video.sh st.mp4 output

# Start the audio encryption(With Docker)
docker-compose run bento4_encrypt /bin/sh encrypt_audio.sh <source_filename.mp3> <output directory_name>
Example:
docker-compose run bento4_encrypt /bin/sh encrypt_audio.sh conv2.mp3 encrypted_audio_files




